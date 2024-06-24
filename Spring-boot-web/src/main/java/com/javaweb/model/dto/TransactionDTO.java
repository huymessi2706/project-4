package com.javaweb.model.dto;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TransactionDTO {
    private Long id;
    private String type;
    private Long customerId;
    private String transactionDetail;
}
