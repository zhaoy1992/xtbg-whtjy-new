package com.chinacreator.xtbg.core.process.processconfig.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.tree.entity.FlowActionTreeConfigBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowFormBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.OaWordTemplate;


/**
 * 
 *<p>Title:FlowInfoConfigServiceIfc.java</p>
 *<p>Description:流程配置服务类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-22
 */
public interface FlowInfoConfigServiceIfc {
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFlowConfigInfo(保存流程基本信息)
	* @param paramjosn
	* @return
	* @throws Exception
	 */
	public String saveFlowConfigInfo(String paramjosn)  throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFlowDefInfo(保存流程定义信息)
	* @param paramjosn
	* @throws Exception
	 */
	public void saveFlowDefInfo(String paramjosn)  throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFlowWfactionInfo(保存流程环节信息)
	* @param paramjosn
	* @throws Exception
	 */
	public void saveFlowWfactionInfo(String paramjosn)  throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* saveFlowWfacuserInfo(保存环节用户信息)
	* @param paramjosn
	* @throws Exception
	 */
	public void saveFlowWfacuserInfo(String paramjosn)  throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* saveFlowWfactionExtInfo(保存环节扩展信息)
	* @param paramjosn
	* @throws Exception
	 */
	public void saveFlowWfactionExtInfo(String paramjosn)  throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFlowWfactionFormDefInfo(保存环节表单配置信息)
	* @param paramjosn
	* @throws Exception
	 */
	public void saveFlowWfactionFormDefInfo(String paramjosn)  throws Exception;
	
	
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFlowInfo(保存在绑定流程)
	* @param packageId
	* @param flowDefId
	* @param flowId
	* @param flowVersion
	* @return
	* @throws Exception
	 */
	public String saveFlowInfo(String packageId,String flowDefId,String flowId,String flowVersion,String flowdesc) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* isExistFlow(是否存在流程)
	* @param packageId
	* @param processId
	* @param ecId
	* @param flowVersion
	* @return
	* @throws Exception
	 */
	public boolean isExistFlow(String packageId,String processId,String ecId,String flowVersion) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* userFlowInfo(启用流程)
	* @param flowId
	* @param defId
	* @throws Exception
	 */
	public void userFlowInfo(String flowId,String defId)throws Exception;
	
	/**
	 * 
	*<b>Summary: 继承老版本流程</b>
	* updateWorkflowInfo(继承老版本流程)
	* @param oldDefId   老的流程定义id
	* @param newDefId   新的流程定义id
	* @param oldTableId 老的业务表id
	* @throws Exception
	 */
	public boolean updateWorkflowInfo(String oldDefId,String newDefId,String oldTableId);
	
	/**
	 * 
	*<b>Summary: </b>
	* getOldFlowId(得到老版本流程id)
	* @param packageId
	* @param processId
	* @param flowId
	* @return
	* @throws Exception
	 */
	public String getOldFlowId(String packageId,String processId,String flowId)throws Exception;
	
	 
	/**
	 * 
	*<b>Summary: </b>
	* delFlowInfoByEcId(从事项配置中删除本流程 )
	* @param ecId
	* @param flowId
	* @return
	* @throws Exception
	 */
	public boolean delFlowInfoByEcId(String ecId,String flowId)throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* saveActColStatusForm(保存环节字段状态表)
	* @param paramjosn
	* @throws Exception 
	*/
	public void saveActColStatusForm(String paramjosn) throws Exception ;
	
	
	/**
	*<b>Summary: </b>
	* saveActTextStatusForm(保存活动环节正文状态)
	* @param paramjosn
	* @throws Exception 
	*/
	public void saveActTextStatusForm(String paramjosn)  throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* saveActTableBusinessMapping(保存业务数据元关系表)
	* @param table_id
	* @param busitype_code
	* @throws Exception 
	*/
	public void saveTableBusinessMapping(String table_id,
			String busitype_code) throws Exception;
	
	/**
	 * 
	*<b>Summary: 查询所有的表单信息</b>
	* queryListFlowForm(请用一句话描述这个方法的作用)
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<FlowFormBean> queryListFlowForm();
	/**
	 * 
	*<b>Summary: </b>
	* findFlowBaseInfoById(根据flowid获取流程基本信息)
	* @param flowid
	* @return
	* @throws SQLException
	 */
	public FlowInfoBean findFlowBaseInfoById(String flowid);
	/**
	 * 
	*<b>Summary: 查询流程id</b>
	* findFlowWfactionInfoList(请用一句话描述这个方法的作用)
	* @param flowId 流程id
	* @return 转换为JSONArray形式的流程id
	 */
	public String findFlowWfactionInfoList(String flowId);
	/**
	 * 
	 *<b>Summary: 根据流程id删除流程信息</b> deleteFlowBaseInfoById(删除流程基本信息)
	 * 
	 * @param flowids
	 * @return
	 * @throws SQLException
	 */
	public boolean deleteFlowBaseInfoById(String flowIds);
	/**
	 * 
	*<b>Summary:保存配置树信息 </b>
	* saveFlowWfactionTreeConfig(请用一句话描述这个方法的作用)
	* @param flowActionTreeConfigBean
	* @throws Exception
	 */
	public void saveFlowWfactionTreeConfig(
			FlowActionTreeConfigBean flowActionTreeConfigBean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryListWordTemp(查詢模板信息)
	* @return
	 */
	public List<OaWordTemplate> queryListWordTemp();
	
	/**
	 * 
	*<b>Summary: </b>
	* getFlowBaseInfoList(查询有效的流程基本信息列表)
	* @return
	 */
	public List<FlowInfoBean> getFlowBaseInfoList(FlowInfoBean flowInfoBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* getSingnConfig(获取WORD文档表单的会签内容配置)
	* @param temp_id
	* @return
	 */
	public String getSingnConfig(String temp_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* ActionInit(流程环节初始化)
	* @param new_def_id
	* @return
	 */
	public boolean ActionInit(String new_def_id);
	/**
	 * 
	*<b>Summary: </b>
	* isFlowInstance(判断流程是否被引用)
	* @param busitype_code
	* @return
	 */
	public boolean isFlowInstance(String busitype_code);
	/**
	 * 复制流程
	 *<b>Summary: </b>
	 * copyWordTemplate
	 * @param procMap
	 * @return
	 * @throws Exception
	 */
	public String copyFlowInfo(Map<Integer,String> procMap) throws Exception;
	/**
	 * 复制流程定义
	 * @param procMap
	 * @return
	 * @throws Exception
	 */
	public Map<String,String> copyFlowDefInfo(Map<Integer,String> procMap) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* deleteFlowDefInfo(根据def_id删除流程定义相关信息)
	* @param def_id
	* @return
	* @throws Exception
	 */
	public boolean deleteFlowDefInfo(String def_id)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* checkFlowDefHasIns(检测该定义是否有流程实例)
	* @param def_id
	* @return
	* @throws Exception
	 */
	public boolean checkFlowDefHasIns(String def_id) throws Exception;
}
