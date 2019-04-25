package com.jok.mapper;

import org.apache.ibatis.annotations.*;

import com.jok.domain.Car;

import java.util.List;

/**
 * 映射器接口
 *
 * @author jok
 */
@CacheNamespace(implementation = com.jok.uitl.RedisCache.class)
public interface CarMapper {

  List<Car> findByParam(@Param("name") String name);

  @Select("select id,name,price,sale_date from car")
  @Results({
      @Result(property = "saleDate", column = "sale_date")
  })
  List<Car> find();

  @Select("select id,name,price,sale_date saleDate from car where id=#{id}")
  // @Options(useCache = true, flushCache = Options.FlushCachePolicy.FALSE, timeout = 10000)
  Car findById(Integer id);

  @Insert("insert into car(name,price,sale_date) values(#{name},#{price},#{saleDate})")
  // @Options(flushCache = Options.FlushCachePolicy.TRUE, timeout = 20000)
  int add(Car car);

  @Update("update car set name=#{name},price=#{price},sale_date=#{saleDate} where id=#{id}")
  int modify(Car car);

  @Delete("delete from car where id=#{id}")
  int remove(Integer id);
}
