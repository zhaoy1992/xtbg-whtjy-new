package com.chinacreator.xtbg.core.meeting.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.meeting.entity.MeetingTopicBean;

/**
 * 
 *<p>Title:MeetingTopicDao.java</p>
 *<p>Description:会议议题Dao接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-24
 */
public interface MeetingTopicDao {

	/**
	 * 
	*<b>Summary: </b>
	* saveMeetingTopic(保存会议议题信息)
	* @param meetingTopicBeanList
	* @param conn
	 */
	public void saveMeetingTopic(String m_notice_id, List<MeetingTopicBean> meetingTopicBeanList, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getmeetingTopicBeanListMap(获得会议议题基本信息)
	* @param m_notice_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getMeetingTopicBeanListMap(String m_notice_id, Connection conn) throws Exception;
}
