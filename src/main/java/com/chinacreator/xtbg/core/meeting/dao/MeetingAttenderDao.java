package com.chinacreator.xtbg.core.meeting.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * 
 *<p>Title:MeetingAttenderDao.java</p>
 *<p>Description:会议参会人dao服务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-26
 */
public interface MeetingAttenderDao {
	
	
	/**
	*<b>Summary: </b>
	* findMeetingAttenderList(得到参会人员)
	* @return
	* @throws Exception 
	*/
	public List<Map<String,String>> getMeetingAttenderList(Map<String,String> map) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* saveMeetingAttender(保存会议参加人员)
	* @param m_receiver_id
	* @param m_attender_ids
	* @param conn
	* @return
	 */
	public boolean saveMeetingAttender(String m_receiver_id, String m_attender_ids, Connection conn) throws Exception;
}
