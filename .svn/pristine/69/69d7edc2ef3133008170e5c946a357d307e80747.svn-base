package com.chinacreator.xtbg.core.meeting.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.note.services.NoteService;
import com.chinacreator.xtbg.core.common.note.services.impl.NoteServiceImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.MessageUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingAttenderDao;
import com.chinacreator.xtbg.core.meeting.dao.MeetingCheckStatusDao;
import com.chinacreator.xtbg.core.meeting.dao.MeetingDao;
import com.chinacreator.xtbg.core.meeting.dao.MeetingMsgLogDao;
import com.chinacreator.xtbg.core.meeting.dao.MeetingReceiverUnitDao;
import com.chinacreator.xtbg.core.meeting.dao.MeetingReceiverUserDao;
import com.chinacreator.xtbg.core.meeting.dao.MeetingTopicDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingCheckStatusBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingMsgLogBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoteTemplateBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeFlaglogBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUnitBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUserBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingTopicBean;
import com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc;
import com.chinacreator.xtbg.core.meeting.service.MeetingRoomService;
import com.chinacreator.xtbg.core.meeting.service.MeetingServiceIfc;
import com.chinacreator.xtbg.core.meeting.util.MeetingConstants;
import com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc;
import com.chinacreator.xtbg.core.personwork.service.impl.PersonInfoServiceImpl;
import com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc;
import com.chinacreator.xtbg.core.purviewmanager.service.impl.UserManagerServiceImpl;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;

/**
 * 
 *<p>Title:MeetingHandleServiceImpl.java</p>
 *<p>Description:议处理服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-24
 */
public class MeetingHandleServiceImpl implements MeetingHandleServiceIfc {

	private static final Log LOG = LogFactory.getLog(MeetingHandleServiceImpl.class);
	
