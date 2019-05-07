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
import com.chinacreator.xtbg.core.file.dao.FileFondsnoDao;
import com.chinacreator.xtbg.core.file.entity.FileFondsnoBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FileFondsnoDaoImpl.java</p>
 *<p>Description:档案全宗号接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-12
 */
public class FileFondsnoDaoImpl extends XtDbBaseDao implements FileFondsnoDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selFileFondsnoList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFondsnoDao#selFileFondsnoList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selFileFondsnoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		FileFondsnoBean fileFondsnoBean= new FileFondsnoBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				fileFondsnoBean = (FileFondsnoBean) JSONObject.parseObject(parmjson, FileFondsnoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select b.f_fonds_id,");
			sql.append("       b.f_fondsno_name,");
			sql.append("       b.f_fondsno,");
			sql.append("       b.f_fonds_order,");
			sql.append("       b.f_fonds_remark,");
			sql.append("       b.f_org_id,");
			sql.append("       b.f_org_name");
			sql.append("  from oa_file_fondsno b");
			sql.append("  where 1=1");
			
			if(fileFondsnoBean!=null){
				if (!StringUtil.nullOrBlank(fileFondsnoBean.getF_fondsno_name())) {
					sql.append(" and b.f_fondsno_name like '%'||?||'%'");
					condition.add(fileFondsnoBean.getF_fondsno_name());
				}
				if (!StringUtil.nullOrBlank(fileFondsnoBean.getF_org_id())) {
					sql.append(" and b.f_org_id = ? ");
					condition.add(fileFondsnoBean.getF_org_id());
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
	  *     复写方法 getFileFondsnoBean
	  * @param f_program_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFondsnoDao#getFileFondsnoBean(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getFileFondsnoBean(String f_fonds_id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_file_fondsno b");
		sql.append(" where b.f_fonds_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), f_fonds_id);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFileFondsnoBeanByOrgid
	  * @param f_fonds_orgid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFondsnoDao#getFileFondsnoBeanByOrgid(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getFileFondsnoBeanByOrgid(String f_fonds_orgid,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_file_fondsno b");
		sql.append(" where b.f_org_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), f_fonds_orgid);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: 判断全宗号和名称是否被引用</b>
	  *     复写方法 isNameorCode
	  * @param name
	  * @param code
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFondsnoDao#isNameorCode(java.lang.String, java.lang.String)
	 */
	public String isNameorCode(String name, String code,String id) throws Exception {
		if(isName(name,id)>0){
			return "name";
		}
		if(isCode(code,id)>0){
			return "code";
		}
		return null;
	}
	public int isName(String name,String id)throws Exception{
		PreparedDBUtil pdb=new PreparedDBUtil();
		String sql="select count(*) numb from oa_file_fondsno where f_fondsno_name=? and f_fonds_id <> ? ";
		pdb.preparedSelect(sql);
		pdb.setString(1, name);
		pdb.setString(2, id);
		pdb.executePrepared();
		int count =0;
		if(pdb.size()>0){
			count=pdb.getInt(0, "numb");
		}
		return count;
	}
	public int isCode(String code,String id)throws Exception{
		PreparedDBUtil pdb=new PreparedDBUtil();
		String sql="select count(*) numb from oa_file_fondsno where f_fondsno=? and f_fonds_id <> ? ";
		pdb.preparedSelect(sql);
		pdb.setString(1, code);
		pdb.setString(2, id);
		pdb.executePrepared();
		int count =0;
		if(pdb.size()>0){
			count=pdb.getInt(0, "numb");
		}
		return count;
	}

}
