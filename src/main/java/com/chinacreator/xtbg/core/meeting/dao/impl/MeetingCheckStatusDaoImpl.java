package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingCheckStatusDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingCheckStatusBean;
import com.chinacreator.xtbg.core.meeting.util.MeetingConstants;

/**
 * 
 *<p>Title:MeetingCheckStatusDaoImpl.java</p>
 *<p>Description:会议审批情况Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-24
 */
public class MeetingCheckStatusDaoImpl extends XtDbBaseDao implements MeetingCheckStatusDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveMeetingCheckStatus
	  * @param m_notice_id
	  * @param m_room_id
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingCheckStatusDao#saveMeetingCheckStatus(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public void saveMeetingCheckStatus(String m_notice_id, String m_room_id,
			Connection conn) throws Exception {
		
		StringBuffer sql = new StringBuffer();
		sql.append("select u.m_id, u.m_user_id, u.m_user_name");
		sql.append("  from oa_meeting_room_administrator u");
		sql.append(" where u.m_room_id = ?");
		
		MeetingCheckStatusBean meetingCheckStatusBean = null;
		List<Map<String, String>> listMap = queryToListMap(sql.toString(), m_room_id);
		Map<String, String> roorUserMap = new HashMap<String, String>();
		for (int i = 0; i < listMap.size(); i++) {
			roorUserMap = listMap.get(i);
			meetingCheckStatusBean = new MeetingCheckStatusBean();
			meetingCheckStatusBean.setM_id(StringUtil.getUUID());
			meetingCheckStatusBean.setM_notice_id(m_notice_id);
			meetingCheckStatusBean.setM_user_id(roorUserMap.get("m_user_id"));
			meetingCheckStatusBean.setM_user_name(roorUserMap.get("m_user_name"));
			meetingCheckStatusBean.setM_flag(MeetingConstants.STATUS_TRUE);
			meetingCheckStatusBean.setM_create_time(new Timestamp(System.currentTimeMillis()));
			insert(meetingCheckStatusBean, conn);//保存会议审批情况信息
		}
		
		
	}

}
