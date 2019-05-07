package com.chinacreator.xtbg.core.process.processconfig.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.tree.entity.FlowActionTreeConfigBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao;
import com.chinacreator.xtbg.core.process.processconfig.entity.ActColStatusBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.ActTextStatusBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowActionFormDef;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowDefInfoBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowFormBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactUser;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionExtBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionInfoBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.OaWordTemplate;
import com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc;

/**
 * 
 *<p>
 * Title:FlowInfoConfigServiceImpl.java
 * </p>
 *<p>
 * Description:流程配置服务类
 * </p>
 *<p>
 * Copyright:Copyright (c) 2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 黄艺平
 *@version 1.0 2013-4-22
 */
public class FlowInfoConfigServiceImpl implements FlowInfoConfigServiceIfc {
	public static final Logger LOG = Logger
			.getLogger(FlowInfoConfigServiceImpl.class.getName());

	/**
	 * 
	 * <b>Summary: </b> 复写方法 saveFlowConfigInfo
	 * 
	 * @param paramjosn
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#saveFlowConfigInfo(java.lang.String)
	 */
	public String saveFlowConfigInfo(String paramjosn) throws Exception {
		FlowInfoBean flowInfoBean = new FlowInfoBean();
		String resultStr = "";
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowInfoBean = (FlowInfoBean) JSONObject.parseObject(paramjosn,FlowInfoBean.class);
		}
		try {

			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
			if("2".equals(flowInfoBean.getFlow_tyle())){//如果是WORD类型，这里特殊处理(都是一个页面)
				flowInfoBean.setFrom_path("/ccapp/oa/archive/wordform.jsp");
			}
			if (StringUtil.nullOrBlank(flowInfoBean.getFlow_id())) {
				resultStr = dao.addFlowBaseInfo(flowInfoBean);
			} else {
				resultStr = flowInfoBean.getFlow_id();
				dao.updateFlowBaseInfo(flowInfoBean);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return "";
		}
		return resultStr;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 saveFlowDefInfo
	 * 
	 * @param paramjosn
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#saveFlowDefInfo(java.lang.String)
	 */
	public void saveFlowDefInfo(String paramjosn) throws Exception {
		FlowDefInfoBean flowDefInfoBean = new FlowDefInfoBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowDefInfoBean = (FlowDefInfoBean) JSONObject.parseObject(
					paramjosn, FlowDefInfoBean.class);
		}
		try {
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
					.getApplicationContext().getBean("flowInfoDaoImpl");
			dao.addFlowDefInfo(flowDefInfoBean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);

			throw e;
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 saveFlowWfactionInfo
	 * 
	 * @param paramjosn
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#saveFlowWfactionInfo(java.lang.String)
	 */
	public void saveFlowWfactionInfo(String paramjosn) throws Exception {
		FlowWfactionInfoBean flowWfactionInfoBean = new FlowWfactionInfoBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowWfactionInfoBean = (FlowWfactionInfoBean) JSONObject
					.parseObject(paramjosn, FlowWfactionInfoBean.class);
		}
		try {
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
					.getApplicationContext().getBean("flowInfoDaoImpl");
			dao.updateFlowWfactionInfo(flowWfactionInfoBean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 saveFlowWfactionExtInfo
	 * 
	 * @param paramjosn
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#saveFlowWfactionExtInfo(java.lang.String)
	 */
	public void saveFlowWfactionExtInfo(String paramjosn) throws Exception {
		FlowWfactionExtBean flowWfactionExtBean = new FlowWfactionExtBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowWfactionExtBean = (FlowWfactionExtBean) JSONObject.parseObject(
					paramjosn, FlowWfactionExtBean.class);
		}
		try {
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
					.getApplicationContext().getBean("flowInfoDaoImpl");
			if (!dao.isExsitFlowWfactionExtInfo(flowWfactionExtBean
					.getAction_id())) {
				dao.addFlowWfactionExtInfo(flowWfactionExtBean);
			} else {
				dao.updateFlowWfactionExtInfo(flowWfactionExtBean);
			}

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 saveFlowWfactionFormDefInfo
	 * 
	 * @param paramjosn
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#saveFlowWfactionFormDefInfo(java.lang.String)
	 */
	public void saveFlowWfactionFormDefInfo(String paramjosn) throws Exception {
		FlowActionFormDef flowActionFormDefBean = new FlowActionFormDef();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowActionFormDefBean = (FlowActionFormDef) JSONObject.parseObject(
					paramjosn, FlowActionFormDef.class);
		}
		try {

			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
					.getApplicationContext().getBean("flowInfoDaoImpl");
			if (!dao.isExsitFlowFormDefInfo(flowActionFormDefBean.getForm_id())) {
				dao.addFlowWfactionFormDef(flowActionFormDefBean);
			} else {
				dao.updateFlowWfactionFormDef(flowActionFormDefBean);
			}

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 saveFlowWfacuserInfo
	 * 
	 * @param paramjosn
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#saveFlowWfacuserInfo(java.lang.String)
	 */
	public void saveFlowWfacuserInfo(String paramjosn) throws Exception {
		FlowWfactUser flowWfactUserBean = new FlowWfactUser();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowWfactUserBean = (FlowWfactUser) JSONObject.parseObject(
					paramjosn, FlowWfactUser.class);
		}
		try {
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
					.getApplicationContext().getBean("flowInfoDaoImpl");
			dao.addFlowWfactionUserInfo(flowWfactUserBean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 isExistFlow
	 * 
	 * @param packageId
	 * @param processId
	 * @param ecId
	 * @param flowVersion
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#isExistFlow(java.lang.String,
	 *      java.lang.String, java.lang.String, java.lang.String)
	 */
	public boolean isExistFlow(String packageId, String processId, String ecId,
			String flowVersion) throws Exception {
		FlowInfoDao flowInfoDao = (FlowInfoDao) LoadSpringContext
				.getApplicationContext().getBean("flowInfoDaoImpl");
		try {
			return flowInfoDao.isExistFlow(packageId, processId, ecId,
					flowVersion);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return true;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 saveFlowInfo
	 * 
	 * @param packageId
	 * @param flowDefId
	 * @param flowId
	 * @param flowVersion
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#saveFlowInfo(java.lang.String,
	 *      java.lang.String, java.lang.String, java.lang.String)
	 */
	public String saveFlowInfo(String packageId, String flowDefId,
			String flowId, String flowVersion,String flowdesc) {
		
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FlowInfoDao flowInfoDao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
			flowInfoDao.stopFlowInfo(flowId,conn);// 流程设置为无效

			FlowDefInfoBean flowDefInfoBean = new FlowDefInfoBean();
			flowDefInfoBean.setFlow_id(flowId);
			flowDefInfoBean.setPackage_id(packageId);
			flowDefInfoBean.setFlow_version(flowVersion);
			flowDefInfoBean.setFlow_defid(flowDefId);
			flowDefInfoBean.setFlow_desc(flowdesc);
			flowDefInfoBean.setIs_valid("Y");
			String new_def_id = flowInfoDao.addFlowDefInfo(flowDefInfoBean,conn);
			/* 新增环节信息 */
			boolean hasActFlag = flowInfoDao.hasAct(new_def_id,conn);

			if (!hasActFlag) {
				flowInfoDao.insertWFAction(new_def_id, packageId, flowDefId,flowVersion,conn);
				//flowInfoDao.insertActionInit(new_def_id,conn);//流程环节配置信息初始化
			}
			DbManager.closeTransactionConnection(conn, true);
			return new_def_id;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			return "";
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 userFlowInfo
	 * 
	 * @param flowId
	 * @param flowDefId
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#userFlowInfo(java.lang.String,
	 *      java.lang.String)
	 */
	public void userFlowInfo(String flowId, String flowDefId){
		
		Connection conn = null;
		try {
			FlowInfoDao flowInfoDao = (FlowInfoDao) LoadSpringContext
			.getApplicationContext().getBean("flowInfoDaoImpl");
			flowInfoDao.stopFlowInfo(flowId,conn);// 流程设置为无效
			flowInfoDao.startupFlowInfo(flowDefId,conn);
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 updateWorkflowInfo
	 * 
	 * @param oldFlowId
	 * @param newFlowId
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#updateWorkflowInfo(java.lang.String,
	 *      java.lang.String)
	 */
	// FIXME lei.zhang
	public boolean updateWorkflowInfo(String oldDefId, String newDefId,
			String oldTableId) {
       Connection conn = null;
       try{
    	   conn = DbManager.getInstance().getTransactionConnection();
    	   FlowInfoDao flowInfoDao = (FlowInfoDao) LoadSpringContext
			.getApplicationContext().getBean("flowInfoDaoImpl");
    	   //执行复制继承操作
    	   flowInfoDao.copyConfigInfo(newDefId, oldDefId, oldTableId, conn);
    	   //提交事务，并关闭连接
    	   DbManager.closeTransactionConnection(conn, true);    
    	   return true;
       }catch(Exception e){
    	   //回滚事务，并关闭连接
    	   DbManager.closeTransactionConnection(conn, false);    
    	   LOG.error(e.getMessage(),e);
    	   return false;
       }
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getOldFlowId
	 * 
	 * @param packageId
	 * @param flowDefId
	 * @param flowId
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#getOldFlowId(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	public String getOldFlowId(String packageId, String flowDefId, String flowId)
			throws Exception {
		FlowInfoDao flowInfoDao = (FlowInfoDao) LoadSpringContext
				.getApplicationContext().getBean("flowInfoDaoImpl");
		return flowInfoDao.getOldFlowId(packageId, flowDefId, flowId);
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 delFlowInfoByEcId
	 * 
	 * @param ecId
	 * @param flowId
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#delFlowInfoByEcId(java.lang.String,
	 *      java.lang.String)
	 */
	public boolean delFlowInfoByEcId(String ecId, String flowId)
			throws Exception {		
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FlowInfoDao flowInfoDao = (FlowInfoDao) LoadSpringContext
			.getApplicationContext().getBean("flowInfoDaoImpl");
			List<String> flowActList = flowInfoDao.getFlowAct(flowId,conn);
			StringBuffer actionIds = new StringBuffer();
			if (flowActList.size() > 0) {
				for (int j = 0; j < flowActList.size(); j++) {
					// 流程 环节编号
					actionIds.append("'").append(flowActList.get(j))
							.append("'");
					if (flowActList.size() - 1 > j) {
						actionIds.append(",");
					}

				}
			}

			// 删除流程信息
			flowInfoDao.deleteFlowDefInfoById(flowId,conn);

			// 删除流程对应环节 信息
			flowInfoDao.deleteFlowWfactionInfoById(flowId,conn);

			if (!StringUtil.isBlank(actionIds.toString())) {

				// 删除流程对应的环节对应的用户信息

				// flowInfoDao.delWfactionUser(actionIds.toString());

				// 删除环节扩展信息
				// flowInfoDao.delWfactionExt(actionIds.toString());

				// 删除流程对应的环节对应的表单信息
				// flowInfoDao.delActFormConfig(actionIds.toString());

			}

			DbManager.closeTransactionConnection(conn, true);

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.closeTransactionConnection(conn, false);
			return false;
		}
		return true;
	}

	/**
	 *<b>Summary: </b> saveActColStatusForm(保存环节字段状态表)
	 * 
	 * @param paramjosn
	 * @throws Exception
	 */
	public void saveActColStatusForm(String paramjosn) throws Exception {
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			Connection conn = null;
			try {
				conn = DbManager.getInstance().getTransactionConnection();
				List<ActColStatusBean> list = (List<ActColStatusBean>) JSONObject
						.parseArray(paramjosn, ActColStatusBean.class);
				FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
						.getApplicationContext().getBean("flowInfoDaoImpl");
				for (ActColStatusBean model : list) {
					if (StringUtil.nullOrBlank(model.getId())) {// 增加
						dao.insertActColStatusForm(model);
					} else {
						dao.updateActColStatusForm(model);
					}
					
					if("T_ZW_ID".equals(model.getColumn_code())){//如果字段为正文
						Integer count = dao.selectFlowByActionId(model.getAction_id());
						if(count>0){
							dao.updateTextEdite(model.getAction_id(), model.getReadonly(), conn);
						}else{
							ActTextStatusBean bean = new ActTextStatusBean();
							bean.setAction_id(model.getAction_id());
							bean.setIs_readonly(model.getReadonly());
							dao.insertActTextStatusForm(bean);
						}
					}
				}
				DbManager.closeTransactionConnection(conn, true);
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
				DbManager.closeTransactionConnection(conn, false);
			}
		}
	}

	/**
	 * <b>Summary: </b> 复写方法 saveActTextStatusForm
	 * 
	 * @param paramjosn
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#saveActTextStatusForm(java.lang.String)
	 */
	public void saveActTextStatusForm(String paramjosn) throws Exception {
		ActTextStatusBean model = new ActTextStatusBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			model = (ActTextStatusBean) JSONObject.parseObject(paramjosn,
					ActTextStatusBean.class);
		}

		try {
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
					.getApplicationContext().getBean("flowInfoDaoImpl");
			if (StringUtil.nullOrBlank(model.getId())) {// 增加
				dao.insertActTextStatusForm(model);
			} else {
				dao.updateActTextStatusForm(model);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	};

	/**
	 * <b>Summary: </b> 复写方法 saveActTableBusinessMapping
	 * 
	 * @param table_id
	 * @param busitype_code
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#saveActTableBusinessMapping(java.lang.String,
	 *      java.lang.String)
	 */
	public void saveTableBusinessMapping(String table_id, String busitype_code)
			throws Exception {
		try {
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
					.getApplicationContext().getBean("flowInfoDaoImpl");
			dao.insertTableBusinessMapping(table_id, busitype_code);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 queryListFlowForm
	 * 
	 * @return
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#queryListFlowForm()
	 */
	@Override
	public List<FlowFormBean> queryListFlowForm() {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
					.getApplicationContext().getBean("flowInfoDaoImpl");
			return dao.queryListFlowForm(conn);
		} catch (Exception e) {
			LOG.error("查询表单类型出现异常", e);
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowBaseInfoById
	 * 
	 * @param flowid
	 * @return
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#findFlowBaseInfoById(java.lang.String)
	 */
	@Override
	public FlowInfoBean findFlowBaseInfoById(String flowid) {
		FlowInfoBean bean = new FlowInfoBean();
		try {
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
					.getApplicationContext().getBean("flowInfoDaoImpl");
			return dao.findFlowBaseInfoById(flowid);
		} catch (Exception e) {
			LOG.error("查询流程基本信息出现异常", e);
			return bean;
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findFlowWfactionInfoList
	  * @param flowId
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#findFlowWfactionInfoList(java.lang.String)
	 */
	@Override
	public String findFlowWfactionInfoList(String flowId) {
		try {
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext
					.getApplicationContext().getBean("flowInfoDaoImpl");
            //查询得到id列表，并返回
			return JSONArray.toJSON(
					dao.findFlowWfactionInfoList(flowId)).toString();
		} catch (Exception e) {
			LOG.error("查询流程id列表出现异常", e);
			// 返回空的数组
			return "[]";
		}
	}
	
	/**
	 * 
	 *<b>Summary: 根据流程id删除流程信息</b> deleteFlowBaseInfoById(删除流程基本信息)
	 * 
	 * @param flowids
	 * @return
	 * @throws SQLException
	 */
	public boolean deleteFlowBaseInfoById(String flowIds){
		Connection conn = null;		
		try {
			conn =DbManager.getInstance().getConnection();
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");

            //删除业务数据元关系表数据
			dao.deleteBusinessMappingByFlowId(flowIds, conn);
			
			//删除流程数据
			dao.deleteFlowBaseInfoById(flowIds, conn);
			
			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {			
			LOG.error("删除流程出现异常", e);
			DbManager.closeTransactionConnection(conn, false);
			// 返回空的数组
			return false;
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法  
	  * @param flowActionTreeConfigBean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.pub.flowinfoconif.service.FlowInfoConfigServiceIfc#saveFlowWfactionTreeConfig(com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowActionTreeConfigBean)
	 */
	public void saveFlowWfactionTreeConfig(
			FlowActionTreeConfigBean flowActionTreeConfigBean) throws Exception {
			Connection conn = null;	
		try {
			conn =DbManager.getInstance().getConnection();
			FlowInfoDao dao = (FlowInfoDao)LoadSpringContext
			.getApplicationContext().getBean("flowInfoDaoImpl");
			if(!dao.isExsitFlowActTreeConfig(flowActionTreeConfigBean.getAction_id())){
				flowActionTreeConfigBean.setConfig_id(StringUtil.getUUID());
				((BaseDao)dao).insert(flowActionTreeConfigBean,conn);
			}else{
				((BaseDao)dao).update(flowActionTreeConfigBean,conn);
			}
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			LOG.error(e.getMessage());
			DbManager.closeTransactionConnection(conn, false);
			throw e;
		}
		
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryListWordTemp
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#queryListWordTemp()
	 */
	@Override
	public List<OaWordTemplate> queryListWordTemp() {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
			return dao.queryListWordTemp(conn);
		} catch (Exception e) {
			LOG.error("查询WORD模板出现异常", e);
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowBaseInfoList
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#getFlowBaseInfoList()
	 */
	@Override
	public List<FlowInfoBean> getFlowBaseInfoList(FlowInfoBean flowInfoBean) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
			flowInfoBean.setIs_valid("1");
			return dao.getFlowBaseInfoList(flowInfoBean, conn);
		} catch (Exception e) {
			LOG.error("查询流程基本信息列表出现异常", e);
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getSingnConfig
	  * @param temp_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#getSingnConfig(java.lang.String) 
	  */
	@Override
	public String getSingnConfig(String temp_id) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
			return dao.querySingnConfig(temp_id,conn);
		} catch (Exception e) {
			LOG.error("查询WORD模板会签配置出错！", e);
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 ActionInit
	  * @param new_def_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#ActionInit(java.lang.String) 
	  */
	@Override
	public boolean ActionInit(String new_def_id) {
		boolean flag = true;
		FlowInfoDao flowInfoDao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
		try {
			flowInfoDao.insertActionInit(new_def_id,null);
		} catch (Exception e) {
			LOG.error("新增流程环节初始化错误！", e);
			flag = false;
		}//流程环节配置信息初始化
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isFlowInstance
	  * @param new_def_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#isFlowInstance(java.lang.String)
	 */
	public boolean isFlowInstance(String busitype_code) {
		Connection conn = null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getConnection();
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
			dao.querySingnConfig(busitype_code,conn);
			flag=true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 copycopyFlowInfo
	 * @param procMap
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#copycopyFlowInfo(java.util.Map)
	 */
	@Override
	public String copyFlowInfo(Map<Integer, String> procMap)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
			return dao.copyFlowInfo(procMap,conn);
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeTransactionConnection(conn, true);
		}
		return "";
	}

	@Override
	public Map<String, String> copyFlowDefInfo(Map<Integer, String> procMap)
			throws Exception {
		Connection conn = null;
		Map<String, String> mess= new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
			mess = dao.copyFlowDefInfo(procMap,conn);
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			mess.put("flag", "false");
		} finally {
			DbManager.closeTransactionConnection(conn, true);
		}
		return mess;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteFlowDefInfo
	  * @param def_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc#deleteFlowDefInfo(java.lang.String)
	 */
	public boolean deleteFlowDefInfo(String def_id) throws Exception {
		Connection conn = null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getConnection();
			FlowInfoDao dao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
			dao.deleteFlowDefInfo(def_id, conn);
			flag=true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}

	@Override
	public boolean checkFlowDefHasIns(String def_id) throws Exception {
		FlowInfoDao dao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
		boolean flag = dao.isExistFlowIns(def_id);
		return flag;
	}
}
