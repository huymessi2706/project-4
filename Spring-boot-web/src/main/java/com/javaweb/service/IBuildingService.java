package com.javaweb.service;

import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IBuildingService {
    BuildingDTO getBuildingById(Long id);
    List<BuildingSearchResponse> getAllBuildings(BuildingSearchRequest building, Pageable pageable);
    void saveBuilding(BuildingDTO building);
    void deleteBuildings(List<Long> ids);
    void updateAssignmentBuilding(AssignmentBuildingDTO assignmentBuilding);
    int countTotalItems();
}
