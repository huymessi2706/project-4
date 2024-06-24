package com.javaweb.service;

import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;
import java.util.List;

public interface ITransactionService {
    List<TransactionEntity> findByCodeAndCustomerId(String code, Long customerId);
    void addOrUpdateTransaction(TransactionDTO transaction);
    TransactionDTO findById(Long id);
}
