package com.javaweb.service.impl;

import com.javaweb.converter.CustomerConverter;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.ICustomerService;
import lombok.AllArgsConstructor;
import lombok.Builder;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Builder
@AllArgsConstructor
public class CustomerService implements ICustomerService {

    private final CustomerRepository customerRepository;
    private final UserRepository userRepository;
    private final CustomerConverter customerConverter;
    private final ModelMapper modelMapper;

    @Override
    public List<CustomerEntity> getAllCustomers(CustomerSearchRequest customer, Pageable pageable) {
        List<CustomerEntity> result = customerRepository.findAll(customer,pageable);
        return result;
    }

    @Transactional
    @Override
    public void deleteCustomers(Long[] ids) {
        for (Long item : ids) {
            CustomerEntity customer = customerRepository.findById(item).get();
            customer.setIsActive(0l);
            customerRepository.save(customer);
        }
    }

    @Override
    public void updateAssignmentCustomer(AssignmentDTO assignmentDTO) {
        CustomerEntity customer = customerRepository.findById((assignmentDTO.getId())).get();
        List<UserEntity> staffs = userRepository.findByIdIn(assignmentDTO.getStaffs());
        customer.setUsers(staffs);
        customerRepository.save(customer);
    }

    @Transactional
    @Override
    public CustomerDTO addOrUpdate(CustomerDTO userDTO) {
        CustomerEntity customer = new CustomerEntity();
        if(userDTO.getId() != null){
            customer = customerRepository.findById(userDTO.getId()).get();
            customerConverter.convertToEntity(customer,userDTO);
        }
        else {
            customer = CustomerEntity.builder()
                    .email(userDTO.getEmail())
                    .phone(userDTO.getPhone())
                    .demand(userDTO.getDemand())
                    .fullName(userDTO.getFullName())
                    .isActive(1l)
                    .status("Chưa xử lý")
                    .build();
        }
        return customerConverter.convertToDTO(customerRepository.save(customer));
    }

    @Override
    public int countItems() {
        return customerRepository.countTotalItems();
    }

    @Override
    public CustomerEntity getCustomerById(Long id) {
        return customerRepository.findById(id).get();
    }
}
