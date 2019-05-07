package com.chinacreator.xtbg.core.kbm.dao.impl;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocFavoritesDao;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:KbmDocFavoritesDaoImpl.java</p>
 *<p>Description:知识库我的收藏实体接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-15
 */
public class KbmDocFavoritesDaoImpl extends XtDbBaseDao implements
		KbmDocFavoritesDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delFavoritesBan
	  * @param userid
	  * @param k_doc_id
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocFavoritesDao#delFavoritesBan(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public void delFavoritesBan(String userid, String k_doc_id, Connection conn)
			throws Exception {
		StringBuffer sql=new StringBuffer();
		PreparedDBUtil pdb=new PreparedDBUtil();
		sql.append(" delete from oa_kbm_doc_favorites ");
		sql.append(" where k_create_user=?  ");
		sql.append(" and k_doc_id=?  ");
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, userid);
		pdb.setString(2, k_doc_id);
		pdb.executePrepared(conn);
		
	}

}
