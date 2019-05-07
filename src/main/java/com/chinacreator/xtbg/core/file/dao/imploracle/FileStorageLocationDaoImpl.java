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
import com.chinacreator.xtbg.core.file.dao.FileStorageLocationDao;
import com.chinacreator.xtbg.core.file.entity.FileStorageLocationBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FileStorageLocationDaoImpl.java</p>
 *<p>Description:档案存放位置接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-19
 */
public class FileStorageLocationDaoImpl extends XtDbBaseDao implements
		FileStorageLocationDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selFileStoragoLocationList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileStorageLocationDao#selFileStoragoLocationList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selFileStoragoLocationList(String parmjson,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		FileStorageLocationBean fileStorageLocationBean= new FileStorageLocationBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				fileStorageLocationBean = (FileStorageLocationBean) JSONObject.parseObject(parmjson, FileStorageLocationBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select b.f_storage_id,");
			sql.append("       b.f_storage_shotname,");
			sql.append("       b.f_storage_fullname,");
			sql.append("       b.f_org_id,");
			sql.append("       b.f_org_name,");
			sql.append("       b.f_perant_id,");
			sql.append("       b.f_order_num,");
			sql.append("       b.f_remark,");
			sql.append("       b.f_user_id,");
			sql.append("       b.f_user_name,");
			sql.append("       b.f_creator_time");
			sql.append("  from  (select * from oa_file_storage_location a ");
			sql.append("      where a.f_perant_id=? ) b ");
			sql.append("  where 1=1");
			
			if(fileStorageLocationBean!=null){
				if (!StringUtil.nullOrBlank(fileStorageLocationBean.getF_storage_id())) {
					condition.add(fileStorageLocationBean.getF_storage_id());
				}else{
					fileStorageLocationBean.setF_storage_id("0");
					condition.add(fileStorageLocationBean.getF_storage_id());
				}
				if (!StringUtil.nullOrBlank(fileStorageLocationBean.getF_storage_shotname())) {
					sql.append(" and ( b.f_storage_shotname like '%'||?||'%'");
					sql.append(" or b.f_storage_fullname like '%'||?||'%' )");
					condition.add(fileStorageLocationBean.getF_storage_shotname());
					condition.add(fileStorageLocationBean.getF_storage_shotname());
				}
				if (!StringUtil.nullOrBlank(fileStorageLocationBean.getF_org_id())) {
					sql.append(" and b.f_org_id = ? ");
					condition.add(fileStorageLocationBean.getF_org_id());
				}
				sql.append(" order by " + sortName + " " + sortOrder);
			}else{
				condition.add("0");
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
	  *     复写方法 getFileStorangeLocationBean
	  * @param f_storage_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.dao.FileStorageLocationDao#getFileStorangeLocationBean(java.lang.String)
	 */
	public Map<String, String> getFileStorageLocationBean(String f_storage_id,Connection conn) throws Exception  {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_file_storage_location ");
		sql.append(" where f_storage_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), f_storage_id);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFileStorageLocationURL
	  * @param f_storage_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileStorageLocationDao#getFileStorageLocationURL(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getFileStorageLocationURL(String f_storage_id) throws Exception {
		List<Map<String, String>> list= new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("  select * from oa_file_storage_location a ");
		sql.append("       connect by prior a.f_perant_id=a.f_storage_id start with a.f_storage_id=? order by level desc ");
		
		list = queryToListMap(sql.toString(), f_storage_id);
		
		return list;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isFileStorageLocationBean
	  * @param f_storage_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileStorageLocationDao#isFileStorageLocationBean(java.lang.String, java.sql.Connection)
	 */
	public int isFileStorageLocationBean(String f_storage_id, Connection conn)
			throws Exception {
		int count=0;
		PreparedDBUtil pdb=new PreparedDBUtil();
		String sql="select count(*) from oa_file_storage_location where f_perant_id="+f_storage_id;
		pdb.preparedSelect(sql);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			count=pdb.getInt(0, 0);
		}
		return count;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selChildFileStorageLocationBean
	  * @param f_storage_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileStorageLocationDao#selChildFileStorageLocationBean(java.lang.String)
	 */
	public List<Map<String, String>> selChildFileStorageLocationBean(
			String f_storage_id) throws Exception {
		List<Map<String, String>> list= new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("  select * from oa_file_storage_location a ");
		sql.append("       connect by prior a.f_storage_id=a.f_perant_id start with a.f_perant_id=? order by f_storage_id ");
		
		list = queryToListMap(sql.toString(), f_storage_id);
		
		return list;
	}

}
