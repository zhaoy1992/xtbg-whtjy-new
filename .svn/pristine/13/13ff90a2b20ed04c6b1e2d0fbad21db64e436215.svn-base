package com.chinacreator.xtbg.core.meeting.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUnitBean;

/**
 * 
 *<p>Title:MeetingReceiverUnitDao.java</p>
 *<p>Description:会议单位接收Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-24
 */
public interface MeetingReceiverUnitDao {

	/**
	 * 
	*<b>Summary: </b>
	* saveMeetingReceiverUnit(保存单位接收人)
	* @param m_notice_id
	* @param receiver_unit_ids
	* @param m_check_flag
	* @return
	* @throws Exception
	 */
	public String saveMeetingReceiverUnit(String m_notice_id, String receiver_unit_ids, String m_check_flag, Connection conn) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* findMeetingReceiverUnitList(与会单位报名情况列表查询)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean findMeetingReceiverUnitList(MeetingReceiverUnitBean model,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* isMeetingReceiverUnit(接收单位是否存在)
	* @param m_receiver_unit_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public int isMeetingReceiverUnit(String m_receiver_unit_id, Connection conn) throws Exception;
	
}
