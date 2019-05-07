package com.chinacreator.xtbg.core.kbm.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocSuggestDao;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:KbmDocSuggestDaoImpl.java</p>
 *<p>Description:知识库文档推荐实体接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-16
 */
public class KbmDocSuggestDaoImpl extends XtDbBaseDao implements
		KbmDocSuggestDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delFavoritesBan
	  * @param userids
	  * @param k_doc_id
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocSuggestDao#delFavoritesBan(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public void delSuggestBean(String userids, String k_doc_id, Connection conn)
			throws Exception {
		StringBuffer sql=new StringBuffer();
		PreparedDBUtil pdb=new PreparedDBUtil();
		sql.append(" delete from oa_kbm_doc_suggest ");
		sql.append(" where k_user in ('"+userids+"')  ");
		sql.append(" and k_doc_id=?  ");
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, k_doc_id);
		pdb.executePrepared(conn);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getUserBeanbyuserids
	  * @param userids
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocSuggestDao#getUserBeanbyuserids(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getUserBeanbyuserids(String userids,
			Connection conn) throws Exception {
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select v.user_id,v.user_realname  ");
		sql.append(" from table(split(?, ',')), td_sm_user v  ");
		sql.append(" where v.user_id = column_value ");
		
		list = queryToListMap(sql.toString(), conn, userids);
		
		return list;
	}

}
