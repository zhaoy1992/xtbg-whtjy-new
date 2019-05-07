package com.chinacreator.xtbg.core.form.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import oracle.sql.CLOB;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.form.dao.FormDao;
import com.chinacreator.xtbg.core.form.entity.OaFormConfigBean;
import com.chinacreator.xtbg.core.form.entity.OaFormTagConfigBean;
import com.chinacreator.xtbg.core.form.entity.OaMdColumnsBean;
import com.chinacreator.xtbg.core.form.entity.OaMdTableBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:FormDaoImpl.java</p>
 *<p>Description:表单处理DAO</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-6-22
 */
public class FormDaoImpl implements FormDao {
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTableList
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#getTableList()
	 */
	@Override
	public List<OaMdTableBean> getTableList() throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		List<OaMdTableBean> oaMdTableBeanList  = new ArrayList<OaMdTableBean>(); 
        String hsql = "select t.table_id, t.table_code, t.table_name, t.table_pk, t.parent_table_id, t.table_sn  from oa_md_table t order by t.table_code";
        db.preparedSelect(hsql); 
		db.executePrepared();
		
        for (int i = 0; i < db.size(); i++) {
        	OaMdTableBean oaMdTableBean = new OaMdTableBean();
        	oaMdTableBean.setTable_code(db.getString(i, "table_code"));
        	oaMdTableBean.setTable_name(db.getString(i, "table_name"));
        	oaMdTableBean.setTable_id(db.getString(i, "table_id"));
        	oaMdTableBeanList.add(oaMdTableBean);
        }
        return oaMdTableBeanList;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getCloumn
	  * @param table_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#getCloumn(java.lang.String)
	 */
	@Override
	public List<OaMdColumnsBean> getCloumn(String table_id) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		List<OaMdColumnsBean> oaMdColumnsBeanList  = new ArrayList<OaMdColumnsBean>(); 
        String hsql = "select t.column_id, t.table_id, t.column_code, t.column_name, t.column_sn  from oa_md_columns t where t.table_id = ? order by t.column_sn";
        db.preparedSelect(hsql); 
        db.setString(1, table_id);
		db.executePrepared();
		
        for (int i = 0; i < db.size(); i++) {
        	OaMdColumnsBean oaMdColumnsBean = new OaMdColumnsBean();
        	oaMdColumnsBean.setColumn_code(db.getString(i, "column_code"));
        	oaMdColumnsBean.setColumn_name(db.getString(i, "column_name"));
        	oaMdColumnsBeanList.add(oaMdColumnsBean);
        }
        return oaMdColumnsBeanList;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveTagConfig
	  * @param oaFormTagConfigBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#saveTagConfig(com.chinacreator.xtbg.core.form.entity.OaFormTagConfigBean)
	 */
	@Override
	public boolean saveTagConfig(OaFormTagConfigBean oaFormTagConfigBean, Connection conn ) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
        String sql = "insert into oa_form_tag_config(tag_id,tag_type_id,title,table_id,column_id,style_text,select_type,select_text,tag_html,display_html, form_id,default_value,drag_in_value) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        db.preparedInsert(sql); 
        db.setString(1, oaFormTagConfigBean.getTag_id());
        db.setString(2, oaFormTagConfigBean.getTag_type_id());
        db.setString(3, oaFormTagConfigBean.getTitle());
        db.setString(4, oaFormTagConfigBean.getTable_id());
        db.setString(5, oaFormTagConfigBean.getColumn_id());
        db.setString(6, oaFormTagConfigBean.getStyle_text());
        db.setString(7, oaFormTagConfigBean.getSelect_type());
        db.setString(8, oaFormTagConfigBean.getSelect_text());
        db.setString(9, oaFormTagConfigBean.getTag_html());
        db.setString(10, oaFormTagConfigBean.getDisplay_html());
        db.setString(11, oaFormTagConfigBean.getForm_id());
        db.setString(12, oaFormTagConfigBean.getDefault_value());
        db.setString(13, oaFormTagConfigBean.getDrag_in_value());
		db.executePrepared();
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateTagConfig
	  * @param oaFormTagConfigBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#updateTagConfig(com.chinacreator.xtbg.core.form.entity.OaFormTagConfigBean)
	 */
	@Override
	public boolean updateTagConfig(OaFormTagConfigBean oaFormTagConfigBean, Connection conn )throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_form_tag_config");
		sql.append("   set tag_type_id   = ?,");
		sql.append("       title         = ?,");
		sql.append("       table_id      = ?,");
		sql.append("       column_id     = ?,");
		sql.append("       style_text    = ?,");
		sql.append("       select_type   = ?,");
		sql.append("       select_text   = ?,");
		sql.append("       tag_html      = ?,");
		sql.append("       display_html  = ?,");
		sql.append("       default_value = ?,");
		sql.append("       drag_in_value = ? ");
		sql.append(" where tag_id = ?        ");
        db.preparedUpdate(sql.toString()); 
        db.setString(1, oaFormTagConfigBean.getTag_type_id());
        db.setString(2, oaFormTagConfigBean.getTitle());
        db.setString(3, oaFormTagConfigBean.getTable_id());
        db.setString(4, oaFormTagConfigBean.getColumn_id());
        db.setString(5, oaFormTagConfigBean.getStyle_text());
        db.setString(6, oaFormTagConfigBean.getSelect_type());
        db.setString(7, oaFormTagConfigBean.getSelect_text());
        db.setString(8, oaFormTagConfigBean.getTag_html());
        db.setString(9, oaFormTagConfigBean.getDisplay_html());
        db.setString(10, oaFormTagConfigBean.getDefault_value());
        db.setString(11, oaFormTagConfigBean.getDrag_in_value());
        db.setString(12, oaFormTagConfigBean.getTag_id());

