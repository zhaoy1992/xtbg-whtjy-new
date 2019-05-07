package com.chinacreator.xtbg.core.pubconfig.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.pubconfig.dao.FormActionDao;
import com.chinacreator.xtbg.core.pubconfig.entity.FormActionBean;
/**
 * 
 *<p>Title:FormActionDaoImpl.java</p>
 *<p>Description:表单环节定义实体接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-31
 */
public class FormActionDaoImpl extends XtDbBaseDao implements FormActionDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selFormActionList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FormActionDao#selFormActionList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selFormActionList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		FormActionBean formActionBean= new FormActionBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				formActionBean = (FormActionBean) JSONObject.parseObject(parmjson, FormActionBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select * ");
			sql.append("  from oa_form_action b");
			sql.append("  where 1=1");
			
			if(formActionBean!=null){
				
					sql.append(" and b.busitype_code = ?");
					condition.add(formActionBean.getBusitype_code());
				
				sql.append(" order by " + sortName + " " + sortOrder);
				}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFormAciton
	  * @param action_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FormActionDao#getFormAciton(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getFormAciton(String action_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_form_action b");
		sql.append(" where b.action_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), action_id.replaceAll("'", ""));
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFormAcitons
	  * @param busitype_code
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FormActionDao#getFormAcitons(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getFormAcitons(String busitype_code) throws Exception {
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_form_action b");
		sql.append(" where b.busitype_code = ? ");
		
		list = queryToListMap(sql.toString(), busitype_code);
		
		return list;
	}

}
