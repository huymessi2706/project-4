package com.javaweb.enums;

import java.util.Map;
import java.util.TreeMap;

public enum statusCode {
    CHUA_XU_LY("Chưa xử lý"),
    DANG_XU_LY("Đang xử lý"),
    DA_XU_LY("Đã xử lý");

    private final String statusName;
    statusCode(String statusName){
        this.statusName = statusName;
    }

    public String getStatusName() {
        return statusName;
    }

    public static Map<String, String> status(){
        Map<String, String> statusMap = new TreeMap<>();
        for(statusCode statusCode : statusCode.values()){
            statusMap.put(statusCode.getStatusName(), statusCode.statusName);
        }
        return statusMap;
    }
}
