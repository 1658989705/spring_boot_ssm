package com.jok.mapper;

import java.util.List;

import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jok.domain.Role;

/**
 * 角色映射器
 *
 * @author SONG
 */
//@CacheNamespace(implementation = com.jok.uitl.RedisCache.class)
public interface RoleMapper {

  @Insert("insert into sys_roles(name,code,descn) values(#{name},#{code},#{descn})")
  int add(Role role);

  @Update("update sys_roles set NAME=#{name},CODE=#{code},DESCN=#{descn} where ID=#{id}")
  int modify(Role role);

  @Delete("delete from sys_roles where ID=#{id}")
  int remove(Integer id);

  @Select("select ID,NAME,CODE,DESCN from sys_roles where ID=#{id}")
  Role findById(Integer id);

  @Select("select ID,NAME,CODE,DESCN from sys_roles order by ID")
  List<Role> find();

  /**
   * 根据选中的角色id查询显示对应的menu
   *
   * @param roleId
   * @return
   */
  @Select("select MENU_ID from sys_menu_role where ROLE_ID=#{roleId} order by MENU_ID")
  List<Integer> findMenuRole(@Param("roleId") Integer roleId);
}