		db.executePrepared();
		return true;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delTagConfig
	  * @param tag_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#delTagConfig(java.lang.String)
	 */
	@Override
	public boolean delTagConfig(String tag_id, Connection conn ) throws Exception{
		PreparedDBUtil db = new PreparedDBUtil();
        String hsql = "delete from oa_form_tag_config  where tag_id = ?";
        db.preparedDelete(hsql); 
        db.setString(1, tag_id);
		db.executePrepared(conn);
		return true;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryTagConfigInfo
	  * @param tag_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#queryTagConfigInfo(java.lang.String)
	 */
	@Override
	public OaFormTagConfigBean queryTagConfigInfo(String tag_id, Connection conn ) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		OaFormTagConfigBean oaFormTagConfigBean  = null; 
        String hsql = "select tag_id, tag_type_id, title, table_id, column_id, style_text, select_type, select_text, default_value,display_html,drag_in_value from oa_form_tag_config  where tag_id = ?";
        db.preparedSelect(hsql); 
        db.setString(1, tag_id);
		db.executePrepared();
        if(db.size()>0){
        	oaFormTagConfigBean  = new OaFormTagConfigBean(); 
        	oaFormTagConfigBean.setTag_id(tag_id);
        	oaFormTagConfigBean.setTag_type_id(db.getString(0, "tag_type_id"));
        	oaFormTagConfigBean.setTable_id(db.getString(0, "table_id"));
        	oaFormTagConfigBean.setTitle(db.getString(0, "title"));
        	oaFormTagConfigBean.setColumn_id(db.getString(0, "column_id"));
        	oaFormTagConfigBean.setStyle_text(db.getString(0, "style_text"));
        	oaFormTagConfigBean.setSelect_type(db.getString(0, "select_type"));
        	oaFormTagConfigBean.setSelect_text(db.getString(0, "select_text"));
        	oaFormTagConfigBean.setDefault_value(db.getString(0,"default_value"));
        	oaFormTagConfigBean.setDisplay_html(db.getString(0,"display_html"));
        	oaFormTagConfigBean.setDrag_in_value(db.getString(0,"drag_in_value"));
        }
        return oaFormTagConfigBean;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTagConfig
	  * @param form_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#getTagConfig(java.lang.String)
	 */
	@Override
	public List<OaFormTagConfigBean> getTagConfig(String form_id, Connection conn ) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		List<OaFormTagConfigBean> oaFormTagConfigBeanList  = new ArrayList<OaFormTagConfigBean>(); 
        String hsql = "select tag_id, tag_type_id, title, table_id, column_id, style_text, select_type, select_text, tag_html, display_html,default_value from oa_form_tag_config  where form_id = ?";
        db.preparedSelect(hsql); 
        db.setString(1, form_id);
		db.executePrepared(conn);
		for (int i = 0; i < db.size(); i++) {
        	OaFormTagConfigBean  oaFormTagConfigBean = new OaFormTagConfigBean(); 
        	oaFormTagConfigBean.setTag_id(db.getString(i, "tag_id"));
        	oaFormTagConfigBean.setTag_type_id(db.getString(i, "tag_type_id"));
        	oaFormTagConfigBean.setTable_id(db.getString(i, "table_id"));
        	oaFormTagConfigBean.setTitle(db.getString(i, "title"));
        	oaFormTagConfigBean.setColumn_id(db.getString(i, "column_id"));
        	oaFormTagConfigBean.setStyle_text(db.getString(i, "style_text"));
        	oaFormTagConfigBean.setSelect_type(db.getString(i, "select_type"));
        	oaFormTagConfigBean.setSelect_text(db.getString(i, "select_text"));
        	oaFormTagConfigBean.setTag_html(db.getString(i, "tag_html"));
        	oaFormTagConfigBean.setDisplay_html(db.getString(i, "display_html"));
        	oaFormTagConfigBean.setDefault_value(db.getString(i,"default_value"));
        	oaFormTagConfigBeanList.add(oaFormTagConfigBean);
        }
        return oaFormTagConfigBeanList;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findFormConfigList
	  * @param flowInfoBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#findFormConfigList(com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findFormConfigList(OaFormConfigBean oaFormconfigBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<OaFormConfigBean> list = new ArrayList<OaFormConfigBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		form_id,");
		sql.append(" 		form_name,");
		sql.append(" 		form_jsp_name,");
		sql.append(" 		form_background,");
		sql.append(" 		tag_background,");
		sql.append(" 		tag_width,");
		sql.append(" 		tag_height,");
		sql.append(" 		tag_margins,");
		sql.append("        from_ext_parm,");
		sql.append("        is_text,");
		sql.append("        form_width");
		sql.append(" from oa_form_config  ");
		sql.append(" where  1=1");
		if (!StringUtil.nullOrBlank(oaFormconfigBean.getForm_name())) {
			sql.append(" and form_name like '%").append(
					oaFormconfigBean.getForm_name()).append("%'");
		}
		if (!StringUtil.nullOrBlank(oaFormconfigBean.getForm_jsp_name())) {
			sql.append(" and form_jsp_name like '%").append(
					oaFormconfigBean.getForm_jsp_name()).append("%'");
		}
		sql.append(" order by " + sortName + ",rownum " + sortOrder);
		
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				OaFormConfigBean fob = new OaFormConfigBean();
				fob.setForm_id(db.getString(i, "form_id"));
				fob.setForm_name(db.getString(i, "form_name"));
				fob.setForm_jsp_name(db.getString(i, "form_jsp_name"));
				fob.setForm_background(db.getString(i, "form_background"));
				fob.setTag_background(db.getString(i, "tag_background"));
				fob.setTag_width(db.getString(i, "tag_width"));
				fob.setTag_height(db.getString(i, "tag_height"));
				fob.setTag_margins(db.getString(i, "tag_margins"));
				fob.setFrom_ext_parm(db.getString(i, "from_ext_parm"));
				fob.setIs_text(db.getString(i, "is_text"));
				fob.setForm_width(db.getString(i, "form_width"));
				list.add(fob);
			}
		
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveFormConfig
	  * @param oaFormConfigBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#saveFormConfig(com.chinacreator.xtbg.core.form.entity.OaFormConfigBean)
	 */
	@Override
	public boolean saveFormConfig(OaFormConfigBean oaFormConfigBean, Connection conn ) throws Exception{
		PreparedDBUtil db = new PreparedDBUtil();
        String sql = "insert into oa_form_config(form_id,form_name,form_jsp_name,form_background,tag_background,tag_width,tag_height,tag_margins,from_ext_parm,form_width) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        db.preparedInsert(sql); 
        db.setString(1, StringUtil.getUUID());
        db.setString(2, oaFormConfigBean.getForm_name());
        db.setString(3, oaFormConfigBean.getForm_jsp_name());
        db.setString(4, oaFormConfigBean.getForm_background());
        db.setString(5, oaFormConfigBean.getTag_background());
        db.setString(6, oaFormConfigBean.getTag_width());
        db.setString(7, oaFormConfigBean.getTag_height());
        db.setString(8, oaFormConfigBean.getTag_margins());
        db.setString(9, oaFormConfigBean.getFrom_ext_parm());
        //db.setString(10, oaFormConfigBean.getIs_text());
        db.setString(10, oaFormConfigBean.getForm_width());
		db.executePrepared();
		return true;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateFormConfig
	  * @param oaFormConfigBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#updateFormConfig(com.chinacreator.xtbg.core.form.entity.OaFormConfigBean)
	 */
	@Override
	public boolean updateFormConfig(OaFormConfigBean oaFormConfigBean, Connection conn )
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
        String sql = "update oa_form_config set  form_name = ?, form_jsp_name = ?, form_background = ?, tag_background = ?, tag_width = ?, tag_height = ?, tag_margins = ?, from_ext_parm = ?,form_width=? where form_id = ?";
        db.preparedUpdate(sql); 
        db.setString(1, oaFormConfigBean.getForm_name());
        db.setString(2, oaFormConfigBean.getForm_jsp_name());
        db.setString(3, oaFormConfigBean.getForm_background());
        db.setString(4, oaFormConfigBean.getTag_background());
        db.setString(5, oaFormConfigBean.getTag_width());
        db.setString(6, oaFormConfigBean.getTag_height());
        db.setString(7, oaFormConfigBean.getTag_margins());
        db.setString(8, oaFormConfigBean.getFrom_ext_parm());
       // db.setString(9, oaFormConfigBean.getIs_text());
        db.setString(9, oaFormConfigBean.getForm_width());
        db.setString(10, oaFormConfigBean.getForm_id());

		db.executePrepared();
		return true;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delFormConfig
	  * @param form_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#delFormConfig(java.lang.String)
	 */
	@Override
	public boolean delFormConfig(String form_ids, Connection conn ) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
        String hsql = "delete from oa_form_config  where instr (','||?||',',','||form_id||',')>0";
        db.preparedDelete(hsql); 
        db.setString(1, form_ids);
		db.executePrepared(conn);
		return true;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFormHtml
	  * @param form_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#getFormHtml(java.lang.String)
	 */
	@Override
	public String getFormHtml(String form_id, Connection conn ) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		CLOB conHtml = null;
		String reStr = "";
        String hsql = "select tag_config_html from oa_form_config  where form_id = ?";
        db.preparedSelect(hsql); 
        db.setString(1, form_id);
		db.executePrepared();
		if(db.size()>0){
			conHtml = (CLOB) db.getClob(0, "tag_config_html");
			if(conHtml!=null){
				reStr = StringUtil.ClobToString(conHtml);
			}
		}
		return reStr;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveFormHtml
	  * @param formHtml
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#saveFormHtml(java.lang.String)
	 */
	@Override
	public boolean saveFormHtml(String formHtml,String form_id, Connection conn ) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
        String sql = "update oa_form_config set  tag_config_html = ? where form_id = ?";
        db.preparedUpdate(sql); 
        db.setClob(1, formHtml);
        db.setString(2, form_id);
		db.executePrepared();
		return true;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFormConfig
	  * @param form_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#getFormConfig(java.lang.String)
	 */
	@Override
	public OaFormConfigBean getFormConfig(String form_id, Connection conn ) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		OaFormConfigBean oaFormConfigBean  = null; 
        String hsql = "select form_id,form_name,form_jsp_name,form_background,tag_background,tag_width,tag_height,tag_margins,from_ext_parm,tag_config_html,is_text,form_width from oa_form_config  where form_id = ?";
        db.preparedSelect(hsql); 
        db.setString(1, form_id);
		db.executePrepared(conn);
        if(db.size()>0){
        	oaFormConfigBean  = new OaFormConfigBean(); 
        	oaFormConfigBean.setForm_id(db.getString(0, "form_id"));
        	oaFormConfigBean.setForm_name(db.getString(0, "form_name"));
        	oaFormConfigBean.setForm_jsp_name(db.getString(0, "form_jsp_name"));
        	oaFormConfigBean.setForm_background(db.getString(0, "form_background"));
        	oaFormConfigBean.setTag_background(db.getString(0, "tag_background"));
        	oaFormConfigBean.setTag_width(db.getString(0, "tag_width"));
        	oaFormConfigBean.setTag_height(db.getString(0, "tag_height"));
        	oaFormConfigBean.setTag_margins(db.getString(0, "tag_margins"));
        	oaFormConfigBean.setIs_text(db.getString(0, "is_text"));
        	oaFormConfigBean.setForm_width(db.getString(0, "form_width"));
        	oaFormConfigBean.setFrom_ext_parm(db.getString(0, "from_ext_parm"));
        }
        return oaFormConfigBean;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delTagByformList
	  * @param form_ids
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#delTagByformList(java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean delTagByformList(String form_ids, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
        String hsql = "delete from oa_form_tag_config  where instr (','||?||',',','||form_id||',')>0";
        db.preparedDelete(hsql); 
        db.setString(1, form_ids);
		db.executePrepared(conn);
		return true;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateIsText
	  * @param oaFormConfigBean
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#updateIsText(com.chinacreator.xtbg.core.form.entity.OaFormConfigBean, java.sql.Connection)
	 */
	@Override
	public boolean updateIsText(OaFormConfigBean oaFormConfigBean,
			Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
        String sql = "update oa_form_config set is_text = ?,from_ext_parm = ? where form_id = ?";
        db.preparedUpdate(sql); 
        db.setString(1, oaFormConfigBean.getIs_text());
        db.setString(2, oaFormConfigBean.getFrom_ext_parm());
        db.setString(3, oaFormConfigBean.getForm_id());
		db.executePrepared(conn);
		return true;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getIsText
	  * @param form_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#getIsText(java.lang.String, java.sql.Connection)
	 */
	@Override
	public String getIsText(String form_id, Connection conn) throws Exception {
		String is_text="N";
		PreparedDBUtil db = new PreparedDBUtil();
        String sql = "select is_text from oa_form_config  where form_id = ?";
        db.preparedSelect(sql); 
        db.setString(1, form_id);
		db.executePrepared();
		if(db.size()>0){
			is_text = db.getString(0, "is_text");
		}
		return is_text;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveOrUpdateFlowForm
	  * @param appPath
	  * @param form_name
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#saveOrUpdateFlowForm(java.lang.String, java.lang.String)
	 */
	@Override
	public boolean saveOrUpdateFlowForm(String appPath, String form_name,Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
        String hsql = "delete from oa_flow_form  where form_path = ?　or form_name =?";
        db.preparedDelete(hsql); 
        db.setString(1, appPath);
        db.setString(2, form_name);
		db.executePrepared(conn);
	
        String sql = "insert into oa_flow_form(form_path,form_name,form_desc,creator_time) values (?,?,?,sysdate)";
        db.preparedInsert(sql); 
        db.setString(1, appPath);
        db.setString(2, form_name);
        db.setString(3, form_name);
		db.executePrepared(conn);
		return true;
	
		
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveOrUpdateHide
	  * @param oaFormTagConfigBeanList
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#saveOrUpdateHide(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean saveOrUpdateHideTag(List<OaFormTagConfigBean> oaFormTagConfigBeanList, Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		int i = 0;
		for (OaFormTagConfigBean oaFormTagConfigBean : oaFormTagConfigBeanList) {
			String insertSql = "insert into oa_form_tag_config(tag_id,form_id,tag_type_id,table_id,column_id,default_value) values (?,?,?,?,?,?)";
			pdb.preparedInsert(insertSql);
			pdb.setString(1, StringUtil.getUUID());
			pdb.setString(2, oaFormTagConfigBean.getForm_id());
			pdb.setString(3, oaFormTagConfigBean.getTag_type_id());
			pdb.setString(4, oaFormTagConfigBean.getTable_id());
			pdb.setString(5, oaFormTagConfigBean.getColumn_id());
			pdb.setString(6, oaFormTagConfigBean.getDefault_value());
			pdb.addPreparedBatch();
			i++;
		}
		// 批处理执行
		if (i > 0) {
			pdb.executePreparedBatch(conn);
		}
		return true;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delHideTag
	  * @param form_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#delHideTag(java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean delTagByType(String form_id, String tag_type_id ,Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String delsql = "delete from oa_form_tag_config where form_id = ?　and  tag_type_id = ?";
		pdb.preparedDelete(delsql);
		pdb.setString(1, form_id);
		pdb.setString(2, tag_type_id);
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryHideTag
	  * @param form_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#queryHideTag(java.lang.String, java.sql.Connection)
	 */
	@Override
	public List<OaFormTagConfigBean> queryHideTag(String form_id, Connection conn)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTagConfigByType
	  * @param form_id
	  * @param tag_type_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.form.dao.FormDao#getTagConfigByType(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	@Override
	public List<OaFormTagConfigBean> getTagConfigByType(String form_id,String tag_type_id, Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		List<OaFormTagConfigBean> oaFormTagConfigBeanList  = new ArrayList<OaFormTagConfigBean>(); 
        String hsql = "select tag_id, tag_type_id, title, table_id, column_id, style_text, select_type, select_text, tag_html, display_html, default_value from oa_form_tag_config  where form_id = ? and tag_type_id = ? ";
        db.preparedSelect(hsql); 
        db.setString(1, form_id);
        db.setString(2, tag_type_id);
		db.executePrepared(conn);
		for (int i = 0; i < db.size(); i++) {
        	OaFormTagConfigBean  oaFormTagConfigBean = new OaFormTagConfigBean(); 
        	oaFormTagConfigBean.setTag_id(db.getString(i, "tag_id"));
        	oaFormTagConfigBean.setTag_type_id(db.getString(i, "tag_type_id"));
        	oaFormTagConfigBean.setTable_id(db.getString(i, "table_id"));
        	oaFormTagConfigBean.setTitle(db.getString(i, "title"));
        	oaFormTagConfigBean.setColumn_id(db.getString(i, "column_id"));
        	oaFormTagConfigBean.setStyle_text(db.getString(i, "style_text"));
        	oaFormTagConfigBean.setSelect_type(db.getString(i, "select_type"));
        	oaFormTagConfigBean.setSelect_text(db.getString(i, "select_text"));
        	oaFormTagConfigBean.setTag_html(db.getString(i, "tag_html"));
        	oaFormTagConfigBean.setDisplay_html(db.getString(i, "display_html"));
        	oaFormTagConfigBean.setDefault_value(db.getString(i, "default_value"));
        	oaFormTagConfigBeanList.add(oaFormTagConfigBean);
        }
        return oaFormTagConfigBeanList;
	}
	
	/**
	 * 
	 */
	@Override
	public List<OaMdColumnsBean> getCloumnDataFromSystemTable(String table_id)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT UCC.COLUMN_NAME CODES,");
		sql.append("       CASE");
		sql.append("         WHEN LENGTH(UCC.COMMENTS) > 5 THEN");
		sql.append("          SUBSTR(UCC.COMMENTS, 1, 5) || '...'");
		sql.append("         ELSE");
		sql.append("          UCC.COMMENTS");
		sql.append("       END TITLES,");
		sql.append("       UCC.COMMENTS NAMES");
		sql.append("  FROM USER_COL_COMMENTS UCC");
		sql.append(" WHERE UCC.TABLE_NAME = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString()); 
        db.setString(1, table_id);
		db.executePrepared();
		List<OaMdColumnsBean> list = new ArrayList<OaMdColumnsBean>();
		for (int i = 0; i < db.size(); i++) {
			OaMdColumnsBean o= new OaMdColumnsBean();
			o.setColumn_code(db.getString(i, "CODES"));
        	o.setColumn_name(db.getString(i, "TITLES"));
        	o.setColumn_id(db.getString(i, "NAMES"));
        	list.add(o);
        }
		return list;
	}
	
}
