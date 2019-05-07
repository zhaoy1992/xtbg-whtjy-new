package com.chinacreator.xtbg.core.meeting.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingRoomoccupancyBean;

/**
 * 
 *<p>Title:MeetingRoomoccupancyDao.java</p>
 *<p>Description:会议室预约Dao接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-28
 */
public interface MeetingRoomoccupancyDao {

	/**
	 * 
	*<b>Summary: </b>
	* viewRoomOccupancy(查询会议室占用情况)
	* @param unit_id
	* @param times
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> viewRoomOccupancy(String unit_id, String times) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getMeetingRoomList(查询会议室展示列表)
	* @param unit_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getMeetingRoomList(String unit_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getMeetingRoomViewList(获得会议室占用列表)
	* @param meetingRoomoccupancyBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean getMeetingRoomViewList(MeetingRoomoccupancyBean meetingRoomoccupancyBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* isRoomAdministrator(是否是会议室管理员)
	* @param user_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public int isRoomAdministrator(String user_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* isCurRoomAdministrator(是否是当前会议室的管理员)
	* @param room_id
	* @param user_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public int isCurRoomAdministrator(String room_id, String user_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* geteMeetingRoomoccupancyBean(获得会议预约情况Bean)
	* @param m_ro_id
	* @param meetingType
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> geteMeetingRoomoccupancyBean(String m_ro_id, String meetingType, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* isRoomOccupancy(会议室是否被占用)
	* @param m_begin_time
	* @param m_end_time
	* @param room_id
	* @param m_ro_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean isRoomOccupancy(String m_begin_time, String m_end_time,
			String room_id, String m_ro_id, String m_notice_id, Connection conn) throws Exception;	
	
	/**
	*<b>Summary: </b>
	* isRoomOccupancyBym_notice_id(会议室是否被占用,同一个会议要剔除)
	* @param m_begin_time
	* @param m_end_time
	* @param room_id
	* @param m_notice_id
	* @param conn
	* @return
	* @throws Exception 
	*/
	//public boolean isRoomOccupancyBym_notice_id(String m_begin_time, String m_end_time,String room_id,String m_notice_id, Connection conn) throws Exception;
}
