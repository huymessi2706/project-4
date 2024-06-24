package com.javaweb.service.impl;

import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.service.ITransactionService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@AllArgsConstructor
public class TransactionService implements ITransactionService {
    private final TransactionRepository transactionRepository;
    private final CustomerRepository customerRepository;

    @Override
    public List<TransactionEntity> findByCodeAndCustomerId(String code, Long customerId) {
        return transactionRepository.findByCodeAndCustomerId(code, customerId);
    }

    @Override
    public void addOrUpdateTransaction(TransactionDTO transaction) {
        TransactionEntity transactionEntity = new TransactionEntity();
        if(transaction.getId() != null){
            transactionEntity = transactionRepository.findById(transaction.getId()).get();
            transactionEntity.setNote(transaction.getTransactionDetail());
        }
        else {
            transactionEntity = TransactionEntity.builder()
                    .note(transaction.getTransactionDetail())
                    .customer(customerRepository.findById(transaction.getCustomerId()).get())
                    .code(transaction.getType())
                    .build();
        }

        transactionRepository.save(transactionEntity);
    }

    @Override
    public TransactionDTO findById(Long id) {
        TransactionEntity transactionEntity = transactionRepository.findById(id).get();
        TransactionDTO transactionDTO = TransactionDTO.builder()
                .transactionDetail(transactionEntity.getNote())
                .build();
        return transactionDTO;
    }
}
