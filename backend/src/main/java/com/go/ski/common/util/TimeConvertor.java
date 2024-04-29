package com.go.ski.common.util;

import java.util.List;

public class TimeConvertor {

    public static String calLessonTimeInfo(String startTime, Integer duration) {
        String newStartTime = calNewStartTime(startTime);
        String newEndTime = calNewEndTime(startTime, duration);
        return newStartTime + " ~ " + newEndTime;
    }

    public static String calNewStartTime(String startTime) {
        return startTime.length() == 4 ?
                startTime.substring(0,2) + ":" + startTime.substring(2,4) :
                startTime.charAt(0) + ":" + startTime.substring(1,3);
    }

    public static String calNewEndTime(String startTime, Integer duration) {
        // startTime과 duration으로부터 endTime 계산
        String endTime = Integer.parseInt(startTime) + duration * 100 > 2400 ? // 새벽 강습 -> 24시가 넘어가면
                String.valueOf(Integer.parseInt(startTime) + duration * 100 - 2400) : // 0시로 초기화
                String.valueOf(Integer.parseInt(startTime) + duration * 100);
        return endTime.length() == 4 ?
                endTime.substring(0,2) + ":" + endTime.substring(2,4) :
                endTime.charAt(0) + ":" + endTime.substring(1,3);
    }

    public static Integer dayoffListToInteger(List<Integer> dayoffList) {
        return dayoffList.stream()
                .mapToInt(day -> 1 << day)
                .sum();
    }
}
