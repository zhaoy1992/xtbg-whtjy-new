
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAccountServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.OrgCache;
import com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.DevAccountInfoDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevAccountInfoDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo;
import com.chinacreator.xtbg.tjy.device.service.DevAccountInfoService;

/**
 *<p>Title:DevAccountServiceImpl.java</p>
 *<p>Description:设备台帐管理业务层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public class DevAccountServiceImpl implements DevAccountInfoService {
	
	private static final Log LOG=LogFactory.getLog(DevAccountServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevAccountBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevAccountService#getDevAccountBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevAccountBean(String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevAccountInfoDao devaccountdao = new DevAccountInfoDaoImpl();
			viewMap = devaccountdao.getDevAccount(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* getDevAccountByCode(根据设备编号查询设备基本信息)
	* @param id
	* @return
	 */
	public Map<String, String> getDevAccountByCode(String dev_code){
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevAccountInfoDao devaccountdao = new DevAccountInfoDaoImpl();
			viewMap = devaccountdao.getDevAccountByDevCode(dev_code, conn);
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
	  *     复写方法 insertOrUpdateDevAccount
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevAccountService#insertOrUpdateDevAccount(com.chinacreator.xtbg.tjy.device.entity.DevAccount) 
	  */
	@Override
	public String insertOrUpdateDevAccount(DevAccountInfo bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//生产日期
			bean.setCreat_date(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getCreat_date()), "yyyy-MM-dd"));
			//达到时间
			bean.setArrive_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getArrive_time()), "yyyy-MM-dd"));
			//登记时间
			bean.setCreat_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getCreat_time()), "yyyy-MM-dd"));
			//设备保管部门
			if(!StringUtil.nullOrBlank(bean.getUser_orgid())){
				OrgCache orgcache = new OrgCache();
				OrgCacheBean orgcachebean = orgcache.getOrgCacheBean(bean.getUser_orgid());
				bean.setUser_unit(orgcachebean.getUnit_id());//单位ID
				bean.setUser_unitname(orgcachebean.getUnit_name());//单位名称
			}
			conn = DbManager.getInstance().getTransactionConnection();
			DevAccountInfoDao dao = new DevAccountInfoDaoImpl();
			if(StringUtil.nullOrBlank(bean.getId())){//insert
				bean.setId(StringUtil.getUUID());
				beanId = bean.getId();
				//设备使用状态  1:在库 2:借出
				bean.setDev_stockflag("1");
				//设备完好状态  1:完好2:在修 3:报废 4:损耗
				bean.setDev_state("1");
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
	*<b>Summary: </b>
	* deleteDevAccountByIds(根据IDs 删除设备台帐信息)
	* @param ids
	* @return
	 */
	public String  deleteDevAccountByIds(String[] ids){
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevAccountInfoDao dao = new DevAccountInfoDaoImpl();
			for (String beanId : ids) {
				dao.deleteDevAccount(conn, beanId);
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
	
	/**
	*<b>Summary: </b>
	* getDevEquipmentacc(根据id查询政府采购设备验证信息)
	* @param t_sb_id
	* @return
	 */
	public Map<String, String> getDevEquipmentacc(String t_sb_id){
		
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevAccountInfoDao devaccountdao = new DevAccountInfoDaoImpl();
			viewMap = devaccountdao.getDevEquipmentacc(t_sb_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* getDevEqAppInfo(根据id查询政府采购单信息)
	* @param id  采购明细表ID
	* @return Map
	 */
	public Map<String, String> getDevEqAppInfo(String id){
		
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevAccountInfoDao devaccountdao = new DevAccountInfoDaoImpl();
			viewMap = devaccountdao.getDevEqAppInfo(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}

}
