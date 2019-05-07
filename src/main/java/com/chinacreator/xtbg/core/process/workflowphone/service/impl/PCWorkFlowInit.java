package com.chinacreator.xtbg.core.process.workflowphone.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao;
import com.chinacreator.xtbg.core.dssave.entity.MdTableBean;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowDefinfoBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionExtBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InstanceBean;
import com.chinacreator.xtbg.core.process.flowprocessing.service.InitFlowServiceIfc;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.ResponseConstant;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneRequestBean;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneResponseBean;
import com.chinacreator.xtbg.core.process.workflowphone.exception.InitWorkFlowInfoException;
import com.chinacreator.xtbg.core.process.workflowphone.exception.WorkFlowAbstractException;
import com.chinacreator.xtbg.core.process.workflowphone.service.PCWorkFlowHandler;
/**
 * 
 *<p>Title:PCWorkFlowInit.java</p>
 *<p>Description:(初始化流程数据类)</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */
public class PCWorkFlowInit extends PCWorkFlowHandler {
	private InitFlowServiceIfc initFlowServiceIfc = null;
	private DsCRUDDao  dsCRUDDao = null;//通用保存DAO
	//PCWorkFlowHanlderFactory.createInitFlowServiceIfc(); 	
	
	public PCWorkFlowInit() {
		super();
		// TODO Auto-generated constructor stub
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 initFlowServiceIfc 的值 
	 * @param initFlowServiceIfc 
	 */
	public void setInitFlowServiceIfc(InitFlowServiceIfc initFlowServiceIfc) {
		this.initFlowServiceIfc = initFlowServiceIfc;
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
	* <p>Title: doWorkFlowMethod</p> 
	* <p>Description: 流程初始化方法--加载初始化数据</p> 
	* @param workFlowPhoneRequestBean
	* @return WorkFlowPhoneResponseBean
	* @throws Exception 
	* @see com.chinacreator.xtbg.pub.workflowphone.service.PCWorkFlowHandler#doWorkFlowMethod(com.chinacreator.xtbg.pub.workflowphone.entity.WorkFlowPhoneRequestBean)
	 */
	public WorkFlowPhoneResponseBean doWorkFlowMethod(
			WorkFlowPhoneRequestBean workFlowPhoneRequestBean) throws WorkFlowAbstractException{
		
		String mgrName = "";
		String isDynamicSelectUser = "";
		String isShowBack = "";
		String isSignCount = "";
		
		FlowDefinfoBean flowDefinfoBean = null; //流程定义Bean
		FlowWfactionBean flowWfactionBean = null; //活动定义Bean
		FlowWfactionExtBean flowWfactionExtBean = null;  //流程活动扩展Bean
		InstanceBean instanceBean = null; //实例Bean
		//TODO 
		//String action_id = flowUtilDao.getActionId(flow_id, actDefId)
		//flowUtilDao.getFlowWfactionBean(action_id);
		
		/**
		 * 初始化请求参数
		 */
		//workFlowPhoneRequestBean.putInitMap("operType", "isShowActSelectText@isShowUserText@isShowBackButton@isShowRecycle@isShowCompleteWorkflow@isShowTempSaveForm@isShowTerminate@isShowSuspend@isShowResume");//流程行为标识
		
		Map<String, Object> map;
		try {
			map = init(workFlowPhoneRequestBean.getInitmap());
		} catch (Exception e) {
			throw new InitWorkFlowInfoException(e.getMessage(), ResponseConstant.RESULT_CODE_02,ResponseConstant.RESULT_MESSAGE_02,"获取流程初始化数据失败！");
		}

		//begin
		if (map.get("instanceBean") != null) {
			instanceBean = (InstanceBean) map.get("instanceBean");//活动定义Bean
			workFlowPhoneRequestBean.putInitMap("status_code", instanceBean.getStatus_code());
		}

		if (map.get("flowDefinfoBean") != null) {
			flowDefinfoBean = (FlowDefinfoBean) map.get("flowDefinfoBean");//流程定义Bean
			mgrName = flowDefinfoBean.getPackage_id() + "#" + flowDefinfoBean.getFlow_version() + "#" + flowDefinfoBean.getFlow_defid();
			workFlowPhoneRequestBean.putInitMap("mgrName", mgrName);
			workFlowPhoneRequestBean.putInitMap("action_defid", flowDefinfoBean.getAction_defid());
			workFlowPhoneRequestBean.putInitMap("flow_id", flowDefinfoBean.getFlow_id());
			workFlowPhoneRequestBean.putInitMap("action_form", flowDefinfoBean.getAction_form());
			workFlowPhoneRequestBean.putInitMap("insname_rule", flowDefinfoBean.getInsname_rule());
		}

		if (map.get("flowWfactionBean") != null) {
			flowWfactionBean = (FlowWfactionBean) map.get("flowWfactionBean");//活动定义Bean
			workFlowPhoneRequestBean.putInitMap("def_id", flowWfactionBean.getDef_id());
			workFlowPhoneRequestBean.putInitMap("action_id", flowWfactionBean.getAction_id());
			workFlowPhoneRequestBean.putInitMap("action_name", flowWfactionBean.getAction_name());
		}

		if (map.get("flowWfactionExtBean") != null) {
			flowWfactionExtBean = (FlowWfactionExtBean) map
					.get("flowWfactionExtBean");//活动定义Bean
			isDynamicSelectUser = flowWfactionExtBean.getIsshowuser();
			isShowBack = flowWfactionExtBean.getIsshowback();
			//isDispense = flowWfactionExtBean.getIsdispense();
			//================
			if(!StringUtil.isBlank(flowWfactionExtBean.getIssignjoinbyorder())){
				isSignCount = flowWfactionExtBean.getIssignjoinbyorder();
			}
			if ("Y".equals(isDynamicSelectUser)) {
				isDynamicSelectUser = "true";
			} else {
				isDynamicSelectUser = "false";
			}
			if("Y".equals(isShowBack)) {
				isShowBack = "true";
			} else {
				isShowBack = "false";
			}
			/*if("Y".equals(isDispense)) {
				isDispense = "true";
			} else {
				isDispense = "false";
			}*/
			
			workFlowPhoneRequestBean.putInitMap("isDynamicSelectUser", isDynamicSelectUser);
			workFlowPhoneRequestBean.putInitMap("isShowBack", isShowBack);
			//=============会签的标记================
			workFlowPhoneRequestBean.putInitMap("isSignCount", isSignCount);
			//initmap.put("isDispense", isDispense);
		}

		if (map.get("flowinfo") != null) {
			workFlowPhoneRequestBean.putInitMap("flowinfo", map.get("flowinfo").toString());//流程信息
		}
		
		if (map.get("actionAliasAndOrderStr") != null) {
			workFlowPhoneRequestBean.putInitMap("actionAliasAndOrderStr", map.get("actionAliasAndOrderStr").toString());//环节别名与排序
		}
		
		if (map.get("actUsertList") != null) { //环节用户与是否选择人员
			workFlowPhoneRequestBean.putInitMap("actUsertList", map.get("actUsertList").toString());
		}
		
		JSONObject pageParmsjson = new JSONObject();
		pageParmsjson.put("flowParmJson", workFlowPhoneRequestBean.getInitmap());	
		workFlowPhoneRequestBean.putInitMap("pageParmsjson", pageParmsjson.toJSONString());
		/*//TODO 查询出业务数据  Map<String, List<Map<String, String>>>格式 
		Map<String, List<Map<String, String>>> dataMap = new HashMap<String, List<Map<String,String>>>();
		
		try {
			dataMap = this.getarchivedate(workFlowPhoneRequestBean.getInitmap().get("busi_id"), workFlowPhoneRequestBean.getInitmap().get("busiTypeCode"));
		} catch (Exception e) {
			throw new InitWorkFlowInfoException(e.getMessage(), ResponseConstant.RESULT_CODE_11,ResponseConstant.RESULT_MESSAGE_11,"获取业务数据失败！");
		}
		workFlowPhoneRequestBean.putInitMap("dataMap", dataMap.toString());*/
		
		workFlowPhoneResponseBean.setInitmap(workFlowPhoneRequestBean.getInitmap());
		workFlowPhoneResponseBean.setResultCode(ResponseConstant.RESULT_CODE_10);
		workFlowPhoneResponseBean.setResultStateMessage(ResponseConstant.RESULT_MESSAGE_10);

		return workFlowPhoneResponseBean;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* init(初始化流程参数)
	* @param map
	* @return
	* @throws Exception 
	 */
	public Map<String, Object> init(Map<String, String> map) throws Exception {
		return initFlowServiceIfc.init(map);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getarchivedate(根据业务主键，业务类型获取业务数据)
	* @param businessid 主键ID
	* @param busiTypeCode 业务类型
	* @return
	* @throws Exception
	 */
	public Map<String, List<Map<String, String>>> getarchivedate(String businessid, String busiTypeCode) throws Exception{
		Map<String, List<Map<String, String>>> dateMap = new HashMap<String, List<Map<String,String>>>();
		
		List<MdTableBean> listBean = dsCRUDDao.getMdTableInfo(busiTypeCode);//获取业务类型的配置信息
		//TODO 由于只有一个业务ID，所以当出现多个主表的时候会出现问题，但是满足当前只需要支持一个主表
		for(MdTableBean archiveMdTableBean:listBean){ //循环主表 
			List<Map<String, String>> list = new ArrayList<Map<String,String>>();
			String tableName = archiveMdTableBean.getTable_code();
			String tablePk = archiveMdTableBean.getTable_pk();
			list = dsCRUDDao.getBusinessDada(archiveMdTableBean,tablePk,businessid);
			
			dateMap.put(tableName, list);//set值
			if(archiveMdTableBean.getSonlist().size()>0){
				for(MdTableBean sonArchiveMdTableBean:archiveMdTableBean.getSonlist()){
					List<Map<String, String>> sonList = new ArrayList<Map<String,String>>();
					String sonTableName = sonArchiveMdTableBean.getTable_code();
					String sonTablePk = tablePk;//此处用父表的主键一次性查询出主表的所有数据
					sonList = dsCRUDDao.getBusinessDada(sonArchiveMdTableBean,sonTablePk,businessid);
					dateMap.put(sonTableName, sonList);//set值
				}
			}
		}
		return dateMap;
	}


}
