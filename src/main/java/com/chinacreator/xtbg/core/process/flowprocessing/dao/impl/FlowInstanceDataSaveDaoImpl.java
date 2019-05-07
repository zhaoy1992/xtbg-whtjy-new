package com.chinacreator.xtbg.core.process.flowprocessing.dao.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.servlet.AttachmentConfigBean;
import com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.entity.ViewListBean;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowActionUserBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InsWfactionBean;
import com.frameworkset.common.poolman.CallableDBUtil;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:FlowInstanceDataSaveDaoImpl.java</p>
 *<p>Description:流程实例业务数据保存实例类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-20
 */
public class FlowInstanceDataSaveDaoImpl implements FlowInstanceDataSaveDao  {

	/**
	 * 
	*<b>Summary: </b>
	* saveFlowInfo(保存流程基本信息)
	* @param flowInfo
	* @param con
	* @return
	* @throws Exception
	 */
	public void saveFlowInfo(Map<Object, Object> flowInfo, Connection con)
			throws Exception {
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		String status_code = (String)flowInfo.get("status_code");
		String busi_id = (String) flowInfo.get("busi_id");
		String ins_name = (String)flowInfo.get("ins_name");
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		String busitype_code = flowData.get("busitype_code");
		String accepter_id = flowData.get("accepter_id");
		String accepter = flowData.get("accepter");
		String flow_id = flowData.get("flow_id");
		String	org_id = flowData.get("org_id");
		String cc_form_instanceid = flowData.get("cc_form_instanceid");
		String ins_code = flowData.get("ins_code");
		String def_id = flowData.get("def_id");
		String ins_id =  flowData.get("ins_id"); 
		String template_id =  flowData.get("template_id"); 
		String parent_ins_id =  flowData.get("parent_ins_id"); 

		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_flow_instance");
		sql.append("  (ins_id,");
		sql.append("   busitype_code,");
		sql.append("   status_code,");
		sql.append("   ins_name,");
		sql.append("   ins_code,");
		sql.append("   accept_time,");
		sql.append("   accepter,");
		sql.append("   accepter_id,");
		sql.append("   def_id,");
		sql.append("   org_id,");
		sql.append("   flow_id,");
		sql.append("   lastmodifedtime,");
		sql.append("   cc_form_instanceid,");
		sql.append("   busi_id,");
		sql.append("   template_id,parent_ins_id) values");
		sql.append("  (?,?,?,?,?,sysdate,?,?,?,?,?,sysdate,?,?,?,?) ");
		
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, ins_id);
		pdb.setString(2, busitype_code);
		pdb.setString(3, status_code);
		pdb.setString(4, ins_name);
		pdb.setString(5, ins_code);
		pdb.setString(6, accepter);
		pdb.setString(7, accepter_id);
		pdb.setString(8, def_id);
		pdb.setString(9, org_id);
		pdb.setString(10, flow_id);
		pdb.setString(11, cc_form_instanceid);
		pdb.setString(12, busi_id);
		pdb.setString(13, template_id);
		pdb.setString(14, parent_ins_id);
		pdb.executePrepared(con);
		
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* updateFlowInfoTitle(修改流程标题)
	* @param flowInfo
	* @param con
	* @throws Exception
	 */
	public void updateFlowInfoTitle(Map<Object, Object> flowInfo, Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		String ins_id = (String)flowData.get("ins_id");
		String ins_name = (String)flowInfo.get("ins_name");
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_flow_instance");
		sql.append("  set  ins_name = ? ");
		sql.append("  where ins_id = ?");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, ins_name);
		pdb.setString(2, ins_id);
		pdb.executePrepared(con);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* updateFlowInfo(请用一句话描述这个方法的作用 1.流程实例数据 2.流程添加数据)
	* @param flowInfo 流程业务数据
	* @param con
	* @return
	* @throws Exception
	 */
	public InsWfactionBean updateFlowInfo(Map<Object, Object> flowInfo, Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		String action_id = flowData.get("action_id");
		String ins_id = (String)flowData.get("ins_id");
		String status_code = (String)flowInfo.get("status_code");
		String action_name = (String)flowData.get("action_name");
		String ins_name = (String)flowInfo.get("ins_name");
		
	
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_flow_instance");
		sql.append("  set status_code = ?, ins_name = ? ");
		sql.append("  where ins_id = ?");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, status_code);
		pdb.setString(2, ins_name);
		pdb.setString(3, ins_id);

		pdb.executePrepared(con);
		
