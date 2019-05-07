package com.chinacreator.xtbg.core.process.flowprocessing.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.agency.entity.FlowAgencyInfoBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowActionUserBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowDefinfoBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionExtBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InsViewListBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InstanceBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowActionTreeConfigBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactUser;



/**
 * 
 *<p>Title:FlowUtilDao.java</p>
 *<p>Description:流程工具接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-22
 */
public interface FlowUtilDao {

	/**
	 * 
	*<b>Summary: </b>
	* getFlowDefBean(获得流程定义Bean)
	* @param orgId 用户机构ID
	* @param busiTypeCode  流程业务类型编码
	* @return
	* @throws SQLException
	 */
	public FlowDefinfoBean getFlowDefBean(String orgId, String busiTypeCode) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getFlowDefBean(获得流程定义Bean)
	* @param flow_id 流程ID
	* @return
	* @throws SQLException
	 */
	public FlowDefinfoBean getFlowDefBean(String flow_id) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getFlowviewlist(获得流程意见List)
	* @param ins_id
	* @return
	* @throws SQLException
	 */
	public List<InsViewListBean> getFlowviewlist(String ins_id) throws SQLException;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getMiddleFlowDefBean(获得流程定义Bean)
	* @param def_id 流程ID
	* @return
	* @throws SQLException
	 */
	public FlowDefinfoBean getMiddleFlowDefBean(String def_id) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActionId(获得活动定义ID)
	* @param def_id 流程主键ID
	* @param action_defid 活动定义ID
	* @return
	 */
	public String getActionId(String def_id, String action_defid) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActionName(获得活动定义ID)
	* @param def_id 流程主键ID
	* @param action_defid 活动定义ID
	* @return
	 */
	public String getActionName(String def_id, String action_defid) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActionFrom(获得表单)
	* @param action_id 活动ID
	* @return
	* @throws Exception
	 */
	public String getActionFrom(String action_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getFlowWfactionBean(获得活动定义Bean)
	* @param action_id 活动ID
	* @return
	* @throws SQLException
	 */
	public FlowWfactionBean getFlowWfactionBean(String action_id) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getInstanceBean(获得实例Bean)
	* @param ins_id 实例ID
	* @return
	* @throws SQLException
	 */
	public InstanceBean getInstanceBean(String ins_id) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getFlowActionExtBean(获得活动扩展信息)
	* @param action_id
	* @return
	 */
	public FlowWfactionExtBean getFlowActionExtBean(String action_id) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActionAlias(获得环节别名Dao接口方法)
	* @param flowId 流程ID
	* @param actDefId 环节定义ID
	* @return
	* @throws Exception
	 */
	public String getActionAlias(String flowId, String actDefId) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActionOrder(获得环节顺序Dao实现方法)
	* @param flowId
	* @param actDefId
	* @return
	* @throws Exception
	 */
	public String getActionOrder(String flowId, String actDefId) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getNextActUser(根据FLOWID和活动定义ID，取得下一环节执行人列表 )
	* @param flowId 流程ID
	* @param nextActId 下一环节ID
	* @return
	* @throws Exception
	 */
	public String getNextActUser(String flowId, String nextActId)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActivityProperty(根据事项id，流程名称，活动定义id,属性名称查询出下个环节的执行人)
	* @param moduleId
	* @param procName
	* @param activityId
	* @param propertyName
	* @return
	 */
	public String getActivityProperty(String moduleId, String procName, String activityId, String propertyName);
	
	/**
	 * 
	*<b>Summary: </b>
	* getAction_Id(通过业务流程ID，与环节定义ID获得环节ID)
	* @param flow_id
	* @param actDefId
	* @return
	* @throws Exception
	 */
	public String getAction_Id(String flow_id, String actDefId) throws Exception; 
	
	/**
	 * 
	*<b>Summary: </b>
	* getActUser(获得环节的用户)
	* @param action_id
	* @return
	* @throws Exception
	 */
	public List<FlowWfactUser> getActUser(String action_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getCountersignType(获得会签类型)
	* @return
	* @throws Exception
	 */
	public String getCountersignType(String action_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActOrderUser(获取环节的用户，已经排序)
	* @param action_id
	* @return
	* @throws Exception
	 */
	public List<FlowWfactUser> getActOrderUser(String action_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActionTreeConfig(获取环节活动树配置表信息)
	* @param action
	* @return
	* @throws Exception
	 */
	public FlowActionTreeConfigBean getActionTreeConfig(String action_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActAutoassignmentUser(获取环节的用户)
	* @param action_id
	* @param ins_id
	* @param ins_id
	* @return
	* @throws Exception
	 */
	public List<FlowWfactUser> getActAutoassignmentUser(String action_id, String ins_id, String autoassignment) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getUserIds(通过用户登陆名称查询用户ID)
	* @param userrelnames
	* @return
	* @throws Exception
	 */
	public String getUserIds(String userrelnames) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActionUserBeanList(获取环节任务表用户列表)
	* @param ins_id
	* @return
	* @throws Exception
	 */
	public List<FlowActionUserBean> getActionUserBeanList(String ins_id, Connection con)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* save(添加委托代办记录)
	* @param bean
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean save(FlowAgencyInfoBean bean, Connection con)throws Exception;
	
	/**
	 * 判断当前环节是否是会签环节
	 * @param ins_id
	 * @return
	 * @throws Exception
	 */
	public boolean isSignAction(String ins_id)throws Exception;
	
	/**
	 * 根据实例ID获取当前环节实例ID
	 * @param ins_id
	 * @return
	 * @throws Exception
	 */
	public String isActInsId(String ins_id) throws Exception;
	
   /**
	* 
	*<b>Summary:检查是否全部会签完毕 </b>
	* checkIsAllSignJoin(请用一句话描述这个方法的作用)
	* @param ins_id
	* @param action_id
	* @param curr_userid
	* @param order
	* @return
	* @throws Exception
	*/
	public JSONObject checkIsAllSignJoin(String ins_id,String action_id,String curr_userid,String order) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getDocmentAttachIdByInsId(根据流程实例ID，获取配置的正文ID，附件ID)
	* @param ins_id
	* @return Map<String,String> key :"zw_id" (正文ID)  key:"fj_id"（附件ID） 。。 无法获取是key里的值为空
	 */
	public Map<String,String> getDocmentAttachIdByInsId(String ins_id,Connection conn);
}
