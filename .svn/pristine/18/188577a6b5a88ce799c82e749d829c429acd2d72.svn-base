package com.chinacreator.xtbg.core.process.flowprocessing.service;


import java.util.Map;

/**
 * 
 *<p>Title:WorkFlowServiceIfc.java</p>
 *<p>Description:流程处理接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-18
 */
public interface WorkFlowServiceIfc {

	/**
	 * 
	*<b>Summary: </b>
	* start(启动流程)
	* @param userName 用户帐号
	* @param mgrName 包名＃版本号＃流程名
	* @param map 流程控制参数
	* @param busiId 业务ID
	* @param formDefId 表单ID
	* @param remoteAddr 应用IP地址 （127.0.0.1）
	* @return
	* @throws Exception
	 */
	public String start(String userName, String mgrName, Map<String, String> map,
			String busiId, String formDefId, String remoteAddr)
			throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* doTemp(启动流程暂存，保存下一活动执行人，下一活动名称,与分支活动)
	* @param userName 用户帐号
	* @param mgrName 包名＃版本号＃流程名
	* @param busiId 业务ID
	* @param formDefId 表单ID
	* @param remoteAddr 应用IP地址 （127.0.0.1）
	* @return
	* @throws Exception
	 */
	public String doTemp(String userName, String mgrName, String busiId,
			String formDefId, String remoteAddr) throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* suspend(流程挂起)
	* @param userName 用户帐号
	* @param procInsId 流程实例ID
	* @param remoteAddr 应用IP地址 （127.0.0.1）
	* @throws Exception
	 */
	public void suspend(String userName, String procInsId, String remoteAddr)
			throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* resume(恢复流程)
	* @param userName 用户帐号
	* @param actInsId 活动实例ID
	* @param remoteAddr 应用IP地址 （127.0.0.1）
	* @throws Exception
	 */
	public void resume(String userName, String actInsId, String remoteAddr)
			throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* complete(完成活动)
	* @param map 流程控制参数
	* @param userName 用户帐号
	* @param actInsId 活动实例ID
	* @param busiId 业务ID
	* @param formDefId 表单ID
	* @param isFirstAct
	* @param remoteAddr  应用IP地址 （127.0.0.1）
	* @return 0 成功
	* @throws Exception
	 */
	public int complete(Map map, String userName, String actInsId, String busiId, String formDefId, String isFirstAct, String remoteAddr) throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* terminate(终止流程)
	* @param userName 用户帐号
	* @param procInsId 流程实例ID
	* @param remoteAddr 应用IP地址 （127.0.0.1）
	* @throws Exception
	 */
	public void terminate(String userName, String procInsId, String remoteAddr) throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* recycle(收回任务，如果活动的下一个活动还没有执行，那么上一活动的执行人可以将任务收回)
	* @param userName 用户帐号
	* @param actInsId 活动实例ID
	* @param remoteAddr 应用IP地址 （127.0.0.1）
	* @param ins_id 流程实例ID
	* @throws Exception
	 */
	public void recycle(String userName, String actInsId, String remoteAddr,String ins_id)
			throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* back(退回活动，将当前活动退回至上一活动)
	* @param userName 用户帐号
	* @param actInsId 活动实例ID
	* @param busiId 业务ID
	* @param formDefId 应用IP地址 （127.0.0.1）
	* @param remoteAddr
	* @return 0 成功
	* @throws Exception
	 */
	public int back(String userName, String actInsId, String busiId,
			String formDefId, String remoteAddr) throws Exception;

	
	/**
	 * 
	*<b>Summary: </b>
	* getNextActList(获得后续活动及参与者 Map key为 活动id#活动名称 如test1201_wp1_act2#第二步 value为用户名组成的List {test1201_wp1_act2#第二步=[weida02, weida03],test1201_wp1_act5#添加的节点=[weida02, weida03]})
	* @param userName
	* @param actInsId
	* @param mgrName
	* @return
	* @throws Exception
	 */
	public Map getNextActList(String userName, String actInsId, String mgrName)
			throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getIsShowActSelectText(获得是否手动指定下一步活动)
	* @param actInsId 活动实例id
	* @param mgrName 包名＃版本号＃流程名
	* @return
	 */
	public String getIsShowActSelectText(String actInsId, String mgrName);
	
	/**
	 * 
	*<b>Summary: </b>
	* getIsAndTypeSplit(判断是否为与分支活动)
	* @param actInsId
	* @param mgrName
	* @return
	 */
	public boolean getIsAndTypeSplit(String actInsId, String mgrName);
	
	/**
	 * 
	*<b>Summary: </b>
	* getFlowCtrlInfo(获得流程控制信息)
	* @param xzspWorkflowType 流程类型
	* @param isDynamicSelectUser 是否动态选择执行人
	* @param DYNAMICPERFORMER 动态执行人
	* @param flowId 流程ID
	* @param nextActList 
	* @param flowTache 流程阶段
	* @param nextActId 下一环节ID
	* @return
	* @throws Exception
	 */
	public Map<String, String> getFlowCtrlInfo(String xzspWorkflowType,String isDynamicSelectUser,String DYNAMICPERFORMER, String flowId, String nextActList, String flowTache,String nextActId) throws Exception;
	
	
	

	
}
