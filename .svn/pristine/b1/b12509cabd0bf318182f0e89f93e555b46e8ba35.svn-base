package com.chinacreator.business.common.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinacreator.business.common.action.process.RequestProcess;
import com.chinacreator.business.common.bean.BusinessBean;
import com.chinacreator.business.common.bean.ResultBean;
import com.chinacreator.business.common.exception.ExceptionAbstract;
import com.chinacreator.business.common.exception.SystemException;
import com.chinacreator.business.common.tools.CacheCommonManage;

/**
 * <p>
 * Title:BusinessAction.java
 * </p>
 * <p>
 * Description:请求处理的分发类
 * </p>
 * <p>
 * Copyright:Copyright (c) 2012
 * </p>
 * <p>
 * Company:湖南
 * </p>
 * 
 * @author 沈联成
 * @version 1.0
 * @date 2012-11-20
 */
public class BusinessAction extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -558855254488888L;
	
	static{
		try {
			CacheCommonManage.getInstance().init();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 方法GET
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// 新建对像
		BusinessBean bean = new BusinessBean();
		bean.setRequest(req);
		bean.setResponse(resp);
		// 处理实例
		RequestProcess reqProcess = RequestProcess.getInstance();
		Object respObject = null;
		ExceptionAbstract err = null;
		// 转换request
		try {
			reqProcess.setCharacterEncoding(bean);
			reqProcess.transformRequestParam(bean);
			reqProcess.validatonProcess(bean);
			 respObject = reqProcess.distribution(bean);
			
		} catch (ExceptionAbstract e) {
			err = e;
		} 
		ResultBean resultBean = new ResultBean();
		if(null != respObject){
			resultBean.setResult(respObject);
		}
		if(null != err){
			resultBean.setErrorMag(err.getErrorMsg());
			resultBean.setErrorType(err.getErrorType());
			resultBean.setResultCode(err.getErrorCode());
		}
		reqProcess.responseProcess(resultBean, bean);
	}

}
