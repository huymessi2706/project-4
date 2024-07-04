package com.javaweb.controller.admin;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.enums.statusCode;
import com.javaweb.enums.transactionCode;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.ICustomerService;
import com.javaweb.service.IUserService;
import com.javaweb.service.impl.RoleService;
import com.javaweb.service.impl.TransactionService;
import com.javaweb.utils.DisplayTagUtils;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller(value = "customerControllerOfAdmin")
@AllArgsConstructor
public class CustomerController {

    private final ICustomerService customerService;
    private final IUserService userService;
    private final TransactionService transactionService;
    private final RoleService roleService;

    @GetMapping(value = "/admin/customer-list")
    public ModelAndView customerList(@ModelAttribute("searchModel") CustomerSearchRequest customerSearchRequest, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/list");
        DisplayTagUtils.of(request, customerSearchRequest);

        if(SecurityUtils.getAuthorities().contains("ROLE_STAFF")){
            customerSearchRequest.setStaffId(SecurityUtils.getPrincipal().getId());
        }

        List<CustomerEntity> results = customerService.getAllCustomers(customerSearchRequest, PageRequest.of(customerSearchRequest.getPage() - 1, customerSearchRequest.getMaxPageItems()));

        mav.addObject("maxPages", customerSearchRequest.getMaxPageItems());
        mav.addObject("totalItems", customerService.countItems());
        mav.addObject("listResponse", results);
        mav.addObject("statuses", statusCode.status());
        mav.addObject("staffs", userService.getStaffs());

        return mav;
    }

    @GetMapping(value = "/admin/customer-edit")
    public ModelAndView customerEdit(@ModelAttribute("editModel")CustomerDTO customer) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        customer.setStatus(statusCode.CHUA_XU_LY.getStatusName());
        mav.addObject("statuses", statusCode.status());
        return mav;
    }

    @GetMapping(value = "/admin/customer-edit-{id}")
    public ModelAndView customerEdit(@PathVariable("id") Long id) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");

        if(SecurityUtils.getAuthorities().contains("ROLE_STAFF")){
            if(!userService.findUserEntityById(SecurityUtils.getPrincipal().getId()).getCustomers().contains(customerService.getCustomerById(id))) {
                return new ModelAndView("redirect:/admin/customer-list");
            }
        }

        CustomerEntity customer = customerService.getCustomerById(id);

        mav.addObject("editModel", customer);
        mav.addObject("statuses", statusCode.status());
        mav.addObject("transactions", transactionCode.transaction());

        List<TransactionEntity> listDDX = transactionService.findByCodeAndCustomerId("DDX", id);
        List<TransactionEntity> listCSKH = transactionService.findByCodeAndCustomerId("CSKH", id);
        mav.addObject("listDDX", listDDX);
        mav.addObject("listCSKH", listCSKH);

        return mav;
    }
}
