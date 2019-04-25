package com.jok.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jok.domain.Car;
import com.jok.mapper.CarMapper;

import java.util.List;

@Service
@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
public class CarService {
  @Autowired
  private CarMapper carMapper;

  public List<Car> list(String name) {
    return carMapper.findByParam(name);
  }

  public List<Car> list() {
    return carMapper.find();
  }

  public Car find(Integer id) {
    return carMapper.findById(id);
  }

  @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, rollbackFor = Exception.class)
  public int add(Car car) {
    return carMapper.add(car);
  }

  @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
  public int modify(Car car) {
    return carMapper.modify(car);
  }

  @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
  public int remove(Integer id) {
    return carMapper.remove(id);
  }
}
