package com.github.stazxr.zblog.base.domain.dto.query;

import com.github.stazxr.zblog.core.base.PageParam;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 用户查询
 *
 * @author SunTao
 * @since 2022-09-13
 */
@Getter
@Setter
@ToString
public class UserQueryDto extends PageParam {
    /**
     * 业务序列
     */
    private Long businessId;

    /**
     * 用户名
     */
    private String username;

    /**
     * 用户昵称
     */
    private String nickname;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 手机号
     */
    private String telephone;

    /**
     * 启用状态
     */
    private Boolean enabled;

    /**
     * 登录时间范围 - 开始时间
     */
    private String loginStartTime;

    /**
     * 登录时间范围 - 结束时间
     */
    private String loginEndTime;
}
