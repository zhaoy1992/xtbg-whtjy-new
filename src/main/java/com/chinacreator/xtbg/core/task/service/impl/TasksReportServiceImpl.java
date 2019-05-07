package com.chinacreator.xtbg.core.task.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.MessageUtil;
import com.chinacreator.xtbg.core.common.util.RequestBeanUtils;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.sysparam.util.SysParamUitl;
import com.chinacreator.xtbg.core.task.dao.TasksReportDao;
import com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean;
import com.chinacreator.xtbg.core.task.entity.TaskMsgBean;
import com.chinacreator.xtbg.core.task.entity.TaskReportBean;
import com.chinacreator.xtbg.core.task.service.TasksReportServiceIfc;
import com.chinacreator.xtbg.core.task.util.TaskConstant;

/**
 * 
 *<p>Title:TasksReportServiceImpl.java</p>
 *<p>Description:保存回复信息</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-11
 */
public class TasksReportServiceImpl implements TasksReportServiceIfc {

	public static final Logger LOG = Logger.getLogger(TasksReportServiceImpl.class.getName());
	private TasksReportDao dao = null;

	/**
	 * 
	  * <b>Summary: </b>
	  *     构造一个 TasksReportServiceImpl  
	   * <b>Remarks: </b>
	  *     构造类 TasksReportServiceImpl 的构造函数 TasksReportServiceImpl
	 */
	public TasksReportServiceImpl() {
		this.dao = (TasksReportDao) LoadSpringContext.getApplicationContext()
				.getBean("tasksReportDaoImpl");
	}
	
