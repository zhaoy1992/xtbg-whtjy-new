package com.chinacreator.xtbg.yimingju.carmanage.dao;

import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean;

/**
 * 
 *<p>Title:CarDriverDao.java</p>
 *<p>Description:发改委所用车辆管理司机信息管理固化层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2013-10-24
 */
public interface CarDriverDao {
	/**
	 * 
	*<b>Summary: </b>
	* queryDriverInfolist(查询车辆司机详细信息)
	* @param driverBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryDriverInfolist(DriverBean driverBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception ;
	/**
	 * 
	*<b>Summary: </b>
	* queryDriverInfoById(根据主键信息查询司机详情)
	* @param driver_id
	* @return
	* @throws Exception
	 */
	public List<DriverBean> queryDriverInfoById(String driver_id)throws Exception ;
}
