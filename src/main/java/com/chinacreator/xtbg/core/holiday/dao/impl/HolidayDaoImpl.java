package com.chinacreator.xtbg.core.holiday.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.holiday.dao.HolidayDao;
import com.chinacreator.xtbg.core.holiday.entity.Holiday;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:HolidayDaoImpl.java</p>
 *<p>Description:节假日管理接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-22
 */
public class HolidayDaoImpl extends XtDbBaseDao implements HolidayDao {

	/**
	 * 
	  * <b>Summary:删除节假日 </b>
	  *     复写方法 delete
	  * @param Holiday
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.holiday.dao.HolidayDao#delete(com.chinacreator.xtbg.core.holiday.entity.Holiday, java.sql.Connection)
	 */
	public boolean delete(Holiday holiday, Connection conn) throws Exception {
		boolean flag=false;
		String yholiday=holiday.getYholiday();
		String mholiday=holiday.getMholiday();
		PreparedDBUtil pdb=new PreparedDBUtil();
		String sqlstr = "delete from td_sp_holiday where yholiday='" + yholiday + "' and mholiday='" + mholiday + "'";
		pdb.preparedDelete(sqlstr);
		pdb.executePrepared(conn);
		flag=true;
		return flag;
	}

	/**
	 * 
	  * <b>Summary: 判断是否已经是初始化年</b>
	  *     复写方法 hasInitYear
	  * @param year
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.holiday.dao.HolidayDao#hasInitYear(java.lang.String, java.sql.Connection)
	 */
	public boolean hasInitYear(String year, Connection conn) throws Exception {
		if(StringUtil.isBlank(year)){
			return false;
		}
		String sqlstr = "select count(*) as num from TD_SM_INITYEAR_HOLIDAY where YHOLIDAY='" + year + "'";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sqlstr);
		pdb.executePrepared(conn);
		if(pdb.size() > 0) {
	        return (pdb.getInt(0, "num") > 0);
	    }
		return false;
	}

	/**
	 * 
	  * <b>Summary:添加所有的节假日 </b>
	  *     复写方法 insertValues
	  * @param values
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.holiday.dao.HolidayDao#insertValues(java.util.List)
	 */
	public void insertValues(List<Holiday> values,Connection conn) throws Exception {
		PreparedDBUtil pdb=new PreparedDBUtil();
		List<String> sqls=new ArrayList<String>();
		if(values!=null){
			for (Holiday hol : values) {
				String holiday = hol.getHoliday();
		        String yholiday = hol.getYholiday();
		        String mholiday = hol.getMholiday();
		        
		        mholiday = (mholiday.trim().length() == 1) ? "0" + mholiday : mholiday;
		        holiday = (holiday.trim().length() == 1) ? "0" + holiday : holiday;
		        holiday = yholiday + "-" + mholiday + "-" + holiday;
		        String sqlstr = "insert into td_sp_holiday(holiday,yholiday,mholiday) select '" + holiday + "' as holiday, '" + yholiday + "' as yholiday, '" + mholiday + "' " + "as mholiday from dual where not exists (select * from " + "td_sp_holiday where holiday='" + holiday + "' and  yholiday='" + yholiday + "' " + "and mholiday='" + mholiday + "') ";
		        sqls.add(sqlstr);
			}
			pdb.addBatch(sqls);
			pdb.executeBatch(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 recordInitYear
	  * @param year
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.holiday.dao.HolidayDao#recordInitYear(java.lang.String, java.sql.Connection)
	 */
	public void recordInitYear(String year,Connection conn) throws Exception {
		String sqlstr = "insert into TD_SM_INITYEAR_HOLIDAY(YHOLIDAY)values(?)";
	    PreparedDBUtil pd = new PreparedDBUtil();
	    if(!StringUtil.isBlank(year)){
	    	pd.preparedInsert(sqlstr);
	        pd.setString(1, year);
	        pd.executePrepared();
	    }
	}

	/**
	 * \
	  * <b>Summary: 查询选中的天</b>
	  *     复写方法 findByDay
	  * @param pk
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.holiday.dao.HolidayDao#findByDay(java.lang.String, java.sql.Connection)
	 */
	public String findByDay(String pk, Connection conn) throws Exception {
		String isSet = "";
		PreparedDBUtil pd = new PreparedDBUtil();
	    String sqlstr = "select holiday from td_sp_holiday where holiday='" + pk + "'";
	    pd.preparedSelect(sqlstr);
	    pd.executePrepared(conn);
	    if (pd.size() != 0) {
	      isSet = "checked";
	    }
	    return isSet;
	}

}
