
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevRepairServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-6   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.tjy.device.dao.DevRepairDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevRepairDaoImpl;
import com.chinacreator.xtbg.tjy.device.service.DevRepairService;

/**
 *<p>Title:DevRepairServiceImpl.java</p>
 *<p>Description:仪器设备维修业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-6
 */
public class DevRepairServiceImpl implements DevRepairService{

	private static final Log LOG=LogFactory.getLog(DevRepairServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevRepairInfo
	  * @param t_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevRepairService#getDevRepairInfo(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevRepairInfo(String t_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevRepairDao devrepairdao = new DevRepairDaoImpl();
			viewMap = devrepairdao.getDevRepairInfo(t_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}

}
