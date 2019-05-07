package com.chinacreator.xtbg.core.process.flowprocessing.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.enhydra.shark.SharkUtilities;
import org.enhydra.shark.xpdl.elements.Activity;

import com.chinacreator.spi.impl.local.WorkflowManagerImpl;
import com.chinacreator.spi.impl.local.WorkflowNotTransactionImpl;
import com.chinacreator.workflow.shark.SharkEngine;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao;
import com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc;
import com.chinacreator.xtbg.core.process.flowprocessing.util.Constant;


/**
 * 
 *<p>Title:WorkFlowServiceImpl.java</p>
 *<p>Description:流程处理实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-20
 */
public class WorkFlowServiceImpl implements WorkFlowServiceIfc {
 
	private WorkflowNotTransactionImpl workflowNotTransactionImpl;
	private WorkflowManagerImpl workflowManagerImpl;
	
	public WorkFlowServiceImpl() {
		workflowNotTransactionImpl = new WorkflowNotTransactionImpl();
		workflowManagerImpl = new WorkflowManagerImpl();
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 start
	  * @param userName
	  * @param mgrName
	  * @param map
	  * @param busiId
	  * @param formDefId
	  * @param remoteAddr
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#start(java.lang.String, java.lang.String, java.util.Map, java.lang.String, java.lang.String, java.lang.String)
	 */
	public String start(String userName, String mgrName, Map<String, String> map, String busiId, String formDefId, String remoteAddr)
			throws Exception {
//		//获得流程静态参数
//		FlowStaticTHreadData.setMgrName(mgrName);
//		FlowStaticTHreadData.setBuisinessId(map.get("ins_id"));
//		FlowStaticTHreadData.setModuleId(map.get("MODULE_ID"));
//		FlowStaticTHreadData.setAction_form(formDefId);
		new WorkflowManagerImpl().startWorkflowWrapperReturn(userName, mgrName, map, busiId, remoteAddr, map.get("MODULE_ID"));
		
//		//删除流程静态参数
//		FlowStaticTHreadData.removeAll();
		return "";
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doTemp
	  * @param userName
	  * @param mgrName
	  * @param busiId
	  * @param formDefId
	  * @param module_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#doTemp(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	public String doTemp(String userName, String mgrName, String busiId,
			String formDefId, String module_id) throws Exception {
		new WorkflowManagerImpl().startWorkflowNotCompleteFirstActWrapper(userName, mgrName, busiId, module_id);
		return "";
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 suspend
	  * @param userName
	  * @param procInsId
	  * @param remoteAddr
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#suspend(java.lang.String, java.lang.String, java.lang.String)
	 */
	public void suspend(String userName, String procInsId, String remoteAddr)
			throws Exception {
		workflowNotTransactionImpl.suspendProcessByProcId(userName, procInsId,
				remoteAddr);

	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 resume
	  * @param userName
	  * @param actInsId
	  * @param remoteAddr
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#resume(java.lang.String, java.lang.String, java.lang.String)
	 */
	public void resume(String userName, String actInsId, String remoteAddr)
			throws Exception {
		
		new WorkflowManagerImpl().resumeProcessByProcId(userName, actInsId,
				remoteAddr);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 complete
	  * @param map
	  * @param userName
	  * @param actInsId
	  * @param busiId
	  * @param formDefId
	  * @param isFirstAct
	  * @param remoteAddr
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#complete(java.util.Map, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	public int complete(Map map, String userName, String actInsId, String busiId, String formDefId, String isFirstAct, String remoteAddr) throws Exception {
		WorkflowManagerImpl workflowManagerImpl = new WorkflowManagerImpl();
		return workflowManagerImpl.completeActWrapper(map, userName, actInsId, busiId, isFirstAct);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 terminate
	  * @param userName
	  * @param procInsId
	  * @param remoteAddr
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#terminate(java.lang.String, java.lang.String, java.lang.String)
	 */
	public void terminate(String userName, String procInsId, String remoteAddr)
			throws Exception {
		workflowNotTransactionImpl.terminateProcessByProcId(userName,
				procInsId, remoteAddr);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 recycle
	  * @param userName
	  * @param actInsId
	  * @param remoteAddr
	  * @param ins_id
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#recycle(java.lang.String, java.lang.String, java.lang.String)
	 */
	public void recycle(String userName, String actInsId, String remoteAddr,String ins_id)
			throws Exception {
		//modify by shuqi.liu 加入当前环节是会签的控制。
		//根据流程实例ID当前所处的环节是不是会签
		boolean isSign = this.isSignAction(ins_id);
		if(isSign){ //如果是会签环节，那么获取到当前会签的实例ID，然后先调用回退接口。
			String currActInsId = this.getCurrActInsId(ins_id);
			workflowNotTransactionImpl.backAct(userName, currActInsId, "", "", "");
		}
		workflowNotTransactionImpl.recycleAct(userName, actInsId, remoteAddr);
	}
	
	/**
	 * 根据实例ID，获取当前的环节实例ID
	 * @param ins_id
	 * @return
	 */
	private String getCurrActInsId(String ins_id)  throws Exception{
		FlowUtilDao flowUtilDao = (FlowUtilDao)LoadSpringContext.getApplicationContext().getBean("flowUtilDaoImpl");
		String actInsId = flowUtilDao.isActInsId(ins_id);
		return actInsId;
	}

	/**
	 * 判断当前环节是否是会签环节
	 * @param ins_id
	 * @return
	 * @throws Exception 
	 */
	private boolean isSignAction(String ins_id) throws Exception {
		FlowUtilDao flowUtilDao = (FlowUtilDao)LoadSpringContext.getApplicationContext().getBean("flowUtilDaoImpl");
		boolean isSign = flowUtilDao.isSignAction(ins_id);
		return isSign;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 back
	  * @param userName
	  * @param actInsId
	  * @param busiId
	  * @param formDefId
	  * @param remoteAddr
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#back(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	public int back(String userName, String actInsId, String busiId,
			String formDefId, String remoteAddr) throws Exception {
		new WorkflowManagerImpl().backAct(userName, actInsId, busiId);
		return 1;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getNextActList
	  * @param userName
	  * @param actInsId
	  * @param mgrName
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#getNextActList(java.lang.String, java.lang.String, java.lang.String)
	 */
	public Map getNextActList(String userName, String actInsId, String mgrName)
			throws Exception {
		return workflowManagerImpl.getNextActivityPerformers(userName, actInsId, mgrName, Constant.NULL);
		
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getIsShowActSelectText
	  * @param actInsId
	  * @param mgrName
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#getIsShowActSelectText(java.lang.String, java.lang.String)
	 */
	public String getIsShowActSelectText(String actInsId, String mgrName) {
		boolean hasNextAct;
		if (!StringUtil.isBlank(actInsId)) {
			Activity actDefObj = SharkUtilities.getActivityDefinition(actInsId);
			hasNextAct = actDefObj.getExtendedAttributes().containsValue(
					SharkEngine.EXTENTATTR_NEXT_ACT);
		} else {
			SharkEngine shark = SharkEngine.getInstance();
			hasNextAct = shark.firstActivityHasExtentAttr(mgrName,
					SharkEngine.EXTENTATTR_NEXT_ACT);
		}
		return Constant.IS_SHOWANDACTSELECTTEXT + Constant.COLON + hasNextAct;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getIsAndTypeSplit
	  * @param actInsId
	  * @param mgrName
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#getIsAndTypeSplit(java.lang.String, java.lang.String)
	 */
	public boolean getIsAndTypeSplit(String actInsId, String mgrName) {
		
		return workflowManagerImpl.isAndTypeSplit(actInsId, mgrName);
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowCtrlInfo
	  * @param xzspWorkflowType
	  * @param isDynamicSelectUser
	  * @param DYNAMICPERFORMER
	  * @param flowId
	  * @param nextActList
	  * @param flowTache
	  * @param nextActId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc#getFlowCtrlInfo(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	public Map<String, String> getFlowCtrlInfo(String xzspWorkflowType,
			String isDynamicSelectUser, String DYNAMICPERFORMER, String flowId,
			String nextActList, String flowTache, String nextActId)
			throws Exception {
		
		Map<String,String> flowCtrlInfoMap = new HashMap<String,String>();
		String actUser = "";
		String andSplitUsers = "";
	    if("1".equals(xzspWorkflowType)){  //普通流程  
	        actUser = getActUserForNotAndSelect(isDynamicSelectUser, flowId,DYNAMICPERFORMER,nextActId, actUser);  //根据活动ID取得下一活动的参与者 
	    }else if("2".equals(xzspWorkflowType)){ //动态选择下一或活动（且除退窗外有多于等于2个活动选项）
	        actUser = getActUserForNotAndSelect(isDynamicSelectUser, flowId,DYNAMICPERFORMER,nextActId,actUser);  //quan.zhou 2010.3.23
	    }else{  //动态选择下一与活动
	        andSplitUsers = getActUserForAndSelect(flowId,isDynamicSelectUser,nextActList);
	    }
		flowCtrlInfoMap.put("NEXT_ACT", nextActId);//下一步执行活动ID（多个活动ID之间用逗号隔开）
		if("true".equals(isDynamicSelectUser)) {
			flowCtrlInfoMap.put("DYNAMICPERFORMER", actUser);//下一步活动执行人ID（多个活动ID之间用逗号隔开）
		}
		flowCtrlInfoMap.put("ANDSPLITUSERS", andSplitUsers);//下一步与活动执行人ID（多个活动ID之间用逗号隔开）
		return flowCtrlInfoMap;
		
	}
	
	/**
	 * 获得下一环节的活动执行人
	 * @param isDynamicSelectUser 是否动态选择执行人
	 * @param flowId 流程ID
	 * @param DYNAMICPERFORMER 动态执行人
	 * @param nextActId 下一环节ID
	 * @param orgId 机构ID
	 * @param actUser 环节用户
	 * @retur String 环节执行人
	 * @throws Exception
	 */
	public String getActUserForNotAndSelect(String isDynamicSelectUser, String flowId, String DYNAMICPERFORMER,String nextActId,String actUser) throws Exception{
		if("true".equals(isDynamicSelectUser)){
			return DYNAMICPERFORMER;
		}else{
			FlowUtilDao flowUtilDao = (FlowUtilDao)LoadSpringContext.getApplicationContext().getBean("flowUtilDaoImpl");
			return flowUtilDao.getNextActUser(flowId,nextActId);
		}

	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getActUserForAndSelect(获得用户选定的环节)
	* @param xzspWorkflowType
	* @param flowTache
	* @param countryId
	* @return
	 */
	public String getActUserForAndSelect(String xzspWorkflowType,String flowTache,String countryId){
		return null;
	}



}
