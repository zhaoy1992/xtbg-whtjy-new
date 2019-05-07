package com.chinacreator.xtbg.core.ajax.common.exception;

public class InterException  extends ExceptionAbstract {

	/**
	 * 
	 */
	private static final long serialVersionUID = 189185142114L;
	
	public InterException(String errorCode, String errorMsg) {
		super(errorCode, errorMsg,"INTER");
	}
	
	public InterException(Exception e){
		super(e);
	}
	public InterException(String errorCode){
		super(errorCode, "","INTER");
	}
}
