package com.github.stazxr.zblog.base.controller;

import com.github.stazxr.zblog.base.util.GenerateIdUtils;
import com.github.stazxr.zblog.core.annotation.Router;
import com.github.stazxr.zblog.core.base.BaseConst;
import com.github.stazxr.zblog.core.enums.ResultCode;
import com.github.stazxr.zblog.core.exception.ServiceException;
import com.github.stazxr.zblog.core.model.Result;
import com.github.stazxr.zblog.log.annotation.IgnoredLog;
import org.springframework.web.bind.annotation.*;

/**
 * ID生成管理器
 *
 * @author SunTao
 * @since 2021-12-19
 */
@RestController
@RequestMapping("/api/id")
public class IdController {
    /**
     * 生成唯一ID
     *
     * @return 唯一ID
     */
    @IgnoredLog
    @GetMapping("/getId")
    @Router(name = "生成唯一序列", code = "getId", level = BaseConst.PermLevel.PUBLIC)
    public Result getId() {
        try {
            return Result.success().data(GenerateIdUtils.getId());
        } catch (Exception e) {
            throw new ServiceException(ResultCode.ID_EXCEPTION, e);
        }
    }

    /**
     * 生成ID列表
     *
     * @return 唯一ID列表
     */
    @IgnoredLog
    @GetMapping("/getIds")
    @Router(name = "生成序列列表", code = "getIds", level = BaseConst.PermLevel.PUBLIC)
    public Result getIds(@RequestParam("count") Integer count) {
        Integer tmpCount = count;
        if (tmpCount == null || tmpCount == 0) {
            tmpCount = 1;
        }
        try {
            return Result.success().data(GenerateIdUtils.getIdList(tmpCount));
        } catch (Exception e) {
            throw new ServiceException(ResultCode.ID_EXCEPTION, e);
        }
    }
}
