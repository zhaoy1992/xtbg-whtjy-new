package com.chinacreator.xtbg.core.process.workflowphone.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao;
import com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc;
import com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc;
import com.chinacreator.xtbg.core.process.flowprocessing.util.FlowStaticTHreadData;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.ResponseConstant;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneRequestBean;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneResponseBean;
import com.chinacreator.xtbg.core.process.workflowphone.exception.InitWorkFlowInfoException;
import com.chinacreator.xtbg.core.process.workflowphone.exception.WorkFlowAbstractException;
/**
 * 
 *<p>Title:PCWorkFlowApprove.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */

public class PCWorkFlowApprove extends PCWorkFlowHandler {
	protected FlowInstanceServiceIfc flowInstanceServiceIfc = null;  //TODO 配置  PCWorkFlowHanlderFactory.createFlowInstanceServiceIfc();
	protected WorkFlowServiceIfc workFlowServiceIfc = null;
	private DsCRUDDao  dsCRUDDao = null;//通用保存DAO
	//PCWorkFlowHanlderFactory.createWorkFlowServiceIfc();
	protected String userName = "";//当前登录用户的用户名
	protected String userRealName = "";//当前登录用户的真实名称
	protected String orgId = "";//当前登录用户的机构id
	protected String orgName = "";//当前登录用户的机构名称
	protected String flowDataJson = "";//流程信息
	protected String classNameId = "";	//操作类
	protected String busiData = "";	//操作类型
	protected String xzspWorkflowType = "";	//流程类型
	protected String isDynamicSelectUser = "";	//是否动态选择执行人
	protected String DYNAMICPERFORMER = "";	//活动执行人
	protected String flowTache = "";	//
	protected String nextActId = "";	//下一活动ID
	protected String nextActList = "";	//活动列表
	protected String action_handeridea = "";	//处理意见
	protected String bigColumnsValue = "";	//大字段数据
	protected String insName = ""; //流程实例名称
	
