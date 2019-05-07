package com.chinacreator.xtbg.core.meeting.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.meeting.entity.MeetingRoomoccupancyBean;

/**
 * 
 *<p>Title:MeetingRoomoccupancyServiceIfc.java</p>
 *<p>Description:会议室预约情况Service接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-28
 */
public interface MeetingRoomoccupancyServiceIfc {

	/**
	 * 
	*<b>Summary: </b>
	* getMeetingRoomList(查询会议室展示列表)
	* @param unit_id
	* @return
	 */
	public List<Map<String, String>> getMeetingRoomList(String unit_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* viewRoomOccupancy(查询会议室占用情况)
	* @param unit_id
	* @param times
	* @return
	 */
	public List<Map<String, String>> viewRoomOccupancy(String unit_id, String times);
	
	/**
	 * 
	*<b>Summary: </b>
	* isRoomAdministrator(是否是会议室管理员)
	* @param user_id
	* @return
	 */
	public int isRoomAdministrator(String user_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* isCurRoomAdministrator(是否是当前会议室的管理员)
	* @param room_id
	* @param user_id
	* @return
	 */
	public int isCurRoomAdministrator(String room_id, String user_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveMeetingRoomoccupancy(保存会议预约情况)
	* @param meetingRoomoccupancyBean
	* @return
	 */
	public boolean saveMeetingRoomoccupancy(MeetingRoomoccupancyBean meetingRoomoccupancyBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* geteMeetingRoomoccupancyBean(获得会议预约情况Bean)
	* @param m_ro_id
	* @param meetingType
	* @return
	 */
	public Map<String, String> geteMeetingRoomoccupancyBean(String m_ro_id, String meetingType);
	
	/**
	 * 
	*<b>Summary: </b>
	* delMeetingRoomoccupancy(删除会议预约情况)
	* @param m_ids
	* @return
	 */
	public boolean delMeetingRoomoccupancy(String m_ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* isRoomOccupancy(会议室是否被占用)
	* @param m_begin_time
	* @param m_end_time
	* @param room_id
	* @param m_ro_id
	* @return
	 */
	public boolean isRoomOccupancy(String m_begin_time, String m_end_time, String room_id, String m_ro_id, String m_notice_id);
	
	
	/**
	*<b>Summary: </b>
	* isRoomOccupancyBym_notice_id(会议室是否被占用,同一个会议要剔除)
	* @param m_begin_time
	* @param m_end_time
	* @param room_id
	* @param m_notice_id
	* @return 
	*/
	public boolean isRoomOccupancyBym_notice_id(String m_begin_time, String m_end_time, String room_id, String m_notice_id);
}
