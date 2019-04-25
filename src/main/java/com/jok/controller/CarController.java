package com.jok.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.jok.domain.Car;
import com.jok.domain.CustomType;
import com.jok.service.CarService;

import java.util.List;

/**
 * @author jok
 * @date 2019/4/20 22:11
 */
@RestController // 以json数据格式返回
@RequestMapping("/api")
public class CarController {
  @Autowired
  private CarService carService;

  @RequestMapping(value = "/cars", method = RequestMethod.GET)
  public ResponseEntity<?> getCars() {
    List<Car> cars = carService.list();

    if (cars.isEmpty()) {
      return new ResponseEntity<>(new CustomType(400, "没有匹配的结果!"), HttpStatus.OK);
    }

    return new ResponseEntity<>(cars, HttpStatus.OK);
  }

  /*@RequestMapping(value = "/cars", method = RequestMethod.GET)
  public ResponseEntity<?> getCars(
      @RequestParam(value = "name", required = false) String name
  ) {
    List<Car> cars = carService.list(name);

    if (cars.isEmpty()) {
      return new ResponseEntity<>(new CustomType(400, "没有匹配的结果!"), HttpStatus.OK);
    }

    return new ResponseEntity<>(cars, HttpStatus.OK);
  }*/

  @RequestMapping(value = "/cars/{id}", method = RequestMethod.GET)
  public ResponseEntity<?> getCar(@PathVariable("id") Integer id) {
    Car car = carService.find(id);

    if (car == null) {
      return new ResponseEntity<>(new CustomType(400, id + " 没有匹配的结果!"), HttpStatus.OK);
    }

    return new ResponseEntity<>(car, HttpStatus.OK);
  }

  @RequestMapping(value = "/cars", method = RequestMethod.POST)
  public ResponseEntity<?> add(@RequestBody Car car) {
    int count = carService.add(car);
    return new ResponseEntity<>(count, HttpStatus.OK);
  }

  @RequestMapping(value = "/cars", method = RequestMethod.PUT)
  public ResponseEntity<?> modify(@RequestBody Car car) {
    int count = carService.modify(car);
    return new ResponseEntity<>(count, HttpStatus.OK);
  }

  @RequestMapping(value = "/cars/{id}", method = RequestMethod.DELETE)
  public ResponseEntity<?> remove(@PathVariable("id") Integer id) {
    int count = carService.remove(id);
    return new ResponseEntity<>(count, HttpStatus.OK);
  }
}
