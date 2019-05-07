package com.chinacreator.xtbg.pub.flowinfoconif.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.enhydra.shark.xpdl.elements.Activity;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowActionFormDef;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowActionTreeConfigBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowDefInfoBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowInfoBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactUser;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactionInfoBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactionExtBean;

public interface FlowInfoDao {
	/**
	 * @Description 根据条件查询流程信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findFlowBaseInfoList(FlowInfoBean flowInfoBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 查询流程定义信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findFlowDefInfoList(FlowDefInfoBean flowDefInfoBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 查询流程活动信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findFlowWfactionInfoList(FlowWfactionInfoBean flowWfactionInfoBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	
	/**
	 * @Description 查询活动用户信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findFlowWfactionUserInfoList(FlowWfactUser flowWfactUser, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据flowid获取流程基本信息
	 * @param flowid
	 */
	public FlowInfoBean findFlowBaseInfoById(String flowid) throws SQLException;
	
	/**
	 * @Description 更新流程基本信息
	 * @param flowInfoBean
	 */
	public void updateFlowBaseInfo(FlowInfoBean flowInfoBean) throws SQLException;
	
	/**
	 * 新增流程基本信息
	 * @param flowInfoBean
	 * @return
	 */
	public String addFlowBaseInfo(FlowInfoBean flowInfoBean) throws SQLException;
	
	/**
	 * 删除流程基本信息
	 * @param flowid
	 */
	public String deleteFlowBaseInfoById(String flowids) throws SQLException;
	
	/**
	 * 根据flowid获取流程定义信息
	 * @param flowdefid
	 */
	public FlowDefInfoBean findFlowDefInfoByFlowId(String flowid) throws SQLException;
	
	/**
	 * 更新流程定义信息
	 * @param flowDefInfoBean
	 */
	public void updateFlowDefInfo(FlowDefInfoBean flowDefInfoBean) throws SQLException;
	
	/**
	 * 新增流程定义信息
	 * @param flowDefInfoBean
	 * @return
	 */
	public String addFlowDefInfo(FlowDefInfoBean flowDefInfoBean) throws SQLException;
	
	/**
	 * 删除流程定义信息
	 * @param flowdefid
	 */
	public void deleteFlowDefInfoById(String flowdefid) throws SQLException;
	
	/**
	 * 获取流程活动信息
	 * @param actionid
	 */
	public FlowWfactionInfoBean findFlowWfactionInfoById(String actionid) throws SQLException;
	
	/**
	 * 更新流程活动信息
	 * @param flowDefInfoBean
	 */
	public void updateFlowWfactionInfo(FlowWfactionInfoBean flowWfactionInfoBean) throws SQLException;
	
	/**
	 * 新增流程活动信息
	 * @param flowDefInfoBean
	 * @return
	 */
	public String addFlowWfactionInfo(FlowWfactionInfoBean flowWfactionInfoBean) throws SQLException;
	
	/**
	 * 删除流程活动信息
	 * @param flowdefid
	 */
	public void deleteFlowWfactionInfoById(String flowdefid) throws SQLException;
	
	
	
	/**
	 * 新增活动用户信息
	 * @param flowDefInfoBean
	 * @return
	 */
	public String addFlowWfactionUserInfo(FlowWfactUser flowWfactUser) throws SQLException;
	
	/**
	 * 删除活动用户信息
	 * @param flowdefid
	 */
	public void deleteFlowWfactionUserInfoById(String userids) throws SQLException;
	/**
	 * 删除活动用户信息
	 * @param action_id
	 */
	public void deleteFlowWfactionUserInfoByActionId(String action_id) throws SQLException;
	
	/**
	 * 获取活动扩展信息
	 * @param actionid
	 */
	public Map<String,String> findFlowWfactionExtInfoById(String actionid) throws Exception;
	
	/**
	 * 更新活动扩展信息
	 * @param flowDefInfoBean
	 */
	public void updateFlowWfactionExtInfo(FlowWfactionExtBean flowWfactionExtBean) throws Exception;
	
	/**
	 * 获取活动树的配置信息
	 * @param actionid
	 */
	public FlowActionTreeConfigBean findFlowWfactionTreeConfigById(String actionid) throws Exception;
	
	
	/**
	 * 当前环节是否存在树的配置信息
	 * @param actionid
	 * @return
	 * @throws SQLException
	 */
	public boolean isExsitFlowActTreeConfig(String actionid) throws Exception;
	
	/**
	 * 当前环节是否存在扩展信息
	 * @param actionid
	 * @return
	 * @throws SQLException
	 */
	public boolean isExsitFlowWfactionExtInfo(String actionid) throws SQLException;
	
	
	/**
	 * 当前环节是否存在表单配置信息
	 * @param actionid
	 * @return
	 * @throws SQLException
	 */
	public boolean isExsitFlowFormDefInfo(String actionid) throws SQLException;
	
