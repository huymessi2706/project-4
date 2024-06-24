package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum transactionCode {
    DDX("Dẫn đi xem"),
    CSKH("Chăm sóc khách hàng");

    private final String transactionName;
    transactionCode(String transactionName){
        this.transactionName = transactionName;
    }

    public String getTransactionName() {
        return transactionName;
    }

    public static Map<String, String> transaction(){
        Map<String, String> transactionMap = new LinkedHashMap<>();
        for(transactionCode transactionCode : transactionCode.values()){
            transactionMap.put(transactionCode.toString(), transactionCode.getTransactionName());
        }
        return transactionMap;
    }
}
