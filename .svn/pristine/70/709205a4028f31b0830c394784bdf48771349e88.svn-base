
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAppraisalServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-8   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevAppraisalDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevAppraisalDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevAppraisalBean;
import com.chinacreator.xtbg.tjy.device.service.DevAppraisalService;

/**
 *<p>Title:DevAppraisalServiceImpl.java</p>
 *<p>Description:设备检定记录业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-8
 */
public class DevAppraisalServiceImpl implements DevAppraisalService{

	private static final Log LOG=LogFactory.getLog(DevAppraisalServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevAppraisalBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevAppraisalService#getDevAppraisalBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevAppraisalBean(String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevAppraisalDao devappraisaldao = new DevAppraisalDaoImpl();
			viewMap = devappraisaldao.getDevAppraisalBean(id, conn);
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
	  *     复写方法 insertOrUpdateDevAppraisal
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevAppraisalService#insertOrUpdateDevAppraisal(com.chinacreator.xtbg.tjy.device.entity.DevAppraisalBean) 
	  */
	@Override
	public String insertOrUpdateDevAppraisal(DevAppraisalBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//检定/校准日期
			bean.setAppr_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getAppr_time()), "yyyy-MM-dd"));
			//有效期
			bean.setAppr_valitime(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getAppr_valitime()), "yyyy-MM-dd"));
			//下次检定日期
			bean.setNext_appr_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getNext_appr_time()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			DevAppraisalDao dao = new DevAppraisalDaoImpl();
			if(StringUtil.nullOrBlank(bean.getAppr_id())){//insert
				bean.setAppr_id(StringUtil.getUUID());
				beanId = bean.getAppr_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getAppr_id();
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
	  *     复写方法 deleteDevDevAppraisalByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevAppraisalService#deleteDevDevAppraisalByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevDevAppraisalByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevAppraisalDao devappraisaldao = new DevAppraisalDaoImpl();
			for (String beanId : ids) {
				devappraisaldao.deleteDevAppraisalById(conn, beanId);
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

}
