package com.chinacreator.xtbg.core.process.flowprocessing.servlet;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.agency.entity.FlowAgencyInfoBean;
import com.chinacreator.xtbg.core.common.tree.dao.impl.CommonTreeDaoImpl;
import com.chinacreator.xtbg.core.common.tree.entity.RcentlyUserBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowUtilDaoImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.service.FlowInstanceServiceIfc;
import com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc;
import com.chinacreator.xtbg.core.process.flowprocessing.service.impl.FlowInstanceServiceImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.service.impl.WorkFlowServiceImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.util.FlowStaticTHreadData;


/**
 * 
 *<p>Title:FlowServlet.java</p>
 *<p>Description:流程处理类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-20
 */
public class FlowServlet {
	
	private static final Log LOG = LogFactory.getLog(FlowServlet.class);

	/**
	* 
	*<b>Summary: </b>
	* FlowHaddle(前台流程数据的接收处理)
	* @param request
	* @param response
	*/
	public boolean flowHaddle(HttpServletRequest request, HttpServletResponse response,Connection conn) throws Exception{
		AccessControl control = AccessControl.getInstance();
		FlowUtilDao flowUtilDao = new FlowUtilDaoImpl();
		control.checkAccess(request, response);
		String userRealName = control.getUserName();
		String user_id = control.getUserID();
		String orgid = control.getChargeOrgId();//与orgId区分
		String orgName = control.getChargeOrgName();
		String operationType = request.getParameter("operationType");	//操作类型
		String flowDataJson = request.getParameter("flowData");//流程信息
		String xzspWorkflowType = request.getParameter("xzspWorkflowType");	//流程类型
		String isDynamicSelectUser = request.getParameter("isDynamicSelectUser");	//是否动态选择执行人
		String DYNAMICPERFORMER = request.getParameter("DYNAMICPERFORMER");	//活动执行人
		String flowTache = request.getParameter("flowTache");	//
		String nextActId = request.getParameter("nextActId");	//下一活动ID
		String nextActList = request.getParameter("nextActList");	//活动列表
		
		
		Map<Object, Object> flowInfoObj = new HashMap<Object, Object>();
		Map<String, String> flowData = new HashMap<String, String>();
		Map<String, String> flowCtrlInfo = new HashMap<String, String>();
		
		
		String bussinessID = StringUtil.deNull(request.getParameter("bussinessID"));
		if("".equals(bussinessID)){
			bussinessID = (String) request.getAttribute("bussinessID");//业务ID
		}
		String insName = (String) request.getAttribute("insName");

		flowDataJson = DataControlUtil.replaceStr(flowDataJson);
		flowData = (Map)JSONObject.parseObject(flowDataJson);// 根据字符串转换对象
		//如果是委托代办，那么在此处将执行人修改为本人，并且插入委托代办记录
		String is_agency = StringUtil.deNull(request.getParameter("is_agency"));
		if("1".equals(is_agency)){
			String entrust_user_name = StringUtil.deNull(request.getParameter("entrust_user_name"));
			if(!StringUtil.isBlank(entrust_user_name)){
				String agency_user_name = flowData.get("userName");
				flowData.put("userName", entrust_user_name);
				//TODO 在这里插入委托代办日志
				FlowAgencyInfoBean bean=new FlowAgencyInfoBean();
				bean.setId(StringUtil.getUUID());
				bean.setBusitype_code(flowData.get("busitype_code"));
				bean.setAgency_id(agency_user_name);
				bean.setEntrust_id(entrust_user_name);
				bean.setIns_id(flowData.get("ins_id"));
				bean.setActinsid(flowData.get("actInsId"));
				bean.setAction_name(flowData.get("action_name"));
				bean.setAction_id(flowData.get("action_id"));
				
				flowUtilDao.save(bean, conn);
			}
		}
		String ins_id = StringUtil.deNull(flowData.get("ins_id"));
		if(StringUtil.isBlank(ins_id)){
			ins_id = (String) request.getAttribute("ins_id");
			flowData.put("ins_id", ins_id);
		}
		
		String def_id = flowData.get("def_id");//流程定义ID
		flowInfoObj.put("flowData", flowData);
		flowInfoObj.put("orgid", orgid);
		flowInfoObj.put("orgName", orgName);
		flowInfoObj.put("userRealName", userRealName);
		flowInfoObj.put("busi_id", bussinessID);
		flowInfoObj.put("ins_name", insName);
		
		FlowInstanceServiceIfc flowInstanceServiceIfc = new FlowInstanceServiceImpl();
		WorkFlowServiceIfc workFlowServiceIfc = new WorkFlowServiceImpl();
		
		//获得流程静态参数
		FlowStaticTHreadData.setMgrName(flowData.get("mgrName"));
		FlowStaticTHreadData.setBuisinessId(ins_id);
		FlowStaticTHreadData.setModuleId(flowData.get("flow_id"));
		FlowStaticTHreadData.setDefId(def_id);//设置流程定义ID，新建流程时的流程版本，控制版本。
		FlowStaticTHreadData.setAction_form(flowData.get("action_form"));
		FlowStaticTHreadData.setDynamicperformer(DYNAMICPERFORMER);
		
		RcentlyUserBean rcentlyUserBean = null;
		if(!StringUtil.isBlank(DYNAMICPERFORMER) && !StringUtil.isBlank(nextActId) && !StringUtil.isBlank(user_id)) {
			
			String userIds = flowUtilDao.getUserIds(DYNAMICPERFORMER);
			rcentlyUserBean = new RcentlyUserBean();
			rcentlyUserBean.setRu_logn(nextActId);
			rcentlyUserBean.setRu_type("1");
			rcentlyUserBean.setRu_data(userIds);
			rcentlyUserBean.setUser_id(user_id);
			CommonTreeDaoImpl.insertRcentlyUser(rcentlyUserBean, conn);
		}
		
		if("dotemp".equals(operationType)){//暂存
			FlowStaticTHreadData.setStatus_code("04");
	    	flowInstanceServiceIfc.doTemp(flowInfoObj, conn);
	    } else if("dostartflow".equals(operationType)) {//受理	 
	    	//FlowStaticTHreadData.setStatus_code("07");
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType, isDynamicSelectUser, DYNAMICPERFORMER, def_id, nextActList, flowTache, nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
    		flowInstanceServiceIfc.doStartFlow(flowInfoObj, conn);
	    } else if("docompleteworkflow".equals(operationType)) {	//完成活动
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,def_id,nextActList,flowTache,nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
	    	flowInstanceServiceIfc.doCompleteAct(flowInfoObj,conn);
	    } else if("dofinishworkflow".equals(operationType)) {	//办结
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,def_id,nextActList,flowTache,nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
	    	flowInstanceServiceIfc.doFlowFinish(flowInfoObj,conn);
	    } else if("doterminationflow".equals(operationType)) {//终止流程
	    	flowInstanceServiceIfc.doTerminationFlow(flowInfoObj,conn);
	    } else if("doflowback".equals(operationType)) {//回退
	    	FlowStaticTHreadData.setStatus_code("06");
	    	String userName = flowData.get("userName");
	    	FlowStaticTHreadData.setBackflow_username(userName);
	    	flowInstanceServiceIfc.doFlowBack(flowInfoObj,conn);
	    }else if("doTemporarySave".equals(operationType)){//中间环节暂存
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,def_id,nextActList,flowTache,nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
	    	flowInstanceServiceIfc.doTemporarySave(flowInfoObj, conn);
	    }
		//删除流程静态参数
		FlowStaticTHreadData.removeAll();
	    return true;
	}
	