	protected String table_name ="";//表名
	protected String column_name ="";//意见列名
	protected Map<Object, Object> flowInfoObj = new HashMap<Object, Object>();
	protected Map<String, String> flowData = new HashMap<String, String>();
	protected Map<String, String> flowCtrlInfo = new HashMap<String, String>();
	
	
	/** 
	 * <b>Summary: </b>
	 *     设置 flowInstanceServiceIfc 的值 
	 * @param flowInstanceServiceIfc 
	 */
	public void setFlowInstanceServiceIfc(
			FlowInstanceServiceIfc flowInstanceServiceIfc) {
		this.flowInstanceServiceIfc = flowInstanceServiceIfc;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 workFlowServiceIfc 的值 
	 * @param workFlowServiceIfc 
	 */
	public void setWorkFlowServiceIfc(WorkFlowServiceIfc workFlowServiceIfc) {
		this.workFlowServiceIfc = workFlowServiceIfc;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 dsCRUDDao 的值 
	 * @param dsCRUDDao 
	 */
	public void setDsCRUDDao(DsCRUDDao dsCRUDDao) {
		this.dsCRUDDao = dsCRUDDao;
	}

	/**
	* @Title: initApprove 
	* @Description: TODO( 加载处理环节的初始化参数) 
	* @param workFlowPhoneRequestBean
	 */
	private void initApprove(WorkFlowPhoneRequestBean workFlowPhoneRequestBean){
		Map<String,String> initMap = workFlowPhoneRequestBean.getInitmap();
		userName = initMap.get("userName");
		userRealName = initMap.get("userRealName");
		orgId = initMap.get("orgId");
		orgName = initMap.get("orgName");
		flowDataJson = initMap.get("flowData");//流程信息
		classNameId = initMap.get("classNameId");	//操作类
		busiData = initMap.get("busiData");	//操作类型
		xzspWorkflowType = initMap.get("xzspWorkflowType");	//流程类型
		isDynamicSelectUser = initMap.get("isDynamicSelectUser");	//是否动态选择执行人
		DYNAMICPERFORMER = initMap.get("DYNAMICPERFORMER");	//活动执行人
		flowTache = initMap.get("flowTache");	//
		nextActId = initMap.get("nextActId");	//下一活动ID
		nextActList = initMap.get("nextActList");	//活动列表
		action_handeridea = initMap.get("action_handeridea");	//处理意见
		bigColumnsValue = initMap.get("bigColumnsValue");	//大字段数据
		insName = initMap.get("insName");	//流程实例名称
		
		table_name = initMap.get("table_name");	//表名
		column_name = initMap.get("column_name");	//列名
		
		flowDataJson = DataControlUtil.replaceStr(flowDataJson);
		flowData = (Map)JSONObject.parseObject(flowDataJson);// 根据字符串转换对象
		
		flowInfoObj.put("flowData", flowData);
		flowInfoObj.put("classNameId", classNameId);
		flowInfoObj.put("bigColumnsValue", bigColumnsValue);
		flowInfoObj.put("action_handeridea", action_handeridea);
		flowInfoObj.put("orgid", orgId);
		flowInfoObj.put("orgName", orgName);
		flowInfoObj.put("userRealName", userRealName);
		flowInfoObj.put("ins_name", insName);
		
		flowInfoObj.put("table_name", table_name);
		flowInfoObj.put("column_name", column_name);
	}

	@Override
	public WorkFlowPhoneResponseBean doWorkFlowMethod(WorkFlowPhoneRequestBean workFlowPhoneRequestBean)  throws WorkFlowAbstractException {
		initApprove(workFlowPhoneRequestBean);
		/*//TODO 在这里保存业务数据
		Map<String,String> initMap = workFlowPhoneRequestBean.getInitmap();
		String dateMapString = initMap.get("dateMap");
		String businessType = initMap.get("businessType");
		Map<String, List<Map<String, String>>> dataMap =  new HashMap<String, List<Map<String, String>>>(); //TODO 在这里将STRING转换成 Map<String, List<Map<String, String>>>
		List<Map<String, List<Map<String, String>>>> dataMapList = new  ArrayList<Map<String, List<Map<String, String>>>>();
		try {
			dsCRUDDao.update(dataMapList, null,businessType , null);
		} catch (Exception e) {
			throw new InitWorkFlowInfoException(e.getMessage(), ResponseConstant.RESULT_CODE_11,ResponseConstant.RESULT_MESSAGE_11,"更新业务数据失败！");
		}*/
		return null;
	}


	public void doCompleteAct(Map<Object, Object> flowInfo, String busiJson)
			throws Exception {
		flowInstanceServiceIfc.doCompleteAct(flowInfo, null);
	}


	public void doFlowBack(Map<Object, Object> flowInfo, String busiJson)
			throws Exception {
		flowInstanceServiceIfc.doFlowBack(flowInfo, null);
	}


	public void doFlowFinish(Map<Object, Object> flowInfo, String busiJson)
			throws Exception {
		flowInstanceServiceIfc.doFlowFinish(flowInfo, null);
	}


	public void doStartFlow(Map<Object, Object> flowInfo, String busiJson)
			throws Exception {
		flowInstanceServiceIfc.doStartFlow(flowInfo, null);
	}


	public void doTemp(Map<Object, Object> flowInfo, String busiJson)
			throws Exception {
		flowInstanceServiceIfc.doTemp(flowInfo, null);
	}


	public void doTemporarySave(Map<Object, Object> flowInfo, String busiJson)
			throws Exception {
		flowInstanceServiceIfc.doTemporarySave(flowInfo, null);
	}


	public void doTerminationFlow(Map<Object, Object> flowInfo, String busiJson)
			throws Exception {
		flowInstanceServiceIfc.doTerminationFlow(flowInfo, null);
	}


	public void startWorkflowNotCompleteFirstAct(Map<Object, Object> flowInfo,
			String busiJson) throws Exception {
		flowInstanceServiceIfc.startWorkflowNotCompleteFirstAct(flowInfo, null);
	}


	public int back(String userName, String actInsId, String busiId,
			String formDefId, String remoteAddr) throws Exception {
		return workFlowServiceIfc.back(userName, actInsId, busiId, formDefId,
				remoteAddr);
	}


	public int complete(Map map, String userName, String actInsId,
			String busiId, String formDefId, String isFirstAct,
			String remoteAddr) throws Exception {
		return workFlowServiceIfc.complete(map, userName, actInsId, busiId,
				formDefId, isFirstAct, remoteAddr);
	}


	public String doTemp(String userName, String mgrName, String busiId,
			String formDefId, String remoteAddr) throws Exception {
		return workFlowServiceIfc.doTemp(userName, mgrName, busiId, formDefId,
				remoteAddr);
	}


	public Map<String, String> getFlowCtrlInfo(String xzspWorkflowType,
			String isDynamicSelectUser, String DYNAMICPERFORMER, String flowId,
			String nextActList, String flowTache, String nextActId)
			throws Exception {
		return workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,
				isDynamicSelectUser, DYNAMICPERFORMER, flowId, nextActList,
				flowTache, nextActId);
	}


	public boolean getIsAndTypeSplit(String actInsId, String mgrName) {
		return workFlowServiceIfc.getIsAndTypeSplit(actInsId, mgrName);
	}


	public String getIsShowActSelectText(String actInsId, String mgrName) {
		return workFlowServiceIfc.getIsShowActSelectText(actInsId, mgrName);
	}


	public Map getNextActList(String userName, String actInsId, String mgrName)
			throws Exception {
		return workFlowServiceIfc.getNextActList(userName, actInsId, mgrName);
	}


	public void recycle(String userName, String actInsId, String remoteAddr)
			throws Exception {
		workFlowServiceIfc.recycle(userName, actInsId, remoteAddr,"");
	}


	public void resume(String userName, String actInsId, String remoteAddr)
			throws Exception {
		workFlowServiceIfc.resume(userName, actInsId, remoteAddr);
	}


	public String start(String userName, String mgrName,
			Map<String, String> map, String busiId, String formDefId,
			String remoteAddr) throws Exception {
		return workFlowServiceIfc.start(userName, mgrName, map, busiId,
				formDefId, remoteAddr);
	}


	public void suspend(String userName, String procInsId, String remoteAddr)
			throws Exception {
		workFlowServiceIfc.suspend(userName, procInsId, remoteAddr);
	}


	public void terminate(String userName, String procInsId, String remoteAddr)
			throws Exception {
		workFlowServiceIfc.terminate(userName, procInsId, remoteAddr);
	}

	
}
