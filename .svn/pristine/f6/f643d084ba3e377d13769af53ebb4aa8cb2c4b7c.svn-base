package com.chinacreator.xtbg.core.meeting.dao;


import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoteTemplateBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;

/**
 *<p>Title:MeetingDao.java</p>
 *<p>Description:会议管理 数据访问层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-19
 */
/**
 *<p>Title:MeetingDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-7-4
 */
public interface MeetingDao {
	
	
	
	
	/**
	*<b>Summary: </b>
	* insertMeetingNotice(保存会议通知表记录)
	* @param conn
	* @param model
	* @throws Exception 
	*/
	public void insertMeetingNotice(Connection conn, MeetingNoticeBean model) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteMeetingNotice(删除会议通知表记录)
	* @param ids
	* @return
	* @throws SQLException 
	*/
	public boolean deleteMeetingNotice(String ids) throws Exception;
	
	/**
	*<b>Summary: </b>
	* findMeetingNoticeList(查询会议通知表记录)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean findMeetingNoticeList(MeetingNoticeBean model,String timesupflag, String dotype,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getMeetingNoticeBean(会议基本信息查询)
	* @param m_notice_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getMeetingNoticeBean(String m_notice_id, Connection conn) throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* viewRoomOccupancy(查询会议室占用情况)
	* @param unit_id
	* @param times
	* @param sortName
	* @param sortOrder
	* @return
	* @throws Exception
	 */
	public PagingBean viewRoomOccupancy(String unit_id, String times, String sortName,
			String sortOrder) throws Exception;

	
	/**
	*<b>Summary: </b>
	* updateMeetingReceiver(修改催发状态信息)
	* @param conn
	* @param tablename
	* @param ids
	* @param m_call_type
	* @throws Exception 
	*/
	public void updateMeetingReceiver(Connection conn, String tablename,
			String ids, String m_call_type) throws Exception;
	
	
	
	/**
	*<b>Summary: </b>
	* findMeetingNoteTemplateList(查询短信模板列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean findMeetingNoteTemplateList(
			MeetingNoteTemplateBean model, String sortName, String sortOrder,
			long offset, int maxPagesize) throws Exception;
	
	
	
	/**
	*<b>Summary: </b>
	* getMeetingNoticeInfo(查询会议信息)
	* @param m_notice_id
	* @param m_receiver_user_id
	* @param conn
	* @return
	* @throws Exception 
	*/
	public Map<String, String> getMeetingNoticeInfo(String m_notice_id,
			String m_receiver_user_id, Connection conn) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* getUserNames(得到用户names)
	* @param userIds
	* @param conn
	* @return
	* @throws Exception 
	*/
	public String getUserNames(String userIds, Connection conn)
			throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getReceiverUserNames(根据ids得到从新封装会议接收人的列表显示信息)
	* @param ids
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getReceiverUserNames(String ids, Connection conn)throws Exception;
}
