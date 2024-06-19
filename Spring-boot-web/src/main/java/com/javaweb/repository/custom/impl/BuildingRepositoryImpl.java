package com.javaweb.repository.custom.impl;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.repository.custom.BuildingRepositoryCustom;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class BuildingRepositoryImpl implements BuildingRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    private String sqlForCount;

    @Override
    public List<BuildingEntity> findAll(BuildingSearchRequest building, Pageable pageable) {
        // TODO Auto-generated method stub
        StringBuilder sql = new StringBuilder(
                " SELECT DISTINCT B.* " + " FROM building B ");
        joinBuilding(building, sql);
        sql.append(" WHERE 1 = 1 ");
        sqlBuildingNormal(building, sql);
        sqlBuildingSpecial(building, sql);
        sqlForCount = sql.toString();
        sql.append(" LIMIT ").append(pageable.getPageSize()).append("\n")
                .append(" OFFSET ").append(pageable.getOffset());
        Query query = entityManager.createNativeQuery(sql.toString(), BuildingEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItems() {
        Query query = entityManager.createNativeQuery(sqlForCount);
        return query.getResultList().size();
    }

    public void sqlBuildingNormal(BuildingSearchRequest building, StringBuilder sql) {
        try {
            Field[] fields = BuildingSearchRequest.class.getDeclaredFields();
            for(Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();

                if (!fieldName.equals("type") && !fieldName.equals("staffId") && !fieldName.startsWith("area")
                        && !fieldName.startsWith("rentPrice") && !fieldName.startsWith("rentPrice")) {
                    Object data = item.get(building);

                    if (data != null) {
                        if (item.getType().getName().equals("java.lang.Long")) {
                            sql.append(" AND B." + fieldName.toLowerCase() + " = " + data + " ");
                        } else if(!data.toString().equals("")){
                            sql.append(" AND B." + fieldName.toLowerCase() + " LIKE '%" + data + "%' ");
                        }
                    }
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public void sqlBuildingSpecial(BuildingSearchRequest building, StringBuilder sql) {
        // check if field typeCode != null
        if (building.getType() != null && building.getType().size() > 0) {
            sql.append(" AND ( ");
            sql.append(building.getType().stream().map(item -> " B.type LIKE '%" + item + "%' ")
                    .collect(Collectors.joining(" OR ")));
            sql.append(" ) ");
        }

        // check if field areaFrom != null
        if (building.getAreaFrom() != null)
            sql.append(" AND RA.value >= " + building.getAreaFrom() + " ");

        // check if field areaTo != null
        if (building.getAreaTo() != null)
            sql.append(" AND RA.value <= " + building.getAreaTo() + " ");

        // check if field rentPriceFrom != null
        if (building.getRentPriceFrom() != null) {
            sql.append(" AND B.rentprice >= " + building.getRentPriceFrom() + " ");
        }

        // check if field rentPriceTo != null
        if (building.getRentPriceTo() != null) {
            sql.append(" AND B.rentprice <= " + building.getRentPriceTo() + " ");
        }

        // check if field staffId != null
        if (building.getStaffId() != null) {
            sql.append(" AND ASM.staffid = " + building.getStaffId() + " ");
        }
    }

    public void joinBuilding(BuildingSearchRequest building, StringBuilder sql) {
        // check if field areaFrom != null || areaTo != null
        if (building.getAreaFrom() != null || building.getAreaTo() != null) {
            sql.append(" JOIN rentarea RA on RA.buildingid = B.id ");
        }

        // check if field staffId != null
        if (building.getStaffId() != null) {
            sql.append(" JOIN assignmentbuilding ASM on ASM.buildingid = B.id ");
        }
    }
}