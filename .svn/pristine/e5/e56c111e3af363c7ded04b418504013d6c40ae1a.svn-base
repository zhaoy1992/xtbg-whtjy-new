package com.chinacreator.xtbg.core.holiday.service;

import java.util.Map;

import com.chinacreator.xtbg.core.holiday.entity.Daily;

/**
 * 
 *<p>Title:DailyService.java</p>
 *<p>Description:z工作时间管理服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-23
 */
public interface DailyService {
	
	/**
	 * 
	*<b>Summary: </b>
	* findDailyByWorkId(根据id查询工作时间的基本信息)
	* @param workId
	* @return
	 */
	public Map<String, String> findDailyByWorkId(String workId);
	/**
	 * 
	*<b>Summary: </b>
	* delDailyByIds(根据ids删除相应的工作时间信息)
	* @param idsStr
	* @return
	 */
	public boolean delDailyByIds(String idsStr);
	/**
	 * 
	*<b>Summary: </b>
	* addDaily(添加工作时间信息)
	* @param daily
	* @return
	 */
	public boolean addorupdateDaily(Daily daily);
	/**
	 * 
	*<b>Summary: </b>
	* findAcross(判断该工作日期是否冲突)
	* @param daily
	* @return
	 */
	public String findAcross(Daily daily);

}
