package com.chinacreator.xtbg.core.process.workflowphone.service.impl;

import com.chinacreator.xtbg.core.process.flowprocessing.util.FlowStaticTHreadData;
import com.chinacreator.xtbg.core.process.workflowphone.dao.PCWorkFlowDao;
import com.chinacreator.xtbg.core.process.workflowphone.dao.impl.PCWorkFlowDaoImpl;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.ResponseConstant;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneRequestBean;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneResponseBean;
import com.chinacreator.xtbg.core.process.workflowphone.exception.ApproveWorkFlowInfoException;
import com.chinacreator.xtbg.core.process.workflowphone.exception.WorkFlowAbstractException;
import com.chinacreator.xtbg.core.process.workflowphone.service.PCWorkFlowApprove;

/**
 * 
 *<p>Title:PCWorkFlowComplete.java</p>
 *<p>Description:(手机调用pc流程处理类 -- 完成活动类) </p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */
public class PCWorkFlowComplete extends PCWorkFlowApprove {
	
	public PCWorkFlowComplete() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	* <p>Title: doWorkFlowMethod</p> 
	* <p>Description: </p> 
	* @param workFlowPhoneRequestBean
	* @return WorkFlowPhoneResponseBean
	* @throws Exception 
	* @see com.chinacreator.xtbg.pub.workflowphone.service.PCWorkFlowHandler#doWorkFlowMethod(com.chinacreator.xtbg.pub.workflowphone.entity.WorkFlowPhoneRequestBean)
	 */
	public WorkFlowPhoneResponseBean doWorkFlowMethod(
			WorkFlowPhoneRequestBean workFlowPhoneRequestBean) throws WorkFlowAbstractException {
			super.doWorkFlowMethod(workFlowPhoneRequestBean);
		
			try {
				flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,flowData.get("def_id"),nextActList,flowTache,nextActId);
			} catch (Exception e) {
				throw new ApproveWorkFlowInfoException(e.getMessage(),ResponseConstant.RESULT_CODE_03,ResponseConstant.RESULT_MESSAGE_03, "完成活动的初始化流程数据报错！");
			}
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
	    	//获得流程静态参数
			FlowStaticTHreadData.setMgrName(flowData.get("mgrName"));
			FlowStaticTHreadData.setBuisinessId(flowData.get("ins_id"));
			FlowStaticTHreadData.setModuleId(flowData.get("flow_id"));
			FlowStaticTHreadData.setAction_form(flowData.get("action_form"));
			FlowStaticTHreadData.setDynamicperformer(DYNAMICPERFORMER);
			//特检院OA 解决流程中转失败的问题 2014-07-22 start
			FlowStaticTHreadData.setDefId(flowData.get("def_id"));
			//特检院OA 解决流程中转失败的问题 2014-07-22 end
			try {
	    		//保存意见表信息 start
	    		PCWorkFlowDao pCWorkFlowDao = new PCWorkFlowDaoImpl();
	    		pCWorkFlowDao.saveCompleteActView(flowInfoObj, null);
	    		//保存意见表信息 start
	    		flowInstanceServiceIfc.doCompleteAct(flowInfoObj, null);
			} catch (Exception e) {
				throw new ApproveWorkFlowInfoException(e.getMessage(),ResponseConstant.RESULT_CODE_03,ResponseConstant.RESULT_MESSAGE_03, "完成活动的处理程序报错！");
			} finally{
				//删除流程静态参数
				FlowStaticTHreadData.removeAll();
			}
			
		workFlowPhoneResponseBean.setResultCode(ResponseConstant.RESULT_CODE_10);
		workFlowPhoneResponseBean.setResultStateMessage(ResponseConstant.RESULT_MESSAGE_10);

		return workFlowPhoneResponseBean;
	}
	

	
	
	

}
