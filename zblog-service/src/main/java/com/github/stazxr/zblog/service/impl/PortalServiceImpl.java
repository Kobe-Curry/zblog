package com.github.stazxr.zblog.service.impl;

import cn.hutool.json.JSONObject;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.github.pagehelper.PageHelper;
import com.github.stazxr.zblog.base.converter.UserConverter;
import com.github.stazxr.zblog.base.domain.entity.User;
import com.github.stazxr.zblog.base.domain.vo.UserVo;
import com.github.stazxr.zblog.base.mapper.UserMapper;
import com.github.stazxr.zblog.base.util.Constants;
import com.github.stazxr.zblog.base.util.GenerateIdUtils;
import com.github.stazxr.zblog.converter.CommentConverter;
import com.github.stazxr.zblog.converter.MessageConverter;
import com.github.stazxr.zblog.core.exception.ServiceException;
import com.github.stazxr.zblog.core.util.DataValidated;
import com.github.stazxr.zblog.core.util.IpImplUtils;
import com.github.stazxr.zblog.domain.CommentLikeDto;
import com.github.stazxr.zblog.domain.bo.PageInfo;
import com.github.stazxr.zblog.domain.dto.CommentDeleteDto;
import com.github.stazxr.zblog.domain.dto.CommentDto;
import com.github.stazxr.zblog.domain.dto.MessageDto;
import com.github.stazxr.zblog.domain.dto.UserLoginDto;
import com.github.stazxr.zblog.domain.dto.query.ArticleQueryDto;
import com.github.stazxr.zblog.domain.dto.query.CommentQueryDto;
import com.github.stazxr.zblog.domain.dto.setting.OtherInfo;
import com.github.stazxr.zblog.domain.dto.setting.SocialInfo;
import com.github.stazxr.zblog.domain.dto.setting.WebInfo;
import com.github.stazxr.zblog.domain.entity.*;
import com.github.stazxr.zblog.domain.enums.WebsiteConfigType;
import com.github.stazxr.zblog.domain.vo.*;
import com.github.stazxr.zblog.mapper.*;
import com.github.stazxr.zblog.service.PortalService;
import com.github.stazxr.zblog.util.Assert;
import com.github.stazxr.zblog.util.StringUtils;
import com.github.stazxr.zblog.util.http.HtmlContentUtils;
import com.github.stazxr.zblog.util.io.FileUtils;
import com.github.stazxr.zblog.util.net.IpUtils;
import com.github.stazxr.zblog.util.secret.RsaUtils;
import com.github.stazxr.zblog.util.time.DateUtils;
import eu.bitwalker.useragentutils.OperatingSystem;
import eu.bitwalker.useragentutils.UserAgent;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.ClassPathResource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.concurrent.CompletableFuture;

/**
 * 前台服务实现层
 *
 * @author SunTao
 * @since 2022-11-25
 */
@Service
@RequiredArgsConstructor
public class PortalServiceImpl implements PortalService {
    private static final String UNKNOWN_AREA = "外星人";

    private static final String LOCAL_AREA_NET = "局域网";

    private final PortalMapper portalMapper;

    private final VisitorMapper visitorMapper;

    private final VisitorAreaMapper visitorAreaMapper;

    private final WebSettingMapper webSettingMapper;

    private final PageMapper pageMapper;

    private final TalkMapper talkMapper;

    private final ArticleMapper articleMapper;

    private final MessageConverter messageConverter;

    private final MessageMapper messageMapper;

    private final FriendLinkMapper friendLinkMapper;

    private final CommentMapper commentMapper;

    private final CommentLikeMapper commentLikeMapper;

    private final CommentConverter commentConverter;

    private final UserMapper userMapper;

    private final UserConverter userConverter;

    private final PasswordEncoder passwordEncoder;

    /**
     * 查询博客前台信息
     *
     * @return BlogWebVo
     */
    @Override
    public BlogWebVo queryBlogWebInfo() {
        BlogWebVo webVo = portalMapper.selectBlogWebInfo();

        // WebInfo
        WebsiteConfig websiteConfig = webSettingMapper.selectById(WebsiteConfigType.WEB_INFO.value());
        webVo.setWebInfo(websiteConfig == null ? new WebInfo() : JSON.parseObject(websiteConfig.getConfig(), WebInfo.class));

        // SocialInfo
        websiteConfig = webSettingMapper.selectById(WebsiteConfigType.SOCIAL_INFO.value());
        webVo.setSocialInfo(websiteConfig == null ? new SocialInfo() : JSON.parseObject(websiteConfig.getConfig(), SocialInfo.class));

        // OtherInfo
        websiteConfig = webSettingMapper.selectById(WebsiteConfigType.OTHER_INFO.value());
        webVo.setOtherInfo(websiteConfig == null ? new OtherInfo() : JSON.parseObject(websiteConfig.getConfig(), OtherInfo.class));

        // PageInfo
        List<PageInfo> pageList = pageMapper.selectWebPageList();
        webVo.setPageList(pageList);

        return webVo;
    }

