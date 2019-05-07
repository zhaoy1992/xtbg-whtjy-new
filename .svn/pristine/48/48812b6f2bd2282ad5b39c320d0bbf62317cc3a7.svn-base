
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     PCWorkFlowDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-1-13   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.process.workflowphone.dao.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.entity.ViewListBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InsViewListBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InsWfactionBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:PCWorkFlowDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-1-13
 */
public class PCWorkFlowDaoImpl implements
		com.chinacreator.xtbg.core.process.workflowphone.dao.PCWorkFlowDao {

	/** 
	 * <b>Summary: </b>
	 *     复写方法 saveCompleteActView
	 * @param flowInfo
	 * @param con
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.process.workflowphone.dao.PCWorkFlowDao#saveCompleteActView(java.util.Map, java.sql.Connection) 
	 */
	@Override
	public Map<String, String> saveCompleteActView(
			Map<Object, Object> flowInfo, Connection con) throws Exception {
		Map<String, String> map = new HashMap<String,String>();
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		Map<String, String> flowCtrlInfo = (Map)flowInfo.get("flowCtrlInfo");
		String action_id = flowData.get("action_id");
		String ins_id = (String)flowData.get("ins_id");
		String action_name = flowData.get("action_name");
		String action_form = flowData.get("action_form");
		String accepter_id = flowData.get("accepter_id");
		String user_name = flowData.get("userName");
		String actInsId = flowData.get("actInsId");
	
		InsWfactionBean insWfactionBean = new InsWfactionBean();
		insWfactionBean.setIns_id(ins_id);
		insWfactionBean.setAction_id(action_id);
		insWfactionBean.setAction_name(action_name);
		insWfactionBean.setAction_handerid(accepter_id);
		insWfactionBean.setAction_handername(user_name);
		insWfactionBean.setAction_form(action_form);
		insWfactionBean.setAct_insid(actInsId);

		String action_handeridea = (String)flowInfo.get("action_handeridea");
		if(!StringUtil.isBlank(action_handeridea)) {
			ViewListBean insViewListBean = new ViewListBean();
			insViewListBean.setIns_id(insWfactionBean.getIns_id());
			insViewListBean.setAction_id(insWfactionBean.getAction_id());
			insViewListBean.setAction_name(insWfactionBean.getAction_name());
			insViewListBean.setAction_handeridea(action_handeridea);
			insViewListBean.setOrg_id((String)flowInfo.get("orgid"));
			insViewListBean.setOrg_name((String)flowInfo.get("orgName"));
			insViewListBean.setUser_name((String)flowInfo.get("userRealName"));
			insViewListBean.setUser_id(insWfactionBean.getAction_handerid());
			insViewListBean.setTable_name((String)flowInfo.get("table_name"));
			insViewListBean.setColumn_name((String)flowInfo.get("column_name"));
			saveActionView(insViewListBean, con);//保存意见信息
		}
		return map;
	}
	
	/**
	 * 保存环节意见
	 * @param insViewListBean 流程意见Bean
	 * @throws Exception
	 */
	public void saveActionView(ViewListBean insViewListBean, Connection con) throws Exception{
		try {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			String viewlist_id = StringUtil.getUUID();
			sql.append("insert into oa_flow_insviewlist ");
			sql.append("  (viewlist_id, ");
			sql.append("   ins_id, ");
			sql.append("   action_id, ");
			sql.append("   action_name, ");
			sql.append("   action_handeridea, ");
			sql.append("   hander_time, ");
			sql.append("   is_valid, ");
			sql.append("   org_id, ");
			sql.append("   org_name, ");
			sql.append("   user_id, ");
			sql.append("   user_name,");
			sql.append("   table_name,");
			sql.append("   column_name) ");
			sql.append("values ");
			sql.append("  (?, ?, ?, ?, ?, sysdate, 'Y', ?, ?, ?, ?, ?, ?) ");
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, viewlist_id);
			pdb.setString(2, insViewListBean.getIns_id());
			pdb.setString(3, insViewListBean.getAction_id());
			pdb.setString(4, insViewListBean.getAction_name());
			pdb.setString(5, insViewListBean.getAction_handeridea());
			pdb.setString(6, insViewListBean.getOrg_id());
			pdb.setString(7, insViewListBean.getOrg_name());
			pdb.setString(8, insViewListBean.getUser_id());
			pdb.setString(9, insViewListBean.getUser_name());
			pdb.setString(10, StringUtil.deNull(insViewListBean.getTable_name()).toUpperCase());
			pdb.setString(11, StringUtil.deNull(insViewListBean.getColumn_name()).toUpperCase());
			pdb.executePrepared(con);
			
		} catch(Exception e) {
			e.printStackTrace(); 
		} 

	}

}
