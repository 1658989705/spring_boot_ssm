package com.jok.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jok.domain.User;
import com.jok.mapper.UserMapper;

import java.util.List;

/**
 * @author SONG
 */
@Service
@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
public class UserService {
  @Autowired
  private UserMapper userMapper;

  @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
  public int changePassword(Integer id,
                            String password) {
    return userMapper.changePassword(id, password);
  }

  @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
  public int add(User user) {
    return userMapper.add(user);
  }

  @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
  public int modify(User user) {
    return userMapper.modify(user);
  }

  @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
  public int remove(Integer id) {
    return userMapper.remove(id);
  }

  public User find(Integer id) {
    return userMapper.findById(id);
  }

  public List<User> find() {
    return userMapper.find();
  }
}
