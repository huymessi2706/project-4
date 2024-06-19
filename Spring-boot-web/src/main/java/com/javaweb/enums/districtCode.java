package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum districtCode {
    QUAN_1("Quận 1"),
    QUAN_2("Quận 2"),
    QUAN_3("Quận 3"),
    QUAN_4("Quận 4"),
    QUAN_5("Quận 5");

    private final String districtName;
    districtCode(String districtName){
        this.districtName = districtName;
    }

    public String getDistrictName() {
        return districtName;
    }

    public static Map<String, String> district(){
        Map<String, String> districtMap = new LinkedHashMap<>();
        for(districtCode districtCode : districtCode.values()){
            districtMap.put(districtCode.toString(), districtCode.getDistrictName());
        }
        return districtMap;
    }
}
