package com.chinacreator.xtbg.core.process.workflowphone.service.impl;

import com.chinacreator.xtbg.core.process.workflowphone.eneity.ResponseConstant;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneRequestBean;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneResponseBean;
import com.chinacreator.xtbg.core.process.workflowphone.exception.ApproveWorkFlowInfoException;
import com.chinacreator.xtbg.core.process.workflowphone.exception.WorkFlowAbstractException;
import com.chinacreator.xtbg.core.process.workflowphone.service.PCWorkFlowApprove;
/**
 * 
 *<p>Title:PCWorkFlowBack.java</p>
 *<p>Description:手机调用pc流程处理类 -- 回退活动类</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */
public class PCWorkFlowBack extends PCWorkFlowApprove {

	public PCWorkFlowBack() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	* <p>Title: doWorkFlowMethod</p> 
	* <p>Description: 调用流程回退方法</p> 
	* @param workFlowPhoneRequestBean
	* @return WorkFlowPhoneResponseBean
	* @throws Exception 
	* @see com.chinacreator.xtbg.pub.workflowphone.service.PCWorkFlowHandler#doWorkFlowMethod(com.chinacreator.xtbg.pub.workflowphone.entity.WorkFlowPhoneRequestBean)
	 */
	public WorkFlowPhoneResponseBean doWorkFlowMethod(
			WorkFlowPhoneRequestBean workFlowPhoneRequestBean) throws WorkFlowAbstractException {
		super.doWorkFlowMethod(workFlowPhoneRequestBean);
		try {
			flowInstanceServiceIfc.doFlowBack(flowInfoObj, null);
		} catch (Exception e) {
			throw new ApproveWorkFlowInfoException(e.getMessage(),ResponseConstant.RESULT_CODE_03,ResponseConstant.RESULT_MESSAGE_03, "回退活动的处理程序报错！");
		}
		return null;
	}

}
