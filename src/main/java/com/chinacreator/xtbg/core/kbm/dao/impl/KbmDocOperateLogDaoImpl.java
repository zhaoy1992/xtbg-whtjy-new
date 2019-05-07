package com.chinacreator.xtbg.core.kbm.dao.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocOperateLogDao;
/**
 * 
 *<p>Title:KbmDocOperateLogDaoImpl.java</p>
 *<p>Description:文档用户操作情况记录实体类接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-28
 */
public class KbmDocOperateLogDaoImpl extends XtDbBaseDao implements KbmDocOperateLogDao {

	/**
	 * 
	  * <b>Summary: 根据文档id和用户id查询操作记录</b>
	  *     复写方法 getKbmDocOperateLog
	  * @param id
	  * @param userid
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocOperateLogDao#getKbmDocOperateLog(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getKbmDocOperateLog(String id, String userid, Connection conn) throws Exception{
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_kbm_doc_operate_log b");
		sql.append(" where b.k_doc_id = ? and b.k_create_user=? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), id,userid);
		
		return viewMap;
	}

}
