package com.chinacreator.xtbg.wangcheng.virtualappmanager.service;

import java.sql.SQLException;

/**
 * description 应用注册
 * author yin.liu
 * date 2012-2-2
 */
public interface AppPermissionServiceIfc {

	/**
	 * @Description 添加应用注册信息
	 * @param appPermission 应用注册Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean saveAppPermission(String appids,String orgid,String orgname);
	
	/**
	 * @Description  删除应用注册信息
	 * @param pids
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delAppPermission(String pids,String orgid);
}
