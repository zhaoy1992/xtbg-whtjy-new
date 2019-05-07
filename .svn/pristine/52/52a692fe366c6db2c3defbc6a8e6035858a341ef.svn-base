package com.chinacreator.xtbg.pub.flowinfoconif.service.impl;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao;
import com.chinacreator.xtbg.pub.flowinfoconif.dao.imploracle.FlowInfoDaoImpl;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowActionFormDef;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowActionTreeConfigBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowDefInfoBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowInfoBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactUser;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactionExtBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactionInfoBean;
import com.chinacreator.xtbg.pub.flowinfoconif.service.FlowInfoConfigServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.orm.transaction.TransactionManager;

public class FlowInfoConfigServiceImpl implements FlowInfoConfigServiceIfc {
	public static final Logger logger = Logger.getLogger(FlowInfoConfigServiceImpl.class.getName());
	
	@Override
	public String saveFlowConfigInfo(String paramjosn) throws Exception{
		FlowInfoBean flowInfoBean  = new FlowInfoBean();
		String resultStr = "";
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowInfoBean = (FlowInfoBean) JSONObject.parseObject(paramjosn, FlowInfoBean.class);
		} 
		try {
			FlowInfoDao dao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
			if(StringUtil.nullOrBlank(flowInfoBean.getFlow_id())){
				resultStr = dao.addFlowBaseInfo(flowInfoBean);
			}else{
				resultStr = flowInfoBean.getFlow_id();
				dao.updateFlowBaseInfo(flowInfoBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			logger.info(e.getMessage());
			
			throw e;
		}
		return resultStr;
	}
	
	
	
	@Override
	public void saveFlowDefInfo(String paramjosn) throws Exception {
		FlowDefInfoBean flowDefInfoBean  = new FlowDefInfoBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowDefInfoBean = (FlowDefInfoBean) JSONObject.parseObject(paramjosn, FlowDefInfoBean.class);
		} 
		try {
			FlowInfoDao dao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
			dao.addFlowDefInfo(flowDefInfoBean);
		} catch (Exception e) {
			e.printStackTrace();
			
			logger.info(e.getMessage());
			
			throw e;
		}
		
	}



