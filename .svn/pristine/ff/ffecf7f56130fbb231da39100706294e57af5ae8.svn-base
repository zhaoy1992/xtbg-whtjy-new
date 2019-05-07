
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PsdataBaseDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-14   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.persondata.dao.imploracle;

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
import com.chinacreator.xtbg.core.persondata.dao.PsdataBaseDao;
import com.chinacreator.xtbg.core.persondata.entity.PsdataBaseBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:PsdataBaseDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-14
 */
public class PsdataBaseDaoImpl extends XtDbBaseDao implements PsdataBaseDao{
	
	/** 
	  * <b>Summary: </b>
	  *     复写方法 selPsdataTypeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.persondata.dao.PsdataTypeDao#selPsdataTypeList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selPsdataBaseList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PsdataBaseBean psdataBaseBean= new PsdataBaseBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				psdataBaseBean = (PsdataBaseBean) JSONObject.parseObject(parmjson, PsdataBaseBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("      select p_data_id,");
			sql.append("             p_data_title,");
			sql.append("             p_data_code,");
			sql.append("             p_type_id,");
			sql.append("             p_unit_d,");
			sql.append("             p_unit_name,");
			sql.append("             p_remark,");
			sql.append("             to_char(p_creater_time,'yyyy-mm-dd hh24:mi:ss') as p_creater_time,");
			sql.append("             p_creater_userid,");
			sql.append("             p_creater_username,");
			sql.append("             p_creater_orgid,");
			sql.append("             p_creater_orgname,");
			sql.append("             p_attach_id, ");
			sql.append("             to_char(p_file_time,'yyyy-mm-dd') as  p_file_time,p_docment_id ");
			sql.append("        from oa_persondata_base   ");
			sql.append("       where 1=1 ");
			if(psdataBaseBean!=null){
				//分类ID
				if (!StringUtil.nullOrBlank(psdataBaseBean.getP_type_id())&&!"0".equals(psdataBaseBean.getP_type_id())) {
					sql.append(" and p_type_id = ? ");
					condition.add(psdataBaseBean.getP_type_id());
				}
				//标题
				if (!StringUtil.nullOrBlank(psdataBaseBean.getP_data_title())) {
					sql.append(" and p_data_title like '%'||?||'%'");
					condition.add(psdataBaseBean.getP_data_title());
				}
				//编号
				if (!StringUtil.nullOrBlank(psdataBaseBean.getP_data_code())) {
					sql.append(" and p_data_code = ? ");
					condition.add(psdataBaseBean.getP_data_code());
				}
				//年份
				if (!StringUtil.nullOrBlank(psdataBaseBean.getP_data_year())) {
					sql.append(" and to_char(p_file_time,'yyyy') = ? ");
					condition.add(psdataBaseBean.getP_data_year());
				}
				//创建人
				if (!StringUtil.nullOrBlank(psdataBaseBean.getP_creater_userid())) {
					sql.append(" and p_creater_userid = ? ");
					condition.add(psdataBaseBean.getP_creater_userid());
				}
				
			}
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	*<b>Summary: </b>
	* getPsdataType(根据id查询个人资料信息)
	* @param p_data_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getPsdataBaseById(String p_data_id, Connection conn) throws Exception{
		Map<String, String> viewMap = new HashMap<String, String>();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select p_data_id,");
		sql.append("       p_data_title,");
		sql.append("       p_data_code,");
		sql.append("       p_type_id,");
		sql.append("       p_unit_d,");
		sql.append("       p_unit_name,");
		sql.append("       p_remark,");
		sql.append("       to_char(p_creater_time, 'yyyy-mm-dd hh24:mi:ss') as p_creater_time,");
		sql.append("       p_creater_userid,");
		sql.append("       p_creater_username,");
		sql.append("       p_creater_orgid,");
		sql.append("       p_creater_orgname,");
		sql.append("       p_attach_id,");
		sql.append("       to_char(p_file_time,'yyyy-mm-dd') as p_file_time,p_docment_id ");
		sql.append("  from oa_persondata_base ");
		sql.append(" where p_data_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), p_data_id);
		
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* deletePsdataBaseBeansById(根据id删除资料基本信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deletePsdataBaseBeansById(Connection conn,String beanId)throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from oa_persondata_base ");
		sql.append(" where p_data_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	*<b>Summary: </b>
	* selupLoadPsdataBase(查询 导出资料列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selupLoadPsdataBase(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception{
		Connection conn = null;
		PsdataBaseBean psdataBaseBean= new PsdataBaseBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				psdataBaseBean = (PsdataBaseBean) JSONObject.parseObject(parmjson, PsdataBaseBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select p_data_id,");
			sql.append("       p_data_title,");
			sql.append("       p_data_code,");
			sql.append("       b.p_type_id,");
			sql.append("       t.p_type_name,");
			sql.append("       p_unit_d,");
			sql.append("       p_unit_name,");
			sql.append("       b.p_remark,");
			sql.append("       to_char(b.p_creater_time, 'yyyy-mm-dd hh24:mi:ss') as p_creater_time,");
			sql.append("       b.p_creater_userid,");
			sql.append("       b.p_creater_username,");
			sql.append("       p_creater_orgid,");
			sql.append("       p_creater_orgname,");
			sql.append("       to_char(p_file_time,'yyyy-mm-dd') as  p_file_time, ");
			sql.append("       p_attach_id ");
			sql.append("  from oa_persondata_base b, oa_persondata_type t");
			sql.append(" where b.p_type_id = t.p_type_id");
			if(psdataBaseBean!=null){
				//分类ID
				if (!StringUtil.nullOrBlank(psdataBaseBean.getP_type_id())&&!"0".equals(psdataBaseBean.getP_type_id())) {
					sql.append(" and b.p_type_id = ? ");
					condition.add(psdataBaseBean.getP_type_id());
				}
				//标题
				if (!StringUtil.nullOrBlank(psdataBaseBean.getP_data_title())) {
					sql.append(" and p_data_title like '%'||?||'%'");
					condition.add(psdataBaseBean.getP_data_title());
				}
				//编号
				if (!StringUtil.nullOrBlank(psdataBaseBean.getP_data_code())) {
					sql.append(" and p_data_code = ? ");
					condition.add(psdataBaseBean.getP_data_code());
				}
				//年份
				if (!StringUtil.nullOrBlank(psdataBaseBean.getP_data_year())) {
					sql.append(" and to_char(b.p_creater_time,'yyyy') = ? ");
					condition.add(psdataBaseBean.getP_data_year());
				}
				//创建人
				if (!StringUtil.nullOrBlank(psdataBaseBean.getP_creater_userid())) {
					sql.append(" and b.p_creater_userid = ? ");
					condition.add(psdataBaseBean.getP_creater_userid());
				}
				
			}
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
}
