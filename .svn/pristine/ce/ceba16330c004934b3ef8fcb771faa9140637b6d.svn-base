
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAppraisalDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

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
import com.chinacreator.xtbg.tjy.device.dao.DevAppraisalDao;
import com.chinacreator.xtbg.tjy.device.entity.DevAppraisalBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevAppraisalDaoImpl.java</p>
 *<p>Description:检定记录数据库Dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-8
 */
public class DevAppraisalDaoImpl extends XtDbBaseDao implements DevAppraisalDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selDevAppraisalList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevAppraisalDao#selDevAppraisalList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selDevAppraisalList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		
		Connection conn = null;
		DevAppraisalBean devappraisalbean= new DevAppraisalBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				devappraisalbean = (DevAppraisalBean) JSONObject.parseObject(parmjson, DevAppraisalBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select appr_id,");
			sql.append("       t_sb_id,");
			sql.append("       info.num as dev_code,");
			sql.append("       info.name as dev_name,");
			sql.append("       info.type_name as dev_type,");
			sql.append("       appr_no,");
			sql.append("       appr_org_id,");
			sql.append("       dict1.dictdata_name as appr_org_name,");
			sql.append("       to_char(appr_time, 'yyyy-mm-dd') as appr_time,");
			sql.append("       to_char(appr_valitime, 'yyyy-mm-dd') as appr_valitime,");
			sql.append("       appr_parrange,");
			sql.append("       appr_method_id,");
			sql.append("       dict2.dictdata_name as appr_method,");
			sql.append("       appr_result,");
			sql.append("       to_char(next_appr_time, 'yyyy-MM-dd') as next_appr_time");
			sql.append("  from ta_oa_whtjy_gdzc   info,");
			sql.append("       ta_oa_devappraisal appr,");
			sql.append("       oa_dict_data       dict1,");
			sql.append("       oa_dict_data       dict2");
			sql.append(" where info.id = appr.t_sb_id");
			sql.append("   and appr_org_id = dict1.dictdata_id");
			sql.append("   and appr_method_id = dict2.dictdata_id");
			if(devappraisalbean!=null){
				//设备设备ID
				if (!StringUtil.nullOrBlank(devappraisalbean.getT_sb_id())) {
					sql.append(" and t_sb_id = ? ");
					condition.add(devappraisalbean.getT_sb_id());
				}
				//设备编号
				if (!StringUtil.nullOrBlank(devappraisalbean.getDev_code())) {
					sql.append(" and info.num like '%'||?||'%'");
					condition.add(devappraisalbean.getDev_code());
				}
				//设备名称
				if (!StringUtil.nullOrBlank(devappraisalbean.getDev_name())) { 
					sql.append(" and info.name like '%'||?||'%'");
					condition.add(devappraisalbean.getDev_name());
				}
				//设备类型
				if (!StringUtil.nullOrBlank(devappraisalbean.getDev_type())) { 
					sql.append(" and info.dev_type like '%'||?||'%'");
					condition.add(devappraisalbean.getDev_type());
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
	  *     复写方法 getDevAppraisalBean
	  * @param appr_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevAppraisalDao#getDevAppraisalBean(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevAppraisalBean(String appr_id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select appr_id,");
		sql.append("       t_sb_id,");
		sql.append("       info.num as dev_code,");
		sql.append("       info.name as dev_name,");
		sql.append("       info.type_name as dev_type,");
		sql.append("       appr_no,");
		sql.append("       appr_org_id,");
		sql.append("       appr_org_name,");
		sql.append("       to_char(appr_time, 'yyyy-mm-dd') as appr_time,");
		sql.append("       to_char(appr_valitime, 'yyyy-mm-dd') as appr_valitime,");
		sql.append("       appr_parrange,");
		sql.append("       appr_method_id,");
		sql.append("       appr_method,");
		sql.append("       appr_result,");
		sql.append("       to_char(next_appr_time, 'yyyy-MM-dd') as next_appr_time");
		sql.append("  from ta_oa_whtjy_gdzc info, ta_oa_devappraisal appr");
		sql.append(" where info.id = appr.t_sb_id");
		sql.append("   and appr_id = ?");
		viewMap = queryToSingleMap(conn, sql.toString(), appr_id);
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevAppraisalById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevAppraisalDao#deleteDevAppraisalById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteDevAppraisalById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devappraisal ");
		sql.append(" where appr_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

}
