package com.chinacreator.xtbg.core.process.workflowphone.exception;
/**
 * 
 *<p>Title:InitWorkFlowInfoException.java</p>
 *<p>Description:自定义业务异常</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */
public class InitWorkFlowInfoException extends WorkFlowAbstractException {

	/** 
	* @Fields serialVersionUID : TODO(序列化) 
	*/ 
	
	private static final long serialVersionUID = 1L;

	public InitWorkFlowInfoException(String info, String state,
			String messageTypeDesc, String message) {
		super(info, state, messageTypeDesc, message,"init");
		// TODO Auto-generated constructor stub
	}
	
	
	
}
