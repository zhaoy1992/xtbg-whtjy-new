package com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class LeaveSaveDaoImpl extends XtDbBaseDao implements FlowBusiDataSaveDao {

	@Override
	public boolean saveBusiInfo(HttpServletRequest request, Connection conn)
			throws Exception {
		//当前环节
		String action_defid = request.getParameter("action_defid");
		String nextid= request.getParameter("nextid");
		String t_type = request.getParameter("TA_OA_ATTENDANCELEAVE__T_TYPE");
		String start_time=request.getParameter("TA_OA_ATTENDANCELEAVE__T_STARTTIME");
		String end_time=request.getParameter("TA_OA_ATTENDANCELEAVE__T_ENDTIME");
		String t_depart_id=request.getParameter("TA_OA_ATTENDANCELEAVE__T_DEPART_ID");
		String t_depart_name=request.getParameter("TA_OA_ATTENDANCELEAVE__T_DEPART_NAME");
		String t_user_id=request.getParameter("TA_OA_ATTENDANCELEAVE__T_USER_ID");
		String t_name=request.getParameter("TA_OA_ATTENDANCELEAVE__T_NAME");
		String t_data_type=request.getParameter("TA_OA_ATTENDANCELEAVE__T_DATA_TYPE");
		String t_data_value=request.getParameter("TA_OA_ATTENDANCELEAVE__T_DATA_VALUE");
		if("hbtjyqj_wp1_act6".equals(nextid)){
				long difday= DateUtil.getDiffDays(start_time,end_time);
				List<String> dlist =new ArrayList<String>();
			    List<Map<String, String>> listmap=new ArrayList<Map<String,String>>();	
				for ( int i = 0; i <= difday; i++) {
					Date tempday=DateUtil.getDate(start_time, "yyyy-MM-dd");
					String addday=DateUtil.getFormatDateAdd(tempday, i, "yyyy-MM-dd");
					dlist.add(addday);
				}
				dlist=filterHoliday(dlist);
				dlist=filterExit(dlist, t_user_id);
				for (int i = 0; i < dlist.size(); i++) {
					Map<String, String> map=new HashMap<String, String>();
					map.put("t_type",t_type);
					map.put("start_time",start_time.substring(0,10));
					map.put("end_time",end_time.substring(0, 10));
					map.put("t_depart_id",t_depart_id);
					map.put("t_depart_name",t_depart_name);
					map.put("t_user_id",t_user_id);
					map.put("t_name",t_name);
					map.put("datetime", dlist.get(i));
					map.put("t_data_type", t_data_type);
					map.put("t_data_value", t_data_value);
					listmap.add(map);
			   }
				//忽略该记录直接覆盖或修改成当前日期、当前IP、状态为该表单的请假类型
			   deleteRecord(dlist,t_user_id);
			   insertinfo(conn, listmap);
		}
		/*取消销假管理
		else if("bmzyldqj_wp1_act9".equals(nextid)){
			  String cdate= DateUtil.getCurrentDate();
			  long difday= DateUtil.getDiffDays(cdate,end_time);
			  List<String> dlist =new ArrayList<String>();
			  for (int i = 0; i <= difday; i++) {
				Date tempday=DateUtil.getDate(cdate, "yyyy-MM-dd");
				String addday=DateUtil.getFormatDateAdd(tempday, i, "yyyy-MM-dd");
				dlist.add(addday);
			  }
			  deleteRecord(dlist,t_user_id);
		}*/
		return true;
	}
	
	public void insertinfo(Connection conn,List<Map<String, String>> listmap){
		PreparedDBUtil pdb =new PreparedDBUtil();
		StringBuffer sql =new StringBuffer();
		sql.append(" insert into sx_ta_oa_electcheck_info i");
		sql.append(" (elect_id,");
		//sql.append(" start_time,");
		sql.append(" start_ip,");
		//sql.append(" end_time,");
		sql.append(" username,");
		sql.append(" userid,");
		sql.append(" orgid,orgname,depart_name,depart_id,state,datetime");
		sql.append(" )values(seq_sx_electcheck.nextval,?,?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'))");
		
		try {
			for (int j = 0; j < listmap.size(); j++) {
				Map<String, String> map=listmap.get(j);
				int i=1;
				pdb.preparedInsert(sql.toString());
				pdb.setString(i++, map.get("start_ip"));
				pdb.setString(i++, map.get("t_name"));
				pdb.setString(i++, map.get("t_user_id"));
				pdb.setString(i++, map.get("t_depart_id"));
				pdb.setString(i++, map.get("t_depart_name"));
				pdb.setString(i++, map.get("t_depart_name"));
				pdb.setString(i++, map.get("t_depart_id"));
				pdb.setString(i++, map.get("t_type"));
				pdb.setString(i++, map.get("datetime"));
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//过滤假期
	public List<String> filterHoliday(List<String> list){
		PreparedDBUtil pdb =new PreparedDBUtil();
		StringBuffer sql =new StringBuffer();
		List<String> daylist=new ArrayList<String>();
		String strlist="";
		for (int i = 0; i < list.size(); i++) {
			strlist+=list.get(i)+",";
		}
		strlist=","+strlist;
		sql.append(" select * from td_sp_holiday h");
		sql.append(" where instr('"+strlist+"',','||h.holiday||',')>0");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			if(pdb.size()>0){
				for (int i = 0; i < pdb.size(); i++) {
					String holiday = pdb.getString(i, "holiday");
						list.remove(holiday);
				}
			}
			daylist=list;
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return daylist;
	}
	//过滤同用户同日期记录
	public List<String> filterExit(List<String> list,String userid){
		PreparedDBUtil pdb =new PreparedDBUtil();
		StringBuffer sql =new StringBuffer();
		List<String> daylist=new ArrayList<String>();
		sql.append(" select * from sx_ta_oa_electcheck_info t");
		sql.append(" where t.userid='"+userid+"' and t.datetime=to_date(?,'yyyy-mm-dd')");
		try {
			for (int i = 0; i < list.size(); i++) {
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, list.get(i));
				pdb.executePrepared();
				if(pdb.size()>0){
					String datetime= pdb.getString(0, "datetime");
					list.remove(datetime);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	//删除没多余假期考勤记录
	public void deleteRecord(List<String> list,String userid){
		PreparedDBUtil pdb =new PreparedDBUtil();
		StringBuffer sql =new StringBuffer();
		sql.append(" delete sx_ta_oa_electcheck_info t ");
		sql.append(" where t.userid =? and t.datetime=to_date(?,'yyyy-mm-dd') ");
		try {
			for (int j = 0; j < list.size(); j++) {
				int i=1;
				pdb.preparedDelete(sql.toString());
				pdb.setString(i++, userid);
				pdb.setString(i++, list.get(j));
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
