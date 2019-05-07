package com.chinacreator.xtbg.core.process.flowprocessing.service.impl;

import java.sql.Connection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.enhydra.shark.api.SharkTransaction;
import org.enhydra.shark.api.common.SharkConstants;
import org.enhydra.shark.api.internal.eventaudit.AssignmentEventAuditPersistenceInterface;
import org.enhydra.shark.api.internal.eventaudit.EventAuditException;
import org.enhydra.shark.api.internal.eventaudit.StateEventAuditPersistenceInterface;
import org.enhydra.shark.eventaudit.DODSEventAuditManager;

import com.chinacreator.workflow.shark.SharkUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowInstanceDataSaveDaoImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowUtilDaoImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowViewDaoImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowActionUserBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InsWfactionBean;
import com.chinacreator.xtbg.core.process.flowprocessing.util.FlowStaticTHreadData;

/***
 * 
 *<p>Title:FlowExtServiceImpl.java</p>
 *<p>Description:流程扩展处理类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-3
 */
public class FlowExtServiceImpl extends DODSEventAuditManager {
	
	private static final Log LOG = LogFactory.getLog(FlowExtServiceImpl.class);
	

	/**
	 * 
	  * <b>Summary: 添加任务</b>
	  *     复写方法 persist
	  * @param aea
	  * @param ti
	  * @throws EventAuditException 
	  * @see org.enhydra.shark.eventaudit.DODSEventAuditManager#persist(org.enhydra.shark.api.internal.eventaudit.AssignmentEventAuditPersistenceInterface, org.enhydra.shark.api.SharkTransaction)
	 */
	public void persist(AssignmentEventAuditPersistenceInterface aea,
			SharkTransaction ti) throws EventAuditException {
		
		super.persist(aea, ti);
		Connection conn = null;
		try {
			conn = SharkUtil.getDBConnection(ti).getConnection();
			udateInsWfaction(aea, ti, conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			throw new EventAuditException(e);
		} 
		
	}

	/**
	 * 
	  * <b>Summary: 修改任务</b>
	  *     复写方法 persist
	  * @param sea
	  * @param ti
	  * @throws EventAuditException 
	  * @see org.enhydra.shark.eventaudit.DODSEventAuditManager#persist(org.enhydra.shark.api.internal.eventaudit.StateEventAuditPersistenceInterface, org.enhydra.shark.api.SharkTransaction)
	 */
	public void persist(StateEventAuditPersistenceInterface sea,
			SharkTransaction ti) throws EventAuditException {
		super.persist(sea, ti);
		String state = sea.getNewState();
		Connection conn = null;
		try {
			conn = SharkUtil.getDBConnection(ti).getConnection();
			if (SharkConstants.STATE_OPEN_NOT_RUNNING_NOT_STARTED.equals(state)
					|| SharkConstants.STATE_OPEN_NOT_RUNNING_SUSPENDED.equals(state)
					|| SharkConstants.STATE_CLOSED_COMPLETED.equals(state)
					|| SharkConstants.STATE_CLOSED_TERMINATED.equals(state)
					|| SharkConstants.STATE_CLOSED_ABORTED.equals(state)) {
				addOrUpdateInsWfaction(sea, ti, conn);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			throw new EventAuditException(e);
			
		} 
	}
	
	
	/**
	 * 
	*<b>Summary: </b>
	* addOrUpdateInsWfaction(保存流程环节待办数据)
	 */
	public void addOrUpdateInsWfaction(StateEventAuditPersistenceInterface sea, SharkTransaction ti, Connection conn) throws Exception{
		InsWfactionBean insWfactionBean = null;
		FlowUtilDao flowUtilDao = null;
		FlowInstanceDataSaveDao flowInstanceDataSaveDao = null;
		
		String act_insid = sea.getActivityId();//环节实例ID
	    String state = sea.getNewState();
	    String status_code = FlowStaticTHreadData.getStatus_code();
	    String ins_id = FlowStaticTHreadData.getBuisinessId();//流程实例ID
	    
		if(!StringUtil.isBlank(act_insid) && !StringUtil.isBlank(ins_id)) {
			flowInstanceDataSaveDao = new FlowInstanceDataSaveDaoImpl();
			
			if(SharkConstants.STATE_OPEN_NOT_RUNNING_NOT_STARTED.equals(state)) { //当状态为待办
				
					flowUtilDao = new FlowUtilDaoImpl();
					String actDefid = sea.getActivityDefinitionId();//环节定义ID
					String module_id = FlowStaticTHreadData.getModuleId();//流程ID
					String def_id = FlowStaticTHreadData.getDefId();//流程ID  modify by shuqi.liu 实际上取的def_id
					String action_form = FlowStaticTHreadData.getAction_form();//表单
					
					//modify by shuqi.liu getAction_Id此处替换为getActionId 根据def_id，actDefid 确定ACTION_ID  此处是为了解决新版本流程发布后，老版本的实例仍然按照老版本的流程流转。
					String action_id = flowUtilDao.getActionId(def_id, actDefid); //环节ID
					// modify by shuqi.liu 此方法为平台BUG，发布新版本后返回的action_name 不会修改。String action_name = sea.getActivityName();
					String action_name = flowUtilDao.getActionName(def_id, actDefid); //环节名称
					
					String processid = sea.getProcessId();//流程ID
					
					insWfactionBean = new InsWfactionBean();
					insWfactionBean.setIns_id(ins_id);
					insWfactionBean.setAction_id(action_id);
					insWfactionBean.setAction_name(action_name);
					insWfactionBean.setFlow_action_id(StringUtil.getUUID());
					insWfactionBean.setAct_insid(act_insid);
					insWfactionBean.setProcessid(processid);
					insWfactionBean.setAct_defid(actDefid);
					insWfactionBean.setState(state);
					insWfactionBean.setAction_form(action_form);
					
					flowInstanceDataSaveDao.addInswfaction(insWfactionBean, conn);
					new FlowViewDaoImpl().callBackForFullData(ins_id,act_insid);
			} else if(SharkConstants.STATE_CLOSED_TERMINATED.equals(state)) { //回退
				if("06".equals(status_code)) { //回退
					String bbackflow_username = FlowStaticTHreadData.getBackflow_username();
					flowInstanceDataSaveDao.updateInswfaction(bbackflow_username, act_insid, status_code, conn);
					flowInstanceDataSaveDao.delFlow_actionuser(act_insid, conn);
				} else if("07".equals(status_code)) { //追回
					flowInstanceDataSaveDao.delFlow_actionuser(act_insid, conn);
					flowInstanceDataSaveDao.updateRecycleInswfaction(ins_id, conn);
				}
			}
			
			
		}

	}
	
	public void udateInsWfaction(AssignmentEventAuditPersistenceInterface aea, SharkTransaction ti, Connection conn) throws Exception {
		String ins_id = FlowStaticTHreadData.getBuisinessId();//流程实例ID
		String actDefid = aea.getActivityDefinitionId();//环节定义ID
		String actInsId = aea.getActivityId();//环节实例ID
		String processid = aea.getProcessId();//流程实例
		String module_id = FlowStaticTHreadData.getModuleId();
		String def_id = FlowStaticTHreadData.getDefId();//流程ID  modify by shuqi.liu 实际上取的def_id
		String mgrName = FlowStaticTHreadData.getMgrName();
		String status_code = FlowStaticTHreadData.getStatus_code();
		String dynamicperformer = FlowStaticTHreadData.getDynamicperformer();//动态执行人
		String is_handle = "0"; //0表示已处理  1表示未处理
		String is_countersignperson = "0";//0表示会签当前环节不可以处理，1表示当前环节可以处理
		
		FlowUtilDao flowUtilDao = null;
		FlowInstanceDataSaveDao flowInstanceDataSaveDao = null;
		FlowActionUserBean flowActionUserBean = null;
		String newResourceUsername = aea.getNewResourceUsername();
		String oldResourceUsername = aea.getOldResourceUsername();

		if(!StringUtil.isBlank(actInsId) && !StringUtil.isBlank(ins_id)) {
			flowUtilDao = new FlowUtilDaoImpl();
			flowInstanceDataSaveDao = new FlowInstanceDataSaveDaoImpl();
			//modify by shuqi.liu getAction_Id此处替换为getActionId 根据def_id，actDefid 确定ACTION_ID  此处是为了解决新版本流程发布后，老版本的实例仍然按照老版本的流程流转。
			String action_id = flowUtilDao.getActionId(def_id, actDefid); //环节ID
			String issignjoinbyorder = flowUtilDao.getCountersignType(action_id); //获得会签类型
			
			flowActionUserBean = new FlowActionUserBean();
			flowActionUserBean.setActionuser_id(StringUtil.getUUID());
			flowActionUserBean.setIns_id(ins_id);
			flowActionUserBean.setAct_defid(actDefid);
			flowActionUserBean.setActivity(actInsId);
			flowActionUserBean.setActivityprocessid(processid);
			flowActionUserBean.setActivityprocessdefname(mgrName);
			flowActionUserBean.setUser_name(newResourceUsername);
			flowActionUserBean.setCountersign_type(issignjoinbyorder);
			boolean isDeleteCountersign = false;
			
			if(!StringUtil.isBlank(newResourceUsername) && StringUtil.isBlank(oldResourceUsername)) { //如果新用户不为空，老用户为空表示是待办用户生成
				is_handle = "1";
				flowActionUserBean.setIs_handle(is_handle);
				
				if ("userLevelHighToLow".equals(issignjoinbyorder) || "userLevelLowToHigh".equals(issignjoinbyorder)) {
					is_handle = "0";
					String countersignUser = flowInstanceDataSaveDao.getCountersignUser(actDefid, processid, conn);
					if(!StringUtil.isBlank(countersignUser)) {//如果会签人不为空
						dynamicperformer = countersignUser;
						
					}
					String dynamicperformerArray[] = dynamicperformer.split(",");
					int dynamicperformerArraySize = dynamicperformerArray.length;
					flowActionUserBean.setCountersign_maxorder(String.valueOf(dynamicperformerArraySize));
					
					int order = 0;
					
					for (int i = 0; i < dynamicperformerArray.length; i++) {
						if(newResourceUsername.equals(dynamicperformerArray[i])) {
							order = i;
							if (i == 0 ) { //如果会签用户是最后一个,将删除会签临时表的记录
								isDeleteCountersign = true;
							}
							break;
						}
					}
					
					if(StringUtil.isBlank(countersignUser)) {
						if ("userLevelHighToLow".equals(issignjoinbyorder)) { //表示从高到低
							order = order + 1;
						} else if ("userLevelLowToHigh".equals(issignjoinbyorder)) {//表示从低到高
							order = dynamicperformerArraySize - order;
						}
					} else {
						order = order + 1;
					}
					
					if(order == 1) {
						is_handle = "1";
						is_countersignperson = "1";
					}
					
					flowActionUserBean.setIs_handle(is_handle);
					flowActionUserBean.setIs_countersignperson(is_countersignperson);
					flowActionUserBean.setCountersign_order(String.valueOf(order));
					
					if(isDeleteCountersign) {
						//flowInstanceDataSaveDao.delCountersignUser(actDefid, processid, conn);
					}
					
				}
				
				flowInstanceDataSaveDao.addFlow_actionuser(flowActionUserBean, conn);
			
			} else if (!StringUtil.isBlank(newResourceUsername) && !StringUtil.isBlank(oldResourceUsername)) { //如果新用户不为空，老用户也不为空表示是已办用户生成
				if ("userLevelHighToLow".equals(issignjoinbyorder) || "userLevelLowToHigh".equals(issignjoinbyorder)) {
					flowInstanceDataSaveDao.addCountersignUser(actDefid, processid, conn);
				}
				
				flowInstanceDataSaveDao.delFlow_actionuser(actInsId, conn);
				flowInstanceDataSaveDao.updateInswfaction(oldResourceUsername,actInsId, status_code,  conn);
				
			}
					
		}
			
	

	}
			
	
	
	
}
