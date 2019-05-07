package com.chinacreator.xtbg.yimingju.carmanage.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageViolationrecordDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageViolationrecordBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class CarManageViolationrecordDaoImpl extends XtDbBaseDao implements CarManageViolationrecordDao {

	@Override
	public PagingBean findCarManageViolationrecordList(CarManageViolationrecordBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws SQLException {
		
		PagingBean pb = new PagingBean();
		// 数据库操作工具对象
		PreparedDBUtil db = new PreparedDBUtil();
		// 创建sql语句
		StringBuffer sql = new StringBuffer();
		sql.append("select endorsement_id, license_number, record_place, involve_cash, more_detail, record_type, " +
				"record_time, drive_person, drive_person_name,t1.car_num from ta_oa_violationrecord t left join " +
				"YMJ_OA_CARMANAGE_CAR t1 on t.license_number=t1.car_id where 1=1 ");
		// 查询条件不为空则拼接查询条件
		if (!StringUtil.nullOrBlank(bean.getStart_time())) {
			sql.append(" and to_date(record_time ,'yyyy-mm-dd') >= to_date('"+bean.getStart_time()+"' ,'yyyy-mm-dd') ");
		}
		if (!StringUtil.nullOrBlank(bean.getEnd_time())) {
			sql.append(" and to_date(record_time ,'yyyy-mm-dd') <= to_date('"+bean.getEnd_time()+"' ,'yyyy-mm-dd') ");
		}
		// 排序字段不为空，则将排序拼接到sql
		if (!StringUtil.nullOrBlank(sortName) && !StringUtil.nullOrBlank(sortOrder)) {
			sql.append(" order by " + sortName + " " + sortOrder);
		}
		db.preparedSelect(sql.toString(), offset, maxPagesize);
		// 执行查询语句，并封装成List<ActivityTypeBean>数据集合
		pb.setList(db.executePreparedForList(CarManageViolationrecordBean.class));
		pb.setRecords((long) db.getTotalSize());
		return pb;
		
	}
	
	
	/**
	  * 复写方法 getCarManageViolationrecord
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	 */
	public Map<String, String> getCarManageViolationrecord(String id, Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select endorsement_id, license_number, record_place, involve_cash, more_detail, record_type, " +
				"record_time, drive_person, drive_person_name from ta_oa_violationrecord where endorsement_id=?  ");
		viewMap = queryToSingleMap(conn, sql.toString(), id);
		return viewMap;
	}
}