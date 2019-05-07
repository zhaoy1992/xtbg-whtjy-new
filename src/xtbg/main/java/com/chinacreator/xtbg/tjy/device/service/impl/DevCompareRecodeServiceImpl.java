
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCompareRecodeServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-8   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevCompareRecodeDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevCompareRecodeDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevCompareRecode;
import com.chinacreator.xtbg.tjy.device.service.DevCompareRecodeService;

/**
 *<p>Title:DevCompareRecodeServiceImpl.java</p>
 *<p>Description:对比记录业务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-8
 */
public class DevCompareRecodeServiceImpl implements DevCompareRecodeService{
	
	private static final Log LOG = LogFactory.getLog(DevCompareRecodeServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevCompareRecode
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevCompareRecodeService#getDevCompareRecode(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevCompareRecode(String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevCompareRecodeDao devcomparerecodedao = new DevCompareRecodeDaoImpl();
			viewMap = devcomparerecodedao.getDevCompareRecode(id, conn);
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
	  *     复写方法 insertOrUpdateDevCompareRecode
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevCompareRecodeService#insertOrUpdateDevCompareRecode(com.chinacreator.xtbg.tjy.device.entity.DevCompareRecode) 
	  */
	@Override
	public String insertOrUpdateDevCompareRecode(DevCompareRecode bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//创建日期
			bean.setCreator_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getCreator_time()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			DevCompareRecodeDao dao = new DevCompareRecodeDaoImpl();
			if(StringUtil.nullOrBlank(bean.getComp_id())){//insert
				bean.setComp_id(StringUtil.getUUID());
				beanId = bean.getComp_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getComp_id();
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
	  *     复写方法 deleteDevCompareRecodeByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevCompareRecodeService#deleteDevCompareRecodeByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevCompareRecodeByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevCompareRecodeDao dao = new DevCompareRecodeDaoImpl();
			for (String beanId : ids) {
				dao.deleteDevCompareRecodeById(conn, beanId);
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
