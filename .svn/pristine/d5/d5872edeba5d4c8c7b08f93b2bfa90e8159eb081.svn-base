package com.chinacreator.xtbg.core.process.flowprocessing.service;

import java.sql.Connection;
import java.util.Map;

/**
 * 
 *<p>Title:FlowInstanceServiceIfc.java</p>
 *<p>Description:流程处理接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-20
 */
public interface FlowInstanceServiceIfc {
	
	
	/**
	 * 
	*<b>Summary: </b>
	* doTemp(处理暂存业务)
	* @param flowInfo 流程信息
	* @param conn
	* @throws Exception
	 */
	public void doTemp(Map<Object, Object> flowInfo, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* doStartFlow(启动流程)
	* @param flowInfo
	* @param conn
	* @throws Exception
	 */
	public void doStartFlow(Map<Object, Object> flowInfo, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* doCompleteAct(完成活动流程业务)
	* @param flowInfo 流程信息
	* @param conn
	* @throws Exception
	 */
	public void doCompleteAct(Map<Object, Object> flowInfo, Connection conn) throws Exception;
	
	/**
	 *        
	*<b>Summary: </b>
	* doTemporarySave(除第一环节外的暂存功能)
	* @param flowInfo 流程信息
	* @throws Exception
	 */
	public void doTemporarySave(Map<Object, Object> flowInfo, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* doFlowFinish(办结活动流程业务)
	* @param flowInfo 流程信息
	* @param conn
	* @throws Exception
	 */
	public void doFlowFinish(Map<Object, Object> flowInfo, Connection conn) throws Exception;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* doTerminationFlow(终止流程业务)
	* @param flowInfo 流程信息
	* @param conn
	* @throws Exception
	 */
	public void doTerminationFlow(Map<Object, Object> flowInfo, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* doFlowBack(回退流程业务)
	* @param flowInfo
	* @param conn
	* @throws Exception
	 */
	public void doFlowBack(Map<Object, Object> flowInfo, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* startWorkflowNotCompleteFirstAct(启动下一个流程)
	* @param flowInfo
	* @throws Exception
	 */
	public void startWorkflowNotCompleteFirstAct(Map<Object, Object> flowInfo, Connection conn) throws Exception; 
	
	/**
	 * 检查某流程在某环节是否需要启动自动办结
	 * @param def_id 流程定义ID
	 * @param action_defid 流程活动定义id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean checkWorkflowNeedAutoFinish(String def_id,String action_defid,Connection conn) throws Exception;
	/**
	 * 获得流程的最后一条 有效的信息
	 * @param ins_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public Map<String,String> getLastActionMessInFlow(String ins_id,Connection conn) throws Exception;
	
}