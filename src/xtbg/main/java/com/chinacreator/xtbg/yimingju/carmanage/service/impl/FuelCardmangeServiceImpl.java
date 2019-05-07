
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     FuelCardmangeServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-25   Administrator    最初版本
   */
package com.chinacreator.xtbg.yimingju.carmanage.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.FuelCardmangeDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.impl.FuelCardmangeDaoImpl;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.FuelCardInfoBean;
import com.chinacreator.xtbg.yimingju.carmanage.service.FuelCardmangeService;

/**
 *<p>Title:FuelCardmangeServiceImpl.java</p>
 *<p>Description:特检院 车辆油卡管理信息业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-25
 */
public class FuelCardmangeServiceImpl implements FuelCardmangeService {
	
	private static final Log LOG=LogFactory.getLog(FuelCardmangeServiceImpl.class);
	/**
	*<b>Summary: </b>
	* getFuelcardInfo(根据车辆id查询车辆油卡信息)
	* @param car_id
	* @return Map
	 */
	public Map<String, String> getFuelcardInfo(String car_id){
		
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			FuelCardmangeDao fuelcardmangedao = new FuelCardmangeDaoImpl();
			viewMap = fuelcardmangedao.getFuelcardInfo(car_id, conn);
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
	* insertOrUpdateFuelCardmange(增加和修改车辆油卡信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateFuelCardmange(CarManageCarBean bean){
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FuelCardmangeDao dao = new FuelCardmangeDaoImpl();
			if(StringUtil.nullOrBlank(bean.getCar_id())){//insert
				bean.setCar_id(StringUtil.getUUID());
				beanId = bean.getCar_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getCar_id();
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
	* insertOrUpdateFuelCardinfo(登记加油和充值处理)
	* @param bean
	* @return
	 */
	public String insertOrUpdateFuelCardinfo(FuelCardInfoBean bean){
		Connection conn = null;
		String beanId = "";
		try {
			//登记时间
			bean.setFuelcard_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getFuelcard_time()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			FuelCardmangeDao dao = new FuelCardmangeDaoImpl();
			if(StringUtil.nullOrBlank(bean.getFuelcard_id())){//insert
				bean.setFuelcard_id(StringUtil.getUUID());
				beanId = bean.getFuelcard_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getFuelcard_id();
				((BaseDao)dao).update(bean, conn);
			}
			//油卡余额更新操作
			FuelCardmangeDao fuelcardmangedao = new FuelCardmangeDaoImpl();
			Map<String,String> fuelcardmangeMap = fuelcardmangedao.getFuelcardInfo(bean.getCard_id(), conn);
			String fuelcard_sum = StringUtil.deNull(fuelcardmangeMap.get("fuelcard_sum"));//油卡余额
			if("".equals(fuelcard_sum)){
				fuelcard_sum = "0";
			}
			String fuelcard_money = bean.getFuelcard_money();//加油\充值金额
			float money =0; 
			//加油
			if("0".equals(StringUtil.deNull(bean.getFuelcard_type()))){
				money = StringUtil.round(Float.valueOf(fuelcard_sum),2) - StringUtil.round(Float.valueOf(fuelcard_money),2);
			}else if("1".equals(StringUtil.deNull(bean.getFuelcard_type()))){
				money = StringUtil.round(Float.valueOf(fuelcard_sum),2) + StringUtil.round(Float.valueOf(fuelcard_money),2);
			}
			CarManageCarBean carmanagecarbean = new CarManageCarBean();
			carmanagecarbean.setCar_id(bean.getCard_id());
			carmanagecarbean.setFuelcard_sum(""+money);
			insertOrUpdateFuelCardmange(carmanagecarbean);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}
}
