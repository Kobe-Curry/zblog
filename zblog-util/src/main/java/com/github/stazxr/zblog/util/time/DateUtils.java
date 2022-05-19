package com.github.stazxr.zblog.util.time;

import com.github.stazxr.zblog.util.Assert;
import com.github.stazxr.zblog.util.StringUtils;
import lombok.extern.slf4j.Slf4j;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 日期工具类
 *
 * @author SunTao
 * @since 2020-11-15
 */
@Slf4j
public class DateUtils extends org.apache.commons.lang3.time.DateUtils {
    /**
     * yyyy-MM-dd HH:mm:ss
     */
    public static final String YMD_HMS_PATTERN = "yyyy-MM-dd HH:mm:ss";

    /**
     * yyyy-MM-dd
     */
    public static final String YMD_PATTERN = "yyyy-MM-dd";

    /**
     * 默认时间格式
     */
    private static final String DEFAULT_PATTERN = YMD_HMS_PATTERN;

    /**
     * 获取系统默认的时间格式样式
     *
     * @return DEFAULT_PATTERN
     */
    public static String defaultPattern() {
        return DEFAULT_PATTERN;
    }

    /**
     * 格式化现在
     *
     * @return 当前时间的字符串 "yyyy-MM-dd HH:mm:ss"
     */
    public static String formatNow() {
        return formatTime();
    }

    /**
     * 格式化现在
     *
     * @return 当前时间的字符串 "yyyy-MM-dd HH:mm:ss"
     */
    public static String formatTime() {
        return format(new Date(), YMD_HMS_PATTERN);
    }

    /**
     * 格式化现在
     *
     * @return 当前时间的字符串 "yyyy-MM-dd"
     */
    public static String formatDate() {
        return format(new Date(), YMD_PATTERN);
    }

    /**
     * 格式化当前时间
     *
     * @param pattern 表达式
     * @return String
     */
    public static String formatNow(String pattern) {
        return format(new Date(), pattern);
    }

    /**
     * 格式化日期为字符串，默认格式为"yyyy-MM-dd HH:mm:ss"
     *
     * @param date 日期
     * @return "yyyy-MM-dd HH:mm:ss"
     */
    public static String format(Date date) {
        return format(date, DEFAULT_PATTERN);
    }

    /**
     * 格式化日期为字符串
     *
     * @param date    日期
     * @param pattern 格式
     * @return String 格式化后的日期
     */
    public static String format(Date date, String pattern) {
        Assert.notNull(date, "待格式化日期不能为空");
        String pattern2 = StringUtils.isEmpty(pattern) ? DEFAULT_PATTERN : pattern;
        return new SimpleDateFormat(pattern2).format(date);
    }

    /**
     * 重新格式化字符串日期为新的格式字符串
     *
     * @param dateStr    字符串日期
     * @param oldPattern 字符串原来的格式
     * @param newPattern 字符串期望的格式
     * @return String 格式化后的日期
     */
    public static String reFormat(String dateStr, String oldPattern, String newPattern) {
        try {
            return format(parseDate(dateStr, oldPattern), newPattern);
        } catch (Exception e) {
            // 格式化失败返回空
            log.warn("reFormat data eor, return oldPattern: [{} & {} & {}]", dateStr, oldPattern, newPattern);
            return oldPattern;
        }
    }

    /**
     * 获取当前时间的时间戳
     *
     * @return 当前时间的时间戳
     */
    public static long getLongTime() {
        return System.currentTimeMillis();
    }

    /**
     * 格式话Long时间
     *
     * @param longTime mills
     * @return String
     */
    public static String formatLongTime(long longTime) {
        return format(new Date(longTime));
    }

    /**
     * 格式话Long时间
     *
     * @param longTime mills
     * @param pattern 输出格式
     * @return String
     */
    public static String formatLongTime(long longTime, String pattern) {
        return format(new Date(longTime), pattern);
    }

    /**
     * 格式话时间
     *
     * @param dateStr 日期
     * @return Date
     */
    public static Date parse(String dateStr) throws ParseException {
        return parseDate(dateStr, DEFAULT_PATTERN);
    }

    /**
     * 字符串转 LocalDateTime ，字符串格式 yyyy-MM-dd
     *
     * @param localDateTime yyyy-MM-dd
     * @return LocalDateTime
     */
    public static LocalDateTime parseLocalDateTimeFormat(String localDateTime, String pattern) {
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(pattern);
        return LocalDateTime.from(dateTimeFormatter.parse(localDateTime));
    }

    /**
     * 字符串转 LocalDateTime ，字符串格式 yyyy-MM-dd
     *
     * @param localDateTime yyyy-MM-dd
     * @return LocalDateTime
     */
    public static LocalDateTime parseLocalDateTimeFormat(String localDateTime, DateTimeFormatter dateTimeFormatter) {
        return LocalDateTime.from(dateTimeFormatter.parse(localDateTime));
    }

    /**
     * 根据两个时间，返回时间差的字符串表示
     *
     * @param endDate 结束时间
     * @param nowDate 当前时间
     * @return String
     */
    public static String getDateDiff(Date endDate, Date nowDate) {
        long nd = 1000 * 24 * 60 * 60;
        long nh = 1000 * 60 * 60;
        long nm = 1000 * 60;
        long ns = 1000;

        // 获得两个时间的毫秒时间差异
        long diff = endDate.getTime() - nowDate.getTime();

        // 计算差多少天
        long day = diff / nd;

        // 计算差多少小时
        long hour = diff % nd / nh;

        // 计算差多少分钟
        long min = diff % nd % nh / nm;

        // 计算差多少秒
        long sec = diff % nd % nh % nm / ns;

        return day + "天" + hour + "小时" + min + "分钟" + sec + "秒";
    }

