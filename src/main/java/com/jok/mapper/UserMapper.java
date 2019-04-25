package com.jok.mapper;

import org.apache.ibatis.annotations.*;

import com.jok.domain.User;

import java.util.List;

/**
 * 系统用户映射器
 *
 * @author SONG
 */

//@CacheNamespace(implementation = com.jok.uitl.RedisCache.class)
public interface UserMapper {

  User findByUsername(@Param("username") String username);

  @Update("update sys_users set password=#{password},last_password_reset_date=now() where id=#{id}")
  int changePassword(@Param("id") Integer id,
                     @Param("password") String password);

  // ** CRUD *********************************************************
  @Select("select id,username,email,status,campus,last_password_reset_date from sys_users")
  @Results({
      @Result(property = "lastPasswordResetDate", column = "last_password_reset_date")
  })
  List<User> find();

  @Select("select id,username,email,status,campus,last_password_reset_date lastPasswordResetDate from sys_users where id=#{id}")
  User findById(Integer id);

  @Insert("insert into sys_users(username,password,email,status,campus,last_password_reset_date) values(#{username},#{password},#{email},#{status},#{campus},#{lastPasswordResetDate})")
  int add(User user);

  @Update("update sys_users set username=#{username},password=#{password}, email=#{email},status=#{status},campus=#{campus} where id=#{id}")
  int modify(User user);

  @Delete("delete from sys_users where id=#{id}")
  int remove(Integer id);

  @Delete("delete from sys_user_role where user_id=#{userId} and role_id=#{roleId}")
  void removeUserRole(@Param("userId") Integer userId, @Param("roleId") Integer roleId);

  @Insert("insert into sys_user_role(user_id,role_id) values(#{userId},#{roleId})")
  void addUserRole(@Param("userId") Integer userId, @Param("roleId") Integer roleId);
}
