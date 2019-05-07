package com.chinacreator.xtbg.core.process.flowprocessing.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowActionUserBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InsWfactionBean;

/**
 *<p>Title:FlowInstanceDataSaveDao.java</p>
 *<p>Description:流程实例业务数据保存接口类</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-1
 */
public interface FlowInstanceDataSaveDao {

	/**
	 * 
	*<b>Summary: </b>
	* saveForTempFromNew(保存新办件暂存)
	* @param flowInfo 流程业务数据
	* @param con
	* @throws Exception
	 */
	public void saveForTempFromNew(Map<Object, Object> flowInfo, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveForRepeatedlyTemp(保存反复暂存)
	* @param flowInfo 流程业务数据
	* @param con
	* @throws Exception
	 */
	public void saveForRepeatedlyTemp(Map<Object, Object> flowInfo, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveForAcceptFromNew(保存流程数据)
	* @param flowInfo 流程业务数据
	* @param con
	* @throws Exception
	 */
	public void saveForAcceptFromNew(Map<Object, Object> flowInfo, Connection con) throws Exception;
	
	/**
	*<b>Summary: </b>
	* saveForAcceptFromTemp(从暂存受理时保存办件数据)
	* @param flowInfo 流程业务数据
	* @param con
	* @return
	* @throws Exception
	 */
	public void saveForAcceptFromTemp(Map<Object, Object> flowInfo,  Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveForCompleteAct(保存完成活动的信息)
	* @param flowInfo 流程业务数据
	* @param con
	* @throws Exception
	 */
	public void saveForCompleteAct(Map<Object, Object> flowInfo,  Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveForGeneralFinish(保存办结活动的信息)
	* @param flowInfo
	* @param con
	* @return
	* @throws Exception
	 */
	public void saveForGeneralFinish(Map<Object, Object> flowInfo,  Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveForTerminationFlow(保存终止流程的信息)
	* @param flowInfo
	* @param con
	* @throws Exception
	 */
	public void saveForTerminationFlow(Map<Object, Object> flowInfo,  Connection con) throws Exception;
	
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getActHanderUser(获得已处理该环节的人)
	* @param act_insid
	* @return
	* @throws Exception
	 */
	public String getActHanderUser(String act_insid, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* addInswfaction(添加环节实例表)
	* @param flowActionUserBean
	* @param con
	* @throws Exception
	 */
	public void addInswfaction(InsWfactionBean insWfactionBean, Connection con) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateInswfaction(修改环节实例表)
	* @param action_handername
	* @param act_insidorIns_id
	* @param status_code
	* @throws Exception
	 */
	public void updateInswfaction(String action_handername ,String act_insidorIns_id, String status_code, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateRecycleInswfaction(修改追回状态)
	* @param ins_id
	* @param con
	* @throws Exception
	 */
	public void updateRecycleInswfaction(String ins_id, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* addFlow_actionuser(添加待办用户)
	* @param flowActionUserBean
	* @param con
	* @throws Exception
	 */
	public void addFlow_actionuser(FlowActionUserBean flowActionUserBean, Connection con) throws Exception;
	
	

	/**
	 * 
	*<b>Summary: </b>
	* updateFlow_actionuser(修改待办用户的处理状态)
	* @param flowActionUserBean
	* @param con
	* @throws Exception
	 */
	public void updateFlow_actionuser(FlowActionUserBean flowActionUserBean, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getFlowActionUserBean(获得该环节实例是否有产生了用户实例)
	* @param act_insid
	* @param user_name
	* @param con
	* @return
	* @throws Exception
	 */
	public FlowActionUserBean getFlowActionUserBean(String act_insid,String user_name, Connection con) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getFlowActionUserBean(获得该环节实例基本信息)
	* @param act_insid
	* @param user_name
	* @param con
	* @return
	* @throws Exception
	 */
	public FlowActionUserBean getActionUserBean(String act_insid,String user_name, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* delFlow_actionuser(删除待办用户)
	* @param act_insid
	* @param con
	* @throws Exception
	 */
	public void delFlow_actionuser(String act_insid,Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* addCountersignUser(添加会签用户)
	* @param act_defid
	* @param processid
	* @param con
	* @throws Exception
	 */
	public void addCountersignUser(String act_defid, String processid, Connection con) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* delCountersignUser(删除会签用户)
	* @param act_defid
	* @param processid
	* @param con
	* @throws Exception
	 */
	public void delCountersignUser(String act_defid,String processid, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getCountersignUser(获得会签执行人)
	* @param actDefid
	* @param con
	* @return
	* @throws Exception
	 */
	public String getCountersignUser(String actDefid, String processid, Connection con) throws Exception;
		
	/**
	 * 
	*<b>Summary: </b>
	* sendToFile(送档案待归档)
	* @param saveData
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean sendToFile(Map<String,String> saveData, Connection con) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getNumberNo(根据业务ID获取文号)
	* @param busi_id
	* @param conn
	* @return 
	*/
	public String getNumberNo(String busi_id, Connection conn)throws Exception;
	
	/**
	 * delFlow(删除流程实例) 
	 * @param ins_id 流程实例ID
	 * @param conn 数据库连接
	 * @return
	 */
	public boolean delFlowIns(String ins_id,Connection conn)  throws Exception;
	
	/**
	 * delShakeFlow(删除平台流程实例) 
	 * @param ins_code 平台流程实例ID
	 * @param conn 数据库连接
	 * @return
	 */
	public boolean delShakeFlow(String ins_code,Connection conn)  throws Exception;
	
	
	/**
	  * <b>Summary: 根据传阅性主键ID 修改记录的查看的状态未查看  “1” 已查看 </b>
	  *     复写方法 updateFlowActInsState
	  * @param circularize_id
	  * @param user_id
	  * @param is_view
	  * @return
	  * @throws Exception 
	 */
	public boolean updateFlowActInsState(String circularize_id ,String user_id,String is_view) throws Exception ;
}
