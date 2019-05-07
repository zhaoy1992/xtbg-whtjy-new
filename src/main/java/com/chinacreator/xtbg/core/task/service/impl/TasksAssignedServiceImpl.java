package com.chinacreator.xtbg.core.task.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.MessageUtil;
import com.chinacreator.xtbg.core.common.util.RequestBeanUtils;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.sysparam.util.SysParamUitl;
import com.chinacreator.xtbg.core.task.dao.TasksAssignedDao;
import com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean;
import com.chinacreator.xtbg.core.task.entity.TaskMsgBean;
import com.chinacreator.xtbg.core.task.entity.TaskReportBean;
import com.chinacreator.xtbg.core.task.entity.TaskTypeBean;
import com.chinacreator.xtbg.core.task.service.TasksAssignedServiceIfc;
import com.chinacreator.xtbg.core.task.util.TaskConstant;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;

/**
 * 
 *<p>Title:TasksAssignedServiceImpl.java</p>
 *<p>Description:任务交办service</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-9
 */
public class TasksAssignedServiceImpl implements TasksAssignedServiceIfc {

	public static final Logger LOG = Logger
			.getLogger(TasksAssignedServiceImpl.class.getName());
	//任务操作的dao接口
	TasksAssignedDao dao = null;
   /**
    * 
     * <b>Summary: 定义构造器，实例化dao对象</b>
     *     构造一个 TasksAssignedServiceImpl  
      * <b>Remarks: </b>
     *     构造类 TasksAssignedServiceImpl 的构造函数 TasksAssignedServiceImpl
    */
	public TasksAssignedServiceImpl() {
		this.dao = (TasksAssignedDao) LoadSpringContext.getApplicationContext()
				.getBean("tasksAssignedDaoImpl");
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryTaskTypeBySort
	  * @param typeSort
	  * @return 
	  * @see com.chinacreator.xtbg.core.task.service.TasksAssignedServiceIfc#queryTaskTypeBySort(java.lang.String)
	 */
	public List<TaskTypeBean> queryTaskTypeBySort(String typeSort){
		Connection conn = null;
		try {
			if(StringUtil.nullOrBlank(typeSort)){
				return new ArrayList<TaskTypeBean>();
			}
			//获取连接
			conn = DbManager.getInstance().getConnection();			
				
			return this.dao.queryTaskTypeBySort(typeSort, conn);	
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return new ArrayList<TaskTypeBean>();
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryToTaskBaseInfoBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.task.service.TasksAssignedServiceIfc#queryToTaskBaseInfoBean(java.lang.String)
	 */
	public TaskBaseInfoBean queryToTaskBaseInfoBean(String id){
		Connection conn = null;
		try {
			TaskBaseInfoBean bean = new TaskBaseInfoBean();
			bean.setId(id);
			return (TaskBaseInfoBean)((BaseDao)dao).queryToBean(bean,conn);					
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return new TaskBaseInfoBean();
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertTaskBaseInfo
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.task.service.TasksAssignedServiceIfc#insertTaskBaseInfo(com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean)
	 */
    public boolean insertTaskBaseInfo(TaskBaseInfoBean bean){
		Connection conn = null;
		try {
			if (null == bean) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			
			String[] receive_userIds = bean.getReceive_userid().split(",");
        	String[] receive_userNames = bean.getReceive_username().split(",");
        	String[] receive_orgIds = bean.getReceive_orgid().split(",");
        	String[] receive_orgNames = bean.getReceive_orgname().split(",");
        	Map<String, String> taskMap = RequestBeanUtils.transBean2Map(bean);
        	// 将字符串时间转换为Timestamp
			bean.setStart_time(StringUtil.convertStringToTimestamp(bean
					.getStart_time()));
			// 会议开始时间转换为Timestamp对象（由于其格式为yyyy-MM-dd hh:mm）
			bean.setEnd_time(StringUtil.convertStringToTimestamp(bean
					.getEnd_time()));
        	for(int i = 0; i<receive_userIds.length; i++){
        		//负责人名称
        		String receive_userId = receive_userIds[i];
        		String receive_userName = receive_userNames[i];
        		String receive_orgId = receive_orgIds[i];
        		String receive_orgName = receive_orgNames[i];
        		//
        		bean.setReceive_userid(receive_userId);
        		bean.setReceive_username(receive_userName);
        		bean.setReceive_orgid(receive_orgId);
        		bean.setReceive_orgname(receive_orgName);
        		
				String t_is_sms=bean.getT_is_sms();
				String t_is_mail=bean.getT_is_mail();
				String t_is_msg=bean.getT_is_msg();
				String t_is_rtx=bean.getT_is_rtx();
				if(StringUtil.isBlank(t_is_sms)){
					t_is_sms="0";
				}
				if(StringUtil.isBlank(t_is_mail)){
					t_is_mail="0";
				}
				if(StringUtil.isBlank(t_is_msg)){
					t_is_msg="0";
				}
				if(StringUtil.isBlank(t_is_rtx)){
					t_is_rtx="0";
				}
				bean.setT_is_sms(t_is_sms);
				bean.setT_is_mail(t_is_mail);
				bean.setT_is_msg(t_is_msg);
				bean.setT_is_rtx(t_is_rtx);
				
				
				// id赋初值
				String id=StringUtil.getUUID();
				bean.setId(id);
	
				//插入
				((BaseDao) dao).insert(bean, conn);
				
				//保存相应消息表信息
				//得到短信内容
				String code = SysParamUitl.getSysParamValueIsVALID(TaskConstant.TASK_MSG);
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
				if("1".equals(t_is_sms)){//短信
					msgbean.setT_msg_id(StringUtil.getUUID());
					msgbean.setId(id);
					msgbean.setT_msg_type("1");
					((BaseDao)dao).insert(msgbean, conn);
				}
				if("1".equals(t_is_msg)){//站内
					msgbean.setT_msg_id(StringUtil.getUUID());
					msgbean.setId(id);
					msgbean.setT_msg_type("2");
					((BaseDao)dao).insert(msgbean, conn);
				}
				if("1".equals(t_is_rtx)){//及时
					msgbean.setT_msg_id(StringUtil.getUUID());
					msgbean.setId(id);
					msgbean.setT_msg_type("3");
					((BaseDao)dao).insert(msgbean, conn);
				}
				if("1".equals(t_is_mail)){//邮件
					msgbean.setT_msg_id(StringUtil.getUUID());
					msgbean.setId(id);
					msgbean.setT_msg_type("4");
					((BaseDao)dao).insert(msgbean, conn);
				}
				//发送消息提醒
				MessageUtil util=new MessageUtil();
				List<String> receiveuser=new ArrayList<String>();
				receiveuser.add(bean.getReceive_userid());
				if("1".equals(t_is_sms)){//短信
					util.sendSms(bean.getId(),n_msg_contents, bean.getInput_userid(), receiveuser,"",NoteConstants.SEND_TASK, conn);
				}
				if("1".equals(t_is_msg)){//站内
					util.sendMsg(n_msg_contents,bean.getInput_userid(), receiveuser, conn);
				}
				if("1".equals(t_is_rtx)){//及时
					util.sendRtx(n_msg_contents, bean.getInput_userid(), receiveuser, conn);
				}
				if("1".equals(t_is_mail)){//邮件
					util.sendMail(n_msg_contents, bean.getInput_userid(), receiveuser, conn);
				}
        	}
        	conn.commit();
			return true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}	
    }
    /**
     * 
      * <b>Summary: </b>
      *     复写方法 deleteListTaskBaseInfo
      * @param ids
      * @return 
      * @see com.chinacreator.xtbg.core.task.service.TasksAssignedServiceIfc#deleteListMeetingMinutes(java.lang.String)
     */
    public boolean deleteListTaskBaseInfo(String ids) {
		// 数据库连接
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			
			//先删掉任务对应的回复
			((BaseDao) dao).deleteListById(new TaskReportBean().setDeleteKey("task_id"), conn, ids);
			//删除相应消息表信息
			((BaseDao) dao).deleteListById(new TaskMsgBean().setDeleteKey("id"), conn, ids);
			// 执行删除操作
			((BaseDao) dao).deleteListById(new TaskBaseInfoBean(), conn, ids);
			// 关闭连接并提交事务
			conn.commit();
			return true;

		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
	}
    
    /**
     * 
      * <b>Summary: </b>
      *     复写方法 updateTaskBaseInfo
      * @param bean
      * @return 
      * @see com.chinacreator.xtbg.core.task.service.TasksAssignedServiceIfc#updateTaskBaseInfo(com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean)
     */
    public boolean updateTaskBaseInfo(TaskBaseInfoBean bean){
		Connection conn = null;
		try {
			if (null == bean) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			String id=bean.getId();
			String t_is_sms=bean.getT_is_sms();
			String t_is_mail=bean.getT_is_mail();
			String t_is_msg=bean.getT_is_msg();
			String t_is_rtx=bean.getT_is_rtx();
			if(StringUtil.isBlank(t_is_sms)){
				t_is_sms="0";
			}
			if(StringUtil.isBlank(t_is_mail)){
				t_is_mail="0";
			}
			if(StringUtil.isBlank(t_is_msg)){
				t_is_msg="0";
			}
			if(StringUtil.isBlank(t_is_rtx)){
				t_is_rtx="0";
			}
			bean.setT_is_sms(t_is_sms);
			bean.setT_is_mail(t_is_mail);
			bean.setT_is_msg(t_is_msg);
			bean.setT_is_rtx(t_is_rtx);
			Map<String, String> taskMap = RequestBeanUtils.transBean2Map(bean);
			
			
			// 将字符串时间转换为Timestamp
			bean.setStart_time(StringUtil.convertStringToTimestamp(bean
					.getStart_time()));
			// 时间转换为Timestamp对象（由于其格式为yyyy-MM-dd hh:mm）
			bean.setEnd_time(StringUtil.convertStringToTimestamp(bean
					.getEnd_time()));
			//实际办结时间
			if(bean.getComplete_time()!=null){
				bean.setComplete_time(StringUtil.convertStringToTimestamp(bean.getComplete_time()));
			}
			
			//更新
			((BaseDao) dao).update(bean, conn);
			
			//保存相应消息表信息
			//得到短信内容
			String code = SysParamUitl.getSysParamValueIsVALID(TaskConstant.TASK_MSG_END);
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
			if("1".equals(t_is_sms)){//短信
				msgbean.setT_msg_id(StringUtil.getUUID());
				msgbean.setId(id);
				msgbean.setT_msg_type("1");
				((BaseDao)dao).insert(msgbean, conn);
			}
			if("1".equals(t_is_msg)){//站内
				msgbean.setT_msg_id(StringUtil.getUUID());
				msgbean.setId(id);
				msgbean.setT_msg_type("2");
				((BaseDao)dao).insert(msgbean, conn);
			}
			if("1".equals(t_is_rtx)){//及时
				msgbean.setT_msg_id(StringUtil.getUUID());
				msgbean.setId(id);
				msgbean.setT_msg_type("3");
				((BaseDao)dao).insert(msgbean, conn);
			}
			if("1".equals(t_is_mail)){//邮件
				msgbean.setT_msg_id(StringUtil.getUUID());
				msgbean.setId(id);
				msgbean.setT_msg_type("4");
				((BaseDao)dao).insert(msgbean, conn);
			}
			//发送消息提醒
			MessageUtil util=new MessageUtil();
			List<String> receiveuser=new ArrayList<String>();
			receiveuser.add(bean.getReceive_userid());
			if("1".equals(t_is_sms)){//短信
				util.sendSms(bean.getId(),n_msg_contents, bean.getInput_userid(), receiveuser,"",NoteConstants.SEND_TASK, conn);
			}
			if("1".equals(t_is_msg)){//站内
				util.sendMsg(n_msg_contents,bean.getInput_userid(), receiveuser, conn);
			}
			if("1".equals(t_is_rtx)){//及时
				util.sendRtx(n_msg_contents, bean.getInput_userid(), receiveuser, conn);
			}
			if("1".equals(t_is_mail)){//邮件
				util.sendMail(n_msg_contents, bean.getInput_userid(), receiveuser, conn);
			}
			
			conn.commit();
			return true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}	
    }
	

}
