package com.javaweb.entity;

import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;

@Getter
@Setter
@Entity
@Table(name="rentarea")
public class RentAreaEntity extends BaseEntity {
    @Column(name = "value")
    private Long value;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn (name = "buildingid")
    private BuildingEntity building;
}
