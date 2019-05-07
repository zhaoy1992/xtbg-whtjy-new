package com.chinacreator.xtbg.core.common.util;

 
import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.eform.util.Escape;
/**
 * 
 *<p>Title:request转化为javaBean工具类</p>
 *<p>Description:request转化为javaBean工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-18
 */
public class RequestBeanUtils {  
  
    final static String PREFFIX = "set";  
      
    /** 
     *  
     * 把request中的值赋给Object对象,也就是把request中的parameter和object属性对应的时候 
     * 把object中的属性赋值,使用标准的bean 
     * @param  request 
     * @param  target 目标bean 
     * @return 封装之后的bean 
     * @throws Exception 
     */  
    @SuppressWarnings("unchecked")  
    public static Object getValuesByRequest(HttpServletRequest request,Object target) throws Exception {  
        Enumeration<String> keys = request.getParameterNames();  
        Map<String, String> valueMap = getValuesMap(request, keys);  
        getObject(valueMap, target, null,null);  
        return target;  
    }
  
    public static Map<String, String> getValueMapByRequest(HttpServletRequest request) throws Exception {  
        Enumeration<String> keys = request.getParameterNames();  
        Map<String, String> valueMap = getValuesMap(request, keys);  
        return valueMap;  
    }  
  
    /** 
     *  
     * @see    把request中的值赋给Object对象,也就是把request中的parameter和object属性对应的时候 
     *         把object中的属性赋值,使用标准的bean 
     * @param  request 
     * @param  target 目标bean 
     * @param  unSetProperties 不复制的对象 
     * @return 封装之后的bean 
     * @throws Exception 
     */  
    @SuppressWarnings("unchecked")  
    public static Object getValuesByRequest(HttpServletRequest request,  
            Object object,  String[] unSetProperties)throws Exception {  
        Enumeration<String> keys = request.getParameterNames();  
        Map<String, String> valueMap = getValuesMap(request, keys);  
        getObject(valueMap, object, unSetProperties,null);  
        return object;  
    }  
  
    /** 
     *  
     * @see    把request中的值赋给Object对象,也就是把request中的parameter和object属性对应的时候 
     *         把object中的属性赋值,使用标准的bean 
     * @param  request 
     * @param  target 目标bean 
     * @param  unSetProperties 不复制的对象 
     * @param  proertiesMap 不一致属性匹配 
     * @return 封装之后的bean 
     * @throws Exception 
     */  
    @SuppressWarnings("unchecked")  
    public static Object getValuesByRequest(HttpServletRequest request,  
            Object object,  String[] unSetProperties,Map<String,String> proertiesMap)  
            throws Exception {  
        Enumeration<String> keys = request.getParameterNames();  
        Map<String, String> valueMap = getValuesMap(request, keys);  
        getObject(valueMap, object, unSetProperties,proertiesMap);  
        return object;  
    }  
      
    /** 
     * 获取request参数及值map(键值对) 
     * @param request 
     * @param keys 
     * @return 
     * @throws Exception 
     */  
    protected static Map<String, String> getValuesMap(  
            HttpServletRequest request, Enumeration<String> keys) throws Exception {  
        if (keys == null)  
            return null;  
        Map<String, String> value = new HashMap<String, String>();  
		while (keys.hasMoreElements()) {
			String element = keys.nextElement();
			/**
			 * 将值转码，有些环境存在url传的值乱码
			 * 
			 * @alter by 戴连春
			 * @alter date 2013-8-27
			 */
			String paramValue = Escape.unescape(DataControlUtil
					.replaceStr(request.getParameter(element)));
			value.put(element, paramValue);
		}  
        return value;  
    }  
  
    /** 
     * 转化javaBean 
     * @param valueMap request获取的键值 
1        * @param object javaBean对象 
     * @param unSetProperties 不复制的对象 
     * @param proertiesMap 不一致属性匹配 
     * @return 
     * @throws Exception 
     */  
    protected static Object getObject(Map<String, String> valueMap,  
            Object object, String[] unSetProperties,Map<String,String> proertiesMap) throws Exception {  
        List<String> unSet = null;  
        if (unSetProperties != null)  
            unSet=java.util.Arrays.asList(unSetProperties);  
        if (valueMap == null)  
            return null;  
        for (Iterator<String> iter=valueMap.keySet().iterator();iter.hasNext();) {  
            String key = iter.next();  
            if (unSet != null && unSet.contains(key)) {  
                continue;  
            }  
            String methodValue = valueMap.get(key);  
            if(proertiesMap!=null && proertiesMap.containsKey(key)){  
                key=proertiesMap.get(key);  
            }  
            if (methodValue != null)  
                setValue(object, key, methodValue);  
        }  
        return object;  
    }  
  
