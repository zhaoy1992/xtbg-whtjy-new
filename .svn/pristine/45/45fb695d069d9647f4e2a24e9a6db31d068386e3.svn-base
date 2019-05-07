package com.chinacreator.xtbg.core.common.util;


/**
 *<p>Title:ResultCode.java</p>
 *<p>Description:状态码父类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 陈建华
 *@version 1.0
 *Jan 26, 2014
 */
public class AResultCode {
	private String code;
	private String value;
	
	protected AResultCode(String code){
		this.code = code;
	}
	protected AResultCode(String code,String value){
		this.code = code;
		this.value = value;
	}
	
	public static final AResultCode OK = new AResultCode("0","操作成功");
	public static final AResultCode FAIL = new AResultCode("0-001","操作失败");
	//未定义错误，-2，private，外部不能调用此错误代码，系统内部使用，初始化时需要这个错误代码
	public static final AResultCode UNDEFINED = new AResultCode("0-002","未知错误");
	
	/**
	 * 
	*<b>Summary: 自定义状态描述，前提是这个状态对象已存在了</b>
	* setCode()
	* @param resultCode
	* @param desc
	* @return
	 */
	public static AResultCode getCode(AResultCode resultCode,String value){
		if(resultCode != null ){
			AResultCode rc = new AResultCode(resultCode.code,value);
			resultCode = rc;
		} else {
			resultCode = AResultCode.UNDEFINED;
		}
		return resultCode;
	}
	
	/**
	 * 
	*<b>Summary: 得到状态码</b>
	* getCode()
	* @return
	 */
	public String getCode() {
		return code;
	}
	/**
	 * 
	*<b>Summary: 设置状态码</b>
	* setCode()
	* @param code
	 */
	public void setCode(String code) {
		this.code = code;
	}
	/**
	 * 
	*<b>Summary: 得到状态描述</b>
	* getDesc()
	* @return
	 */
	public String getValue() {
		return value;
	}
	/**
	 * 
	*<b>Summary: 设置状态描述</b>
	* setDesc()
	* @param desc
	 */
	public void setValue(String value) {
		this.value = value;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + ((value == null) ? 0 : value.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AResultCode other = (AResultCode) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (value == null) {
			if (other.value != null)
				return false;
		} else if (!value.equals(other.value))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "[code:"+code+",value:"+value+"]";
	}
}
