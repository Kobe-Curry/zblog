package com.github.stazxr.zblog.base.controller;

import com.github.stazxr.zblog.base.domain.dto.*;
import com.github.stazxr.zblog.base.domain.dto.query.UserQueryDto;
import com.github.stazxr.zblog.base.service.UserService;
import com.github.stazxr.zblog.core.annotation.RequestPostSingleParam;
import com.github.stazxr.zblog.core.annotation.Router;
import com.github.stazxr.zblog.core.base.BaseConst;
import com.github.stazxr.zblog.core.model.Result;
import com.github.stazxr.zblog.log.annotation.Log;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 用户管理
 *
 * @author SunTao
 * @since 2020-12-10
 */
@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/users")
public class UserController {
    private final UserService userService;

    /**
     * 修改个人头像
     *
     * @param updateDto 用户信息
     * @return Result
     */
    @Log
    @PostMapping("updateUserHeadImg")
    @Router(name = "修改个人头像", code = "updateUserHeadImg", level = BaseConst.PermLevel.PUBLIC)
    public Result updateUserHeadImg(@RequestBody UserDto updateDto) {
        return userService.updateUserHeadImg(updateDto) ? Result.success() : Result.failure();
    }

    /**
     * 修改个人基础信息
     *
     * @param updateDto 用户信息
     * @return Result
     */
    @Log
    @PostMapping("updateUserBaseInfo")
    @Router(name = "修改个人基础信息", code = "updateUserBaseInfo", level = BaseConst.PermLevel.PUBLIC)
    public Result updateUserBaseInfo(@RequestBody UserDto updateDto) {
        return userService.updateUserBaseInfo(updateDto) ? Result.success() : Result.failure();
    }

    /**
     * 修改个人密码
     *
     * @param passDto 用户密码信息
     * @return Result
     */
    @Log
    @PostMapping("updateUserPass")
    @Router(name = "修改个人密码", code = "updateUserPass", level = BaseConst.PermLevel.PUBLIC)
    public Result updateUserPass(@RequestBody UserUpdatePassDto passDto) {
        return userService.updateUserPass(passDto) ? Result.success() : Result.failure();
    }

    /**
     * 强制修改密码
     *
     * @param passDto 用户密码信息
     * @return Result
     */
    @PostMapping("forceUpdatePass")
    @Router(name = "强制修改密码", code = "forceUpdateUserPass", level = BaseConst.PermLevel.OPEN)
    public Result forceUpdatePass(@RequestBody UserUpdatePassDto passDto) {
        userService.forceUpdatePass(passDto);
        return Result.success();
    }

    /**
     * 修改个人邮箱
     *
     * @param emailDto 用户邮箱信息
     * @return Result
     */
    @Log
    @PostMapping("updateUserEmail")
    @Router(name = "修改个人邮箱", code = "updateUserEmail", level = BaseConst.PermLevel.PUBLIC)
    public Result updateUserEmail(@RequestBody UserUpdateEmailDto emailDto) {
        return userService.updateUserEmail(emailDto) ? Result.success() : Result.failure();
    }

    /**
     * 查询用户列表（公共接口）
     *
     * @param queryDto 查询参数
     * @return userList
     */
    @GetMapping(value = "/pageListOfCommon")
    @Router(name = "查询用户列表（公共接口）", code = "pageUserListOfCommon", level = BaseConst.PermLevel.PUBLIC)
    public Result pageUserListOfCommon(UserQueryDto queryDto) {
        return Result.success().data(userService.queryUserListByPage(queryDto));
    }

    /**
     * 查询用户列表
     *
     * @param queryDto 查询参数
     * @return userList
     */
    @GetMapping(value = "/pageList")
    @Router(name = "查询用户列表", code = "queryUserListByPage")
    public Result pageList(UserQueryDto queryDto) {
        return Result.success().data(userService.queryUserListByPage(queryDto));
    }

    /**
     * 查询用户详情
     *
     * @param userId 用户序列
     * @return UserVo
     */
    @GetMapping(value = "/queryUserDetail")
    @Router(name = "查询用户详情", code = "queryUserDetail", level = BaseConst.PermLevel.PUBLIC)
    public Result queryUserDetail(@RequestParam Long userId) {
        return Result.success().data(userService.queryUserDetail(userId));
    }

    /**
     * 新增用户
     *
     * @param user 用户信息
     * @return Result
     */
    @Log
    @PostMapping(value = "/addUser")
    @Router(name = "新增用户", code = "addUser")
    public Result addUser(@RequestBody UserDto user) {
        userService.addUser(user);
        return Result.success();
    }

    /**
     * 编辑用户
     *
     * @param user 用户信息
     * @return Result
     */
    @Log
    @PostMapping(value = "/editUser")
    @Router(name = "编辑用户", code = "editUser")
    public Result editUser(@RequestBody UserDto user) {
        userService.editUser(user);
        return Result.success();
    }

    /**
     * 删除用户
     *
     * @param userId 用户序列
     * @return Result
     */
    @Log
    @PostMapping(value = "/deleteUser")
    @Router(name = "删除用户", code = "deleteUser")
    public Result deleteUser(@RequestPostSingleParam Long userId) {
        if (userId == null) {
            return Result.failure("参数错误，缺失ID");
        }

        userService.deleteUser(userId);
        return Result.success();
    }

    /**
     * 更新用户状态
     *
     * @param user 用户信息
     * @return Result
     */
    @Log
    @PostMapping(value = "/updateUserStatus")
    @Router(name = "更新用户状态", code = "updateUserStatus")
    public Result updateUserStatus(@RequestBody UserDto user) {
        userService.updateUserStatus(user);
        return Result.success();
    }

    /**
     * 用户注册
     *
     * @param registerDto 注册信息
     * @return Result
     */
    @PostMapping(value = "/register")
    @Router(name = "用户注册", code = "userRegister", level = BaseConst.PermLevel.OPEN)
    public Result userRegister(@RequestBody UserRegisterDto registerDto) {
        userService.userRegister(registerDto);
        return Result.success();
    }

    /**
     * 通过邮箱修改密码
     *
     * @param forgetPwdDto 密码信息
     * @return Result
     */
    @PostMapping(value = "/updateUserPwdByEmail")
    @Router(name = "通过邮箱修改密码", code = "updateUserPwdByEmail", level = BaseConst.PermLevel.OPEN)
    public Result updateUserPwdByEmail(@RequestBody ForgetPwdDto forgetPwdDto) {
        userService.updateUserPwdByEmail(forgetPwdDto);
        return Result.success();
    }
}
