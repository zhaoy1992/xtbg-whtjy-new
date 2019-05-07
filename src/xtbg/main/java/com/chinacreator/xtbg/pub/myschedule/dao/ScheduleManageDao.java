package com.chinacreator.xtbg.pub.myschedule.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


import com.chinacreator.business.common.bean.BusinessBean;
import com.chinacreator.business.common.exception.BusinessException;
//import com.chinacreator.xtbg.androidpc.dao.AndroidCommonDao;
//import com.chinacreator.xtbg.androidpc.dao.impl.AndroidCommonDaoImpl;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class ScheduleManageDao {
	private String select = "select u.user_id, u.user_name, u.user_realname, o.org_id, o.org_name from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id = (select org_id from td_sm_organization b  where b.parent_id = '0' and rownum = 1)   connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id left join td_sm_user u on u.user_id = ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id  where u.user_id is not null and (instr((select ',' || ids || ',' from ta_oa_resources_config where (resources_id = '22') and resources_configtypeid = ? and rownum = 1),  ',' || u.user_id || ',') > 0  or instr((select ',' || ids || ','from ta_oa_resources_config where (resources_id = '21') and resources_configtypeid = ?  and rownum = 1), ',' || u.user_id || ',') > 0 ) or u.user_id=? order by to_number(o.index_sn),  a.same_job_user_sn, u.user_sn";
	private static final String INQUERY_MONTH = " select count(u.user_id) counts,u.user_id,u.user_name,u.user_realname,o.org_id,WM_CONCAT(td.theme)  remark,dates.s_date from  (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org start with org.org_id =  (select org_id from td_sm_organization cd where cd.parent_id = '0') connect by prior org.org_id = org.parent_id  order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id left join td_sm_user u on u.user_id = ou.user_id left join td_sm_userjoborg uod on uod.user_id = ou.user_id left join ta_oa_leaderschedule td on instr(','||td.leader_userid||',',','||u.user_id||',')>0  left join (select to_char(to_date(?, 'yyyy-mm') + (rownum - 1),'yyyy-mm-dd') s_date from dual connect by rownum<=last_day(to_date(?,'yyyy-mm')) - to_date(?,'yyyy-mm')+1) dates   on to_date(to_char(to_date(td.starttime,'yyyy-mm-dd hh24:mi'),'yyyy-mm-dd'),'yyyy-mm-dd')<= to_date(dates.s_date||' 23:59','yyyy-mm-dd hh24:mi') and to_date(to_char(to_date(td.endtime,'yyyy-mm-dd hh24:mi'),'yyyy-mm-dd'),'yyyy-mm-dd')>=to_date(dates.s_date||' 00:00','yyyy-mm-dd hh24:mi') where td.leaderschedule_id is not null  and  dates.s_date is not null and instr(','||?||',',','||u.user_id||',')>0  group by u.user_id,u.user_name,u.user_realname,o.org_id ,index_sn,u.user_sn,uod.same_job_user_sn,dates.s_date order by  index_sn,u.user_sn,uod.same_job_user_sn";
	private static final String INSERT = "insert into ta_oa_leaderschedule(leaderschedule_id	,theme,address,important_level,weather,starttime,endtime	,station_type	,remind_flag	,remind_starttime	,remind_endtime	,remind_interval	,remind_type	,schdule_describe	,leader_name,leader_userid,org_id,org_name,time_unit,createtime) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate)";
	private static final String INQUERY_SG = " select (select '<b>'||edit_user_name||'</b> '||to_char(edittime,'yyyy-mm-dd HH24:mi')||' 进行了'||edittype from ta_oa_leaderschedule_log  where edittime = (select max(edittime) from ta_oa_leaderschedule_log l where td.LEADERSCHEDULE_ID = l.LEADERSCHEDULE_ID)) log, td.*,u.user_realname,u.user_id from ta_oa_leaderschedule td left join td_sm_user u on instr(',' || td.leader_userid || ',', ',' || u.user_id || ',') > 0 where instr(','||?||',', ','||u.user_id||',') >0  and to_date(to_char(to_date(td.starttime, 'yyyy-mm-dd hh24:mi'),'yyyy-mm-dd'), 'yyyy-mm-dd') <= to_date(?,'yyyy-mm-dd hh24:mi') and to_date(to_char(to_date(td.endtime,  'yyyy-mm-dd hh24:mi'),'yyyy-mm-dd'), 'yyyy-mm-dd') >= to_date(?,'yyyy-mm-dd hh24:mi')";
	private static final String INQUERY_SG_NOTIME = "select td.*, u.user_realname, u.user_id from ta_oa_leaderschedule td left join td_sm_user u on instr(',' || td.leader_userid || ',',',' || u.user_id || ',') > 0 where instr(',' || ? || ',', ',' || u.user_id || ',') > 0  order by to_number(td.leaderschedule_id)  desc";
    private static final String INSERT_KEY =" select SEQ_LEADERSCHEDULE.nextval nextfileid from dual";
	//查询节假日列表中的日期  at jia.tong  2013-07-31
    private static final String QUERY_HOLIDAY = "select h.holiday from td_sp_holiday h";
    public Object initUserList(BusinessBean bean) {
		String sql = select;
		ArrayList<Map<String, String>> result = new ArrayList<Map<String, String>>();

		PreparedDBUtil db = new PreparedDBUtil();
		try { 
			db.preparedSelect(sql);
			db.setString(1, bean.getUserID());
			db.setString(2, bean.getUserID());
			db.setString(3, bean.getUserID());
			db.executePrepared();
			Map<String, String> temp = null;
			for (int i = 0; i < db.size(); i++) {
				temp = new HashMap<String, String>();
				temp.put("userID", db.getString(i, "user_id"));
				if (bean.getUserID().equals(db.getString(i, "user_id"))) {
					temp.put("isThis", db.getString(i, "user_id"));
				}
				temp.put("userName", db.getString(i, "user_name"));
				temp.put("userRealName", db.getString(i, "user_realname")); 
				temp.put("orgID", db.getString(i, "org_id"));
				temp.put("orgName", db.getString(i, "org_name"));
				result.add(temp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public void insertSchedule(BusinessBean bean) throws BusinessException {
		String sql = INSERT;
		PreparedDBUtil db = new PreparedDBUtil();
		try {
			db.preparedSelect(INSERT_KEY);
			db.executePrepared();
			String key = db.getString(0, "nextfileid");
			db.preparedInsert(sql);
			int i=1;
			db.setString(i++, key);
			db.setString(i++, bean.getParam("theme"));
			db.setString(i++, bean.getParam("address"));
			db.setString(i++, bean.getParam("level"));
			db.setString(i++, "");
			db.setString(i++, bean.getParam("beginDate"));
			db.setString(i++, bean.getParam("endDate"));
			db.setString(i++, bean.getParam("stationStatus"));
			db.setString(i++, bean.getParam("isCall"));
			db.setString(i++, bean.getParam("callBeginDate"));
			db.setString(i++, bean.getParam("callEndDate"));
			db.setString(i++, bean.getParam("calliInterval"));
			db.setString(i++, bean.getParam("callType"));
			db.setString(i++, bean.getParam("remark"));
			db.setString(i++, bean.getParam("personNames"));
			db.setString(i++, bean.getParam("personIds"));
			db.setString(i++, bean.getUserDeptID());
			db.setString(i++, bean.getUserDeptName());
			db.setString(i++, bean.getParam("dateUnit"));
			db.executePrepared();
			insertLog(key,"新增",bean);
		} catch (SQLException e) {
			throw new BusinessException("EBUSISQL", "");
		}

	}

	public Object searchMonthList(BusinessBean bean) throws BusinessException {
		String sql = INQUERY_MONTH;
		ArrayList<Map<String, String>> result = new ArrayList<Map<String, String>>();

		PreparedDBUtil db = new PreparedDBUtil();
		try {
			db.preparedSelect(sql);
			db.setString(1, bean.getParam("month"));
			db.setString(2, bean.getParam("month"));
			db.setString(3, bean.getParam("month"));
			db.setString(4, bean.getParam("userIDs"));

			db.executePrepared();
			Map<String, String> temp = null;
			for (int i = 0; i < db.size(); i++) {
				temp = new HashMap<String, String>();
				temp.put("userID", db.getString(i, "user_id"));
				if (bean.getUserID().equals(db.getString(i, "user_id"))) {
					temp.put("isThis", db.getString(i, "user_id"));
				}
				temp.put("userName", db.getString(i, "user_name"));
				temp.put("userRealName", db.getString(i, "user_realname"));
				temp.put("count", db.getString(i, "counts"));
				temp.put("day", db.getString(i, "s_date"));
				temp.put("remark", db.getString(i, "remark"));
				temp.put("orgID", db.getString(i, "org_id"));
				result.add(temp);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public Object searchSingleList(BusinessBean bean) throws BusinessException {
		String sql = INQUERY_SG;
		ArrayList<Map<String, String>> result = new ArrayList<Map<String, String>>();

		int index = 1;
		PreparedDBUtil db = new PreparedDBUtil();
		try {
			db.preparedSelect(sql.toString());
			db.setString(index, bean.getParam("userIDs"));
			db.setString(++index, bean.getParam("endtime"));
			db.setString(++index, bean.getParam("starttime"));
			db.executePrepared();
			HashMap<String, String> temp = null;
			for (int i = 0; i < db.size(); i++) {
				temp = new HashMap<String, String>();
				temp.put("id", db.getString(i, "LEADERSCHEDULE_ID"));
				temp.put("theme", db.getString(i, "THEME"));
				temp.put("address", db.getString(i, "ADDRESS"));
				temp.put("level", db.getString(i, "IMPORTANT_LEVEL"));
				temp.put("weather", db.getString(i, "WEATHER"));
				temp.put("startTime", db.getString(i, "STARTTIME"));
				temp.put("endTime", db.getString(i, "ENDTIME"));
				temp.put("stationType", db.getString(i, "STATION_TYPE"));
				temp.put("isCall", db.getString(i, "REMIND_FLAG"));
				temp.put("remindStartTime", db.getString(i, "REMIND_STARTTIME"));
				temp.put("remindEndTime", db.getString(i, "REMIND_ENDTIME"));
				temp.put("remindIntErval", db.getString(i, "REMIND_INTERVAL"));
				temp.put("callType", db.getString(i, "REMIND_TYPE"));
				temp.put("remark", db.getString(i, "SCHDULE_DESCRIBE"));
				temp.put("personNames", db.getString(i, "LEADER_NAME"));
				temp.put("personIds", db.getString(i, "LEADER_USERID"));
				temp.put("orgId", db.getString(i, "ORG_ID"));
				temp.put("orgName", db.getString(i, "ORG_NAME"));
				temp.put("timeUnit", db.getString(i, "TIME_UNIT"));
				temp.put("userID", db.getString(i, "user_id"));
				temp.put("userName", db.getString(i, "user_realname"));
				temp.put("beginDate", db.getString(i, "STARTTIME"));
				temp.put("endDate", db.getString(i, "ENDTIME"));
				temp.put("log", db.getString(i, "log"));
				result.add(temp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 刘为玮
	 * @param bean
	 * @data 2012-12-10
	 * @return
	 * @throws BusinessException
	 */
	public Object mianSearchSingleList(BusinessBean bean) throws BusinessException {
		String sql = INQUERY_SG_NOTIME;
		ArrayList<Map<String, String>> result = new ArrayList<Map<String, String>>();

		int index = 1;
		PreparedDBUtil db = new PreparedDBUtil();
		try {
			db.preparedSelect(sql.toString());
			db.setString(index, bean.getParam("userIDs"));
			db.executePrepared();
			HashMap<String, String> temp = null;
			for (int i = 0; i < db.size(); i++) {
				temp = new HashMap<String, String>();
				temp.put("id", db.getString(i, "LEADERSCHEDULE_ID"));
				temp.put("theme", db.getString(i, "THEME"));
				temp.put("address", db.getString(i, "ADDRESS"));
				temp.put("level", db.getString(i, "IMPORTANT_LEVEL"));
				temp.put("weather", db.getString(i, "WEATHER"));
				temp.put("startTime", db.getString(i, "STARTTIME"));
				temp.put("endTime", db.getString(i, "ENDTIME"));
				temp.put("stationType", db.getString(i, "STATION_TYPE"));
				temp.put("isCall", db.getString(i, "REMIND_FLAG"));
				temp.put("remindStartTime", db.getString(i, "REMIND_STARTTIME"));
				temp.put("remindEndTime", db.getString(i, "REMIND_ENDTIME"));
				temp.put("remindIntErval", db.getString(i, "REMIND_INTERVAL"));
				temp.put("callType", db.getString(i, "REMIND_TYPE"));
				temp.put("remark", db.getString(i, "SCHDULE_DESCRIBE"));
				temp.put("personNames", db.getString(i, "LEADER_NAME"));
				temp.put("personIds", db.getString(i, "LEADER_USERID"));
				temp.put("orgId", db.getString(i, "ORG_ID"));
				temp.put("orgName", db.getString(i, "ORG_NAME"));
				temp.put("timeUnit", db.getString(i, "TIME_UNIT"));
				temp.put("userID", db.getString(i, "user_id"));
				temp.put("userName", db.getString(i, "user_realname"));
				temp.put("beginDate", db.getString(i, "STARTTIME"));
				temp.put("endDate", db.getString(i, "ENDTIME"));
				result.add(temp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* queryHoliday(得到节假日的所有日期用于改变节假日日期的颜色)
	* @param bean
	* @return
	* @author jia.tong  2013-07-31
	* 
	 */
	public Object queryHoliday(BusinessBean bean) {
		String sql = QUERY_HOLIDAY;
		ArrayList<Map<String, String>> result = new ArrayList<Map<String, String>>();

		PreparedDBUtil db = new PreparedDBUtil();
		try { 
			db.preparedSelect(sql);
			db.executePrepared();
			Map<String, String> temp = null;
			for (int i = 0; i < db.size(); i++) {
				temp = new HashMap<String, String>();
				temp.put("holiday", db.getString(i, "holiday"));
				result.add(temp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	private static final String DELETE = "delete ta_oa_leaderschedule where LEADERSCHEDULE_ID=?";

	public void delete(BusinessBean bean) throws BusinessException {
		String sql = DELETE;
		if (rule(bean) == 0) {
			throw new BusinessException("ERRAUTH", "");
		}
		PreparedDBUtil db = new PreparedDBUtil();
		try {
			db.preparedDelete(sql);
			db.setString(1, bean.getParam("id"));
			db.executePrepared();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static final String RULE = "select count(t.resources_configid) nums from ta_oa_resources_config t where instr(','||t.ids||',',','||?||',')  > 0 and t.resources_id='21' and t.resources_configtypeid=?";

	public int rule(BusinessBean bean) throws BusinessException {
		PreparedDBUtil db = new PreparedDBUtil();
		int result = 0;
		if (bean.getUserID().equals(bean.getParam("modflyUserID"))) {
			return 1;
		}
		try {
			db.preparedSelect(RULE);
			db.setString(1, bean.getParam("modflyUserID"));
			db.setString(2, bean.getUserID());
			db.executePrepared();
			if (db.size() > 0)
				result = db.getInt(0, "nums");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	private static final String UPDATE = "update  ta_oa_leaderschedule set THEME=?,ADDRESS=?,IMPORTANT_LEVEL=?,WEATHER=?,STARTTIME=?,ENDTIME=?,STATION_TYPE=?,REMIND_FLAG=?,REMIND_STARTTIME=?,REMIND_ENDTIME=?,REMIND_INTERVAL=?,REMIND_TYPE=?,SCHDULE_DESCRIBE=?,LEADER_NAME=?,LEADER_USERID=?,ORG_ID=?,ORG_NAME=?,TIME_UNIT =? where LEADERSCHEDULE_ID=?";

	public void update(BusinessBean bean) throws BusinessException {
		String sql = UPDATE;
		if (rule(bean) == 0) {
			throw new BusinessException("ERRAUTH", "");
		}
		PreparedDBUtil db = new PreparedDBUtil();
		try {
			db.preparedUpdate(sql);
			db.setString(1, bean.getParam("theme"));
			db.setString(2, bean.getParam("address"));
			db.setString(3, bean.getParam("level"));
			db.setString(4, "");
			db.setString(5, bean.getParam("beginDate"));
			db.setString(6, bean.getParam("endDate"));
			db.setString(7, bean.getParam("stationStatus"));
			db.setString(8, bean.getParam("isCall"));
			db.setString(9, bean.getParam("callBeginDate"));
			db.setString(10, bean.getParam("callEndDate"));
			db.setString(11, bean.getParam("calliInterval"));
			db.setString(12, bean.getParam("callType"));
			db.setString(13, bean.getParam("remark"));
			db.setString(14, bean.getParam("personNames"));
			db.setString(15, bean.getParam("personIds"));
			db.setString(16, bean.getUserDeptID());
			db.setString(17, bean.getUserDeptName());
			db.setString(18, bean.getParam("dateUnit"));
			db.setString(19, bean.getParam("id"));
			db.executePrepared();
			insertLog(bean.getParam("id"),"修改",bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private static final String INSERT_LOG = "INSERT INTO ta_oa_leaderschedule_LOG (LEADERSCHEDULE_ID,THEME,ADDRESS,IMPORTANT_LEVEL, WEATHER, STARTTIME, ENDTIME, STATION_TYPE,REMIND_FLAG , REMIND_STARTTIME,REMIND_ENDTIME ,REMIND_INTERVAL,REMIND_TYPE,SCHDULE_DESCRIBE ,LEADER_NAME,LEADER_USERID,ORG_ID,TIME_UNIT,EDITTIME,EDIT_USER_NAME,EDITTYPE) SELECT LEADERSCHEDULE_ID ,THEME, ADDRESS,IMPORTANT_LEVEL ,WEATHER,STARTTIME,ENDTIME,STATION_TYPE,REMIND_FLAG,REMIND_STARTTIME, REMIND_ENDTIME,REMIND_INTERVAL,REMIND_TYPE,SCHDULE_DESCRIBE,LEADER_NAME,LEADER_USERID,ORG_ID,TIME_UNIT,SYSDATE,?,? from ta_oa_leaderschedule where LEADERSCHEDULE_ID=?";
	public void insertLog(String id,String type,BusinessBean bean){
		PreparedDBUtil db = new PreparedDBUtil();
		try {
			db.preparedInsert(INSERT_LOG);
			int i=1;
			db.setString(i++, bean.getUserName());
			db.setString(i++, type);
			db.setString(i++, id);
			db.executePrepared();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static final String SELECT_LOG = "select LEADERSCHEDULE_ID,THEME,ADDRESS,IMPORTANT_LEVEL, WEATHER, STARTTIME, ENDTIME, STATION_TYPE,REMIND_FLAG , REMIND_STARTTIME,REMIND_ENDTIME ,REMIND_INTERVAL,REMIND_TYPE,SCHDULE_DESCRIBE ,LEADER_NAME,LEADER_USERID,ORG_ID,TIME_UNIT,TO_CHAR(EDITTIME, 'YYYY-MM-DD HH24:MI:SS') edittimes,EDIT_USER_NAME,EDITTYPE from ta_oa_leaderschedule_LOG where LEADERSCHEDULE_ID=? order by EDITTIME desc";
	public Object selectLog(BusinessBean bean){
		ArrayList<Map<String, String>> result = new ArrayList<Map<String, String>>();

		PreparedDBUtil db = new PreparedDBUtil();
		try {
			db.preparedSelect(SELECT_LOG);
			db.setString(1, bean.getParam("id"));
			db.executePrepared();
			HashMap<String, String> temp = null;
			for (int i = 0; i < db.size(); i++) {
				temp = new HashMap<String, String>();
				temp.put("text",  "<li><b>"+db.getString(i, "edit_user_name")+"</b>" +" "+db.getString(i, "edittimes")+" 进行了"+db.getString(i, "edittype")+" </li>");
				temp.put("title","主题："+db.getString(i, "theme")+"\n参与者："+db.getString(i, "LEADER_NAME")+"\n 地址："+db.getString(i, "address")+"\n 时间："+db.getString(i, "STARTTIME")+" - "+db.getString(i, "ENDTIME")+"\n 备注："+db.getString(i, "SCHDULE_DESCRIBE"));
				result.add(temp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
		
	}

}
