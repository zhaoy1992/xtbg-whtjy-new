
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevIssuedPlanServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.DevIssuedDetailsDao;
import com.chinacreator.xtbg.tjy.device.dao.DevIssuedPlanDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevIssuedDetailsDaoImp;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevIssuedPlanDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevIssuedPlanBean;
import com.chinacreator.xtbg.tjy.device.service.DevIssuedPlanService;

/**
 *<p>Title:DevIssuedPlanServiceImpl.java</p>
 *<p>Description:下达核检计划业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-3
 */
public class DevIssuedPlanServiceImpl implements DevIssuedPlanService{

	private static final Log LOG=LogFactory.getLog(DevIssuedPlanServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevIssuedPlanBean
	  * @param plan_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevIssuedPlanService#getDevIssuedPlanBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevIssuedPlanBean(String plan_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevIssuedPlanDao devissuedplandao = new DevIssuedPlanDaoImpl();
			viewMap = devissuedplandao.getDevIssuedPlan(plan_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 insertOrUpdateDevIssuedPlan
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevIssuedPlanService#insertOrUpdateDevIssuedPlan(com.chinacreator.xtbg.tjy.device.entity.DevIssuedPlanBean) 
	  */
	@Override
	public String insertOrUpdateDevIssuedPlan(DevIssuedPlanBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//计划完成时间
			bean.setCompltime(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getCompltime()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			DevIssuedPlanDao dao = new DevIssuedPlanDaoImpl();
			if(StringUtil.nullOrBlank(bean.getPlan_id())){//insert
				bean.setPlan_id(StringUtil.getUUID());
				beanId = bean.getPlan_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getPlan_id();
				((BaseDao)dao).update(bean, conn);
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevIssuedPlanByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevIssuedPlanService#deleteDevIssuedPlanByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevIssuedPlanByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevIssuedPlanDao dao = new DevIssuedPlanDaoImpl();
			DevIssuedDetailsDao datailsDao = new DevIssuedDetailsDaoImp();
			for (String beanId : ids) {
				dao.deleteDevIssuedPlanById(conn, beanId);
				datailsDao.delete(beanId, conn);
			}
			conn.commit();
			flag = "true";
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

	@Override
	public String insertDevIssuedPlan(DevIssuedPlanBean bean) {
		Connection conn = null;
		String flag = "false";
		try {
			//计划完成时间
			bean.setCompltime(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getCompltime()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			DevIssuedPlanDao dao = new DevIssuedPlanDaoImpl();
			((BaseDao)dao).insert(bean, conn);
			conn.commit();
			flag = "true";
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

	@Override
	public String updateDevIssuedPlan(DevIssuedPlanBean bean) {
		Connection conn = null;
		String flag = "false";
		try {
			//计划完成时间
			bean.setCompltime(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getCompltime()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			DevIssuedPlanDao dao = new DevIssuedPlanDaoImpl();
			((BaseDao)dao).update(bean, conn);
			conn.commit();
			flag = "true";
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}