    /**
     * 格式化时间为字符串数组
     *
     * @param dateStr 时间字符串 yyyy-MM-dd HH:mm:ss or yyyy-MM-dd
     * @return 时间字符数组
     */
    public static String[] parseDateStrToAry(String dateStr) {
        String[] result = new String[6];
        if (StringUtils.isBlank(dateStr)) {
            return result;
        }

        int i = 0;
        String[] tmp1 = dateStr.contains(" ") ? dateStr.split(" ") : new String[]{dateStr};
        for (String tmp : tmp1) {
            // get item
            String[] tmp2 = tmp.contains("-") ? tmp.split("-") :
                    tmp.contains(":") ? tmp.split(":") : new String[]{tmp};

            // set item
            for (String item : tmp2) {
                result[i++] = item;
            }
        }

        // result
        return result;
    }

    /**
     * 判断某天是否是周末（周六或周日）
     *
     * @param date 判断日期
     * @return boolean
     */
    public static boolean isWeekend(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);

        int weekFlag = calendar.get(Calendar.DAY_OF_WEEK);
        return weekFlag == Calendar.SATURDAY || weekFlag == Calendar.SUNDAY;
    }

    /**
     * 计算两个日期之间的天数
     *
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 天数
     */
    public static int calDayCount(Date startDate, Date endDate) {
        if (startDate == null || endDate == null) {
            throw new IllegalArgumentException("startDate or endDate must not be null");
        }

        return (int) ((endDate.getTime() - startDate.getTime()) / (24L * 3600L * 1000L)) + 1;
    }

    /**
     * 计算两个日期之间的工作日天数
     *
     * @param startDate 开始日期
     * @param endDate   结束日期
     * @param workDays  工作日列表，yyyy-MM-dd格式
     * @param restDays  节假日列表，yyyy-MM-dd格式
     * @return 天数
     */
    public static int calWorkDayCount(Date startDate, Date endDate, Set<String> workDays, Set<String> restDays) throws ParseException {
        if (startDate == null || endDate == null) {
            throw new IllegalArgumentException("startDate or endDate must not be null");
        }

        // deal workDays and restDays
        Set<String> workDaysTmp = workDays == null ? new HashSet<>() : workDays;
        Set<String> restDaysTmp = restDays == null ? new HashSet<>() : restDays;

        // 获取日期列表
        Set<String> days = findDays(startDate, endDate);

        // 规则计算，判断是否是周六或周天，如果是，则判断当天是否在 workDays 中配置，如果不是，则判断当天是否在 restDays 中配置
        int workDayCount = 0;
        for (String day : days) {
            Date tmp = parseDate(day, YMD_PATTERN);
            if (isWeekend(tmp)) {
                if (workDaysTmp.contains(day)) {
                    workDayCount++;
                }
            } else {
                if (!restDaysTmp.contains(day)) {
                    workDayCount++;
                }
            }
        }

        return workDayCount;
    }

    /**
     * 计算两个日期之间所有的天数
     *
     * @param startTime 开始日期
     * @param endTime 结束日期
     * @return 日期的集合, 集合格式: [startTime, endTime]
     */
    public static Set<String> findDays(Date startTime, Date endTime) {
        return findDays(startTime, endTime, true, "yyyy-MM-dd");
    }

    /**
     * 计算两个日期之间所有的天数
     *
     * @param startTime 开始日期
     * @param endTime   结束日期
     * @param pattern   日期格式
     * @return 日期的集合, 集合格式: [startTime, endTime]
     */
    public static Set<String> findDays(Date startTime, Date endTime, String pattern) {
        return findDays(startTime, endTime, true, pattern);
    }

    /**
     * 计算两个日期之间所有的天数
     *
     * @param startTime  开始日期
     * @param endTime    结束日期
     * @param containEnd 是否包含结束
     * @return 日期的集合
     */
    public static Set<String> findDays(Date startTime, Date endTime, boolean containEnd) {
        return findDays(startTime, endTime, containEnd, "yyyy-MM-dd");
    }

    /**
     * 计算两个日期之间所有的天数
     *
     * @param startTime  开始日期
     * @param endTime    结束日期
     * @param containEnd 是否包含结束
     * @param pattern    日期格式
     * @return 日期的集合
     */
    public static Set<String> findDays(Date startTime, Date endTime, boolean containEnd, String pattern) {
        Calendar startNode = Calendar.getInstance();
        startNode.setTime(startTime);
        Calendar endNode = Calendar.getInstance();
        endNode.setTime(endTime);
        if (containEnd) {
            endNode.add(Calendar.DATE, 1);
        }

        // cal
        Set<String> days = new HashSet<>();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        while (startNode.before(endNode)) {
            days.add(simpleDateFormat.format(startNode.getTime()));
            startNode.add(Calendar.DAY_OF_YEAR, 1);
        }

        return days;
    }

    public static void main(String[] args) throws ParseException {
        String area = "2022-05-16~至今";
        String[] tmp = area.split("~");
        Date sDate = parseDate(tmp[0], YMD_PATTERN);
        Date eDate = "".equals(tmp[1]) ? new Date() : parseDate(tmp[1], YMD_PATTERN);
        Set<String> days = findDays(sDate, eDate);
        System.out.println(days);
    }
}
