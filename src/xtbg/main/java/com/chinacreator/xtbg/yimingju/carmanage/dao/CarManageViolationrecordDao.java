package com.chinacreator.xtbg.yimingju.carmanage.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageViolationrecordBean;

/**
 * 车辆管理车辆申请Dao
 * @author haiyun
 *
 */
public interface CarManageViolationrecordDao {
	/**
	 * @Description 根据条件查询加油信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findCarManageViolationrecordList(CarManageViolationrecordBean bean, String sortName, String sortOrder, long offset, int maxPagesize) throws SQLException;
	
	
	/**
	  * 复写方法 getCarManageViolationrecord
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	 */
	public Map<String, String> getCarManageViolationrecord(String id, Connection conn) throws Exception ;
}