		InsWfactionBean insWfactionBean = null;
		if("01".equals(status_code)){
			insWfactionBean = new InsWfactionBean();
			insWfactionBean.setIns_id(ins_id);
			insWfactionBean.setAction_id(action_id);
			insWfactionBean.setAction_name(action_name);
		}
		return insWfactionBean;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* updateReFlowInfo(修改流程名称)
	* @param flowInfo
	* @param con
	* @throws Exception
	 */
	public void updateReFlowInfo(Map<Object, Object> flowInfo, Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		String ins_id = (String)flowData.get("ins_id");
		String ins_name = (String)flowInfo.get("ins_name");
		StringBuffer sql = new StringBuffer();

		sql.append("update oa_flow_instance");
		sql.append("  set ins_name = ? ");
		sql.append("  where ins_id = ?");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, ins_name);
		pdb.setString(2, ins_id);
		pdb.executePrepared(con);

	}
	
	/**
	 * 
	*<b>Summary: </b>
	* saveActionInfo(保存环节业务数据)
	* @param flowData
	* @param con
	* @return
	* @deprecated
	* @throws Exception
	 */
	public String saveActionInfo(Map<String, String> flowData, Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sqlaction = new StringBuffer();
		String flow_action_id = DaoUtil.findBySequencsName("seq_ins_wfaction",con);
		
		String accepter_id = flowData.get("accepter_id");
		String user_name = flowData.get("userName");
		String action_id = flowData.get("action_id");
		String action_name = flowData.get("action_name");
		String action_form = flowData.get("action_form");
		String ins_id =  flowData.get("ins_id"); 
		
		sqlaction.append("insert into oa_flow_inswfaction");
		sqlaction.append("  (flow_action_id,");
		sqlaction.append("   ins_id,");
		sqlaction.append("   action_id,");
		sqlaction.append("   action_name,");
		sqlaction.append("   action_handerid,");
		sqlaction.append("   action_handername,");
		sqlaction.append("   tache_begin_time,");
		sqlaction.append("   tache_end_time,");
		sqlaction.append("   tache_limit,");
		sqlaction.append("   limit_type,");
		sqlaction.append("   spend_limit,");
		sqlaction.append("   is_overdue,");
		sqlaction.append("   action_form) values");
		sqlaction.append("  (?,?,?,?,?,?,sysdate,sysdate,?,?,?,?,?)");
		pdb.preparedInsert(sqlaction.toString());
		pdb.setString(1, flow_action_id);
		pdb.setString(2, ins_id);
		pdb.setString(3, action_id);
		pdb.setString(4, action_name);
		pdb.setString(5, accepter_id);
		pdb.setString(6, user_name);
		pdb.setString(7, "");
		pdb.setString(8, "");
		pdb.setString(9, "");
		pdb.setString(10, "");
		pdb.setString(11, action_form);
		pdb.executePrepared(con);
		return flow_action_id;
		
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* saveActionView(保存环节意见)
	* @param request
	* @param viewListBeanList
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean saveActionView(HttpServletRequest request, HttpServletResponse response, List<ViewListBean> viewListBeanList, Connection con) throws Exception{
		
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		String user_id = control.getUserID();
		String userRealName = control.getUserName();
		String orgid = control.getChargeOrgId();//与orgId区分
		String orgName = control.getChargeOrgName();
		
		
		String flowDataJson = request.getParameter("flowData");//流程信息
		flowDataJson = DataControlUtil.replaceStr(flowDataJson);
		Map<String, String> flowData = (Map)JSONObject.parseObject(flowDataJson);// 根据字符串转换对象
		String action_id = StringUtil.deNull(flowData.get("action_id"));
		String action_name = StringUtil.deNull(flowData.get("action_name"));
		//String ins_id = StringUtil.deNull(flowData.get("ins_id"));
		String ins_id = StringUtil.deNull((String)request.getAttribute("ins_id"));
		PreparedDBUtil pdb = new PreparedDBUtil();
		String viewlist_id = "";
		if(null != viewListBeanList) {
			for (int i = 0; i < viewListBeanList.size(); i++) {
				viewlist_id = StringUtil.getUUID();
				ViewListBean viewListBean = viewListBeanList.get(i);
				StringBuffer sql = new StringBuffer();
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
				pdb.setString(2, ins_id);
				pdb.setString(3, action_id);
				pdb.setString(4, action_name);
				pdb.setString(5, viewListBean.getAction_handeridea());
				pdb.setString(6, orgid);
				pdb.setString(7, orgName);
				pdb.setString(8, user_id);
				pdb.setString(9, userRealName);
				pdb.setString(10, viewListBean.getTable_name());
				pdb.setString(11, viewListBean.getColumn_name());
				pdb.executePrepared(con);
			}
		}
		return true;

	}
	
	/**
	 * 
	*<b>Summary: </b>
	* updateActionInfo(更新活动业务数据)
	* @param insWfactionBean
	* @param con
	* @deprecated
	* @throws SQLException
	 */
	public void updateActionInfo(InsWfactionBean insWfactionBean, Connection con) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String action_id = insWfactionBean.getAction_id();
		String ins_id = insWfactionBean.getIns_id();
		
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_flow_inswfaction");
		sql.append("  set tache_begin_time = sysdate, ");
		sql.append("  tache_end_time = sysdate ");
		sql.append("  where ins_id = ? and action_id= ?");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, ins_id);
		pdb.setString(2, action_id);
		pdb.executePrepared(con);
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveForTempFromNew
	  * @param flowInfo
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#saveForTempFromNew(java.util.Map, java.sql.Connection)
	 */
	public void saveForTempFromNew(Map<Object, Object> flowInfo, Connection con)
			throws Exception {
		saveFlowInfo(flowInfo, con);
		//Map<String, String> flowData = (Map)flowInfo.get("flowData");
		//saveActionInfo(flowData, con);//保存活动操作信息
		
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveForRepeatedlyTemp
	  * @param flowInfo
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#saveForRepeatedlyTemp(java.util.Map, java.sql.Connection)
	 */
	public void saveForRepeatedlyTemp(Map<Object, Object> flowInfo,
			Connection con) throws Exception {
		updateReFlowInfo(flowInfo, con);
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveForAcceptFromNew
	  * @param flowInfo
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#saveForAcceptFromNew(java.util.Map, java.sql.Connection)
	 */
	public void saveForAcceptFromNew(Map<Object, Object> flowInfo,
			Connection con) throws Exception{
		flowInfo.put("status_code", "01");
		saveFlowInfo(flowInfo, con);//保存流程实例信息
		//Map<String, String> flowData = (Map)flowInfo.get("flowData");
		//saveActionInfo(flowData, con);//保存活动操作信息

	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveForAcceptFromTemp
	  * @param flowInfo
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#saveForAcceptFromTemp(java.util.Map, java.sql.Connection)
	 */
	public void saveForAcceptFromTemp(Map<Object, Object> flowInfo, Connection con) throws Exception {
		flowInfo.put("status_code", "01");
		updateFlowInfo(flowInfo, con);
		//updateActionInfo(insWfactionBean, con);
	}

	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveForCompleteAct
	  * @param flowInfo
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#saveForCompleteAct(java.util.Map, java.sql.Connection)
	 */
	public void saveForCompleteAct(Map<Object, Object> flowInfo, Connection con)
			throws Exception {
		updateFlowInfoTitle(flowInfo, con);
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		String action_id = flowData.get("action_id");
		String ins_id = (String)flowData.get("ins_id");
		String action_name = flowData.get("action_name");
		String action_form = flowData.get("action_form");
		String accepter_id = flowData.get("accepter_id");
		String user_name = flowData.get("userName");
		
		InsWfactionBean insWfactionBean = new InsWfactionBean();
		insWfactionBean.setIns_id(ins_id);
		insWfactionBean.setAction_id(action_id);
		insWfactionBean.setAction_name(action_name);
		insWfactionBean.setAction_handerid(accepter_id);
		insWfactionBean.setAction_handername(user_name);
		insWfactionBean.setAction_form(action_form);
		//String flow_action_id = saveActionInfo(flowData, con);
		
		//saveActionInfo(flowData, con);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveForGeneralFinish
	  * @param flowInfo
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#saveForGeneralFinish(java.util.Map, java.sql.Connection)
	 */
	public void saveForGeneralFinish(Map<Object, Object> flowInfo,
			Connection con) throws Exception {
		
		flowInfo.put("status_code", "02");
		updateFlowInfo(flowInfo, con);
		
		@SuppressWarnings("unchecked")
		Map<String, String> flowData = (Map<String, String>)flowInfo.get("flowData");
		String action_id = flowData.get("action_id");
		String ins_id = (String)flowData.get("ins_id");
		String action_name = flowData.get("action_name");
		String action_form = flowData.get("action_form");
		String accepter_id = flowData.get("accepter_id");
		String user_name = flowData.get("userName");
		
		InsWfactionBean insWfactionBean = new InsWfactionBean();
		insWfactionBean.setIns_id(ins_id);
		insWfactionBean.setAction_id(action_id);
		insWfactionBean.setAction_name(action_name);
		insWfactionBean.setAction_handerid(accepter_id);
		insWfactionBean.setAction_handername(user_name);
		insWfactionBean.setAction_form(action_form);
		//String flow_action_id = saveActionInfo(flowData, con);
		//saveActionInfo(flowData, con);

	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveForTerminationFlow
	  * @param flowInfo
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#saveForTerminationFlow(java.util.Map, java.sql.Connection)
	 */
	public void saveForTerminationFlow(Map<Object, Object> flowInfo,
			Connection con) throws Exception {
		flowInfo.put("status_code", "05");//05 表示终止流程
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		updateFlowInfo(flowInfo, con);
		FlowActionUserBean flowActionUserBean = new FlowActionUserBean();
		flowActionUserBean.setUser_name(flowData.get("userName"));
		flowActionUserBean.setIns_id(flowData.get("ins_id"));
		
		updateInswfaction(flowData.get("userName"), flowData.get("ins_id"), "05",  con);
		delFlow_actionuser(flowData.get("actInsId"),  con);
		
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActHanderUser
	  * @param act_insid
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#getActHanderUser(java.lang.String)
	 */
	public String getActHanderUser(String act_insid, Connection con) throws Exception {
		String action_handername = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		String sql = "select action_handername from oa_flow_inswfaction where act_insid = ?";
		pdb.preparedSelect(sql);
		pdb.setString(1, act_insid);
		pdb.executePrepared(con);
		if (pdb.size() > 0) {
			action_handername = pdb.getString(0, "action_handername");
		}
		
		return action_handername;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateInswfaction
	  * @param action_handername
	  * @param act_insidorIns_id
	  * @param status_code
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#updateInswfaction(java.lang.String, java.lang.String, java.lang.String)
	 */
	public void updateInswfaction(String action_handername,
			String act_insidorIns_id, String status_code, Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_flow_inswfaction");
		sql.append("  set  action_handername = ?,  tache_end_time = ?");
		
		if("05".equals(status_code)) { //终止流程
			sql.append("  where action_handername is null and ins_id = ?");
		}else if("07".equals(status_code)) { //自由流追回流程
			sql.append("  , is_valid = 'N' ");
			sql.append("  where act_insid = ?");
		}else if("06".equals(status_code)) { //自由流回退
			sql.append("  , is_valid = 'N' ");
			sql.append("  where act_insid = ?");
		}else {
			sql.append("  where act_insid = ?");
		}
		
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, action_handername);
		pdb.setTimestamp(2, new Timestamp(new Date().getTime()));
		pdb.setString(3, act_insidorIns_id);
		
		pdb.executePrepared(con);
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateFlow_actionuser
	  * @param flowActionUserBean
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#updateFlow_actionuser(com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowActionUserBean, java.sql.Connection)
	 */
	public void updateFlow_actionuser(FlowActionUserBean flowActionUserBean, Connection con)
			throws Exception {
		String countersign_type = "";//会签类型
		int countersign_order = 0;//会签顺序
		int countersign_maxorder = 0;//会签顺序最大值
		String countersign_group = ""; //会签分组
		int nextCountersign_order = 0;//下一个会签顺序
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = null;
		
		if(flowActionUserBean != null) {
			countersign_type = flowActionUserBean.getCountersign_type();
			if(StringUtil.isBlank(countersign_type)) { //如果不是会签或不是顺序会签
				sql = new StringBuffer();
				sql.append("update oa_flow_actionuser");
				sql.append("  set  is_handle = ?");
				sql.append("  where activity = ?");
				
				pdb.preparedUpdate(sql.toString());
				pdb.setString(1, flowActionUserBean.getIs_handle());
				pdb.setString(2, flowActionUserBean.getActivity());
				pdb.executePrepared(con);
			} else {//顺序会签
				sql = new StringBuffer();
				sql.append("update oa_flow_actionuser");
				sql.append("  set  is_handle = ?,");
				sql.append("       is_countersignperson = ? ");
				sql.append("  where activity = ? and user_name = ?");
				pdb.preparedUpdate(sql.toString());
				
				pdb.setString(1, flowActionUserBean.getIs_countersignperson());
				pdb.setString(2, flowActionUserBean.getIs_handle());
				pdb.setString(3, flowActionUserBean.getActivity());
				pdb.setString(4, flowActionUserBean.getUser_name());
				
				pdb.addPreparedBatch();
				
				countersign_order = Integer.valueOf(flowActionUserBean.getCountersign_order());
				countersign_maxorder = Integer.valueOf(flowActionUserBean.getCountersign_maxorder());
				countersign_group = flowActionUserBean.getCountersign_group();
				if (countersign_order != countersign_maxorder) {
					sql = new StringBuffer();
					sql.append("update oa_flow_actionuser u");
					sql.append("   set u.is_countersignperson = '1'");
					sql.append(" where u.activity = (select g.activity");
					sql.append("                       from oa_flow_actionuser g");
					sql.append("                      where g.countersign_group = ?");
					sql.append("                        and g.countersign_order = ?)");
					
					nextCountersign_order  = countersign_order + 1;
					pdb.setString(1, countersign_group);
					pdb.setString(2, String.valueOf(nextCountersign_order));
					pdb.addPreparedBatch();
				}
				
				pdb.executePreparedBatch(con);
				
				
				
			}
		}
		
	}

	/**
	 * 
	 * <b>Summary: </b>
	 *     新增/启动流程,或追回/完成/回退流程活动的时候,增加流程活动信息
	 * @param insWfactionBean
	 * @param con
	 * @throws Exception 
	 * @see 
	 */
	public void addInswfaction(InsWfactionBean insWfactionBean,
			Connection con) throws Exception {
		if(insWfactionBean != null) {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			
			sql.append("insert into oa_flow_inswfaction");
			sql.append("  (flow_action_id,");
			sql.append("   ins_id,");
			sql.append("   action_id,");
			sql.append("   action_name,");
			sql.append("   tache_begin_time,");
			sql.append("   act_insid,");
			sql.append("   act_defid,");
			sql.append("   processid,");
			sql.append("   insert_order,");
			sql.append("   action_form)");
			sql.append("values");
			sql.append("  (?, ?, ?, ?, ?, ?, ?, ?,SEQ_OA_FLOW_INSWFACTION.NEXTVAL, ?)");
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, StringUtil.getUUID());
			pdb.setString(2, insWfactionBean.getIns_id());
			pdb.setString(3, insWfactionBean.getAction_id());
			pdb.setString(4, insWfactionBean.getAction_name());
			pdb.setTimestamp(5, new Timestamp(new Date().getTime()));
			pdb.setString(6, insWfactionBean.getAct_insid());
			pdb.setString(7, insWfactionBean.getAct_defid());
			pdb.setString(8, insWfactionBean.getProcessid());
			pdb.setString(9, insWfactionBean.getAction_form());
			pdb.executePrepared(con);
		}
		
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addFlow_actionuser
	  * @param flowActionUserBean
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#addFlow_actionuser(com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowActionUserBean, java.sql.Connection)
	 */
	public void addFlow_actionuser(FlowActionUserBean flowActionUserBean, Connection con) throws Exception {
		if(flowActionUserBean != null) { 
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql.append("insert into oa_flow_actionuser");
			sql.append("  (actionuser_id,");
			sql.append("   ins_id,");
			sql.append("   act_defid,");
			sql.append("   activity,");
			sql.append("   activityprocessid,");
			sql.append("   activityprocessdefname,");
			sql.append("   user_name,");
			sql.append("   is_handle, ");
			sql.append("   countersign_type, ");
			sql.append("   countersign_order, ");
			sql.append("   is_countersignperson, ");
			sql.append("   countersign_group, ");
			sql.append("   countersign_maxorder) ");
			sql.append(" values ");
			sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, StringUtil.getUUID());
			pdb.setString(2, flowActionUserBean.getIns_id());
			pdb.setString(3, flowActionUserBean.getAct_defid());
			pdb.setString(4, flowActionUserBean.getActivity());
			pdb.setString(5, flowActionUserBean.getActivityprocessid());
			pdb.setString(6, flowActionUserBean.getActivityprocessdefname());
			pdb.setString(7, flowActionUserBean.getUser_name());
			pdb.setString(8, flowActionUserBean.getIs_handle());
			
			pdb.setString(9, flowActionUserBean.getCountersign_type());
			pdb.setString(10, flowActionUserBean.getCountersign_order());
			pdb.setString(11, flowActionUserBean.getIs_countersignperson());
			pdb.setString(12, flowActionUserBean.getCountersign_group());
			pdb.setString(13, flowActionUserBean.getCountersign_maxorder());
			pdb.executePrepared(con);
		}
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowActionUserBean
	  * @param act_insid
	  * @param user_name
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#getFlowActionUserBean(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public FlowActionUserBean getFlowActionUserBean(String act_insid, String user_name, Connection con)
			throws Exception {
		FlowActionUserBean flowActionUserBean = null;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select countersign_type,");
		sql.append("       countersign_group,");
		sql.append("       countersign_maxorder,");
		sql.append("       countersign_order");
		sql.append("  from oa_flow_actionuser where activity = ? and user_name = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, act_insid);
		pdb.setString(2, user_name);
		pdb.executePrepared(con);
		if (pdb.size() > 0) {
			flowActionUserBean = new FlowActionUserBean();
			flowActionUserBean.setCountersign_type(pdb.getString(0, "countersign_type"));
			flowActionUserBean.setCountersign_group(pdb.getString(0, "countersign_group"));
			flowActionUserBean.setCountersign_maxorder(pdb.getString(0, "countersign_maxorder"));
			flowActionUserBean.setCountersign_order(pdb.getString(0, "countersign_order"));
		}
		
		return flowActionUserBean;
		
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowActionUserBean
	  * @param act_insid
	  * @param user_name
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#getFlowActionUserBean(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public FlowActionUserBean getActionUserBean(String act_insid, String user_name, Connection con)
			throws Exception {
		FlowActionUserBean flowActionUserBean = null;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select ins_id,");
		sql.append("       act_defid,");
		sql.append("       activity,");
		sql.append("       activityprocessid,");
		sql.append("       activityprocessdefname ");
		sql.append("  from oa_flow_actionuser where activity = ? and user_name = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, act_insid);
		pdb.setString(2, user_name);
		pdb.executePrepared(con);
		if (pdb.size() > 0) {
			flowActionUserBean = new FlowActionUserBean();
			flowActionUserBean.setIns_id(pdb.getString(0, "ins_id"));
			flowActionUserBean.setAct_defid(pdb.getString(0, "act_defid"));
			flowActionUserBean.setActivity(pdb.getString(0, "activity"));
			flowActionUserBean.setActivityprocessid(pdb.getString(0, "activityprocessid"));
			flowActionUserBean.setActivityprocessdefname(pdb.getString(0, "activityprocessdefname"));
		}
		
		return flowActionUserBean;
		
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delFlow_actionuser
	  * @param act_insid
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#delFlow_actionuser(java.lang.String, java.sql.Connection)
	 */
	public void delFlow_actionuser(String act_insid, Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("delete oa_flow_actionuser u ");
		sql.append("       where u.activity = ?");
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, act_insid);
		
		pdb.executePrepared(con);
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getCountersignUser
	  * @param actDefid
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#getCountersignUser(java.lang.String, java.sql.Connection)
	 */
	public String getCountersignUser(String actDefid, String processid, Connection con)
			throws Exception {
		String username = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select wmsys.wm_concat(a.user_name) as username");
		sql.append("  from (select user_name");
		sql.append("          from oa_flow_actcountersignuser u");
		sql.append("         where u.is_handle = '0'");
		sql.append("           and u.act_defid = ?");
		sql.append("           and u.activityprocessid = ?");
		sql.append("         order by u.countersign_order) a");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, actDefid);
		pdb.setString(2, processid);
		pdb.executePrepared(con);
		if (pdb.size() > 0) {
			username = pdb.getString(0, "username");
		}
		
		return username;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delCountersignUser
	  * @param act_defid
	  * @param processid
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#delCountersignUser(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public void delCountersignUser(String act_defid, String processid,
			Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete oa_flow_actcountersignuser u ");
		sql.append("       where u.act_defid = ? and u.activityprocessid = ?");
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, act_defid);
		pdb.setString(2, processid);
		pdb.executePrepared(con);
		
	}

	/**
	 * 
	*<b>Summary: </b>
	* addCountersignUser(请用一句话描述这个方法的作用)
	* @param act_insid
	* @param con
	* @throws Exception
	 */
	public void addCountersignUser(String act_defid, String processid, Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into OA_FLOW_ACTCOUNTERSIGNUSER c");
		sql.append("  (c.actionuser_id,");
		sql.append("   c.ins_id,");
		sql.append("   c.act_defid,");
		sql.append("   c.activity,");
		sql.append("   c.activityprocessid,");
		sql.append("   c.activityprocessdefname,");
		sql.append("   c.user_name,");
		sql.append("   c.is_handle,");
		sql.append("   c.COUNTERSIGN_TYPE,");
		sql.append("   c.COUNTERSIGN_ORDER,");
		sql.append("   c.IS_COUNTERSIGNPERSON)");
		sql.append("  (select u.actionuser_id,");
		sql.append("          u.ins_id,");
		sql.append("          u.act_defid,");
		sql.append("          u.activity,");
		sql.append("          u.activityprocessid,");
		sql.append("          u.activityprocessdefname,");
		sql.append("          u.user_name,");
		sql.append("          u.is_handle,");
		sql.append("          u.COUNTERSIGN_TYPE,");
		sql.append("          u.COUNTERSIGN_ORDER,");
		sql.append("          u.IS_COUNTERSIGNPERSON");
		sql.append("     from oa_flow_actionuser u");
		sql.append("    where u.act_defid = ?");
		sql.append("      and u.activityprocessid = ?");
		sql.append("      and u.is_handle = '0')");
		
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, act_defid);
		pdb.setString(2, processid);
		pdb.executePrepared(con);
	}

	/**
	 * 
	 * <b>Summary: </b>
	 *     在追回流程时候,将部分流程环节置为无效
	 *     
	 *     部分流程环节包括(最近处理的有效的活动环节,最近处理之后产生的还未处理的活动环节)
	 *     
	 *     目前该方法未考虑情况(
	 *     	1：当前处于会签环节,部分完成会签用户 追回 自己处理的 会签活动
	 *      2: 
	 *     )
	 *     
	 *     与该方法配合完成追回功能的有(
	 *       function OA_IS_BACK 函数
	 *       oa_flow_inswfaction.insert_order 字段
	 *     )
	 * @param ins_id
	 * @param con
	 * @throws Exception 
	 * @see 
	 */
	public void updateRecycleInswfaction(String ins_id, Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update oa_flow_inswfaction w");
		sql.append("    set w.is_valid = 'N'");
		sql.append("  where w.flow_action_id =");
		sql.append("        (select flow_action_id");
		sql.append("           from (select wf.flow_action_id");
		sql.append("                   from oa_flow_inswfaction wf");
		sql.append("                  where wf.ins_id = ?");
		sql.append("                    and wf.action_handername is not null and wf.is_valid != 'N' ");
		sql.append("                  order by insert_order desc,wf.tache_end_time desc)");
		sql.append("          where rownum = 1)");

		sql.append("     or w.flow_action_id in");
		sql.append("        (select flow_action_id");
		sql.append("           from (select wf.flow_action_id");
		sql.append("                   from oa_flow_inswfaction wf");
		sql.append("                  where wf.ins_id = ?");
		sql.append("                    and wf.tache_end_time is  null and wf.is_valid != 'N'))");
		
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, ins_id);
		pdb.setString(2, ins_id);
		pdb.executePrepared(con);
		
	}
	
	/**
	 * 
	 * <b>公文归档: </b>
	 * @param saveData
	 * @param con
	 * @return
	 * @throws Exception 
	 * @see wordform.jsp-->iweboffice.js(19:doFlowSave())-->commonflowdo.js(getSaveData())-->ArchiveWordTextTag
	 * --->ArchiveServiceImpl(handler)--->FlowInstanceDataSaveDaoImpl(this method)
	 * getSaveData() contorl saveData
	 */
	//modify by shuqi.liu 此处的正文，面签改成按照TEXT_TYPE的类型取。
	public boolean sendToFile(Map<String,String> saveData, Connection con) throws Exception {
		//1:添加公文待归档信息(正文,原文存储到oa_file_before_archive_info中)
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_file_before_archive_info"); 
		sql.append(" (f_id,f_title,f_file_no,f_archive_type,f_org_id,f_org_name,f_dept_id," +
				   " f_dept_name,f_oldfile_type,f_mainfile_type," + //,f_oldfile_content,f_mainfile_content
				   " f_attach_id,f_create_user_id,f_create_date,f_archive_user_id,f_archive_date,f_is_archived,f_oldfile_content,f_mainfile_content)"); 
		sql.append("values (?,?,?,?,?,?,?,?,?,?,?,?,sysdate,?,sysdate,?" +
				   "  ,(select FILEBODY from oa_document_File  where RECORDID = '"+saveData.get("F_OLDFILE_CONTENT")+"' and TEXT_TYPE is null)" +
				   ",(select FILEBODY from oa_document_File  where RECORDID = '"+saveData.get("F_OLDFILE_CONTENT")+"' and TEXT_TYPE = 'text'))");//,?,?
		//String fjId = saveData.get("F_ATTACH_ID");
		String fjId = "";
		String formjpgfjId = saveData.get("F_ATTACH_ID");
		if(StringUtil.nullOrBlank(fjId)){
			fjId = StringUtil.getUUID();
		}
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1,StringUtil.getUUID()); 
		pdb.setString(2,saveData.get("F_TITLE"));	//标题
		pdb.setString(3,saveData.get("F_FILE_NO"));	//问好
		pdb.setString(4,saveData.get("F_ARCHIVE_TYPE"));//归档类型1:公文归档
		pdb.setString(5,saveData.get("F_ORG_ID"));	
		pdb.setString(6,saveData.get("F_ORG_NAME"));
		pdb.setString(7,saveData.get("F_DEPT_ID"));
		pdb.setString(8,saveData.get("F_DEPT_NAME"));
		//pdb.setString(1,saveData.get("f_oldfile_content"));
		pdb.setString(9,saveData.get("F_OLDFILE_TYPE"));//原文文件类型
		//pdb.setString(1,saveData.get("f_mainfile_content"));
		pdb.setString(10,saveData.get("F_MAINFILE_TYPE"));//正文文件类型
		pdb.setString(11,fjId);	//附件ID
		pdb.setString(12,saveData.get("F_CREATE_USER_ID"));
		//pdb.setString(13,saveData.get("F_CREATE_DATE"));
		pdb.setString(13,saveData.get("F_ARCHIVE_USER_ID"));
		//pdb.setString(15,saveData.get("F_ARCHIVE_DATE"));
		pdb.setString(14,saveData.get("F_IS_ARCHIVED"));//是否已经归档0:否,1:是
		pdb.executePrepared(con);
		//2:添加面签内容(存储到oa_fc_attach中)(copy from FileDocDaoImpl.insertAttachForFileDoc())
		String fileType = saveData.get("F_OLDFILE_TYPE");
		if(!StringUtil.nullOrBlank(fileType)){
			String fileName = "面签"+fileType;
			String mFilePath = saveData.get("mFilePath");
			String userId = "0";
			String djsn = StringUtil.getUUID();
			String djsnURL = djsn;
			FiletransferService ft = new FiletransferServiceImpl();
			sql = new StringBuffer();
			sql.append("insert into oa_fc_attach");
			sql.append("  (extend,");
			sql.append("   djbh,");
			sql.append("   dj_sn,");
			sql.append("   filename,");
			sql.append("   attachid,");
			sql.append("   bz,");
			sql.append("   djsn,");
			sql.append("   attachcontent,");
			sql.append("   filepos,");
			sql.append("   upload_mode,");
			sql.append("   cc_form_instanceid,");
			sql.append("   creator)");
			sql.append("values");
			sql.append("  ('"+fileType+"',");
			sql.append("   '"+fjId+"',");
			sql.append("   null,");
			sql.append("   '"+fileName+"',");
			sql.append("   '"+ft.getAttachId()+"',");
			sql.append("   null,");
			sql.append("   '"+djsn+"',");
			sql.append("   (select FILEBODY from oa_document_File  where RECORDID = '"+saveData.get("F_OLDFILE_CONTENT")+"' and TEXT_TYPE = 'singn' ),");
			sql.append("   '"+AttachmentConfigBean.getInstance().getMiddelUrlStr(null)+File.separator+djsnURL+fileType+"',");
			sql.append("   '1',");//文件存取模式：1-数据库、2-本地磁盘、3-FTP远程服务器
			sql.append("   null,");
			sql.append("   '"+userId+"')");
			DBUtil pdbb = new DBUtil();
			pdbb.executeInsert(sql.toString(), con);
			//2j
			String mFilePathA = AttachmentConfigBean.getBaseUrl()+AttachmentConfigBean.getMiddelUrlStr(null)+File.separator;
			FileUtils.mkDirectory(mFilePathA);//创建文件夹
			List<FileInfoBean> listFileInfoBean = FileUtil.getFileByRecordID(saveData.get("F_OLDFILE_CONTENT"),"singn",saveData.get("F_OLDFILE_CONTENT"));//从文档表数据库表中查询数据
			if(listFileInfoBean.size()>0){
				FileUtil.uploadFileToServer(mFilePathA, listFileInfoBean);//将文件保存到磁盘文件中
			}
		}
		//稿纸面签单 修改为附件
		if(!StringUtil.isBlank(formjpgfjId)){
			StringBuffer formjpgsql = new StringBuffer();
			formjpgsql.append(" update oa_fc_attach set djbh ='"+fjId+"' ");
			formjpgsql.append("   where djbh = '"+formjpgfjId+"' ");
			DBUtil pdbb = new DBUtil();
			pdbb.executeInsert(formjpgsql.toString(), con);
		}
		return true;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getNumberNo
	  * @param busi_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao#getNumberNo(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public String getNumberNo(String busi_id, Connection conn) throws Exception {
		String numberNo = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select number_title  from oa_word_number where busi_id = ?");
		
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, busi_id);
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			numberNo = pdb.getString(0, "number_title");
		}
		return numberNo;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 delFlow
	  * @param ins_id
	  * @param conn
	  * @return boolean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao#delFlow(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public boolean delFlowIns(String ins_id, Connection conn)  throws Exception {
		CallableDBUtil cdb = new CallableDBUtil();
		boolean flag= false;
		if (!StringUtil.nullOrBlank(ins_id)) {
			// 调用存储过程执行复制操作
			cdb.prepareCallable("{call deleteFlowInsInfo(?)}");
			cdb.setString(1, ins_id);
			cdb.executeCallable(conn);	
			flag= true;
		}
		return flag;
	}
	
	/** 
	  * <b>Summary: </b>
	  *     复写方法 delShakeFlow
	  * @param ins_code
	  * @param conn
	  * @return boolean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao#delShakeFlow(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public boolean delShakeFlow(String ins_code, Connection conn)
			throws Exception {
		// TODO 删除平台实例
		return true;
	}

	public boolean oaFlowDotermination(Map<String, String> flowData,Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		//更新流程实例表的状态
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_flow_instance");
		sql.append("  set status_code = ?");
		sql.append("  where ins_id = ?");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, flowData.get("status_code"));
		pdb.setString(2, flowData.get("ins_id"));
		pdb.addPreparedBatch();
		//更新环节任务表的执行人
		sql.delete(0, sql.length());
		sql.append("update oa_flow_inswfaction");
		sql.append("  set  action_handername = ?,  tache_end_time = ?");
		sql.append("  where action_handername is null and ins_id = ?");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, flowData.get("userName"));
		pdb.setTimestamp(2, new Timestamp(new Date().getTime()));
		pdb.setString(3, flowData.get("ins_id"));
		pdb.addPreparedBatch();
		//删除代办任务表
		sql.delete(0, sql.length());
		sql.append("delete oa_flow_actionuser u ");
		sql.append("       where u.activity = ?");
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, flowData.get("act_insid"));
		pdb.addPreparedBatch();
		
		pdb.executePreparedBatch(conn);
		return false;
	}
	
	/**
	 * <b>公文归档: </b>
	 * @param insId
	 * @param con
	 * @return
	 * @throws Exception 
	 * @see wordform.jsp-->iweboffice.js(19:doFlowSave())-->commonflowdo.js(getSaveData())-->ArchiveWordTextTag
	 * --->ArchiveServiceImpl(handler)--->FlowInstanceDataSaveDaoImpl(this method)
	 * getSaveData() contorl saveData
	 */
	public boolean sendToFileByInsId(String userId
			,String insId
			,Connection conn)
			throws Exception {
		//1.1:准备userBean,准备insBean
		UserCacheBean userBean = UserCache.getUserCacheBean(userId);
		String[][] insBean = DaoUtil.sqlToFieldsArray("select i.busi_id,i.ins_name,i.busitype_code from oa_flow_instance i where i.ins_id = '"+insId+"'");
		String busi_id = insBean[0][0];	//业务id
		String ins_name = insBean[0][1];	//实例名称
		ins_name = ins_name.replace("\n","");
		if(ins_name.length()>100){
			ins_name = ins_name.substring(0, 100);
		}
		String busitype_code = insBean[0][2];	//业务类型
		FlowInstanceDataSaveDao dao = new FlowInstanceDataSaveDaoImpl();
		//档案附件ID
		String fjId = StringUtil.getUUID();
		String f_file_no = dao.getNumberNo(busi_id, conn);
		String f_zihao_type_name = "";
		String f_wenhao = "";
		if(!StringUtil.nullOrBlank(f_file_no)){
			String[] serialnumberchar = StringUtil.getPropertiesChar("serialnumberchar",",");
			f_zihao_type_name = f_file_no.substring(0, f_file_no.indexOf(serialnumberchar[0]));
			f_wenhao = f_file_no.substring(f_file_no.lastIndexOf(serialnumberchar[1])+1, f_file_no.lastIndexOf("号"));
		}
		
		//1.2:获得 附件ID，和 正文ID
		String f_attach_id = "";
		String f_oldfile_content = "";
		
		//特检院OA 获取表单版的正文ID附件ID
		String arrays []=getFormFjZwId(insId, busitype_code,conn);
		f_oldfile_content = arrays[0];
		f_attach_id= arrays[1];
		/*//模板id
		String template_id = StringUtil.deNull(DaoUtil.sqlToField("select wb.template_id from OA_FLOW_BASEINFO wb where wb.busitype_code = '"+busitype_code+"'"));
		
		//业务表的附件code
		String[][] templateFjArray = DaoUtil.sqlToFieldsArray("select wt.table_id,wt.column_id from oa_word_textinput wt where wt.template_id =  '"+template_id+"' and wt.textinput_value_type = '3'");
		//业务表的正文code
		String zw_column = StringUtil.deNull(DaoUtil.sqlToField("select wt.column_id from oa_word_textinput wt where wt.template_id =  '"+template_id+"' and wt.textinput_value_type = '2'"));
		String bus_table_name = "";
		String fj_column = "";
		if(templateFjArray.length > 0){
			bus_table_name = templateFjArray[0][0];
			fj_column = templateFjArray[0][1];
		}
		//查询业务表主键
		String pk_code = StringUtil.deNull(DaoUtil.sqlToField("select table_pk from oa_md_table where table_code = '"+bus_table_name+"'"));
		if(!"".equals(bus_table_name) && !"".equals(fj_column) && !"".equals(pk_code)){
			f_attach_id = StringUtil.deNull(DaoUtil.sqlToField("select "+fj_column+" from "+bus_table_name+" where "+pk_code+" =  '"+busi_id+"'"));
		}
		if(!"".equals(bus_table_name) && !"".equals(fj_column) && !"".equals(pk_code)){
			f_oldfile_content = StringUtil.deNull(DaoUtil.sqlToField("select "+zw_column+" from "+bus_table_name+" where "+pk_code+" =  '"+busi_id+"'"));
		}*/
		
		//1.3:填充数据,set顺序按照db table列先后顺序
		FileDocBean obj = new FileDocBean();
		obj.setF_doc_id(StringUtil.getUUID());
		obj.setF_doc_name(ins_name);
		obj.setF_doc_fontsize(f_file_no);
		obj.setF_type_id("");//alter table OA_FILE_DOC modify F_TYPE_ID null;
		obj.setF_type_name("");//alter table OA_FILE_DOC modify F_TYPE_NAME null;
		obj.setF_doc_keywords("");//主题词
		obj.setF_doc_year(DateUtil.getCurrentYear());
		obj.setF_secrecy_id("4");
		obj.setF_secrecy_name("普通");
		obj.setF_org_id(userBean.getUnit_id());
		obj.setF_org_name(userBean.getUnit_name());
		obj.setF_dept_id(userBean.getOrg_id());
		obj.setF_dept_name(userBean.getOrg_name());
		obj.setF_doc_checkuser(userBean.getUnit_name());
		obj.setF_doc_blname(userBean.getUnit_name());
		obj.setF_file_formtime(DateUtil.getCurrentDate());
		obj.setF_file_quantity("1");
		obj.setF_type_remark("");
		obj.setF_user_id(userId);
		obj.setF_user_name(userBean.getUser_realname());
		obj.setF_creator_time(DateUtil.getCurrentDate());
		obj.setF_doc_content("");
		obj.setF_attach_id(fjId);
		obj.setF_doc_state(FileDocBean.STATE_DGD);
		obj.setF_doc_state_name(FileDocBean.STATE_DGD_NM);
		obj.setF_file_no("");//档号
		obj.setF_typeno("");//档案分类号
		obj.setF_doc_num("");//件号
		obj.setF_info_num("");//参见号
		obj.setF_doc_media("0");//介质类型
		obj.setF_doc_media_name("电子和实物");
		obj.setF_entity_type("1");//实物类型
		obj.setF_entity_type_name("文本");
		obj.setF_burn_user_id("");//刻录人
		obj.setF_burn_user_name("");
		obj.setF_file_num("1");//归档数量默认1
		obj.setF_doc_deadline("1");
		obj.setF_file_userid("");//归档人 归档到案卷的人
		obj.setF_file_username("");
		obj.setF_file_time("");
		obj.setF_info_type("1");
		obj.setF_info_type_name("文本");
		obj.setF_file_num_unit("1");
		obj.setF_file_num_unit_name("件");
		obj.setF_doc_deadline_name("永久");
		obj.setF_destroy_state("0");
		obj.setF_zihao_type_name(f_zihao_type_name);
		obj.setF_wenhao(f_wenhao);
		obj.setF_gongwen_id(insId);
		obj.setF_flow_state("0");//最重要的state
		obj.setF_rollback_idea("");
		obj.setF_submit_user_id(userId);
		obj.setF_submit_user_name(userBean.getUser_realname());
		obj.setF_submit_time("");
		
		//2.1:存 bean
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_file_doc ");
		sql.append("(                       ");
		sql.append("  f_doc_id              ");
		sql.append(", f_doc_name            ");
		sql.append(", f_doc_fontsize        ");
		sql.append(", f_type_id             ");
		sql.append(", f_type_name           ");
		sql.append(", f_doc_keywords        ");
		sql.append(", f_doc_year            ");
		sql.append(", f_secrecy_id          ");
		sql.append(", f_secrecy_name        ");
		sql.append(", f_org_id              ");
		sql.append(", f_org_name            ");
		sql.append(", f_dept_id             ");
		sql.append(", f_dept_name           ");
		sql.append(", f_doc_checkuser       ");
		sql.append(", f_doc_blname          ");
		sql.append(", f_file_formtime       ");
		sql.append(", f_file_quantity       ");
		sql.append(", f_type_remark         ");
		sql.append(", f_user_id             ");
		sql.append(", f_user_name           ");
		sql.append(", f_creator_time        ");
		sql.append(", f_doc_content         ");
		sql.append(", f_attach_id           ");
		sql.append(", f_doc_state           ");
		sql.append(", f_doc_state_name      ");
		sql.append(", f_file_no             ");
		sql.append(", f_typeno              ");
		sql.append(", f_doc_num             ");
		sql.append(", f_info_num            ");
		sql.append(", f_doc_media           ");
		sql.append(", f_doc_media_name      ");
		sql.append(", f_entity_type         ");
		sql.append(", f_entity_type_name    ");
		sql.append(", f_burn_user_id        ");
		sql.append(", f_burn_user_name      ");
		sql.append(", f_file_num            ");
		sql.append(", f_doc_deadline        ");
		sql.append(", f_file_userid         ");
		sql.append(", f_file_username       ");
		sql.append(", f_file_time           ");
		sql.append(", f_info_type           ");
		sql.append(", f_info_type_name      ");
		sql.append(", f_file_num_unit       ");
		sql.append(", f_file_num_unit_name  ");
		sql.append(", f_doc_deadline_name   ");
		sql.append(", f_destroy_state       ");
		sql.append(", f_zihao_type_name     ");
		sql.append(", f_wenhao              ");
		sql.append(", f_gongwen_id          ");
		sql.append(", f_flow_state          ");
		sql.append(", f_rollback_idea       ");
		sql.append(", f_submit_user_id      ");
		sql.append(", f_submit_user_name    ");
		sql.append(", f_submit_time         ");
		sql.append(")                       ");
		sql.append(" values                 ");
		sql.append(" ( '"+obj.getF_doc_id());
		sql.append("', '"+obj.getF_doc_name());
		sql.append("', '"+obj.getF_doc_fontsize());
		sql.append("', '"+obj.getF_type_id());
		sql.append("', '"+obj.getF_type_name());
		sql.append("', '"+obj.getF_doc_keywords());
		sql.append("', '"+obj.getF_doc_year());
		sql.append("', '"+obj.getF_secrecy_id());
		sql.append("', '"+obj.getF_secrecy_name());
		sql.append("', '"+obj.getF_org_id());
		sql.append("', '"+obj.getF_org_name());
		sql.append("', '"+obj.getF_dept_id());
		sql.append("', '"+obj.getF_dept_name());
		sql.append("', '"+obj.getF_doc_checkuser());
		sql.append("', '"+obj.getF_doc_blname());
		sql.append("', to_date('"+obj.getF_file_formtime());
		sql.append("','yyyy-MM-dd'), '"+obj.getF_file_quantity());
		sql.append("', '"+obj.getF_type_remark());
		sql.append("', '"+obj.getF_user_id());
		sql.append("', '"+obj.getF_user_name());
		sql.append("', to_date('"+obj.getF_creator_time());
		sql.append("','yyyy-MM-dd'), '"+obj.getF_doc_content());
		sql.append("', '"+obj.getF_attach_id());
		sql.append("', '"+obj.getF_doc_state());
		sql.append("', '"+obj.getF_doc_state_name());
		sql.append("', '"+obj.getF_file_no());
		sql.append("', '"+obj.getF_typeno());
		sql.append("', '"+obj.getF_doc_num());
		sql.append("', '"+obj.getF_info_num());
		sql.append("', '"+obj.getF_doc_media());
		sql.append("', '"+obj.getF_doc_media_name());
		sql.append("', '"+obj.getF_entity_type());
		sql.append("', '"+obj.getF_entity_type_name());
		sql.append("', '"+obj.getF_burn_user_id());
		sql.append("', '"+obj.getF_burn_user_name());
		sql.append("', '"+obj.getF_file_num());
		sql.append("', '"+obj.getF_doc_deadline());
		sql.append("', '"+obj.getF_file_userid());
		sql.append("', '"+obj.getF_file_username());
		sql.append("', '"+obj.getF_file_time());
		sql.append("', '"+obj.getF_info_type());
		sql.append("', '"+obj.getF_info_type_name());
		sql.append("', '"+obj.getF_file_num_unit());
		sql.append("', '"+obj.getF_file_num_unit_name());
		sql.append("', '"+obj.getF_doc_deadline_name());
		sql.append("', '"+obj.getF_destroy_state());
		sql.append("', '"+obj.getF_zihao_type_name());
		sql.append("', '"+obj.getF_wenhao());
		sql.append("', '"+obj.getF_gongwen_id());
		sql.append("', '"+obj.getF_flow_state());
		sql.append("', '"+obj.getF_rollback_idea());
		sql.append("', '"+obj.getF_submit_user_id());
		sql.append("', '"+obj.getF_submit_user_name());
		sql.append("', '"+obj.getF_submit_time());
		sql.append("')");
		DBUtil pdbb = new DBUtil();
		pdbb.executeInsert(sql.toString(), conn);
		
		//2.2存  正文 原文 面签单 ceb文件
		if(!StringUtil.nullOrBlank(f_oldfile_content)){
			FiletransferService ft = new FiletransferServiceImpl();
			
			String fileType = ".doc";
			String fileName = "";
			String djsn = "";
			String sqlYW = "select count(1) from oa_document_File  where RECORDID = '"+f_oldfile_content+"' and TEXT_TYPE   is null and dbms_lob.getLength(FILEBODY)>0";
			String sqlZW = "select count(1) from oa_document_File  where RECORDID = '"+f_oldfile_content+"' and TEXT_TYPE =  'text' and dbms_lob.getLength(FILEBODY)>0";
			String sqlMQ = "select count(1) from oa_document_File  where RECORDID = '"+f_oldfile_content+"' and TEXT_TYPE = 'singn' and dbms_lob.getLength(FILEBODY)>0";
			//String sqlCEB = "select t.ceb_content from oa_archive_dispatch t where t.ins_id = '"+insId+"'";
			if("1".equals(DaoUtil.sqlToField(sqlYW))){
				fileName = "原文"+fileType;
				djsn = StringUtil.getUUID();
				String sql_filebody = "select FILEBODY from oa_document_File  where RECORDID = '"+f_oldfile_content+"' and TEXT_TYPE   is null";
				String filepos = AttachmentConfigBean.getInstance().getMiddelUrlStr(null)+File.separator+djsn+fileType;
				
				this.addAttach(fileType, obj.getF_attach_id(), fileName, ft.getAttachId(), djsn, sql_filebody, filepos, userId,f_oldfile_content,null, conn);
			}
			if("1".equals(DaoUtil.sqlToField(sqlZW))){
				fileName = "正文"+fileType;
				djsn = StringUtil.getUUID();
				String sql_filebody = "select FILEBODY from oa_document_File  where RECORDID = '"+f_oldfile_content+"' and TEXT_TYPE =  'text'";
				String filepos = AttachmentConfigBean.getInstance().getMiddelUrlStr(null)+File.separator+djsn+fileType;
				
				this.addAttach(fileType,  obj.getF_attach_id(), fileName, ft.getAttachId(), djsn, sql_filebody, filepos, userId,f_oldfile_content,"text", conn);
			}
			if("1".equals(DaoUtil.sqlToField(sqlMQ))){
				fileName = "面签"+fileType;
				djsn = StringUtil.getUUID();
				String sql_filebody = "select FILEBODY from oa_document_File  where RECORDID = '"+f_oldfile_content+"' and TEXT_TYPE = 'singn'";
				String filepos = AttachmentConfigBean.getInstance().getMiddelUrlStr(null)+File.separator+djsn+fileType;
				
				this.addAttach(fileType,  obj.getF_attach_id(), fileName, ft.getAttachId(), djsn, sql_filebody, filepos, userId, f_oldfile_content,"singn", conn);
			}
			/*if(!StringUtil.nullOrBlank(DaoUtil.sqlToField(sqlCEB))){
				String cebType = ".ceb";
				fileName = "正文CEB文件"+cebType;
				djsn = StringUtil.getUUID();
				String filepos = AttachmentConfigBean.getInstance().getMiddelUrlStr(null)+File.separator+djsn+cebType;
				this.addAttachCeb(cebType,  obj.getF_attach_id(), fileName, ft.getAttachId(), djsn, sqlCEB, filepos, userId, f_oldfile_content,null, conn);
			}*/
		}
		
		//2.3存 附件
		if(f_attach_id!=null){
			String uploadMode = AttachmentConfigBean.getConfigMap().get("uploadMode").toString();
			
			PreparedDBUtil pdb = new PreparedDBUtil();
			
			sql = new StringBuffer();
			//参考  FileUploadServlet
			FiletransferService ft = new FiletransferServiceImpl();
			//1复制附件s
			sql.append("select djsn,rownum||':'||trim(filename) filename from oa_fc_attach where djbh = '"+f_attach_id+"'");
			pdb.executeSelect(sql.toString());
			if(pdb.size()>0){
				for (int i = 0; i < pdb.size(); i++) {
					//附件 逐个 复制
					String tmpDJSN = pdb.getString(i, "djsn");
					if(tmpDJSN!=null){
						sql = new StringBuffer();
						String djsn = StringUtil.getUUID();
						String filepos = AttachmentConfigBean.getInstance().getMiddelUrlStr(null)+File.separator+djsn;
						sql.append("insert into oa_fc_attach");
						sql.append("  (extend,");
						sql.append("   djbh,");
						sql.append("   dj_sn,");
						sql.append("   filename,");
						sql.append("   attachid,");
						sql.append("   bz,");
						sql.append("   djsn,");
						sql.append("   attachcontent,");
						sql.append("   filepos,");
						sql.append("   upload_mode,");
						sql.append("   cc_form_instanceid,");
						sql.append("   creator)");
						sql.append("  select extend,");
						sql.append("         '"+obj.getF_attach_id()+"',");//关联业务数据的code
						sql.append("         "+i+",");
						sql.append("         filename,");
						sql.append("         '"+ft.getAttachId()+"',");//递增的column
						sql.append("         bz,");
						sql.append("         '"+djsn+"',");//附件ID
						sql.append("         attachcontent,");
						sql.append("         '"+filepos+"'||trim(extend),");//url
						sql.append("         '"+uploadMode+"',");
						sql.append("         cc_form_instanceid,");
						sql.append("         '"+userId+"'");
						sql.append("    from oa_fc_attach");
						sql.append("   where djsn = '"+tmpDJSN+"'");
						pdb.executeInsert(sql.toString());
						
						if(AttachmentConfigBean.UPLOAD_MODE_COMPUTER.equals(uploadMode)
								||AttachmentConfigBean.UPLOAD_MODE_DB_AND_COMPUTER.equals(uploadMode)){
							String mFilePathA = AttachmentConfigBean.getBaseUrl()+AttachmentConfigBean.getInstance().getMiddelUrlStr(null);
							FileUtils.mkDirectory(mFilePathA);//创建文件夹
							
							String sqlTmp = "select filepos,trim(extend) extend from oa_fc_attach where djsn = '"+tmpDJSN+"'";
							pdb.preparedSelect(sqlTmp);
							pdb.executePrepared();
							if(pdb.size()>0) {
								String oldFilepos = pdb.getString(0, "filepos");
								String extend = pdb.getString(0, "extend");
								File oldFile = AttachmentConfigBean.getRealFile(oldFilepos);
								if(oldFile!=null){
									File newFile = new File(AttachmentConfigBean.getBaseUrl()+filepos+extend);
									Logger.getLogger(this.getClass()).error("寻找中newFile:"+newFile.getPath());
									newFile.createNewFile();
									
									FileOutputStream fos = new FileOutputStream(newFile);
									FileInputStream fis = new FileInputStream(oldFile);
									byte[] b = new byte[1024];
									int ii=-1;
									while((ii=fis.read(b))>-1){
										fos.write(b, 0, ii);
									}
									fis.close();
									fos.close();
									if(newFile.exists()){
										Logger.getLogger(this.getClass()).error("我存在");
									}else{
										Logger.getLogger(this.getClass()).error("我不存在");
									}
									//org.apache.commons.io.FileUtils.copyFile(oldFile, newFile);
								}else{
									Logger.getLogger(this.getClass()).error("找不到oldFile:"+oldFile.getPath());
								}
							}else{
								Logger.getLogger(this.getClass()).error("数据库中找不到tmpDJSN:"+tmpDJSN);
							}
							
						}
					}
				}
			}
			//稿纸面签单 修改为附件
			if(!StringUtil.isBlank(f_attach_id)){
				PreparedDBUtil pdb1 = new PreparedDBUtil();
				StringBuffer formjpgsql = new StringBuffer();
				formjpgsql.append(" delete from oa_fc_attach   ");
				formjpgsql.append("   where djbh = '"+f_attach_id+"' and creator='formTojpg' ");
				System.out.println(formjpgsql);
				pdb1.executeDelete(formjpgsql.toString());
			}
		}
		return true;
	}
	
	//特检院 根据流程实例ID和业务类型获取正文ID和附件ID
	private String[] getFormFjZwId(String insId,String busitype_code,Connection conn) throws Exception {
		
		String[] array = new String[2];
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select obj.t_zw_id,obj.t_fj_id from oa_flow_instance i,  ");
		//呈文签批
		if(busitype_code.equals("uuid-1103")){
			sql.append("  OA_FILE_QIANCHENG obj ");
		//接收公文
		} else if(busitype_code.equals("uuid-1102")){
			sql.append("  OA_FILE_SHOUWEN obj ");
		//发布公文
		} else if(busitype_code.equals("uuid-1101")){
			sql.append("  OA_FILE_FAWEN obj ");
		//党委发文
		} else if(busitype_code.equals("uuid-1104")){
			sql.append("  OA_FILE_FAWEN obj ");
		}
		
		sql.append(" where  obj.t_id = i.busi_id  ");
		sql.append("  and i.busitype_code = ? ");
		sql.append("  and i.ins_id = ? ");
		
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, busitype_code);
		pdb.setString(2, insId);
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			array[0] = pdb.getString(0, "t_zw_id");
			array[1] = pdb.getString(0, "t_fj_id");
		}
		return array;
	}
	
	
	private void addAttach(String fileType,
			String f_attach_id,
			String fileName,
			String attachId,
			String djsn,
			String sql_filebody,
			String filepos,
			String userId,
			String f_oldfile_content,
			String text_type,
			Connection conn) throws Exception{
		String uploadMode = AttachmentConfigBean.getConfigMap().get("uploadMode").toString();
		
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_fc_attach");
		sql.append("  (extend,");
		sql.append("   djbh,");
		sql.append("   dj_sn,");
		sql.append("   filename,");
		sql.append("   attachid,");
		sql.append("   bz,");
		sql.append("   djsn,");
		sql.append("   attachcontent,");
		sql.append("   filepos,");
		sql.append("   upload_mode,");
		sql.append("   cc_form_instanceid,");
		sql.append("   creator)");
		sql.append("values");
		sql.append("  ('"+fileType+"',");
		sql.append("   '"+f_attach_id+"',");
		sql.append("   null,");
		sql.append("   '"+fileName+"',");
		sql.append("   '"+attachId+"',");
		sql.append("   null,");
		sql.append("   '"+djsn+"',");
		sql.append("   ("+sql_filebody+"),");
		sql.append("   '"+filepos+"',");
		sql.append("   '"+uploadMode+"',");//文件存取模式：1-数据库、2-本地磁盘、3-FTP远程服务器
		sql.append("   null,");
		sql.append("   '"+userId+"')");
		DBUtil pdbb = new DBUtil();
		pdbb.executeInsert(sql.toString(), conn);
		
		if(AttachmentConfigBean.UPLOAD_MODE_COMPUTER.equals(uploadMode)
				||AttachmentConfigBean.UPLOAD_MODE_DB_AND_COMPUTER.equals(uploadMode)){
			String mFilePathA = AttachmentConfigBean.getBaseUrl()+AttachmentConfigBean.getInstance().getMiddelUrlStr(null);
			FileUtils.mkDirectory(mFilePathA);//创建文件夹
			
			String sql1 = "select filetype,filebody from oa_document_file where recordid=? and text_type =?";
			if(text_type == null){
				sql1 = "select filetype,filebody from oa_document_file where recordid=? and text_type is null";
			}
			PreparedDBUtil pdb = new PreparedDBUtil();
			List<FileInfoBean> fibList = new ArrayList<FileInfoBean>();
			pdb.preparedSelect(sql1);
			pdb.setString(1, f_oldfile_content);
			if(text_type != null){
				pdb.setString(2, text_type);
			}
			pdb.executePrepared();
			if(pdb.size()>0) {
				FileInfoBean fib = new FileInfoBean();
				fib.setFilename(djsn+pdb.getString(0, "filetype"));
			
				Blob blob = pdb.getBlob(0, "filebody");
				if (blob != null) {
					fib.setFileInput(pdb.getBlob(0, "filebody").getBinaryStream());
				}
				fibList.add(fib);
			}
			
			if(fibList.size()>0){
				FileUtil.uploadFileToServer(mFilePathA, fibList);//将文件保存到磁盘文件中
			}
		}
	}
	
	private void addAttachCeb(String fileType,
			String f_attach_id,
			String fileName,
			String attachId,
			String djsn,
			String sql_filebody,
			String filepos,
			String userId,
			String f_oldfile_content,
			String text_type,
			Connection conn) throws Exception{
		String uploadMode = AttachmentConfigBean.getConfigMap().get("uploadMode").toString();
		
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_fc_attach");
		sql.append("  (extend,");
		sql.append("   djbh,");
		sql.append("   dj_sn,");
		sql.append("   filename,");
		sql.append("   attachid,");
		sql.append("   bz,");
		sql.append("   djsn,");
		sql.append("   attachcontent,");
		sql.append("   filepos,");
		sql.append("   upload_mode,");
		sql.append("   cc_form_instanceid,");
		sql.append("   creator)");
		sql.append("values");
		sql.append("  ('"+fileType+"',");
		sql.append("   '"+f_attach_id+"',");
		sql.append("   null,");
		sql.append("   '"+fileName+"',");
		sql.append("   '"+attachId+"',");
		sql.append("   null,");
		sql.append("   '"+djsn+"',");
		sql.append("   ("+sql_filebody+"),");
		sql.append("   '"+filepos+"',");
		sql.append("   '"+uploadMode+"',");//文件存取模式：1-数据库、2-本地磁盘、3-FTP远程服务器
		sql.append("   null,");
		sql.append("   '"+userId+"')");
		DBUtil pdbb = new DBUtil();
		pdbb.executeInsert(sql.toString(), conn);
		
		if(AttachmentConfigBean.UPLOAD_MODE_COMPUTER.equals(uploadMode)
				||AttachmentConfigBean.UPLOAD_MODE_DB_AND_COMPUTER.equals(uploadMode)){
			String mFilePathA = AttachmentConfigBean.getBaseUrl()+AttachmentConfigBean.getInstance().getMiddelUrlStr(null);
			FileUtils.mkDirectory(mFilePathA);//创建文件夹
			
			PreparedDBUtil pdb = new PreparedDBUtil();
			List<FileInfoBean> fibList = new ArrayList<FileInfoBean>();
			pdb.preparedSelect(sql_filebody);
			pdb.executePrepared(conn);
			if(pdb.size()>0) {
				FileInfoBean fib = new FileInfoBean();
				fib.setFilename(djsn+fileType);
			
				Blob blob = pdb.getBlob(0, "ceb_content");
				if (blob != null) {
					fib.setFileInput(blob.getBinaryStream());
				}
				fibList.add(fib);
			}
			
			if(fibList.size()>0){
				FileUtil.uploadFileToServer(mFilePathA, fibList);//将文件保存到磁盘文件中
			}
		}
	}

	/**
	  * <b>Summary: 根据传阅性主键ID 修改记录的查看的状态未查看  “1” 已查看 </b>
	  *     复写方法 updateFlowActInsState
	  * @param circularize_id
	  * @param user_name
	  * @return
	  * @throws Exception 
	 */
	public boolean updateFlowActInsState(String circularize_id ,String user_id,String is_view) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_circularize_flow t");
		sql.append("  set  t.is_view = ? ");
		sql.append("  where t.circularize_id = ? ");
		sql.append("  and t.receive_userid = ? ");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, is_view);
		pdb.setString(2, circularize_id);
		pdb.setString(3, user_id);
		pdb.executePrepared();
		
		return true;
	}
}
