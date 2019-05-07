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
import com.chinacreator.xtbg.core.data.dao.DataDataDao;
import com.chinacreator.xtbg.core.data.entity.DataDataBean;
/**
 * 
 *<p>Title:DataDataDaoImpl.java</p>
 *<p>Description:资料实体接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-21
 */
public class DataDataDaoImpl extends XtDbBaseDao implements DataDataDao {

	/**
	 * 
	  * <b>Summary: 查询资料列表信息</b>
	  *     复写方法 selDataDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.data.dao.DataDataDao#selDataDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selDataDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		DataDataBean bean= new DataDataBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				bean = (DataDataBean) JSONObject.parseObject(parmjson, DataDataBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select  dd.d_data_id,dd.d_data_name, ");
			sql.append("  dd.d_data_code, ");
			sql.append("  dd.d_type_id,dd.d_type_name, ");
			sql.append("  to_char(dd.d_data_put_time,'yyyy-MM-dd') as d_data_put_time, ");
			sql.append("  dd.d_data_create_time,dd.d_data_unit_name,dd.d_data_dept_name,dd.d_data_content,dd.d_data_user_name, ");
			sql.append("  (select decode(count(1),0,'','有(<font color=\"red\">'||count(1)||'</font>)') from oa_fileupload_kbm ofa where ofa.attach_id = dd.d_data_attach) attach_id ");
			sql.append("  from  oa_data_data dd ");
			sql.append("  where 1=1");
			
			if(bean!=null){
				//分类ID
				if (!StringUtil.nullOrBlank(bean.getD_type_id())&&!"0".equals(bean.getD_type_id())) {
					sql.append(" and dd.d_type_id in (select d_type_id from oa_data_type start with d_type_id= ? connect by prior d_type_id=d_type_parent_id )  ");
					condition.add(bean.getD_type_id());
				}
				//标题
				if (!StringUtil.nullOrBlank(bean.getD_data_name())) {
					sql.append(" and dd.d_data_name like '%'||?||'%'");
					condition.add(bean.getD_data_name());
				}
				//编号
				if (!StringUtil.nullOrBlank(bean.getD_data_code())) {
					sql.append(" and dd.d_data_code like '%'||?||'%' ");
					condition.add(bean.getD_data_code());
				}
				//年份
				if (!StringUtil.nullOrBlank(bean.getD_data_year())) {
					sql.append(" and to_char(dd.d_data_put_time,'yyyy') = ? ");
					condition.add(bean.getD_data_year());
				}
				//创建人
				if (!StringUtil.nullOrBlank(bean.getD_data_user_id())) {
					sql.append(" and dd.d_data_user_id = ? ");
					condition.add(bean.getD_data_user_id());
				}
				//单位
				if (!StringUtil.nullOrBlank(bean.getD_data_unit_id())) {
					sql.append(" and dd.d_data_unit_id = ? ");
					condition.add(bean.getD_data_unit_id());
				}
				//部门
				if (!StringUtil.nullOrBlank(bean.getD_data_dept_id())) {
					sql.append(" and dd.d_data_dept_id = ? ");
					condition.add(bean.getD_data_dept_id());
				}
			}
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: 根据id查询资料信息</b>
	  *     复写方法 getDataBaseBean
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.data.dao.DataDataDao#getDataBaseBean(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getDataBaseBean(String id, Connection conn)
			throws Exception {
		Map<String, String> map=new HashMap<String, String>();
		String sql="select * from oa_data_data where d_data_id=? ";
		map=queryToSingleMap(conn, sql, id);
		
		return map;
	}

	@Override
	public List<Map<String, String>> getDataBaseBeanList(String typeid, Connection conn) throws Exception {
		List<Map<String, String>> map=new ArrayList<Map<String,String>>();
		String sql="select * from oa_data_data where d_type_id=? ";
		map=queryToListMap(sql, conn, typeid);
		
		return map;
	}

}
