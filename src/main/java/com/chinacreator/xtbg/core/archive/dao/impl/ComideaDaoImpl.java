package com.chinacreator.xtbg.core.archive.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.archive.dao.ComideaDao;
import com.chinacreator.xtbg.core.archive.entity.DocumentComideaBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:ComideaDaoImpl.java</p>
 *<p>Description:常用意见接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-20
 */
public class ComideaDaoImpl extends XtDbBaseDao implements ComideaDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delComidea
	  * @param content
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.ComideaDao#delComidea(java.lang.String, java.sql.Connection)
	 */
	public boolean delComidea(String content,String user_id, Connection conn) throws Exception {
		String sql="delete OA_DOCUMENT_COMIDEA where idea_content=? and user_id = ? ";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedDelete(sql);
		pdb.setString(1, content);
		pdb.setString(2, user_id);
		pdb.executePrepared(conn);
		return true;
	}

	@Override
	public List<DocumentComideaBean> getList(String userId, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		List<DocumentComideaBean> list = new ArrayList<DocumentComideaBean>();
		sql.append("select Idea_Content,Idea_Content from OA_DOCUMENT_COMIDEA where user_id is null or user_id= ?");
		db.preparedSelect(sql.toString());
		db.setString(1, userId);
		db.executePrepared(conn);
		if(db.size()>0){
			for(int i=0;i<db.size();i++){
				DocumentComideaBean bean = new DocumentComideaBean();
				bean.setIdea_content(db.getString(i, "Idea_Content"));
				bean.setIdea_content(db.getString(i, "Idea_Content"));
				list.add(bean);
			}
		}
		return list;
	}

}
