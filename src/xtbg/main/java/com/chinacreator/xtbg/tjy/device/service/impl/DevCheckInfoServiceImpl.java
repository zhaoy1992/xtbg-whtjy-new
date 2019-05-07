
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCheckInfoServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-7   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevCheckInfoDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevCheckInfoDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevCheckInfoBean;
import com.chinacreator.xtbg.tjy.device.service.DevCheckInfoService;

/**
 *<p>Title:DevCheckInfoServiceImpl.java</p>
 *<p>Description:核查记录业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-7
 */
public class DevCheckInfoServiceImpl implements DevCheckInfoService{

	private static final Log LOG=LogFactory.getLog(DevCheckInfoServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevCheckInfoBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevCheckInfoService#getDevCheckInfoBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevCheckInfoBean(String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevCheckInfoDao devcheckinfodao = new DevCheckInfoDaoImpl();
			viewMap = devcheckinfodao.getDevCheckInfo(id, conn);
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
	  *     复写方法 insertOrUpdateDevCheckInfo
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevCheckInfoService#insertOrUpdateDevCheckInfo(com.chinacreator.xtbg.tjy.device.entity.DevCheckInfoBean) 
	  */
	@Override
	public String insertOrUpdateDevCheckInfo(DevCheckInfoBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//检查时间
			bean.setChinfo_date(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getChinfo_date()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			DevCheckInfoDao dao = new DevCheckInfoDaoImpl();
			if(StringUtil.nullOrBlank(bean.getId())){//insert
				bean.setId(StringUtil.getUUID());
				beanId = bean.getId();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getId();
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
	  *     复写方法 deleteDevCheckInfoByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevCheckInfoService#deleteDevCheckInfoByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevCheckInfoByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevCheckInfoDao dao = new DevCheckInfoDaoImpl();
			for (String beanId : ids) {
				dao.deleteDevCheckInfoById(conn, beanId);
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
