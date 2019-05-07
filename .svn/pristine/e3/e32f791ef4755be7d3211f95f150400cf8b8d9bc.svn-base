package com.chinacreator.business.common.action.process;


import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.business.common.bean.BusinessBean;
import com.chinacreator.business.common.bean.ResultBean;
import com.chinacreator.business.common.exception.BusinessException;
import com.chinacreator.business.common.exception.DatabaseException;
import com.chinacreator.business.common.exception.ExceptionAbstract;
import com.chinacreator.business.common.exception.FileException;
import com.chinacreator.business.common.exception.InterException;
import com.chinacreator.business.common.exception.SystemException;
import com.chinacreator.business.common.publuc.Dictionary;
import com.chinacreator.business.common.publuc.SysErrorCodeDictionary;
import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.business.common.validation.ValidationProcess;
import com.chinacreator.security.AccessControl;
import com.chinacreator.sysmgrcoreext.manager.IOrgManagerExt;
import com.chinacreator.sysmgrcoreext.manager.bean.UserOrgStatusBean;
import com.chinacreator.sysmgrcoreext.manager.db.OrgManagerExtImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
/**
 *<p>Title:RequestProcess.java</p>
 *<p>Description:请求处理类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南</p>
 *@author 沈联成
 *@version 1.0
 *@date 2012-11-20
 */
public class RequestProcess {
	
	private static final Logger logger = Logger.getLogger(CacheCommonManage.class);
	private static RequestProcess uniqueInstance = null;
	
	private  RequestProcess(){
		logger.debug("init RequestProcess ...");
	}
	public static RequestProcess getInstance(){
		if (uniqueInstance == null) {
			uniqueInstance = new RequestProcess();
		}
		return uniqueInstance;
	}
	/**
	 * 值对像转换
	 * @param bean
	 */
	public void transformRequestParam(BusinessBean bean) {
		HttpServletRequest req = bean.getRequest();
		req.getParameterNames();
		Enumeration enu = req.getParameterNames();
    	while( enu.hasMoreElements()){
    		String key = enu.nextElement().toString();
    		bean.setParam(key, req.getParameter(key));
    	}
	}
	/**
	 * 请求转换编码格式
	 * @param bean
	 * @throws SystemException
	 */
	public void setCharacterEncoding(BusinessBean bean) throws SystemException{
		HttpServletRequest req = bean.getRequest();
		try {
			//得到编码格式
			String charset = CacheCommonManage.getInstance().getSystemParam(Dictionary.SYS_CHARSET);
			if("".equals(charset)){
				charset = "UTF-8";//默认编码格式
			}
			req.setCharacterEncoding(charset);
		} catch (UnsupportedEncodingException e) {
			throw new SystemException(SysErrorCodeDictionary.OTHER_ERROR,e.getMessage());
		}
	}
	
	/**
	 * 校验
	 * @param bean
	 * @throws DatabaseException 
	 * @throws InterException 
	 * @throws FileException 
	 * @throws BusinessException 
	 */
	public void validatonProcess(BusinessBean bean) throws SystemException, BusinessException, FileException, InterException, DatabaseException{
		//特殊校验 权限校验
		HttpServletRequest req  = bean.getRequest();
		//实现单点登陆（保留） 
		
		//先调用平台校验方法
		String methodName = bean.getParam("methodName");
		String classID = bean.getParam("classID");
		String openRule =(String)CacheCommonManage.getInstance().getAction(classID+"RULE");
		boolean isOpenRule = true;
		if(null != openRule && !"".equals(openRule) && (","+openRule+",").indexOf(","+methodName+",") > -1){
			isOpenRule = false;
		}
		if (isOpenRule) {
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(req, bean.getResponse());
			if (!accesscontroler.checkAccess(req, bean.getResponse())) {
				// 未登陆直接报异常
				throw new SystemException(
						SysErrorCodeDictionary.NOT_LOGIN_ERROR);
			}

			// 把公共的参数传到BusinessBean
			String userId = accesscontroler.getUserID();
			String userName = accesscontroler.getUserName();
			String userKey = accesscontroler.getUserAccount();
			String orgId = accesscontroler.getChargeOrgId();
			/*获取用户所有的机构，包括主机构和隶属机构*/
			IOrgManagerExt om = new OrgManagerExtImpl();
			List<UserOrgStatusBean> orglist = om.getCurrentOrg(userId);
			
			String parentDeptID = "";
			if (null != accesscontroler.getChargeOrg())
				parentDeptID = accesscontroler.getChargeOrg().getParentId();

			String orgName = accesscontroler.getChargeOrgName();
			bean.setUserDeptID(orgId);
			bean.setUserID(userId);
			bean.setUserDeptName(orgName);
			bean.setUserName(userName);
			bean.setUserKey(userKey);
			bean.setParentDeptID(parentDeptID);
			bean.setAllOrgList(orglist);
		}
		
		//调用校验
		ValidationProcess.getInstance().valdation(bean);
	}
	/**
	 * 核心分发类
	 * @param bean
	 * @return
	 * @throws SystemException
	 * @throws BusinessException
	 * @throws FileException
	 * @throws InterException
	 * @throws DatabaseException
	 */
	public Object distribution(BusinessBean bean)  throws ExceptionAbstract{
		String methodName = bean.getParam("methodName");
		String classID = bean.getParam("classID");
		Object obj = CacheCommonManage.getInstance().getAction(classID);
		if(null == obj){
			obj = LoadSpringContext.getApplicationContext().getBean(classID);
		}
		if(null == obj){
			throw new SystemException(SysErrorCodeDictionary.NO_CLASS_ERROR);
		}
		Method method = null;
		try {
			method = obj.getClass().getDeclaredMethod(methodName,
					BusinessBean.class);
		} catch (SecurityException e) {
			throw new SystemException(SysErrorCodeDictionary.FUN_ERROR,e.getMessage());
		} catch (NoSuchMethodException e) {
			throw new SystemException(SysErrorCodeDictionary.FUN_ERROR);
		}
		try {
			obj = method.invoke(obj, new Object[] { bean });
		} catch (IllegalArgumentException e) {
			throw new SystemException(SysErrorCodeDictionary.FUN_ERROR);
		} catch (IllegalAccessException e) {
			throw new SystemException(SysErrorCodeDictionary.FUN_ERROR);
		} catch (InvocationTargetException e) {
			if( e.getTargetException() instanceof ExceptionAbstract){
				throw ((ExceptionAbstract) e.getTargetException());
			}else{
				throw new SystemException(SysErrorCodeDictionary.FUN_INVOKE_ERROR);
			}
		}
		return obj;
	}
	
	/**
	 * 核心返回值处理类
	 * @param bean
	 * @return
	 * @throws SystemException
	 */
	public void responseProcess(ResultBean result,BusinessBean bean){
		HttpServletResponse resp = bean.getResponse();
		resp.setContentType("text/plain; charset=UTF-8");
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setDateHeader("Expires", 0);
		PrintWriter write;
		try {
			write = resp.getWriter();
			String resultString = JSONObject.toJSON(result).toString();
			write.print("var response="+resultString+";");
			write.flush();
			write.close();
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
	}

}
