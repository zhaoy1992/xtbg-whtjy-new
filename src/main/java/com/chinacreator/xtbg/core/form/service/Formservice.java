package com.chinacreator.xtbg.core.form.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinacreator.xtbg.core.form.entity.OaFormConfigBean;
import com.chinacreator.xtbg.core.form.entity.OaFormTagConfigBean;
import com.chinacreator.xtbg.core.form.entity.OaMdColumnsBean;
import com.chinacreator.xtbg.core.form.entity.OaMdTableBean;

/**
 * 
 *<p>Title:Formservice.java</p>
 *<p>Description:表单定义service</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-6-22
 */
public interface Formservice {
	/**
	 * 
	*<b>Summary: </b>
	* getTableList(获取表列表)
	* @return
	 */
	public List<OaMdTableBean> getTableList();
	
	/**
	 * 
	*<b>Summary: </b>
	* getCloumn(获取列列表)
	* @param table_id
	* @return
	 */
	public List<OaMdColumnsBean> getCloumn(String table_id,String type);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveTagConfig(保存页面配置信息)
	* @param request
	* @return
	 */
	public boolean saveTagConfig(String paramJson,HttpServletRequest request);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveTagConfig(更新页面配置信息)
	* @param request
	* @return
	 */
	public boolean updateTagConfig(String paramJson,HttpServletRequest request);
	/**
	 * 
	*<b>Summary: </b>
	* saveTagConfig(删除页面配置信息)
	* @param request
	* @return
	 */
	public boolean delTagConfig(String tag_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryTagConfigInfo(查询页面配置信息)
	* @param tag_id
	* @return
	 */
	public OaFormTagConfigBean queryTagConfigInfo(String tag_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* formAdd(生成页面方法)
	* @param request
	* @param response
	* @return
	 */
	public Map<String, Object> formAdd(HttpServletRequest request,HttpServletResponse response);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFormConfig(保存表单配置信息)
	* @param paramJson
	* @return
	 */
	public boolean saveFormConfig(String paramJson);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFormConfig(更新表单配置信息)
	* @param paramJson
	* @return
	 */
	public boolean updateFormConfig(String paramJson);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFormConfig(删除表单配置信息)
	* @param paramJson
	* @return
	 */
	public boolean  delFormConfig(String form_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* getFormHtml(获取该表单的配置HTML)
	* @return
	 */
	public String getFormHtml(String form_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryFormConfigInfo(查询表单配置信息)
	* @param form_id
	* @return
	 */
	public OaFormConfigBean queryFormConfigInfo(String form_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* getIsText(获取该表单ID是否配置正文。)
	* @param form_id
	* @return
	 */
	public String getIsText(String form_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveOrUpdateHide(保存隐藏域信息)
	* @param paramJson
	* @param request
	* @return
	 */
	public boolean saveOrUpdateHideTag(String paramJson,HttpServletRequest request);
	
	/**
	 * 
	*<b>Summary: </b>
	* getHideTagConfig(获取隐藏域配置
	* @param form_id
	* @return
	 */
	public List<OaFormTagConfigBean> getHideTagConfig(String form_id);
	}