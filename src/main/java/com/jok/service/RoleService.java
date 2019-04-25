package com.jok.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jok.domain.Role;
import com.jok.mapper.RoleMapper;

/**
 * @author SONG
 */
@Service("roleService")
@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
public class RoleService {
  @Autowired
  private RoleMapper roleMapper;

  @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
  public int add(Role role) {
    return roleMapper.add(role);
  }

  @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
  public int modify(Role role) {
    return roleMapper.modify(role);
  }

  @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
  public int remove(Integer id) {
    return roleMapper.remove(id);
  }

  public Role find(Integer id) {
    return roleMapper.findById(id);
  }

  public List<Role> find() {
    return roleMapper.find();
  }

  /**
   * 根据选中的角色id查询显示对应的menu
   *
   * @param roleId
   * @return
   */
  public List<Integer> findMenuRole(Integer roleId) {
    return roleMapper.findMenuRole(roleId);
  }
}
