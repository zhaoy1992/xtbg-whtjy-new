package com.chinacreator.xtbg.core.process.workflowphone.eneity;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.alibaba.fastjson.JSONObject;
/**
 * 
 *<p>Title:WorkFlowPhoneRequestBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */
public class WorkFlowPhoneRequestBean {
	/**
	 * 操作类型
	 */
	private String operType ;
	
	/**
	 * 参数集合
	 */
	private Map<String,String> initmap = new HashMap<String,String>();
	
	/**
	 * 
	* @Title: putInitMap 
	* @Description: TODO(设置流程初始化数据) 
	* @param key 
	* @param value  
	 */
	public void putInitMap(String key,String value){
		initmap.put(key, value);
	}
	
	/**
	 * 
	* @Title: getInitMap 
	* @Description: TODO(获取流程初始化数据) 
	* @param key
	* @return value
	 */
	public String getInitMap(String key){
		return initmap.get(key);
	}
	
	
	

	
	public String getOperType() {
		return operType;
	}

	public void setOperType(String operType) {
		this.operType = operType;
	}


	public Map<String, String> getInitmap() {
		return initmap;
	}

	public void setInitmap(Map<String, String> initmap) {
		this.initmap = initmap;
	}

	public static void main(String[] args) {
		Map<String,String> maps = new HashMap<String,String>();
		Map<String,String> maps2 = new HashMap<String,String>();
		maps.put("a1", "111");
		maps.put("a2", "222");
		maps.put("a3", "333");
		maps2.put("a1", "222");
		maps2.put("a4", "444");
		maps.putAll(maps2);
		//Bean1 bean1 = new Bean1();
		//bean1.setA1("111");
		//bean1.setA2("222");
		//bean1.setA3("333");
		
		try {
			JSONObject pageParmsjson = new JSONObject();
			pageParmsjson.put("flowParmJson", maps);	//将map对
			//BeanUtils.copyProperties(bean1, maps);
			//System.out.println(bean1.getA1());
			//System.out.println(bean1.getA2());
			//System.out.println(bean1.getA3());
			BeanUtils.copyProperties(maps, maps2);
			//BeanUtils.populate(bean1, maps);
			//System.out.println(maps.get("a4"));
			System.out.println(pageParmsjson.toString());

		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	
}
