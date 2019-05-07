package com.chinacreator.xtbg.core.kbm.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocRssDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocRssBean;
/**
 * 
 *<p>Title:KbmDocRssDaoImpl.java</p>
 *<p>Description:知识库文档订阅接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-13
 */
public class KbmDocRssDaoImpl extends XtDbBaseDao implements KbmDocRssDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryKbmDocRssList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocRssDao#queryKbmDocRssList(com.chinacreator.xtbg.core.kbm.entity.KbmDocRssBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean queryKbmDocRssList(KbmDocRssBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			List<String> conditionValues = new ArrayList<String>();
			sql.append(" select * from oa_kbm_doc_rss  ");
			sql.append(" where 1=1 ");
			
			if(!StringUtil.nullOrBlank(model.getK_type_name() )){
				sql.append(" and k_type_name =? ");
				conditionValues.add(model.getK_type_name() );
			}
			if(!StringUtil.nullOrBlank(model.getK_rss_user() )){
				sql.append(" and k_rss_user =? ");
				conditionValues.add(model.getK_rss_user() );
			}
			if(!StringUtil.nullOrBlank(model.getK_key() )){
				sql.append(" and k_key like '%'||?||'%' ");
				conditionValues.add(model.getK_key());
			}
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getKbmDocRss
	  * @param k_rss_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocRssDao#getKbmDocRss(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getKbmDocRss(String k_rss_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_kbm_doc_rss b");
		sql.append(" where b.k_rss_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), k_rss_id);
		
		return viewMap;
	}
}
