package com.chinacreator.xtbg.core.process.processconfig.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.enhydra.shark.xpdl.elements.Activity;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.tree.entity.FlowActionTreeConfigBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.ActColStatusBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.ActTextStatusBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowActionFormDef;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowDefInfoBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowFormBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactUser;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionExtBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionInfoBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.OaWordTemplate;

/**
 * 
 *<p>Title:FlowInfoDao.java</p>
 *<p>Description:流程配置Dao类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-22
 */
/**
 *<p>
 * Title:FlowInfoDao.java
 * </p>
 *<p>
 * Description:
 * </p>
 *<p>
 * Copyright:Copyright (c) 2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 黄海
 *@version 1.0 2013-5-31
 */
public interface FlowInfoDao {

	/**
	 * 
	 *<b>Summary: </b> findFlowBaseInfoList(根据条件查询流程信息)
	 * 
	 * @param flowInfoBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean findFlowBaseInfoList(FlowInfoBean flowInfoBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;

	/**
	 * 
	 *<b>Summary: </b> findFlowDefInfoList(查询流程定义信息)
	 * 
	 * @param flowDefInfoBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean findFlowDefInfoList(FlowDefInfoBean flowDefInfoBean,
			String sortName, String sortOrder, long offset, int maxPagesize);

	/**
	 * 
	 *<b>Summary: </b> findFlowWfactionInfoList(查询流程活动信息)
	 * 
	 * @param flowWfactionInfoBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean findFlowWfactionInfoList(
			FlowWfactionInfoBean flowWfactionInfoBean, String sortName,
			String sortOrder, long offset, int maxPagesize);

	/**
	 * 
	 *<b>Summary: </b> findFlowWfactionUserInfoList(查询活动用户信息)
	 * 
	 * @param flowWfactUser
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean findFlowWfactionUserInfoList(FlowWfactUser flowWfactUser,
			String sortName, String sortOrder, long offset, int maxPagesize);

	/**
	 * 
	 *<b>Summary: </b> findFlowBaseInfoById(根据flowid获取流程基本信息)
	 * 
	 * @param flowid
	 * @return
	 * @throws SQLException
	 */
	public FlowInfoBean findFlowBaseInfoById(String flowid) throws SQLException;
	/**
	 * 
	*<b>Summary: </b>
	* findFlowBaseInfoByCode(根据busitype_code获取流程基本信息)
	* @param code
	* @return
	* @throws SQLException
	 */
	public Map<String, String> findFlowBaseInfoByCode(String code) throws SQLException;
	/**
	 * 
	 *<b>Summary: </b> updateFlowBaseInfo(更新流程基本信息)
	 * 
	 * @param flowInfoBean
	 * @throws SQLException
	 */
	public void updateFlowBaseInfo(FlowInfoBean flowInfoBean)
			throws SQLException;

	/**
	 * 
	 *<b>Summary:新增流程基本信息 </b> addFlowBaseInfo(新增流程基本信息)
	 * 
	 * @param flowInfoBean
	 * @return 新的流程id
	 * @throws Exception
	 */
	public String addFlowBaseInfo(FlowInfoBean flowInfoBean) throws Exception;

	/**
	 * 
	 *<b>Summary:新增流程基本信息 </b> addFlowBaseInfo(新增流程基本信息)
	 * 
	 * @param flowInfoBean
	 * @param conn
	 *            数据库连接
	 * @return 新的流程id
	 * @throws Exception
	 */
	public String addFlowBaseInfo(FlowInfoBean flowInfoBean, Connection conn)
			throws Exception;

