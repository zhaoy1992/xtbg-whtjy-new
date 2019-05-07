
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevEquipmentaccServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-20   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevEquipmentaccDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevEquipmentaccDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevEquipmentaccBean;
import com.chinacreator.xtbg.tjy.device.service.DevEquipmentaccService;

/**
 *<p>Title:DevEquipmentaccServiceImpl.java</p>
 *<p>Description:政府采购验收单业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-20
 */
public class DevEquipmentaccServiceImpl implements DevEquipmentaccService {
	
	private static final Log LOG=LogFactory.getLog(DevEquipmentaccServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevEquipmentaccBean
	  * @param t_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevEquipmentaccService#getDevEquipmentaccBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevEquipmentaccBean(String t_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevEquipmentaccDao devequipmentaccdao = new DevEquipmentaccDaoImpl();
			viewMap = devequipmentaccdao.getDevEquipmentacc(t_id, conn);
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
	  *     复写方法 insertOrUpdateDevEquipmentacc
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevEquipmentaccService#insertOrUpdateDevEquipmentacc(com.chinacreator.xtbg.tjy.device.entity.DevEquipmentaccBean) 
	  */
	@Override
	public String insertOrUpdateDevEquipmentacc(DevEquipmentaccBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//到货日期
			bean.setT_dhdate(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getT_dhdate()), "yyyy-MM-dd"));
			//供方验收人签字时间
			bean.setT_gfysr_date(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getT_gfysr_date()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			DevEquipmentaccDao dao = new DevEquipmentaccDaoImpl();
			if(StringUtil.nullOrBlank(bean.getT_id())){//insert
				bean.setT_id(StringUtil.getUUID());
				beanId = bean.getT_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getT_id();
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
	  *     复写方法 deleteDevEquipmentaccByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevEquipmentaccService#deleteDevEquipmentaccByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevEquipmentaccByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevEquipmentaccDao dao = new DevEquipmentaccDaoImpl();
			for (String beanId : ids) {
				dao.deleteDevEquipmentacById(conn, beanId);
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
