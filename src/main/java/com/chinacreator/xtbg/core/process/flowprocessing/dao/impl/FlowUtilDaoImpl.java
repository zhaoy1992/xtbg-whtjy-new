package com.chinacreator.xtbg.core.process.flowprocessing.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.workflow.shark.procconfig.ProcessConfigManager;
import com.chinacreator.xtbg.core.agency.entity.FlowAgencyInfoBean;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.StringSplitUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowActionUserBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowDefinfoBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionExtBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InsViewListBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InstanceBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowActionTreeConfigBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactUser;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:FlowUtilDaoImpl.java</p>
 *<p>Description:流程工具接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-22
 */
public class FlowUtilDaoImpl implements FlowUtilDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowDefBean
	  * @param orgId
	  * @param busiTypeCode
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getFlowDefBean(java.lang.String, java.lang.String)
	 */
	public FlowDefinfoBean getFlowDefBean(String orgId, String busiTypeCode) throws SQLException {
		FlowDefinfoBean flowDefinfoBean = null;
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
	// 张家界定制
	//String flag = "";
	//String userArea = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	//if (!"430800".equals(userArea)) {
	//	flag = "true";
	/*	sql.append("select d.flow_id,");
		sql.append("       d.flow_defid,");
		sql.append("       d.flow_version,");
		sql.append("       d.package_id,");
		sql.append("       d.def_id,");
		sql.append("       (select m.action_form");
		sql.append("          from oa_flow_wfaction w, ta_oa_flow_action_fromdefid m");
		sql.append("         where w.def_id = d.def_id");
		sql.append("           and w.action_id = m.action_id");
		sql.append("           and w.actiontype_code = '01') as action_form,");
		sql.append("       (select w1.action_defid");
		sql.append("          from oa_flow_wfaction w1");
		sql.append("         where w1.def_id = d.def_id");
		sql.append("           and w1.actiontype_code = '01') as action_defid");
		sql.append("  from ta_oa_flow_flowbaseinfo f, ta_oa_flow_flowdefinfo d");
		sql.append(" where f.flow_id = d.flow_id");
		sql.append("   and f.is_valid = 'Y'");
		sql.append("   and d.is_valid = 'Y'");
		sql.append("   and (f.org_id = ? and f.is_indivi = 'N') ");
		sql.append("   and trim(f.busitype_code) = trim(?)");
		sql.append("   order by d.flow_id desc");
		}*/
	//else if ("430800".equals(userArea) || "421000".equals(userArea)) {
		//if (1==1) {
		//flag = "false";
		sql.append("select d.flow_id,");
		sql.append("       d.flow_defid,");
		sql.append("       d.flow_version,");
		sql.append("       d.package_id,");
		sql.append("       d.def_id,");
		sql.append("       f.insname_rule,");
		sql.append("       f.from_path  as action_form,");
		//sql.append("       (select m.action_form");
		//sql.append("          from oa_flow_wfaction w, oa_flow_actionfromdefid m");
		//sql.append("         where w.def_id = d.def_id");
		//sql.append("           and w.action_id = m.action_id");
		//sql.append("           and w.actiontype_code = '01') as action_form,");
		sql.append("       (select w1.action_defid");
		sql.append("          from oa_flow_wfaction w1");
		sql.append("         where w1.def_id = d.def_id");
		sql.append("           and w1.actiontype_code = '01') as action_defid");
		sql.append("  from oa_flow_baseinfo f, oa_flow_definfo d,oa_flow_busitype t");
		sql.append(" where f.flow_id = d.flow_id and  t.busitype_code = f.busitype_code ");
		sql.append("   and f.is_valid = 'Y'");
		sql.append("   and d.is_valid = 'Y'");
		sql.append("   and trim(f.busitype_code) = trim(?)");
		//sql.append("  and t.areacode ='" + userArea + "'");
		sql.append("   order by d.flow_id desc");
		System.out.println(sql.toString());

	//}

		db.preparedSelect(sql.toString());
		//if (flag.equals("true")) {
		//	db.setString(1, orgId);
			db.setString(1, busiTypeCode);
		//} else {
		//	db.setString(1, busiTypeCode);
		//}
		db.executePrepared();
		if (db.size() > 0) {
			flowDefinfoBean = new FlowDefinfoBean();
			flowDefinfoBean.setFlow_id(db.getString(0, "flow_id"));
			flowDefinfoBean.setFlow_defid(db.getString(0, "flow_defid"));
			flowDefinfoBean.setFlow_version(db.getString(0, "flow_version"));
			flowDefinfoBean.setPackage_id(db.getString(0, "package_id"));
			flowDefinfoBean.setAction_form(db.getString(0, "action_form"));
			flowDefinfoBean.setAction_defid(db.getString(0, "action_defid"));
			flowDefinfoBean.setDef_id(db.getString(0,"def_id"));
			flowDefinfoBean.setInsname_rule(db.getString(0, "insname_rule"));
		}

		return flowDefinfoBean;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowDefBean
	  * @param def_id
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getFlowDefBean(java.lang.String)
	 */
	public FlowDefinfoBean getFlowDefBean(String def_id) throws SQLException {
		FlowDefinfoBean flowDefinfoBean = null;
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select d.flow_id,");
		sql.append("       d.flow_defid,");
		sql.append("       d.flow_version,");
		sql.append("       d.package_id,");
		sql.append("       d.def_id,");
		sql.append("       f.insname_rule,");
		sql.append("       f.from_path  as action_form,");
		//sql.append("       (select m.action_form");
		//sql.append("          from oa_flow_wfaction w, oa_flow_actionfromdefid m");
		//sql.append("         where w.def_id = d.def_id");
		//sql.append("           and w.action_id = m.action_id");
		//sql.append("           and w.actiontype_code = '01') as action_form,");
		sql.append("       (select w1.action_defid");
		sql.append("          from oa_flow_wfaction w1");
		sql.append("         where w1.def_id = d.def_id");
		sql.append("           and w1.actiontype_code = '01') as action_defid");
		sql.append("  from oa_flow_definfo d");
		sql.append("  left join OA_FLOW_BASEINFO f on f.flow_id = d.flow_id");
		sql.append(" where d.def_id = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, def_id);
		db.executePrepared();

		if (db.size() > 0) {
			flowDefinfoBean = new FlowDefinfoBean();
			flowDefinfoBean.setFlow_id(db.getString(0, "flow_id"));
			flowDefinfoBean.setFlow_defid(db.getString(0, "flow_defid"));
			flowDefinfoBean.setFlow_version(db.getString(0, "flow_version"));
			flowDefinfoBean.setPackage_id(db.getString(0, "package_id"));
			flowDefinfoBean.setAction_form(db.getString(0, "action_form"));
			flowDefinfoBean.setAction_defid(db.getString(0, "action_defid"));
			flowDefinfoBean.setDef_id(db.getString(0,"def_id"));
			flowDefinfoBean.setInsname_rule(db.getString(0,"insname_rule"));
		}

		return flowDefinfoBean;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowviewlist
	  * @param ins_id
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getFlowviewlist(java.lang.String)
	 */
	

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getMiddleFlowDefBean
	  * @param def_id
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getMiddleFlowDefBean(java.lang.String)
	 */
	public FlowDefinfoBean getMiddleFlowDefBean(String def_id) throws SQLException {
		FlowDefinfoBean flowDefinfoBean = null;
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select d.flow_id,");
		sql.append("       d.flow_defid,");
		sql.append("       d.flow_version,");
		sql.append("       d.package_id,");
		sql.append("       d.def_id,");
		sql.append("       f.insname_rule,");
		sql.append("       f.from_path  as action_form");
		sql.append("  from oa_flow_definfo d, oa_flow_baseinfo f");
		sql.append(" where d.flow_id = f.flow_id and d.def_id = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, def_id);
		db.executePrepared();

		if (db.size() > 0) {
			flowDefinfoBean = new FlowDefinfoBean();
			flowDefinfoBean.setFlow_id(db.getString(0, "flow_id"));
			flowDefinfoBean.setFlow_defid(db.getString(0, "flow_defid"));
			flowDefinfoBean.setFlow_version(db.getString(0, "flow_version"));
			flowDefinfoBean.setPackage_id(db.getString(0, "package_id"));
			flowDefinfoBean.setDef_id(db.getString(0,"def_id"));
			flowDefinfoBean.setInsname_rule(db.getString(0,"insname_rule"));
			flowDefinfoBean.setAction_form(db.getString(0, "action_form"));
		}

		return flowDefinfoBean;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActionId
	  * @param def_id
	  * @param action_defid
	  * @return 
	 * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getActionId(java.lang.String, java.lang.String)
	 */
	public String getActionId(String def_id, String action_defid) throws SQLException{
		PreparedDBUtil db = new PreparedDBUtil();
		String action_id = "";
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT W.ACTION_ID");
		sql.append("   FROM oa_flow_wfaction W");
		sql.append("  WHERE W.DEF_ID = ?");
		sql.append("    AND W.ACTION_DEFID = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, def_id);
		db.setString(2, action_defid);
		db.executePrepared();
		if (db.size() > 0) {
			action_id = db.getString(0, "action_id");
		}

		return action_id;

	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActionFrom
	  * @param action_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getActionFrom(java.lang.String)
	 */
	public String getActionFrom(String action_id) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String action_form = "";
		sql.append("select f.action_form");
		sql.append("  from oa_flow_actionfromdefid f");
		sql.append(" where f.action_id = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, action_id);
		db.executePrepared();
		if (db.size() > 0) {
			action_form = db.getString(0,"action_form");
		}

		return action_form;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowActionExtBean
	  * @param action_id
	  * @return 
	 * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getFlowActionExtBean(java.lang.String)
	 */
	public FlowWfactionExtBean getFlowActionExtBean(String action_id) throws SQLException

	{
		FlowWfactionExtBean flowWfactionExtBean = null;
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT E.ACTIONEXT_ID, E.ISSHOWUSER, E.ISSHOWREJECT, E.ISSHOWBACK, E.ISDISPENSE, E.AUTOASSIGNMENT, E.ISSIGNJOINBYORDER");
		sql.append("  FROM OA_FLOW_WFACTIONEXT E");
		sql.append(" WHERE E.ACTION_ID = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, action_id);
		db.executePrepared();
		if (db.size() > 0) {
			flowWfactionExtBean = new

			FlowWfactionExtBean();
			flowWfactionExtBean.setActionext_id(db.getString(0, "actionext_id"));
			flowWfactionExtBean.setIsshowuser(db.getString(0, "isshowuser"));
			flowWfactionExtBean.setIsshowreject(db.getString(0, "isshowreject"));
			flowWfactionExtBean.setIsshowback(db.getString(0, "isshowback"));
			flowWfactionExtBean.setIsdispense(db.getString(0, "isdispense"));
			flowWfactionExtBean.setAutoassignment(db.getString(0, "autoassignment"));
			flowWfactionExtBean.setIssignjoinbyorder(db.getString(0, "issignjoinbyorder"));
		}

		return flowWfactionExtBean;

	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActionAlias
	  * @param flowId
	  * @param actDefId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getActionAlias(java.lang.String, java.lang.String)
	 */
	public String getActionAlias(String flowId, String actDefId)
			throws Exception {
		StringBuffer sqlStr = new StringBuffer();
		sqlStr.append("select w.action_alias from oa_flow_wfaction w ");
		sqlStr.append(" where w.def_id= '").append(flowId).append("'");
		sqlStr.append(" and w.action_defid= '").append(actDefId).append("'");
		return DaoUtil.sqlToField(sqlStr.toString());
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActionOrder
	  * @param flowId
	  * @param actDefId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getActionOrder(java.lang.String, java.lang.String)
	 */
	public String getActionOrder(String flowId, String actDefId)
			throws Exception {
		StringBuffer sqlStr = new StringBuffer();
		sqlStr.append("select w.action_id from oa_flow_wfaction w ");
		sqlStr.append(" where w.def_id= '").append(flowId).append("'");
		sqlStr.append(" and w.action_defid= '").append(actDefId).append("'");
		return DaoUtil.sqlToField(sqlStr.toString());
	}

	public String getInsCode(String busitype_code) {
		return busitype_code;

	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowWfactionBean
	  * @param action_id
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getFlowWfactionBean(java.lang.String)
	 */
	public FlowWfactionBean getFlowWfactionBean(String action_id)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		FlowWfactionBean flowWfactionBean = null;

		StringBuffer sql = new StringBuffer();
		sql.append("select w.action_id,");
		sql.append("       w.action_name,");
		sql.append("       w.action_alias,");
		sql.append("       w.limit_unit,");
		sql.append("       w.action_limit,");
		sql.append("       w.def_id,");
		sql.append("       w.action_defid,");
		sql.append("       w.actiontype_code");
		sql.append("  from oa_flow_wfaction w");
		sql.append(" where w.action_id = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, action_id);
		db.executePrepared();

		if (db.size() > 0) {
			flowWfactionBean = new FlowWfactionBean();
			flowWfactionBean.setAction_id(db.getString(0,"action_id"));
			flowWfactionBean.setAction_name(db.getString(0,"action_name"));
			flowWfactionBean.setAction_alias(db.getString(0,"action_alias"));
			flowWfactionBean.setLimit_unit(db.getString(0,"limit_unit"));
			flowWfactionBean.setAction_limit(db.getString(0,"action_limit"));
			flowWfactionBean.setDef_id(db.getString(0,"def_id"));
			flowWfactionBean.setAction_defid(db.getString(0,"action_defid"));
			flowWfactionBean.setActiontype_code(db.getString(0, "actiontype_code"));
		}
		return flowWfactionBean;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getInstanceBean
	  * @param ins_id
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getInstanceBean(java.lang.String)
	 */
	public InstanceBean getInstanceBean(String ins_id) throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		InstanceBean instanceBean = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select i.ins_id,");
		sql.append("        i.busitype_code,");
		sql.append("        i.status_code,");
		sql.append("        i.ins_name,");
		sql.append("        i.ins_code,");
		sql.append("        i.accept_time,");
		sql.append("        i.accepter,");
		sql.append("        i.accepter_id,");
		sql.append("        i.org_id,");
		sql.append("        i.flow_id,");
		sql.append("        i.cc_form_instanceid,");
		sql.append("        i.busi_id");
		sql.append("   from oa_flow_instance i");
		sql.append("  where i.ins_id = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, ins_id);
		db.executePrepared();

		if (db.size() > 0) {
			instanceBean = new InstanceBean();
			instanceBean.setIns_id(db.getString(0, "ins_id"));
			instanceBean.setBusitype_code(db.getString(0,"busitype_code"));
			instanceBean.setStatus_code(db.getString(0,"status_code"));
			instanceBean.setIns_name(db.getString(0,"ins_name"));
			instanceBean.setIns_code(db.getString(0,"ins_code"));
			instanceBean.setAccept_time(db.getString(0,"accept_time"));
			instanceBean.setAccepter(db.getString(0,"accepter"));
			instanceBean.setAccepter_id(db.getString(0,"accepter_id"));
			instanceBean.setOrg_id(db.getString(0,"org_id"));
			instanceBean.setFlow_id(db.getString(0,"flow_id"));
			instanceBean.setCc_form_instanceid(db.getString(0, "cc_form_instanceid"));
			instanceBean.setBusi_id(db.getString(0,"busi_id"));
		}
		return instanceBean;

	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getNextActUser
	  * @param def_id
	  * @param nextActId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getNextActUser(java.lang.String, java.lang.String)
	 */
	public String getNextActUser(String def_id, String nextActId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select to_char(wmsys.wm_concat(wu.user_name)) as user_name");
		sql.append("  from oa_flow_wfactuser wu");
		sql.append(" where wu.action_id =");
		sql.append("       (select w.action_id");
		sql.append("          from oa_flow_wfaction w");
		sql.append("         where w.def_id = '");
		sql.append(def_id);
		sql.append("'");
		sql.append("           and w.action_defid = '");
		sql.append(nextActId);
		sql.append("')");
		return DaoUtil.sqlToField(sql.toString());
	}

	public String getActivityProperty(String moduleId, String

	procName, String activityId, String propertyName) {
		String userid = new ProcessConfigManager().getActivityProperty(moduleId, procName, activityId, propertyName);
		return userid;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getAction_Id
	  * @param flow_id
	  * @param actDefId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getAction_Id(java.lang.String, java.lang.String)
	 */
	public String getAction_Id(String def_id, String actDefId)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		String action_id = "";
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT W.ACTION_ID");
		sql.append("  FROM oa_flow_wfaction W");
		sql.append(" WHERE W.DEF_ID = ?");
		sql.append("   AND W.ACTION_DEFID = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, def_id);
		db.setString(2, actDefId);
		db.executePrepared();
		if (db.size() > 0) {
			action_id = db.getString(0, "action_id");
		}

		return action_id;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActUser
	  * @param action_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getActUser(java.lang.String)
	 */
	public List<FlowWfactUser> getActUser(String action_id) throws Exception {
		List<FlowWfactUser> flowWfactUserList = new ArrayList<FlowWfactUser>();
		FlowWfactUser flowWfactUser = null;
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select u.action_id, u.user_id, u.user_name, u.actuser_type");
		sql.append("  from oa_flow_wfactuser u");
		sql.append(" where u.action_id = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, action_id);
		db.executePrepared();
		
		for ( int i = 0; i < db.size(); i++) {
			flowWfactUser = new FlowWfactUser();
			flowWfactUser.setAction_id(db.getString(i, "action_id"));
			flowWfactUser.setUser_id(db.getString(i, "user_id"));
			flowWfactUser.setUser_name(db.getString(i, "user_name"));
			flowWfactUser.setActuser_type(db.getString(i, "actuser_type"));
			
			flowWfactUserList.add(flowWfactUser);
		}
		return flowWfactUserList;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActOrderUser
	  * @param action_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getActOrderUser(java.lang.String)
	 */
	@Override
	public List<FlowWfactUser> getActOrderUser(String action_id) throws Exception {
		List<FlowWfactUser> flowWfactUserList = new ArrayList<FlowWfactUser>();
		FlowWfactUser flowWfactUser = null;
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql  = new StringBuffer();//"select o.org_id , t.user_id, t.user_name, t.user_realname from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id = (select org_id from td_sm_organization cd  where cd.parent_id = '0')connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3' and t.user_id in (select u.user_id from oa_flow_wfactuser u where u.action_id = ? and u.actuser_type = '1') order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
		
		sql.append("select o.org_id, t.user_id, t.user_name, t.user_realname");
		sql.append("  from (select rownum index_sn, org.org_id, org.org_name");
		sql.append("          from td_sm_organization org");
		sql.append("         start with instr((select to_char(wmsys.wm_concat(org_id))");
		sql.append("                            from td_sm_organization cd");
		sql.append("                           where cd.parent_id = '0'),");
		sql.append("                          org.org_id) > 0");
		sql.append("        connect by prior org.org_id = org.parent_id");
		sql.append("         order siblings by org.org_sn) o");
		sql.append("  left join td_sm_orguser ou on ou.org_id = o.org_id");
		sql.append("  left join td_sm_user t on t.user_id = ou.user_id");
		sql.append("  left join td_sm_userjoborg a on a.user_id = ou.user_id");
		sql.append("                              and ou.org_id = a.org_id");
		sql.append(" where (t.user_name is not null)");
		sql.append("   and t.user_isvalid != '3'");
		sql.append("   and t.user_id in (select u.user_id");
		sql.append("                       from oa_flow_wfactuser u");
		sql.append("                      where u.action_id = ?");
		sql.append("                        and u.actuser_type = '1')");
		sql.append(" order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn");
		db.preparedSelect(sql.toString());
		db.setString(1, action_id);
		db.executePrepared();
		
		for ( int i = 0; i < db.size(); i++) {
			flowWfactUser = new FlowWfactUser();
			flowWfactUser.setAction_id(action_id);
			flowWfactUser.setUser_id(db.getString(i, "user_id"));
			flowWfactUser.setUser_name(db.getString(i, "user_name"));
			flowWfactUser.setUser_realname(db.getString(i, "user_realname"));
			flowWfactUser.setActuser_type("1");//在sql中已经将不为1的用户排除，所以，此处获取的全部是有效的用户。

			flowWfactUserList.add(flowWfactUser);
		}
		return flowWfactUserList;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getCountersignType
	  * @param action_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getCountersignType(java.lang.String)
	 */
	public String getCountersignType(String action_id) throws Exception {
		String issignjoinbyorder = "";
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select e.issignjoinbyorder");
		sql.append("  from oa_flow_wfactionext e");
		sql.append(" where e.action_id = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, action_id);
		db.executePrepared();
		if (db.size() > 0) {
			issignjoinbyorder = db.getString(0, "issignjoinbyorder");
		}
		return issignjoinbyorder;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActionTreeConfig
	  * @param action
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getActionTreeConfig(java.lang.String)
	 */
	@Override
	public FlowActionTreeConfigBean getActionTreeConfig(String action_id)
			throws Exception {
		FlowActionTreeConfigBean flowActionTreeConfigBean = null;
		PreparedDBUtil db = new PreparedDBUtil();
		String sql  = "select t.config_id, t.action_id, t.tree_role, t.tree_nodetype from OA_FLOW_ACTIONTREECONFIG t where t.action_id = ?";
		db.preparedSelect(sql.toString());
		db.setString(1, action_id);
		db.executePrepared();
		
		if(db.size() > 0){
			flowActionTreeConfigBean = new FlowActionTreeConfigBean();
			flowActionTreeConfigBean.setAction_id(action_id);
			flowActionTreeConfigBean.setConfig_id(db.getString(0, "config_id"));
			flowActionTreeConfigBean.setTree_nodetype(db.getString(0, "tree_nodetype"));
			flowActionTreeConfigBean.setTree_role(db.getString(0, "tree_role"));
		}
		return flowActionTreeConfigBean;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActAutoassignmentUser
	  * @param action_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getActAutoassignmentUser(java.lang.String)
	 */
	@Override
	public List<FlowWfactUser> getActAutoassignmentUser(String action_id, String ins_id, String flow_id)
			throws Exception {
		List<FlowWfactUser> flowWfactUserList = new ArrayList<FlowWfactUser>();
		FlowWfactUser flowWfactUser = null;
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.user_id, t.user_name, t.user_realname");
		sql.append("  from (select u.user_id, u.user_name, u.user_realname");
		sql.append("          from oa_flow_inswfaction iw, td_sm_user u");
		sql.append("         where iw.action_handername = u.user_name");
		sql.append("           and iw.action_handername is not null");
		sql.append("           and iw.act_defid = ?");
		sql.append("           and iw.ins_id = ?");
		sql.append("         order by iw.tache_end_time desc) t");
		sql.append(" where rownum = 1");
		db.preparedSelect(sql.toString());
		db.setString(1, flow_id);
		db.setString(2, ins_id);
		db.executePrepared();
		
		for ( int i = 0; i < db.size(); i++) {
			flowWfactUser = new FlowWfactUser();
			flowWfactUser.setAction_id(action_id);
			flowWfactUser.setUser_id(db.getString(i, "user_id"));
			flowWfactUser.setUser_name(db.getString(i, "user_name"));
			flowWfactUser.setUser_realname(db.getString(i, "user_realname"));
			flowWfactUser.setActuser_type("1");//在sql中已经将不为1的用户排除，所以，此处获取的全部是有效的用户。

			flowWfactUserList.add(flowWfactUser);
		}
		return flowWfactUserList;
	}

	@Override
	public String getUserIds(String userrelnames) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		String userids = "";
		String[] arr_userrelnames = userrelnames.split(",");
		for(int i=0;i<arr_userrelnames.length;i++){
			String sql  = "select WM_CONCAT(u.user_id) as userids from td_sm_user u where instr(',"+ arr_userrelnames[i] +",',','||u.user_name||',') > 0 ";
			db.preparedSelect(sql.toString());
			db.executePrepared();
			if(db.size() > 0){
				userids = userids + ',' + db.getString(0, "userids");
			}
		}
		return userids;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getActionUserBeanList
	  * @param ins_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#getActionUserBeanList(java.lang.String) 
	  */
	@Override
	public List<FlowActionUserBean> getActionUserBeanList(String ins_id, Connection con) throws Exception {
		List<FlowActionUserBean> flowActionUserBeanList = new ArrayList<FlowActionUserBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select countersign_type,");
		sql.append("       countersign_group,");
		sql.append("       countersign_maxorder,");
		sql.append("       countersign_order");
		sql.append("  from oa_flow_actionuser where ins_id =?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, ins_id);
		pdb.executePrepared(con);
		for(int i=0; i<pdb.size();i++) {
			FlowActionUserBean flowActionUserBean =  new FlowActionUserBean();
			flowActionUserBean.setCountersign_type(pdb.getString(i, "countersign_type"));
			flowActionUserBean.setCountersign_group(pdb.getString(i, "countersign_group"));
			flowActionUserBean.setCountersign_maxorder(pdb.getString(i, "countersign_maxorder"));
			flowActionUserBean.setCountersign_order(pdb.getString(i, "countersign_order"));
			flowActionUserBeanList.add(flowActionUserBean);
		}
		return flowActionUserBeanList;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 save
	  * @param bean
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao#save(com.chinacreator.xtbg.core.agency.entity.FlowAgencyInfoBean, java.sql.Connection)
	 */
	public boolean save(FlowAgencyInfoBean bean, Connection con)
			throws Exception {
		String sql="insert into oa_flow_agency_info(id,busitype_code,agency_id,entrust_id,ins_id,actinsid,action_name,action_id) values (?,?,?,?,?,?,?,?)";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedInsert(sql);
		int i=1;
		pdb.setString(i++, bean.getId());
		pdb.setString(i++, bean.getBusitype_code());
		pdb.setString(i++, bean.getAgency_id());
		pdb.setString(i++, bean.getEntrust_id());
		pdb.setString(i++, bean.getIns_id());
		pdb.setString(i++, bean.getActinsid());
		pdb.setString(i++, bean.getAction_name());
		pdb.setString(i++, bean.getAction_id());
		pdb.executePrepared(con);
		
		return true;
	}
	
	/**
	 * 判断当前环节是否是会签环节
	 */
	@Override
	public boolean isSignAction(String ins_id) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		boolean flag = false;
		String sql  = "  SELECT NVL(OFW.ISSIGNJOINBYORDER,'0') as IS_SIGN_ACTION  FROM OA_FLOW_WFACTIONEXT OFW WHERE OFW.ACTION_ID =("
					+"SELECT OFII.ACTION_ID  FROM OA_FLOW_INSWFACTION OFII  WHERE OFII.INSERT_ORDER ="
					+"(SELECT MAX(OFI.INSERT_ORDER) FROM OA_FLOW_INSWFACTION OFI  WHERE OFI.INS_ID = ?))";
		db.preparedSelect(sql.toString());
		db.setString(1, ins_id);
		db.executePrepared();
		if(db.size() > 0){
			String is_sign_action = db.getString(0, "IS_SIGN_ACTION");
			if(!"0".equals(is_sign_action)){
				flag = true;	
			}
		}
		return flag;
	}

	@Override
	public String isActInsId(String ins_id) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		String act_insid = "";
		String sql  = " SELECT OFII.ACT_INSID FROM OA_FLOW_INSWFACTION OFII WHERE OFII.INSERT_ORDER = (SELECT MAX(OFI.INSERT_ORDER)  FROM OA_FLOW_INSWFACTION OFI WHERE OFI.INS_ID = ?)";
		db.preparedSelect(sql.toString());
		db.setString(1, ins_id);
		db.executePrepared();
		if(db.size() > 0){
			act_insid = db.getString(0, "ACT_INSID");
		}
		return act_insid;
	}
	
	/**
	 * 
	 */
	@Override
	public String getActionName(String def_id, String action_defid)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		String action_name = "";
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT W.ACTION_NAME");
		sql.append("   FROM oa_flow_wfaction W");
		sql.append("  WHERE W.DEF_ID = ?");
		sql.append("    AND W.ACTION_DEFID = ?");
		db.preparedSelect(sql.toString());
		db.setString(1, def_id);
		db.setString(2, action_defid);
		db.executePrepared();
		if (db.size() > 0) {
			action_name = db.getString(0, "action_name");
		}
		return action_name;
	}

	@Override
	public List<InsViewListBean> getFlowviewlist(String ins_id)
			throws SQLException {
		return new FlowViewDaoImpl().getFlowviewlist(ins_id);
	}

	@Override
	public JSONObject checkIsAllSignJoin(String ins_id, String action_id,
			String curr_userid, String order) throws Exception {
		String last_action_id = DaoUtil.sqlToField("select action_id from ( select * from ta_oa_ins_wfaction i where i.ins_id = "+ins_id+" and i.action_id <> "+action_id+" order by i.flow_action_id desc) where rownum = 1");
		String signjoin_handlerids = DaoUtil.sqlToField("select wm_concat(ux.user_id) signjoin_handlerids from(select u.user_id,o.user_index from td_sm_user u inner join (select column_value user_name,rownum user_index from table (select split(action_handler) from (select * from ta_oa_ins_wfaction_info t where t.ins_id = "+ins_id+" and t.action_id = '"+last_action_id+"' order by t.wfaction_infoid desc) where rownum = 1)) o on o.user_name = u.user_name order by o.user_index) ux");
		String isAllSignJoin = "true";
		String strReadSignUsers="";//会签按顺序进行时，前面人未处理的用户Id
		if("userLevelLowToHigh".equals(order)){//如果按用户级别从低到高的顺序
			signjoin_handlerids = StringSplitUtil.changeSplitStrOrder(signjoin_handlerids,",");
			isAllSignJoin = DaoUtil.sqlToField("select wf.isAllSignJoin("+ins_id+","+action_id+","+curr_userid+",'"+signjoin_handlerids+"') from dual");
		}else if("userLevelHighToLow".equals(order)){//如果按用户级别从高到低的顺序
			isAllSignJoin = DaoUtil.sqlToField("select wf.isAllSignJoin("+ins_id+","+action_id+","+curr_userid+",'"+signjoin_handlerids+"') from dual");
		}else{
			//如果只是选择了“会签”，则什么都不处理
		}
		//会签按顺序进行时，前面人未处理的人
		if("false".equals(isAllSignJoin)){
			String strReadSignUserId = signjoin_handlerids.substring(0, signjoin_handlerids.indexOf(curr_userid) - 1);
			strReadSignUsers = DaoUtil.sqlToField("select wm_concat(t.user_realname) from td_sm_user t where t.user_id in("+strReadSignUserId+")");
		}
		
		JSONObject json = new JSONObject();
		json.put("isAllSignJoin",isAllSignJoin);
		json.put("readSignUsers",strReadSignUsers);
		json.put("signjoin_handlerids",signjoin_handlerids);
		return json;
	}
	/**
	 * 
	 * getDocmentAttachIdByInsId(根据流程实例ID，获取配置的正文ID，附件ID)
	 * @param ins_id
	 * @return Map<String,String> key :"zw_id" (正文ID)  key:"fj_id"（附件ID） 。。 无法获取是key里的值为空
	 */
	@Override
	public Map<String, String> getDocmentAttachIdByInsId(String ins_id,Connection conn){
		Map<String, String> mess = new HashMap<String, String>();
		try {
			String[][] insBean = DaoUtil.sqlToFieldsArray("select i.busi_id,i.ins_name,i.busitype_code,i.flow_id from oa_flow_instance i where i.ins_id = '"+ins_id+"'",conn);
			if(insBean!=null&&insBean.length>0){
				String busi_id = insBean[0][0];	//业务id
				String ins_name = insBean[0][1];	//实例名称
				String flow_id = insBean[0][3];	//定义ID
				mess.put("ins_name", ins_name);
				String busitype_code = insBean[0][2];	//业务类型
				String flow_type = StringUtil.deNull(DaoUtil.sqlToField("select wb.flow_tyle from OA_FLOW_BASEINFO wb where wb.busitype_code = '"+busitype_code+"'",conn));

				//如果是WORD版本
				if("2".equals(flow_type)){
					String template_id = StringUtil.deNull(DaoUtil.sqlToField("select wb.template_id from OA_FLOW_BASEINFO wb where wb.busitype_code = '"+busitype_code+"'",conn));

					StringBuffer sql = new StringBuffer();
					sql.append("select wt.table_id,");
					sql.append("       max(decode(wt.textinput_value_type, '2', wt.column_id, '-1')) zw_col,");
					sql.append("       max(decode(wt.textinput_value_type, '3', wt.column_id, '-1')) fj_col");
					sql.append("  from oa_word_textinput wt");
					sql.append(" group by wt.template_id, wt.table_id");
					sql.append(" having wt.template_id = '"+template_id+"'");
					String[][] templateFjArray = DaoUtil.sqlToFieldsArray(sql.toString());
					
					if(templateFjArray.length > 0){
						String bus_table_name = templateFjArray[0][0];
						String pk_code = StringUtil.deNull(DaoUtil.sqlToField("select table_pk from oa_md_table where table_code = '"+bus_table_name+"'",conn));
						String yw_col = templateFjArray[0][1];
						String fj_col = templateFjArray[0][2];
						if(!StringUtil.nullOrBlank(fj_col)){
							String fj_id = StringUtil.deNull(DaoUtil.sqlToField("select "+fj_col+" from "+bus_table_name+" where "+pk_code+" =  '"+busi_id+"'",conn));
							mess.put("fj_id", fj_id);
						}
						if(!StringUtil.nullOrBlank(yw_col)){
							String yw_id = StringUtil.deNull(DaoUtil.sqlToField("select "+yw_col+" from "+bus_table_name+" where "+pk_code+" =  '"+busi_id+"'",conn));
							mess.put("yw_id", yw_id);
						}
					}
				//如果是表单版本
				}else{
					//1查询 表名 和 正文 列名
					String[] tableAndCol = this.geColumnArray(flow_id, "txt", conn);
					//2查询 表 主键列名
					String pk_code = StringUtil.deNull(DaoUtil.sqlToField("select table_pk from oa_md_table where table_code = '"+tableAndCol[0]+"'"));
					//3查询原文ID
					String yw_id = StringUtil.deNull(DaoUtil.sqlToField("select "+tableAndCol[1]+" from "+tableAndCol[0]+" where "+pk_code+" =  '"+busi_id+"'",conn));
					mess.put("yw_id", yw_id);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mess;
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * geColumnArray(获得相关 表名 和 列名字)
	 * @param flow_id
	 * @param tag_type_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	private String[] geColumnArray(String flow_id,String tag_type_id,Connection conn) throws Exception{
		String[] columnArray = new String[2];
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select oa_form_tag_config.table_id, oa_form_tag_config.column_id");
		sql.append("  from oa_form_tag_config");
		sql.append(" where oa_form_tag_config.form_id in");
		sql.append("       (select oa_form_config.form_id");
		sql.append("          from oa_form_config");
		sql.append("         where oa_form_config.form_name in");
		sql.append("               (select OA_FLOW_FORM.Form_Name");
		sql.append("                  from OA_FLOW_FORM");
		sql.append("                 where OA_FLOW_FORM.FORM_PATH in");
		sql.append("                       (select oa_flow_baseinfo.from_path");
		sql.append("                          from oa_flow_baseinfo");
		sql.append("                         where oa_flow_baseinfo.flow_id =");
		sql.append("                               '"+flow_id+"')))");
		sql.append("   and oa_form_tag_config.tag_type_id = '"+tag_type_id+"'");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			columnArray[0] = pdb.getString(0, "table_id");
			columnArray[1] = pdb.getString(0, "column_id");
		}
		return columnArray;
	}
}
