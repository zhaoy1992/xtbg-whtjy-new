
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ElectServiceIfc.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-1   Administrator    最初版本
   */
package com.chinacreator.xtbg.suxian.electroniccheck.service;

import java.util.Map;

/**
 *<p>Title:ElectServiceIfc.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-1
 */
public interface ElectServiceIfc {
	/**
	 * 
	*<b>Summary: </b>
	* judgeState(判断是否迟到早退)
	* @return
	* @throws Exception
	 */
	String judgeState(String user_id,String date,String strtime,String betweenDate)throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* getResElecSet(得到考勤设置的数据 根据ID)
	* @param elect_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getResElecSet(String elect_id);
	
	/**
	*<b>Summary: </b>
	* findElecStatExist(查询该用户考勤状态 是否已经有记录)
	* @param user_id
	* @param date
	* @param state
	* @return
	 */
	public boolean findElecStatExist(String user_id,String date,String state);
	
	/**
	*<b>Summary: </b>
	* punchStartClock(首页调用上班打卡方法)
	* @param user_id
	* @param userName
	* @param userAccout
	* @param ip
	* @return
	 */
	public String[] punchStartClock(String user_id,String userName,String userAccout,String ip); 
	
	/**
	*<b>Summary: </b>
	* punchEndClock(首页调用下班打卡方法)
	* @param user_id
	* @param ip
	* @return
	 */
	public String[] punchEndClock(String user_id,String userAccout,String username,String ip); 
	
	/**
	 * 是否旷工
	 * @param user_id
	 * @param date
	 * @param state
	 * @return
	 */
	public boolean isAbsenteeism(String user_id,String date,String state);
	
	
}
