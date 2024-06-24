package com.javaweb.entity;

import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Table(name="transaction")
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TransactionEntity extends BaseEntity {
    @Column(name="code")
    private String code;

    @Column(name="note")
    private String note;

    @Column(name = "staffid")
    private Long staffId;

    @ManyToOne
    @JoinColumn(name = "customerid")
    private CustomerEntity customer;
}
