package com.chinacreator.xtbg.core.process.workflowphone.exception;
/**
 * 
 *<p>Title:WorkFlowAbstractException.java</p>
 *<p>Description:自定义业务异常</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */
public abstract class WorkFlowAbstractException extends Exception{
	
	private static final long serialVersionUID = 1L;
	
	/**
	 * 异常信息
	 */
	protected String info = "";
	/**
	 * 异常状态码
	 */
	protected String state = "";
	/**
	 * 异常类型描述
	 */
	protected String message_type_desc = "";
	/**
	 * 异常状态消息
	 */
	protected String message = "";
	
	/**
	 * 异常类型
	 */
	protected String exception_type = "";
	
	
	public WorkFlowAbstractException(String info, String state,
			String messageTypeDesc, String message, String exceptionType) {
		super();
		this.info = info;
		this.state = state;
		message_type_desc = messageTypeDesc;
		this.message = message;
		exception_type = exceptionType;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getMessage_type_desc() {
		return message_type_desc;
	}
	public void setMessage_type_desc(String messageTypeDesc) {
		message_type_desc = messageTypeDesc;
	}
	public String getException_type() {
		return exception_type;
	}
	public void setException_type(String exceptionType) {
		exception_type = exceptionType;
	}
	@Override
	public String toString() {
		return "[exception_type=" + exception_type
				+ ", info=" + info + ", message=" + message
				+ ", message_type_desc=" + message_type_desc + ", state="
				+ state + "]";
	}
	
	
	
	
	
}
