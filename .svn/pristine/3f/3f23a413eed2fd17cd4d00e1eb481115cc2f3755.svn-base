package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingTopicDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingTopicBean;

/**
 *<p>Title:MeetingTopicDaoImpl.java</p>
 *<p>Description:会议议题Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-26
 */
public class MeetingTopicDaoImpl extends XtDbBaseDao implements MeetingTopicDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveMeetingTopic
	  * @param meetingTopicBeanList 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingTopicDao#saveMeetingTopic(java.util.List)
	 */
	public void saveMeetingTopic(String m_notice_id, List<MeetingTopicBean> meetingTopicBeanList, Connection conn) throws Exception{
		MeetingTopicBean meetingTopicBean = null;
		if(meetingTopicBeanList.size() > 0) {
			for(int k = 0; k < meetingTopicBeanList.size(); k++) {
				meetingTopicBean = new MeetingTopicBean();
				meetingTopicBean = meetingTopicBeanList.get(k);
				meetingTopicBean.setM_topic_id(StringUtil.getUUID());
				meetingTopicBean.setM_notice_id(m_notice_id);
				insert(meetingTopicBean, conn);//保存会议议题数据
			}
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingTopicBeanListMap
	  * @param m_notice_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingTopicDao#getMeetingTopicBeanListMap(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getMeetingTopicBeanListMap(
			String m_notice_id, Connection conn) throws Exception {
		List<Map<String, String>> meetingTopicBeanListMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select m_topic_id,");
		sql.append("       m_notice_id,");
		sql.append("       m_topic_name,");
		sql.append("       m_begin_time,");
		sql.append("       m_user_id,");
		sql.append("       m_user_name,");
		sql.append("       m_remark,");
		sql.append("       m_topic_unit_ids,");
		sql.append("       m_topic_user_ids,");
		sql.append("       m_topic_unit_names,");
		sql.append("       m_topic_user_names");
		sql.append("  from oa_meeting_topic");
		sql.append(" where m_notice_id = ?");
		
		meetingTopicBeanListMap = queryToListMap(sql.toString(), m_notice_id);
		return meetingTopicBeanListMap;
	}

}
