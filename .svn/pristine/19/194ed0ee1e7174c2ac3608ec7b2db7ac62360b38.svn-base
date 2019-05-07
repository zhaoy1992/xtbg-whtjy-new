package com.chinacreator.xtbg.core.process.flowprocessing.service.impl;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.commonworkflow.WorkflowOprationWraper1;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowUtilDaoImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionExtBean;
import com.chinacreator.xtbg.core.process.flowprocessing.service.InitFlowExtServiceIfc;
import com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc;
import com.chinacreator.xtbg.core.process.flowprocessing.util.Constant;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowActionTreeConfigBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactUser;

/**
 *<p>Title:InitFlowExtServiceImpl.java</p>
 *<p>Description:初始化控制器实现扩展实现类</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-3
 */
public class InitFlowExtServiceImpl implements InitFlowExtServiceIfc {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowInfoActNextActList
	  * @param map
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.InitFlowExtServiceIfc#getFlowInfoActNextActList(java.util.Map)
	 */
	public String getFlowInfoActNextActList(Map<String, String> map)
			throws Exception {
		String userName = map.get("userName");//当前登陆用户
		String opType = map.get("opType");//流程行为标识
		String mgrName = map.get("mgrName");//流程包#流程版本#流程ID package_id#flow_version#process_id	
		String action_defid = map.get("action_defid");//环节定义ID
		if(action_defid == null) {
			action_defid = "";
		}
		String actInsId = map.get("actInsId");//环节实例ID
		String procInsId = map.get("procInsId");//流程实例ID
		if(procInsId == null) {
			procInsId = "";
		}
		String operType = map.get("operType");//操作类型
		if(operType == null) {
			operType = "";
		}
		
		String flwoinfo = "";
		if(!StringUtil.isBlank(mgrName)) {
			
			WorkFlowServiceIfc workFlowServiceIfc = new WorkFlowServiceImpl();
			WorkflowOprationWraper1 workflowOperation1 = new WorkflowOprationWraper1();
			//workflowOperation workflowOperation1 = new WorkflowOperation();
			
			String isShowActSelectText = workFlowServiceIfc.getIsShowActSelectText(actInsId, mgrName);  //是否动态选择活动
			//是否有与分支
			String isShowAndActSelectText = Constant.IS_SHOWANDACTSELECTTEXT + Constant.COLON + workFlowServiceIfc.getIsAndTypeSplit(Constant.NULL, mgrName) + Constant.SEMICOLON;
			
			flwoinfo = workflowOperation1.queryForWorkflowEngine(userName, opType, mgrName, actInsId, procInsId, operType, action_defid, Constant.NULL);
			
			flwoinfo = isShowActSelectText + flwoinfo.substring(flwoinfo.indexOf(Constant.SEMICOLON));
			flwoinfo = flwoinfo.replace(Constant.IS_SHOWANDACTSELECTTEXT, Constant.IS_SHOWANCACTSELECTUSERTEXT);
			flwoinfo = flwoinfo.substring(0, flwoinfo.indexOf(Constant.SEMICOLON) + 1) + isShowAndActSelectText + flwoinfo.substring(flwoinfo.indexOf(Constant.SEMICOLON) + 1);
			
			Map temp = workFlowServiceIfc.getNextActList(userName, actInsId, mgrName);
			StringBuffer nextActList = new StringBuffer();
			Set<String> set = temp.keySet();
			set = new TreeSet<String>(set);
			for (String key : set) {
				nextActList.append(key).append(Constant.COMMA);
			}
			flwoinfo = flwoinfo + Constant.AREACOLON + nextActList.toString();
			
		}
		return flwoinfo;


	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActAliasOrder
	  * @param flowInfo
	  * @param flowId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.InitFlowExtServiceIfc#getActAliasOrder(java.lang.String, java.lang.String)
	 */
	public String getActAliasOrder(String flowInfo, String flowId) throws Exception{
		FlowUtilDao flowUtilDao = new FlowUtilDaoImpl();
		StringBuffer actionAliasAndOrderStr =  new StringBuffer();
		String actAliasOrderStr = "";
		if(flowInfo != null) {
			String flowDatas[] = flowInfo.split(Constant.AREACOLON);
			String actListStr = flowDatas[flowDatas.length - 1];
			String temActList[] = actListStr.split(",");
			for(int i = 0; i < temActList.length; i++) {
				if(StringUtil.isBlank(temActList[i])){
		            continue;
		        }
				if(temActList[i] != null) {
					String actionAlias = flowUtilDao.getActionAlias(flowId, temActList[i].split(Constant.WELLCOLON)[0]);
					if(StringUtil.isBlank(actionAlias)){
						actionAlias = temActList[i].split(Constant.WELLCOLON)[1];
					}
					actionAliasAndOrderStr.append(actionAlias).append(Constant.WELLCOLON); 
					String actionOrder = flowUtilDao.getActionOrder(flowId, temActList[i].split(Constant.WELLCOLON)[0]);
					actionAliasAndOrderStr.append(actionOrder+Constant.COMMA);
				}
				
			}
		}
		if(actionAliasAndOrderStr != null) {
			actAliasOrderStr = actionAliasAndOrderStr.toString();
		}
		return actAliasOrderStr;
		
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getActUserList
	  * @param flowInfo
	  * @param def_id
	  * @param ins_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.InitFlowExtServiceIfc#getActUserList(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public String getActUserList(String flowInfo, String def_id, String ins_id) throws Exception {

		FlowUtilDao flowUtilDao = new FlowUtilDaoImpl();
		StringBuffer actUsersStr =  new StringBuffer();
		List<FlowWfactUser> flowWfactUserList = null;
		String autoassignment = ""; //前置活动执行人
		String isshowuser = Constant.STATUS_N;
		if(flowInfo != null) {
			String flowDatas[] = flowInfo.split(Constant.AREACOLON);
			String actListStr = flowDatas[flowDatas.length - 1];
			String temActList[] = actListStr.split(",");
			for(int i = 0; i < temActList.length; i++) {
				if(StringUtil.isBlank(temActList[i])){
		            continue;
		        }
				if(temActList[i] != null) {
					//TODO 这里获取下环节的是否动态选择，用户列表信息
					String actDefId =  temActList[i].split(Constant.WELLCOLON)[0];
					String action_id = flowUtilDao.getAction_Id(def_id, actDefId);
					FlowWfactionExtBean flowWfactionExtBean = flowUtilDao.getFlowActionExtBean(action_id);//是否手动选人员
					autoassignment = flowWfactionExtBean.getAutoassignment();
					if(!StringUtil.isBlank(autoassignment)) {
						flowWfactUserList = flowUtilDao.getActAutoassignmentUser(action_id, ins_id, autoassignment);
						if(flowWfactUserList.size() <= 0) {
							isshowuser = Constant.STATUS_Y;
							flowWfactUserList = flowUtilDao.getActOrderUser(action_id);//用户列表
						}
					} else {
						flowWfactUserList = flowUtilDao.getActOrderUser(action_id);//用户列表
					}
					FlowActionTreeConfigBean flowActionTreeConfigBean = flowUtilDao.getActionTreeConfig(action_id); //获取树配置
					
					StringBuffer userInfoStr  = new StringBuffer(actDefId+Constant.WELLCOLON);
					if(flowWfactUserList.size()>0){//插入user_id 
						StringBuffer userStr = new StringBuffer("");
						for(FlowWfactUser flowWfactUser:flowWfactUserList){
							if("1".equals(flowWfactUser.getActuser_type())){
								userStr.append(flowWfactUser.getUser_id());
								userStr.append(Constant.SEPARATOR);
								userStr.append(flowWfactUser.getUser_name());
								userStr.append(Constant.SEPARATOR);
								userStr.append(flowWfactUser.getUser_realname());
								userStr.append(Constant.COMMA);
							}
						}	
						if(!StringUtil.isBlank(userStr.toString())){
							userStr = userStr.delete(userStr.length()-1, userStr.length());
							userInfoStr.append(userStr);
						}
					}
					userInfoStr.append(Constant.WELLCOLON);
					
					if(!StringUtil.isBlank(autoassignment) && Constant.STATUS_N.equals(isshowuser)) {//如果是前置活动执行人并该环节已处理过
							userInfoStr.append("N");
					} else if(flowWfactionExtBean!=null){//插入是否选中人员
						userInfoStr.append(flowWfactionExtBean.getIsshowuser());
					}else{
						userInfoStr.append("N");
					}
					userInfoStr.append(Constant.WELLCOLON);
					if(flowActionTreeConfigBean != null){
						userInfoStr.append(flowActionTreeConfigBean.getTree_role()).append(Constant.WELLCOLON).append(flowActionTreeConfigBean.getTree_nodetype());
					}else{//如果为空，插入默认的树配置（配置人员，复选框）
						userInfoStr.append("configPeople").append(Constant.WELLCOLON).append("checkbox");
					}
					userInfoStr.append(Constant.AREACOLON);
					actUsersStr.append(userInfoStr);
				}
			}
			actUsersStr.deleteCharAt(actUsersStr.length()-1);
		}
		return actUsersStr.toString();
	}

}
