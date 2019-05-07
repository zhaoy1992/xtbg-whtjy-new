package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.meeting.dao.MeetingMsgLogDao;
import com.chinacreator.xtbg.core.meeting.util.MeetingConstants;

/**
 * 
 *<p>Title:MeetingMsgLogDaoImpl.java</p>
 *<p>Description:会议消息Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-26
 */
public class MeetingMsgLogDaoImpl extends XtDbBaseDao implements MeetingMsgLogDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingMsgLogMap
	  * @param m_notice_id
	  * @param sourceState
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingMsgLogDao#getMeetingMsgLogMap(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getMeetingMsgLogMap(String m_notice_id,
			String sourceState, Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select m_id, m_notice_id, m_contents, m_msg_type, m_msg_send_flag, m_msg_send_flag_name");
		sql.append("  from oa_meeting_msg_log");
		sql.append(" where m_notice_id = ?");
		if(sourceState.equalsIgnoreCase(MeetingConstants.STATUS_PUBLISHED)){
			sql.append("   and m_msg_send_flag = '"+MeetingConstants.STATUS_PUBLISHED+"'");
		}else if(sourceState.equalsIgnoreCase(MeetingConstants.STATUS_REPUBLISHED)){
			sql.append("   and m_msg_send_flag = '"+MeetingConstants.STATUS_REPUBLISHED+"'");
		}else{
			sql.append("   and m_msg_send_flag = '3'");
		}
		viewMap = queryToSingleMap(conn, sql.toString(), m_notice_id);
		
		return viewMap;
	}

}
