package com.chinacreator.xtbg.core.kbm.dao.impl;

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
import com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:KbmDocTypeDaoImpl.java</p>
 *<p>Description:知识库文档分类接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-6
 */
public class KbmDocTypeDaoImpl extends XtDbBaseDao implements KbmDocTypeDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selKbmDocTypeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao#selKbmDocTypeList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selKbmDocTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		KbmDocTypeBean kbmDocTypeBean= new KbmDocTypeBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				kbmDocTypeBean = (KbmDocTypeBean) JSONObject.parseObject(parmjson, KbmDocTypeBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select * from (select k_type_id,  ");
			sql.append("  k_type_name, ");
			sql.append("  k_type_unit,");
			sql.append("  k_type_unit_name,");
			sql.append("  k_type_dept,");
			sql.append("  k_type_dept_name,");
			sql.append("  k_type_level,");
			sql.append("  k_create_user,k_create_user_name,");
			sql.append("  k_create_time,");
			sql.append("  k_content_template,");
			sql.append("  k_remark,k_type_order,");
			sql.append("  decode(k_parent_type_id,null,'0','','0',k_parent_type_id) k_parent_type_id  ");
			sql.append("  from oa_kbm_doc_type ) b ");
			sql.append("  where 1=1");
			
			if(kbmDocTypeBean!=null){
				if (!StringUtil.nullOrBlank(kbmDocTypeBean.getK_type_id())) {
					sql.append(" and b.k_parent_type_id = ? ");
					condition.add(kbmDocTypeBean.getK_type_id());
				}else{
					sql.append(" and b.k_parent_type_id = '0' ");
				}
				if (!StringUtil.nullOrBlank(kbmDocTypeBean.getK_type_name())) {
					sql.append(" and b.k_type_name like '%'||?||'%'");
					condition.add(kbmDocTypeBean.getK_type_name());
				}
				if (!StringUtil.nullOrBlank(kbmDocTypeBean.getK_type_unit())) {
					sql.append(" and b.k_type_unit = ? ");
					condition.add(kbmDocTypeBean.getK_type_unit());
				}
			}
			sql.append(" order by b." + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getKbmDocType
	  * @param k_type_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao#getKbmDocType(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getKbmDocType(String k_type_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_kbm_doc_type b");
		sql.append(" where b.k_type_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), k_type_id);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getIsrecursionDataById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao#getIsrecursionDataById(java.sql.Connection, java.lang.String)
	 */
	public Map<String, String> getIsrecursionDataById(Connection conn,
			String beanId) throws Exception {
		String digui=KbmDocTypeBean.IS_RECURSION_YES;
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("   from (select k_type_id, k_content_template, k_isrecursion_content ");
		sql.append(" from oa_kbm_doc_type ");
		sql.append(" start with k_type_id = ? ");
		sql.append(" connect by prior k_parent_type_id = k_type_id) a ");
		sql.append(" where a.k_isrecursion_content=? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), beanId,digui);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateChildrenDocTypeByBean
	  * @param bean
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao#updateChildrenDocTypeByBean(com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeBean, java.sql.Connection)
	 */
	public boolean updateChildrenDocTypeByBean(KbmDocTypeBean bean,
			Connection conn) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		StringBuffer sql = null;
		sql = new StringBuffer();
		sql.append(" update oa_kbm_doc_type set");
		sql.append(" k_content_template=?  ");
		sql.append(" where k_type_id in  ");
		sql.append(" (select k_type_id ");
		sql.append("  from oa_kbm_doc_type ");
		sql.append("  start with k_parent_type_id =? ");
		sql.append("  connect by prior k_type_id = k_parent_type_id) ");
		pdb.preparedUpdate(sql.toString());
		int i = 1;
		pdb.setString(i++, bean.getK_content_template());
		pdb.setString(i++, bean.getK_type_id());
		pdb.executePrepared(conn);
		return  true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteDocTypeBeansById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao#deleteDocTypeBeansById(java.sql.Connection, java.lang.String)
	 */
	public boolean deleteDocTypeBeansById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from oa_kbm_doc_type ");
		sql.append(" where k_type_id in ");
		sql.append("       (select k_type_id ");
		sql.append("        from oa_kbm_doc_type  ");
		sql.append("        start with k_type_id = ? ");
		sql.append("        connect by prior k_type_id=k_parent_type_id )");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteChildrenDocTypeConfigByBean
	  * @param beanId
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao#deleteChildrenDocTypeConfigByBean(java.lang.String, java.sql.Connection)
	 */
	public boolean deleteChildrenDocTypeConfigByBean(String beanId,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from oa_kbm_doc_type_right_config ");
		sql.append(" where k_type_id in ");
		sql.append("       (select k_type_id ");
		sql.append("        from oa_kbm_doc_type  ");
		sql.append("        start with k_type_id = ? ");
		sql.append("        connect by prior k_type_id=k_parent_type_id )");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getSonDocTypeBeansById
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao#getSonDocTypeBeansById(java.lang.String)
	 */
	public List<Map<String, String>> getSonDocTypeBeansById(String beanId)
			throws Exception {
		List<Map<String, String>> list=new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from oa_kbm_doc_type ");
		sql.append(" start with k_parent_type_id = ? ");
		sql.append(" connect by prior k_type_id = k_parent_type_id ");
		list=queryToListMap(sql.toString(), beanId);
		return list;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deletesonDocTypeConfigByBean
	  * @param beanId
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao#deletesonDocTypeConfigByBean(java.lang.String, java.sql.Connection)
	 */
	public boolean deletesonDocTypeConfigByBean(String beanId, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from oa_kbm_doc_type_right_config ");
		sql.append(" where k_type_id in ");
		sql.append("       (select k_type_id ");
		sql.append("        from oa_kbm_doc_type  ");
		sql.append("        start with k_parent_type_id = ? ");
		sql.append("        connect by prior k_type_id=k_parent_type_id )");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isKbmDocBean
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao#isKbmDocBean(java.lang.String)
	 */
	public int isKbmDocBean(Connection conn,String beanId) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		StringBuffer sql = null;
		sql = new StringBuffer();
		sql.append("  select count(*) numb from oa_kbm_doc ");
		sql.append(" where k_type_id=?  ");
		pdb.preparedSelect(sql.toString());
		int i = 1;
		pdb.setString(i++, beanId);
		pdb.executePrepared(conn);
		int count=0;
		if(pdb.size()>0){
			count=pdb.getInt(0, "numb");
		}
		return  count;
	}

	/**
	 * 
	  * <b>Summary: 根据分类id查询所有该分类下的资料信息</b>
	  *     复写方法 getKbmDocById
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao#getKbmDocById(java.lang.String)
	 */
	public List<Map<String, String>> getKbmDocById(String beanId)
			throws Exception {
		List<Map<String, String>> list=new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from oa_kbm_doc ");
		sql.append(" where k_type_id=? ");
		list=queryToListMap(sql.toString(), beanId);
		return list;
	}

}
