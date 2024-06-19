package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum typeCode {
    TANG_TRET("Tầng trêt"),
    NOI_THAT("Nội thất"),
    NGUYEN_CAN("Nguyên căn");

    private final String nameTypeBuilding;
    typeCode (String nameTypeBuilding){
        this.nameTypeBuilding = nameTypeBuilding;
    }

    public String getNameTypeBuilding(){
        return nameTypeBuilding;
    }

    public static Map<String, String> getTypeCode(){
        Map<String, String> listTypeCode = new LinkedHashMap<>();
        for(typeCode typeCode : typeCode.values()){
            listTypeCode.put(typeCode.toString(), typeCode.getNameTypeBuilding());
        }

        return listTypeCode;
    }
}
