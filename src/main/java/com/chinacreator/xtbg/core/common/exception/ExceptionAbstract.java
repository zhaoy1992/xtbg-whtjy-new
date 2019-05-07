package com.chinacreator.xtbg.core.common.exception;

public abstract class ExceptionAbstract extends Exception {
	private String errorCode = "ES1";
	private String errorMsg = "system error.";
	private  String errorType="OTHER";

	public ExceptionAbstract(String errorCode, String errorMsg,String errorType) {
		this.errorCode = errorCode;
		this.errorMsg = errorMsg;
		this.errorType = errorType;
	}

	public ExceptionAbstract(Exception e) {
		if (e instanceof ExceptionAbstract) {
			this.errorCode = ((ExceptionAbstract) e).errorCode;
			this.errorMsg = ((ExceptionAbstract) e).errorMsg;
		} else {
			this.errorMsg = e.getMessage();
			this.errorCode = "E99";
		}
		this.errorType="OTHER";
	}
	

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public String getErrorType() {
		return errorType;
	}

	public  void setErrorType(String type){
		this.errorType = type;
	}

}
