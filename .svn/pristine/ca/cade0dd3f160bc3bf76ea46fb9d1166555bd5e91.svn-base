package com.chinacreator.xtbg.core.holiday.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.holiday.dao.HolidayDao;
import com.chinacreator.xtbg.core.holiday.entity.Holiday;
import com.chinacreator.xtbg.core.holiday.service.HolidayService;
/**
 * 
 *<p>Title:HolidayServiceImpl.java</p>
 *<p>Description:节假日管理服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-24
 */
public class HolidayServiceImpl implements HolidayService {

	private static final Log LOG=LogFactory.getLog(HolidayServiceImpl.class);
	/**
	 * 
	  * <b>Summary: 删除节假日</b>
	  *     复写方法 delete
	  * @param holiday
	  * @return 
	  * @see com.chinacreator.xtbg.core.holiday.service.HolidayService#delete(com.chinacreator.xtbg.core.holiday.entity.Holiday)
	 */
	public boolean delete(Holiday holiday) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			HolidayDao dao=(HolidayDao)LoadSpringContext.getApplicationContext().getBean("holidayDaoImpl");
			
			flag=dao.delete(holiday, conn);
			
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
	  * <b>Summary: 添加节假日</b>
	  *     复写方法 insert
	  * @param holiday
	  * @return 
	  * @see com.chinacreator.xtbg.core.holiday.service.HolidayService#insert(com.chinacreator.xtbg.core.holiday.entity.Holiday)
	 */
	public boolean insert(Holiday holiday) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			HolidayDao dao=(HolidayDao)LoadSpringContext.getApplicationContext().getBean("holidayDaoImpl");
			
			((BaseDao)dao).insert(holiday, conn);
			
			flag=true;
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
	  * <b>Summary: 判断是否已经是初始化年</b>
	  *     复写方法 hasInitYear
	  * @param year
	  * @return 
	  * @see com.chinacreator.xtbg.core.holiday.service.HolidayService#hasInitYear(java.lang.String)
	 */
	public boolean hasInitYear(String year) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			HolidayDao dao=(HolidayDao)LoadSpringContext.getApplicationContext().getBean("holidayDaoImpl");
			
			flag=dao.hasInitYear(year, conn);
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
	  * <b>Summary: 保存初始化年</b>
	  *     复写方法 insertYearHoliday
	  * @param year_
	  * @return 
	  * @see com.chinacreator.xtbg.core.holiday.service.HolidayService#insertYearHoliday(java.lang.String)
	 */
	public boolean insertYearHoliday(String year_) {
		Connection conn=null;
		boolean flag=false;
		List<Holiday> holidays = new ArrayList<Holiday>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			HolidayDao dao=(HolidayDao)LoadSpringContext.getApplicationContext().getBean("holidayDaoImpl");
			
			int year=Integer.parseInt(year_);
			for (int i = 0; i < 12; ++i){
		      int length =  new Date(year, i + 1, 0).getDate();;
		      for (int j = 1; j <= length; ++j) {
		        Date day = new Date(year - 1900, i, j);
		        if ((day.getDay() != 0) && (day.getDay() != 6))
		          continue;
		        Holiday holiday = new Holiday();
		        holiday.setHoliday(String.valueOf(day.getDate()));
		        holiday.setMholiday(String.valueOf(day.getMonth() + 1));
		        holiday.setYholiday(String.valueOf(day.getYear() + 1900));
		        holidays.add(holiday);
		      }
		    }
			dao.insertValues(holidays, conn);
			dao.recordInitYear(year_, conn);
			
			flag=true;
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
	  * <b>Summary: 查询选中的天</b>
	  *     复写方法 findByDay
	  * @param pk
	  * @return 
	  * @see com.chinacreator.xtbg.core.holiday.service.HolidayService#findByDay(java.lang.String)
	 */
	public String findByDay(String pk) {
		Connection conn=null;
		String flag="";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			HolidayDao dao=(HolidayDao)LoadSpringContext.getApplicationContext().getBean("holidayDaoImpl");
			
			flag=dao.findByDay(pk, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}
