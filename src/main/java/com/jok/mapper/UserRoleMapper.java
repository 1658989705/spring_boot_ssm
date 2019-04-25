package com.jok.mapper;

import java.util.List;

import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.jok.domain.Role;

/**
 * 系统用户角色映射器
 *
 * @author SONG
 */
//@CacheNamespace(implementation = com.jok.uitl.RedisCache.class)
public interface UserRoleMapper {

  @Select("select ID,NAME,CODE,DESCN from sys_roles where ID in (select ROLE_ID from sys_user_role where USER_ID=#{userId})")
  List<Role> findRole(@Param("userId") Integer userId);

  @Delete("delete from sys_user_role  where USER_ID=#{userId} and ROLE_ID=#{roleId}")
  void removeUserRole(@Param("userId") Integer userId, @Param("roleId") Integer roleId);

  @Insert("insert into sys_user_role(USER_ID,ROLE_ID) values(#{userId},#{roleId})")
  void addUserRole(@Param("userId") Integer userId, @Param("roleId") Integer roleId);
}
