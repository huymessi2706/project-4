package com.javaweb.service;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.dto.AssignmentDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import org.springframework.data.domain.Pageable;
import java.util.List;

public interface ICustomerService {
    List<CustomerEntity> getAllCustomers(CustomerSearchRequest customer, Pageable pageable);
    void deleteCustomers(Long[] ids);
    void updateAssignmentCustomer(AssignmentDTO assignmentDTO);
    CustomerDTO addOrUpdate(CustomerDTO userDTO);
    int countItems();
    CustomerEntity getCustomerById(Long id);
}