	NoteService noteService = new NoteServiceImpl();
	UserManagerServiceIfc userManagerServiceIfc = new UserManagerServiceImpl();
	PersonInfoServiceIfc personInfoServiceIfc = new PersonInfoServiceImpl(); 
	
	
	/**
	*<b>Summary: </b>
	* getStr2AdminMsg(拼接一段发给会议室管理 的消息内容)
	* @param bean
	* @return 
	*/
	public String getStr2AdminMsg(MeetingNoticeBean bean){
		String str = "转发["+bean.getM_room_name().toString()+"]会议室管理员的消息|";
		return str;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 tempNotice 暂存
	  * @param meetingNoticeBean
	  * @param meetingTopicBeanList
	  * @param meetingMsgLogBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#tempNotice(com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean, java.util.List, com.chinacreator.xtbg.core.meeting.entity.MeetingMsgLogBean)
	 */
	public boolean tempNotice(MeetingNoticeBean meetingNoticeBean,
			List<MeetingTopicBean> meetingTopicBeanList,
			MeetingMsgLogBean meetingMsgLogBean) {
		
		//会议暂存步骤
		//1.保存会议基本信息
		//2.保存会议接收人与接收单位信息(保存时先删除再添加)
		//3.保存会议议题基本信息(保存时先删除再添加)
		//4.保存会议通知发送消息日志
		
		Connection conn = null;
		boolean flag = false;
		String m_notice_id = "";
		String m_id = "";
		String all_org_receiverusers = "";//所有机构接收人
		String receiver_user_ids = "";//会议接收人
		String receiver_unit_ids = "";//会议接收单位
		
		String[] receiverUseridArray = null;//接收人数组
		String[] AllOrgReceiverusersArray = null; //所有机构接收人数组
		
		MeetingReceiverUserBean meetingReceiverUserBean = null; //会议接收人Bean
		MeetingReceiverUnitBean meetingReceiverUnitBean = null; //会议接收单位Bean
		MeetingTopicBean meetingTopicBean = null; //会议议题Bean
		MeetingDao meetingDao = null;
		MeetingReceiverUserDao meetingReceiverUserDao = null;
		MeetingReceiverUnitDao meetingReceiverUnitDao = null;
		MeetingTopicDao meetingTopicDao = null;
		List<String> allUserReceiverUser = null;
		
		try {
			if(meetingNoticeBean != null) {
				conn = DbManager.getInstance().getTransactionConnection();
				meetingReceiverUserDao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUserDaoImpl");
				meetingReceiverUnitDao = (MeetingReceiverUnitDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUnitDaoImpl");
				meetingTopicDao = (MeetingTopicDao)LoadSpringContext.getApplicationContext().getBean("meetingTopicDaoImpl");
				meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
				
				m_notice_id = meetingNoticeBean.getM_notice_id();
				meetingReceiverUserBean = new MeetingReceiverUserBean();
				meetingReceiverUnitBean = new MeetingReceiverUnitBean();
				meetingTopicBean = new MeetingTopicBean();
				allUserReceiverUser = new ArrayList<String>(); 

				//1.保存会议基本信息
				meetingNoticeBean.setM_check_flag(MeetingConstants.STATUS_DRAFT);//暂存状态
				meetingNoticeBean.setM_check_flag_name("暂存");
				if(StringUtil.isBlank(m_notice_id)) {
					m_notice_id = StringUtil.getUUID();
					meetingNoticeBean.setM_notice_id(m_notice_id);
					((BaseDao)meetingDao).insert(meetingNoticeBean, conn);//保存会议基本信息
				} else {
					m_notice_id = meetingNoticeBean.getM_notice_id();
					((BaseDao)meetingDao).update(meetingNoticeBean, conn);//修改会议基本信息
					meetingReceiverUserBean.setDeleteKey("m_notice_id");
					((BaseDao)meetingDao).deleteListById(meetingReceiverUserBean, conn, m_notice_id);//删除会议接收人
					meetingReceiverUnitBean.setDeleteKey("m_notice_id");
					((BaseDao)meetingDao).deleteListById(meetingReceiverUnitBean, conn, m_notice_id);//删除会议接收单位
					meetingTopicBean.setDeleteKey("m_notice_id");
					((BaseDao)meetingDao).deleteListById(meetingTopicBean, conn, m_notice_id);//删除议题
				}
				
				receiver_user_ids = meetingNoticeBean.getM_receiver_user_ids();//会议接收人
				receiver_unit_ids = meetingNoticeBean.getM_receiver_unit_ids();//会议接收单位
				
				//保存接收单位信息
				all_org_receiverusers = meetingReceiverUnitDao.saveMeetingReceiverUnit(m_notice_id, receiver_unit_ids, "", conn);
				
				
				//将接收人转换成数组
				if(!StringUtil.isBlank(receiver_user_ids)) {
					receiverUseridArray = receiver_user_ids.split(",");
				}
				//将所有单位接收人转换成数组
				if(!StringUtil.isBlank(all_org_receiverusers)) {
					AllOrgReceiverusersArray = all_org_receiverusers.split(",");
				}
				allUserReceiverUser = StringUtil.romveRepeat(receiverUseridArray, AllOrgReceiverusersArray);//将通知公告接收人与单位接收人去重
				
				//保存接收人信息
				meetingReceiverUserDao.saveMeetingReceiverUser(m_notice_id, allUserReceiverUser, "", conn);
				
				//保存会议议题基本信息(保存时先删除再添加)
				if(meetingTopicBeanList!=null){
					meetingTopicDao.saveMeetingTopic(m_notice_id, meetingTopicBeanList, conn);
				}
				
				
				//保存会议通知发送消息日志
				if(meetingMsgLogBean != null) {
					m_id = meetingMsgLogBean.getM_id();
					meetingMsgLogBean.setM_msg_send_flag(MeetingConstants.STATUS_DRAFT);
					meetingMsgLogBean.setM_msg_send_flag_name("草稿");
					meetingMsgLogBean.setM_notice_id(m_notice_id);
					if(StringUtil.isBlank(m_id)) {
						meetingMsgLogBean.setM_id(StringUtil.getUUID());
						((BaseDao)meetingDao).insert(meetingMsgLogBean, conn);//保存会议消息
					} else {
						((BaseDao)meetingDao).update(meetingMsgLogBean, conn);//修改会议消息
					}
				}
			}
			flag = true;
			
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
	  *     复写方法 sentMeeting 送审
	  * @param meetingNoticeBean
	  * @param meetingTopicBeanList
	  * @param meetingMsgLogBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#sentMeeting(com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean, java.util.List, com.chinacreator.xtbg.core.meeting.entity.MeetingMsgLogBean)
	 */
	public boolean sentMeeting(MeetingNoticeBean meetingNoticeBean,
			List<MeetingTopicBean> meetingTopicBeanList,
			MeetingMsgLogBean meetingMsgLogBean) {
		//会议送审步骤
		//1.保存会议基本信息
		//2.保存会议接收人与接收单位信息(保存时先删除再添加)
		//3.保存会议议题基本信息(保存时先删除再添加)
		//4.保存会议通知发送消息日志
		//5.保存送审接收人
		
		Connection conn = null;
		boolean flag = false;
		String m_notice_id = "";
		String m_id = "";
		String all_org_receiverusers = "";//所有机构接收人
		String receiver_user_ids = "";//会议接收人
		String receiver_unit_ids = "";//会议接收单位
		String m_room_id = "";//会议室ID
		
		String[] receiverUseridArray = null;//接收人数组
		String[] AllOrgReceiverusersArray = null; //所有机构接收人数组
		
		MeetingReceiverUserBean meetingReceiverUserBean = null; //会议接收人Bean
		MeetingReceiverUnitBean meetingReceiverUnitBean = null; //会议接收单位Bean
		MeetingTopicBean meetingTopicBean = null; //会议议题Bean
		MeetingDao meetingDao = null;
		MeetingReceiverUserDao meetingReceiverUserDao = null;
		MeetingReceiverUnitDao meetingReceiverUnitDao = null;
		MeetingTopicDao meetingTopicDao = null;
		MeetingCheckStatusDao meetingCheckStatusDao = null;
		List<String> allUserReceiverUser = null;
		
		try {
			if(meetingNoticeBean != null) {
				conn = DbManager.getInstance().getTransactionConnection();
				meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
				meetingReceiverUserDao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUserDaoImpl");
				meetingReceiverUnitDao = (MeetingReceiverUnitDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUnitDaoImpl");
				meetingTopicDao = (MeetingTopicDao)LoadSpringContext.getApplicationContext().getBean("meetingTopicDaoImpl");
				meetingCheckStatusDao = (MeetingCheckStatusDao)LoadSpringContext.getApplicationContext().getBean("meetingCheckStatusDaoImpl");
				
				m_notice_id = meetingNoticeBean.getM_notice_id();
				m_room_id = meetingNoticeBean.getM_room_id();
				meetingReceiverUserBean = new MeetingReceiverUserBean();
				meetingReceiverUnitBean = new MeetingReceiverUnitBean();
				meetingTopicBean = new MeetingTopicBean();
				allUserReceiverUser = new ArrayList<String>(); 
				
				//1.保存会议基本信息
				meetingNoticeBean.setM_check_flag(MeetingConstants.STATUS_PENDING);//待审核  已送审 状态
				meetingNoticeBean.setM_check_flag_name("待审核");
				if(StringUtil.isBlank(m_notice_id)) {
					m_notice_id = StringUtil.getUUID();
					meetingNoticeBean.setM_notice_id(m_notice_id);
					((BaseDao)meetingDao).insert(meetingNoticeBean, conn);//保存会议基本信息
				} else {
					m_notice_id = meetingNoticeBean.getM_notice_id();
					((BaseDao)meetingDao).update(meetingNoticeBean, conn);//修改会议基本信息
					meetingReceiverUserBean.setDeleteKey("m_notice_id");
					((BaseDao)meetingDao).deleteListById(meetingReceiverUserBean, conn, m_notice_id);//删除会议接收人
					meetingReceiverUnitBean.setDeleteKey("m_notice_id");
					((BaseDao)meetingDao).deleteListById(meetingReceiverUnitBean,conn, m_notice_id);//删除会议接收单位
					meetingTopicBean.setDeleteKey("m_notice_id");
					((BaseDao)meetingDao).deleteListById(meetingTopicBean,conn, m_notice_id);//删除议题
				}
				
				receiver_user_ids = meetingNoticeBean.getM_receiver_user_ids();//会议接收人
				receiver_unit_ids = meetingNoticeBean.getM_receiver_unit_ids();//会议接收单位
				
				//保存接收单位信息
				all_org_receiverusers = meetingReceiverUnitDao.saveMeetingReceiverUnit(m_notice_id, receiver_unit_ids, "", conn);
				
				
				//将接收人转换成数组
				if(!StringUtil.isBlank(receiver_user_ids)) {
					receiverUseridArray = receiver_user_ids.split(",");
				}
				//将所有单位接收人转换成数组
				if(!StringUtil.isBlank(all_org_receiverusers)) {
					AllOrgReceiverusersArray = all_org_receiverusers.split(",");
				}
				allUserReceiverUser = StringUtil.romveRepeat(receiverUseridArray, AllOrgReceiverusersArray);//将通知公告接收人与单位接收人去重
				
				//保存接收人信息
				meetingReceiverUserDao.saveMeetingReceiverUser(m_notice_id, allUserReceiverUser, "", conn);
				
				//保存会议议题基本信息(保存时先删除再添加)
				if(meetingTopicBeanList!=null){
					meetingTopicDao.saveMeetingTopic(m_notice_id, meetingTopicBeanList, conn);
				}
				
				//保存会议通知发送消息日志
				if(meetingMsgLogBean != null) {
					m_id = meetingMsgLogBean.getM_id();
					meetingMsgLogBean.setM_msg_send_flag(MeetingConstants.MSG_DRAFT_SEND);
					meetingMsgLogBean.setM_msg_send_flag_name("草稿");
					meetingMsgLogBean.setM_notice_id(m_notice_id);
					if(StringUtil.isBlank(m_id)) {
						meetingMsgLogBean.setM_id(StringUtil.getUUID());
						((BaseDao)meetingDao).insert(meetingMsgLogBean, conn);//保存会议消息
					} else {
						((BaseDao)meetingDao).update(meetingMsgLogBean, conn);//修改会议消息
					}
				}
				
				//保存会议审批情况表
				meetingCheckStatusDao.saveMeetingCheckStatus(m_notice_id, m_room_id, conn);
				
			}
			flag = true;
			
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
	  *     复写方法 checkMeeting 审批
	  * @param checkState
	  * @param meetingNoticeBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#checkMeeting(java.lang.String, com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean)
	 */
	public boolean checkMeeting(String checkState,
			MeetingNoticeBean meetingNoticeBean) {
		Connection conn = null;
		boolean flag = false;
		MeetingDao meetingDao = null;
		MeetingCheckStatusDao meetingCheckStatusDao = null;
		MeetingCheckStatusBean meetingCheckStatusBean = null;
		MeetingNoticeFlaglogBean meetingNoticeFlaglogBean = null;
		String m_check_flag_name = "审核通过";
		if (MeetingConstants.STATUS_UNCHECKPASS.equalsIgnoreCase(checkState)){
			m_check_flag_name = "审核不通过";
		}
		try {
			
			if(meetingNoticeBean != null) {
				conn = DbManager.getInstance().getTransactionConnection();
				meetingCheckStatusBean = new MeetingCheckStatusBean();
				meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
				meetingCheckStatusDao = (MeetingCheckStatusDao)LoadSpringContext.getApplicationContext().getBean("meetingCheckStatusDaoImpl");
				
				meetingNoticeBean.setM_check_flag(checkState);
				meetingNoticeBean.setM_check_flag_name(m_check_flag_name);
				meetingNoticeBean.setM_check_time(new Timestamp(System.currentTimeMillis()));
				((BaseDao)meetingDao).update(meetingNoticeBean, conn);//修改会议基本信息
				//新增会议通知状态日志 begin
				meetingNoticeFlaglogBean = new MeetingNoticeFlaglogBean();
				meetingNoticeFlaglogBean.setM_id(StringUtil.getUUID());
				meetingNoticeFlaglogBean.setM_create_time(new Timestamp(System.currentTimeMillis()));
				meetingNoticeFlaglogBean.setM_notice_id(meetingNoticeBean.getM_notice_id());
				meetingNoticeFlaglogBean.setM_flag(checkState);
				meetingNoticeFlaglogBean.setM_create_user_id(meetingNoticeBean.getM_check_user_id());
				meetingNoticeFlaglogBean.setM_create_user_name(meetingNoticeBean.getM_check_user_name());
				((BaseDao)meetingDao).insert(meetingNoticeFlaglogBean, conn);
				//新增会议通知状态日志end
				
				meetingCheckStatusBean.setM_flag(MeetingConstants.STATUS_FALSE);//追回到暂存状态
				meetingCheckStatusBean.setUpdateKey("m_notice_id");
				((BaseDao)meetingCheckStatusDao).update(meetingCheckStatusBean, conn);//修改审批情况表
				
			}
			flag = true;
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
	*<b>Summary: </b>
	* checkreleaseMeeting(审核发布)
	* @param checkState
	* @param meetingNoticeBean
	* @param meetingMsgLogBean
	* @return 
	*/
	public boolean checkreleaseMeeting(String checkState,
			MeetingNoticeBean meetingNoticeBean,
			MeetingMsgLogBean meetingMsgLogBean) {
		Connection conn = null;
		boolean flag = false;
		String m_notice_id = "" ;
		String m_id = "" ;
        String all_org_receiverusers = "" ;//所有机构接收人
        String receiver_user_ids = "" ;//会议接收人
        String receiver_unit_ids = "" ;//会议接收单位
        
     
        
        String[] receiverUseridArray = null ;//接收人数组
        String[] AllOrgReceiverusersArray = null ; //所有机构接收人数组
        
        MeetingReceiverUserBean meetingReceiverUserBean = null ; //会议接收人Bean
        MeetingReceiverUnitBean meetingReceiverUnitBean = null ; //会议接收单位Bean

		MeetingDao meetingDao = null;
		MeetingReceiverUserDao meetingReceiverUserDao = null ;
        MeetingReceiverUnitDao meetingReceiverUnitDao = null ;

		MeetingCheckStatusDao meetingCheckStatusDao = null;
		MeetingCheckStatusBean meetingCheckStatusBean = null;
		
		List<String> allUserReceiverUser = null ;
		MeetingNoticeFlaglogBean meetingNoticeFlaglogBean = null;
		try {
			
			if(meetingNoticeBean != null) {
				conn = DbManager.getInstance().getTransactionConnection();
				meetingCheckStatusBean = new MeetingCheckStatusBean();
				meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
				meetingCheckStatusDao = (MeetingCheckStatusDao)LoadSpringContext.getApplicationContext().getBean("meetingCheckStatusDaoImpl");
				meetingReceiverUserDao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean( "meetingReceiverUserDaoImpl");
                meetingReceiverUnitDao = (MeetingReceiverUnitDao)LoadSpringContext.getApplicationContext().getBean( "meetingReceiverUnitDaoImpl");

                m_notice_id = meetingNoticeBean.getM_notice_id();
                meetingReceiverUserBean = new MeetingReceiverUserBean();
                meetingReceiverUnitBean = new MeetingReceiverUnitBean();
                allUserReceiverUser = new ArrayList<String>(); 
                
				meetingNoticeBean.setM_check_flag(MeetingConstants.STATUS_PUBLISHED);
				meetingNoticeBean.setM_check_flag_name("已发布");
				meetingNoticeBean.setM_check_time(new Timestamp(System.currentTimeMillis()));
				meetingNoticeBean.setM_current_time(new Timestamp(System.currentTimeMillis()));
				
				((BaseDao)meetingDao).update(meetingNoticeBean, conn);//修改会议基本信息
				//新增会议通知状态日志 begin
				meetingNoticeFlaglogBean = new MeetingNoticeFlaglogBean();
				meetingNoticeFlaglogBean.setM_id(StringUtil.getUUID());
				meetingNoticeFlaglogBean.setM_create_time(new Timestamp(System.currentTimeMillis()));
				meetingNoticeFlaglogBean.setM_notice_id(meetingNoticeBean.getM_notice_id());
				meetingNoticeFlaglogBean.setM_flag(checkState);
				meetingNoticeFlaglogBean.setM_create_user_id(meetingNoticeBean.getM_check_user_id());
				meetingNoticeFlaglogBean.setM_create_user_name(meetingNoticeBean.getM_check_user_name());
				((BaseDao)meetingDao).insert(meetingNoticeFlaglogBean, conn);
				//新增会议通知状态日志end
				
				meetingCheckStatusBean.setM_flag(MeetingConstants.STATUS_PUBLISHED);//发布状态
				meetingCheckStatusBean.setUpdateKey("m_notice_id");
				((BaseDao)meetingCheckStatusDao).update(meetingCheckStatusBean, conn);//修改审批情况表
				
				meetingReceiverUserBean.setDeleteKey("m_notice_id");
				((BaseDao)meetingDao).deleteListById(meetingReceiverUserBean, conn, m_notice_id);//删除会议接收人
				meetingReceiverUnitBean.setDeleteKey("m_notice_id");
				((BaseDao)meetingDao).deleteListById(meetingReceiverUnitBean,conn, m_notice_id);//删除会议接收单位
				
				//注意：审核只传了审核信息，故在这里再查一次数据库，拿到会议申请的信息
				meetingNoticeBean = this.getMeetingNoticeBeanById(m_notice_id);
				
				 //设置修改消息的状态
				if(meetingMsgLogBean!=null){
				String m_msg_type=meetingMsgLogBean.getM_msg_type();
				meetingNoticeBean.setIs_sms("0");
				meetingNoticeBean.setIs_msg("0");
				meetingNoticeBean.setIs_rtx("0");
				meetingNoticeBean.setIs_mail("0");
				if(!StringUtil.isBlank(m_msg_type)){
					String []msg_type=m_msg_type.split(",");
					//先置0
					for (String type : msg_type) {
						if("1".equals(type)){//短信
							meetingNoticeBean.setIs_sms("1");
						}
						if("2".equals(type)){//站内
							meetingNoticeBean.setIs_msg("1");
						}
						if("3".equals(type)){//及时
							meetingNoticeBean.setIs_rtx("1");
						}
						if("4".equals(type)){//邮件
							meetingNoticeBean.setIs_mail("1");
						}
					}
				}
				}
				
				receiver_user_ids = meetingNoticeBean.getM_receiver_user_ids();//会议接收人
				receiver_unit_ids = meetingNoticeBean.getM_receiver_unit_ids();//会议接收单位
				
				//保存接收单位信息
				all_org_receiverusers = meetingReceiverUnitDao.saveMeetingReceiverUnit(m_notice_id, receiver_unit_ids, "", conn);
				
				//将接收人转换成数组
				if(!StringUtil.isBlank(receiver_user_ids)) {
					receiverUseridArray = receiver_user_ids.split(",");
				}
				//将所有单位接收人转换成数组
				if(!StringUtil.isBlank(all_org_receiverusers)) {
					AllOrgReceiverusersArray = all_org_receiverusers.split(",");
				}
				allUserReceiverUser = StringUtil.romveRepeat(receiverUseridArray, AllOrgReceiverusersArray);//将通知公告接收人与单位接收人去重

				//保存接收人信息
				meetingReceiverUserDao.saveMeetingReceiverUser(m_notice_id, allUserReceiverUser, "", conn);
				
				//保存会议通知发送消息日志
				if(meetingMsgLogBean != null) {
					m_id = meetingMsgLogBean.getM_id();
					meetingMsgLogBean.setM_msg_send_flag(MeetingConstants.MSG_PUBLISHED_SEND);
					meetingMsgLogBean.setM_msg_send_flag_name("发布");
					meetingMsgLogBean.setM_notice_id(m_notice_id);
					if(StringUtil.isBlank(m_id)) {
						meetingMsgLogBean.setM_id(StringUtil.getUUID());
						((BaseDao)meetingDao).insert(meetingMsgLogBean, conn);//保存会议消息
					} else {
						((BaseDao)meetingDao).update(meetingMsgLogBean, conn);//修改会议消息
					}
					
					//发送相应消息
					MessageUtil util=new MessageUtil();
					
					if("1".equals(meetingNoticeBean.getIs_sms())){//短信
						util.sendSms(meetingMsgLogBean.getM_notice_id(),meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_check_user_id(), allUserReceiverUser,meetingNoticeBean.getM_other_user_input(),NoteConstants.SEND_MEETING, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_msg())){//站内
						util.sendMsg(meetingMsgLogBean.getM_contents(),meetingNoticeBean.getM_check_user_id(), allUserReceiverUser, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_rtx())){//及时
						util.sendRtx(meetingMsgLogBean.getM_contents(),meetingNoticeBean.getM_check_user_id(), allUserReceiverUser, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_mail())){//邮件
						util.sendMail(meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_check_user_id(), allUserReceiverUser, conn);
					}
					
					//给会议室管理员发通知 2014-04-01 begin +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					MeetingRoomService meetingRoomService = new MeetingRoomServiceImpl();
					List<String> list4RoomAdmin = new ArrayList<String>(); 
					String[] arr = meetingRoomService.queryToMeetingRoomBean(meetingNoticeBean.getM_room_id()).getAdministrator_ids().split(",");
					for(String str:arr){
						list4RoomAdmin.add(str);
					}
					String str2AdminMsg = getStr2AdminMsg(meetingNoticeBean);
					util.sendMsg(str2AdminMsg+meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), list4RoomAdmin, conn);
					//end +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				}
			}
			flag = true;
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
	  *     复写方法 recoverMeeting 追回
	  * @param m_notice_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#recoverMeeting(java.lang.String)
	 */
	public boolean recoverMeeting(String m_notice_id) {
		Connection conn = null;
		boolean flag = false;
		MeetingDao meetingDao = null;
		MeetingCheckStatusDao meetingCheckStatusDao = null;
		MeetingCheckStatusBean meetingCheckStatusBean = null;
		MeetingNoticeBean meetingNoticeBean = null;
		try {
			
			conn = DbManager.getInstance().getTransactionConnection();
			meetingCheckStatusBean = new MeetingCheckStatusBean();
			meetingNoticeBean = new MeetingNoticeBean();
			meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			meetingCheckStatusDao = (MeetingCheckStatusDao)LoadSpringContext.getApplicationContext().getBean("meetingCheckStatusDaoImpl");
			
			meetingNoticeBean.setM_check_flag(MeetingConstants.STATUS_DRAFT);
			meetingNoticeBean.setM_check_flag_name("暂存");
			meetingNoticeBean.setM_notice_id(m_notice_id);
			((BaseDao)meetingDao).update(meetingNoticeBean, conn);//修改会议基本状态
			
			
			meetingCheckStatusBean.setM_flag(MeetingConstants.STATUS_FALSE);//已审批
			meetingCheckStatusBean.setM_notice_id(m_notice_id);
			meetingCheckStatusBean.setDeleteKey("m_notice_id");
			((BaseDao)meetingCheckStatusDao).deleteListById(meetingCheckStatusBean, conn, m_notice_id);//删除审批情况
			flag = true;
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
	  *     复写方法 resendNotice 重发
	  * @param meetingNoticeBean
	  * @param meetingTopicBeanList
	  * @param meetingMsgLogBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#resendNotice(com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean, java.util.List, com.chinacreator.xtbg.core.meeting.entity.MeetingMsgLogBean)
	 */
	public boolean resendNotice(MeetingNoticeBean meetingNoticeBean,
			List<MeetingTopicBean> meetingTopicBeanList,
			MeetingMsgLogBean meetingMsgLogBean, String m_is_need_resignup) {
		//会议重发步骤
		//1.更新会议基本信息
		//2.保存会议接收人与接收单位信息(保存时先删除再添加)
		//3.保存会议议题基本信息(保存时先删除再添加)
		//4.保存会议通知发送消息日志
		//5.删除报名表
		Connection conn = null;
		boolean flag = false;
		String m_notice_id = "";
		String m_id = "";
		String all_org_receiverusers = "";//所有机构接收人
		String receiver_user_ids = "";//会议接收人
		String receiver_unit_ids = "";//会议接收单位
		
		String[] receiverUseridArray = null;//接收人数组
		String[] AllOrgReceiverusersArray = null; //所有机构接收人数组
		
		MeetingReceiverUserBean meetingReceiverUserBean = null; //会议接收人Bean
		MeetingReceiverUnitBean meetingReceiverUnitBean = null; //会议接收单位Bean
		MeetingTopicBean meetingTopicBean = null; //会议议题Bean
		MeetingDao meetingDao = null;
		MeetingReceiverUserDao meetingReceiverUserDao = null;
		MeetingReceiverUnitDao meetingReceiverUnitDao = null;
		MeetingTopicDao meetingTopicDao = null;
		List<String> allUserReceiverUser = null;
		
		MeetingNoticeFlaglogBean meetingNoticeFlaglogBean = null;
		m_notice_id = meetingNoticeBean.getM_notice_id();
		
		try {
			if(meetingNoticeBean != null && !StringUtil.isBlank(m_notice_id)) {
				conn = DbManager.getInstance().getTransactionConnection();
				meetingReceiverUserDao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUserDaoImpl");
				meetingReceiverUnitDao = (MeetingReceiverUnitDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUnitDaoImpl");
				meetingTopicDao = (MeetingTopicDao)LoadSpringContext.getApplicationContext().getBean("meetingTopicDaoImpl");
				meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
				
				meetingReceiverUserBean = new MeetingReceiverUserBean();
				meetingReceiverUnitBean = new MeetingReceiverUnitBean();
				meetingTopicBean = new MeetingTopicBean();
				allUserReceiverUser = new ArrayList<String>(); 

				//1.保存会议基本信息
				meetingNoticeBean.setM_check_flag(MeetingConstants.STATUS_REPUBLISHED);//重新发布状态
				meetingNoticeBean.setM_check_flag_name("重新发布");
				((BaseDao)meetingDao).update(meetingNoticeBean, conn);//修改会议基本信息
				//重发时选择  需要重新报名 为‘是’时 删除原来的 m_is_need_signup
				if (m_is_need_resignup.equalsIgnoreCase("1")){
					meetingReceiverUserBean.setDeleteKey("m_notice_id");
					((BaseDao)meetingDao).deleteListById(meetingReceiverUserBean, conn, m_notice_id);//删除会议接收人
					meetingReceiverUnitBean.setDeleteKey("m_notice_id");
					((BaseDao)meetingDao).deleteListById(meetingReceiverUnitBean, conn, m_notice_id);//删除会议接收单位
				}
				
				meetingTopicBean.setDeleteKey("m_notice_id");
				((BaseDao)meetingDao).deleteListById(meetingTopicBean, conn, m_notice_id);//删除议题
				
				receiver_user_ids = meetingNoticeBean.getM_receiver_user_ids();//会议接收人
				receiver_unit_ids = meetingNoticeBean.getM_receiver_unit_ids();//会议接收单位
				
				
				//重发时选择  需要重新报名  为‘是’时才插入记录，为否不删除，也不插入，保留原来 的  
				if (m_is_need_resignup.equalsIgnoreCase("1")){
					//保存接收单位信息
					all_org_receiverusers = meetingReceiverUnitDao.saveMeetingReceiverUnit(m_notice_id, receiver_unit_ids, "", conn);
				}
				
				
				//将接收人转换成数组
				if(!StringUtil.isBlank(receiver_user_ids)) {
					receiverUseridArray = receiver_user_ids.split(",");
				}
				//将所有单位接收人转换成数组
				if(!StringUtil.isBlank(all_org_receiverusers)) {
					AllOrgReceiverusersArray = all_org_receiverusers.split(",");
				}
				allUserReceiverUser = StringUtil.romveRepeat(receiverUseridArray, AllOrgReceiverusersArray);//将通知公告接收人与单位接收人去重
				
				//重发时选择  需要重新报名  为‘是’时才插入记录，为否不删除，也不插入，保留原来 的  
				if (m_is_need_resignup.equalsIgnoreCase("1")){
					//保存接收人信息
					meetingReceiverUserDao.saveMeetingReceiverUser(m_notice_id, allUserReceiverUser, "", conn);
				}
				
				//保存会议议题基本信息(保存时先删除再添加)
				if(meetingTopicBeanList!=null){
					meetingTopicDao.saveMeetingTopic(m_notice_id, meetingTopicBeanList, conn);
				}
				//保存会议通知发送消息日志
				if(meetingMsgLogBean != null) {
					m_id = meetingMsgLogBean.getM_id();
					meetingMsgLogBean.setM_msg_send_flag(MeetingConstants.MSG_RE_SEND);
					meetingMsgLogBean.setM_msg_send_flag_name("重发");
					meetingMsgLogBean.setM_notice_id(m_notice_id);
					if(StringUtil.isBlank(m_id)) {
						meetingMsgLogBean.setM_id(StringUtil.getUUID());
						((BaseDao)meetingDao).insert(meetingMsgLogBean, conn);//保存会议消息
					} else {
						((BaseDao)meetingDao).update(meetingMsgLogBean, conn);//修改会议消息
					}
					//发送相应消息
					MessageUtil util=new MessageUtil();
					//整合外部接收人
					String gg_ids = StringUtil.deNull(meetingNoticeBean.getM_receiver_other_unit_ids());//公共通讯录   
					String gr_ids = StringUtil.deNull(meetingNoticeBean.getM_receiver_other_user_ids());//个人通讯录
					String person_ids = "";
					if (!StringUtil.nullOrBlank(gg_ids) && !StringUtil.nullOrBlank(gr_ids)){
						person_ids = gg_ids+","+gr_ids;
					}else if (!StringUtil.nullOrBlank(gg_ids)){
						person_ids = gg_ids;
					}else if (!StringUtil.nullOrBlank(gr_ids)){
						person_ids = gr_ids;
					}
					if(!StringUtil.isBlank(person_ids)){
						String []personid=person_ids.split(",");
						for (String str : personid) {
							allUserReceiverUser.add(str);
						}
					}
					if("1".equals(meetingNoticeBean.getIs_sms())){//短信
						util.sendSms(meetingMsgLogBean.getM_notice_id(),meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), allUserReceiverUser,NoteConstants.SEND_MEETING,meetingNoticeBean.getM_other_user_input(), conn);
					}
					if("1".equals(meetingNoticeBean.getIs_msg())){//站内
						util.sendMsg(meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), allUserReceiverUser, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_rtx())){//及时
						util.sendRtx(meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), allUserReceiverUser, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_mail())){//邮件
						util.sendMail(meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), allUserReceiverUser, conn);
					}	
					//给会议室管理员发通知 2014-04-01 begin +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					MeetingRoomService meetingRoomService = new MeetingRoomServiceImpl();
					List<String> list4RoomAdmin = new ArrayList<String>(); 
					String[] arr = meetingRoomService.queryToMeetingRoomBean(meetingNoticeBean.getM_room_id()).getAdministrator_ids().split(",");
					for(String str:arr){
						list4RoomAdmin.add(str);
					}
					String str2AdminMsg = getStr2AdminMsg(meetingNoticeBean);
					util.sendMsg(str2AdminMsg+meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), list4RoomAdmin, conn);
					//end +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				}
				
				//新增会议通知状态日志 begin
				meetingNoticeFlaglogBean = new MeetingNoticeFlaglogBean();
				meetingNoticeFlaglogBean.setM_id(StringUtil.getUUID());
				meetingNoticeFlaglogBean.setM_create_time(new Timestamp(System.currentTimeMillis()));
				meetingNoticeFlaglogBean.setM_notice_id(meetingNoticeBean.getM_notice_id());
				meetingNoticeFlaglogBean.setM_flag(MeetingConstants.STATUS_REPUBLISHED);
				meetingNoticeFlaglogBean.setM_create_user_id(meetingNoticeBean.getM_update_user_id());
				meetingNoticeFlaglogBean.setM_create_user_name(meetingNoticeBean.getM_update_user_name());
				((BaseDao)meetingDao).insert(meetingNoticeFlaglogBean, conn);
				//新增会议通知状态日志end
			}
			flag = true;
			
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
	  *     复写方法 releaseMeeting 发布
	  * @param meetingNoticeBean
	  * @param meetingTopicBeanList
	  * @param meetingMsgLogBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#releaseMeeting(com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean, java.util.List, com.chinacreator.xtbg.core.meeting.entity.MeetingMsgLogBean)
	 */
	public boolean releaseMeeting(MeetingNoticeBean meetingNoticeBean,
			List<MeetingTopicBean> meetingTopicBeanList,
			MeetingMsgLogBean meetingMsgLogBean) {
		//会议发布步骤
		//1.保存会议基本信息
		//2.保存会议接收人与接收单位信息(保存时先删除再添加)
		//3.保存会议议题基本信息(保存时先删除再添加)
		//4.保存会议通知发送消息日志
		//5.短信发送
		Connection conn = null;
		boolean flag = false;
		String m_notice_id = "";
		String m_id = "";
		String all_org_receiverusers = "";//所有机构接收人
		String receiver_user_ids = "";//会议接收人
		String receiver_unit_ids = "";//会议接收单位
		
		String[] receiverUseridArray = null;//接收人数组
		String[] AllOrgReceiverusersArray = null; //所有机构接收人数组
		
		MeetingReceiverUserBean meetingReceiverUserBean = null; //会议接收人Bean
		MeetingReceiverUnitBean meetingReceiverUnitBean = null; //会议接收单位Bean
		MeetingTopicBean meetingTopicBean = null; //会议议题Bean
		MeetingDao meetingDao = null;
		MeetingReceiverUserDao meetingReceiverUserDao = null;
		MeetingReceiverUnitDao meetingReceiverUnitDao = null;
		MeetingTopicDao meetingTopicDao = null;
		List<String> allUserReceiverUser = null;
		MeetingNoticeFlaglogBean meetingNoticeFlaglogBean = null;
		
		try {
			if(meetingNoticeBean != null) {
				conn = DbManager.getInstance().getTransactionConnection();
				meetingReceiverUserDao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUserDaoImpl");
				meetingReceiverUnitDao = (MeetingReceiverUnitDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUnitDaoImpl");
				meetingTopicDao = (MeetingTopicDao)LoadSpringContext.getApplicationContext().getBean("meetingTopicDaoImpl");
				meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
				
				m_notice_id = meetingNoticeBean.getM_notice_id();
				meetingReceiverUserBean = new MeetingReceiverUserBean();
				meetingReceiverUnitBean = new MeetingReceiverUnitBean();
				meetingTopicBean = new MeetingTopicBean();
				allUserReceiverUser = new ArrayList<String>(); 

				//1.保存会议基本信息
				meetingNoticeBean.setM_check_flag(MeetingConstants.STATUS_PUBLISHED);//发布状态
				meetingNoticeBean.setM_check_flag_name("已发布");
				meetingNoticeBean.setM_current_time(new Timestamp(System.currentTimeMillis()));//发布人信息由前台带入
				
				if(!StringUtil.nullOrBlank(meetingNoticeBean.getM_notice_id())){//送审过
					((BaseDao)meetingDao).update(meetingNoticeBean, conn);//修改会议基本信息
				}else{
					meetingNoticeBean.setM_notice_id(StringUtil.getUUID());
					meetingNoticeBean.setM_create_time(new Timestamp(System.currentTimeMillis()));
					((BaseDao)meetingDao).insert(meetingNoticeBean, conn);//修改会议基本信息
				}
				
				m_notice_id = meetingNoticeBean.getM_notice_id();
				
				//新增会议通知状态日志 begin
				meetingNoticeFlaglogBean = new MeetingNoticeFlaglogBean();
				meetingNoticeFlaglogBean.setM_id(StringUtil.getUUID());
				meetingNoticeFlaglogBean.setM_create_time(new Timestamp(System.currentTimeMillis()));
				meetingNoticeFlaglogBean.setM_notice_id(meetingNoticeBean.getM_notice_id());
				meetingNoticeFlaglogBean.setM_flag(MeetingConstants.STATUS_PUBLISHED);
				meetingNoticeFlaglogBean.setM_create_user_id(meetingNoticeBean.getM_current_user_id());
				meetingNoticeFlaglogBean.setM_create_user_name(meetingNoticeBean.getM_current_user_name());
				((BaseDao)meetingDao).insert(meetingNoticeFlaglogBean, conn);
				//新增会议通知状态日志end 
				
				
				meetingReceiverUserBean.setDeleteKey("m_notice_id");
				((BaseDao)meetingDao).deleteListById(meetingReceiverUserBean, conn, m_notice_id);//删除会议接收人
				meetingReceiverUnitBean.setDeleteKey("m_notice_id");
				((BaseDao)meetingDao).deleteListById(meetingReceiverUnitBean,conn, m_notice_id);//删除会议接收单位
				meetingTopicBean.setDeleteKey("m_notice_id");
				((BaseDao)meetingDao).deleteListById(meetingTopicBean,conn, m_notice_id);//删除议题
				
				receiver_user_ids = meetingNoticeBean.getM_receiver_user_ids();//会议接收人
				receiver_unit_ids = meetingNoticeBean.getM_receiver_unit_ids();//会议接收单位
				
				//保存接收单位信息
				all_org_receiverusers = meetingReceiverUnitDao.saveMeetingReceiverUnit(m_notice_id, receiver_unit_ids, "", conn);
				
				
				//将接收人转换成数组
				if(!StringUtil.isBlank(receiver_user_ids)) {
					receiverUseridArray = receiver_user_ids.split(",");
				}
				//将所有单位接收人转换成数组
				if(!StringUtil.isBlank(all_org_receiverusers)) {
					AllOrgReceiverusersArray = all_org_receiverusers.split(",");
				}
				allUserReceiverUser = StringUtil.romveRepeat(receiverUseridArray, AllOrgReceiverusersArray);//将通知公告接收人与单位接收人去重
				
				//保存接收人信息
				meetingReceiverUserDao.saveMeetingReceiverUser(m_notice_id, allUserReceiverUser, "", conn);
				
				//保存会议议题基本信息(保存时先删除再添加)================
				if(meetingTopicBeanList!=null){
					meetingTopicDao.saveMeetingTopic(m_notice_id, meetingTopicBeanList, conn);
				}
				
				
				//保存会议通知发送消息日志
				if(meetingMsgLogBean != null) {
					m_id = meetingMsgLogBean.getM_id();
					meetingMsgLogBean.setM_msg_send_flag(MeetingConstants.MSG_PUBLISHED_SEND);
					meetingMsgLogBean.setM_msg_send_flag_name("发布");
					meetingMsgLogBean.setM_notice_id(m_notice_id);
					if(StringUtil.isBlank(m_id)) {
						meetingMsgLogBean.setM_id(StringUtil.getUUID());
						((BaseDao)meetingDao).insert(meetingMsgLogBean, conn);//保存会议消息
					} else {
						((BaseDao)meetingDao).update(meetingMsgLogBean, conn);//修改会议消息
					}
					//发送相应消息
					MessageUtil util=new MessageUtil();
					//整合外部接收人
					String gg_ids = StringUtil.deNull(meetingNoticeBean.getM_receiver_other_unit_ids());//公共通讯录   
					String gr_ids = StringUtil.deNull(meetingNoticeBean.getM_receiver_other_user_ids());//个人通讯录
					String person_ids = "";
					if (!StringUtil.nullOrBlank(gg_ids) && !StringUtil.nullOrBlank(gr_ids)){
						person_ids = gg_ids+","+gr_ids;
					}else if (!StringUtil.nullOrBlank(gg_ids)){
						person_ids = gg_ids;
					}else if (!StringUtil.nullOrBlank(gr_ids)){
						person_ids = gr_ids;
					}
					if(!StringUtil.isBlank(person_ids)){
						String []personid=person_ids.split(",");
						for (String str : personid) {
							allUserReceiverUser.add(str);
						}
					}
					
					if("1".equals(meetingNoticeBean.getIs_sms())){//短信
						util.sendSms(meetingMsgLogBean.getM_notice_id(),meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), allUserReceiverUser,NoteConstants.SEND_MEETING,meetingNoticeBean.getM_other_user_input(), conn);
					}
					if("1".equals(meetingNoticeBean.getIs_msg())){//站内
						util.sendMsg(meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), allUserReceiverUser, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_rtx())){//及时
						util.sendRtx(meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), allUserReceiverUser, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_mail())){//邮件
						util.sendMail(meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), allUserReceiverUser, conn);
					}	
					
					
					//给会议室管理员发通知 2014-04-01 begin +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					MeetingRoomService meetingRoomService = new MeetingRoomServiceImpl();
					List<String> list4RoomAdmin = new ArrayList<String>(); 
					String[] arr = meetingRoomService.queryToMeetingRoomBean(meetingNoticeBean.getM_room_id()).getAdministrator_ids().split(",");
					for(String str:arr){
						list4RoomAdmin.add(str);
					}
					String str2AdminMsg = getStr2AdminMsg(meetingNoticeBean);
					util.sendMsg(str2AdminMsg+meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), list4RoomAdmin, conn);
					//end +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				}
			}
			flag = true;
			
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
	  * <b>Summary: </b>
	  *     复写方法 reissueMeeting 会议补发
	  * @param meetingNoticeBean
	  * @param reissue_receiver_unit_names
	  * @param reissue_receiver_user_names
	  * @param reissue_receiver_unit_ids
	  * @param reissue_receiver_user_ids
	  * @param reissue_receiver_other_unit_names
	  * @param reissue_receiver_other_user_names
	  * @param reissue_receiver_other_unit_ids
	  * @param reissue_receiver_other_user_ids
	  * @param meetingTopicBeanList
	  * @param meetingMsgLogBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#reissueMeeting(com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.util.List, com.chinacreator.xtbg.core.meeting.entity.MeetingMsgLogBean) 
	  */
	public boolean reissueMeeting(MeetingNoticeBean meetingNoticeBean,
			String reissue_receiver_unit_names,
			String reissue_receiver_user_names,
			String reissue_receiver_unit_ids,
			String reissue_receiver_user_ids,
			String reissue_receiver_other_unit_names, 
			String reissue_receiver_other_user_names, 
			String reissue_receiver_other_unit_ids, 
			String reissue_receiver_other_user_ids,
			String m_other_user_input,
			MeetingMsgLogBean meetingMsgLogBean) {
		//会议补发步骤
		//1.保存会议接收人与接收单位信息
		//3.保存会议通知发送消息日志
		//4.短信发送
		Connection conn = null;
		boolean flag = false;
		String m_notice_id = "";
		String m_id = "";
		String all_org_receiverusers = "";//所有机构接收人
		
		//设置修改消息的状态
		if(meetingMsgLogBean!=null){
		String m_msg_type=meetingMsgLogBean.getM_msg_type();
		meetingNoticeBean.setIs_sms("0");
		meetingNoticeBean.setIs_msg("0");
		meetingNoticeBean.setIs_rtx("0");
		meetingNoticeBean.setIs_mail("0");
		if(!StringUtil.isBlank(m_msg_type)){
			String []msg_type=m_msg_type.split(",");
			//先置0
			for (String type : msg_type) {
				if("1".equals(type)){//短信
					meetingNoticeBean.setIs_sms("1");
				}
				if("2".equals(type)){//站内
					meetingNoticeBean.setIs_msg("1");
				}
				if("3".equals(type)){//及时
					meetingNoticeBean.setIs_rtx("1");
				}
				if("4".equals(type)){//邮件
					meetingNoticeBean.setIs_mail("1");
				}
			}
		}
		}
		MeetingDao meetingDao = null;
		MeetingReceiverUserDao meetingReceiverUserDao = null;
		MeetingReceiverUnitDao meetingReceiverUnitDao = null;
		List<String> allUserReceiverUser = null;
        String[] AllOrgReceiverusersArray = null ; //所有机构接收人数组
		try {
			if(meetingNoticeBean != null) {
				conn = DbManager.getInstance().getTransactionConnection();
				meetingReceiverUserDao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUserDaoImpl");
				meetingReceiverUnitDao = (MeetingReceiverUnitDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUnitDaoImpl");
				meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
				
				m_notice_id = meetingNoticeBean.getM_notice_id();
				allUserReceiverUser = new ArrayList<String>();
				
				//保存接收单位信息  --返回全部单位接收人
				all_org_receiverusers = meetingReceiverUnitDao.saveMeetingReceiverUnit(m_notice_id, reissue_receiver_unit_ids, MeetingConstants.BUFA , conn);
				if(!all_org_receiverusers.equalsIgnoreCase("")){
					reissue_receiver_user_ids = all_org_receiverusers+ "," + reissue_receiver_user_ids;
				}//没有就是传过来那些补发人
				//补发的
				if(!StringUtil.isBlank(reissue_receiver_user_ids)) {
					AllOrgReceiverusersArray = reissue_receiver_user_ids.split(",");
				}
				
				if(AllOrgReceiverusersArray!=null){
					for (int i = 0; i < AllOrgReceiverusersArray.length; i++) {
						if (!StringUtil.nullOrBlank(AllOrgReceiverusersArray[i])) {
							allUserReceiverUser.add(AllOrgReceiverusersArray[i]);
						}
					}
					//保存接收人信息
					meetingReceiverUserDao.saveMeetingReceiverUser(m_notice_id, allUserReceiverUser, MeetingConstants.BUFA, conn);
				}
				
				MeetingNoticeBean mnbean = new MeetingNoticeBean();
				mnbean.setM_notice_id(m_notice_id);
				
				//begin -- 有效补发人员添加更新到会议主表的与会人员字段    reissue_receiver_user_ids --------------
				if (!StringUtil.isBlank(reissue_receiver_user_ids)) {
					mnbean.setM_receiver_user_ids(meetingNoticeBean.getM_receiver_user_ids()+","+reissue_receiver_user_ids);
					String userids=mnbean.getM_receiver_user_ids();//1,2,17,18
					MeetingServiceIfc service=new MeetingServiceImpl();
					List<Map<String, String>> list=service.getReceiverUserNames(userids);
					String receiver_user_names="";
					if(list.size()>0){
						for (Map<String, String> map : list) {
							receiver_user_names+=map.get("org_name")+":"+map.get("user_names")+";";
						}
					}
					mnbean.setM_receiver_user_names(receiver_user_names);
				}
				
				if(!StringUtil.nullOrBlank(m_other_user_input)){//手输的单位补上
					if(!StringUtil.nullOrBlank(meetingNoticeBean.getM_other_user_input())){
						mnbean.setM_other_user_input(meetingNoticeBean.getM_other_user_input()+","+m_other_user_input);
					}else{
						mnbean.setM_other_user_input(m_other_user_input);
					}
				}
				
				if(!StringUtil.nullOrBlank(reissue_receiver_other_unit_ids)){//reissue_receiver_other_unit_ids=公共通讯录的人员
					if(!StringUtil.nullOrBlank(meetingNoticeBean.getM_receiver_other_unit_ids())){
						mnbean.setM_receiver_other_unit_ids(meetingNoticeBean.getM_receiver_other_unit_ids()+","+reissue_receiver_other_unit_ids);
						mnbean.setM_receiver_other_unit_names(meetingNoticeBean.getM_receiver_other_unit_names()+","+reissue_receiver_other_unit_names);
					}else{
						mnbean.setM_receiver_other_unit_ids(reissue_receiver_other_unit_ids);
						mnbean.setM_receiver_other_unit_names(reissue_receiver_other_unit_names);
					}
				}
				
				if(!StringUtil.nullOrBlank(reissue_receiver_other_user_ids)){//reissue_receiver_other_user_ids=个人通讯录的人员
					if(!StringUtil.nullOrBlank(meetingNoticeBean.getM_receiver_other_user_ids())){
						mnbean.setM_receiver_other_user_ids(meetingNoticeBean.getM_receiver_other_user_ids()+","+reissue_receiver_other_user_ids);
						mnbean.setM_receiver_other_user_names(meetingNoticeBean.getM_receiver_other_user_names()+","+reissue_receiver_other_user_names);
					}else{
						mnbean.setM_receiver_other_user_ids(reissue_receiver_other_user_ids);
						mnbean.setM_receiver_other_user_names(reissue_receiver_other_user_names);
					}
				}
				
				if(!StringUtil.nullOrBlank(reissue_receiver_unit_ids)){
					if(!StringUtil.nullOrBlank(meetingNoticeBean.getM_receiver_unit_ids())){
						mnbean.setM_receiver_unit_ids(meetingNoticeBean.getM_receiver_unit_ids()+","+reissue_receiver_unit_ids);
						mnbean.setM_receiver_unit_names(meetingNoticeBean.getM_receiver_unit_names()+","+reissue_receiver_unit_names);
					}else{
						mnbean.setM_receiver_unit_ids(reissue_receiver_unit_ids);
						mnbean.setM_receiver_unit_names(reissue_receiver_unit_names);
					}
					
				}
				
				((BaseDao)meetingDao).update(mnbean, conn);//修改会议参与人员字段
				//end ---------------------------------------------------------------------------------
				
				//保存会议通知发送消息日志
				if(meetingMsgLogBean != null) {
					m_id = meetingMsgLogBean.getM_id();
					if(StringUtil.isBlank(m_id)) {
						meetingMsgLogBean.setM_id(StringUtil.getUUID());
						((BaseDao)meetingDao).insert(meetingMsgLogBean, conn);//保存会议消息
					} else {
						((BaseDao)meetingDao).update(meetingMsgLogBean, conn);//修改会议消息
					}
					
					//发送相应消息
					MessageUtil util=new MessageUtil();
					
					if("1".equals(meetingNoticeBean.getIs_sms())){//短信
						util.sendSms(meetingMsgLogBean.getM_notice_id(),meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), allUserReceiverUser,meetingNoticeBean.getM_other_user_input(),NoteConstants.SEND_MEETING, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_msg())){//站内
						util.sendMsg(meetingMsgLogBean.getM_contents(),meetingNoticeBean.getM_current_user_id(), allUserReceiverUser, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_rtx())){//及时
						util.sendRtx(meetingMsgLogBean.getM_contents(),meetingNoticeBean.getM_current_user_id(), allUserReceiverUser, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_mail())){//邮件
						util.sendMail(meetingMsgLogBean.getM_contents(), meetingNoticeBean.getM_current_user_id(), allUserReceiverUser, conn);
					}	
				}
			}
			flag = true;
			
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
	  * <b>Summary: </b>
	  *     复写方法 callsendMeeting 催发
	  * @param m_notice_id
	  * @param userids
	  * @param unitids
	  * @param meetingMsgLogBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#callsendMeeting(java.lang.String, java.lang.String, java.lang.String, com.chinacreator.xtbg.core.meeting.entity.MeetingMsgLogBean) 
	  */
	public boolean callsendMeeting(String m_notice_id, String userids, String unitids, MeetingMsgLogBean meetingMsgLogBean, String users){
		Connection conn = null;
		boolean flag = false;
		String m_id = "";
		MeetingDao meetingDao = null;
		MeetingNoticeBean meetingNoticeBean = new MeetingNoticeBean();
		//设置修改消息的状态
		String m_msg_type=meetingMsgLogBean.getM_msg_type();
		meetingNoticeBean.setIs_sms("0");
		meetingNoticeBean.setIs_msg("0");
		meetingNoticeBean.setIs_rtx("0");
		meetingNoticeBean.setIs_mail("0");
		if(!StringUtil.isBlank(m_msg_type)){
			String []msg_type=m_msg_type.split(",");
			//先置0
			for (String type : msg_type) {
				if("1".equals(type)){//短信
					meetingNoticeBean.setIs_sms("1");
				}
				if("2".equals(type)){//站内
					meetingNoticeBean.setIs_msg("1");
				}
				if("3".equals(type)){//及时
					meetingNoticeBean.setIs_rtx("1");
				}
				if("4".equals(type)){//邮件
					meetingNoticeBean.setIs_mail("1");
				}
			}
		}
		
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			
			//更新用户催发信息
			if(!StringUtil.nullOrBlank(userids)){
				meetingDao.updateMeetingReceiver(conn, "oa_meeting_receiver_user", userids, meetingMsgLogBean.getM_msg_type());
			}
			if(!StringUtil.nullOrBlank(unitids)){
				meetingDao.updateMeetingReceiver(conn, "oa_meeting_receiver_unit", unitids, meetingMsgLogBean.getM_msg_type());
			}
			
			//保存会议通知发送消息日志
			if(meetingMsgLogBean != null) {
				if(StringUtil.isBlank(m_id)) {
					meetingMsgLogBean.setM_id(StringUtil.getUUID());
					((BaseDao)meetingDao).insert(meetingMsgLogBean, conn);//保存会议消息
				} else {
					((BaseDao)meetingDao).update(meetingMsgLogBean, conn);//修改会议消息
				}
				
				List<String> allUserReceiverUser=new ArrayList<String>();//消息接收人集合
				Map<String, String> map = new HashMap<String, String>(); 
				map = (HashMap <String, String>) this.getMeetingNoticeBean(m_notice_id);
				String []userid = users.replaceAll("'", "").split(",");
				if(userid.length>0){
					for (String id : userid) {
						allUserReceiverUser.add(id);
					}
				}
				//发送相应消息
				MessageUtil util=new MessageUtil();
				if("1".equals(meetingNoticeBean.getIs_sms())){//短信
					util.sendSms(meetingMsgLogBean.getM_notice_id(),meetingMsgLogBean.getM_contents(), StringUtil.deNull(map.get("m_current_user_id")), allUserReceiverUser, NoteConstants.SEND_MEETING,meetingNoticeBean.getM_other_user_input(),conn);
				}
				if("1".equals(meetingNoticeBean.getIs_msg())){//站内
					util.sendMsg(meetingMsgLogBean.getM_contents(), StringUtil.deNull(map.get("m_current_user_id")), allUserReceiverUser, conn);
				}
				if("1".equals(meetingNoticeBean.getIs_rtx())){//及时
					util.sendRtx(meetingMsgLogBean.getM_contents(), StringUtil.deNull(map.get("m_current_user_id")), allUserReceiverUser, conn);
				}
				if("1".equals(meetingNoticeBean.getIs_mail())){//邮件
					util.sendMail(meetingMsgLogBean.getM_contents(), StringUtil.deNull(map.get("m_current_user_id")), allUserReceiverUser, conn);
				}
				
			
			}
			flag = true;
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
	  * <b>Summary: </b>
	  *     复写方法 revocationMeeting 撤销
	  * @param m_notice_id
	  * @param meetingMsgLogBean
	  * @param m_user_id
	  * @param m_user_name
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#revocationMeeting(java.lang.String, com.chinacreator.xtbg.core.meeting.entity.MeetingMsgLogBean, java.lang.String, java.lang.String) 
	  */
	public boolean revocationMeeting(String m_notice_id, MeetingMsgLogBean meetingMsgLogBean,String m_user_id,String m_user_name) {
		Connection conn = null;
		boolean flag = false;
		String m_id = "";
		MeetingDao meetingDao = null;
		MeetingNoticeBean meetingNoticeBean = null;
		MeetingNoticeFlaglogBean meetingNoticeFlaglogBean = null;
		try {
				conn = DbManager.getInstance().getTransactionConnection();
				meetingNoticeBean = new MeetingNoticeBean();
				meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
				meetingNoticeBean.setM_notice_id(m_notice_id);
				meetingNoticeBean.setM_check_flag(MeetingConstants.STATUS_UNDONE);//撤销
				//设置修改消息的状态
				if(meetingMsgLogBean!=null){
				String m_msg_type=meetingMsgLogBean.getM_msg_type();
				meetingNoticeBean.setIs_sms("0");
				meetingNoticeBean.setIs_msg("0");
				meetingNoticeBean.setIs_rtx("0");
				meetingNoticeBean.setIs_mail("0");
				if(!StringUtil.isBlank(m_msg_type)){
					String []msg_type=m_msg_type.split(",");
					//先置0
					for (String type : msg_type) {
						if("1".equals(type)){//短信
							meetingNoticeBean.setIs_sms("1");
						}
						if("2".equals(type)){//站内
							meetingNoticeBean.setIs_msg("1");
						}
						if("3".equals(type)){//及时
							meetingNoticeBean.setIs_rtx("1");
						}
						if("4".equals(type)){//邮件
							meetingNoticeBean.setIs_mail("1");
						}
					}
				}
				}
				meetingNoticeBean.setM_check_flag_name("已撤销");
				((BaseDao)meetingDao).update(meetingNoticeBean, conn);//修改会议基本状态
				
				//保存会议通知发送消息日志
				if(meetingMsgLogBean != null) {
					m_id = meetingMsgLogBean.getM_id();
					meetingMsgLogBean.setM_msg_send_flag(MeetingConstants.MSG_DRAFT_SEND);//撤销就变草稿,再次编辑会议时默认撤销会议短信还是会显示在内容输入框中
					meetingMsgLogBean.setM_msg_send_flag_name("草稿");
					if(StringUtil.isBlank(m_id)) {
						meetingMsgLogBean.setM_id(StringUtil.getUUID());
						((BaseDao)meetingDao).insert(meetingMsgLogBean, conn);//保存会议消息
					} else {
						((BaseDao)meetingDao).update(meetingMsgLogBean, conn);//修改会议消息
					}
					
					List<String> allUserReceiverUser=new ArrayList<String>();//消息接收人集合
					Map<String, String> viewMap4MeetingNotice  = new HashMap<String, String>();
					viewMap4MeetingNotice = meetingDao.getMeetingNoticeBean(m_notice_id, conn);
					String []userid = viewMap4MeetingNotice.get("m_receiver_user_ids").split(",");
					if(userid.length>0){
						for (String id : userid) {
							allUserReceiverUser.add(id);
						}
					}
					
					//发送相应消息
					MessageUtil util=new MessageUtil();
					//整合外部接收人
					String gg_ids = StringUtil.deNull(meetingNoticeBean.getM_receiver_other_unit_ids());//公共通讯录   
					String gr_ids = StringUtil.deNull(meetingNoticeBean.getM_receiver_other_user_ids());//个人通讯录
					String person_ids = "";
					if (!StringUtil.nullOrBlank(gg_ids) && !StringUtil.nullOrBlank(gr_ids)){
						person_ids = gg_ids+","+gr_ids;
					}else if (!StringUtil.nullOrBlank(gg_ids)){
						person_ids = gg_ids;
					}else if (!StringUtil.nullOrBlank(gr_ids)){
						person_ids = gr_ids;
					}
					if(!StringUtil.isBlank(person_ids)){
						String []personid=person_ids.split(",");
						for (String str : personid) {
							allUserReceiverUser.add(str);
						}
					}
					if("1".equals(meetingNoticeBean.getIs_sms())){//短信
						util.sendSms(meetingMsgLogBean.getM_notice_id(),meetingMsgLogBean.getM_contents(), m_user_id, allUserReceiverUser, NoteConstants.SEND_MEETING,meetingNoticeBean.getM_other_user_input(),conn);
					}
					if("1".equals(meetingNoticeBean.getIs_msg())){//站内
						util.sendMsg(meetingMsgLogBean.getM_contents(), m_user_id, allUserReceiverUser, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_rtx())){//及时
						util.sendRtx(meetingMsgLogBean.getM_contents(), m_user_id, allUserReceiverUser, conn);
					}
					if("1".equals(meetingNoticeBean.getIs_mail())){//邮件
						util.sendMail(meetingMsgLogBean.getM_contents(), m_user_id, allUserReceiverUser, conn);
					}	
					
					
				}
				
				//新增会议通知状态日志 begin
				meetingNoticeFlaglogBean = new MeetingNoticeFlaglogBean();
				meetingNoticeFlaglogBean.setM_id(StringUtil.getUUID());
				meetingNoticeFlaglogBean.setM_create_time(new Timestamp(System.currentTimeMillis()));
				meetingNoticeFlaglogBean.setM_notice_id(meetingNoticeBean.getM_notice_id());
				meetingNoticeFlaglogBean.setM_flag(MeetingConstants.STATUS_UNDONE);
				meetingNoticeFlaglogBean.setM_create_user_id(m_user_id);
				meetingNoticeFlaglogBean.setM_create_user_name(m_user_name);
				((BaseDao)meetingDao).insert(meetingNoticeFlaglogBean, conn);
				//新增会议通知状态日志end 
				
				flag = true;
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
	  *     复写方法 viewMeetingDetail
	  * @param sourceState
	  * @param m_notice_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#viewMeetingDetail(java.lang.String, java.lang.String)
	 */
	public Map<String, Object> viewMeetingDetail(String sourceState,
			String m_notice_id) {
		Connection conn = null;
		Map<String, Object> mapObj  = null;
		Map<String, String> meetingNoticeBeanMap = null;
		List<Map<String, String>> meetingTopicBeanListMap = null;
		Map<String, String> meetingMsgLogMap = null;
		MeetingTopicDao meetingTopicDao = null;
		MeetingDao meetingDao = null;
		MeetingMsgLogDao meetingMsgLogDao = null;
		
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			meetingTopicDao = (MeetingTopicDao)LoadSpringContext.getApplicationContext().getBean("meetingTopicDaoImpl");
			meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			meetingMsgLogDao = (MeetingMsgLogDao)LoadSpringContext.getApplicationContext().getBean("meetingMsgLogDaoImpl");
			
			mapObj  = new HashMap<String, Object>();
			meetingNoticeBeanMap = new HashMap<String, String>();
			meetingTopicBeanListMap = new ArrayList<Map<String, String>>();
			meetingMsgLogMap = new HashMap<String, String>();
			
			meetingNoticeBeanMap = meetingDao.getMeetingNoticeBean(m_notice_id, conn);//查询会议基本信息
			meetingTopicBeanListMap = meetingTopicDao.getMeetingTopicBeanListMap(m_notice_id, conn);//查询会议议题信息
			meetingMsgLogMap = meetingMsgLogDao.getMeetingMsgLogMap(m_notice_id, "", conn);//查询消息信息
			mapObj.put("meetingNoticeBeanMap", meetingNoticeBeanMap);
			mapObj.put("meetingTopicBeanListMap", meetingTopicBeanListMap);
			mapObj.put("meetingMsgLogMap", meetingMsgLogMap);
			
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		
		return mapObj;
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 signupMeeting 会议报名
	  * @param signupState
	  * @param meetingReceiverUserBean
	  * @param meetingMsgLogBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#signupMeeting(java.lang.String, com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUserBean)
	 */
	public boolean signupMeeting(String signupState,
			MeetingReceiverUserBean meetingReceiverUserBean,
			MeetingMsgLogBean meetingMsgLogBean) {
		Connection conn = null;
		boolean flag = false;
		String m_receiver_id = "";
		String m_attender_ids = "";
		String m_receiver_unit_id = "";
		int uCounts = 0;
		MeetingReceiverUserDao meetingReceiverUserDao = null;
		MeetingReceiverUnitDao meetingReceiverUnitDao = null;
		MeetingReceiverUnitBean meetingReceiverUnitBean = null; //会议接收单位Bean
		MeetingAttenderDao meetingAttenderDao = null;
		MeetingDao meetingDao = null;
		try {
			if(meetingReceiverUserBean != null) {
				conn = DbManager.getInstance().getTransactionConnection();
				
				meetingReceiverUserDao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUserDaoImpl");
				meetingReceiverUnitDao = (MeetingReceiverUnitDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUnitDaoImpl");
				meetingAttenderDao = (MeetingAttenderDao)LoadSpringContext.getApplicationContext().getBean("meetingAttenderDaoImpl");
				meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");

				if(StringUtil.nullOrBlank(meetingReceiverUserBean.getM_is_read())){//第一次更新
					meetingReceiverUserBean.setM_is_read(MeetingConstants.STATUS_TRUE);
					meetingReceiverUserBean.setM_read_time(new Timestamp(System.currentTimeMillis()));
				}
				meetingReceiverUserBean.setM_reply_time(new Timestamp(System.currentTimeMillis()));
				((BaseDao)meetingReceiverUserDao).update(meetingReceiverUserBean, conn);//会议报名 
				
				m_receiver_id = meetingReceiverUserBean.getM_receiver_id();
				m_attender_ids = meetingReceiverUserBean.getM_attender_ids();
				meetingAttenderDao.saveMeetingAttender(m_receiver_id, m_attender_ids, conn);
				//报名的单位
				m_receiver_unit_id = meetingReceiverUserBean.getM_receiver_unit_id();
				uCounts = meetingReceiverUnitDao.isMeetingReceiverUnit(m_receiver_unit_id, conn);
				if(uCounts > 0) {
					meetingReceiverUnitBean = new MeetingReceiverUnitBean();
					meetingReceiverUnitBean.setM_is_reply(meetingReceiverUserBean.getM_is_reply());;
					meetingReceiverUnitBean.setM_reply(meetingReceiverUserBean.getM_reply());
					meetingReceiverUnitBean.setM_reply_time(meetingReceiverUserBean.getM_reply_time());
					meetingReceiverUnitBean.setM_link_user_id(meetingReceiverUserBean.getM_link_user_id());
					meetingReceiverUnitBean.setM_link_user_name(meetingReceiverUserBean.getM_link_user_name());
					meetingReceiverUnitBean.setM_link_tel(meetingReceiverUserBean.getM_link_tel());
					meetingReceiverUnitBean.setUpdateKey("m_receiver_unit_id");
					((BaseDao)meetingReceiverUnitDao).update(meetingReceiverUnitBean, conn);
				}
				
				//如果选择了2委托人参会或3安排人参会
				if(meetingReceiverUserBean.getM_is_reply().equalsIgnoreCase("2")||meetingReceiverUserBean.getM_is_reply().equalsIgnoreCase("3")){
					//给非本人发会议接收，即和联系人去重
					String strUsers = StringUtil.romveWeight(m_attender_ids, meetingReceiverUserBean.getM_link_user_id());
					String[] arrUsers =  strUsers.split(",");
					List<String> listUsers = null;
					if(arrUsers!=null){
						listUsers = new ArrayList<String>();;
						for (int i = 0; i < arrUsers.length; i++) {
							listUsers.add(arrUsers[i]);
						}
						//保存接收人信息
						if(listUsers!=null){
							meetingReceiverUserDao.saveMeetingReceiverUser(meetingReceiverUserBean.getM_notice_id(), listUsers, MeetingConstants.ZHUANGFA, conn);
							
							//调接口
							//给去重后的人发送消息或短信
							//保存会议通知发送消息日志
							if(meetingMsgLogBean != null) {
								meetingMsgLogBean.setM_id(StringUtil.getUUID());
								((BaseDao)meetingDao).insert(meetingMsgLogBean, conn);//保存会议消息
								
								//发送相应消息
								MessageUtil util=new MessageUtil();
								String is_sms="0";
								String is_msg="0";
								String is_rtx="0";
								String is_mail="0";
								
								String msg_type=meetingMsgLogBean.getM_msg_type();
								if(!StringUtil.isBlank( msg_type)){
									String []typelist=msg_type.split(",");
									for (int i = 0; i < typelist.length; i++) {
										if(typelist[i].equals("1")){
											is_sms="1";
										}
										if(typelist[i].equals("2")){
											is_msg="1";
										}
										if(typelist[i].equals("3")){
											is_rtx="1";
										}
										if(typelist[i].equals("4")){
											is_mail="1";
										}
									}
								}	
								
								if("1".equals(is_sms)){//短信
									util.sendSms(meetingMsgLogBean.getM_notice_id(),meetingMsgLogBean.getM_contents(),meetingReceiverUserBean.getM_link_user_id(), listUsers,NoteConstants.SEND_MEETING,"", conn);
								}
								if("1".equals(is_msg)){//站内
									util.sendMsg(meetingMsgLogBean.getM_contents(), meetingReceiverUserBean.getM_link_user_id(), listUsers, conn);
								}
								if("1".equals(is_rtx)){//及时
									util.sendRtx(meetingMsgLogBean.getM_contents(),meetingReceiverUserBean.getM_link_user_id(), listUsers, conn);
								}
								if("1".equals(is_mail)){//邮件
									util.sendMail(meetingMsgLogBean.getM_contents(), meetingReceiverUserBean.getM_link_user_id(), listUsers, conn);
								}
							
							}
						}
					}
					
				}
			}

			flag = true;
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
	  *     复写方法 viewMeeting
	  * @param m_notice_id
	  * @param m_receiver_id
	  * @param m_receiver_unit_id
	  * @param m_is_read
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#viewMeeting(java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	public Map<String, Object> viewMeeting(String m_notice_id, String m_receiver_id, String m_receiver_unit_id, String m_is_read) {
		Connection conn = null;
		int uCounts = 0;
		MeetingReceiverUserBean meetingReceiverUserBean = null;
		MeetingReceiverUnitBean meetingReceiverUnitBean = null; //会议接收单位Bean
		MeetingReceiverUserDao meetingReceiverUserDao = null;
		MeetingReceiverUnitDao meetingReceiverUnitDao = null;
		Map<String, String> meetingNoticeBeanMap = null;
		Map<String, Object> mapObj  = null;
		MeetingDao meetingDao = null;
		
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			mapObj  = new HashMap<String, Object>();
			meetingNoticeBeanMap = new HashMap<String, String>();
			
			meetingReceiverUserBean = new MeetingReceiverUserBean();
			
			meetingReceiverUserDao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUserDaoImpl");
			meetingReceiverUnitDao = (MeetingReceiverUnitDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUnitDaoImpl");
			meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			
			if(MeetingConstants.STATUS_FALSE.equals(m_is_read)) {
				meetingReceiverUserBean.setM_receiver_id(m_receiver_id);
				meetingReceiverUserBean.setM_is_read(MeetingConstants.STATUS_TRUE);
				meetingReceiverUserBean.setM_read_time(StringUtil.convertTimeToString(new Timestamp(new Date().getTime()), ""));
				((BaseDao)meetingReceiverUserDao).update(meetingReceiverUserBean, conn);//更改用户阅读状态
				
				uCounts = meetingReceiverUnitDao.isMeetingReceiverUnit(m_receiver_unit_id, conn);//查询用户所属的单位是否已阅读
				if(uCounts > 0) {
					meetingReceiverUnitBean = new MeetingReceiverUnitBean();
					meetingReceiverUnitBean.setM_is_read(MeetingConstants.STATUS_TRUE);
					meetingReceiverUnitBean.setM_read_time(StringUtil.convertTimeToString(new Timestamp(new Date().getTime()), ""));
					meetingReceiverUnitBean.setUpdateKey("m_receiver_unit_id");
					((BaseDao)meetingReceiverUnitDao).update(meetingReceiverUnitBean, conn);//更改单位阅读状态
				}
				
			}
			meetingNoticeBeanMap = meetingDao.getMeetingNoticeBean(m_notice_id, conn);//查询会议基本信息 
			mapObj.put("meetingNoticeBeanMap", meetingNoticeBeanMap);
			
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return mapObj;
	}


	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingNoticeBean
	  * @param m_notice_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#getMeetingNoticeBean(java.lang.String) 
	  */
	public Map<String, String> getMeetingNoticeBean(String m_notice_id){
		Connection conn = null;
		MeetingDao meetingDao = null;
		Map<String, String> meetingNoticeBeanMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			meetingNoticeBeanMap = new HashMap<String, String>();
			meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			meetingNoticeBeanMap = meetingDao.getMeetingNoticeBean(m_notice_id, conn);//查询会议基本信息 
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return meetingNoticeBeanMap;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingMsgLogMap
	  * @param m_notice_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#getMeetingMsgLogMap(java.lang.String) 
	  */
	public Map<String, String> getMeetingMsgLogMap(String m_notice_id){
		Connection conn = null;
		MeetingMsgLogDao meetingMsgLogDao = null;
		Map<String, String> map = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			map = new HashMap<String, String>();
			meetingMsgLogDao = (MeetingMsgLogDao)LoadSpringContext.getApplicationContext().getBean("meetingMsgLogDaoImpl");
			map = meetingMsgLogDao.getMeetingMsgLogMap(m_notice_id, this.getMeetingNoticeBeanById(m_notice_id).getM_check_flag(), conn);//查询会议基本信息 
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return map;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingTopicBeanListMap
	  * @param m_notice_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#getMeetingTopicBeanListMap(java.lang.String) 
	  */
	public List<Map<String, String>> getMeetingTopicBeanListMap(String m_notice_id){
		Connection conn = null;
		MeetingTopicDao meetingTopicDao = null;
		List<Map<String, String>> meetingTopicBeanListMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			meetingTopicBeanListMap = new ArrayList<Map<String, String>>();
			meetingTopicDao = (MeetingTopicDao)LoadSpringContext.getApplicationContext().getBean("meetingTopicDaoImpl");
			meetingTopicBeanListMap = meetingTopicDao.getMeetingTopicBeanListMap(m_notice_id, conn); 
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return meetingTopicBeanListMap;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingReceiverInfo
	  * @param m_notice_id
	  * @param m_user_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#getMeetingReceiverInfo(java.lang.String, java.lang.String) 
	  */
	public Map<String, String> getMeetingReceiverInfo(String m_notice_id, String m_user_id){
		Connection conn = null;
		MeetingReceiverUserDao dao = null;
		Map<String, String> map = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			map = new HashMap<String, String>();
			dao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUserDaoImpl");
			map = dao.findMeetingReceiverUserDetail(m_notice_id, m_user_id, conn); 
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return map;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateReadInfo
	  * @param m_receiver_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#updateReadInfo(java.lang.String) 
	  */
	public void updateReadInfo(String m_receiver_id){
		Connection conn = null;
		MeetingReceiverUserDao meetingReceiverUserDao = null;
		MeetingReceiverUserBean meetingReceiverUserBean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			meetingReceiverUserDao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUserDaoImpl");
			meetingReceiverUserBean = new MeetingReceiverUserBean();
			
			meetingReceiverUserBean.setM_receiver_id(m_receiver_id);
			meetingReceiverUserBean.setM_is_read(MeetingConstants.STATUS_TRUE);
			meetingReceiverUserBean.setM_read_time(new Timestamp(System.currentTimeMillis()));
			((BaseDao)meetingReceiverUserDao).update(meetingReceiverUserBean, conn);//更改用户阅读状态
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteMeeting
	  * @param m_notice_ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#deleteMeeting(java.lang.String) 
	  */
	public boolean deleteMeeting(String m_notice_ids){
		Connection conn = null;
		boolean flag = false;
		MeetingReceiverUserBean meetingReceiverUserBean = null; //会议接收人Bean
		MeetingReceiverUnitBean meetingReceiverUnitBean = null; //会议接收单位Bean
		MeetingTopicBean meetingTopicBean = null; //会议议题Bean
		MeetingNoticeBean meetingNoticeBean = null;
		MeetingDao meetingDao = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			meetingReceiverUserBean = new MeetingReceiverUserBean();
			meetingReceiverUnitBean = new MeetingReceiverUnitBean();
			meetingTopicBean = new MeetingTopicBean();
			meetingNoticeBean = new MeetingNoticeBean();
			meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			
			meetingReceiverUserBean.setDeleteKey("m_notice_id");
			((BaseDao)meetingDao).deleteListById(meetingReceiverUserBean, conn, m_notice_ids);//删除会议接收人
			meetingReceiverUnitBean.setDeleteKey("m_notice_id");
			((BaseDao)meetingDao).deleteListById(meetingReceiverUnitBean, conn, m_notice_ids);//删除会议接收单位
			meetingTopicBean.setDeleteKey("m_notice_id");
			((BaseDao)meetingDao).deleteListById(meetingTopicBean, conn, m_notice_ids);//删除议题
			meetingNoticeBean.setDeleteKey("m_notice_id");
			((BaseDao)meetingDao).deleteListById(meetingNoticeBean, conn, m_notice_ids);//删除会议
			
			flag =true;
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
	  * <b>Summary: </b>
	  *     复写方法 deleteListMeetingNoteTemplate
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#deleteListMeetingNoteTemplate(java.lang.String) 
	  */
	public String deleteListMeetingNoteTemplate(String ids) {
		// 数据库连接
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			if (StringUtil.nullOrBlank(ids)) {
				return "{\"flag\":\"false\",\"msg\":\"删除成功\"}";
			}
			MeetingDao dao = (MeetingDao) LoadSpringContext
					.getApplicationContext().getBean("meetingDaoImpl");
			String[] idArray = ids.split(",");
			// 可以被删除的id
			StringBuffer deleteIds = new StringBuffer();
			for (String id : idArray) {
				deleteIds.append(id + ",");
			}

			if (deleteIds.length() > 0) {
				String lastDeleteIds = deleteIds.substring(0, deleteIds
						.length() - 1);
				// 执行删除操作
				((BaseDao) dao).deleteListById(new MeetingNoteTemplateBean(), conn,
						lastDeleteIds);
			}
			String returnStr = "删除成功";
			// 要返回的json
			JSONObject json = new JSONObject();
			json.put("flag", "true");
			json.put("msg", returnStr);
			// 关闭连接并提交事务
			DbManager.closeTransactionConnection(conn, true);
			return json.toString();

		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.closeTransactionConnection(conn, true);
			LOG.error(e.getMessage(), e);
			return "{\"flag\":\"false\",\"msg\":\"删除失败\"}";
		}
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingNoteTemplateBeanById
	  * @param m_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#getMeetingNoteTemplateBeanById(java.lang.String) 
	  */
	public MeetingNoteTemplateBean getMeetingNoteTemplateBeanById(String m_id) {
		MeetingNoteTemplateBean model = new MeetingNoteTemplateBean();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			model.setM_id(m_id);
			MeetingDao dao = (MeetingDao) LoadSpringContext
					.getApplicationContext().getBean("meetingDaoImpl");
			model = (MeetingNoteTemplateBean) ((BaseDao)dao).queryToBean(model, conn);
			return model;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return model;
		}
	}
	
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateMeetingNoteTemplateBean
	  * @param json
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#updateMeetingNoteTemplateBean(java.lang.String) 
	  */
	public boolean updateMeetingNoteTemplateBean(String json) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MeetingDao dao = (MeetingDao) LoadSpringContext
					.getApplicationContext().getBean("meetingDaoImpl");

			// 将json字符串转换为对象
			MeetingNoteTemplateBean model = StringUtil.convertStringToBean(json,
					MeetingNoteTemplateBean.class);
			if(StringUtil.nullOrBlank(model.getM_id())){
				model.setM_id(StringUtil.getUUID());
				((BaseDao) dao).insert(model, conn);
			}else{
				((BaseDao) dao).update(model, conn);
			}
			// 更新操作
			
			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			return false;
		}
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingNoticeInfo
	  * @param m_notice_id
	  * @param m_receiver_user_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#getMeetingNoticeInfo(java.lang.String, java.lang.String) 
	  */
	public Map<String, String> getMeetingNoticeInfo(String m_notice_id, String m_receiver_user_id){
		Connection conn = null;
		MeetingDao dao = null;
		Map<String, String> map = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			map = new HashMap<String, String>();
			dao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			map = dao.getMeetingNoticeInfo(m_notice_id, m_receiver_user_id, conn); 
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return map;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getKbmDocBeanById 由主键m_notice_id得到MeetingNoticeBean
	  * @param m_notice_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc#getKbmDocBeanById(java.lang.String) 
	  */
	public MeetingNoticeBean getMeetingNoticeBeanById(String m_notice_id) {
		Connection conn = null;		
		MeetingNoticeBean model = new MeetingNoticeBean();
		MeetingDao meetingDao = null;
		try {
			conn = DbManager.getInstance().getConnection();	
			meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			model.setM_notice_id(m_notice_id);
			return (MeetingNoticeBean)((BaseDao)meetingDao).queryToBean(model,conn);			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return model;
	}
	
}