	/**
	 * 
	*<b>Summary:保存回复信息 </b>
	* insertTaskReport()
	* @param bean
	* @return
	 */
	@Override
	public boolean insertTaskReport(TaskReportBean bean){
		Connection con = null;
		try {
			if(null == bean){
				return false;
			}
			
			//得到任务信息
			TasksAssignedServiceImpl service=new TasksAssignedServiceImpl();
			TaskBaseInfoBean taskbean= service.queryToTaskBaseInfoBean(bean.getTask_id());
			bean.setTask_name(taskbean.getTask_name());
			
			String is_sms=bean.getIs_sms();
			String is_mail=bean.getIs_mail();
			String is_msg=bean.getIs_msg();
			String is_rtx=bean.getIs_rtx();
			if(StringUtil.isBlank(is_sms)){
				is_sms="0";
			}
			if(StringUtil.isBlank(is_mail)){
				is_mail="0";
			}
			if(StringUtil.isBlank(is_msg)){
				is_msg="0";
			}
			if(StringUtil.isBlank(is_rtx)){
				is_rtx="0";
			}
			bean.setIs_sms(is_sms);
			bean.setIs_mail(is_mail);
			bean.setIs_msg(is_msg);
			bean.setIs_rtx(is_rtx);
			Map<String, String> taskMap = RequestBeanUtils.transBean2Map(bean);
			
			con = DbManager.getInstance().getTransactionConnection();
			//上报信息设置id
			String id=StringUtil.getUUID();
			bean.setId(id);
			//状态设置为未回复
			bean.setType("0");
			
			//上报信息赋值上报时间
			bean.setReport_time(new Timestamp(System.currentTimeMillis()));
			((BaseDao) dao).insert(bean,con);
			
			//更新任务状态为处理中
			TaskBaseInfoBean baseInfo = new TaskBaseInfoBean();
			baseInfo.setId(bean.getTask_id());
			baseInfo.setTask_status(TaskConstant.STATUS_DOING);//状态设置为处理中
			//更新
			((BaseDao) dao).update(baseInfo,con);
			
			//保存相应消息表信息
			//得到短信内容
			String code = SysParamUitl.getSysParamValueIsVALID(TaskConstant.TASK_MSG_REPLY);
			String n_msg_contents="";
			
        	if(!StringUtil.nullOrBlank(code)){
        		n_msg_contents = SysParamUitl.getSysParamValue(code);
            	List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(code);
            	if(!StringUtil.nullOrBlank(n_msg_contents) && listmap!=null && listmap.size()>0){
            		for (Map<String, String> map : listmap){
            			//System.out.println("map.get(\"p_value_name\")=="+map.get("p_value_name")+",map.get(\"p_value_code\")==="+map.get("p_value_code")+",kbmDocMap.get(map.get(\"p_value_code\"))=="+kbmDocMap.get(map.get("p_value_code")));
            			if(taskMap!=null && taskMap.size()>0 && !StringUtil.nullOrBlank(taskMap.get(map.get("p_value_code")))){
            				n_msg_contents = n_msg_contents.replaceAll("【"+map.get("p_value_name")+"】",taskMap.get(map.get("p_value_code")));
            			}
            		}
            	}	
        	}
			TaskMsgBean msgbean=new TaskMsgBean();
        	msgbean.setT_msg_content(n_msg_contents);
			if("1".equals(is_sms)){//短信
				msgbean.setT_msg_id(StringUtil.getUUID());
				msgbean.setId(id);
				msgbean.setT_msg_type("1");
				((BaseDao)dao).insert(msgbean, con);
			}
			if("1".equals(is_msg)){//站内
				msgbean.setT_msg_id(StringUtil.getUUID());
				msgbean.setId(id);
				msgbean.setT_msg_type("2");
				((BaseDao)dao).insert(msgbean, con);
			}
			if("1".equals(is_rtx)){//及时
				msgbean.setT_msg_id(StringUtil.getUUID());
				msgbean.setId(id);
				msgbean.setT_msg_type("3");
				((BaseDao)dao).insert(msgbean, con);
			}
			if("1".equals(is_mail)){//邮件
				msgbean.setT_msg_id(StringUtil.getUUID());
				msgbean.setId(id);
				msgbean.setT_msg_type("4");
				((BaseDao)dao).insert(msgbean, con);
			}
			
			//发送消息提醒
			MessageUtil util=new MessageUtil();
			List<String> receiveuser=new ArrayList<String>();
			if(bean.getUser_id().equals(taskbean.getInput_userid())){
				receiveuser.add(taskbean.getReceive_userid());
			}else{
				receiveuser.add(taskbean.getInput_userid());
			}
			if("1".equals(is_sms)){//短信
				util.sendSms(bean.getId(),n_msg_contents, bean.getUser_id(), receiveuser,"",NoteConstants.SEND_TASK, con);
			}
			if("1".equals(is_msg)){//站内
				util.sendMsg(n_msg_contents,bean.getUser_id(), receiveuser, con);
			}
			if("1".equals(is_rtx)){//及时
				util.sendRtx(n_msg_contents, bean.getUser_id(), receiveuser, con);
			}
			if("1".equals(is_mail)){//邮件
				util.sendMail(n_msg_contents, bean.getUser_id(), receiveuser, con);
			}
			
			con.commit();
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.rollBackNoThrow(con);
			return false;
		} finally {
			DbManager.closeConnection(con);
		}
	}
	
	/**
	 * 
	*<b>Summary:更新回复信息 </b>
	* insertTaskReport()
	* @param bean
	* @return
	 */
	@Override
	public boolean updateTaskReport(TaskReportBean bean){
		Connection con = null;
		try {
			if(null == bean){
				return false;
			}
			con = DbManager.getInstance().getTransactionConnection();
		
			//上报信息赋值上报时间
			bean.setReport_time(new Timestamp(System.currentTimeMillis()));
			((BaseDao) dao).update(bean,con);			
			
			
			con.commit();
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.rollBackNoThrow(con);
			return false;
		} finally {
			DbManager.closeConnection(con);
		}
	}
	
	/**
	 * 
	*<b>Summary: 根据id查询得到回复信息</b>
	* queryToTaskReportBean()
	* @param id 回复信息id
	* @return
	 */
	@Override
	public TaskReportBean queryToTaskReportBean(String id){
		Connection conn = null;
		try {
			TaskReportBean bean = new TaskReportBean();
			bean.setId(id);
			return (TaskReportBean)((BaseDao)dao).queryToBean(bean,conn);					
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return new TaskReportBean();
		} finally {
			DbManager.closeConnection(conn);
		}
	}

}

