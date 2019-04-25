package com.jok.mapper;

import java.util.List;

import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jok.domain.Menu;

/**
 * 菜单映射器
 *
 * @author SONG
 */
//@CacheNamespace(implementation = com.jok.uitl.RedisCache.class)
public interface MenuMapper {

  @Select("SELECT DISTINCT MR.MENU_ID FROM sys_menu_role MR,sys_roles R,sys_user_role UR WHERE MR.ROLE_ID=R.ID AND R.ID=UR.ROLE_ID AND UR.USER_ID=#{userId}")
  List<Integer> loadUserMenus(@Param("userId") Integer userId);

  @Select("SELECT ID,PARENT_ID parentId,SEQ,NAME,DESCN,LINK_URL linkUrl,STATUS FROM sys_menus WHERE PARENT_ID IS NULL ORDER BY SEQ")
  List<Menu> loadTopMenus();

  @Select("SELECT ID,PARENT_ID parentId,SEQ,NAME,DESCN,LINK_URL linkUrl,STATUS FROM sys_menus WHERE PARENT_ID=#{parentId} ORDER BY SEQ")
  List<Menu> loadChildMenus(@Param("parentId") Integer parentId);

  // ** CRUD *************************************************************
  @Insert("insert into sys_menus(PARENT_ID,SEQ,NAME,DESCN,LINK_URL,STATUS) values(#{parentId,jdbcType=INTEGER},#{seq},#{name},#{descn},#{linkUrl},#{status})")
  int add(Menu menu);

  @Update("update sys_menus set PARENT_ID=#{parentId,jdbcType=INTEGER},SEQ=#{seq},NAME=#{name},DESCN=#{descn},LINK_URL=#{linkUrl},STATUS=#{status} where ID=#{id}")
  int modify(Menu menu);

  @Delete("delete from sys_menus where ID=#{id}")
  int remove(Integer id);

  @Select("SELECT ID,ifnull(PARENT_ID,0) parentId,SEQ,NAME,DESCN,ifnull(LINK_URL,'') linkUrl,STATUS FROM sys_menus WHERE ID=#{id}")
  Menu findById(Integer id);

  @Select("SELECT ID,ifnull(PARENT_ID,0) parentId,SEQ,NAME,DESCN,ifnull(LINK_URL,'') linkUrl,STATUS FROM sys_menus")
  List<Menu> find();

  @Delete("delete from sys_menu_role where MENU_ID=#{menuId} and ROLE_ID=#{roleId}")
  void removeMenuRole(@Param("menuId") Integer menuId, @Param("roleId") Integer roleId);

  @Insert("insert into sys_menu_role(MENU_ID,ROLE_ID) values(#{menuId},#{roleId})")
  void addMenuRole(@Param("menuId") Integer menuId, @Param("roleId") Integer roleId);
}
