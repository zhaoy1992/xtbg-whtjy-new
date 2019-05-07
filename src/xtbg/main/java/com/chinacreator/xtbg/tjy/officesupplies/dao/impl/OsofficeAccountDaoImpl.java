
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsofficeAccountDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-9   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsofficeAccountDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsofficeAccountBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:OsofficeAccountDaoImpl.java</p>
 *<p>Description:固定资产台帐台帐管理数据库接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-9
 */
public class OsofficeAccountDaoImpl extends XtDbBaseDao implements OsofficeAccountDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 OsofficeAccountByOrgList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsofficeAccountDao#OsofficeAccountByOrgList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean OsofficeAccountByOrgList(String parmjson,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		OsofficeAccountBean osofficeaccountbean = new OsofficeAccountBean();
		if (!StringUtil.isBlank(parmjson)) {
			osofficeaccountbean = (OsofficeAccountBean) JSONObject.parseObject(parmjson, OsofficeAccountBean.class);
		}
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<OsofficeAccountBean> list = new ArrayList<OsofficeAccountBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select org.org_id                 org_id,");
		sql.append("       org.org_name               org_name,");
		sql.append("       to_char(officeaccounts.receive_day,'yyyy-mm-dd') as receive_day,");
		sql.append("       officeaccounts.zccount     as zccount");
		sql.append("  from td_sm_organization org");
		sql.append("  left join (select t.org_id, t.org_name, receive_day, zccount");
		sql.append("               from (select offices.org_id,");
		sql.append("                            offices.org_name,");
		sql.append("                            (select max(t.receive_day)");
		sql.append("                               from ta_oa_officeaccount t");
		sql.append("                              where t.org_id = offices.org_id) as receive_day,");
		sql.append("                            ");
		sql.append("                            (select count(t.id)");
		sql.append("                               from ta_oa_officeaccount t");
		sql.append("                              where t.org_id = offices.org_id) as zccount");
		sql.append("                     ");
		sql.append("                       from ta_oa_officeaccount offices");
		sql.append("                      where 1 = 1");
		sql.append("                      group by offices.org_id, offices.org_name) t) officeaccounts on org.org_id =");
		sql.append("                                                                                      officeaccounts.org_id");
		sql.append("");
		sql.append(" where 1 = 1");
		sql.append(" and org.parent_id<>'0' ");
		//机构ID
		if(!StringUtil.isBlank(osofficeaccountbean.getOrg_id())){
			sql.append(" and org.org_id = '"+osofficeaccountbean.getOrg_id()+"'");
		}
		//机构名称
		if(!StringUtil.isBlank(osofficeaccountbean.getOrg_name())){
			sql.append(" and org.org_name like '%"+osofficeaccountbean.getOrg_name()+"%'");
		}
		//排序
		sql.append(" order by org.org_sn asc, " + sortName + " " + sortOrder);
		db.preparedSelect(sql.toString(),offset, maxPagesize);
    	
    	
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			OsofficeAccountBean searchbean = new OsofficeAccountBean();
			searchbean.setOrg_id(db.getString(i, "org_id"));//机构ID
			searchbean.setOrg_name(db.getString(i, "org_name"));//机构名称
			searchbean.setReceive_day(db.getString(i, "receive_day"));//最后修改时间
			searchbean.setZccount(db.getString(i, "zccount"));//资产数量
			list.add(searchbean);
	    }
		pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	/**
	*<b>Summary: </b>
	* OsofficeDetailList(查询台帐详情管理)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean OsofficeDetailList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception{
		Connection conn = null;
		OsofficeAccountBean osofficeaccountbean= new OsofficeAccountBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				osofficeaccountbean = (OsofficeAccountBean) JSONObject.parseObject(parmjson, OsofficeAccountBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select id,");
			sql.append("       code,");
			sql.append("       name,");
			sql.append("       type,");
			sql.append("       money,");
			sql.append("       to_char(receive_day,'yyyy-mm-dd') as receive_day,");
			sql.append("       receive_username,");
			sql.append("       blame_username,");
			sql.append("       oftype_name,");
			sql.append("       deposit_place,");
			sql.append("       assetsuse,");
			sql.append("       wastedisposal,");
			sql.append("       remarks,");
			sql.append("       org_id,");
			sql.append("       org_name,");
			sql.append("       unit_id,");
			sql.append("       unit_name");
			sql.append("  from ta_oa_officeaccount ");
			sql.append("  where 1=1");
			if(osofficeaccountbean!=null){
				//所属单位ID
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getUnit_id())) {
					sql.append(" and unit_id = ? ");
					condition.add(osofficeaccountbean.getUnit_id());
				}
				//机构ID
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getOrg_id())) {
					sql.append(" and org_id = ? ");
					condition.add(osofficeaccountbean.getOrg_id());
				}
				//标示卡编号
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getCode())) { 
					sql.append(" and code like '%'||?||'%'");
					condition.add(osofficeaccountbean.getCode());
				}
				//名称
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getName())) {
					sql.append(" and name like '%'||?||'%'");
					condition.add(osofficeaccountbean.getName());
				}
				//规格\型号
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getType())) { 
					sql.append(" and type like '%'||?||'%'");
					condition.add(osofficeaccountbean.getType());
				}
				//领用开始时间
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getReceive_Stime())) {
					sql.append(" and receive_day >= ").append(" to_date('").append(osofficeaccountbean.getReceive_Stime()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
				}
				//领用结束时间
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getReceive_Etime())) { 
					sql.append(" and receive_day <= ").append(" to_date('").append(osofficeaccountbean.getReceive_Etime()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
				}
				//金额
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getMoney())) {
					sql.append(" and money like '%'||?||'%'");
					condition.add(osofficeaccountbean.getMoney());
				}
				//责任人
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getBlame_username())) {
					sql.append(" and blame_username like '%'||?||'%'");
					condition.add(osofficeaccountbean.getBlame_username());
				}
				
				//类别
				if(!StringUtil.nullOrBlank(osofficeaccountbean.getOftype_id())){
					sql.append(" and oftype_id = ? ");
					condition.add(osofficeaccountbean.getOftype_id());
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
	  *     复写方法 getOfficeDetailBean
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsofficeAccountDao#getOfficeDetailBean(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getOfficeDetailBean(String id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select id,");
		sql.append("       code,");
		sql.append("       name,");
		sql.append("       type,");
		sql.append("       money,");
		sql.append("       to_char(receive_day,'yyyy-mm-dd') as receive_day,");
		sql.append("       receive_username,");
		sql.append("       receive_user_id,");
		sql.append("       blame_user_id,");
		sql.append("       blame_username,");
		sql.append("       oftype_id,");
		sql.append("       oftype_name,");
		sql.append("       deposit_place,");
		sql.append("       assetsuse,");
		sql.append("       wastedisposal,");
		sql.append("       remarks,");
		sql.append("       org_id,");
		sql.append("       org_name,");
		sql.append("       unit_id,");
		sql.append("       unit_name");
		sql.append("  from ta_oa_officeaccount");
		sql.append(" where id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteOfficeDetailByIds
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsofficeAccountDao#deleteOfficeDetailByIds(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteOfficeDetailByIds(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_officeaccount ");
		sql.append(" where id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	
	
	/**
	*<b>Summary: </b>
	* OsofficeDetailToExcel(查询台帐详情管理用于导出Excel)
	* @param parmjson
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> OsofficeDetailToExcel(String parmjson) throws Exception{
		Connection conn = null;
		OsofficeAccountBean osofficeaccountbean= new OsofficeAccountBean();
		List<Map<String,String>> result = new ArrayList<Map<String,String>>();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				osofficeaccountbean = (OsofficeAccountBean) JSONObject.parseObject(parmjson, OsofficeAccountBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select id,");
			sql.append("       code,");
			sql.append("       name,");
			sql.append("       type,");
			sql.append("       money,");
			sql.append("       to_char(receive_day,'yyyy-mm-dd') as receive_day,");
			sql.append("       receive_username,");
			sql.append("       blame_username,");
			sql.append("       oftype_name,");
			sql.append("       deposit_place,");
			sql.append("       assetsuse,");
			sql.append("       wastedisposal,");
			sql.append("       remarks,");
			sql.append("       org_id,");
			sql.append("       org_name,");
			sql.append("       unit_id,");
			sql.append("       unit_name");
			sql.append("  from ta_oa_officeaccount ");
			sql.append("  where 1=1");
			if(osofficeaccountbean!=null){
				//机构ID
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getOrg_id())) {
					sql.append(" and org_id = ? ");
					condition.add(osofficeaccountbean.getOrg_id());
				}
				//标示卡编号
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getCode())) { 
					sql.append(" and code like '%'||?||'%'");
					condition.add(osofficeaccountbean.getCode());
				}
				//名称
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getName())) {
					sql.append(" and name like '%'||?||'%'");
					condition.add(osofficeaccountbean.getName());
				}
				//规格\型号
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getType())) { 
					sql.append(" and type like '%'||?||'%'");
					condition.add(osofficeaccountbean.getType());
				}
				//领用开始时间
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getReceive_Stime())) {
					sql.append(" and receive_day >= ").append(" to_date('").append(osofficeaccountbean.getReceive_Stime()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
				}
				//领用结束时间
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getReceive_Etime())) { 
					sql.append(" and receive_day <= ").append(" to_date('").append(osofficeaccountbean.getReceive_Etime()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
				}
				//金额
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getMoney())) {
					sql.append(" and money like '%'||?||'%'");
					condition.add(osofficeaccountbean.getMoney());
				}
				//责任人
				if (!StringUtil.nullOrBlank(osofficeaccountbean.getBlame_username())) {
					sql.append(" and blame_username like '%'||?||'%'");
					condition.add(osofficeaccountbean.getBlame_username());
				}
			}
			//排序
			sql.append(" order by  receive_day asc ");
			result = queryToListMap(sql.toString(), condition);
			return result;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

}
