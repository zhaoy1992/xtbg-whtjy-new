package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:LandHouseInfoDao.java</p>
 *<p>Description:土地房屋管理DAO接口类</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author 陈郊
 *@version 1.0
 *@CreateDate:2015-11-23
 */
public interface LandHouseInfoDao {

	/**
	 * 
	*<b>Summary: </b>
	* getDataList(土地房屋管理列表查询)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	PagingBean getDataList(String parmjson, String sortName, String sortOrder,
			long offset, int maxPagesize) throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* deleteLandHouseItemById(根据lh_id删除土地房屋项)
	* @param conn
	* @param beanId
	* @throws Exception
	 */
	boolean deleteLandHouseItemById(Connection conn, String lh_id) throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* queryLandHouseBean(根据lh_id获取土地房屋基本信息)
	* @param conn
	* @param lh_id
	* @return
	* @throws Exception
	 */
	Map<String, String> queryLandHouseBean(Connection conn, String lh_id) throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* getLandHouseByLh_Number(根据编号查询土地房屋基本信息)
	* @param string
	* @return
	* @throws Exception
	 */
	String getLandHouseByLh_Number(String lh_number) throws Exception;
	
}
