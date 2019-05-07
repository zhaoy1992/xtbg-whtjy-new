package com.chinacreator.xtbg.core.file.list;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.file.dao.FileFilesDao;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;

/**
 * 
 *<p>Title:FileFilesList.java</p>
 *<p>Description:查询档案信息</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-16
 */
public class FileFilesList extends DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(FileFilesList.class);
	//档案实体类，接收前台传入的参数
	private FileFilesBean bean;
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		try {
			FileFilesDao dao = (FileFilesDao) LoadSpringContext
					.getApplicationContext().getBean("fileFilesDaoImpl");
			pb = dao.findFilesPageBean(bean, sortName, sortOrder, offset,
					maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pb;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	

	public FileFilesBean getBean() {
		return bean;
	}

	public void setBean(FileFilesBean bean) {
		this.bean = bean;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 init
	  * @param req
	  * @param res 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#init(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public void init(HttpServletRequest req,HttpServletResponse res) { 
		 super.init(req, res);
		 Class<?> clazz = this.getClass();
		 initAttribute(this,clazz,"",req);
	}
	
	/**
	 * 
	*<b>Summary: 对象的属性赋值（暂时只支持，String、Object、XtDbBaseBean及其子类的赋值） </b>
	* initAttribute()
	* @param obj
	* @param clazz
	* @param name
	 */
	private void initAttribute(Object obj, Class<?> clazz, String name,HttpServletRequest req) {
		try {
			// 获得所有公共方法
			Method[] methods = clazz.getMethods();
			Field[] fields = clazz.getDeclaredFields();// 获取私有属性
			for (Field field : fields) {
				// 获得赋值函数
				Method m = getMethod("set" + field.getName(), methods);
				if(null == m){
					continue;
				}
				//如果类属性中存在request，则赋值
				if ("java.lang.String".equals(field.getType().getName())
						|| "java.lang.Object".equals(field.getType().getName())) {
					//String和Object的直接赋值(其他类型的，请自行扩展)
					
						String value = req.getParameter(name + field.getName());
						//传入了该参数，则赋值
						if(null != value){
							value = DataControlUtil.replaceStr(value);
							value= Escape.unescape(value);
							m.invoke(obj, value);		
						}
					
				} else {
					//基本类型，不进行赋值操作
					if(null == field.getType().getSuperclass()){
						continue;
					}
					if ("com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean"
							.equals(field.getType().getSuperclass().getName())) {
						Object newObj = field.getType().newInstance();
						initAttribute(newObj, field.getType(), name
								+ field.getName() + ".", req);// 前台使用"."来拼接参数和其属性
						
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