	/**
	 * 新增活动扩展信息
	 * @param flowDefInfoBean
	 * @return
	 */
	public String addFlowWfactionExtInfo(FlowWfactionExtBean flowWfactionExtBean) throws Exception;
	

	/**
	 * 获取活动表单信息
	 * @param actionid
	 */
	public FlowActionFormDef findFlowWfactionFormDefById(String actionid) throws SQLException;
	
	/**
	 * 更新活动表单信息
	 * @param flowDefInfoBean
	 */
	public void updateFlowWfactionFormDef(FlowActionFormDef flowWfactionFormDefBean) throws SQLException;
	
	/**
	 * 新增活动表单信息
	 * @param flowDefInfoBean
	 * @return
	 */
	public String addFlowWfactionFormDef(FlowActionFormDef flowWfactionFormDefBean) throws SQLException;
	
	/**
	 * 删除活动表单信息
	 * @param flowdefid
	 */
	public void deleteFlowWfactionFormDefById(String actionid) throws SQLException;
	
	/**
	 * @Description:流程设置为无效
	 * @param ecId
	 * @throws Exception
	 */
	public void stopFlowInfo(String ecId)throws Exception;
	
	/**
	 * @Description:
	 * @param packageId
	 * @param processId
	 * @param ecId
	 * @param flowVersion
	 * @return
	 * @throws Exception
	 */
	public boolean isExistFlow(String packageId,String processId,String ecId,String flowVersion) throws Exception;
	
	/**
	 * @Description:启用流程
	 * @param ecId
	 * @param flowId
	 * @throws Exception
	 */
	public void startupFlowInfo(String flowId)throws Exception;
	
	/**
	 * @Description:是否存在环节
	 * @param flowId
	 * @return
	 * @throws Exception
	 */
	public boolean hasAct(String flowId)throws Exception;
	
	/**
	 * @Description:得到老版本流程id
	 * @param packageId
	 * @param processId
	 * @param ecId
	 * @return
	 * @throws Exception
	 */
	public String getOldFlowId(String packageId, String processId, String ecId)throws Exception;
	
	/**
	 * 获得流程环节id
	 * @return
	 * @throws SQLException 
	 */
	public List<String> getFlowAct(String flowdefId) throws SQLException;
	
	/**
	 * @Description:新增环节信息
	 * @param flowId
	 * @param packageId
	 * @param processId
	 * @param flowVersion
	 * @throws Exception
	 */
	public void insertWFAction(String flowId, String packageId,
			String processId, String flowVersion) throws Exception;
	
	public String getActionCode(String mgrName, String actionDefid) ;
	
	/**
	 * @Description:是否流程的第一个环节
	 * @param mgrName
	 * @return
	 * @throws Exception
	 */
	public boolean isFirstAct(String mgrName,String actDefId)throws Exception;
	
	/**
	 * @Description:是否流程的最后一个环节
	 * @param mgrName
	 * @param actDef
	 * @return
	 * @throws Exception
	 */
	public boolean isLastAct(String mgrName,String actDefId)throws Exception;
	/**
	 * 查询实例是否存在
	 * @param flowid
	 * @return
	 */
	public boolean queryInstance(String flowid);
	public Activity getFirstActivityByMgrName(String mgrName);
	
	public List<Activity> getLastActivityByMgrName(String mgrName);
	
		
	/**
	 * 根据flow_def_id查询出所有的活动信息
	 * @param flow_def_id
	 * @return
	 */
	public List<FlowWfactionInfoBean> getWfActionListByFlowId(String flow_def_id);
	
	/**
	 * 根据flow_def_id查询出所有的活动信息封装在map中，key是action_defid
	 * @param flow_def_id
	 * @return
	 */
	public Map<String,FlowWfactionInfoBean> getWfActionMapByFlowId(String flow_def_id);
	
	/**
	 * 根据流程id和环节定义id查询环节id
	 * @param newFlowId
	 * @param actionDefId
	 * @return
	 */
	public String getActionId(String FlowId,String actionDefId) throws Exception;
	
	/**
	 * 将老环节的用户信息复制给新环节
	 * @param oldAction_id
	 * @param newAction_id
	 * @throws Exception
	 */
	public void addActUsersInfo(String oldAction_id,String newAction_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: 获取流程扩展信息中是否前置活动执行人的下拉框</b>
	* @param defid
	* @param autoassignment
	* @return
	* @throws Exception
	 */
	public String getWfactionExtAutoassignmentDictDropDownList(String actionid,String autoassignment) throws Exception;
	
	
}
