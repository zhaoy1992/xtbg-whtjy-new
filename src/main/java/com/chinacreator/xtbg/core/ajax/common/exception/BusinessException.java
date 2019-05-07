package com.chinacreator.xtbg.core.ajax.common.exception;

public class BusinessException extends ExceptionAbstract {

	/**
	 * 
	 */
	private static final long serialVersionUID = 18985142114L;
	
	public BusinessException(String errorCode, String errorMsg) {
		super(errorCode, errorMsg,"BUSINESS");
	}
	
	public BusinessException(Exception e){
		super(e);
	}
	public BusinessException(String errorCode){
		super(errorCode, "","BUSINESS");
	}
}
