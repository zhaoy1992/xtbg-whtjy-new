package com.chinacreator.xtbg.core.paper.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.NoteService;
import com.chinacreator.xtbg.core.common.note.services.impl.NoteServiceImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.paper.dao.PaperMakeNoticeDao;
import com.chinacreator.xtbg.core.paper.entity.PaperMakeNoticeBean;
import com.chinacreator.xtbg.core.paper.entity.PaperReceiveNoticeBean;
import com.chinacreator.xtbg.core.paper.service.PaperMakeNoticeService;
import com.chinacreator.xtbg.core.paper.util.PaperConstants;
import com.chinacreator.xtbg.core.paper.util.PaperUtil;
import com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc;
import com.chinacreator.xtbg.core.purviewmanager.service.impl.UserManagerServiceImpl;
/**
 * 
 *<p>Title:PaperMakeNoticeServiceImpl.java</p>
 *<p>Description:约稿通知服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-12
 */
public class PaperMakeNoticeServiceImpl implements PaperMakeNoticeService {

	private static final Log LOG=LogFactory.getLog(PaperMakeNoticeServiceImpl.class);
	/**
	 * 
	  * <b>Summary: 保存约稿通知信息</b>
	  *     复写方法 savePaperMakeNotice
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperMakeNoticeService#savePaperMakeNotice(com.chinacreator.xtbg.core.paper.entity.PaperMakeNoticeBean)
	 */
	public boolean savePaperMakeNotice(PaperMakeNoticeBean bean) {
		Connection conn = null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperMakeNoticeDao dao=(PaperMakeNoticeDao)LoadSpringContext.getApplicationContext().getBean("paperMakeNoticeDaoImpl");
			//1:设置时间
			Timestamp time= StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(), "yyyy-MM-dd HH24:mi:ss");
			bean.setP_create_time(time);
			bean.setP_send_time(time);
			String p_notice_id=StringUtil.getUUID();
			bean.setP_notice_id(p_notice_id);
			String p_msg_type="";
			if(!StringUtil.isBlank(bean.getP_msg_type1())){
				p_msg_type=p_msg_type+bean.getP_msg_type1()+",";
			}
			if(!StringUtil.isBlank(bean.getP_msg_type2())){
				p_msg_type=p_msg_type+bean.getP_msg_type2();
			}
			bean.setP_msg_type(p_msg_type);
			//保存约稿通知信息
			((BaseDao)dao).insert(bean, conn);
			
			//保存相应约稿通知接收信息
			String[] unitids =bean.getP_unit_id().split(",");
			String[] unitnames=bean.getP_unit_name().split(",");
			for (int i = 0; i < unitids.length; i++) {
				PaperReceiveNoticeBean receivebean=new PaperReceiveNoticeBean();
				receivebean.setP_receive_id(StringUtil.getUUID());
				receivebean.setP_notice_id(p_notice_id);
				receivebean.setP_title(bean.getP_title());
				receivebean.setP_receive_unit_id(unitids[i]);
				receivebean.setP_receive_unit_name(unitnames[i]);
				receivebean.setP_read_status("0");
				((BaseDao)dao).insert(receivebean, conn);
			}
			//发短信
			if(!StringUtil.isBlank(bean.getP_msg_type1())){
				
				PaperUtil paperutil=new PaperUtil();
				for (String unit_id : unitids) {
					List<Map<String, String>>  userids=new ArrayList<Map<String,String>>();
					userids=paperutil.getPersonbyOrgrole(conn, unit_id, PaperConstants.PAPER_UNIT_RECEIVEROLE);
					String user_ids="";
					for (int i = 0; i < userids.size(); i++) {
						user_ids+=userids.get(i).get("user_id")+",";
					}
					if(!StringUtil.isBlank(user_ids)){
						user_ids=user_ids.substring(0, user_ids.length()-1);
						bean.setP_update_user_id(user_ids);
						sendMakeNoticeMsg(bean);
					}
				}
			}
			
			conn.commit();
			flag=true;
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
	  * <b>Summary: 根据id查询约稿通知信息</b>
	  *     复写方法 getMakeNoticeBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperMakeNoticeService#getMakeNoticeBean(java.lang.String)
	 */
	public Map<String, String> getMakeNoticeBean(String id) {
		Connection conn=null;
		Map<String, String> map=new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperMakeNoticeDao dao=(PaperMakeNoticeDao)LoadSpringContext.getApplicationContext().getBean("paperMakeNoticeDaoImpl");
			map = dao.getMakeNoticeBean(conn, id);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return map;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 sendMakeNoticeMsg
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperMakeNoticeService#sendMakeNoticeMsg(com.chinacreator.xtbg.core.paper.entity.PaperMakeNoticeBean)
	 */
	public boolean sendMakeNoticeMsg(PaperMakeNoticeBean bean) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			
			//发短信-----------------------------------------------------begin
        	NoteBufferBean noteBufferBean = new NoteBufferBean();
        	NoteDetailBean noteDetailBean = null;
        	List<NoteDetailBean> detailList = new ArrayList<NoteDetailBean>();; 
        	
        	noteBufferBean.setContent(bean.getP_msg_contents());
        	noteBufferBean.setUser_id(bean.getP_create_user_id());
        	noteBufferBean.setUser_name(bean.getP_create_user_name());
        	String buffer_id = StringUtil.getUUID();
        	noteBufferBean.setBuffer_id(buffer_id);
        	
        	//给上传人发短信-----------------
        	
        	Map<String, String> userMap = new HashMap<String, String>();
        	UserManagerServiceIfc userManagerServiceIfc = new UserManagerServiceImpl();
        	NoteService noteService = new NoteServiceImpl();
        	String[]  ids=bean.getP_update_user_id().split(",");
        	for (String id : ids) {
        		userMap = userManagerServiceIfc.getUserBean(id);
        		String phone="";
        		if(StringUtil.nullOrBlank(userMap.get("user_mobiletel1"))){
        			phone=userMap.get("user_mobiletel2");
        		}else{
        			phone=userMap.get("user_mobiletel1");
        		}
        		if(!StringUtil.nullOrBlank(phone)){
        			noteDetailBean = new NoteDetailBean();
        			noteDetailBean.setRecv_id(StringUtil.getUUID());
        			noteDetailBean.setBuffer_id(buffer_id);
        			noteDetailBean.setUser_id(userMap.get("user_id"));
        			noteDetailBean.setUser_name(userMap.get("user_realname"));
        			noteDetailBean.setPhone_num(phone);
        			detailList.add(noteDetailBean);
        		}
			}
        	if(noteBufferBean!=null && detailList!=null && detailList.size()>0){
        		flag = noteService.doNoteSend(noteBufferBean, detailList, conn);
        	}else{
        		flag=true;
        	}
        	//发短信-----------------------------------------------------end
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}
