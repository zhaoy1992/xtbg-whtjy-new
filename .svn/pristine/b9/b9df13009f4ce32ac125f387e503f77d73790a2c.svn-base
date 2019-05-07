package com.chinacreator.xtbg.core.process.flowprocessing.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.spi.impl.local.WorkflowNotTransactionImpl;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowInstanceDataSaveDaoImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc;
import com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc;
import com.frameworkset.common.poolman.PreparedDBUtil;


/**
 *<p>Title:FlowInstanceServiceImpl.java</p>
 *<p>Description:流程处理实现类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-1
 */
public class FlowInstanceServiceImpl implements FlowInstanceServiceIfc{


	private WorkFlowServiceIfc workFlowServiceIfc; // 流程处理 类
	
	private FlowInstanceDataSaveDao flowInstanceDataSaveDao;//流程数据保存类
	/**
	 * 在流程doTemp,doStartFlow,doCompleteAct,doFlowFinish 方法执行之后,
	 * 需要做的同样的事务,交给lastService来处理
	 */
	private LastWorkFlowServiceImpl lastService;

	/**
	* 构造函数
	*/
	public FlowInstanceServiceImpl() {
		workFlowServiceIfc = new WorkFlowServiceImpl();
		flowInstanceDataSaveDao = new FlowInstanceDataSaveDaoImpl();
		lastService = new LastWorkFlowServiceImpl();
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doTemp
	  * @param flowInfo
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc#doTemp(java.util.Map, java.sql.Connection)
	 */
	public void doTemp(Map<Object, Object> flowInfo, Connection conn) throws Exception {
		
		@SuppressWarnings("unchecked")
		Map<String, String> flowData = (Map<String, String>)flowInfo.get("flowData");
		//Map<String, String> flowCtrlInfo = (Map)flowInfo.get("flowCtrlInfo");
		String status_code = flowData.get("status_code");
		if(StringUtil.isBlank(status_code)) {
			flowInfo.put("status_code", "04");
		}
		String userName = flowData.get("userName");
		String mgrName = flowData.get("mgrName");
		String cc_form_instanceid = flowData.get("cc_form_instanceid");
		String action_form = flowData.get("action_form");
		
		String flow_id = flowData.get("flow_id");
		
		if (StringUtil.isBlank(status_code)) { // 新办件暂存
			flowInstanceDataSaveDao.saveForTempFromNew(flowInfo, conn);  //保存流程数据
			workFlowServiceIfc.doTemp(userName, mgrName, cc_form_instanceid, action_form, flow_id);  //流程暂存操作
		}  else if ("04".equals(status_code)) { // 反复暂存
			flowInstanceDataSaveDao.saveForRepeatedlyTemp(flowInfo, conn);
		} else if ("01".equals(status_code)) { // 追回后在代办列表暂存。
			flowInstanceDataSaveDao.saveForRepeatedlyTemp(flowInfo, conn);
		}
		lastService.handle(LastWorkFlowServiceImpl.HANDLE_TYPE_DOTEMP, flowInfo, conn);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doStartFlow
	  * @param flowInfo
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc#doStartFlow(java.util.Map, java.sql.Connection)
	 */
	public void doStartFlow(Map<Object, Object> flowInfo, Connection conn)
			throws Exception {
		
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		Map<String, String> flowCtrlInfo = (Map)flowInfo.get("flowCtrlInfo");
		String status_code = flowData.get("status_code");
		String userName = flowData.get("userName");
		String mgrName = flowData.get("mgrName");
		String actInsId = flowData.get("actInsId");
		String cc_form_instanceid = flowData.get("cc_form_instanceid");
		String action_form = flowData.get("action_form");
		String remoteAddr = flowData.get("remoteAddr");
		String flow_id = flowData.get("flow_id");
		String ins_id = flowData.get("ins_id");
		
		flowCtrlInfo.put("ins_id", ins_id);
		flowCtrlInfo.put("MODULE_ID", flow_id);
		if (StringUtil.isBlank(status_code)) { // 新启动流程
			flowInstanceDataSaveDao.saveForAcceptFromNew(flowInfo, conn);
			workFlowServiceIfc.start(userName, mgrName, flowCtrlInfo, cc_form_instanceid, action_form, remoteAddr);
		}  else if ("01".equals(status_code)) { // 从后续环节回退到受理的办件，或被其他流程调用产生第一个活动实例的办件
			flowCtrlInfo.put("MODULE_ID", flow_id);
			flowInstanceDataSaveDao.saveForCompleteAct(flowInfo, conn);
			flowCtrlInfo.put("FORMID", action_form);
			flowCtrlInfo.put("MODULE_ID", flow_id);
			flowCtrlInfo.put("ExtendWorkflowSettingParam", flow_id);
			workFlowServiceIfc.complete(flowCtrlInfo, userName, actInsId, cc_form_instanceid, action_form, "false", remoteAddr);
		} else if ("04".equals(status_code)) { // 暂存
			flowInstanceDataSaveDao.saveForAcceptFromTemp(flowInfo, conn);  //操作流程数据
			flowInfo.put("flowData", flowData);
			workFlowServiceIfc.complete(flowCtrlInfo, userName, actInsId, cc_form_instanceid, action_form, "false", remoteAddr);
		}
		lastService.handle(LastWorkFlowServiceImpl.HANDLE_TYPE_DOTEMP, flowInfo, conn);
	}
 
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doCompleteAct
	  * @param flowInfo
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc#doCompleteAct(java.util.Map, java.sql.Connection)
	 */
	public void doCompleteAct(Map<Object, Object> flowInfo, Connection conn)
			throws Exception {
		
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		Map<String, String> flowCtrlInfo = (Map)flowInfo.get("flowCtrlInfo");
		String userName = flowData.get("userName");
		String cc_form_instanceid = flowData.get("cc_form_instanceid");
		String actInsId = flowData.get("actInsId");
		String action_form = flowData.get("action_form");
		String remoteAddr = flowData.get("remoteAddr");
		String flow_id = flowData.get("flow_id");
		flowCtrlInfo.put("MODULE_ID", flow_id);
		flowCtrlInfo.put("FORMID", action_form);
		flowCtrlInfo.put("MODULE_ID", flow_id);
		flowCtrlInfo.put("ExtendWorkflowSettingParam", flow_id);
		
		flowInstanceDataSaveDao.saveForCompleteAct(flowInfo, conn);  //保存流程数据
		System.out.println("flowCtrlInfoflowCtrlInfo=="+flowCtrlInfo);
		System.out.println("userName=="+userName);
		System.out.println("actInsIdactInsId=="+actInsId);
		System.out.println("cc_form_instanceid=="+cc_form_instanceid);
		System.out.println("action_form=="+action_form);
		System.out.println("remoteAddr=="+remoteAddr);
		workFlowServiceIfc.complete(flowCtrlInfo, userName, actInsId, cc_form_instanceid, action_form, "false", remoteAddr);
		lastService.handle(LastWorkFlowServiceImpl.HANDLE_TYPE_DOTEMP, flowInfo, conn);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doFlowFinish
	  * @param flowInfo
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc#doFlowFinish(java.util.Map, java.sql.Connection)
	 */
	public void doFlowFinish(Map<Object, Object> flowInfo, Connection conn)
			throws Exception {
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		Map<String, String> flowCtrlInfo = (Map)flowInfo.get("flowCtrlInfo");
		String userName = flowData.get("userName");
		String cc_form_instanceid = flowData.get("cc_form_instanceid");
		String actInsId = flowData.get("actInsId");
		String action_form = flowData.get("action_form");
		String remoteAddr = flowData.get("remoteAddr");
		String flow_id = flowData.get("flow_id");

		flowCtrlInfo.put("MODULE_ID", flow_id);
		flowInstanceDataSaveDao.saveForGeneralFinish(flowInfo, conn);
		workFlowServiceIfc.complete(flowCtrlInfo, userName, actInsId, cc_form_instanceid, action_form, "false", remoteAddr);
		
		lastService.handle(LastWorkFlowServiceImpl.HANDLE_TYPE_DOTEMP, flowInfo, conn);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doTerminationFlow
	  * @param flowInfo
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc#doTerminationFlow(java.util.Map, java.sql.Connection)
	 */
	public void doTerminationFlow(Map<Object, Object> flowInfo, Connection conn)
			throws Exception {
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		String userName = flowData.get("userName");
		String procId = flowData.get("procId");
		String remoteAddr = flowData.get("remoteAddr");
		flowInstanceDataSaveDao.saveForTerminationFlow(flowInfo, conn);  
		workFlowServiceIfc.terminate(userName, procId, remoteAddr);
		
		lastService.handle(LastWorkFlowServiceImpl.HANDLE_TYPE_DOTEMP, flowInfo, conn);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doFlowBack
	  * @param flowInfo
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc#doFlowBack(java.util.Map, java.sql.Connection)
	 */
	public void doFlowBack(Map<Object, Object> flowInfo, Connection conn)
			throws Exception {
	
		@SuppressWarnings("unchecked")
		Map<String, String> flowData = (Map<String, String>)flowInfo.get("flowData");
		//Map<String, String> flowCtrlInfo = (Map)flowInfo.get("flowCtrlInfo");
		String userName = flowData.get("userName");
		String cc_form_instanceid = flowData.get("cc_form_instanceid");
		String remoteAddr = flowData.get("remoteAddr");
		String actInsId = flowData.get("actInsId");
		String action_form = flowData.get("action_form");
		flowInstanceDataSaveDao.saveForCompleteAct(flowInfo, conn);  //保存流程数据
		workFlowServiceIfc.back(userName, actInsId, cc_form_instanceid, action_form, remoteAddr);
		
		lastService.handle(LastWorkFlowServiceImpl.HANDLE_TYPE_DOTEMP, flowInfo, conn);
	}
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getNextActUsers(查询下一环节所有执行人)
	* @param flowInfo
	* @param con
	* @return
	* @throws Exception
	 */
	public String getNextActUsers(Map<Object, Object> flowInfo, Connection con) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		
		String actNextUsers = ""; //环节所对应的用户
		StringBuffer sql = null;
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		Map<String, String> flowCtrlInfo = (Map)flowInfo.get("flowCtrlInfo");
		
		String NEXT_ACTS = flowCtrlInfo.get("NEXT_ACT");//环节定义IDS
		String[] actDefIdArray = null;
		
		String  def_id = flowData.get("def_id"); //流程定义主键(流程实例id)
		String dynamicperformer = flowCtrlInfo.get("DYNAMICPERFORMER");//是否为动态选择执行人 不为空是动态选择执行人
		
		if(StringUtil.isBlank(dynamicperformer) ){
			
			if(!StringUtil.isBlank(NEXT_ACTS)) {//如果环节定义ID不为空
				actDefIdArray = NEXT_ACTS.split(",");
				sql = new StringBuffer();
				//查询下一环节执行人
				sql.append("select wm_concat(u.user_name) as user_name");
				sql.append("  from oa_flow_wfactuser u "); 
				sql.append(" where u.action_id = (select t.action_id ");
				sql.append("                        from oa_flow_wfaction t ");
				sql.append("                       where t.action_defid = ? ");
				sql.append("                         and t.def_id = ?) ");
				for (int i = 0; i < actDefIdArray.length; i++) {
					db.preparedSelect(sql.toString());
					db.setString(1, actDefIdArray[i]);
					db.setString(2, def_id);
					db.executePrepared(con);
					if(db.size() > 0) {
						actNextUsers += db.getString(0, "user_name") + "#" + actDefIdArray[i] + "__" ;
					}
				}
			}
		} else {
			actNextUsers = dynamicperformer + "#" + NEXT_ACTS + "__";
		}
		actNextUsers = actNextUsers.substring(0, actNextUsers.length() - 2);
		return actNextUsers;
	}
	
	
	/**
	 * 
	*<b>Summary: </b>
	* insertAgency(请用一句话描述这个方法的作用 1.当是动态选择执行人的时候 2.当不是动态选择执行人的时候)
	* @param flowInfo 流程信息
	* @param con
	* @return
	* @throws Exception
	 */
	public String insertAgency(Map<Object, Object> flowInfo, Connection con) throws Exception {
		String actNextUsersAndActDefId = getNextActUsers(flowInfo, con);
		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		String ins_id = flowData.get("ins_id").toString();
		PreparedDBUtil pd = new PreparedDBUtil();
		StringBuffer sql = null;
		String[] actNextUsersArray = null;
		String agency_name = "";//代理人的登陆名称
		String[] agency_nameArray = null;  
		String agency_username = "";//代理人的中文名称
		String[] agency_usernameArray = null;
		String entrust_id = "";//委托人登陆名称
		String entrust_name = "";//委托人中文名称
		String actDefId = "";//环节定义
		String[] actDefIdsandUsersArray = null;
		String actDefIdandUser = "";
		String actNextUsers= "";
		if(!StringUtil.isBlank(actNextUsersAndActDefId)) {
			actDefIdsandUsersArray = actNextUsersAndActDefId.split("__");
			for (int l = 0; l < actDefIdsandUsersArray.length; l++) {
				actDefIdandUser = actDefIdsandUsersArray[l];
				if(!StringUtil.isBlank(actDefIdandUser)) {
					actNextUsers = actDefIdandUser.split("#")[0];
					actDefId = actDefIdandUser.split("#")[1];
					if(!StringUtil.isBlank(actNextUsers)) {
						actNextUsersArray = actNextUsers.split(",");
						
						for (int i = 0; i < actNextUsersArray.length; i++ ) {
							sql = new StringBuffer();
							//通过下一环节执行人查询执行人的代理人
							sql.append("select a.agency_name, a.agency_username, a.entrust_id, a.entrust_name ");
							sql.append("  from to_oa_agency a ");
							sql.append(" where a.entrust_id = ? ");
							sql.append(" and (  a.start_time < sysdate  and  a.end_time >sysdate) and a.flow_id = ? ");
							pd.preparedSelect(sql.toString());
							pd.setString(1,actNextUsersArray[i]);
							pd.setString(2,flowData.get("busitype_code").trim());
							pd.executePrepared(con);
							
							for (int j = 0; j < pd.size(); j++) {
								sql = new StringBuffer();
								agency_name = pd.getString(0, "agency_name");
								agency_username = pd.getString(0, "agency_username");
								entrust_id = pd.getString(0, "entrust_id");
								entrust_name = pd.getString(0, "entrust_name");
								
								//插入代理实例
								sql.append("insert into TA_OA_AGENCY_FLOW af ");
								sql.append("  (af.id, af.agency_id, af.agency_name, af.entrust_id, entrust_name, ins_id, act_defid) ");
								sql.append("values ");
								sql.append("  (SEQ_TA_FLOW.Nextval, ?, ?, ?, ?, ?, ?) ");
								
								if(!StringUtil.isBlank(agency_name)) {
									actNextUsers += "," +  agency_name;
									agency_nameArray = agency_name.split(",");
									agency_usernameArray = agency_username.split(",");
									for (int k = 0; k < agency_nameArray.length; k++) {
										 pd.preparedInsert(sql.toString());
										 pd.setString(1, agency_nameArray[k]);
										 pd.setString(2, agency_usernameArray[k]);
										 pd.setString(3, entrust_id);
										 pd.setString(4, entrust_name);
										 pd.setString(5, ins_id);
										 pd.setString(6, actDefId);
										 pd.executePrepared(con);
									}
									
								}
							}
						}
					}
				}
				
				
			}
		}
		return actNextUsers;
  
	}
	
	
	/**
	 * 
	*<b>Summary: </b>
	* updateAgency(代理人处理后修改代理实例数据)
	* @param userName 用户登陆名称
	* @param act_defId 环节定义ID
	* @param ins_id 流程实例ID
	* @param act_ins_id 流程实例ID
	* @param con
	* @throws Exception
	 */
	public void updateAgency(String userName, String act_defId, String ins_id, String act_ins_id, Connection con) throws Exception{
		PreparedDBUtil pd = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update TA_OA_AGENCY_FLOW a ");
		sql.append("   set a.ACT_INS_ID = ?, HANDERTIME = sysdate ");
		sql.append(" where a.id = (select id ");
		sql.append("                 from TA_OA_AGENCY_FLOW af ");
		sql.append("                where af.ins_id = ? ");
		sql.append("                  and af.act_defid = ? ");
		sql.append("                  and af.AGENCY_ID = ?) ");
		pd.preparedUpdate(sql.toString());
		pd.setString(1, act_ins_id);
		pd.setString(2, ins_id);
		pd.setString(3, act_defId);
		pd.setString(4, userName);
		pd.executePrepared(con);
		
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doTemporarySave
	  * @param flowInfo
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc#doTemporarySave(java.util.Map)
	 */
	public void doTemporarySave(Map<Object, Object> flowInfo, Connection conn) throws Exception {

		Map<String, String> flowData = (Map)flowInfo.get("flowData");
		Map<String, String> flowCtrlInfo = (Map)flowInfo.get("flowCtrlInfo");
		String flow_id = flowData.get("flow_id");
		flowCtrlInfo.put("MODULE_ID", flow_id);
		flowInstanceDataSaveDao.saveForCompleteAct(flowInfo, conn);  //保存流程数据
		
		lastService.handle(LastWorkFlowServiceImpl.HANDLE_TYPE_DOTEMPORARYSAVE, flowInfo, conn);
		
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 startWorkflowNotCompleteFirstAct
	  * @param flowInfo
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc#startWorkflowNotCompleteFirstAct(java.util.Map)
	 */
	@SuppressWarnings("unchecked")
	public void startWorkflowNotCompleteFirstAct(Map<Object, Object> flowInfo, Connection conn ) throws Exception {
		Map<String, String> flowData = (Map<String, String>)flowInfo.get("flowData");
		Map<String, String> flowCtrlInfo = (Map<String, String>)flowInfo.get("flowCtrlInfo");
		String userName = flowData.get("userName");
		String mgrName = flowData.get("mgrName");
		String cc_form_instanceid = flowData.get("cc_form_instanceid");
		String action_form = flowData.get("action_form");
		String remoteAddr = flowData.get("remoteAddr");
		String flow_id = flowData.get("flow_id");

		flowCtrlInfo.put("MODULE_ID", flow_id);
		flowInstanceDataSaveDao.saveForAcceptFromNew(flowInfo, conn);  //保存流程数据
		flowInfo.put("flowData", flowData);
		new WorkflowNotTransactionImpl().startWorkflowNotCompleteFirstActWrapperWithRet(userName, mgrName, cc_form_instanceid,action_form,remoteAddr, flow_id);
	}
	
	/**
	 * 检查某流程在某环节是否需要启动自动办结
	 * @param def_id 流程定义ID
	 * @param action_defid 流程活动定义id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	@Override
	public boolean checkWorkflowNeedAutoFinish(String def_id,
			String action_defid, Connection conn) throws Exception {
		boolean flag = false;
		PreparedDBUtil pd = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT IS_AUTO_COMPLETE");
		sql.append("  FROM OA_FLOW_WFACTIONEXT OFWE");
		sql.append(" WHERE OFWE.ACTION_ID IN (SELECT ACTION_ID");
		sql.append("                            FROM OA_FLOW_WFACTION OFW");
		sql.append("                           WHERE OFW.ACTION_DEFID = ?");
		sql.append("                             AND OFW.DEF_ID = ?)");
		pd.preparedSelect(sql.toString());
		pd.setString(1, action_defid);
		pd.setString(2, def_id);
		pd.executePrepared(conn);
		if(pd.size()==1&&"Y".equals(pd.getString(0, "IS_AUTO_COMPLETE"))){
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 
	 */
	@Override
	public Map<String, String> getLastActionMessInFlow(String ins_id,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT *");
		sql.append("  FROM OA_FLOW_INSWFACTION");
		sql.append(" WHERE INS_ID = ?");
		sql.append("   AND ACTION_HANDERNAME IS NULL");
		sql.append("   AND TACHE_END_TIME IS NULL");
		sql.append("   AND IS_VALID = 'Y'");
		PreparedDBUtil pd = new PreparedDBUtil();
		pd.preparedSelect(sql.toString());
		pd.setString(1, ins_id);
		pd.executePrepared(conn);
		if(pd.size()==1){
			Map<String, String> map = new HashMap<String, String>();
			map.put("flow_action_id",pd.getString(0,"flow_action_id"));
			map.put("ins_id",pd.getString(0,"ins_id"));
			map.put("action_id",pd.getString(0,"action_id"));
			map.put("action_name",pd.getString(0,"action_name"));
			map.put("action_handerid",pd.getString(0,"action_handerid"));
			map.put("action_handername",pd.getString(0,"action_handername"));
			map.put("tache_begin_time",pd.getString(0,"tache_begin_time"));
			map.put("tache_end_time",pd.getString(0,"tache_end_time"));
			map.put("tache_limit",pd.getString(0,"tache_limit"));
			map.put("limit_type",pd.getString(0,"limit_type"));
			map.put("spend_limit",pd.getString(0,"spend_limit"));
			map.put("is_overdue",pd.getString(0,"is_overdue"));
			map.put("is_valid",pd.getString(0,"is_valid"));
			map.put("remark1",pd.getString(0,"remark1"));
			map.put("remark2",pd.getString(0,"remark2"));
			map.put("act_insid",pd.getString(0,"act_insid"));
			map.put("act_defid",pd.getString(0,"act_defid"));
			map.put("processid",pd.getString(0,"processid"));
			map.put("state",pd.getString(0,"state"));
			map.put("action_form",pd.getString(0,"action_form"));
			map.put("insert_order",pd.getString(0,"insert_order"));
			return map;
		}else{
			//如果出现多条最新的数据 则不是办结环节
		}
		return null;
	}
	
	
	
}
