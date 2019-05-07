package com.chinacreator.xtbg.core.meeting.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingMinutesDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingMinutesBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingMinutesReaderBean;
import com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc;
import com.chinacreator.xtbg.core.meeting.service.MeetingMinutesService;

/**
 * 
 *<p>
 * Title:MeetingMinutesServiceImpl.java
 * </p>
 *<p>
 * Description:会议纪要业务类
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-26
 */
public class MeetingMinutesServiceImpl implements MeetingMinutesService {
	private static final Logger LOG = Logger
			.getLogger(MeetingMinutesServiceImpl.class);
	// 会议纪要dao
	private MeetingMinutesDao dao = null;
	
	MeetingHandleServiceIfc meetingservice = new MeetingHandleServiceImpl();

	/**
	 * 
	  * <b>Summary: 构造器</b>
	  *     构造一个 MeetingMinutesServiceImpl  
	   * <b>Remarks: </b>
	  *     构造类 MeetingMinutesServiceImpl 的构造函数 MeetingMinutesServiceImpl
	 */
	public MeetingMinutesServiceImpl() {
		try {
			this.dao = (MeetingMinutesDao) LoadSpringContext
					.getApplicationContext().getBean("meetingMinutesDaoImpl");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryToMeetingMinutesBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingMinutesService#queryToMeetingMinutesBean(java.lang.String)
	 */
	public MeetingMinutesBean queryToMeetingMinutesBean(String id) {
		MeetingMinutesBean minutes = new MeetingMinutesBean();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			minutes.setM_minutes_id(id);			
			return (MeetingMinutesBean)((BaseDao)dao).queryToBean(minutes,conn);			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return minutes;
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertMeetingMinutesBean
	  * @param json
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingMinutesService#insertMeetingMinutesBean(java.lang.String)
	 */
	public boolean insertMeetingMinutesBean(MeetingMinutesBean bean) {
		Connection conn = null;
		try {
			if (null == bean) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			// id赋初值
			bean.setM_minutes_id(StringUtil.getUUID());

			// 将字符串时间转换为Timestamp
			bean.setM_reg_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getM_reg_time())));
			// 会议开始时间转换为Timestamp对象（由于其格式为yyyy-MM-dd hh:mm,需补齐秒）
			bean.setM_begin_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getM_begin_time())));

			// 插入会议室
			((BaseDao) dao).insert(bean, conn);
			// 插入会议纪要阅读人员信息
			insertMinutesReader(bean, conn);

			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			return false;
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateMeetingMinutesBean
	  * @param json
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingMinutesService#updateMeetingMinutesBean(java.lang.String)
	 */
	public boolean updateMeetingMinutesBean(MeetingMinutesBean bean) {
		Connection conn = null;
		try {
			if(null == bean){
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			// 将字符串转换为bean
			// MeetingMinutesBean bean = StringUtil.convertStringToBean(json,
			// MeetingMinutesBean.class);

			// 将字符串时间转换为Timestamp
			bean.setM_reg_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getM_reg_time())));
			// 会议开始时间转换为Timestamp对象（由于其格式为yyyy-MM-dd hh:mm,需补齐秒）
			if (StringUtil.nullOrBlank(bean.getM_begin_time().toString())) {
				bean.setM_begin_time(null);
			} else {
				String time = bean.getM_begin_time().toString();
				time = time.length() < 18 ? time + ":00" : time;
				bean.setM_begin_time(StringUtil.convertStringToTimestamp(time));
			}

			// 插入会议室
			((BaseDao) dao).update(bean, conn);
			// 插入会议纪要阅读人员信息
			insertMinutesReader(bean, conn);

			DbManager.closeTransactionConnection(conn, true);
			return true;			
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			return false;
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteListMeetingMinutes
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingMinutesService#deleteListMeetingMinutes(java.lang.String)
	 */
	public boolean deleteListMeetingMinutes(String ids) {
		// 数据库连接
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			
				// 执行删除操作
				((BaseDao) dao).deleteListById(new MeetingMinutesBean(), conn,
						ids);
				//删除对应的会议纪要阅读人员信息
				((BaseDao) dao).deleteListById(new MeetingMinutesReaderBean()
						.setDeleteKey("m_minutes_id"), conn, ids);
			
			// 关闭连接并提交事务
			DbManager.closeTransactionConnection(conn, true);
			return true;

		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			return false;
		}
	}

	/**
	 * 
	*<b>Summary:批量插入会议纪要阅读人员 </b>
	* insertMinutesReader(请用一句话描述这个方法的作用)
	* @param bean 会议纪要bean
	* @param conn 数据库连接
	* @throws Exception
	 */
	private void insertMinutesReader(MeetingMinutesBean bean,
			Connection conn) throws Exception {

		if (null == bean || StringUtil.nullOrBlank(bean.getM_minutes_id())) {
			return;
		}
		// 先删除存在的管理员信息
		((BaseDao) dao).deleteListById(new MeetingMinutesReaderBean()
				.setDeleteKey("m_minutes_id"), conn, bean.getM_minutes_id());
		//可阅读人员还要 自动加上会议的全部接收人，都可以阅读会议纪要。
		/*String m_receiver_user_ids = "";
		if(!StringUtil.nullOrBlank(bean.getM_notice_id())){
			m_receiver_user_ids = meetingservice.getMeetingNoticeBeanById(bean.getM_notice_id()).getM_receiver_user_ids();
		}
		if(!StringUtil.nullOrBlank(m_receiver_user_ids)){
			// 插入管理员信息
			dao.insertMinutesReader(bean.getM_minutes_id(),bean.getM_read_person_ids()+","+m_receiver_user_ids, conn);
		}else{*/
			// 插入管理员信息
			dao.insertMinutesReader(bean.getM_minutes_id(),bean.getM_read_person_ids(), conn);
		//}
		

	}
	

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateMeetingMinutesReader
	  * @param minutesId
	  * @param userId 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingMinutesService#updateMeetingMinutesReader(java.lang.String, java.lang.String)
	 */
	public void updateMeetingMinutesReader(String minutesId, String userId) {
		if (StringUtil.nullOrBlank(minutesId) || StringUtil.nullOrBlank(userId)) {
			return;
		}
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MeetingMinutesReaderBean bean = new MeetingMinutesReaderBean();
			bean.setM_minutes_id(minutesId);
			bean.setM_user_id(userId);
			bean.setM_flag("1"); // 设置状态为已读
			bean.setM_read_time(new Timestamp(System.currentTimeMillis()));// 设置阅读时间
			bean.setUpdateKey("m_minutes_id", "m_user_id");
			// 更新
			((BaseDao) dao).update(bean, conn);
			// 提交事务
			conn.commit();
		} catch (Exception e) {
			// 回滚事务
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	


	
}

