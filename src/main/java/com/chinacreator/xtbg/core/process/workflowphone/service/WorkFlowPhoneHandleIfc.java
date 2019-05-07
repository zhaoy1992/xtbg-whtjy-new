package com.chinacreator.xtbg.core.process.workflowphone.service;

import javax.jws.WebService;

import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneRequestBean;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneResponseBean;
/**
 * 
 *<p>Title:WorkFlowPhoneHandleIfc.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */
@WebService
public interface WorkFlowPhoneHandleIfc {

	/**
	 * 手机端调用PC端流程的远程webservice方法
	 * @param WorkFlowPhoneRequestBean 请求bean
	 * @return WorkFlowPhoneResponseBean 响应bean
	 */
	public WorkFlowPhoneResponseBean workFlowPhoneHandle(WorkFlowPhoneRequestBean workFlowPhoneRequestBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* checkIsAllSignJoin(检查是否全部会签完毕)
	* @param ins_id 当前流程ins_id
	* @param action_id 当前环节action_id
	* @param curr_userid 当前用户id
	* @param order 会签顺序
	* @return
	 */
	public String checkIsAllSignJoin(String ins_id, String action_id,
			String curr_userid, String order);
}
