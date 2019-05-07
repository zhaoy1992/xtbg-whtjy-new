
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PsdataTypeDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-12   Administrator    最初版本
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
import com.chinacreator.xtbg.core.persondata.dao.PsdataTypeDao;
import com.chinacreator.xtbg.core.persondata.entity.PsdataTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:PsdataTypeDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-12
 */
public class PsdataTypeDaoImpl extends XtDbBaseDao implements PsdataTypeDao{

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
	public PagingBean selPsdataTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PsdataTypeBean psdataTypeBean= new PsdataTypeBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				psdataTypeBean = (PsdataTypeBean) JSONObject.parseObject(parmjson, PsdataTypeBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select p_type_id,");
			sql.append("       p_type_name,");
			sql.append("       p_type_unit,");
			sql.append("       p_type_parentid,");
			sql.append("       p_type_order,");
			sql.append("       p_remark,");
			sql.append("       p_creater_userid,");
			sql.append("       p_creater_username,");
			sql.append("       p_creater_time");
			sql.append("  from oa_persondata_type ");
			sql.append("  where 1=1");
			
			if(psdataTypeBean!=null){
				if (!StringUtil.nullOrBlank(psdataTypeBean.getP_type_id())) {
					sql.append(" and p_type_parentid = ? ");
					condition.add(psdataTypeBean.getP_type_id());
				}
				if (!StringUtil.nullOrBlank(psdataTypeBean.getP_type_name())) {
					sql.append(" and p_type_name like '%'||?||'%'");
					condition.add(psdataTypeBean.getP_type_name());
				}
				if (!StringUtil.nullOrBlank(psdataTypeBean.getP_type_unit())) {
					sql.append(" and p_type_unit = ? ");
					condition.add(psdataTypeBean.getP_type_unit());
				}
				if (!StringUtil.nullOrBlank(psdataTypeBean.getP_creater_userid())) {
					sql.append(" and p_creater_userid = ? ");
					condition.add(psdataTypeBean.getP_creater_userid());
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
	  * <b>Summary: </b>
	  *     复写方法 getPsdataType
	  * @param p_type_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.persondata.dao.PsdataTypeDao#getPsdataType(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getPsdataType(String p_type_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_persondata_type ");
		sql.append(" where p_type_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), p_type_id);
		
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* deletePsdataTypeBeansById(根据id删除分类以及子类)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deletePsdataTypeBeansById(Connection conn,String beanId)throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from oa_persondata_type ");
		sql.append(" where p_type_id in ");
		sql.append("       (select p_type_id ");
		sql.append("        from oa_persondata_type  ");
		sql.append("        start with p_type_id = ? ");
		sql.append("        connect by prior p_type_id = p_type_parentid )");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	*<b>Summary: </b>
	* isPsdataBaseBean(判断分类是否被引用)
	* @param beanId
	* @return
	* @throws Exception
	 */
	public int isPsdataBaseBean(Connection conn,String beanId)throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		StringBuffer sql = null;
		sql = new StringBuffer();
		sql.append("  select count(*) numb from oa_persondata_base ");
		sql.append(" where p_type_id=?  ");
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
	*<b>Summary: </b>
	* findTopTypeById(根据id查询个人资料分类信息)
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> findTopType(String user_id,Connection conn) throws Exception {
			Map<String, String> viewMap = new HashMap<String, String>();
			StringBuffer sql = new StringBuffer();
			sql.append("  select * from  ");
			sql.append("  oa_persondata_type ");
			sql.append("  where p_type_parentid='0' and p_creater_userid=? and rownum=1 order by p_type_order ");
			
			viewMap = queryToSingleMap(conn, sql.toString(),user_id);
			
			return viewMap;
	}
}