    /**
     * 记录访客信息
     *
     * @param request 请求信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void recordVisitor(HttpServletRequest request) {
        // 获取访问信息
        UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
        OperatingSystem os = userAgent.getOperatingSystem();
        String ipAddress = IpUtils.getIp(request);

        // 生成访问唯一编码
        String uuid = ipAddress + os.getName();
        String md5Uuid = DigestUtils.md5DigestAsHex(uuid.getBytes());

        // 判断是否访问过
        String browserName = IpUtils.getBrowser(request);
        Visitor visitor = Visitor.builder().id(md5Uuid).addressIp(ipAddress).browserName(browserName).osName(os.getName()).build();
        boolean exists = visitorMapper.exists(new LambdaQueryWrapper<Visitor>().eq(Visitor::getId, md5Uuid));
        if (!exists) {
            // 第一次访问
            JSONObject cityInfo = IpImplUtils.getHttpCityDetailInfo(ipAddress);
            String province = cityInfo.get("addr", String.class);
            if (StringUtils.isBlank(province) || LOCAL_AREA_NET.equals(province.trim())) {
                updateVisitorAreaCount(UNKNOWN_AREA);
            } else {
                province = province.trim().substring(0, 2);
                visitor.setProvince(province);
                visitor.setAreaCode(cityInfo.get("cityCode", String.class));
                updateVisitorAreaCount(province);
            }

            // 保存访客信息
            visitorMapper.insert(visitor);
        }

        // 网站访问量自增
        visitorMapper.addWebVisitorCount();
    }

    /**
     * 查询首页轮播的说说列表
     *
     * @return TalkList
     */
    @Override
    public List<TalkVo> queryTalkList() {
        return talkMapper.selectWebTalkList();
    }

    /**
     * 分页查询前台文章列表
     *
     * @param queryDto 查询参数
     * @return ArticleList
     */
    @Override
    public com.github.pagehelper.PageInfo<ArticleVo> queryArticleList(ArticleQueryDto queryDto) {
        queryDto.checkPage();
        PageHelper.startPage(queryDto.getPage(), queryDto.getPageSize());
        return new com.github.pagehelper.PageInfo<>(articleMapper.selectWebArticleList(queryDto));
    }

    /**
     * 分页查询前台文章详情
     *
     * @param articleId 文章ID
     * @return ArticleVo
     */
    @Override
    public ArticleVo queryArticleDetail(Long articleId) {
        if (articleId == null) {
            // 返回空，前台处理
            return null;
        }

        return articleMapper.selectArticleDetail(articleId);
    }

    /**
     * 留言板留言
     *
     * @param request    请求信息
     * @param messageDto 留言信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveMessage(HttpServletRequest request, MessageDto messageDto) {
        // 留言审核开启状态
        WebsiteConfig websiteConfig = webSettingMapper.selectById(WebsiteConfigType.OTHER_INFO.value());
        OtherInfo otherInfo = websiteConfig == null ? new OtherInfo() : JSON.parseObject(websiteConfig.getConfig(), OtherInfo.class);
        Integer isReview = otherInfo.getIsMessageReview();

        // 设置请求信息
        Message message = messageConverter.dtoToEntity(messageDto);
        String ip = IpUtils.getIp(request);
        message.setIpAddress(ip);
        message.setMessageContent(HtmlContentUtils.filter(message.getMessageContent()));
        message.setIpSource(IpImplUtils.getCityInfo(ip));
        message.setId(GenerateIdUtils.getId());
        message.setIsReview(1 != isReview);
        messageMapper.insert(message);
    }

    /**
     * 查询前台弹幕列表
     *
     * @return MessageVo
     */
    @Override
    public List<MessageVo> queryMessageList() {
        return messageMapper.selectWebMessageList();
    }

    /**
     * 查询前台友链列表
     *
     * @return FriendLinkVo
     */
    @Override
    public List<FriendLinkVo> queryFriendLinkList() {
        return friendLinkMapper.selectWebFriendLinkList();
    }

