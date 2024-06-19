package com.javaweb.service.impl;

import com.javaweb.converter.BuildingConverter;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.RentAreaRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.IBuildingService;
import com.javaweb.utils.UploadFileUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.io.File;
import java.util.List;

@Service
public class BuildingService implements IBuildingService {

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private BuildingConverter buildingConverter;

    @Autowired
    private RentAreaRepository rentAreaRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UploadFileUtils uploadFileUtils;

    @Override
    public BuildingDTO getBuildingById(Long id) {
        BuildingEntity buildingEntity = buildingRepository.findById(id).get();
        BuildingDTO buildingDTO = buildingConverter.convertBuildingDTO(buildingEntity);
        return buildingDTO;
    }

    @Override
    public List<BuildingSearchResponse> getAllBuildings(BuildingSearchRequest building, Pageable pageable) {
        List<BuildingEntity> buildings = buildingRepository.findAll(building, pageable);
        List<BuildingSearchResponse> rs = buildingConverter.convertBuildingSearchReponseList(buildings);
        return rs;
    }

    @Override
    @Transactional
    public void saveBuilding(BuildingDTO building) {
        Long buildingId = building.getId();
        BuildingEntity buildingEntity = buildingConverter.convertBuildingEntity(building);

        if (buildingId != null) { // update
            BuildingEntity foundBuilding = buildingRepository.findById(buildingId)
                    .orElseThrow(() -> new NotFoundException("Building not found!"));
            buildingEntity.setAvatar(foundBuilding.getAvatar());
            buildingEntity.setUsers(foundBuilding.getUsers());
        }
        saveThumbnail(building, buildingEntity);


        buildingRepository.save(buildingEntity);
    }

    @Override
    @Transactional
    public void deleteBuildings(List<Long> ids) {
        buildingRepository.deleteByIdIn(ids);
    }

    @Override
    @Transactional
    public void updateAssignmentBuilding(AssignmentBuildingDTO assignmentBuilding) {
        List<UserEntity> staffs = userRepository.findByIdIn(assignmentBuilding.getStaffs());
        BuildingEntity buildingEntity = buildingRepository.findById(assignmentBuilding.getBuildingId()).get();
        buildingEntity.setUsers(staffs);
        buildingRepository.save(buildingEntity);
    }

    private void saveThumbnail(BuildingDTO buildingDTO, BuildingEntity buildingEntity) {
        String path = "/building/" + buildingDTO.getImageName();
        if (null != buildingDTO.getImageBase64()) {
            if (null != buildingEntity.getAvatar()) {
                if (!path.equals(buildingEntity.getAvatar())) {
                    File file = new File("C://home/office" + buildingEntity.getAvatar());
                    file.delete();
                }
            }
            byte[] bytes = Base64.decodeBase64(buildingDTO.getImageBase64().getBytes());
            uploadFileUtils.writeOrUpdate(path, bytes);
            buildingEntity.setAvatar(path);
        }
    }

    @Override
    public int countTotalItems() {
        return buildingRepository.countTotalItems();
    }
}
