package com.chinacreator.xtbg.core.holiday.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.holiday.dao.DailyDao;
import com.chinacreator.xtbg.core.holiday.entity.Daily;
/**
 * 
 *<p>Title:DailyDaoImpl.java</p>
 *<p>Description:作息时间管理接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-22
 */
public class DailyDaoImpl extends XtDbBaseDao implements DailyDao {

	/**
	 * 
	  * <b>Summary:查询作息时间列表信息 </b>
	  *     复写方法 selDailyList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.holiday.dao.DailyDao#selDailyList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selDailyList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			conn = DbManager.getInstance().getConnection();
			
			String sqlstr = "select work_id,begin_date||' 至 '||end_date work_date, decode(am_begin_time,'00:00','休息',am_begin_time||' - '||am_end_time ) work_am_time,decode(pm_begin_time,'00:00','休息',pm_begin_time||' - '||pm_end_time) work_pm_time,REMARK,to_char(last_modify_time,'yyyy-mm-dd hh24:mi')last_modify_time from tb_workdate order by to_date(begin_date,'yyyy-mm-dd')";
			
			pb = queryToPagingBean(sqlstr, offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: 根据id查询工作时间的基本信息</b>
	  *     复写方法 findDailyByWorkId
	  * @param workId
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.holiday.dao.DailyDao#findDailyByWorkId(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> findDailyByWorkId(String workId,Connection conn) throws Exception {
		Map<String, String> mapbean=new HashMap<String, String>();
		String sql = "select * from tb_workdate where work_id=? ";
		mapbean=queryToSingleMap(conn, sql,workId);
		return mapbean;
	}

	/**
	 * 
	  * <b>Summary: 判断改工作日期是否冲突</b>
	  *     复写方法 findAcross
	  * @param daily
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.holiday.dao.DailyDao#findAcross(com.chinacreator.xtbg.core.holiday.entity.Daily, java.sql.Connection)
	 */
	public String findAcross(Daily daily, Connection conn) throws Exception {
		String msg="";
		StringBuffer sqlString = new StringBuffer("");
	    sqlString.append("select  wmsys.wm_concat(begin_date||'至'||end_date) as msg from tb_workdate where ((to_date(begin_date, 'yyyy-mm-dd') > to_date('" + daily.getBegin_date() + "', 'yyyy-mm-dd') ");
	    sqlString.append(" and to_date(begin_date, 'yyyy-mm-dd') <= to_date('" + daily.getEnd_date() + "', 'yyyy-mm-dd'))");
	    sqlString.append(" or (to_date(end_date, 'yyyy-mm-dd') >= to_date('" + daily.getBegin_date() + "', 'yyyy-mm-dd')");
	    sqlString.append(" and to_date(end_date, 'yyyy-mm-dd') <= to_date('" + daily.getEnd_date() + "', 'yyyy-mm-dd'))");
	    sqlString.append(" or (to_date(begin_date, 'yyyy-mm-dd') <= to_date('" + daily.getBegin_date() + "', 'yyyy-mm-dd')");
	    sqlString.append(" and to_date(end_date, 'yyyy-mm-dd') >= to_date('" + daily.getEnd_date() + "', 'yyyy-mm-dd')))");
	    if (!StringUtil.isBlank(daily.getWork_id())) {
	      sqlString.append("and work_id <> '" + daily.getWork_id() + "'");
	    }
	    Map<String, String> map= queryToSingleMap(conn, sqlString.toString());
	    msg=map.get("msg");
		return msg;
	}

}
