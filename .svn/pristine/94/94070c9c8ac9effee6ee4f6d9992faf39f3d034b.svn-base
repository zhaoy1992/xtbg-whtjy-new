
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevTakcareServiceImpl.java
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
import com.chinacreator.xtbg.tjy.device.dao.DevTakcareDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevAccountInfoDaoImpl;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevTakcareDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo;
import com.chinacreator.xtbg.tjy.device.entity.DevTakcareBean;
import com.chinacreator.xtbg.tjy.device.service.DevTakcareService;

/**
 *<p>Title:DevTakcareServiceImpl.java</p>
 *<p>Description:设备维修和保养记录业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-8
 */
public class DevTakcareServiceImpl implements DevTakcareService{
		
	private static final Log LOG=LogFactory.getLog(DevTakcareServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevTakcareBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevTakcareService#getDevTakcareBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevTakcareBean(String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevTakcareDao devtakcaredao = new DevTakcareDaoImpl();
			viewMap = devtakcaredao.getDevTakcareBean(id, conn);
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
	  *     复写方法 insertOrUpdateDevTakcare
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevTakcareService#insertOrUpdateDevTakcare(com.chinacreator.xtbg.tjy.device.entity.DevTakcareBean) 
	  */
	@Override
	public String insertOrUpdateDevTakcare(DevTakcareBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//投入使用时间
			bean.setTac_usertime(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getTac_usertime()), "yyyy-MM-dd"));
			//申请时间
			bean.setTac_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getTac_time()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			DevTakcareDao dao = new DevTakcareDaoImpl();
			//更改设备信息中的 设备完好状态  1:完好2:在修 3:报废 4:损耗
			DevAccountInfo devaccountinfo = new DevAccountInfo();
			//设备ID
			devaccountinfo.setId(bean.getT_sb_id());
			//设置设备完好状态为"1":完好 状态
			devaccountinfo.setDev_state("1");
			DevAccountInfoDaoImpl devaccountinfodao = new DevAccountInfoDaoImpl();
			devaccountinfodao.update(devaccountinfo);
			//保存设备维修和保养记录
			if(StringUtil.nullOrBlank(bean.getTac_id())){//insert
				bean.setTac_id(StringUtil.getUUID());
				beanId = bean.getTac_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getTac_id();
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
	  *     复写方法 deleteDevDevTakcareByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevTakcareService#deleteDevDevTakcareByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevDevTakcareByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevTakcareDao dao = new DevTakcareDaoImpl();
			for (String beanId : ids) {
				dao.deleteDevTakcareById(conn, beanId);
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
