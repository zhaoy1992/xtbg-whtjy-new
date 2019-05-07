package com.chinacreator.xtbg.core.holiday.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.holiday.entity.Holiday;

/**
 * 
 *<p>Title:HolidayDao.java</p>
 *<p>Description:节假日管理接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-22
 */
public interface HolidayDao {

	/**
	 * 
	*<b>Summary: </b>
	* delete(删除节假日)
	* @param Holiday
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean delete(Holiday Holiday,Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* hasInitYear(判断是否已经是初始化年)
	* @param year conn
	* @return
	 */
	public boolean hasInitYear(String year,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* insertValues(添加所有的节假日)
	* @param values
	* @throws Exception
	 */
	public void insertValues(List<Holiday> values,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* recordInitYear()
	* @param year
	* @throws Exception
	 */
	public void recordInitYear(String year,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findByDay(查询选中的天)
	* @param pk
	* @param conn
	* @return
	* @throws Exception
	 */
	public String findByDay(String pk,Connection conn)throws Exception;
}
