package com.chinacreator.xtbg.core.meeting.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingRoomoccupancyDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingRoomoccupancyBean;
import com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc;
/**
 * 
 *<p>Title:MeetingRoomoccupancyServiceImpl.java</p>
 *<p>Description:会议室预约情况Service实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-29
 */
public class MeetingRoomoccupancyServiceImpl implements
		MeetingRoomoccupancyServiceIfc {
	
	private static final Logger LOG = Logger.getLogger(MeetingRoomoccupancyServiceImpl.class);

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isRoomAdministrator
	  * @param user_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomService#isRoomAdministrator(java.lang.String)
	 */
	public int isRoomAdministrator(String user_id) {
		Connection conn = null;
		int roomcount = 0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MeetingRoomoccupancyDao dao = (MeetingRoomoccupancyDao) LoadSpringContext
					.getApplicationContext().getBean("meetingRoomoccupancyDaoImpl");
			roomcount = dao.isRoomAdministrator(user_id, conn);
			
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return roomcount;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isCurRoomAdministrator
	  * @param room_id
	  * @param user_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomService#isCurRoomAdministrator(java.lang.String, java.lang.String)
	 */
	public int isCurRoomAdministrator(String room_id, String user_id) {
		Connection conn = null;
		int roomcount = 0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MeetingRoomoccupancyDao dao = (MeetingRoomoccupancyDao) LoadSpringContext
					.getApplicationContext().getBean("meetingRoomoccupancyDaoImpl");
			roomcount =dao.isCurRoomAdministrator(room_id, user_id, conn);
			
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return roomcount;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveMeetingRoomoccupancy
	  * @param meetingRoomoccupancyBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc#saveMeetingRoomoccupancy(com.chinacreator.xtbg.core.meeting.entity.MeetingRoomoccupancyBean)
	 */
	public boolean saveMeetingRoomoccupancy(
			MeetingRoomoccupancyBean meetingRoomoccupancyBean) {
		boolean flag = false;
		Connection conn = null;
		MeetingRoomoccupancyDao meetingRoomoccupancyDao = null;
		String m_ro_id = "";
		try {
			if(meetingRoomoccupancyBean != null) {
				conn = DbManager.getInstance().getTransactionConnection();
				m_ro_id = meetingRoomoccupancyBean.getM_ro_id();
				meetingRoomoccupancyDao = (MeetingRoomoccupancyDao)LoadSpringContext.getApplicationContext().getBean("meetingRoomoccupancyDaoImpl");
				
				if(StringUtil.isBlank(m_ro_id)) {
					m_ro_id = StringUtil.getUUID();
					meetingRoomoccupancyBean.setM_ro_id(m_ro_id);
					((BaseDao)meetingRoomoccupancyDao).insert(meetingRoomoccupancyBean, conn);//保存会议预约
				} else {
					((BaseDao)meetingRoomoccupancyDao).update(meetingRoomoccupancyBean, conn);//修改会议预约
				}
				
				flag = true;
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 geteMeetingRoomoccupancyBean
	  * @param m_ro_id
	  * @param meetingType
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc#geteMeetingRoomoccupancyBean(java.lang.String, java.lang.String)
	 */
	public Map<String, String> geteMeetingRoomoccupancyBean(String m_ro_id,
			String meetingType) {
		Connection conn = null;
		Map<String, String> viewMap = new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getConnection();
			MeetingRoomoccupancyDao meetingRoomoccupancyDao = (MeetingRoomoccupancyDao) LoadSpringContext.getApplicationContext().getBean("meetingRoomoccupancyDaoImpl");
			viewMap = meetingRoomoccupancyDao.geteMeetingRoomoccupancyBean(m_ro_id, meetingType, conn);
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delMeetingRoomoccupancy
	  * @param m_ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc#delMeetingRoomoccupancy(java.lang.String)
	 */
	public boolean delMeetingRoomoccupancy(String m_ids) {
		MeetingRoomoccupancyBean meetingRoomoccupancyBean = null;
		Connection conn = null;
		String[] m_idsArray = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MeetingRoomoccupancyDao MeetingRoomoccupancyDao = (MeetingRoomoccupancyDao) LoadSpringContext
					.getApplicationContext().getBean("meetingRoomoccupancyDaoImpl");
			
			if(!StringUtil.isBlank(m_ids)) {
				m_idsArray = m_ids.split(",");
				for (int i = 0; i < m_idsArray.length; i++) {
					meetingRoomoccupancyBean = new MeetingRoomoccupancyBean();
					meetingRoomoccupancyBean.setM_ro_id(m_idsArray[i]);
					((BaseDao)MeetingRoomoccupancyDao).deleteListById(meetingRoomoccupancyBean, conn, m_idsArray[i]);//删除会议预约
				}
				
			}
			flag = true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingRoomList
	  * @param unit_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#getMeetingRoomList(java.lang.String)
	 */
	public List<Map<String, String>> getMeetingRoomList(String unit_id) {
		Connection conn = null;
		MeetingRoomoccupancyDao meetingRoomoccupancyDao = null;
		List<Map<String, String>> meetingRoomList = null;
		
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			meetingRoomList = new ArrayList<Map<String, String>>();
			meetingRoomoccupancyDao = (MeetingRoomoccupancyDao) LoadSpringContext
			.getApplicationContext().getBean("meetingRoomoccupancyDaoImpl");
			
			meetingRoomList = meetingRoomoccupancyDao.getMeetingRoomList(unit_id, conn);
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return meetingRoomList;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 viewRoomOccupancy
	  * @param unit_id
	  * @param times
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#viewRoomOccupancy(java.lang.String, java.lang.String)
	 */
	public List<Map<String, String>> viewRoomOccupancy(String unit_id,
			String times) {
		Connection conn = null;
		MeetingRoomoccupancyDao meetingRoomoccupancyDao = null;
		List<Map<String, String>> roomOccupancyList = null;
		
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			roomOccupancyList = new ArrayList<Map<String, String>>();
			meetingRoomoccupancyDao = (MeetingRoomoccupancyDao) LoadSpringContext
			.getApplicationContext().getBean("meetingRoomoccupancyDaoImpl");
			
			
			roomOccupancyList = meetingRoomoccupancyDao.viewRoomOccupancy(unit_id, times);
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return roomOccupancyList;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isRoomOccupancy
	  * @param m_begin_time
	  * @param m_end_time
	  * @param room_id
	  * @param m_ro_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc#isRoomOccupancy(java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	public boolean isRoomOccupancy(String m_begin_time, String m_end_time,
			String room_id, String m_ro_id, String m_notice_id) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MeetingRoomoccupancyDao dao = (MeetingRoomoccupancyDao) LoadSpringContext
					.getApplicationContext().getBean("meetingRoomoccupancyDaoImpl");
			flag =dao.isRoomOccupancy(m_begin_time, m_end_time, room_id,m_ro_id,m_notice_id, conn);
			
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 isRoomOccupancyBym_notice_id 会议室是否被占用,同一个会议要剔除
	  * @param m_begin_time
	  * @param m_end_time
	  * @param room_id
	  * @param m_notice_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc#isRoomOccupancyBym_notice_id(java.lang.String, java.lang.String, java.lang.String, java.lang.String) 
	  */
	public boolean isRoomOccupancyBym_notice_id(String m_begin_time, String m_end_time,
			String room_id, String m_notice_id) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MeetingRoomoccupancyDao dao = (MeetingRoomoccupancyDao) LoadSpringContext
					.getApplicationContext().getBean("meetingRoomoccupancyDaoImpl");
			flag =dao.isRoomOccupancy(m_begin_time, m_end_time, room_id,"",m_notice_id, conn);
			
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}
