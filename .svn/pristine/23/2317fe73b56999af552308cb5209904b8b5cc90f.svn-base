package com.chinacreator.xtbg.wangcheng.virtualappmanager.dao;

import java.sql.SQLException;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppPermissionBean;



/**
 * description 应用注册Dao
 * author yin.liu
 * date 2012-2-2
 */
public interface AppPermissionDao {

	/**
	 * @Description 根据条件查询已分配的应用注册信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAppPermissionList(AppPermissionBean appPermission, String sortName, String sortOrder, long offset, int maxPagesize);

	/**
	 * @Description 添加应用注册信息
	 * @param appPermission 应用注册Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addAppPermission(AppPermissionBean appPermission) throws SQLException;
	
	/**
	 * @Description  删除应用注册信息
	 * @param pids
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delAppPermission(String pids) throws SQLException;
	/**
	 * 
	*<b>Summary: </b>
	* insertAppToWait(更新菜单获取标识)
	* @param orgid
	* @throws SQLException
	 */
	public void insertAppToWait(String orgid) throws SQLException;
}
