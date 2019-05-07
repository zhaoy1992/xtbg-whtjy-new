package com.chinacreator.xtbg.core.file.dao.imploracle;

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
import com.chinacreator.xtbg.core.file.dao.FileProgramPageDao;
import com.chinacreator.xtbg.core.file.entity.FileProgramPageBean;
/**
 * 
 *<p>Title:FileProgramPageDaoImpl.java</p>
 *<p>Description:档案程序界面Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-10
 */
public class FileProgramPageDaoImpl extends XtDbBaseDao implements
		FileProgramPageDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selNoticeViewList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileProgramPageDao#selNoticeViewList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selFileProgramPageList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		FileProgramPageBean fileProgramPageBean= new FileProgramPageBean();
		PagingBean pb = new PagingBean();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				fileProgramPageBean = (FileProgramPageBean) JSONObject.parseObject(parmjson, FileProgramPageBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			List<String> condition = new ArrayList<String>();
			sql.append("select b.f_program_id,");
			sql.append("       b.f_program_page,");
			sql.append("       b.f_file_list,");
			sql.append("       b.f_file_detail,");
			sql.append("       b.f_files_list,");
			sql.append("       b.f_files_detail,");
			sql.append("       b.f_order,");
			sql.append("       b.f_remark");
			sql.append("  from oa_file_program_page b");
			sql.append("  where 1=1");
			
			if(fileProgramPageBean!=null){
				if (!StringUtil.nullOrBlank(fileProgramPageBean.getF_program_page())) {
					//sql.append(" and b.f_program_page like '%" + fileProgramPageBean.getF_program_page() + "%'");
					sql.append(" and b.f_program_page like '%'||?||'%'");
					condition.add(fileProgramPageBean.getF_program_page());
				}
				
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
	  *     复写方法 getFileProgramPageBean
	  * @param f_program_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileProgramPageDao#getFileProgramPageBean(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getFileProgramPageBean(String f_program_id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select b.f_program_id,");
		sql.append("       b.f_program_page,");
		sql.append("       b.f_file_list,");
		sql.append("       b.f_file_detail,");
		sql.append("       b.f_files_list,");
		sql.append("       b.f_files_detail,");
		sql.append("       b.f_order,");
		sql.append("       b.f_remark");
		sql.append("  from oa_file_program_page b");
		sql.append(" where b.f_program_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), f_program_id);
		
		return viewMap;
	}


}