	@Override
	public void saveFlowWfactionInfo(String paramjosn) throws Exception {
		FlowWfactionInfoBean flowWfactionInfoBean  = new FlowWfactionInfoBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowWfactionInfoBean = (FlowWfactionInfoBean) JSONObject.parseObject(paramjosn, FlowWfactionInfoBean.class);
		} 
		try {
			FlowInfoDao dao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
			dao.updateFlowWfactionInfo(flowWfactionInfoBean);
		} catch (Exception e) {
			e.printStackTrace();
			
			logger.info(e.getMessage());
			
			throw e;
		}
	}



	@Override
	public void saveFlowWfactionExtInfo(String paramjosn) throws Exception {
		FlowWfactionExtBean flowWfactionExtBean  = new FlowWfactionExtBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowWfactionExtBean = (FlowWfactionExtBean) JSONObject.parseObject(paramjosn, FlowWfactionExtBean.class);
		} 
		try {
			FlowInfoDao dao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
			if(!dao.isExsitFlowWfactionExtInfo(flowWfactionExtBean.getAction_id())){
				dao.addFlowWfactionExtInfo(flowWfactionExtBean);
			}else{
				dao.updateFlowWfactionExtInfo(flowWfactionExtBean);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			throw e;
		}
	}



	@Override
	public void saveFlowWfactionFormDefInfo(String paramjosn) throws Exception {
		FlowActionFormDef flowActionFormDefBean  = new FlowActionFormDef();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowActionFormDefBean = (FlowActionFormDef) JSONObject.parseObject(paramjosn, FlowActionFormDef.class);
		} 
		try {
			
			FlowInfoDao dao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
			if(!dao.isExsitFlowFormDefInfo(flowActionFormDefBean.getForm_id())){
				dao.addFlowWfactionFormDef(flowActionFormDefBean);
			}else{
				dao.updateFlowWfactionFormDef(flowActionFormDefBean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			throw e;
		}
	}



	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveFlowWfactionTreeConfig
	  * @param flowActionTreeConfigBean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.pub.flowinfoconif.service.FlowInfoConfigServiceIfc#saveFlowWfactionTreeConfig(com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowActionTreeConfigBean)
	 */
	public void saveFlowWfactionTreeConfig(
			FlowActionTreeConfigBean flowActionTreeConfigBean) throws Exception {
		try {
			FlowInfoDao dao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
			if(!dao.isExsitFlowActTreeConfig(flowActionTreeConfigBean.getAction_id())){
				flowActionTreeConfigBean.setConfig_id(DaoUtil.findBySequencsName("SEQ_FLOW_TREECONFIG"));
				((BaseDao)dao).insert(flowActionTreeConfigBean);
			}else{
				((BaseDao)dao).update(flowActionTreeConfigBean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			throw e;
		}
		
	}



	@Override
	public void saveFlowWfacuserInfo(String paramjosn) throws Exception {
		FlowWfactUser flowWfactUserBean  = new FlowWfactUser();
		TransactionManager tm = new TransactionManager();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowWfactUserBean = (FlowWfactUser) JSONObject.parseObject(paramjosn, FlowWfactUser.class);
		} 
		try {
			tm.begin();
			FlowInfoDao dao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
			dao.deleteFlowWfactionUserInfoByActionId(flowWfactUserBean.getAction_id());
			dao.addFlowWfactionUserInfo(flowWfactUserBean);
			tm.commit();
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			tm.rollback();
			throw e;
		}
	}



	/**
	 * @Description:是否存在流程
	 * @return
	 * @throws Exception
	 */
	public boolean isExistFlow(String packageId, String processId, String ecId,
			String flowVersion) throws Exception {
		FlowInfoDao flowInfoDao = new FlowInfoDaoImpl();
		try {
			return flowInfoDao.isExistFlow(packageId, processId, ecId,
					flowVersion);
		} catch (Exception e) {
			logger.error(e.toString());
			throw new Exception(e.toString());
		}
	}

	/**
	 * @Description:保存在绑定流程
	 * @param packageId
	 * @param processId
	 * @param ecId
	 * @param flowVersion
	 * @throws Exception
	 */
	public String saveFlowInfo(String packageId, String flowDefId, String flowId,
			String flowVersion) throws Exception {
		FlowInfoDao flowInfoDao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
		TransactionManager tm = new TransactionManager();
		try {
			tm.begin();
			flowInfoDao.stopFlowInfo(flowId);// 流程设置为无效
			
			FlowDefInfoBean flowDefInfoBean = new FlowDefInfoBean();
			flowDefInfoBean.setFlow_id(flowId);
			flowDefInfoBean.setPackage_id(packageId);
			flowDefInfoBean.setFlow_version(flowVersion);
			flowDefInfoBean.setFlow_defid(flowDefId);
			flowDefInfoBean.setIs_valid("Y");
			String new_def_id = flowInfoDao.addFlowDefInfo(flowDefInfoBean);
			/* 新增环节信息 */
			boolean hasActFlag = flowInfoDao.hasAct(new_def_id);
			
			if (!hasActFlag) {
				flowInfoDao.insertWFAction(new_def_id, packageId, flowDefId,
						flowVersion);
			}
			tm.commit();
			return new_def_id;
		} catch (Exception e) {
			tm.rollback();
			logger.error(e.toString());
			throw new Exception(e.toString());
		}
	}

	/**
	 * @Description:启用流程
	 * @param ecId
	 * @param flowId
	 * @throws Exception
	 */
	public void userFlowInfo(String flowId, String flowDefId) throws Exception {
		FlowInfoDao flowInfoDao = new FlowInfoDaoImpl();
		TransactionManager tm = new TransactionManager();
		try {
			tm.begin();
			flowInfoDao.stopFlowInfo(flowId);// 流程设置为无效
			flowInfoDao.startupFlowInfo(flowDefId);
			tm.commit();
		} catch (Exception e) {
			tm.rollback();
			logger.error(e.toString());
			throw new Exception(e.toString());
		}
	}

	/**
	 * 继承老版本流程信息
	 * 
	 * @param oldWfId
	 * @param newWfId
	 * @return
	 */
	// FIXME lei.zhang
	public void updateWorkflowInfo(String oldFlowId, String newFlowId)
			throws Exception {

		 	TransactionManager tm = new TransactionManager();
		FlowInfoDao flowInfoDao = new FlowInfoDaoImpl();
		try {
			tm.begin();
			//老流程的环节信息，封装在map中，key是action_defid
			Map<String,FlowWfactionInfoBean> oldActionInfoMap = flowInfoDao
					.getWfActionMapByFlowId(oldFlowId);// 得得老流程环节list
			List<FlowWfactionInfoBean> newWfactionList = flowInfoDao
			.getWfActionListByFlowId(newFlowId);// 得到新流程环节list
			for (int i = 0; i < newWfactionList.size(); i++) {
				FlowWfactionInfoBean newWfActionBaseBean = newWfactionList.get(i);
				String newAction_id = newWfActionBaseBean.getAction_id();
				String actionDefId = newWfActionBaseBean.getAction_defid();
				FlowWfactionInfoBean oldWfActionBaseBean = oldActionInfoMap.get(actionDefId);
				if(null != oldWfActionBaseBean){//如果老流程中有对应的环节才去继承老环节数据
					String oldAction_id = oldWfActionBaseBean.getAction_id();
					
					oldWfActionBaseBean.setAction_id(newAction_id);
					
					flowInfoDao.updateFlowWfactionInfo(oldWfActionBaseBean);// 更新ta_sp_wfaction
					
					FlowWfactionExtBean flowWfactionExtBean = new FlowWfactionExtBean(); 
					BeanUtils.copyProperties(flowWfactionExtBean,flowInfoDao.findFlowWfactionExtInfoById(oldAction_id));
					FlowActionFormDef flowActionFormDef = flowInfoDao.findFlowWfactionFormDefById(oldAction_id);
					FlowActionTreeConfigBean flowActionTreeConfigBean = flowInfoDao.findFlowWfactionTreeConfigById(oldAction_id);
					flowActionTreeConfigBean.setConfig_id(DaoUtil.findBySequencsName("SEQ_FLOW_TREECONFIG"));
					flowWfactionExtBean.setAction_id(newAction_id);
					flowActionFormDef.setAction_id(newAction_id);
					flowActionTreeConfigBean.setAction_id(newAction_id);
					
					flowInfoDao.addFlowWfactionExtInfo(flowWfactionExtBean);
					flowInfoDao.addFlowWfactionFormDef(flowActionFormDef);
					((BaseDao)flowInfoDao).insert(flowActionTreeConfigBean);
					flowInfoDao.addActUsersInfo(oldAction_id, newAction_id);
				}
			}
			tm.commit();
		} catch (Exception e) {
			tm.rollback();
			logger.error(e.toString());
			throw new Exception(e.toString());
		}
		
	}

	/**
	 * @Description:得到老版本流程id
	 * @param packageId
	 * @param processId
	 * @param ecId
	 * @return
	 * @throws Exception
	 */
	public String getOldFlowId(String packageId, String flowDefId, String flowId)
			throws Exception {
		FlowInfoDao flowInfoDao = new FlowInfoDaoImpl();
		return flowInfoDao.getOldFlowId(packageId, flowDefId, flowId);
	}

	public boolean delFlowInfoByEcId(String ecId, String flowId)
			throws Exception {
		TransactionManager tm = new TransactionManager();
		FlowInfoDao flowInfoDao = new FlowInfoDaoImpl();
		
		try {
			 
			List<String> flowActList = flowInfoDao.getFlowAct(flowId);
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
			
			tm.begin();
			// 删除流程信息
			flowInfoDao.deleteFlowDefInfoById(flowId);

			// 删除流程对应环节 信息
			flowInfoDao.deleteFlowWfactionInfoById(flowId);

			if (!StringUtil.isBlank(actionIds.toString())) {

				// 删除流程对应的环节对应的用户信息

				//flowInfoDao.delWfactionUser(actionIds.toString());

				// 删除环节扩展信息
				//flowInfoDao.delWfactionExt(actionIds.toString());

				
				// 删除流程对应的环节对应的表单信息
				//flowInfoDao.delActFormConfig(actionIds.toString());


			}

			tm.commit();

		} catch (Exception e) {
			logger.error(e.getMessage());
			return false;
		}
		return true;
	}
}
