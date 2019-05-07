
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     FuelCardmangeDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-25   Administrator    最初版本
   */
package com.chinacreator.xtbg.yimingju.carmanage.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.FuelCardmangeDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.FuelCardInfoBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:FuelCardmangeDaoImpl.java</p>
 *<p>Description:特检院车辆油卡管理dao层接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-25
 */
public class FuelCardmangeDaoImpl extends XtDbBaseDao implements FuelCardmangeDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 queryFuelCardmangeList
	  * @param carmanagecarbean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.yimingju.carmanage.dao.FuelCardmangeDao#queryFuelCardmangeList(com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean queryFuelCardmangeList(CarManageCarBean carmanagecarbean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		
		PagingBean pb = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		List<String> values = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * ");
		sql.append("  from  ymj_oa_carmanage_car ");
		sql.append("  where  1=1  ");
		//车牌号
		if(!StringUtil.isBlank(carmanagecarbean.getCar_num())){
			sql.append("     and car_num like '%"+carmanagecarbean.getCar_num()+"%'");
		}
		//品牌
		if(!StringUtil.isBlank(carmanagecarbean.getCar_brand())){
			sql.append("     and car_brand like '%"+carmanagecarbean.getCar_brand()+"%'");
		}
		//油卡卡号
		if(!StringUtil.isBlank(carmanagecarbean.getFuelcard_num())){
			sql.append("     and fuelcard_num like '%"+carmanagecarbean.getFuelcard_num()+"%'");
		}
		sql.append("  order by "+ sortName+"   "+sortOrder);
		pdb.preparedSelect(sql.toString(),offset, maxPagesize);
		pdb.executePrepared();
		list = queryToListMap(sql.toString(), offset, maxPagesize, values);
		pb.setList(list);
		pb.setRecords((long) pdb.getTotalSize());
		return pb;
	}
	
	/**
	*<b>Summary: </b>
	* getFuelcardInfo(根据车辆id查询车辆油卡信息)
	* @param car_id
	* @param conn
	* @return Map
	 */
	public Map<String, String> getFuelcardInfo(String car_id,Connection conn) throws Exception{
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *   ");
		sql.append("  from ymj_oa_carmanage_car ");
		sql.append(" where car_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), car_id);
		return viewMap;
	}
	
	
	/**
	*<b>Summary: </b>
	* queryCardFuelHistory(查询车辆油卡使用记录)
	* @param fuelcardinfobean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryCardFuelHistory(FuelCardInfoBean fuelcardinfobean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		
		PagingBean pb = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		List<String> values = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select fuelcard_id, ");
		sql.append(" 	   fuelcard_money,  ");
		sql.append(" 	   decode(fuelcard_type,'0','加油','1','充值','') as fuelcard_type,  ");
		sql.append(" 	   to_char(fuelcard_time,'yyyy-mm-dd') as fuelcard_time,  ");
		sql.append(" 	   card_id,  ");
		sql.append(" 	   fuelcard_remark  ");
		sql.append("  from  ta_oa_cardfuelhistory ");
		sql.append("  where  1=1  ");
		//车辆ID
		if(!StringUtil.isBlank(fuelcardinfobean.getCard_id())){
			sql.append("     and card_id = '"+fuelcardinfobean.getCard_id()+"'");
		}
		sql.append("  order by "+ sortName+"   "+sortOrder);
		pdb.preparedSelect(sql.toString(),offset, maxPagesize);
		pdb.executePrepared();
		list = queryToListMap(sql.toString(), offset, maxPagesize, values);
		pb.setList(list);
		pb.setRecords((long) pdb.getTotalSize());
		return pb;
	}
	

}
