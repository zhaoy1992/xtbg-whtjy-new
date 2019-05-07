
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsuserTypeItemDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

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
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsuserTypeItemDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsuserTypeItemBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:OsuserTypeItemDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public class OsuserTypeItemDaoImpl extends XtDbBaseDao implements OsuserTypeItemDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selOsuserTypeItemList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsuserTypeItemDao#selOsuserTypeItemList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selOsuserTypeItemList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		OsuserTypeItemBean osusertypeitembean= new OsuserTypeItemBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				osusertypeitembean = (OsuserTypeItemBean) JSONObject.parseObject(parmjson, OsuserTypeItemBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select distinct i.it_id, ");
			sql.append("       i.it_name, ");
			sql.append("       i.it_no, ");
			sql.append("       i.it_remark, ");
			sql.append("       t.ofustype_name as ofustype_name");
			sql.append(" from ta_oa_osusertypeitem i left join TA_OA_HAVA_OBJECT t ");
			sql.append(" on i.it_typeid=t.ofustype_id ");
			sql.append("  where 1=1");
			if(osusertypeitembean!=null){
				if (!StringUtil.nullOrBlank(osusertypeitembean.getUnit_id())) {
					sql.append(" and i.unit_id = ? ");
					condition.add(osusertypeitembean.getUnit_id());
				}
				
				if (!StringUtil.nullOrBlank(osusertypeitembean.getIt_name())) {
					sql.append(" and i.it_name like '%'||?||'%'");
					condition.add(osusertypeitembean.getIt_name());
				}
				if(!StringUtil.nullOrBlank(osusertypeitembean.getOftype_id())){
					sql.append(" and t.oftype_id = ? ");
					condition.add(osusertypeitembean.getOftype_id());
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
	  *     复写方法 getOsuserTypeItem
	  * @param it_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsuserTypeItemDao#getOsuserTypeItem(java.lang.String, java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getOsuserTypeItem(String it_id, Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from ta_oa_osusertypeitem ");
		sql.append(" where it_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), it_id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteOsuserTypeItemsById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsuserTypeItemDao#deleteOsuserTypeItemsById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteOsuserTypeItemsById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_osusertypeitem ");
		sql.append(" where it_id in ");
		sql.append("       ("+beanId+")");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		//pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 isOsuserTypeItem
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsuserTypeItemDao#isOsuserTypeItem(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public int isOsuserTypeItem(Connection conn, String beanId)
			throws Exception {
		//申购计划物品表
		List<Map<String, String>> viewAppMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.it_id ");
		sql.append("  from ta_oa_osapp_object t, oa_flow_instance ins ");
		sql.append(" where t.t_id = ins.busi_id and t.it_id = ? ");
		viewAppMap = queryToListMap(sql.toString(), conn, beanId);
		
		//物品库存表
		List<Map<String, String>> viewHaveMap = new ArrayList<Map<String, String>>();
		StringBuffer sqlhava = new StringBuffer();
		sqlhava.append("select *");
		sqlhava.append("  from ta_oa_hava_object ");
		sqlhava.append(" where it_id = ? ");
		viewHaveMap = queryToListMap(sqlhava.toString(), conn, beanId);
		
		//易耗品申领物品表
		List<Map<String, String>> viewosAppregMap = new ArrayList<Map<String, String>>();
		StringBuffer sqlosAppreg = new StringBuffer();
		sqlosAppreg.append("select t.it_id ");
		sqlosAppreg.append("  from ta_oa_osappreg_object t,oa_flow_instance ins  ");
		sqlosAppreg.append(" where t.t_appregyhp_id = ins.busi_id and t.it_id = ? ");
		viewosAppregMap = queryToListMap(sqlosAppreg.toString(), conn, beanId);
		
		//物品领用表
		List<Map<String, String>> viewLingyongMap = new ArrayList<Map<String, String>>();
		StringBuffer sqllingyong = new StringBuffer();
		sqllingyong.append("select *");
		sqllingyong.append("  from ta_oa_lingyong_object ");
		sqllingyong.append(" where it_id = ? ");
		viewLingyongMap = queryToListMap(sqllingyong.toString(), conn, beanId);
		
		//申购审批物品表
		List<Map<String, String>> viewOsexaMap = new ArrayList<Map<String, String>>();
		StringBuffer sqlosExa = new StringBuffer();
		sqlosExa.append("select t.it_id ");
		sqlosExa.append("  from ta_oa_osexa_object t,oa_flow_instance ins ");
		sqlosExa.append(" where t.t_osexa_id = ins.busi_id and t.it_id = ? ");
		viewOsexaMap = queryToListMap(sqlosExa.toString(), conn, beanId);
		
		int count = viewAppMap.size() + viewosAppregMap.size() 
					+ viewLingyongMap.size() + viewOsexaMap.size();
		return count;
	}


	/**
	 * 
	  * <b>Summary: 根据物品ID查询出规格列表</b>
	  *     复写方法 queryOsuserTyptItemList
	  * @param ofustypeId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsuserTypeItemDao#queryOsuserTyptItemList(java.lang.String)
	 */
	public List<Map<String, String>> queryOsuserTyptItemList(String ofustypeId)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<Map<String, String>> ofustypeItemList = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select it_id,it_name");
		sql.append("  from ta_oa_osusertypeitem ");
		sql.append(" where it_typeid = ? ");
		pdb.preparedSelect(sql.toString());
		
		pdb.setString(1, ofustypeId);
		
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			Map<String, String> ofustypeItemMap = new HashMap<String, String>();
			ofustypeItemMap.put("it_id", pdb.getString(i, "it_id"));
			ofustypeItemMap.put("it_name", pdb.getString(i, "it_name"));
			
			ofustypeItemList.add(ofustypeItemMap);
		}
		
		return ofustypeItemList;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* queryOsoFtypeItemList(根据物品ID查询出物品类别)
	* @param ofustypeId
	* @return
	* @throws Exception
	 */
	public Map<String, String> queryOsoFtypeItemList(String ofustypeId) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		Map<String, String> oftypeNameMap = new HashMap<String,String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select usestype.oftype_id as oftype_id,usestype.oftype_name as oftype_name ");
		sql.append("  from ta_oa_osupplieUseType oftypes, ta_oa_osupplietype usestype ");
		sql.append(" where oftypes.oftype_id = usestype.oftype_id ");
		sql.append(" and ofustype_id = ? ");
		pdb.preparedSelect(sql.toString());
		
		pdb.setString(1, ofustypeId);
		
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			oftypeNameMap.put("oftype_id", pdb.getString(i, "oftype_id"));
			oftypeNameMap.put("oftype_name", pdb.getString(i, "oftype_name"));
		}
		
		return oftypeNameMap;
		
	}


	@Override
	public boolean insert(OsuserTypeItemBean bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_osusertypeitem a ");
		sql.append("(a.it_id,a.it_name,a.it_no,a.it_remark,a.it_typeid,a.unit_id,a.unit_name)");
		sql.append(" values(?,?,?,?,?,?,?)");
		db.preparedInsert(sql.toString());
		db.setString(1, bean.getIt_id());
		db.setString(2, bean.getIt_name());
		db.setString(3, bean.getIt_no());
		db.setString(4, bean.getIt_remark());
		db.setString(5, bean.getIt_typeid());
		db.setString(6, bean.getUnit_id());
		db.setString(7, bean.getUnit_name());
		db.executePrepared(conn);
		return true;
	}


	@Override
	public Map<String, String> getOfustypeById(String id,Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.ofustype_name,a.ofustype_id,a.ofustype_no,a.t_ha_id from ta_oa_hava_object a where a.ofustype_id = ?");
		viewMap = queryToSingleMap(conn, sql.toString(), id);
		return viewMap;
	}

}
