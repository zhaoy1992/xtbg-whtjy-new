package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.dbbase.entity.XtShowInfoHashMap;
import com.chinacreator.xtbg.core.file.dao.FileReadRecodeInfoDao;
import com.chinacreator.xtbg.core.file.entity.FileReadRecodeInfoBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 档案查看记录dao
 *<p>Title:FileReadRecodeInfoDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Oct 22, 2013
 */
public class FileReadRecodeInfoDaoImpl extends XtDbBaseDao implements FileReadRecodeInfoDao {
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getRecodeByBeanMess
	 * @param conn
	 * @param bean
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileReadRecodeInfoDao#getRecodeByBeanMess(java.sql.Connection, com.chinacreator.xtbg.core.file.entity.FileReadRecodeInfoBean)
	 */
	@Override
	public FileReadRecodeInfoBean getRecodeByBeanMess(Connection conn,
			FileReadRecodeInfoBean bean) throws Exception {
		return null;
	}
	
	
	public Map<String,String> getOldRecode(HttpServletRequest request,AccessControl ac,
			Connection con)throws Exception {
		String f_doc_id = request.getParameter("f_doc_id");
		String f_user_id = ac.getUserID();
		String sql = "select *"+
                     "  from OA_FILE_READ_RECODE_INFO ofr"+
                     " where ofr.f_user_id = '"+f_user_id+"'"+
                     "   and ofr.recode_type = '1'"+
                     "   and ofr.f_doc_id = '"+f_doc_id+"'"+
                     "   and ofr.f_date = to_char(sysdate,'yyyyMMdd')";
		return super.queryToSingleMap(con, sql);
	}


	@Override
	public int checkAttachNumOfFileDoc(String f_doc_id, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select count(1) countt        ");
		sql.append("  from oa_fc_attach           ");
		sql.append(" where djbh =                 ");
		sql.append("       (select odc.f_attach_id");
		sql.append("          from oa_file_doc odc");
		sql.append("         where f_doc_id = ?)  ");
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, f_doc_id);
		pdb.executePrepared(conn);
		int intt = 0;
		if(pdb.size()==1){
			intt = pdb.getInt(0, "countt");
		}
		return intt;
	}
}
