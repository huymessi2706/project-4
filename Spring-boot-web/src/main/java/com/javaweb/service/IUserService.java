package com.javaweb.service;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.PasswordDTO;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.exception.MyException;
import com.javaweb.model.response.StaffResponseDTO;
import org.springframework.data.domain.Pageable;
import java.util.List;
import java.util.Map;

public interface IUserService {
    UserDTO findOneByUserNameAndStatus(String name, int status);
    List<UserDTO> getUsers(String searchValue, Pageable pageable);
    int getTotalItems(String searchValue);
    UserDTO findOneByUserName(String userName);
    UserDTO findUserById(long id);
    UserEntity findUserEntityById(Long id);
    UserDTO insert(UserDTO userDTO);
    UserDTO update(Long id, UserDTO userDTO);
    void updatePassword(long id, PasswordDTO userDTO) throws MyException;
    UserDTO resetPassword(long id);
    UserDTO updateProfileOfUser(String id, UserDTO userDTO);
    void delete(long[] ids);
    List<UserDTO> getAllUsers(Pageable pageable);
    int countTotalItems();
    Map<Long, String> getStaffs();
    List<StaffResponseDTO> getListStaffsAndAssignmentStaffs(Long buildingId);
    List<StaffResponseDTO> getListStaffsManageCustomer(Long customerId);
}
