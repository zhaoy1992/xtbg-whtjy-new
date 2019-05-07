package com.chinacreator.xtbg.core.common.commonlist;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:AjaxServlet.java</p>
 *<p>Description:ajax提交的公用servlet，未做跳转操作.
 *</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-23
 */
public class AjaxServlet extends HttpServlet {
	/**
	 * serialVersionUID:TODO（序列化id）
	 */
	private static final long serialVersionUID = 293285398428827172L;
	private static final Logger LOG = Logger.getLogger(AjaxServlet.class);
    /**
      * 
      * <b>Summary: </b>
      *     复写方法 doGet
      * @param request
      * @param response
      * @throws ServletException
      * @throws IOException 
      * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try{
			String classNameId = StringUtil.deNull(request
					.getParameter("className")); // 实现类
			String methodName = StringUtil.deNull(request.getParameter("method")); //要调用的方法名
            Class<?> clazz = Class.forName(classNameId);
            Object obj = clazz.newInstance();
            //设置字符编码集
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            //调用父类的方法初始化
            initAttribute(obj,clazz.getSuperclass(),"",request,response);
            //对像的属性初始化值
            initAttribute(obj,clazz,"",request,response);
            
            //方法调用，只支持无参数的方法
            Method method = clazz.getMethod(methodName);
                        
            method.invoke(obj);
            
		} catch (Exception e) {
			LOG.error("公用ajax类出现异常:"+e.getMessage(), e);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doPost
	  * @param req
	  * @param resp
	  * @throws ServletException
	  * @throws IOException 
	  * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}
	
  /**
	* 
	*<b>Summary: 对象的属性赋值（暂时只支持，String、Object、XtDbBaseBean及其子类的赋值.要支持其他类型请扩展） </b>
	* initAttribute()
	* @param obj   被赋值的对象
	* @param clazz
	* @param name 用于支持多层赋值，如类变量为 XtDbBaseBean bean。支持前台传入的 bean.name的赋值
	*/
	private void initAttribute(Object obj, Class<?> clazz, String name,HttpServletRequest req,HttpServletResponse resp) {
		try {
			// 获得所有公共方法
			Method[] methods = clazz.getMethods();
			Field[] fields = clazz.getDeclaredFields();// 获取私有属性
			for (Field field : fields) {
				// 获得赋值函数
				Method m = getMethod("set" + field.getName(), methods);
				if (null == m) {
					continue;
				}
				// 如果类属性中存在request，则赋值
				if ("javax.servlet.http.HttpServletRequest".equals(field
						.getType().getName())) {
					m.invoke(obj, req);
				} else if ("javax.servlet.http.HttpServletResponse"
						.equals(field.getType().getName())) {

					m.invoke(obj, resp);

				} else if ("java.lang.String".equals(field.getType().getName())
						|| "java.lang.Object".equals(field.getType().getName())) {
					// String和Object的直接赋值(其他类型的，请自行扩展)

					String value = req.getParameter(name + field.getName());
					// 传入了该参数，则赋值
					if (null != value) {
						value = DataControlUtil.replaceStr(value);
						value = Escape.unescape(value);
						m.invoke(obj, value);
					}

				}else if ("com.chinacreator.xtbg.core.common.commonlist.PageInfoBean"
						.equals(field.getType().getName())) {
					Object newObj = field.getType().newInstance();
					initAttribute(newObj, field.getType(), name
							+ field.getName() + ".", req, resp);// 前台使用"."来拼接参数和其属性
					m.invoke(obj, newObj);
				} else {
					// 基本类型，不进行赋值操作
					if (null == field.getType().getSuperclass()) {
						continue;
					}
					if ("com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean"
							.equals(field.getType().getSuperclass().getName())) {
						Object newObj = field.getType().newInstance();
						initAttribute(newObj, field.getType(), name
								+ field.getName() + ".", req, resp);// 前台使用"."来拼接参数和其属性

						m.invoke(obj, newObj);

					}
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}
	
	/**
	 * 
	*<b>Summary: 根据方法名，从方法数组中遍历得到方法</b>
	* getMethod()
	* @param methodName
	* @param methods
	* @return
	 */
	private Method getMethod(String methodName,Method[] methods){
		if(null == methodName || null == methods || methods.length == 0){
			return null;
		}
		for(Method method : methods){
			if(methodName.equalsIgnoreCase(method.getName())){
				return method;
			}
		}
		return null;
	}
}
