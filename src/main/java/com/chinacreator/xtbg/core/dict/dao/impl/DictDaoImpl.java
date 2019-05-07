package com.chinacreator.xtbg.core.dict.dao.impl;

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
import com.chinacreator.xtbg.core.dict.dao.DictDao;
import com.chinacreator.xtbg.core.dict.entity.DictDataBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:DictDaoImpl.java</p>
 *<p>Description:数据字典接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-23
 */
public class DictDaoImpl extends XtDbBaseDao implements DictDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selDictDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dict.dao.DictDao#selDictDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selDictDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		DictDataBean dictDataBean= new DictDataBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				dictDataBean = (DictDataBean) JSONObject.parseObject(parmjson, DictDataBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select * from  (select * from oa_dict_data a ");
			sql.append("  connect by prior a.dictdata_id = a.dictdata_parent_id ");
			if (!StringUtil.nullOrBlank(dictDataBean.getDictdata_id())){
				sql.append("  start with a.dictdata_id =? ) b");
			}else{
				sql.append("  start with a.dictdata_parent_id =? ) b");
			}
			sql.append("  where 1=1");
			
			if(dictDataBean!=null){
				if (!StringUtil.nullOrBlank(dictDataBean.getDictdata_id())) {
					condition.add(dictDataBean.getDictdata_id());
				}else{
					condition.add("0");
				}
				if (!StringUtil.nullOrBlank(dictDataBean.getDictdata_name())) {
					sql.append(" and b.dictdata_name like '%'||?||'%'");
					condition.add(dictDataBean.getDictdata_name());
				}
				if (!StringUtil.nullOrBlank(dictDataBean.getDict_id())) {
					sql.append(" and b.dict_id = ? ");
					condition.add(dictDataBean.getDict_id());
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
	  *     复写方法 getDictDataBean
	  * @param dictdata_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dict.dao.DictDao#getDictDataBean(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getDictDataBean(String dictdata_id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_dict_data b");
		sql.append(" where b.dictdata_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), dictdata_id);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDictTypeBean
	  * @param dict_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dict.dao.DictDao#getDictTypeBean(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getDictTypeBean(String dict_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_dict_type b");
		sql.append(" where b.dict_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), dict_id);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDictDataBydvalue
	  * @param dictdata_value
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dict.dao.DictDao#getDictDataBydvalue(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getDictDataBydvalue(String dictdata_value,
			Connection conn,String dict_id) throws Exception {
		Map<String, String> map= new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_dict_data b");
		sql.append(" where b.dictdata_value = ?  and dict_id=?");
		
		map = queryToSingleMap(conn,sql.toString(), dictdata_value,dict_id);
		
		return map;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDictTypeBydcode
	  * @param dict_code
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dict.dao.DictDao#getDictTypeBydcode(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getDictTypeBydcode(String dict_code,
			Connection conn) throws Exception {
		Map<String, String> map= new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_dict_type b");
		sql.append(" where b.dict_code = ? ");
		
		map = queryToSingleMap(conn,sql.toString(), dict_code);
		
		return map;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isSonDictType
	  * @param dict_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dict.dao.DictDao#isSonDictType(java.lang.String, java.sql.Connection)
	 */
	public Boolean isSonDictType(String dict_id, Connection conn)
			throws Exception {
		int count=0;
		PreparedDBUtil pdb=new PreparedDBUtil();
		String sql="select count(*) from oa_dict_type where dict_parent_id='"+dict_id+"'";
		pdb.preparedSelect(sql);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			count=pdb.getInt(0, 0);
		}
		if(count>0){
			return true;
		}else{
			return false;
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isDictData
	  * @param dict_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dict.dao.DictDao#isDictData(java.lang.String, java.sql.Connection)
	 */
	public Boolean isDictData(String dict_id, Connection conn) throws Exception {
		int count=0;
		PreparedDBUtil pdb=new PreparedDBUtil();
		String sql="select count(*) from oa_dict_data where dict_id='"+dict_id+"'";
		pdb.preparedSelect(sql);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			count=pdb.getInt(0, 0);
		}
		if(count>0){
			return true;
		}else{
			return false;
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isSonData
	  * @param dictdata_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dict.dao.DictDao#isSonData(java.lang.String, java.sql.Connection)
	 */
	public Boolean isSonData(String dictdata_id, Connection conn)
			throws Exception {
		int count=0;
		PreparedDBUtil pdb=new PreparedDBUtil();
		String sql="select count(*) from oa_dict_data where dictdata_parent_id="+dictdata_id;
		pdb.preparedSelect(sql);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			count=pdb.getInt(0, 0);
		}
		if(count>0){
			return true;
		}else{
			return false;
		}
	}

}
