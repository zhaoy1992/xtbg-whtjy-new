package com.chinacreator.xtbg.pub.flowinfoconif.service;

import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowActionTreeConfigBean;


public interface FlowInfoConfigServiceIfc {
	
	/**
	 * 保存流程基本信息
	 * @param flowInfoBean
	 * @return
	 */
	public String saveFlowConfigInfo(String paramjosn)  throws Exception;
	
	/**
	 * 保存流程定义信息
	 * @param flowInfoBean
	 * @return
	 */
	public void saveFlowDefInfo(String paramjosn)  throws Exception;
	
	/**
	 * 保存流程环节信息
	 * @param flowInfoBean
	 * @return
	 */
	public void saveFlowWfactionInfo(String paramjosn)  throws Exception;

	/**
	 * 保存环节用户信息
	 * @param flowInfoBean
	 * @return
	 */
	public void saveFlowWfacuserInfo(String paramjosn)  throws Exception;

	/**
	 * 保存环节扩展信息
	 * @param flowInfoBean
	 * @return
	 */
	public void saveFlowWfactionExtInfo(String paramjosn)  throws Exception;
	
	/**
	 * 保存环节表单配置信息
	 * @param flowInfoBean
	 * @return
	 */
	public void saveFlowWfactionFormDefInfo(String paramjosn)  throws Exception;
	
	/**
	 * 保存环节树的配置信息
	 * @param flowInfoBean
	 * @return
	 */
	public void saveFlowWfactionTreeConfig(FlowActionTreeConfigBean flowActionTreeConfigBean)  throws Exception;
	
	/**
	 * @Description:保存在绑定流程
	 * @param packageId
	 * @param processId
	 * @param ecId
	 * @param flowVersion
	 * @throws Exception
	 */
	public String saveFlowInfo(String packageId,String flowDefId,String flowId,String flowVersion) throws Exception;
	
	/**
	 * @Description:是否存在流程
	 * @return
	 * @throws Exception
	 */
	public boolean isExistFlow(String packageId,String processId,String ecId,String flowVersion) throws Exception;
	
	/**
	 * @Description:启用流程
	 * @param flowId
	 * @param defId
	 * @throws Exception
	 */
	public void userFlowInfo(String flowId,String defId)throws Exception;
	
	/**
	 * @Description:继承老版本流程
	 * @param oldFlowId
	 * @param newFlowId
	 * @throws Exception
	 */
	public void updateWorkflowInfo(String oldFlowId,String newFlowId)throws Exception;
	
	/**
	 * @Description:得到老版本流程id
	 * @param packageId
	 * @param processId
	 * @param ecId
	 * @return
	 * @throws Exception
	 */
	public String getOldFlowId(String packageId,String processId,String flowId)throws Exception;
	
	 
	/**
	 * 从事项配置中删除本流程 
	 * @param ecId
	 * @param flowId
	 * @return
	 * @throws Exception
	 */
	public boolean delFlowInfoByEcId(String ecId,String flowId)throws Exception;
}
