package com.chinacreator.xtbg.core.meeting.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUserBean;

/**
 * 
 *<p>Title:MeetingReceiverUserDao.java</p>
 *<p>Description:会议接收人Dao接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-24
 */
public interface MeetingReceiverUserDao {

	/**
	 * 
	*<b>Summary: </b>
	* saveMeetingReceiverUser(保存会议接收人)
	* @param m_notice_id
	* @param allUserReceiverUser
	* @param m_check_flag
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean saveMeetingReceiverUser(String m_notice_id, List<String> allUserReceiverUser, String m_check_flag, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* findMeetingReceiverUserList(与会人员报名情况列表查询)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean findMeetingReceiverUserList(
			MeetingReceiverUserBean model, String sortName, String sortOrder,
			long offset, int maxPagesize) throws Exception;
	
	
	
	/**
	*<b>Summary: </b>
	* findMeetingReceiverUserDetail(查询用户接收表明细信息)
	* @param m_notice_id
	* @param m_user_id
	* @return
	* @throws Exception 
	*/
	public Map<String, String> findMeetingReceiverUserDetail(
			String m_notice_id, String m_user_id, Connection conn)
			throws Exception;

}
