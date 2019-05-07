package com.chinacreator.commonworkflow;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.enhydra.shark.api.SharkTransaction;

import com.chinacreator.workflow.shark.SharkEngine;
import com.chinacreator.workflow.shark.SharkUtil;
import com.chinacreator.workflow.shark.procconfig.ProcessConfigManager;

public class WorkflowOprationWraper1 extends WorkflowOpertionWrapper {
	private static final Logger logger = Logger
	.getLogger(WorkflowOpertionWrapper.class);
	/**
	 * 表单中请求的统一处理入口（比如判断某按钮是否显示，根据活动实例id得到流程实例id等等）
	 * @author yaohui.luo
	 * @date 2008-12-16
	 * @param userName
	 * @param opType
	 * @param mgrName
	 * @param actInsId
	 * @param procInsId
	 * @param operType
	 * @param actDefId
	 * @return 
	 */ 
	public String queryForWorkflowEngine(String userName, String opType,
			String mgrName, String actInsId, String procInsId, String operType,
			String actDefId, String moduleId) throws Exception {
		
		logger.debug("调用WorkflowOperationWrap.queryForWorkflowEngine:::::::::::::::::::::::::::::::::");
		logger.debug("userName:"+userName);
		logger.debug("opType:"+opType);
		logger.debug("mgrName:"+mgrName);
		logger.debug("actInsId:"+actInsId);
		logger.debug("procInsId:"+procInsId);
		logger.debug("operType:"+operType);
		logger.debug("actDefId:"+actDefId);
		logger.debug("moduleId:"+moduleId);
		logger.debug("调用WorkflowOperationWrap.queryForWorkflowEngine:::::::::::::::::::::::::::::::::  end");
		
		SharkEngine shark = SharkEngine.getInstance();
		SharkTransaction t = null;
		String tempRet = "";
		String ret = "";

		String[] opTypeArr = opType.split(SharkEngine.AT_TOKEN);
		List opTypeList = Arrays.asList(opTypeArr);

		// 创建事务
		try {
			t = SharkUtil.createTransaction();
			shark.loginWorkflowServer(t, userName, "");
			Iterator ite = opTypeList.iterator();
			while (ite.hasNext()) {
				String opTypeTemp = (String) ite.next();
				if (opTypeTemp.equals("getActName")) {
					tempRet = "";
					tempRet = shark.getActNameByActInsId(t, actInsId)
							+ SharkEngine.AT_TOKEN;
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("getActObject")) {
					tempRet = "";
					tempRet = shark.getActObjectByActInsId(t, actInsId)
							+ SharkEngine.AT_TOKEN;
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("getProcInsId")) {
					tempRet = "";
					tempRet = shark.getProcInsIdByActInsId(t, actInsId)
							+ SharkEngine.AT_TOKEN;
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isShowActSelectText")) {
					tempRet = "";
					tempRet = shark.isShowActSelectText(t, actInsId, mgrName, moduleId);
					if (operType.equals("readonly")) {
						tempRet = "isShowActSelectText:false;isShowAndActSelectText:false";
					} else if (operType.equals("suspend")) {
						tempRet = "isShowActSelectText:false;isShowAndActSelectText:false";
					} else if (operType.equals("onuse")) { // add by yaohui.luo	2008-10-16
						tempRet = "isShowActSelectText:false;isShowAndActSelectText:false";
					}
					/* modified by zhou.luo 2008-08-19
					 * 未发送列表也应该按照以前的逻辑处理是否显示选择活动和与分支选执行人。
					 else if (operType.equals("nosend")) {
						ret = "isShowActSelectText:false;isShowAndActSelectText:false";
					}
					*/
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isShowUserText")) {
					tempRet = "";

					//add by minghua.guo 2010-07-12====================begin====================
					//读取外围扩展配置 中的动态选择执行人
					ProcessConfigManager processConfigManager = new ProcessConfigManager();
					String ret11 = "";
					if (actInsId != null && !"".equals(actInsId)) {
						ret11 = processConfigManager.isChooseUserFromActIns(moduleId, mgrName, actInsId);
					} else {
						ret11 = processConfigManager.isChooseUserFromFirstAct(moduleId, mgrName);
					}
					tempRet = ret11 + "";
					if("".equals(tempRet))
					//add by minghua.guo 2010-07-12====================end====================
						tempRet = shark.isShowUserText(t, actInsId, mgrName);

					if (operType.equals("readonly")) {
						tempRet = "false";
					} else if (operType.equals("suspend")) {
						tempRet = "false";
					} else if (operType.equals("onuse")) { // add by yaohui.luo	2008-10-16
						tempRet = "false";
					}
					/*modified by zhou.luo 2008-08-19
					 * 未发送列表也有可能需要选择执行人
					else if (operType.equals("nosend")) {
						ret = "false";
					}
					*/
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isShowBackButton")) {
					tempRet = "false";
					//modify by minghua.guo[2011-03-31] 流程中暂存要能显示回退
					if (operType.equals("daiban") || operType.equals("nosend")) {
						tempRet = "false";
						//modify by shuqi.liu 2013-11-18 暂存只是针对第一环节才调用流程接口。暂存要能显示回退？
						//tempRet = shark.isShowBackButton(t, actInsId, mgrName); 
					} else if (operType.equals("readonly")) {
						tempRet = "false";
					} else if (operType.equals("suspend")) {
						tempRet = "false";
					} else if (operType.equals("onuse")) { // add by yaohui.luo	2008-10-16
						tempRet = "false";
					}
					//modified by zhou.luo 2008-08-20 由于回退功能存在问题，暂时先把这个按钮屏蔽掉
					// ret = "false";
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isShowRecycle")) {
					tempRet = "";
					if (operType.equals("readonly")) {
						// ---------------------确认是否可以删掉
						procInsId = shark.getProcInsIdByActInsId(t, actInsId);
						// ---------------------
						tempRet = shark.isShowRecycle(t, procInsId, actInsId);
					} else {
						tempRet = "false";
					}
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isShowSuspend")) { // 待办列表才能挂起
					tempRet = "false";
					if (operType.equals("daiban")) {
						tempRet = "true";
					} else if (operType.equals("nosend")) {
						tempRet = "false";
					} else if (operType.equals("readonly")) {
						tempRet = "false";
					} else if (operType.equals("suspend")) {
						tempRet = "false";
					} else if (operType.equals("onuse")) { // add by yaohui.luo	2008-10-16
						tempRet = "false";
					}
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isShowResume")) { // 挂起列表页面里才显示收回按钮
					tempRet = "false";
					if (operType.equals("suspend")) {
						tempRet = "true";
					} else if (operType.equals("nosend")) {
						tempRet = "false";
					} else if (operType.equals("readonly")) {
						tempRet = "false";
					} else if (operType.equals("daiban")) {
						tempRet = "false";
					} else if (operType.equals("onuse")) { // add by yaohui.luo	2008-10-16
						tempRet = "false";
					}
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isShowCompleteWorkflow")) { // 完成活动
					tempRet = "false";
					if (operType.equals("suspend")) {
						tempRet = "false";
					} else if (operType.equals("nosend")) {
						tempRet = "true";
					} else if (operType.equals("readonly")) {
						tempRet = "false";
					} else if (operType.equals("daiban")) {
						tempRet = "true";
					} else if (operType.equals("onuse")) { // add by yaohui.luo	2008-10-16
						tempRet = "false";
					}
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isShowTempSaveForm")) { // 暂存
					tempRet = "";
					if (operType.equals("nosend")) {
						tempRet = "true";
					//add by minghua.guo 多次暂存支持
					} else if (operType.equals("daiban")) {
						tempRet = "true";
						//如果是会签，不允许暂存
						if(shark.isAllUsersExcuteActivity(t, actInsId)){
							tempRet = "false";
						}
					} else {		
						tempRet = "false";
					}
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isShowTerminate")) { // 中止流程
					tempRet = "";
					if (operType.equals("readonly")) {
						tempRet = "false";
					} else if (operType.equals("nosend")) {// modified by yaohui.luo 2009-4-9
						tempRet = "true";
					} else if (operType.equals("onuse")) { // add by yaohui.luo	2008-10-16
						tempRet = "false";
					} else {
						tempRet = "true";
					}
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isRoute")) { // 判断该活动是否为路由活动,返回1是，0不是
					tempRet = "";
					tempRet = shark.isRoute(mgrName, actDefId);
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("hasOnlyOnePerformer")) {
					tempRet = "";
					// 判断该活动是否只有一个参与者，是返回userName;userRealname,否则返回""
					tempRet = shark.hasOnlyOnePerformer(t, mgrName, actDefId,
							actInsId, moduleId);
					ret += tempRet + SharkEngine.AT_TOKEN;
				} else if (opTypeTemp.equals("isactivityonuse")) { // add by yaohui.luo	2008-10-14
					tempRet = "";
					tempRet = shark.isActivityOnUse(t, actInsId);
					ret += tempRet + SharkEngine.AT_TOKEN;
				}
			}

			if (!"".equals(ret)) {
				ret = ret.substring(0, ret.length() - 1);
			}
			logger.debug("调用结果：：：：：：");
			logger.debug(ret);
			logger.debug("调用结果：：：：：：end");
			SharkUtil.commitTransaction(t);
		} catch (Exception e) {
			logger
					.error(
							"exception in WorkflowOpertionWrapper.queryForWorkflowEngine:",
							e);
			try {
				// 回滚事务
				SharkUtil.rollbackTransaction(t);
			} catch (Exception e1) {
				logger
						.error(
								"exception in WorkflowOpertionWrapper.queryForWorkflowEngine rollbackTransaction:",
								e1);
				throw e1;
			}
			throw e;
		} finally {
			// 退出工作流
			shark.logoutWorkflowServer(t);
			try {
				// 释放事务
				SharkUtil.releaseTransaction(t);
			} catch (Exception e) {
				logger
						.error(
								"exception in WorkflowOpertionWrapper.queryForWorkflowEngine releaseTransaction:",
								e);
				throw e;
			}
		}

		return ret;
	}
}
