package com.javaweb.controller.admin;

import com.javaweb.enums.districtCode;
import com.javaweb.enums.typeCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.IBuildingService;
import com.javaweb.service.IUserService;
import com.javaweb.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller(value="buildingControllerOfAdmin")
public class BuildingController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IBuildingService buildingService;

    @GetMapping(value="/admin/building-list")
    public ModelAndView buildingList(@ModelAttribute("searchModel")BuildingSearchRequest buildingSearchRequest, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/list");
        DisplayTagUtils.of(request, buildingSearchRequest);

        if(SecurityUtils.getAuthorities().contains("ROLE_STAFF")){
            buildingSearchRequest.setStaffId(SecurityUtils.getPrincipal().getId());
        }

        List<BuildingSearchResponse> results = buildingService.getAllBuildings(buildingSearchRequest, PageRequest.of(buildingSearchRequest.getPage() - 1, buildingSearchRequest.getMaxPageItems()));

        BuildingSearchResponse buildingSearchResponse = new BuildingSearchResponse();
        buildingSearchResponse.setTotalItems(buildingService.countTotalItems());
        buildingSearchResponse.setListResult(results);

        mav.addObject("staffs", userService.getStaffs());
        mav.addObject("districts", districtCode.district());
        mav.addObject("typeCodes", typeCode.getTypeCode());
        mav.addObject("listReponseBuilding", buildingSearchResponse);

        return mav;
    }

    @GetMapping(value="/admin/building-edit")
    public ModelAndView buildingEdit(@ModelAttribute("editModel")BuildingDTO buildingDTO) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        mav.addObject("districts", districtCode.district());
        mav.addObject("typeCodes", typeCode.getTypeCode());
        return mav;
    }

    @GetMapping(value="/admin/building-edit-{id}")
    public ModelAndView buildingEditById(@PathVariable Long id) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        BuildingDTO buildingDTO = buildingService.getBuildingById(id);

        mav.addObject("editModel", buildingDTO);
        mav.addObject("districts", districtCode.district());
        mav.addObject("typeCodes", typeCode.getTypeCode());
        return mav;
    }
}
