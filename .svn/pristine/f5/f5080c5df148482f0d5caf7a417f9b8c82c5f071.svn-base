package com.chinacreator.xtbg.core.data.dao.impl;

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
import com.chinacreator.xtbg.core.data.dao.DataTypeDao;
import com.chinacreator.xtbg.core.data.entity.DataTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:DataTypeDaoImpl.java</p>
 *<p>Description:资料分类dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-20
 */
public class DataTypeDaoImpl extends XtDbBaseDao implements DataTypeDao {

	/**
	 * 
	  * <b>Summary: 根据id查询资料分类信息</b>
	  *     复写方法 getDataTypeBean
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.data.dao.DataTypeDao#getDataTypeBean(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getDataTypeBean(String id, Connection conn) throws Exception {
		Map<String, String> map=new HashMap<String, String>();
		String sql="select * from oa_data_type where d_type_id=? ";
		map=queryToSingleMap(conn, sql, id);
		
		return map;
	}

	/**
	 * 
	  * <b>Summary:查询资料分类列表 </b>
	  *     复写方法 selDataTypeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.data.dao.DataTypeDao#selDataTypeList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selDataTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		DataTypeBean bean= new DataTypeBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				bean = (DataTypeBean) JSONObject.parseObject(parmjson, DataTypeBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select * from (select d_type_id,  ");
			sql.append("  d_type_name, ");
			sql.append("  d_type_unit_id,");
			sql.append("  d_type_unit_name,");
			sql.append("  d_type_level,");
			sql.append("  d_type_user_id,d_type_user_name,");
			sql.append("  d_type_create_time,");
			sql.append("  d_type_order,");
			sql.append("  d_type_remark,");
			sql.append("  decode(d_type_parent_id,null,'0','','0',d_type_parent_id) d_type_parent_id  ");
			sql.append("  from oa_data_type ) b ");
			sql.append("  where 1=1");
			
			if(bean!=null){
				if (!StringUtil.nullOrBlank(bean.getD_type_name())) {
					sql.append(" and b.d_type_name like  '%'||?||'%' ");
					condition.add(bean.getD_type_name());
				}
				if (!StringUtil.nullOrBlank(bean.getD_type_id())) {
					sql.append(" and b.d_type_parent_id = ? ");
					condition.add(bean.getD_type_id());
				}else{
					sql.append(" and b.d_type_parent_id = ? ");
					condition.add("0");
				}
				if (!StringUtil.nullOrBlank(bean.getD_type_unit_id())) {
					sql.append(" and b.d_type_unit_id = ? ");
					condition.add(bean.getD_type_unit_id());
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
	  * <b>Summary: 根据id删除分类以及子分类信息</b>
	  *     复写方法 deleteDataTypeBeansById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.data.dao.DataTypeDao#deleteDataTypeBeansById(java.sql.Connection, java.lang.String)
	 */
	public boolean deleteDataTypeBeansById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from oa_data_type ");
		sql.append(" where d_type_id in ");
		sql.append("       (select d_type_id ");
		sql.append("        from oa_data_type  ");
		sql.append("        start with d_type_id = ? ");
		sql.append("        connect by prior d_type_id=d_type_parent_id )");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: 根据id查询是否有子分类</b>
	  *     复写方法 isSonDataType
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.data.dao.DataTypeDao#isSonDataType(java.sql.Connection, java.lang.String)
	 */
	public boolean isSonDataType(Connection conn, String beanId)
			throws Exception {
		boolean flag=false;
		List<Map<String, String>> list=new ArrayList<Map<String,String>>();
		String  sql="select * from oa_data_type t where t.d_type_parent_id=?";
		list=queryToListMap(sql, conn, beanId);
		if(list.size()>0){
			flag=true;
		}
		return flag;
	}

}
