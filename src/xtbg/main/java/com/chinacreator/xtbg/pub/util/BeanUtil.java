package com.chinacreator.xtbg.pub.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 *<p>Title:RequestToBean.java</p>
 *<p>Description:request对象转换成实体对象工具类</p>
 *<p>在初始化BeanUtil时，建议先使用泛型，这样效率会高些</p>
 *<p>因为只通过反射，所以要求表单的name，必须和bean里的属性名一致,可以考虑用注解配置</p>
 *<p>如果需要转date类型的数据，请先设置日期转换格式(setDateFormat,setDateTimeFormat)，默认的日期格式为yyyy-MM-dd hh:mm:ss</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *2013-08-08
 */
public class BeanUtil<T> {
	private String defaultDateFormat = "yyyy-MM-dd";
	private String defaultDateTimeFormat = "yyyy-MM-dd hh:mm:ss";
	
	public BeanUtil(){
		
	}
	
	/**
	 * 
	*<b>Summary: request对象转换成实体对象</b>
	* requestToBean()
	* @param request	request对象
	* @param _class		将要转换的实体对象class
	* @return
	 */
	public T requestToBean(HttpServletRequest request,Class<T> _class){
		T bean = null;
		try {
			bean = (T) _class.newInstance();
			Field[] fieldArr = _class.getDeclaredFields();
			for (Field field : fieldArr) {
				String fieldName = field.getName();
				String methodName = "set"+this.capitalize(field.getName());
				String filedVal = request.getParameter(fieldName);
				if(filedVal  != null || "".equals(filedVal)){
					if(!"char".equals(field.getType())){	
						Method method = _class.getMethod(methodName,field.getType());
						Object val = covertField(field,filedVal);
						method.invoke(bean, val);
					} else {
						System.out.println("warn:the filed type is char,can not be convert!!"+"bean--"+_class.getName()+"field--"+field.getName());
					}
				}
			}
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	private Object covertField(Field field,String value) {
		String typeName = field.getType().getName();
		try {
			if("java.lang.String".equals(typeName)){
				return value;
			} else if("java.lang.Integer".equals(typeName) || "int".equals(typeName)){
				if(!"".equals(value) && value != null){
					return Integer.parseInt(value);
				} else {
					return 0;
				}
			} else if("byte".equals(typeName) || "java.lang.Byte".equals(typeName)){
				if(!"".equals(value) && value != null){
					return Byte.parseByte(value);
				} else {
					return 0;
				}
			} else if("boolean".equals(typeName) || "java.lang.Boolean".equals(typeName)){
				if(!"".equals(value) && value != null){
					return Boolean.parseBoolean(value);
				} else {
					return false;
				}
			} else if("java.util.Date".equals(typeName)){
				if(!"".equals(value) && value != null){
					Date resDate = null;
					SimpleDateFormat dateFormat = new SimpleDateFormat();
					if(value.length() == 10){
						dateFormat = new SimpleDateFormat(defaultDateFormat);
					} else if(value.length() == 19){
						dateFormat = new SimpleDateFormat(defaultDateTimeFormat);
					}
					try {
						resDate = dateFormat.parse(value);
					} catch (Exception e) {
						System.out.println("the date filed convert ERROR!! filed is : "+field.getName()+",the value is:"+value+", you can set the right format by setDateFormat or setDateTimeFormat method!");
						e.printStackTrace();
					}
					return resDate;
				} else {
					return new Date();
				}
			} else if("double".equals(typeName) || "java.lang.Double".equals(typeName)){
				if(!"".equals(value) && value != null){
					return Double.parseDouble(value);
				} else {
					return 0.0;
				}
			} else if("float".equals(typeName) || "java.lang.Float".equals(typeName)){
				if(!"".equals(value) && value != null){
					return Float.parseFloat(value);
				} else {
					return 0.0;
				}
			} else if("long".equals(typeName) || "java.lang.Long".equals(typeName)){
				if(!"".equals(value) && value != null){
					return Long.parseLong(value);
				} else {
					return 0.0;
				}
			} else if("char".equals(typeName)){
				//
			} else {
				
			}
		} catch (Exception e) {
			System.out.println("the filed convert ERROR!! this filed is : "+field.getName()+"the value is:"+value);
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 
	*<b>Summary:  首字母大写</b>
	* capitalize()
	* @param str
	* @return
	 */
	private String capitalize(String str) {
		int strLen;
		if ((str == null) || ((strLen = str.length()) == 0)) {
		return str;
		}
		return new StringBuffer(strLen).append(Character.toTitleCase(str.charAt(0))).append(str.substring(1)).toString();
	}
	
	/**
	 * 
	*<b>Summary: 设置日期格式</b>
	* setDateFormat()
	* @param dateFormat
	 */
	public void setDateFormat(String dateFormat){
		this.defaultDateFormat = dateFormat;
	}
	/**
	 * 
	*<b>Summary: 设置日期时间格式</b>
	* setDateTimeFormat()
	* @param dateTimeFormat
	 */
	public void setDateTimeFormat(String dateTimeFormat){
		this.defaultDateTimeFormat = dateTimeFormat;
	}
}