	/**
	 * 检查流程 并 自动办结流程
	 * @param flowData 从request中整理的流程数据
	 * @param request
	 * @param response
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean checkAndAutoFinishWorkflow(Map<String, String> flowData,HttpServletRequest request, HttpServletResponse response,Connection conn) throws Exception{
		boolean flag = true;
		//1:通过流程定义ID 与 活动定义id 从 "流程活动定义表","活动扩展表" 判断 下一个活动环节 是否是  需要自动办结的最后环节
		String def_id = flowData.get("def_id");
		String action_defid = request.getParameter("nextActId");
		FlowInstanceServiceIfc flowService = new FlowInstanceServiceImpl();
		if(flowService.checkWorkflowNeedAutoFinish(def_id, action_defid, conn)){
			LOG.info("\t\n自动办结:启动");
			flag = this.autoflowHaddle(flowData, request, response, conn);
			if(flag){
				LOG.info("\t\n自动办结:成功");
			}
		}
		return flag;
	}
	
	/**
	 * 流程自动跑过下一个环节
	 * @param request
	 * @param response
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	private boolean autoflowHaddle(Map<String, String> flowData,HttpServletRequest request, HttpServletResponse response,Connection conn) throws Exception{
		//1:整理数据
		boolean flag = false;
		String ins_id = flowData.get("ins_id");
		if(ins_id!=null){
			FlowInstanceServiceIfc flowService = new FlowInstanceServiceImpl();
			Map<String,String> actionMess = flowService.getLastActionMessInFlow(ins_id, conn);
			if(actionMess!=null){
				//整理 flowData
				String bussinessID = StringUtil.deNull(request.getParameter("bussinessID"));
				flowData.put("actInsId", actionMess.get("act_insid"));//修改活动实例ID like '40305_36802_dwxxbg_dwxxbg_wp1_dwxxbg_wp1_act3'
				flowData.put("action_id",actionMess.get("action_id"));//修改活动ID like '5155121e-78b8-43b1-87c5-83b782dd7a4d'
				flowData.put("ins_code",actionMess.get("ins_code"));//修改?? like '20131211065116281wordsfw'
				flowData.put("busi_id",bussinessID);
				flowData.put("status_code","02");//
				flowData.put("action_defid","");
				//整理 flowInfoObj
				String insName = (String) request.getAttribute("insName");
				AccessControl control = AccessControl.getInstance();
				control.checkAccess(request, response);
				String userRealName = control.getUserName();
				String orgid = control.getChargeOrgId();
				String orgName = control.getChargeOrgName();
				Map<Object, Object> flowInfoObj = new HashMap<Object, Object>();
				flowInfoObj.put("flowData", flowData);
				flowInfoObj.put("orgid", orgid);
				flowInfoObj.put("orgName", orgName);
				flowInfoObj.put("userRealName", userRealName);
				flowInfoObj.put("busi_id", bussinessID);
				flowInfoObj.put("ins_name", insName);
				//整理 getFlowCtrlInfo 方法所需参数
				String def_id = flowData.get("def_id");//流程定义ID
				String xzspWorkflowType = "";	//流程类型
				String isDynamicSelectUser = "";	//是否动态选择执行人
				String DYNAMICPERFORMER = null;	//活动执行人
				String flowTache = "";	//
				String nextActId = "";	//下一活动ID
				String nextActList = "";	//活动列表
				
				//2 办结
				//2.1 获得流程静态参数
				FlowStaticTHreadData.setMgrName(flowData.get("mgrName"));
				FlowStaticTHreadData.setBuisinessId(ins_id);
				FlowStaticTHreadData.setModuleId(flowData.get("flow_id"));
				FlowStaticTHreadData.setAction_form(flowData.get("action_form"));
				FlowStaticTHreadData.setDynamicperformer(DYNAMICPERFORMER);
				//2.2
				WorkFlowServiceIfc workFlowServiceIfc = new WorkFlowServiceImpl();
				Map<String, String> flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,def_id,nextActList,flowTache,nextActId);
		    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
		    	flowService.doFlowFinish(flowInfoObj,conn);
				//2.3 删除流程静态参数
				FlowStaticTHreadData.removeAll();
				flag = true;
			}else{
				LOG.info("\t\n自动办结:流程办结环节信息获取失败");
			}
		}else{
			LOG.info("\t\n自动办结:流程实例ID为空");
		}
		return flag;
	}
}
