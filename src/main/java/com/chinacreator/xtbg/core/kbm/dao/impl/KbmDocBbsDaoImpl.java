package com.chinacreator.xtbg.core.kbm.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocBbsDao;
/**
 * 
 *<p>Title:KbmDocBbsDaoImpl.java</p>
 *<p>Description:知识库文档评阅实体接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-15
 */
public class KbmDocBbsDaoImpl extends XtDbBaseDao implements KbmDocBbsDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getKbmDocBbsBeans
	  * @param k_doc_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocBbsDao#getKbmDocBbsBeans(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getKbmDocBbsBeans(String k_doc_id,
			Connection conn) throws Exception {
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_kbm_doc_bbs b");
		sql.append(" where b.k_doc_id = ? order by k_create_time desc ");
		
		list = queryToListMap(sql.toString(), conn, k_doc_id);
		
		return list;
	}

}
