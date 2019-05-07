package com.chinacreator.xtbg.core.process.workflowphone.eneity;

import java.util.HashMap;
import java.util.Map;
/**
 * 
 *<p>Title:WorkFlowPhoneResponseBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */
public class WorkFlowPhoneResponseBean {
	/**
	 * 执行结果状态码
	 */
	private String resultCode = "";
	/**
	 * 执行结果状态消息
	 */
	private String resultStateMessage = "";
	
	/**
	 * 异常信息
	 */
	private String exceptionMessage = "";
	
	/**
	 * 参数集合
	 */
	private Map<String,String> initmap = new HashMap<String,String>();
	
	
	public WorkFlowPhoneResponseBean() {
		super();
	}

	/*public WorkFlowPhoneResponseBean(String resultCode,
			String resultStateMessage) {
		super();
		this.resultCode = resultCode;
		this.resultStateMessage = resultStateMessage;
	}*/

	/**
	 * 
	* @Title: putInitMap 
	* @Description: TODO(设置流程初始化数据) 
	* @param key 
	* @param value  
	 */
	public void putInitMap(String key,String value){
		initmap.put(key, value);
	}
	
	/**
	 * 
	* @Title: getInitMap 
	* @Description: TODO(获取流程初始化数据) 
	* @param key
	* @return value
	 */
	public String getInitMap(String key){
		return initmap.get(key);
	}

	public Map<String, String> getInitmap() {
		return initmap;
	}

	public void setInitmap(Map<String, String> initmap) {
		this.initmap = initmap;
	}

	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	public String getResultStateMessage() {
		return resultStateMessage;
	}

	public void setResultStateMessage(String resultStateMessage) {
		this.resultStateMessage = resultStateMessage;
	}

	public String getExceptionMessage() {
		return exceptionMessage;
	}

	public void setExceptionMessage(String exceptionMessage) {
		this.exceptionMessage = exceptionMessage;
	}
	
	
	
}
