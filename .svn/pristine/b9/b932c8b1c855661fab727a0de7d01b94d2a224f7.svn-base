package com.chinacreator.xtbg.yimingju.carmanage.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageRefuelmanageDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageRefuelmanageBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class CarManageRefuelmanageDaoImpl extends XtDbBaseDao implements CarManageRefuelmanageDao {

	@Override
	public PagingBean findCarManageRefuelmanageList(CarManageRefuelmanageBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws SQLException {
		
		PagingBean pb = new PagingBean();
		// 数据库操作工具对象
		PreparedDBUtil db = new PreparedDBUtil();
		// 创建sql语句
		StringBuffer sql = new StringBuffer();
		sql.append("select fuel_id, license_number, fuel_type, unit_cost, refuel_point, invoice_number, more_detail, " +
				"refuel_time, total_price, fuel_charge, fuel_person, fuel_name, t1.car_num " +
				"from ta_oa_refuelmanage t left join YMJ_OA_CARMANAGE_CAR t1 on t.license_number=t1.car_id where 1=1 ");
		// 查询条件不为空则拼接查询条件
		if (!StringUtil.nullOrBlank(bean.getStart_time())) {
			sql.append(" and to_date(refuel_time ,'yyyy-mm-dd') >= to_date('"+bean.getStart_time()+"' ,'yyyy-mm-dd') ");
		}
		if (!StringUtil.nullOrBlank(bean.getEnd_time())) {
			sql.append(" and to_date(refuel_time ,'yyyy-mm-dd') <= to_date('"+bean.getEnd_time()+"' ,'yyyy-mm-dd') ");
		}
		// 排序字段不为空，则将排序拼接到sql
		if (!StringUtil.nullOrBlank(sortName) && !StringUtil.nullOrBlank(sortOrder)) {
			sql.append(" order by " + sortName + " " + sortOrder);
		}
		db.preparedSelect(sql.toString(), offset, maxPagesize);
		// 执行查询语句，并封装成List<ActivityTypeBean>数据集合
		pb.setList(db.executePreparedForList(CarManageRefuelmanageBean.class));
		pb.setRecords((long) db.getTotalSize());
		return pb;
		
	}
	
	/**
	  * 复写方法 getCarManageRefuelmanage
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	 */
	public Map<String, String> getCarManageRefuelmanage(String id, Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select fuel_id, license_number, fuel_type, unit_cost, refuel_point, invoice_number, more_detail, " +
				"refuel_time, total_price, fuel_charge, fuel_person, fuel_name from ta_oa_refuelmanage where fuel_id=? ");
		viewMap = queryToSingleMap(conn, sql.toString(), id);
		return viewMap;
	}
}
