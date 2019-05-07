package com.chinacreator.xtbg.tjy.device.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.LandHouseInfoDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.LandHouseInfoDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.LandHouseBean;
import com.chinacreator.xtbg.tjy.device.service.LandHouseItemService;

/**
 *<p>Title:DevInfoItemServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public class LandHouseInfoItemServiceImpl implements LandHouseItemService {

	private static final Log LOG=LogFactory.getLog(LandHouseInfoItemServiceImpl.class);

	/**
	 * 
	  * <b>Summary: 删除土地房屋基本信息</b>
	  *     复写方法 deleteLandHouseItemByIds
	  * @param lh_ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.LandHouseItemService
	  * #deleteLandHouseItemByIds(java.lang.String[])
	 */
	@Override
	public String deleteLandHouseItemByIds(String[] lh_ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			LandHouseInfoDao dao = new LandHouseInfoDaoImpl();
			if(lh_ids != null && lh_ids.length > 0 ){
				for (String beanId : lh_ids) {
					dao.deleteLandHouseItemById(conn, beanId);
				}
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
	 * 
	  * <b>Summary: 新增或修改土地房屋基本信息</b>
	  *     复写方法 insertOrUpdateLandHouseItem
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.LandHouseItemService
	  * #insertOrUpdateLandHouseItem(com.chinacreator.xtbg.tjy.device.entity.LandHouseBean)
	 */
	@Override
	public String insertOrUpdateLandHouseItem(LandHouseBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//日期
			bean.setLh_date(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getLh_date()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			LandHouseInfoDao dao = new LandHouseInfoDaoImpl();
			if(StringUtil.nullOrBlank(bean.getLh_id())){//insert
				//根据编号查询是否存在，存在更新，不存在新增
				beanId =  dao.getLandHouseByLh_Number(bean.getLh_number());
				if(!"false".equals(beanId)){//存在，更新
					bean.setLh_id(beanId);
					((BaseDao)dao).update(bean, conn);
				}else{//不存在新增
					bean.setLh_id(StringUtil.getUUID());
					beanId = bean.getLh_id();
					((BaseDao)dao).insert(bean, conn);
				}
			}else{//update
				beanId = bean.getLh_id();
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
	 * 
	  * <b>Summary: 根据lh_id获取土地房屋基本信息</b>
	  *     复写方法 getLandHouseBean
	  * @param lh_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.LandHouseItemService#getLandHouseBean(java.lang.String)
	 */
	@Override
	public Map<String, String> getLandHouseBean(String lh_id) {
		Connection conn = null;
		Map<String, String> beanMap = new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			LandHouseInfoDao dao = new LandHouseInfoDaoImpl();
			beanMap = dao.queryLandHouseBean(conn,lh_id);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanMap;
	}
	 
}
