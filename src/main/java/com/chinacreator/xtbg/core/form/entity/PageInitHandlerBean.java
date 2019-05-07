package com.chinacreator.xtbg.core.form.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 自定义表单生成的JSP页面初始化时  数据处理bean
 *<p>Title:PageInitHandlerBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2013-12-31
 */
public class PageInitHandlerBean {
	/**
	 * 下拉列表框[name="默认值"]的值
	 * 位置:自定义表单配置-->配置属性页面   
	 */
	private LinkedHashMap<String,String> defaultData = new LinkedHashMap<String,String>();
	/**
	 * 生成的JSP页面的String变量 名称
	 * 位置:*.JSP-->java脚本   
	 */
	private List<String> defaultDataVariName = new ArrayList<String>();

	private void init(){
		defaultDataVariName.add("user_id");
		defaultDataVariName.add("user_name");
		defaultDataVariName.add("org_id");
		defaultDataVariName.add("org_name");
		defaultDataVariName.add("unit_id");
		defaultDataVariName.add("unit_name");
		defaultDataVariName.add("time");
		defaultDataVariName.add("date");
		defaultDataVariName.add("user_worktel");
		defaultDataVariName.add("user_mobiletel1");
		
		defaultData.put("{user_id}", "用户ID");
		defaultData.put("{user_name}", "用户名称");
		defaultData.put("{org_id}", "部门ID");
		defaultData.put("{org_name}", "部门名称");
		defaultData.put("{unit_id}", "单位ID");
		defaultData.put("{unit_name}", "单位名称");
		defaultData.put("{time}", "当前时间1");
		defaultData.put("{date}", "当前时间2");
		defaultData.put("{user_name + date}", "用户名时间1（yyyy-MM-dd）");
		defaultData.put("{user_name + time}", "用户名时间2（yyyy-MM-dd hh-mm-ss）");
		defaultData.put("{user_worktel}", "公司电话");
		defaultData.put("{user_mobiletel1}", "手机号码");
	}
	/**
	 * 页面处理对象(顶级)
	 */
	public static final String TOP_PAGE_HANDLER = "com.chinacreator.xtbg.core.form.entity.PageInitHandlerBean";
	/**
	 *构造方法
	 */
	public PageInitHandlerBean(){
		init();
	}
	
	
	/**
	 * 获得当前request需要的处理对象
	 */
	private PageInitHandlerBean getRealBean(HttpServletRequest request){
		String pageInitClass = request.getParameter("from_ext_parm");//table.field=[oa_form_config.from_ext_parm]
		if(StringUtil.nullOrBlank(pageInitClass)){
			pageInitClass = PageInitHandlerBean.TOP_PAGE_HANDLER;
		}
		PageInitHandlerBean bean = null;
		try{
			bean = (PageInitHandlerBean)Class.forName(pageInitClass).newInstance();
		}catch(Exception e){
			bean = new PageInitHandlerBean();
		}
		return bean;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getJavaString(为JSP页面生成时,创建java脚本)
	 * @param request
	 * @return
	 */
	public final String getJavaString(HttpServletRequest request){
		PageInitHandlerBean bean = this.getRealBean(request);
		StringBuffer javaCode = new StringBuffer();
		String className = bean.getClass().getName();
		javaCode.append(className+" pihBean = new "+className+"();\r\n");
		javaCode.append("Map<String,String> pihBeanmap = pihBean.getPageDefaultData(request,response);\r\n");
		
		List<String> varArr = bean.getPageDefaultDataVarName();
		for (String string : varArr) {
			javaCode.append("String "+string+" = pihBeanmap.get(\""+string+"\");\r\n");
		}
		return javaCode.toString();
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getPageDefaultData(为JSP页面初始化默认值Map)
	 * 
	 * 在 getJavaString方法中调用
	 * 扩展时有必要重写
	 * @param request
	 * @param response
	 * @return
	 */
	public Map<String,String> getPageDefaultData(HttpServletRequest request,HttpServletResponse response){
		Map<String,String> map = new HashMap<String,String>();
		AccessControl ac = AccessControl.getInstance();
		ac.checkAccess(request, response);
		String user_id = ac.getUserID();//用户id
		map.put("user_id", user_id);
		String user_name = ac.getUserName();//用户名
		map.put("user_name", user_name);
		map.put("time", DateUtil.getCurrentDateTime());//当前时间
		map.put("date", DateUtil.getCurrentDate());//当日期
		UserCacheBean userBean = UserCache.getUserCacheBean(user_id);
		String org_id = userBean.getOrg_id();//所属部门id
		map.put("org_id", org_id);
		String org_name = userBean.getOrg_name();//所属部门名
		map.put("org_name", org_name);
		String unit_id = userBean.getUnit_id();    //所属单位id
		map.put("unit_id", unit_id);
		String unit_name =  userBean.getUnit_name();//所属单位名
		map.put("unit_name", unit_name);
		String user_worktel = userBean.getUser_worktel(); //工作电话
		map.put("user_worktel", user_worktel);
		String user_mobiletel1 = userBean.getUser_mobiletel1(); //手机号码
		map.put("user_mobiletel1", user_mobiletel1);
		return map;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getPageDefaultDataName(在配置生成JSP页面时,给[name="默认值"]的下拉框提供数据)
	 * 
	 * 扩展时有必要重写
	 * @return
	 */
	public LinkedHashMap<String,String> getPageDefaultDataName(){
		return defaultData;
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * getPageDefaultDataVarName(在配置生成JSP页面时,给JSP页面 的java脚本部分提供 String 变量名称 )
	 * 扩展时有必要重写
	 * @return
	 */
	public List<String> getPageDefaultDataVarName(){
		return defaultDataVariName;
	}
	/**
	 * 将配置的{code}转换为<%=code%>
	 * 
	 * 在 保存配置属性页面时 调用
	 * 
	 * 可重写
	 */
	public String getHTMLString(String tagHtml,HttpServletRequest request){
		PageInitHandlerBean bean = this.getRealBean(request);
		Set<String> keySet = bean.getPageDefaultDataName().keySet();
		for (String key : keySet) {
			String newKey = new String(key);
			newKey = newKey.replace("{","<%=").replace("}","%>").replace("+","+\" \"+");
			tagHtml = tagHtml.replace(key,newKey);
		}
		return tagHtml;
	}
	
}
