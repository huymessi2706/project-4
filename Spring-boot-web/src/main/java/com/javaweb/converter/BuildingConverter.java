package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.enums.districtCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.BuildingSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class BuildingConverter {
    @Autowired
    private ModelMapper modelMapper;

    public BuildingDTO convertBuildingDTO(BuildingEntity building) {
        BuildingDTO dto = modelMapper.map(building, BuildingDTO.class);
        // get typeCode
        List<String> type = new ArrayList<>();
        String[] part = building.getType().split(",");
        for(String par : part) {
            type.add(par);
        }
        dto.setType(type);

        //get rentareas
        String rentAreas = "";
        for(RentAreaEntity item : building.getRentareas()){
            rentAreas += item.getValue() + ", ";
        }

        if(rentAreas.length() > 1)
            rentAreas = rentAreas.substring(0, rentAreas.length() - 2);

        dto.setRentArea(rentAreas);

        return dto;
    }

    public BuildingEntity convertBuildingEntity(BuildingDTO dto) {
        BuildingEntity building = modelMapper.map(dto, BuildingEntity.class);
        building.setType(dto.getType().stream().collect(Collectors.joining(",")));
        String[] values = convertRentAreas(dto);

        if(values[0] != "") {
            List<RentAreaEntity> rentAreas = new ArrayList<>();

            for (String value : values) {
                RentAreaEntity rentArea = new RentAreaEntity();
                rentArea.setValue(Long.parseLong(value));
                rentArea.setBuilding(building);
                rentAreas.add(rentArea);
            }
            building.setRentareas(rentAreas);
        }

        return building;
    }

    public List<BuildingSearchResponse> convertBuildingSearchReponseList(List<BuildingEntity> buildingEntities) {
        List<BuildingSearchResponse> dtos = new ArrayList<>();
        for(BuildingEntity buildingEntity : buildingEntities) {
            List<String> rentAreas = new ArrayList<>();
            BuildingSearchResponse building = modelMapper.map(buildingEntity, BuildingSearchResponse.class);
            building.setAddress(buildingEntity.getStreet() + ", " + buildingEntity.getWard() + ", " + districtCode.district().get(buildingEntity.getDistrict()));

            for(RentAreaEntity rentArea : buildingEntity.getRentareas())
                rentAreas.add(rentArea.getValue().toString());

            building.setRentArea(rentAreas.stream().collect(Collectors.joining(", ")));

            dtos.add(building);
        }
        return dtos;
    }

    public String[] convertRentAreas (BuildingDTO building) {
        building.setRentArea(building.getRentArea().trim());
        building.setRentArea(building.getRentArea().replaceAll(" ", ""));
        String[] values = building.getRentArea().split(",");

        return values;
    }
}
