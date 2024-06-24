package com.javaweb.api.admin;

import com.javaweb.model.dto.AssignmentDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/buildings")
public class BuildingAPI {
    @Autowired
    private IUserService userService;

    @Autowired
    private IBuildingService buildingService;

    //update or add building
    @PostMapping
    public void updateOrAddBuilding(@RequestBody BuildingDTO buildingDTO){
        buildingService.saveBuilding(buildingDTO);
    }

    // get all staff and mark "checked" for any staffs that manage the building
    @GetMapping("/{id}/staffs")
    public ResponseDTO getlistStaffs(@PathVariable Long id){
        ResponseDTO responseDTO = new ResponseDTO();
        try {
            List<StaffResponseDTO> response = userService.getListStaffsAndAssignmentStaffs(id);
            responseDTO.setData(response);
            responseDTO.setMessage(new String("Successful!"));
        }
        catch (Exception e) {
            responseDTO.setMessage(e.getMessage());
        }
        return responseDTO;
    }

    //Update List staff manage the building
    @PutMapping
    public void updateAssignmentBuilding(@RequestBody AssignmentDTO assignmentDTO){
        buildingService.updateAssignmentBuilding(assignmentDTO);
    }

    // delete list buildings
    @DeleteMapping
    public void deleteBuilding(@RequestBody List<Long> ids){
        buildingService.deleteBuildings(ids);
    }
}
