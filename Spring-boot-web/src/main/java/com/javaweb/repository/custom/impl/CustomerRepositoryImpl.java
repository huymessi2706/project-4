package com.javaweb.repository.custom.impl;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.repository.custom.CustomerRepositoryCustom;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

@Repository
public class CustomerRepositoryImpl implements CustomerRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    private String sqlForCount;

    @Override
    public List<CustomerEntity> findAll(CustomerSearchRequest customer, Pageable pageable) {
        StringBuilder sql = new StringBuilder(
                " SELECT DISTINCT C.* " + " FROM customer C ");
        joinSql(customer, sql);
        sql.append(" WHERE 1 = 1 ");
        sqlCustomer(customer, sql);
        sql.append(" AND C.is_active = 1 ");
        sqlForCount = sql.toString();
        sql.append(" LIMIT ").append(pageable.getPageSize()).append("\n")
                .append(" OFFSET ").append(pageable.getOffset());
        Query query = entityManager.createNativeQuery(sql.toString(), CustomerEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItems() {
        Query query = entityManager.createNativeQuery(sqlForCount);
        return query.getResultList().size();
    }

    public void sqlCustomer (CustomerSearchRequest customer, StringBuilder sql) {
        try {
            Field[] fields = CustomerSearchRequest.class.getDeclaredFields();
            for(Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();

                if (!fieldName.equals("staffId")) {
                    Object data = item.get(customer);

                    if (data != null) {
                        if (item.getType().getName().equals("java.lang.Long")) {
                            sql.append(" AND C." + fieldName.toLowerCase() + " = " + data + " ");
                        } else if(!data.toString().equals("")){
                            sql.append(" AND C." + fieldName.toLowerCase() + " LIKE '%" + data + "%' ");
                        }
                    }
                }
                else{
                    Object data = item.get(customer);
                    if(data != null) {
                        sql.append(" AND asm." + fieldName.toLowerCase() + " = " + data + " ");
                    }
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public  void joinSql(CustomerSearchRequest customer, StringBuilder sql) {
        if (customer.getStaffId() != null) {
            sql.append(" JOIN assignmentcustomer asm ON C.id = asm.customerid");
        }
    }
}
