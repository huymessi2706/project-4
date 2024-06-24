package com.javaweb.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomerDTO{
    private Long id;
    private String fullName;
    private String phone;
    private String email;
    private String companyName;
    private String demand;
    private String status;
//    private Long isActive;
}