    /** 
     * 给javaBean中的属性字段赋值 
     * @param obj  javaBean对象 
     * @param name bean属性 
     * @param value 值 
     * @throws Exception 
     */  
    protected static void setValue(Object obj, String name, String value)  
            throws Exception {  
        Field field = null;  
        try {  
            field = obj.getClass().getDeclaredField(name);  
        } catch (Exception e) {  
            return;  
        }  
        if (field == null) {  
            return;  
        }  
        Method method = obj.getClass().getDeclaredMethod(  
                getSetMethodName(name), field.getType());  
        String type = field.getGenericType().toString();  
        if(type.equals("int") || type.equals("class java.lang.Integer")){  
            if(value!=null && !value.equals("")){  
                method.invoke(obj, Integer.parseInt(value));  
            }  
        }else if(type.equals("double") || type.equals("class java.lang.Double")){  
            if(value!=null && !value.equals("")){  
                method.invoke(obj, Double.valueOf(value));  
            }  
        }else if(type.equals("float") || type.equals("class java.lang.Float")){  
            if(value!=null && !value.equals("")){  
                method.invoke(obj, Float.valueOf(value));  
            }  
        }else if(type.equals("char") || type.equals("class java.lang.Character")){  
            if(value!=null && !value.equals("")){  
                method.invoke(obj, Character.valueOf(value.charAt(0)));  
            }  
        }else if(type.equals("class java.util.Date")){  
            if(value!=null && !value.equals("")){  
                String format = value.length()==10?"yyyy-MM-dd":"yyyy-MM-dd HH:mm:ss";  
                SimpleDateFormat sdf = new SimpleDateFormat(format);  
                method.invoke(obj, sdf.parse(value));  
            }                  
        }else if(type.equals("class java.sql.Timestamp")){  
            if(value!=null && !value.equals("")){  
                String format = value.length()==10?"yyyy-MM-dd":"yyyy-MM-dd HH:mm:ss";  
                SimpleDateFormat sdf = new SimpleDateFormat(format);  
                method.invoke(obj, new Timestamp(sdf.parse(value).getTime()));  
            }  
        }else{  
            method.invoke(obj, value);  
        }  
    }  
  
    /** 
     * bean属性转化为set方法 
     * @param methodName 
     * @return 
     */  
    protected static String getSetMethodName(String methodName) {  
        String first = methodName.substring(0, 1);  
        String suffex = methodName.substring(1);  
        return (PREFFIX + first.toUpperCase() + suffex).toString();  
    }  
    
    
    /**
    *<b>Summary: </b>
    * getValuesByRequestObj(把request的参数组装成对象)
    * @param request
    * @param target 类名
    * @param modelName json对象名
    * @return
    * @throws Exception 
    */
    @SuppressWarnings("unchecked")  
    public static Object getValuesByRequestObj(HttpServletRequest request,Object target,String modelName) throws Exception {  
    	Enumeration<String> keys = request.getParameterNames();  
    	Map<String, String> valueMapOk = new HashMap<String, String>(); 
        Map<String, String> valueMap = getValuesMap(request, keys);  
        for (String key : valueMap.keySet()) {
        	if(key.indexOf(modelName)>=0){
	        	valueMapOk.put(clearData(key,modelName), valueMap.get(key));
        	}
        }
        getObject(valueMapOk, target, null,null);  
        return target;   
    }
    
    
    /**
    *<b>Summary: </b>
    * clearData(完善数据)
    * @param key
    * @param modelName
    * @return 
    */
    public static String clearData(String key,String modelName){
    	String str = key;
    	str=str.replace(modelName, "");
    	str = str.substring(1, str.length()-1);
    	return str;
    }
    
    
    /**
    *<b>Summary: </b>
    * transBean2Map(利用java.beans.Introspector和java.beans.PropertyDescriptor实现 javaBean转为Map<String,String>)
    * @param obj
    * @return 
    */
    public static Map<String, String> transBean2Map(Object obj) {
        if(obj == null){
            return null;
        }        
        Map<String, String> map = new HashMap<String, String>();
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());//通过类 Introspector 来获取某个对象的 BeanInfo 信息
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();//然后通过 BeanInfo 来获取属性的描述器PropertyDescriptor
            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();//再利用属性描述器获取某个属性对应的 getter/setter 方法
                // 过滤class属性
                if (!key.equals("class") && !key.equals("tableName") && !key.equals("pKey") && !key.equals("updateKey") && !key.equals("deleteKey")) {
                    //通过反射机制 得到property对应的getter方法
                    Method getter = property.getReadMethod();
                    String value = (String) getter.invoke(obj);
                    map.put(key, value);
                }
            }
        } catch (Exception e) {
            System.out.println("transBean2Map Error " + e);
        }
        return map;
    }
}  
