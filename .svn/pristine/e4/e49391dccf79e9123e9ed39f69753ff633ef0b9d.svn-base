package com.chinacreator.xtbg.core.paper.dao.impl;

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
import com.chinacreator.xtbg.core.paper.dao.PaperTemplateDao;
import com.chinacreator.xtbg.core.paper.entity.PaperTemplateBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:PaperTemplateDaoImpl.java</p>
 *<p>Description:信息报送模版管理Dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-13
 */
public class PaperTemplateDaoImpl extends XtDbBaseDao implements PaperTemplateDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selPaperTemplateList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperTemplateDao#selPaperTemplateList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selPaperTemplateList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PaperTemplateBean paperTemplateBean= new PaperTemplateBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				paperTemplateBean = (PaperTemplateBean) JSONObject.parseObject(parmjson, PaperTemplateBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select p_template_id,");
			sql.append("       p_template_typeid,");
			sql.append("       p_template_typename,");
			sql.append("       create_userid,");
			sql.append("       create_username,");
			sql.append("       p_template_name,");
			sql.append("       p_template_unitid,");
			sql.append("       p_template_unit,");
			sql.append("       create_time");
			sql.append("  from oa_paper_template ");
			sql.append("  where 1=1");
			
			if(paperTemplateBean!=null){
				if (!StringUtil.nullOrBlank(paperTemplateBean.getP_template_unitid())) {
					sql.append(" and p_template_unitid = ? ");
					condition.add(paperTemplateBean.getP_template_unitid());
				}
				if (!StringUtil.nullOrBlank(paperTemplateBean.getP_template_name())) {
					sql.append(" and p_template_name like '%'||?||'%' ");
					condition.add(paperTemplateBean.getP_template_name());
				}
			}
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getPaperTemplate
	  * @param p_template_typeid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperTemplateDao#getPaperTemplate(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getPaperTemplate(String p_template_typeid,
			Connection conn) throws Exception {
		
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_paper_template ");
		sql.append(" where p_template_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), p_template_typeid);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deletePaperTemplateById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperTemplateDao#deletePaperTemplateById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deletePaperTemplateById(Connection conn, String beanId) throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from oa_paper_template ");
		sql.append(" where p_template_id in ");
		sql.append("  ('"+beanId+"')");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}
	
}
