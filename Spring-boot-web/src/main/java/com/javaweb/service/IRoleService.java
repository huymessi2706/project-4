package com.javaweb.service;

import com.javaweb.entity.RoleEntity;
import com.javaweb.model.dto.RoleDTO;

import java.util.List;
import java.util.Map;

public interface IRoleService {
	List<RoleDTO> findAll();
	Map<String,String> getRoles();
	RoleEntity getRole(String roleName);
}
