package com.javaweb.model.dto;

import lombok.Getter;
import lombok.Setter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@Setter
public class BuildingDTO extends AbstractDTO{
    private Long id;
    private String name;
    private String street;
    private String ward;
    private String district;
    private Long numberOfBasement;
    private Long floorArea;
    private String level;
    private List<String> type;
    private String overtimeFee;
    private String electricityFee;
    private String waterFee;
    private String deposit;
    private String payment;
    private String rentTime;
    private String decorationTime;
    private String rentPriceDescription;
    private String carFee;
    private String motoFee;
    private String structure;
    private String direction;
    private String note;
    private String rentArea;
    private String managerName;
    private String managerPhone;
    private Long rentPrice;
    private String serviceFee;
    private Double brokerageFee;
    private String avatar;
    private String imageBase64;
    private String imageName;

    private Map<String,String> buildingDTOs = new HashMap<>();

    public Map<String, String> getBuildingDTOs() {
        return buildingDTOs;
    }

    public void setBuildingDTOs(Map<String, String> buildingDTOs) {
        this.buildingDTOs = buildingDTOs;
    }

    public String getImageBase64() {
        if (imageBase64 != null) {
            return imageBase64.split(",")[1];
        }
        return null;
    }

    public void setImageBase64(String imageBase64) {
        this.imageBase64 = imageBase64;
    }

}