package com.chinacreator.xtbg.core.form.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.form.entity.OaFormTagConfigBean;
import com.chinacreator.xtbg.core.form.entity.OaFormConfigBean;
import com.chinacreator.xtbg.core.form.entity.OaMdColumnsBean;
import com.chinacreator.xtbg.core.form.entity.OaMdTableBean;

/**
 * 
 *<p>Title:FormDao.java</p>
 *<p>Description:表单处理接口</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-6-22
 */
public interface FormDao {
	/**
	 * 
	*<b>Summary: </b>
	* getTableList(获取定义表SQL)
	* @return
	* @throws Exception
	 */
	public List<OaMdTableBean> getTableList() throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getCloumn(获取定义表的列)
	* @param table_id
	* @return
	* @throws Exception
	 */
	public List<OaMdColumnsBean> getCloumn(String table_id) throws Exception;
	/**
	 * 
	 * @param table_id
	 * @return
	 * @throws Exception
	 */
	public List<OaMdColumnsBean> getCloumnDataFromSystemTable(String table_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveTagConfig(保存表单配置信息)
	* @param oaFormTagConfigBean
	* @return
	 */
	public boolean saveTagConfig(OaFormTagConfigBean oaFormTagConfigBean, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveTagConfig(更新表单配置信息)
	* @param oaFormTagConfigBean
	* @return
	 */
	public boolean updateTagConfig(OaFormTagConfigBean oaFormTagConfigBean, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveTagConfig(删除表单配置信息)
	* @param oaFormTagConfigBean
	* @return
	 */
	public boolean delTagConfig(String tag_id, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryTagConfigInfo((查询表单配置信息)
	* @param tag_id
	* @return
	* @throws Exception
	 */
	public OaFormTagConfigBean queryTagConfigInfo(String tag_id, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getTagConfig(获取form的所有表单配置)
	* @param form_id
	* @return
	* @throws Exception
	 */
	public List<OaFormTagConfigBean> getTagConfig(String form_id, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findFormConfigList(获取表单列表LIST)
	* @param flowInfoBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findFormConfigList(OaFormConfigBean oaFormconfigBean,
			String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFormConfig(保存表单配置信息)
	* @param oaFormConfigBean
	* @return
	 */
	public boolean saveFormConfig(OaFormConfigBean oaFormConfigBean, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFormConfig(更新表单配置信息)
	* @param oaFormConfigBean
	* @return
	 */
	public boolean updateFormConfig(OaFormConfigBean oaFormConfigBean, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFormConfig(删除表单配置信息)
	* @param oaFormConfigBean
	* @return
	 */
	public boolean delFormConfig(String form_id, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getFormHtml(查询出表单配置的HTML)
	* @param form_id
	* @return
	* @throws Exception
	 */
	public String getFormHtml(String form_id, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getFormHtml(保存表单配置的HTML)
	* @param form_id
	* @return
	* @throws Exception
	 */
	public boolean saveFormHtml(String formHtml,String form_id, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getFormConfig(根据form_id获取表单配置信息)
	* @param form_id
	* @return
	* @throws Exception
	 */
	public OaFormConfigBean getFormConfig(String form_id, Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* delTagByformList(根据表单ID删除TAG信息)
	* @param form_ids
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean delTagByformList(String form_ids,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateIs_text(更新表单是否正文)
	* @param oaFormConfigBean
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean updateIsText(OaFormConfigBean oaFormConfigBean,Connection conn)throws Exception;
	

	/**
	 * 
	*<b>Summary: </b>
	* updateIs_text(获取表单是否正文)
	* @param oaFormConfigBean
	* @param conn
	* @return
	* @throws Exception
	 */
	public String getIsText(String form_id,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveOrUpdateFlowForm(保存或更新表单配置表)
	* @param appPath
	* @param form_name
	* @return
	 */
	public boolean saveOrUpdateFlowForm(String appPath, String form_name,Connection conn)throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveOrUpdateHide(保存隐藏域)
	* @param oaFormTagConfigBeanList
	* @param conn
	* @return
	 */
	public boolean saveOrUpdateHideTag(List<OaFormTagConfigBean> oaFormTagConfigBeanList, Connection conn) throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* delHideTag(删除隐藏域)
	* @param form_id
	* @return
	* @throws Exception
	 */
	public boolean delTagByType(String form_id, String tag_type_id, Connection conn)throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryHideTag(查询隐藏域)
	* @param form_id
	* @return
	* @throws Exception
	 */
	public List<OaFormTagConfigBean> queryHideTag(String form_id, Connection conn)throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* getTagConfig(获取form的所有表单配置)
	* @param form_id
	* @return
	* @throws Exception
	 */
	public List<OaFormTagConfigBean> getTagConfigByType(String form_id, String tag_type, Connection conn )throws Exception;
}
