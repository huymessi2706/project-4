package com.javaweb.api.admin;

import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.AssignmentDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.service.IUserService;
import com.javaweb.service.impl.CustomerService;
import com.javaweb.service.impl.TransactionService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/customers")
@AllArgsConstructor
public class CustomerAPI {

    private final IUserService userService;
    private final CustomerService customerService;
    private final TransactionService transactionService;

    @GetMapping("/{id}/staffs")
    public ResponseDTO getlistStaffs(@PathVariable Long id){
        ResponseDTO responseDTO = new ResponseDTO();
        try {
            List<StaffResponseDTO> response = userService.getListStaffsManageCustomer(id);
            responseDTO.setData(response);
            responseDTO.setMessage(new String("Successful!"));
        }
        catch (Exception e) {
            responseDTO.setMessage(e.getMessage());
        }
        return responseDTO;
    }

    @PostMapping
    public ResponseEntity<CustomerDTO> addOrUpdateCustomer(@RequestBody CustomerDTO customerDTO){
        return ResponseEntity.ok(customerService.addOrUpdate(customerDTO));
    }

    @GetMapping(value = "/transactions-{id}")
    public ResponseDTO getTransaction(@PathVariable Long id){
        ResponseDTO responseDTO = new ResponseDTO();
        try {
            TransactionDTO response = transactionService.findById(id);
            responseDTO.setData(response);
            responseDTO.setMessage(new String("Successful!"));
        }
        catch (Exception e) {
            responseDTO.setMessage(e.getMessage());
        }
        return responseDTO;
    }

    @PostMapping(value = "/transactions")
    public void addOrUpdateTransaction(@RequestBody TransactionDTO transactionDTO){
        transactionService.addOrUpdateTransaction(transactionDTO);
    }

    @PutMapping
    public void updateAssignmentBuilding(@RequestBody AssignmentDTO assignmentDTO){
        customerService.updateAssignmentCustomer(assignmentDTO);
    }

    @DeleteMapping
    public void deleteCustomer(@RequestBody Long[] ids){
        customerService.deleteCustomers(ids);
    }
}
