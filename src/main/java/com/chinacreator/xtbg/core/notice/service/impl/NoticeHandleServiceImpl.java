package com.chinacreator.xtbg.core.notice.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.MessageUtil;
import com.chinacreator.xtbg.core.common.util.RequestBeanUtils;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dataresources.util.DataResourcesUtil;
import com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao;
import com.chinacreator.xtbg.core.notice.dao.NoticeReceiverUnitDao;
import com.chinacreator.xtbg.core.notice.dao.NoticeReceiverUserDao;
import com.chinacreator.xtbg.core.notice.entity.NoticeAuditBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeBaseInfoBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeMsgBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeReceiverUnitBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeReceiverUserBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeReportAuditBean;
import com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc;
import com.chinacreator.xtbg.core.notice.util.NoticeConstants;
import com.chinacreator.xtbg.core.sysparam.util.SysParamUitl;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;

/**
 * 
 *<p>Title:NoticeHandleServiceImpl.java</p>
 *<p>Description:通用公告处理服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-19
 */
public class NoticeHandleServiceImpl implements NoticeHandleServiceIfc {

	private static final Log LOG = LogFactory.getLog(NoticeHandleServiceImpl.class);
	private static final String  N_AUDIT_STATE ="2";//送审状态
	/**
	 * 
	*<b>Summary: </b>
	* handleNotic(通知公告处理)
	* @param noticeBaseInfoBean
	* @param noticReceiverUnitBeanList
	* @param noticReceiverUserBean
	* @param noticMsgBean
	* @return
	 */
	public boolean handleNotice(NoticeBaseInfoBean noticeBaseInfoBean, NoticeMsgBean noticMsgBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			NoticeBaseInfoDao noticeBaseInfoDao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
			NoticeReceiverUserDao noticeReceiverUserDao = (NoticeReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("noticeReceiverUserDaoImpl");
			NoticeReceiverUnitDao noticeReceiverUnitDao = (NoticeReceiverUnitDao)LoadSpringContext.getApplicationContext().getBean("noticeReceiverUnitDaoImpl");
			
			String n_notice_id = "";
			String audit_id ="";
			NoticeReceiverUserBean noticeReceiverUserBean = new NoticeReceiverUserBean();
			NoticeReceiverUnitBean noticeReceiverUnitBean = new NoticeReceiverUnitBean();
			NoticeAuditBean noticeAuditBean = new NoticeAuditBean();
			String n_is_sms=noticeBaseInfoBean.getN_is_sms();
			String n_is_mail=noticeBaseInfoBean.getN_is_mail();
			String n_is_msg=noticeBaseInfoBean.getN_is_msg();
			String n_is_rtx=noticeBaseInfoBean.getN_is_rtx();
			//审核接收人名字
			String n_audit_name = noticeBaseInfoBean.getN_audit_name();
			String n_audit_id = noticeBaseInfoBean.getN_audit_id();
			String n_audit_state_view = noticeBaseInfoBean.getN_audit_state_view();
			if(StringUtil.isBlank(n_is_sms)){
				n_is_sms="0";
			}
			if(StringUtil.isBlank(n_is_mail)){
				n_is_mail="0";
			}
			if(StringUtil.isBlank(n_is_msg)){
				n_is_msg="0";
			}
			if(StringUtil.isBlank(n_is_rtx)){
				n_is_rtx="0";
			}
			noticeBaseInfoBean.setN_is_sms(n_is_sms);
			noticeBaseInfoBean.setN_is_mail(n_is_mail);
			noticeBaseInfoBean.setN_is_msg(n_is_msg);
			noticeBaseInfoBean.setN_is_rtx(n_is_rtx);
			Map<String, String> noticeMap = RequestBeanUtils.transBean2Map(noticeBaseInfoBean);
			if(StringUtil.isBlank((String)noticeBaseInfoBean.getN_release_time())) {
				noticeBaseInfoBean.setN_release_time(null);
			} else {
				noticeBaseInfoBean.setN_release_time(StringUtil.convertStringToTimestamp(noticeBaseInfoBean.getN_release_time().toString()));
			}
			if(StringUtil.isBlank(noticeBaseInfoBean.getN_notice_id())) {
				n_notice_id = StringUtil.getUUID();
				noticeBaseInfoBean.setN_notice_id(n_notice_id);
				((BaseDao)noticeBaseInfoDao).insert(noticeBaseInfoBean, conn);//保存公告基本信息
			
			} else {
				n_notice_id = noticeBaseInfoBean.getN_notice_id();
				((BaseDao)noticeBaseInfoDao).update(noticeBaseInfoBean, conn);//修改公告基本信息
				//如果是审核状态才加入数据
				if(N_AUDIT_STATE.equals(noticeBaseInfoBean.getN_audit_state())){
					audit_id = StringUtil.getUUID();
					noticeAuditBean.setNotice_id(n_notice_id);
					noticeAuditBean.setId(audit_id);
					noticeAuditBean.setN_audit_state_view(n_audit_state_view); 
					noticeAuditBean.setN_view(noticeBaseInfoBean.getN_view());
					((BaseDao)noticeBaseInfoDao).insert(noticeAuditBean, conn);//保存公告审核意见
				}
				noticeReceiverUserBean.setDeleteKey("n_notice_id");
				((BaseDao)noticeBaseInfoDao).deleteListById(noticeReceiverUserBean, conn, noticeBaseInfoBean.getN_notice_id());//删除通知接收人
				noticeReceiverUnitBean.setDeleteKey("n_notice_id");
				((BaseDao)noticeReceiverUnitDao).deleteListById(noticeReceiverUnitBean, conn, noticeBaseInfoBean.getN_notice_id());//删除通知接收人
				noticMsgBean.setDeleteKey("n_notice_id");
				((BaseDao)noticeBaseInfoDao).deleteListById(noticMsgBean, conn, noticeBaseInfoBean.getN_notice_id());//删除消息表信息
			}
			//保存相应消息表信息
			//得到短信内容
			String code = SysParamUitl.getSysParamValueIsVALID(NoticeConstants.NOTICE_MSG);
			String n_msg_contents="";
			
        	if(!StringUtil.nullOrBlank(code)){
        		n_msg_contents = SysParamUitl.getSysParamValue(code);
            	List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(code);
            	if(!StringUtil.nullOrBlank(n_msg_contents) && listmap!=null && listmap.size()>0){
            		for (Map<String, String> map : listmap){
            			//System.out.println("map.get(\"p_value_name\")=="+map.get("p_value_name")+",map.get(\"p_value_code\")==="+map.get("p_value_code")+",kbmDocMap.get(map.get(\"p_value_code\"))=="+kbmDocMap.get(map.get("p_value_code")));
            			if(noticeMap!=null && noticeMap.size()>0 && !StringUtil.nullOrBlank(noticeMap.get(map.get("p_value_code")))){
            				n_msg_contents = n_msg_contents.replaceAll("【"+map.get("p_value_name")+"】",noticeMap.get(map.get("p_value_code")));
            			}
            		}
            	}	
        	}
        	noticMsgBean.setN_msgcontent(n_msg_contents);
			if("1".equals(n_is_sms)){//短信
				noticMsgBean.setN_msgid(StringUtil.getUUID());
				noticMsgBean.setN_notice_id(n_notice_id);
				noticMsgBean.setN_megtype("1");
				((BaseDao)noticeBaseInfoDao).insert(noticMsgBean, conn);
			}
			if("1".equals(n_is_msg)){//站内
				noticMsgBean.setN_msgid(StringUtil.getUUID());
				noticMsgBean.setN_notice_id(n_notice_id);
				noticMsgBean.setN_megtype("2");
				((BaseDao)noticeBaseInfoDao).insert(noticMsgBean, conn);
			}
			if("1".equals(n_is_rtx)){//及时
				noticMsgBean.setN_msgid(StringUtil.getUUID());
				noticMsgBean.setN_notice_id(n_notice_id);
				noticMsgBean.setN_megtype("3");
				((BaseDao)noticeBaseInfoDao).insert(noticMsgBean, conn);
			}
			if("1".equals(n_is_mail)){//邮件
				noticMsgBean.setN_msgid(StringUtil.getUUID());
				noticMsgBean.setN_notice_id(n_notice_id);
				noticMsgBean.setN_megtype("4");
				((BaseDao)noticeBaseInfoDao).insert(noticMsgBean, conn);
			}
			
			String unit_receiver_userids = ""; //单位接收人
			String all_org_receiverusers = "";//所有机构接收人
			String[] receiverUseridArray = null;//接收人数组
			String[] AllOrgReceiverusersArray = null; //所有机构接收人数组
			String[] n_receiver_orgidArray = null;//接收单位数组
			
			List<String> allUserReceiverUser = new ArrayList<String>(); 
			String receiverUserid = noticeBaseInfoBean.getN_receiver_userid();//通知公告接收人
			String receiverOrgid = noticeBaseInfoBean.getN_receiver_orgid();//通知公告接收单位
			
			//所有单位接收人拼接在一起
			if(!StringUtil.isBlank(receiverOrgid)) {
				n_receiver_orgidArray = receiverOrgid.split(",");
				for(int i = 0; i < n_receiver_orgidArray.length; i++) {
					
					noticeReceiverUnitBean = new NoticeReceiverUnitBean();
					noticeReceiverUnitBean.setN_receiver_unitid(StringUtil.getUUID());
					noticeReceiverUnitBean.setN_notice_id(n_notice_id);
					noticeReceiverUnitBean.setN_orgid(n_receiver_orgidArray[i]);
					noticeReceiverUnitBean.setN_orgname(DaoUtil.sqlToField("select org_name from td_sm_organization where org_id = '" + n_receiver_orgidArray[i] + "'"));
					((BaseDao)noticeReceiverUnitDao).insert(noticeReceiverUnitBean, conn);//保存公告基本信息
					// 获得单位接收人
					unit_receiver_userids = DataResourcesUtil.getDataResourcesRecipient(n_receiver_orgidArray[i], "noticeunitreson");
					if(!StringUtil.isBlank(unit_receiver_userids)) {
						all_org_receiverusers += "," + unit_receiver_userids;
					}
				}
			}
			if(!StringUtil.isBlank(receiverUserid)) {
				receiverUseridArray = receiverUserid.split(",");
				
			}
			
			if(!StringUtil.isBlank(all_org_receiverusers)) {
				AllOrgReceiverusersArray = all_org_receiverusers.split(",");
			}
			
			allUserReceiverUser = StringUtil.romveRepeat(receiverUseridArray, AllOrgReceiverusersArray);//将通知公告接收人与单位接收人去重
			
			
			for (int j = 0; j < allUserReceiverUser.size(); j++) {
				noticeReceiverUserBean = new NoticeReceiverUserBean();
				noticeReceiverUserBean.setN_receiverid(StringUtil.getUUID());
				noticeReceiverUserBean.setN_notice_id(n_notice_id);
				noticeReceiverUserBean.setN_receiver_userid(allUserReceiverUser.get(j));
				UserCacheBean userCacheBean = UserCache.getUserCacheBean(allUserReceiverUser.get(j));
				noticeReceiverUserBean.setN_receiver_username(userCacheBean.getUser_realname());
				noticeReceiverUserBean.setN_receiveruser_orgid(userCacheBean.getUnit_id());
				noticeReceiverUserBean.setN_receiveruser_orgname(userCacheBean.getUnit_name());
				((BaseDao)noticeReceiverUserDao).insert(noticeReceiverUserBean, conn);//保存用户接收人信息
			}
			
			//如果n_state是1即发布则给接收通告人发送消息提示
			if("1".equals(noticeBaseInfoBean.getN_state())){
				MessageUtil util=new MessageUtil();
				if("1".equals(n_is_sms)){//短信
					util.sendSms(noticeBaseInfoBean.getId(),n_msg_contents, noticeBaseInfoBean.getN_release_userid(), allUserReceiverUser,"",NoteConstants.SEND_NOTICE, conn);
				}
				if("1".equals(n_is_msg)){//站内
					util.sendMsg(n_msg_contents, noticeBaseInfoBean.getN_release_userid(), allUserReceiverUser, conn);
				}
				if("1".equals(n_is_rtx)){//及时
					util.sendRtx(n_msg_contents, noticeBaseInfoBean.getN_release_userid(), allUserReceiverUser, conn);
				}
				if("1".equals(n_is_mail)){//邮件
					util.sendMail(n_msg_contents, noticeBaseInfoBean.getN_release_userid(), allUserReceiverUser, conn);
				}
				// 添加待办信息（add by yin.liu 20131211）
//				util.sendMsgTodo(n_msg_contents, "notice", "", "1", noticeBaseInfoBean.getN_release_userid(), allUserReceiverUser, conn);
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
	  *     复写方法 getNoticeBaseInfoBean
	  * @param n_notice_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc#getNoticeBaseInfoBean(java.lang.String)
	 */
	public Map<String, String> getNoticeBaseInfoBean(String n_notice_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			NoticeBaseInfoDao noticeBaseInfoDao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
			viewMap = noticeBaseInfoDao.getNoticeBaseInfoBean(n_notice_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteNotice
	  * @param n_notice_ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc#deleteNotice(java.lang.String)
	 */
	public boolean deleteNotice(String n_notice_ids) {
		Connection conn = null;
		boolean flag = false;
		String[]  n_notice_idsArray = null;
		NoticeReceiverUserBean noticeReceiverUserBean = null;
		NoticeBaseInfoBean noticeBaseInfoBean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			NoticeBaseInfoDao noticeBaseInfoDao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
			if(!StringUtil.isBlank(n_notice_ids)) {
				n_notice_idsArray = n_notice_ids.split(",");
				for (int i = 0; i < n_notice_idsArray.length; i++) {
					noticeBaseInfoBean = new NoticeBaseInfoBean();
					noticeReceiverUserBean = new NoticeReceiverUserBean();
					noticeBaseInfoBean.setN_notice_id(n_notice_idsArray[i]);
					noticeReceiverUserBean.setN_notice_id(n_notice_idsArray[i]);
					noticeReceiverUserBean.setDeleteKey("n_notice_id");
					((BaseDao)noticeBaseInfoDao).deleteListById(noticeReceiverUserBean, conn, n_notice_idsArray[i]);//删除通知接收人
					((BaseDao)noticeBaseInfoDao).deleteListById(noticeBaseInfoBean, conn, n_notice_idsArray[i]);//删除公告主表信息
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
	  *     复写方法 selUserNoViewAndViewCount
	  * @param n_notice_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc#selUserNoViewAndViewCount(java.lang.String)
	 */
	public String selUserNoViewAndViewCount(String n_notice_id) {
		Connection conn = null;
		String noviewandview = "";
		try {
			conn = DbManager.getInstance().getConnection();
			NoticeBaseInfoDao noticeBaseInfoDao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
			noviewandview = noticeBaseInfoDao.selUserNoViewAndViewCount(n_notice_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		
		return noviewandview;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 cacelRelease
	  * @param n_notice_ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc#cacelRelease(java.lang.String)
	 */
	public boolean cacelRelease(String n_notice_ids) {
		Connection conn = null;
		boolean flag = false;
		String[]  n_notice_idsArray = null;
		NoticeBaseInfoBean noticeBaseInfoBean = null;
		NoticeReceiverUserBean noticeReceiverUserBean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			NoticeBaseInfoDao noticeBaseInfoDao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
			NoticeReceiverUserDao noticeReceiverUserDao = (NoticeReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("noticeReceiverUserDaoImpl");
			if(!StringUtil.isBlank(n_notice_ids)) {
				n_notice_idsArray = n_notice_ids.split(",");
				for (int i = 0; i < n_notice_idsArray.length; i++) {
					noticeBaseInfoBean = new NoticeBaseInfoBean();
					noticeBaseInfoBean.setN_notice_id(n_notice_idsArray[i]);
					noticeBaseInfoBean.setN_state("2");
					((BaseDao)noticeBaseInfoDao).update(noticeBaseInfoBean, conn);//修改公告状态
					
					noticeReceiverUserBean = new NoticeReceiverUserBean();
					noticeReceiverUserBean.setN_notice_id(n_notice_idsArray[i]);
					noticeReceiverUserBean.setUpdateKey("n_notice_id");
					noticeReceiverUserBean.setN_isview("2");
					((BaseDao)noticeReceiverUserDao).update(noticeReceiverUserBean, conn);//修改接收人的状态
				}
			}
			
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateNoticeReceiverUserState
	  * @param n_receiverid 
	  * @see com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc#updateNoticeReceiverUserState(java.lang.String)
	 */
	public void updateNoticeReceiverUserState(String n_receiverid) {
		Connection conn = null;
		NoticeReceiverUserBean noticeReceiverUserBean = null;
		String is_view = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			noticeReceiverUserBean = new NoticeReceiverUserBean();
			NoticeReceiverUserDao noticeReceiverUserDao = (NoticeReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("noticeReceiverUserDaoImpl");
			noticeReceiverUserBean.setN_receiverid(n_receiverid);
			noticeReceiverUserBean.setN_isview("1");
			
			is_view = noticeReceiverUserDao.getNoticeViewState(n_receiverid, conn);
			if(!"2".equals(is_view)) {
				((BaseDao)noticeReceiverUserDao).update(noticeReceiverUserBean, conn);//修改公告状态
			}

		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteNoticeReceiverUser
	  * @param n_receiverids
	  * @return 
	  * @see com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc#deleteNoticeReceiverUser(java.lang.String)
	 */
	public boolean deleteNoticeReceiverUser(String n_receiverids) {
		Connection conn = null;
		boolean flag = false;
		String[]  n_receiveridsArray = null;
		NoticeReceiverUserBean noticeReceiverUserBean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			NoticeReceiverUserDao noticeReceiverUserDao = (NoticeReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("noticeReceiverUserDaoImpl");
			if(!StringUtil.isBlank(n_receiverids)) {
				n_receiveridsArray = n_receiverids.split(",");
				for (int i = 0; i < n_receiveridsArray.length; i++) {
					noticeReceiverUserBean = new NoticeReceiverUserBean();
					noticeReceiverUserBean.setN_receiverid(n_receiveridsArray[i]);
					noticeReceiverUserBean.setN_isdel("1");
					((BaseDao)noticeReceiverUserDao).update(noticeReceiverUserBean, conn);//删除接收人的公告
				}
			}
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return flag;
	}

	@Override
	public Map<String, String> getNoticeIsAuditBaseInfoBean(String n_notice_id,String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			NoticeBaseInfoDao noticeBaseInfoDao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
			viewMap = noticeBaseInfoDao.getNoticeIsAuditBaseInfoBean(n_notice_id,id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return viewMap;
	}

	@Override
	public List<NoticeAuditBean> getNoticeAuditBeanView(String n_notice_id) {
		
		Connection conn = null;
		List<NoticeAuditBean> viewlist = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewlist = new ArrayList<NoticeAuditBean>();
			NoticeBaseInfoDao noticeBaseInfoDao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
			viewlist = noticeBaseInfoDao.getNoticeAuditBeanView(n_notice_id,conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return viewlist;
	}
	
	/**
	*<b>Summary: </b>
	* findInfoReportAudit(根据评论ID 查询评论信息)
	* @param report_id
	* @return
	 */
	public  Map<String,String> findInfoReportAudit(String report_id){
		
		Connection conn = null;
		Map<String,String> bean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			 bean = new  HashMap<String,String>();
			NoticeBaseInfoDao noticeBaseInfoDao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
			 bean = noticeBaseInfoDao.getNoticeReportAuditBean(report_id,conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return  bean;
	}
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateNoticeReportBean(增加和修改评论信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateNoticeReportBean(NoticeReportAuditBean bean){
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			NoticeBaseInfoDao dao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
			//1:设置时间REPORT_TIME
			bean.setReport_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getReport_time()), "yyyy-MM-dd HH24:mi:ss"));
			if(StringUtil.nullOrBlank(bean.getReport_id())){//insert
				beanId = StringUtil.getUUID();
				bean.setReport_id(beanId);
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getReport_id();
				((BaseDao)dao).update(bean, conn);
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}
	
	/**
	*<b>Summary: </b>
	* deleteNoticeReportBeanByid(根据评论ID 删除评论信息)
	* @param bean
	* @return
	 */
	public String deleteNoticeReportBeanByid(String[] bean_ids){
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			NoticeBaseInfoDao dao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
			for (String beanId : bean_ids) {
				dao.deleteNoticeReportsById(beanId,conn);
			}
			conn.commit();
			flag = "true";
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}
