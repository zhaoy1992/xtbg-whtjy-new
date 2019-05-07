package com.chinacreator.xtbg.core.process.workflowphone.service;

import com.chinacreator.xtbg.core.process.workflowphone.eneity.ResponseConstant;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneRequestBean;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneResponseBean;
import com.chinacreator.xtbg.core.process.workflowphone.exception.WorkFlowAbstractException;
/**
 * 
 *<p>Title:PCWorkFlowHandler.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */

public abstract class PCWorkFlowHandler {
	protected WorkFlowPhoneResponseBean workFlowPhoneResponseBean = new WorkFlowPhoneResponseBean();

	public PCWorkFlowHandler() {
		super();
		workFlowPhoneResponseBean.setResultCode(ResponseConstant.RESULT_CODE_01);
		workFlowPhoneResponseBean.setResultStateMessage(ResponseConstant.RESULT_MESSAGE_01);
		// TODO Auto-generated constructor stub
	}
	
	/**
	* 
	* @Title: doWorkFlowMethod 
	* @Description: TODO(执行流程中的方法) 
	* @param workFlowPhoneRequestBean  流程请求bean
	* @return WorkFlowPhoneResponseBean    返回类型 
	* @throws
	*/
	public abstract WorkFlowPhoneResponseBean doWorkFlowMethod(WorkFlowPhoneRequestBean workFlowPhoneRequestBean)  throws WorkFlowAbstractException;


	
}