    /**
     * 前台登录
     *
     * @param request  请求信息
     * @param loginDto 登录信息
     * @return User
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public UserVo webLogin(HttpServletRequest request, UserLoginDto loginDto) {
        String username = loginDto.getUsername();
        String password = loginDto.getPassword();
        Assert.isTrue(StringUtils.isBlank(username), "登录账号不能为空");
        Assert.isTrue(StringUtils.isBlank(password), "登陆密码不能为空");

        // 判断用户名或邮箱是否存在
        boolean isEmail = username.contains("@");
        User user = userMapper.selectLoginUserByUsernameOrEmail(username, isEmail);
        DataValidated.notNull(user, "用户不存在");
        DataValidated.isTrue(!user.isEnabled(), "用户未启用");
        DataValidated.isTrue(user.getLocked(), "用户被锁定");

        // 对密码进行解密
        try {
            ClassPathResource classPathResource = new ClassPathResource("pri.key");
            String priKeyBase64 = FileUtils.readFile(classPathResource.getFile());
            password = RsaUtils.decryptByPrivateKey(priKeyBase64, password);
        } catch (Exception e) {
            throw new ServiceException("密码解析失败，请联系管理员", e);
        }

        DataValidated.isTrue(!passwordEncoder.matches(password, user.getPassword()), "密码错误");
        UserVo userVo = userConverter.entityToVo(user);

        // 查询用户点赞列表
        userVo.setCommentLikeSet(portalMapper.selectCommentListSet(userVo.getId()));

        return userVo;
    }

    /**
     * 查询前台评论列表
     *
     * @param queryDto 查询参数
     * @return CommentVo
     */
    @Override
    public com.github.pagehelper.PageInfo<CommentVo> queryCommentList(CommentQueryDto queryDto) {
        PageHelper.startPage(queryDto.getCurrent(), queryDto.getDefaultPageSize());
        List<CommentVo> commentVos = commentMapper.selectWebCommentList(queryDto);
        return new com.github.pagehelper.PageInfo<>(commentVos);
    }

    /**
     * 获取评论回复列表
     *
     * @param queryDto 查询参数
     * @return CommentReplyVo
     */
    @Override
    public com.github.pagehelper.PageInfo<CommentReplyVo> queryCommentReplyList(CommentQueryDto queryDto) {
        queryDto.checkPage();
        PageHelper.startPage(queryDto.getPage(), queryDto.getPageSize());
        List<CommentReplyVo> commentVos = commentMapper.selectWebCommentReplyList(queryDto);
        return new com.github.pagehelper.PageInfo<>(commentVos);
    }

    /**
     * 新增评论
     *
     * @param request    请求信息
     * @param commentDto 评论信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveComment(HttpServletRequest request, CommentDto commentDto) {
        // 评论审核开启状态
        WebsiteConfig websiteConfig = webSettingMapper.selectById(WebsiteConfigType.OTHER_INFO.value());
        OtherInfo otherInfo = websiteConfig == null ? new OtherInfo() : JSON.parseObject(websiteConfig.getConfig(), OtherInfo.class);
        Integer isReview = otherInfo.getIsCommentReview();

        // 保存评论
        commentDto.setContent(HtmlContentUtils.filter(commentDto.getContent()));
        Comment comment = commentConverter.dtoToEntity(commentDto);
        comment.setId(GenerateIdUtils.getId());
        String ip = IpUtils.getIp(request);
        comment.setIpAddress(ip);
        comment.setIpSource(IpImplUtils.getCityInfo(ip));
        comment.setIsReview(1 != isReview);
        commentMapper.insert(comment);

        // 判断是否开启邮箱通知,通知用户
        if (Constants.TRUE.equals(otherInfo.getIsEmailNotice())) {
            CompletableFuture.runAsync(() -> notice(comment));
        }
    }

    /**
     * 点赞评论
     *
     * @param request    请求信息
     * @param commentDto 评论信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void likeComment(HttpServletRequest request, CommentLikeDto commentDto) {
        if (commentLikeMapper.isLiked(commentDto.getUserId(), commentDto.getCommentId())) {
            // 取消点赞
            commentLikeMapper.deleteLike(commentDto.getUserId(), commentDto.getCommentId());
        } else {
            // 点赞
            CommentLike commentLike = new CommentLike();
            commentLike.setId(GenerateIdUtils.getId());
            commentLike.setUserId(commentDto.getUserId());
            commentLike.setCommentId(commentDto.getCommentId());
            String ip = IpUtils.getIp(request);
            commentLike.setIpAddress(ip);
            commentLike.setIpSource(IpImplUtils.getCityInfo(ip));
            commentLikeMapper.insert(commentLike);
        }
    }

    /**
     * 删除评论
     *
     * @param commentDto 评论信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteComment(CommentDeleteDto commentDto) {
        Assert.notNull(commentDto.getUserId(), "请登录后在做删除操作");
        if (commentDto.getCommentId() != null) {
            Comment comment = commentMapper.selectById(commentDto.getCommentId());
            if (comment != null) {
                DataValidated.isTrue(!comment.getUserId().equals(commentDto.getUserId()), "无法删除其他用户的评论");
                commentMapper.deleteById(commentDto.getCommentId());
            }
        }
    }

    private void notice(Comment comment) {
        throw new ServiceException("暂不支持");
    }

    private synchronized void updateVisitorAreaCount(String area) {
        String currentTime = DateUtils.formatNow();
        if (visitorAreaMapper.judgeAreaExist(area)) {
            visitorAreaMapper.updateAreaCount(area, currentTime);
        } else {
            visitorAreaMapper.insertAreaCount(area, currentTime);
        }
    }
}