	/**
	 * 
	 *<b>Summary: </b> deleteFlowBaseInfoById(删除流程基本信息)
	 * 
	 * @param flowids
	 * @return
	 * @throws SQLException
	 */
	public String deleteFlowBaseInfoById(String flowids, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> findFlowDefInfoByFlowId(根据flowid获取流程定义信息)
	 * 
	 * @param flowid
	 * @return
	 * @throws SQLException
	 */
	public FlowDefInfoBean findFlowDefInfoByFlowId(String flowid)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> updateFlowDefInfo(更新流程定义信息)
	 * 
	 * @param flowDefInfoBean
	 * @throws SQLException
	 */
	public void updateFlowDefInfo(FlowDefInfoBean flowDefInfoBean)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> addFlowDefInfo(新增流程定义信息)
	 * 
	 * @param flowDefInfoBean
	 * @return
	 * @throws SQLException
	 */
	public String addFlowDefInfo(FlowDefInfoBean flowDefInfoBean,
			Connection conn) throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> addFlowDefInfo(新增流程定义信息)
	 * 
	 * @param flowDefInfoBean
	 * @return
	 * @throws SQLException
	 */
	public String addFlowDefInfo(FlowDefInfoBean flowDefInfoBean)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> deleteFlowDefInfoById(删除流程定义信息)
	 * 
	 * @param flowdefid
	 * @throws SQLException
	 */
	public void deleteFlowDefInfoById(String flowdefid) throws SQLException;
	/**
	 * 
	 *<b>Summary: </b> deleteFlowDefInfo(删除流程定义信息以及关联信息)
	 * 
	 * @param def_id
	 * @throws SQLException
	 */
	public void deleteFlowDefInfo(String def_id,Connection conn) throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> deleteFlowDefInfoById(删除流程定义信息)
	 * 
	 * @param flowdefid
	 * @throws SQLException
	 */
	public void deleteFlowDefInfoById(String flowdefid, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> findFlowWfactionInfoById(获取流程活动信息)
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 */
	public FlowWfactionInfoBean findFlowWfactionInfoById(String actionid)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> updateFlowWfactionInfo(更新流程活动信息)
	 * 
	 * @param flowWfactionInfoBean
	 * @throws SQLException
	 */
	public void updateFlowWfactionInfo(FlowWfactionInfoBean flowWfactionInfoBean)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> addFlowWfactionInfo(新增流程活动信息)
	 * 
	 * @param flowWfactionInfoBean
	 * @return
	 * @throws SQLException
	 */
	public String addFlowWfactionInfo(FlowWfactionInfoBean flowWfactionInfoBean)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> deleteFlowWfactionInfoById(删除流程活动信息)
	 * 
	 * @param flowdefid
	 * @throws SQLException
	 */
	public void deleteFlowWfactionInfoById(String flowdefid)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> deleteFlowWfactionInfoById(删除流程活动信息)
	 * 
	 * @param flowdefid
	 * @throws SQLException
	 */
	public void deleteFlowWfactionInfoById(String flowdefid, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> addFlowWfactionUserInfo(删除流程活动信息)
	 * 
	 * @param flowWfactUser
	 * @return
	 * @throws SQLException
	 */
	public String addFlowWfactionUserInfo(FlowWfactUser flowWfactUser)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> deleteFlowWfactionUserInfoById(删除活动用户信息)
	 * 
	 * @param actionid
	 * @throws SQLException
	 */
	public void deleteFlowWfactionUserInfoById(String actionid)
			throws SQLException;

	/**
	 * 获取活动扩展信息
	 * 
	 * @param actionid
	 */
	public Map<String, String> findFlowWfactionExtInfoById(String actionid)
			throws Exception;

	/**
	 * 
	 *<b>Summary: </b> updateFlowWfactionExtInfo(更新活动扩展信息)
	 * 
	 * @param flowWfactionExtBean
	 * @throws SQLException
	 */
	public void updateFlowWfactionExtInfo(
			FlowWfactionExtBean flowWfactionExtBean) throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> isExsitFlowWfactionExtInfo(当前环节是否存在扩展信息)
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 */
	public boolean isExsitFlowWfactionExtInfo(String actionid)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> isExsitFlowFormDefInfo(当前环节是否存在表单配置信息)
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 */
	public boolean isExsitFlowFormDefInfo(String actionid) throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> addFlowWfactionExtInfo(新增活动扩展信息)
	 * 
	 * @param flowWfactionExtBean
	 * @return
	 * @throws SQLException
	 */
	public String addFlowWfactionExtInfo(FlowWfactionExtBean flowWfactionExtBean)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> findFlowWfactionFormDefById(获取活动表单信息)
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 */
	public FlowActionFormDef findFlowWfactionFormDefById(String actionid)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> updateFlowWfactionFormDef(更新活动表单信息)
	 * 
	 * @param flowWfactionFormDefBean
	 * @throws SQLException
	 */
	public void updateFlowWfactionFormDef(
			FlowActionFormDef flowWfactionFormDefBean) throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> addFlowWfactionFormDef(新增活动表单信息)
	 * 
	 * @param flowWfactionFormDefBean
	 * @return
	 * @throws SQLException
	 */
	public String addFlowWfactionFormDef(
			FlowActionFormDef flowWfactionFormDefBean) throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> deleteFlowWfactionFormDefById(删除活动表单信息)
	 * 
	 * @param actionid
	 * @throws SQLException
	 */
	public void deleteFlowWfactionFormDefById(String actionid)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> stopFlowInfo(流程设置为无效)
	 * 
	 * @param ecId
	 * @throws Exception
	 */
	public void stopFlowInfo(String ecId) throws Exception;

	/**
	 * 
	 *<b>Summary: </b> stopFlowInfo(流程设置为无效)
	 * 
	 * @param ecId
	 * @throws Exception
	 */
	public void stopFlowInfo(String ecId, Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary: </b> isExistFlow(是否存在流程)
	 * 
	 * @param packageId
	 * @param processId
	 * @param ecId
	 * @param flowVersion
	 * @return
	 * @throws Exception
	 */
	public boolean isExistFlow(String packageId, String processId, String ecId,
			String flowVersion) throws Exception;

	/**
	 * 
	 *<b>Summary: </b> startupFlowInfo(启用流程)
	 * 
	 * @param flowId
	 * @throws Exception
	 */
	public void startupFlowInfo(String flowId) throws Exception;

	/**
	 * 
	 *<b>Summary: </b> startupFlowInfo(启用流程)
	 * 
	 * @param flowId
	 * @throws Exception
	 */
	public void startupFlowInfo(String flowId, Connection conn)
			throws Exception;

	/**
	 * 
	 *<b>Summary: </b> hasAct(是否存在环节)
	 * 
	 * @param flowId
	 * @return
	 * @throws Exception
	 */
	public boolean hasAct(String flowId, Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary: </b> getOldFlowId(得到老版本流程id)
	 * 
	 * @param packageId
	 * @param processId
	 * @param ecId
	 * @return
	 * @throws Exception
	 */
	public String getOldFlowId(String packageId, String processId, String ecId)
			throws Exception;

	/**
	 * 
	 *<b>Summary: </b> getFlowAct(获得流程环节id)
	 * 
	 * @param flowdefId
	 * @return
	 * @throws SQLException
	 */
	public List<String> getFlowAct(String flowdefId) throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> getFlowAct(获得流程环节id)
	 * 
	 * @param flowdefId
	 * @return
	 * @throws SQLException
	 */
	public List<String> getFlowAct(String flowdefId, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> insertWFAction(新增环节信息)
	 * 
	 * @param flowId
	 * @param packageId
	 * @param processId
	 * @param flowVersion
	 * @throws Exception
	 */
	public void insertWFAction(String flowId, String packageId,
			String processId, String flowVersion) throws Exception;
	/**
	 * 
	 *<b>Summary: </b> insertWFAction(新增环节信息)
	 * 
	 * @param flowId
	 * @param packageId
	 * @param processId
	 * @param flowVersion
	 * @throws Exception
	 */
	public void insertWFAction(String flowId, String packageId,
			String processId, String flowVersion,Connection conn) throws Exception;
	/**
	 * 
	 *<b>Summary: </b> getActionCode(请用一句话描述这个方法的作用)
	 * 
	 * @param mgrName
	 * @param actionDefid
	 * @return
	 * @throws Exception
	 */
	public String getActionCode(String mgrName, String actionDefid)
			throws Exception;

	/**
	 * 
	 *<b>Summary: </b> isFirstAct(是否流程的第一个环节)
	 * 
	 * @param mgrName
	 * @param actDefId
	 * @return
	 * @throws Exception
	 */
	public boolean isFirstAct(String mgrName, String actDefId) throws Exception;

	/**
	 * 
	 *<b>Summary: </b> isLastAct(是否流程的最后一个环节)
	 * 
	 * @param mgrName
	 * @param actDefId
	 * @return
	 * @throws Exception
	 */
	public boolean isLastAct(String mgrName, String actDefId) throws Exception;

	/**
	 * 
	 *<b>Summary: </b> queryInstance(查询实例是否存在)
	 * 
	 * @param flowid
	 * @return
	 */
	public boolean queryInstance(String flowid) throws SQLException;

	/**
	 * 
	 *<b>Summary: </b> getFirstActivityByMgrName(获得第一环节的环节实例)
	 * 
	 * @param mgrName
	 * @return
	 */
	public Activity getFirstActivityByMgrName(String mgrName);

	/**
	 * 
	 *<b>Summary: </b> getLastActivityByMgrName(获得最后环节的环节实例)
	 * 
	 * @param mgrName
	 * @return
	 */
	public List<Activity> getLastActivityByMgrName(String mgrName);

	/**
	 *<b>Summary: </b> findActColStatusList(由条件1业务类型和条件2活动id获得环节字段状态表记录)
	 * 
	 * @param businessType
	 * @param actionId
	 * @return
	 * @throws SQLException
	 */
	public List<ActColStatusBean> findActColStatusList(String businessType,
			String actionId) throws SQLException;

	/**
	 *<b>Summary: </b> updateActColStatusForm(更新环节字段状态表记录)
	 * 
	 * @param actColStatusBean
	 * @throws SQLException
	 */
	public void updateActColStatusForm(ActColStatusBean actColStatusBean)
			throws SQLException;

	/**
	 * <b>Summary: </b> insertActColStatusForm(新增环节字段状态表记录)
	 * 
	 * @param actColStatusBean
	 * @throws SQLException
	 */
	public void insertActColStatusForm(ActColStatusBean actColStatusBean)
			throws SQLException;

	/**
	 *<b>Summary: </b> updateActColStatusForm(根据actionId获取流程活动表正文状态控制表)
	 * 
	 * @param actionId
	 * @return
	 */
	public ActTextStatusBean findActTextStatusBeanById(String actionId)
			throws SQLException;

	/**
	 *<b>Summary: </b> updateActTextStatusForm(更新环节正文状态表记录)
	 * 
	 * @param actTextStatusBean
	 * @throws SQLException
	 */
	public void updateActTextStatusForm(ActTextStatusBean model)
			throws SQLException;

	/**
	 * <b>Summary: </b> insertActTextStatusForm(新增正文字段状态表记录)
	 * 
	 * @param actTextStatusBean
	 * @throws SQLException
	 */
	public void insertActTextStatusForm(ActTextStatusBean model)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: 获取流程扩展信息中是否前置活动执行人的下拉框</b>
	 * 
	 * @param defid
	 * @param autoassignment
	 * @return
	 * @throws Exception
	 */
	public String getWfactionExtAutoassignmentDictDropDownList(String actionid) throws Exception;

	/**
	 *<b>Summary: </b> insertActTableBusinessMapping(保存业务数据元关系表)
	 * 
	 * @param table_id
	 * @param busitype_code
	 * @throws SQLException
	 */
	public void insertTableBusinessMapping(String table_id, String busitype_code)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: 查询所有的表单信息</b> queryListFlowForm(请用一句话描述这个方法的作用)
	 * 
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<FlowFormBean> queryListFlowForm(Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: 查询流程信息列表</b> findFlowWfactionInfoList(请用一句话描述这个方法的作用)
	 * 
	 * @param flowId
	 * @return
	 * @throws SQLException
	 */
	public List<String> findFlowWfactionInfoList(String flowId)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: 业务数据元关系表的数据</b> deleteBusinessMappingByFlowId(请用一句话描述这个方法的作用)
	 * 
	 * @param flowids
	 *            流程id
	 * @param conn
	 *            数据库连接
	 * @throws SQLException
	 *             数据库操作异常
	 */
	public void deleteBusinessMappingByFlowId(String flowids, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary:查询环节树配置信息 </b> findFlowWfactionTreeConfigById(请用一句话描述这个方法的作用)
	 * 
	 * @param actionid
	 * @return
	 * @throws Exception
	 */
	public FlowActionTreeConfigBean findFlowWfactionTreeConfigById(
			String actionid) throws Exception;

	/**
	 * 
	 * <b>Summary: </b> 复写方法 isExsitFlowActTreeConfig
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao#isExsitFlowActTreeConfig(java.lang.String)
	 */
	public boolean isExsitFlowActTreeConfig(String actionid) throws Exception;
	
	/**
	 * 
	 *<b>Summary: 流程继承老版本信息</b> copyConfigInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param oldDefId
	 *            老的流程定义id
	 * @param newDefId
	 *            新的流程定义id
	 * @param oldTableId
	 *            老的业务表id
	 * @return
	 * @throws SQLException 
	 */
	public void copyConfigInfo(String newDefId, String oldDefId,
			String oldTableId, Connection conn) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryListWordTemp(查詢WORD模板文件)
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<OaWordTemplate> queryListWordTemp(Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getFlowBaseInfoList(查询有效的流程基本信息列表)
	* @return
	* @throws Exception
	 */
	public List<FlowInfoBean> getFlowBaseInfoList(FlowInfoBean flowInfoBean,Connection conn)throws Exception;

	
	/**
	*<b>Summary: </b>
	* querySingnConfig(查询WORD文档会签配置)
	* @param conn
	* @return 
	*/
	public String querySingnConfig(String temp_id,Connection conn) throws Exception ;

	
	/**
	*<b>Summary: </b>
	* insertActionInit(初始化环节配置信息)
	* @param new_def_id
	* @param conn 
	*/
	public void insertActionInit(String new_def_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isFlowInstance(判断流程是否被引用)
	* @param busitype_code
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean isFlowInstance(String busitype_code, Connection conn) throws Exception;
	
	/**
	 * 
	 *<b>Summary: </b>
	 * copyFlowInfo(复制流程(包括基本信息))
	 * @param procMap
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public String copyFlowInfo(Map<Integer,String> procMap, Connection conn) throws Exception;
	/**
	 *<b>Summary: </b>
	 * copyFlowDefInfo(复制流程(不包括基本信息)) 
	 * @param procMap
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public Map<String,String> copyFlowDefInfo(Map<Integer,String> procMap, Connection conn) throws Exception;
	
	/**
	 *流程是否存在 
	 */
	public boolean isExistFlowIns(String def_id)throws Exception;
	/**
	 *流程的正文信息是否存在 
	 */
	public Integer selectFlowByActionId(String action_id)throws Exception;
	/**
	 *修改流程中的正文可编辑状态
	 */
	public void updateTextEdite(String action_id,String is_readOnly,Connection conn)throws Exception;
}
