
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevIssuedPlanDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-3   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevIssuedPlanDao;
import com.chinacreator.xtbg.tjy.device.entity.DevIssuedPlanBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevIssuedPlanDaoImpl.java</p>
 *<p>Description:下达核检计划数据库dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-3
 */
public class DevIssuedPlanDaoImpl extends XtDbBaseDao implements DevIssuedPlanDao{
	
	/**
	 * 
	*<b>Summary: </b>
	* selDevIssuedPlanList(查询下达核检计划列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevIssuedPlanList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception{
		Connection conn = null;
		DevIssuedPlanBean devissuedplanbean = new DevIssuedPlanBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				devissuedplanbean = (DevIssuedPlanBean) JSONObject.parseObject(parmjson, DevIssuedPlanBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select plan_id,");
			sql.append("       plan_internal_no,");
			sql.append("	   plan_title,");
			sql.append("       checkuser_id,");
			sql.append("       checkuser_name,");
			sql.append("       datas.dictdata_name as checktype,");
			sql.append("       to_char(compltime,'yyyy-mm-dd') as compltime,");
			sql.append("       datas1.dictdata_name as complflag,");
			sql.append("       t.remark,");
			sql.append("       t.creater_userid as creater_userid,");
			sql.append("       t.creater_username as creater_username,");
			sql.append("       unit_id,");
			sql.append("       unit_name");
			sql.append("  from ta_oa_devissuedplan t, ");
			sql.append("       oa_dict_data datas ,  ");
			sql.append("       oa_dict_data datas1 ");
			sql.append(" where  t.checktype = datas.dictdata_id ");
			sql.append("   and t.complflag = datas1.dictdata_id ");
			if(devissuedplanbean!=null){
				//核验表标题
				if(!StringUtil.nullOrBlank(devissuedplanbean.getPlan_title())){
					sql.append(" and plan_title like '%'||?||'%'");
					condition.add(devissuedplanbean.getPlan_title());
				}
				//核检负责人
				if (!StringUtil.nullOrBlank(devissuedplanbean.getCheckuser_name())) {
					sql.append(" and checkuser_name like '%'||?||'%'");
					condition.add(devissuedplanbean.getCheckuser_name());
				}
				//完成状态
				if (!StringUtil.nullOrBlank(devissuedplanbean.getComplflag())) {
					sql.append(" and datas1.dictdata_id like '%'||?||'%'");
					condition.add(devissuedplanbean.getComplflag());
				}
				//界面入口
				if(!StringUtil.nullOrBlank(devissuedplanbean.getType())){
					sql.append(" and checkuser_id = ?");
					condition.add(devissuedplanbean.getUser_id());
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
	 * 
	*<b>Summary: </b>
	* getDevIssuedPlan(根据id查询下达核检计划)
	* @param plan_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevIssuedPlan(String plan_id,Connection conn) throws Exception{
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.plan_id,");
		sql.append("       a.checkuser_id,");
		sql.append("       a.checkuser_name,");
		sql.append("       a.checktype,");
		sql.append("       to_char(a.compltime, 'yyyy-MM-dd') as compltime,");
		sql.append("       a.complflag,");
		sql.append("       a.remark,");
		sql.append("       a.creater_userid,");
		sql.append("       a.creater_username,");
		sql.append("       a.unit_id,");
		sql.append("       a.unit_name,");
		sql.append("       a.plan_internal_no,");
		sql.append("       a.plan_title");
		sql.append("  from ta_oa_devissuedplan a");
		sql.append(" where plan_id = ?");
		viewMap = queryToSingleMap(conn, sql.toString(), plan_id);
		
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* deleteDevIssuedPlanById(根据id删除下达核检计划)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevIssuedPlanById(Connection conn,String beanId)throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devissuedplan ");
		sql.append(" where plan_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
}
