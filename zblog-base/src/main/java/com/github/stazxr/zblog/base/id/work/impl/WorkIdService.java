package com.github.stazxr.zblog.base.id.work.impl;

import com.alibaba.fastjson.JSON;
import com.github.stazxr.zblog.base.entity.Dict;
import com.github.stazxr.zblog.base.enums.DictType;
import com.github.stazxr.zblog.base.id.work.model.WorkIdCache;
import com.github.stazxr.zblog.base.id.work.model.WorkResult;
import com.github.stazxr.zblog.base.service.DictService;
import com.github.stazxr.zblog.core.base.Const;
import com.github.stazxr.zblog.util.net.LocalHostUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;

/**
 * workId generate
 *
 * @author SunTao
 * @since 2021-12-13
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WorkIdService {
    /**
     * key-value 存储主键
     */
    private static final String DICT_KEY = "GUID_WORK_ID";

    /**
     * 默认最近使用的workId是0
     */
    private static final Long DEFAULT_LAST_WORK_ID = 0L;

    private final DictService dictService;

    public WorkIdService(DictService dictService) {
        this.dictService = dictService;
    }

    /**
     * 获取机器ID
     *
     * @return workId
     * @throws UnknownHostException failed get hostIp
     */
    public WorkResult generateWorkId() throws UnknownHostException {
        String ipAddr = LocalHostUtils.getLocalIp();
        WorkResult result = new WorkResult();
        result.setWorkIp(ipAddr);

        Dict dict = dictService.getById(Const.DictId.WORK_ID);
        if (dict == null) {
            // 不存在机器ID描述信息
            insertDictInfo(ipAddr);
            result.setWorkId(DEFAULT_LAST_WORK_ID);
            return result;
        }

        WorkIdCache workIdCache = JSON.parseObject(dict.getValue(), WorkIdCache.class);
        Map<String, Long> workIdsMap = workIdCache.getWorkIdsCache();

        if (workIdsMap != null && workIdsMap.containsKey(ipAddr)) {
            // 已经保存了当前ip，直接返回对应的workId
            result.setWorkId(workIdsMap.get(ipAddr));
            return result;
        }

        if (workIdsMap == null) {
            workIdsMap = new HashMap<>();
        }

        // 刷新机器保存信息
        long newLastId = workIdCache.getLastWorkId() + 1;
        workIdCache.setLastWorkId(newLastId);
        workIdsMap.put(ipAddr, newLastId);
        workIdCache.setWorkIdsCache(workIdsMap);
        dict.setValue(JSON.toJSONString(workIdCache));
        dictService.updateById(dict);
        result.setWorkId(newLastId);
        return result;
    }

    private void insertDictInfo(String ipAddr) {
        WorkIdCache workIdCache = new WorkIdCache();
        Map<String, Long> workIdsMap = new HashMap<>(1);
        workIdsMap.put(ipAddr, DEFAULT_LAST_WORK_ID);
        workIdCache.setWorkIdsCache(workIdsMap);
        workIdCache.setLastWorkId(DEFAULT_LAST_WORK_ID);

        Dict newDict = new Dict();
        newDict.setId(Const.DictId.WORK_ID);
        newDict.setName("机器ID信息");
        newDict.setKey(DICT_KEY);
        newDict.setPid(Const.DictId.SYS);
        newDict.setType(DictType.ITEM.value());
        newDict.setLocked(true);
        newDict.setUnique(true);
        newDict.setEnabled(true);
        newDict.setValue(JSON.toJSONString(workIdCache));
        newDict.setDesc("系统参数：存储机器ID信息");
        dictService.save(newDict);
    }
}
