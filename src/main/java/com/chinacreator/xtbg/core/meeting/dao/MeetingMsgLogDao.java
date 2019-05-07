package com.chinacreator.xtbg.core.meeting.dao;

import java.sql.Connection;
import java.util.Map;

/**
 * 
 *<p>Title:MeetingMsgLogDao.java</p>
 *<p>Description:会议消息Dao接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-26
 */
public interface MeetingMsgLogDao {

	/**
	 * 
	*<b>Summary: </b>
	* getMeetingMsgLogMap(查询消息基本信息)
	* @param m_notice_id
	* @param sourceState
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getMeetingMsgLogMap(String m_notice_id, String sourceState, Connection conn) throws Exception;
}
