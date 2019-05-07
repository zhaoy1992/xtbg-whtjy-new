package com.chinacreator.xtbg.yimingju.carmanage.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageMileagerecordDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageMileagerecordBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class CarManageMileagerecordDaoImpl extends XtDbBaseDao implements CarManageMileagerecordDao {

	@Override
	public PagingBean findCarManageMileagerecordList(CarManageMileagerecordBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws SQLException {
		
		PagingBean pb = new PagingBean();
		// 数据库操作工具对象
		PreparedDBUtil db = new PreparedDBUtil();
		// 创建sql语句
		StringBuffer sql = new StringBuffer();
		sql.append("select mileagerecord_id, license_number, t.driver, count_time, count_mileage, more_detail, " +
				"driver_name, t1.car_num from ta_oa_mileagerecord t left join YMJ_OA_CARMANAGE_CAR t1 on " +
				"t.license_number=t1.car_id where 1=1 ");
		// 查询条件不为空则拼接查询条件
		if (!StringUtil.nullOrBlank(bean.getLicense_number())) {
			sql.append(" and license_number='" + bean.getLicense_number() + "' ");
		}
		// 排序字段不为空，则将排序拼接到sql
		if (!StringUtil.nullOrBlank(sortName) && !StringUtil.nullOrBlank(sortOrder)) {
			sql.append(" order by " + sortName + " " + sortOrder);
		}
		db.preparedSelect(sql.toString(), offset, maxPagesize);
		// 执行查询语句，并封装成List<ActivityTypeBean>数据集合
		pb.setList(db.executePreparedForList(CarManageMileagerecordBean.class));
		pb.setRecords((long) db.getTotalSize());
		return pb;
		
	}
	
	
	/**
	  * 复写方法 getCarManageMileagerecord
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	 */
	public Map<String, String> getCarManageMileagerecord(String id, Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select mileagerecord_id, license_number, driver, count_time, count_mileage, more_detail, " +
				"driver_name from ta_oa_mileagerecord where mileagerecord_id=? ");
		viewMap = queryToSingleMap(conn, sql.toString(), id);
		return viewMap;
	}
}
