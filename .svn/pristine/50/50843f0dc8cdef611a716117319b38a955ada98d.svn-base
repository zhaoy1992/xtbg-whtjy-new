
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevScrapServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-10   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.DevScrapDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevScrapDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevScrapBean;
import com.chinacreator.xtbg.tjy.device.service.DevScrapService;

/**
 *<p>Title:DevScrapServiceImpl.java</p>
 *<p>Description:申请报废业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-10
 */
public class DevScrapServiceImpl implements DevScrapService {

	private static final Log LOG=LogFactory.getLog(DevScrapServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevScrapInfo
	  * @param t_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevScrapService#getDevScrapInfo(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevScrapInfo(String t_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevScrapDao devscrapdao = new DevScrapDaoImpl();
			viewMap = devscrapdao.getDevScrapInfo(t_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}
	@Override
	public boolean saveDevScrapInfo(DevScrapBean bean) throws Exception {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevScrapDao devscrapdao = new DevScrapDaoImpl();
			//bean.setT_id(StringUtil.getUUID());
			devscrapdao.saveDevScrapInfo(bean);
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}
