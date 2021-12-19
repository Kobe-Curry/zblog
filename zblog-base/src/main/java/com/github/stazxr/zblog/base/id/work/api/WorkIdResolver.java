package com.github.stazxr.zblog.base.id.work.api;

/**
 * 本机workId持有者
 *
 * @author SunTao
 * @since 2021-12-12
 */
public interface WorkIdResolver {
    long resolveWorkId();

    String resolveWorkIp();
}
