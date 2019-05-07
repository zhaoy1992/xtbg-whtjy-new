package com.chinacreator.xtbg.core.holiday.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.holiday.entity.Daily;

/**
 * 
 *<p>Title:DailyDao.java</p>
 *<p>Description:作息时间管理接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-22
 */
public interface DailyDao {

	/**
	 * 
	*<b>Summary: </b>
	* selDataDataList(查询作息时间列表信息)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDailyList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception; 
	/**
	 * 
	*<b>Summary: </b>
	* findDailyByWorkId(根据id查询工作时间的基本信息)
	* @param workId
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> findDailyByWorkId(String workId,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findAcross(判断该工作日期是否冲突)
	* @param daily
	* @param conn
	* @return
	* @throws Exception
	 */
	public String findAcross(Daily daily,Connection conn)throws Exception;
}
