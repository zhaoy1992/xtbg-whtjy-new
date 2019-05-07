package com.chinacreator.xtbg.waitDoWork.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.waitDoWork.dao.HomeBusinessDao;
import com.chinacreator.xtbg.waitDoWork.entity.ToDoWorkListBean;
import com.chinacreator.xtbg.waitDoWork.entity.ToDoWorkSearchBean;
import com.chinacreator.xtbg.pub.util.StringUtil;

import com.frameworkset.common.poolman.PreparedDBUtil;

public class HomeBusinessDaoImpl implements HomeBusinessDao {

	@Override
	public PagingBean getToDoWorkList(ToDoWorkSearchBean toDoWorkSearchBean,
			ToDoWorkListBean tdwlBean1,String sortName, String sortOrder, long offset, int maxPagesize)
			throws SQLException {
		PagingBean pb = new PagingBean();
	    PreparedDBUtil db = new PreparedDBUtil();
	    List<ToDoWorkListBean> list = new ArrayList<ToDoWorkListBean>();
		StringBuffer sql = new StringBuffer();
		if("waitingapproval".equals(toDoWorkSearchBean.getListtype())){
			sql = getWaiting4ApprovalSql(toDoWorkSearchBean,tdwlBean1);
		}else if("waitingread".equals(toDoWorkSearchBean.getListtype())){
			sql = getWaiting4ReadSql(toDoWorkSearchBean,tdwlBean1);
		}
	
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			
			db.executePrepared();
			for(int i=0 ; i < db.size() ; i++){
				ToDoWorkListBean tdwlBean = new ToDoWorkListBean();
				tdwlBean.setPri_id(db.getString(i, "pri_id"));
				tdwlBean.setInfo_type(db.getString(i, "info_type"));
				tdwlBean.setStart_time(db.getString(i, "start_time"));
				tdwlBean.setWork_name(db.getString(i, "work_name"));
				tdwlBean.setInfo_state(db.getString(i, "info_state"));
				tdwlBean.setInput_user(db.getString(i, "input_user"));
				tdwlBean.setNotice_state(db.getString(i,"notice_state"));
				tdwlBean.setFk_id(db.getString(i,"fk_id"));//外键ID
				tdwlBean.setM_check_flag_name(db.getString(i,"m_check_flag_name"));//会议审批中的会议状态名称
				tdwlBean.setM_check_flag(db.getString(i,"m_check_flag"));//会议审批中的会议状态
				tdwlBean.setM_reg_user_id(db.getString(i,"m_reg_user_id"));//会议审批中的管理员ID
				tdwlBean.setM_reg_user_name(db.getString(i,"m_reg_user_name"));//会议审批中的管理员
				tdwlBean.setM_is_need_signup(db.getString(i,"m_is_need_signup"));//报名截止日期
				tdwlBean.setM_close_time(db.getString(i,"m_close_time"));//是否需要报名（0否1是，默认不报名）
				
				list.add(tdwlBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}
	
	
	@Override
	public int getToDoWorkListTotal(ToDoWorkSearchBean toDoWorkSearchBean,ToDoWorkListBean tdwlBean1)
			throws SQLException {
		PagingBean pb = new PagingBean();
	    PreparedDBUtil db = new PreparedDBUtil();
	    int infoTotal = 0;
		StringBuffer sql = new StringBuffer();
		if("waitingapproval".equals(toDoWorkSearchBean.getListtype())){
			sql = getWaiting4ApprovalSql(toDoWorkSearchBean,tdwlBean1);
		}else if("waitingread".equals(toDoWorkSearchBean.getListtype())){
			sql = getWaiting4ReadSql(toDoWorkSearchBean,tdwlBean1);
		}
		
		try {
			db.preparedSelect(sql.toString());
			db.executePrepared();
			infoTotal = db.size();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return infoTotal;
	}

	/**
	 * 根据参数获取首页待办处理的sql
	 * @param toDoWorkSearchBean
	 * @return
	 */
	public StringBuffer getWaiting4ApprovalSql(ToDoWorkSearchBean toDoWorkSearchBean,ToDoWorkListBean tdwlBean1){
		StringBuffer sql = new StringBuffer();
		//获得当前用户部门ID
		UserCacheBean userBean= UserCache.getUserCacheBean(toDoWorkSearchBean.getInputuser_id());
		String dept_id = userBean.getUnit_id();
		if(tdwlBean1!=null){
			if("信息审批".equals(tdwlBean1.getInfo_type())){
				sql.append("select * ");
				sql.append("  from (select distinct (t.submittedinfo_id) pri_id, ");
				sql.append("                        t.submittedinfo_title work_name, ");
				sql.append("                       to_char(t.input_date,'yyyy-mm-dd hh24:mi') start_time, ");
				sql.append("                        t.inputuser_name input_user, ");
				sql.append("                        u.andit_state info_state, ");
				sql.append("                        '信息审批' as info_type,  ");
				sql.append("   '' as notice_state, ");
				sql.append("   u.andit_state as m_check_flag, ");
				sql.append("   1 as rsn, ");
				sql.append("   ''as status ");
				sql.append("          from ta_oa_infre_submitted_info t ");
				sql.append("         inner join ta_oa_infre_audit u on u.submittedinfo_id = ");
				sql.append("                                           t.submittedinfo_id ");
				sql.append("         inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode = ");
				sql.append("                                                        to_number(u.andit_state) ");
				sql.append("         inner join td_sm_organization o on o.org_id = t.department_id ");
				sql.append("         where u.andit_person_id = '"+toDoWorkSearchBean.getInputuser_id()+"' ");
				sql.append("           and u.andit_state in ('3','11', '12', '14') ");
				sql.append(") tt ");
			}
			if("派车审批".equals(tdwlBean1.getInfo_type())){
				sql.append("	select f.use_name ,");
				sql.append("    f.use_id ,");
				sql.append("    u.user_realname input_user,");
				sql.append("    '派车审批' info_type,");
				sql.append("   f.apply_id pri_id,");
				sql.append("   f.use_reason work_name,");
				sql.append("   f.use_starttime ,");
				sql.append("   f.use_endtime,");
				sql.append("   to_char(f.sqrq,'yyyy-mm-dd HH24:mi') start_time,");
				sql.append("  f.car_id,");
				sql.append("  (select r.car_num");
				sql.append("     from YMJ_OA_CARMANAGE_CAR r");
				sql.append("   where f.car_id = r.car_id) car_num,");
				sql.append("  decode(f.state,");
				sql.append("       1,");
				sql.append("      '等待分配',");
				sql.append("       2,");
				sql.append("      '审批通过',");
				sql.append("      3,");
				sql.append("      '审批未通过',");
				sql.append("       4,");
				sql.append("       '等待审批',");
				sql.append("      5,");
				sql.append("     '派车结束') state");
				sql.append("  from YMJ_OA_CARMANAGE_APPLYINFO f left join td_sm_user u");
				sql.append("  on f.apply_personid=u.user_id ");
				sql.append(" where");
				sql.append("   state = '4'");
				sql.append("  and (select count(user_id) from td_sm_userrole r left join td_sm_role t");
				sql.append("   on r.role_id=t.role_id");
				sql.append("   where r.user_id= '"+toDoWorkSearchBean.getInputuser_id()+"' and t.role_name in ('车辆审批角色'))>0");
				sql.append(" order by start_time desc ");
			}
			if("会议审批".equals(tdwlBean1.getInfo_type())){
				sql.append("	select * from (");
			    sql.append("    select t.m_notice_id as pri_id,");
			    sql.append("    t.m_title as work_name,");
			    sql.append("    to_char(t.m_begin_time,'yyyy-mm-dd hh24:mi') as start_time,");
			    sql.append("     '会议审核' info_type,");
			    sql.append("     t.m_create_user_name as input_user,");
			    sql.append("    t.m_check_flag_name as m_check_flag_name,");
			    sql.append("    t.m_check_flag as m_check_flag,");
			    sql.append("    r.m_reg_user_id as m_reg_user_id,");
			    sql.append("    r.m_reg_user_name as m_reg_user_name,");
			    
			    sql.append("	r.administrator_ids,");
			    sql.append("	r.administrator_names,");
			    sql.append("	decode(t.m_is_need_signup,");
			    sql.append("	'0',");
			    sql.append("	'',");
			    sql.append("	((select count(*)");
			    sql.append("	from oa_meeting_receiver_user u");
			    sql.append("	where u.m_notice_id = t.m_notice_id");
			    sql.append("	and u.m_is_other is null");
			    sql.append("	and u.m_is_reply IN ('1', '2', '3')) || '/' ||");
			    sql.append("	(select count(*)");
			    sql.append("	from oa_meeting_receiver_user u");
			    sql.append("	where u.m_notice_id = t.m_notice_id");
			    sql.append("	and u.m_is_other is null))) signup_percent,");
			    sql.append("	((select count(*)");
			    sql.append("	from oa_meeting_receiver_user u");
			    sql.append("	where u.m_notice_id = t.m_notice_id");
			    sql.append("	and u.m_is_other is null");
			    sql.append("	and u.m_is_read = '1') || '/' ||");
			    sql.append("	(select count(*)");
			    sql.append("	from oa_meeting_receiver_user u");
			    sql.append("	where u.m_notice_id = t.m_notice_id");
			    sql.append("	and u.m_is_other is null)) read_percent");
			    sql.append("	from oa_meeting_notice t, oa_meeting_room r");
			    sql.append("	where t.m_room_id = r.m_room_id(+)");
			    sql.append("	and ',' || r.administrator_ids || ',' like '%,"+toDoWorkSearchBean.getInputuser_id()+",%'");
			    sql.append("	and (t.m_check_flag = '0')");
			    sql.append("	order by m_title desc");
			    sql.append("   )");
			}
			if("借阅审批".equals(tdwlBean1.getInfo_type())){
				
				sql.append("	select * from (");
				sql.append(" select distinct (t.t_regb_id) pri_id,");
				sql.append("                t.t_regb_user_id,");
				sql.append("                t.t_regb_user_name as input_user,");
				sql.append("                to_char(t.t_regb_date, 'yyyy-MM-dd') start_time,");
				sql.append("                '借阅审批' as info_type, ");
				sql.append("                t.t_regb_bookids,");
				sql.append("                t.t_regb_org_id,");
				sql.append("                t.t_regb_org_name,");
				sql.append("                t.t_regb_dept_id,");
				sql.append("                t.t_regb_dept_name,");
				sql.append("                t.t_regb_state,");
				sql.append("                to_char(t.t_regb_gh_date, 'yyyy-MM-dd') t_regb_gh_date,");
				sql.append("                to_char(t.t_regb_booknames) as work_name,");
				sql.append("                t.t_regb_iskonw,");
				sql.append("                to_char(t.t_regb_jy_date, 'yyyy-MM-dd') t_regb_jy_date,");
				sql.append("                to_char(t.t_regb_truegh_date, 'yyyy-MM-dd') t_regb_truegh_date,");
				sql.append("                t.t_regb_isxj,");
				sql.append("                t.t_regb_sqtype");
				sql.append("  from TA_OA_REGBOOK t");
				sql.append(" where 1 = 1");
				sql.append("   and (t_regb_state = '1')");
				sql.append("   and t_regb_dept_id = '"+dept_id+"'");
				sql.append("  and (select count(user_id) from td_sm_userrole r left join td_sm_role t");
				sql.append("   on r.role_id=t.role_id");
				sql.append("   where r.user_id= '"+toDoWorkSearchBean.getInputuser_id()+"' and t.role_name in ('图书管理员'))>0");
				sql.append(" order by t_regb_date desc");
			    sql.append("   ) ");
			}
		}
		if(StringUtil.nullOrBlank(tdwlBean1.getInfo_type())||"--请选择--".equals(tdwlBean1.getInfo_type())){
			sql.append("  select * ");
			sql.append("  from (");
			//会议审批
				sql.append(" select pri_id, info_type,work_name ,input_user ,start_time,m_check_flag_name,m_check_flag,m_reg_user_id,m_reg_user_name  ");
				sql.append("    from(    ");
				sql.append("        select t1.m_notice_id as pri_id,");
				sql.append("               '会议审批' info_type,");
				sql.append("               t1.m_title work_name,");
				sql.append("               t1.m_create_user_name input_user,");
			    sql.append("   			   t1.m_check_flag_name as m_check_flag_name,");
			    sql.append("    		   t1.m_check_flag as m_check_flag,");
			    sql.append("    		   r.m_reg_user_name as m_reg_user_name,");
				sql.append("               to_char( t1.m_begin_time, 'yyyy-mm-dd hh24:mi') start_time,");
				sql.append("              ");
				sql.append("               r.m_reg_user_id,");
				sql.append("               r.administrator_names");
				sql.append("          from oa_meeting_notice t1, oa_meeting_room r");
				sql.append("         where t1.m_room_id = r.m_room_id(+)");
				sql.append("           and ',' || r.administrator_ids || ',' like '%,"+toDoWorkSearchBean.getInputuser_id()+",%'");
				sql.append("           and (t1.m_check_flag = '0')");
				sql.append("         order by t1.m_title desc)) ");
			
				//信息审批
				sql.append("        union all");
				sql.append("        select pri_id,info_type,work_name,input_user,start_time,'' m_check_flag_name,m_check_flag,'' m_reg_user_id,'' m_reg_user_name  ");
				sql.append(" 		 from (select distinct (t.submittedinfo_id) pri_id, ");
				sql.append("                        t.submittedinfo_title work_name, ");
				sql.append("                       to_char(t.input_date,'yyyy-mm-dd hh24:mi') start_time, ");
				sql.append("                        t.inputuser_name input_user, ");
				sql.append("                        u.andit_state info_state, ");
				sql.append("                        '信息审批' as info_type,  ");
				sql.append("   ''as notice_state, ");
				sql.append("   u.andit_state as m_check_flag, ");
				sql.append("   1 as rsn, ");
				sql.append("   ''as status ");
				sql.append("          from ta_oa_infre_submitted_info t ");
				sql.append("         inner join ta_oa_infre_audit u on u.submittedinfo_id = ");
				sql.append("                                           t.submittedinfo_id ");
				sql.append("         inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode = ");
				sql.append("                                                        to_number(u.andit_state) ");
				sql.append("         inner join td_sm_organization o on o.org_id = t.department_id ");
				sql.append("         where u.andit_person_id = '"+toDoWorkSearchBean.getInputuser_id()+"' ");
				sql.append("           and u.andit_state in ('3','11', '12', '14') ");
				sql.append("         )");
				//借阅审批
				sql.append("        union all");
				sql.append("        select pri_id,info_type,work_name,input_user,start_time,'' m_check_flag_name,'' m_check_flag,'' m_reg_user_id,'' m_reg_user_name  ");
				sql.append(" 		 from ( ");
				sql.append("			select distinct (t.t_regb_id) pri_id,");
				sql.append("                t.t_regb_user_id,");
				sql.append("                t.t_regb_user_name as input_user,");
				sql.append("                to_char(t.t_regb_date, 'yyyy-MM-dd') start_time,");
				sql.append("                '借阅审批' as info_type, ");
				sql.append("                t.t_regb_bookids,");
				sql.append("                t.t_regb_org_id,");
				sql.append("                t.t_regb_org_name,");
				sql.append("                t.t_regb_dept_id,");
				sql.append("                t.t_regb_dept_name,");
				sql.append("                t.t_regb_state,");
				sql.append("                to_char(t.t_regb_gh_date, 'yyyy-MM-dd') t_regb_gh_date,");
				sql.append("                to_char(t.t_regb_booknames) as work_name,");
				sql.append("                t.t_regb_iskonw,");
				sql.append("                to_char(t.t_regb_jy_date, 'yyyy-MM-dd') t_regb_jy_date,");
				sql.append("                to_char(t.t_regb_truegh_date, 'yyyy-MM-dd') t_regb_truegh_date,");
				sql.append("                t.t_regb_isxj,");
				sql.append("                t.t_regb_sqtype");
				sql.append("  	from TA_OA_REGBOOK t");
				sql.append(" 	where 1 = 1");
				sql.append("   and (t_regb_state = '1')");
				sql.append("   and t_regb_dept_id = '"+dept_id+"'");
				sql.append("  and (select count(user_id) from td_sm_userrole r left join td_sm_role t");
				sql.append("   on r.role_id=t.role_id");
				sql.append("   where r.user_id= '"+toDoWorkSearchBean.getInputuser_id()+"' and t.role_name in ('图书管理员'))>0");
				sql.append(" 	order by t_regb_date desc");
				sql.append("         )");

				//派车审批
				sql.append("        union all");
				sql.append("        select pri_id,info_type,work_name,input_user,start_time,'' m_check_flag_name,'' m_check_flag,'' m_reg_user_id,'' m_reg_user_name   from (");
				sql.append("        select f.use_name,");
				sql.append("               f.use_id,");
				sql.append("               u.user_realname input_user,");
				sql.append("               '派车审批' info_type,");
				sql.append("               f.apply_id pri_id,");
				sql.append("               f.use_reason work_name,");
				sql.append("               f.use_starttime,");
				sql.append("               f.use_endtime,");
				sql.append("               to_char(f.sqrq, 'yyyy-mm-dd HH24:mi') start_time,");
				sql.append("               f.car_id,");
				sql.append("               (select r.car_num");
				sql.append("                  from YMJ_OA_CARMANAGE_CAR r");
				sql.append("                 where f.car_id = r.car_id) car_num,");
				sql.append("               decode(f.state,");
				sql.append("                      1,");
				sql.append("                      '等待分配',");
				sql.append("                      2,");
				sql.append("                      '审批通过',");
				sql.append("                      3,");
				sql.append("                      '审批未通过',");
				sql.append("                      4,");
				sql.append("                      '等待审批',");
				sql.append("                      5,");
				sql.append("                      '派车结束') state");
				sql.append("          from YMJ_OA_CARMANAGE_APPLYINFO f");
				sql.append("          left join td_sm_user u on f.apply_personid = u.user_id");
				sql.append("         where state = '4'");
				sql.append("           and (select count(user_id)");
				sql.append("                  from td_sm_userrole r");
				sql.append("                  left join td_sm_role t on r.role_id = t.role_id");
				sql.append("                 where r.user_id = '"+toDoWorkSearchBean.getInputuser_id()+"'");
				sql.append("                   and t.role_name in ('车辆审批角色')) > 0");
				sql.append("         order by start_time desc ");
			
			sql.append(" )tt ");
			sql.append(" where tt.pri_id is not null ");
		}
		return sql;
	}
	
	/**
	 * 根据参数获取首页阅读的sql
	 * @param toDoWorkSearchBean
	 * @return
	 */
	public StringBuffer getWaiting4ReadSql(ToDoWorkSearchBean toDoWorkSearchBean,ToDoWorkListBean tdwlBean1){
		StringBuffer sql = new StringBuffer();	
		if(tdwlBean1!=null){
			if("公告查看".equals(tdwlBean1.getInfo_type())){
				sql.append(" select b.n_notice_id pri_id,");
				sql.append("       b.n_title work_name,");
				sql.append("       '公告查看' info_type,");
				sql.append("       b.n_release_username input_user,");
				sql.append("       to_char(b.n_release_time,'yyyy-mm-dd hh24:mi') start_time,  r.n_receiverid fk_id,");
				sql.append("       b.n_orgname,");
				sql.append("       b.n_release_userid,");
				sql.append("       decode(r.n_isview, '0', '未查看', '1', '已查看', '2', '撤销') as n_state");
				sql.append("  from oa_notice_baseinfo b, oa_notice_receiver_user r");
				sql.append(" where r.n_notice_id = b.n_notice_id");
				sql.append("   and b.n_state in (1, 2)");
				sql.append("   and r.n_isdel != '1' and r.n_isview ='0' ");
				sql.append("   and r.n_receiver_userid =  '"+toDoWorkSearchBean.getInputuser_id()+"'");
				sql.append(" order by n_release_time desc");
			}
			if("会议通知查看".equals(tdwlBean1.getInfo_type())){
				sql.append("select                 t.m_notice_id pri_id,");
				sql.append("                       '会议通知查看' info_type,");
				sql.append("                       to_char(t.m_begin_time, 'yyyy-mm-dd hh24:mi') start_time,");
				sql.append("                       t.m_title work_name,");
				sql.append("                       t.m_create_user_name input_user,");
				sql.append("                       t.m_check_flag m_check_flag,");
				sql.append("                       t.m_check_flag_name m_check_flag_name,");
				sql.append("                       t.m_is_need_signup m_is_need_signup,");
				sql.append("                       u.m_receiver_id fk_id,");
				sql.append("                       u.m_is_read,");
				sql.append("                       to_char(t.m_close_time, 'yyyy/mm/dd hh24:mi:ss') m_close_time,");
				sql.append("                       r.m_reg_user_id m_reg_user_id,");
				sql.append("                       r.m_reg_user_name m_reg_user_name,");
				sql.append("                       r.administrator_ids,");
				sql.append("                       r.administrator_names");
				sql.append("                  from oa_meeting_notice        t,");
				sql.append("                       oa_meeting_room          r,");
				sql.append("                       oa_meeting_receiver_user u");
				sql.append("                 where t.m_room_id = r.m_room_id(+)");
				sql.append("                   and t.m_notice_id = u.m_notice_id");
				sql.append("                   and u.m_receiver_user_id = '"+toDoWorkSearchBean.getInputuser_id()+"'");
				sql.append("                   and to_date(to_char(t.m_begin_time,");
				sql.append("                                       'yyyy/mm/dd hh24:mi:ss'),");
				sql.append("                               'yyyy/mm/dd hh24:mi:ss') >=");
				sql.append("                       to_date('2013-09-24 00:00:01', 'yyyy/mm/dd hh24:mi:ss')");
				sql.append("                   and (t.m_check_flag ='4'  or t.m_check_flag = '5')");
				sql.append("                   and u.m_is_read = '0'");
				sql.append("                 order by m_title desc");
			}
			if("信息报送".equals(tdwlBean1.getInfo_type())){
				sql.append("	select * from (select distinct (t.submittedinfo_id) pri_id,");
				sql.append("       t.submittedinfo_title work_name,");
				sql.append("     to_char(t.input_date,'yyyy-mm-dd hh24:mi') start_time,");
				sql.append("       '信息报送' info_type,");
				sql.append("    t.inputuser_id,");
				sql.append("     t.inputuser_name input_user,");
				sql.append("      t.department_id,");
				sql.append("     o.org_name,");
				sql.append("     t.is_recommend,");
				sql.append("     u.andit_state,");
				sql.append("     b.submittedinfo_typename,");
				sql.append("    (select max(a.andit_time)");
				sql.append("      from ta_oa_infre_audit a");
				sql.append("      where a.submittedinfo_id = t.submittedinfo_id");
				sql.append("      and a.andit_state = '6'");
				sql.append("      group by a.submittedinfo_id) release_time,");
				sql.append("   t.infotype_id");
				sql.append("    from ta_oa_infre_submitted_info t");
				sql.append("  inner join ta_oa_infre_audit u on u.submittedinfo_id =");
				sql.append("                            t.submittedinfo_id");
				sql.append("  inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode =");
				sql.append("                                        to_number(u.andit_state)");
				sql.append("   inner join td_sm_organization o on o.org_id = t.department_id");
				sql.append(" where u.andit_person_id = "+toDoWorkSearchBean.getInputuser_id());
				sql.append("   and u.andit_state in ('7', '8', '9')) tt");
				sql.append(" where  submittedinfo_typename = '未查看'");
				sql.append(" order by start_time desc");
			}
			if("电子邮件".equals(tdwlBean1.getInfo_type())){
				sql.append("	select tt.mid as pri_id,						");
				sql.append("	       tt.sendpid,								");
				sql.append("	       tt.sendpname 	as 	input_user,			");
				sql.append("	       tt.title as work_name,					");
				sql.append("	       decode(t.readstate, '0', '未读', '1', '已读', '') as readstate,	");
				sql.append("	       tt.createtime  as start_time,			");
				sql.append("	       '电子邮件'  as info_type					");
				sql.append("	  from ymj_oa_user_mail t, ymj_oa_jbxx_mail tt	");
				sql.append("	 where 1 = 1									");
				sql.append("	   and t.mid = tt.mid							");
				sql.append("	   and t.receivepid =							");
				sql.append(toDoWorkSearchBean.getInputuser_id());
				sql.append("   		and (tt.state = '1' or tt.state = '-1')		");
				sql.append("   		and t.readstate = '0'						");
				sql.append("	 order by createtime desc						");
			}
			if("交办的任务".equals(tdwlBean1.getInfo_type())){
				sql.append("select a.id as pri_id,");
				sql.append("       a.task_name as work_name,");
				sql.append("        '交办的任务' info_type,");
				sql.append("       to_char(a.start_time, 'yyyy-mm-dd hh24:mi') as start_time,");
				sql.append("       a.input_username as input_user,");
				sql.append("       to_char(a.end_time, 'yyyy-mm-dd hh24:mi') as end_time,");
				sql.append("       a.higher_level_task,");
				sql.append("       a.task_content,");
				sql.append("       a.task_needinfo,");
				sql.append("       a.degree_of_importance,");
				sql.append("       a.completion_rate,");
				sql.append("       a. task_type,");
				sql.append("       a.attach_id,");
				sql.append("       a.task_status,");
				sql.append("       decode(a.task_status, '3', '已办结', '2', '办理中', '未办理') as task_status_name,");
				sql.append("       a.input_userid,");
				sql.append("       a.input_orgid,");
				sql.append("       a.del_ident,");
				sql.append("       a.input_orgname,");
				sql.append("       a.receive_userid,");
				sql.append("       a.receive_username,");
				sql.append("       a.receive_orgid,");
				sql.append("       a.receive_orgname,");
				sql.append("       b.type_name,");
				sql.append("       (select count(*)");
				sql.append("          from oa_task_taskreport c");
				sql.append("         where a.id = c.task_id");
				sql.append("           and c.type = '0'");
				sql.append("           and c.user_id <> '"+toDoWorkSearchBean.getInputuser_id()+"') as report_count");
				sql.append("  from oa_task_baseinfo a");
				sql.append("  left join oa_task_type b on a.task_type = b.type_id");
				sql.append(" where a.input_userid = '"+toDoWorkSearchBean.getInputuser_id()+"'");
				sql.append(" and a.task_status = '2'");
				sql.append(" order by start_time desc");
			}
			if("我的任务".equals(tdwlBean1.getInfo_type())){
				sql.append("select a.id as pri_id,");
				sql.append("       a.task_name as work_name,");
				sql.append("        '我的任务' info_type,");
				sql.append("       to_char(a.start_time, 'yyyy-mm-dd hh24:mi') as start_time,");
				sql.append("       a.input_username as input_user,");
				sql.append("       to_char(a.end_time, 'yyyy-mm-dd hh24:mi') as end_time,");
				sql.append("       a.higher_level_task,");
				sql.append("       a.task_content,");
				sql.append("       a.task_needinfo,");
				sql.append("       a.degree_of_importance,");
				sql.append("       a.completion_rate,");
				sql.append("       a. task_type,");
				sql.append("       a.attach_id,");
				sql.append("       a.task_status as m_check_flag,");
				sql.append("       decode(a.task_status, '3', '已办结', '2', '办理中', '未办理') as task_status_name,");
				sql.append("       a.input_userid,");
				sql.append("       a.input_orgid,");
				sql.append("       a.del_ident,");
				sql.append("       a.input_orgname,");
				sql.append("       a.receive_userid,");
				sql.append("       a.receive_username,");
				sql.append("       a.receive_orgid,");
				sql.append("       a.receive_orgname,");
				sql.append("       b.type_name,");
				sql.append("       (select count(*)");
				sql.append("          from oa_task_taskreport c");
				sql.append("         where a.id = c.task_id");
				sql.append("           and c.type = '0'");
				sql.append("           and c.user_id <> '"+toDoWorkSearchBean.getInputuser_id()+"') as report_count");
				sql.append("  from oa_task_baseinfo a");
				sql.append("  left join oa_task_type b on a.task_type = b.type_id");
				sql.append(" where a.receive_userid = '"+toDoWorkSearchBean.getInputuser_id()+"'");
				sql.append(" and (a.task_status = '2' or a.task_status = '1') ");
				sql.append(" order by start_time desc");
			}
			if("传阅文件".equals(tdwlBean1.getInfo_type())){
				sql.append("select f.circularize_id as pri_id,");
				sql.append("       f.circularize_title as work_name,");
				sql.append("       '传阅文件' info_type,");
				sql.append("       to_char(f.entering_date, 'yyyy-mm-dd hh24:mi') as start_time,");
				sql.append("       f.receive_userid,");
				sql.append("       f.is_circularize,");
				sql.append("       f.action_form as m_check_flag_name,");
				sql.append("       f.ins_id as m_is_need_signup,");
				sql.append("       f.busi_id as fk_id,");
				sql.append("       f.send_userid,");
				sql.append("       u.user_realname as input_user,");
				sql.append("       f.busitype_code as m_check_flag,");
				sql.append("       decode(f.is_view, '1', '已查看', '未查看') as isViews,");
				sql.append("       f.template_id");
				sql.append("  from oa_circularize_flow f, td_sm_user u");
				sql.append(" where 1=1 ");
				sql.append("   and f.receive_userid = '"+toDoWorkSearchBean.getInputuser_id()+"'");
				sql.append("   and u.user_id = f.send_userid");
				sql.append("   and f.is_view is null");
				sql.append(" order by start_time desc");
			}
		}
		if(StringUtil.nullOrBlank(tdwlBean1.getInfo_type())||"--请选择--".equals(tdwlBean1.getInfo_type())){
			
			sql.append("  select * from ( ");   
			sql.append("  select  pri_id,  info_type,  work_name,  input_user,  start_time");  
			sql.append("               , fk_id, m_check_flag_name, m_check_flag, m_reg_user_id, m_reg_user_name");   
			sql.append("               , m_close_time, m_is_need_signup");         
			sql.append("          from ( ");    
			//会议通知查看
			sql.append(" select ");
				sql.append("               t.m_notice_id pri_id,");
				sql.append("               '会议通知查看' info_type,");
				sql.append("               to_char(t.m_begin_time, 'yyyy-mm-dd hh24:mi') start_time,");
				sql.append("               t.m_title work_name,");
				sql.append("               t.m_create_user_name input_user,");
				sql.append("               t.m_check_flag m_check_flag , ");
				sql.append("               t.m_check_flag_name m_check_flag_name, ");
				sql.append("                t.m_is_need_signup m_is_need_signup,");
				sql.append("               u.m_receiver_id fk_id,");
				sql.append("               u.m_is_read,");
				sql.append("               to_char(t.m_close_time, 'yyyy/mm/dd hh24:mi:ss') m_close_time,");
				sql.append("               r.m_reg_user_id m_reg_user_id , ");
				sql.append("               r.m_reg_user_name m_reg_user_name,");
				sql.append("               r.administrator_ids,");
				sql.append("               r.administrator_names");
				sql.append("          from oa_meeting_notice t, ");
				sql.append("               oa_meeting_room r, ");
				sql.append("               oa_meeting_receiver_user u");
				sql.append("         where t.m_room_id = r.m_room_id(+)");
				sql.append("           and t.m_notice_id = u.m_notice_id");
				sql.append("           and u.m_receiver_user_id = '"+toDoWorkSearchBean.getInputuser_id()+"'");
				sql.append("           and to_date(to_char(t.m_begin_time, 'yyyy/mm/dd hh24:mi:ss'),");
				sql.append("                       'yyyy/mm/dd hh24:mi:ss') >=");
				sql.append("               to_date('2013-09-24 00:00:01', 'yyyy/mm/dd hh24:mi:ss')");
				sql.append("           and (t.m_check_flag = '4' or t.m_check_flag = '5')");
				sql.append("           and u.m_is_read = '0'");
				sql.append("         order by m_title desc)");
				//公告查看
				sql.append(" union all");
				sql.append("        select pri_id, info_type, work_name, input_user, start_time");
				sql.append("        ,fk_id,m_check_flag_name,m_check_flag,m_reg_user_id,m_reg_user_name");
				sql.append("               ,m_close_time,m_is_need_signup");
				sql.append("          from (select b.n_notice_id pri_id,");
				sql.append("                       '公告查看' info_type,");
				sql.append("                       b.n_title work_name,");
				sql.append("                       b.n_release_username input_user,");
				sql.append("                       to_char(b.n_release_time, 'yyyy-mm-dd hh24:mi') start_time,");
				sql.append("                       b.n_orgname,");
				sql.append("                       b.n_release_userid,");
				sql.append("                       r.n_receiverid,");
				sql.append("                       r.n_receiverid fk_id,");
				sql.append("                       '' m_check_flag_name,");
				sql.append("                       '' m_check_flag,");
				sql.append("                       '' m_reg_user_id,");
				sql.append("                       '' m_reg_user_name,");
				sql.append("                       '' m_close_time,");
				sql.append("                       '' m_is_need_signup,");
				sql.append("                       decode(r.n_isview,");
				sql.append("                              '0',");
				sql.append("                              '未查看',");
				sql.append("                              '1',");
				sql.append("                              '已查看',");
				sql.append("                              '2',");
				sql.append("                              '撤销') as n_state");
				sql.append("                  from oa_notice_baseinfo b, oa_notice_receiver_user r");
				sql.append("                 where r.n_notice_id = b.n_notice_id");
				sql.append("                   and b.n_state in (1, 2)");
				sql.append("                   and r.n_isdel != '1'");
				sql.append("                   and r.n_isview = '0'");
				sql.append("                   and r.n_receiver_userid = '"+toDoWorkSearchBean.getInputuser_id()+"'");
				sql.append("                 order by n_release_time desc)");
			//信息报送
			sql.append(" union all");
				sql.append("        select pri_id, info_type, work_name, input_user, start_time");
				sql.append("        ,'' fk_id,'' m_check_flag_name,'' m_check_flag,'' m_reg_user_id,'' m_reg_user_name");
				sql.append("        ,'' m_close_time,'' m_is_need_signup ");
				sql.append("          from (  							");
				sql.append("	select distinct (t.submittedinfo_id) pri_id,");
				sql.append("       t.submittedinfo_title work_name,");
				sql.append("     to_char(t.input_date,'yyyy-mm-dd hh24:mi') start_time,");
				sql.append("       '信息报送' info_type,");
				sql.append("    t.inputuser_id,");
				sql.append("     t.inputuser_name input_user,");
				sql.append("      t.department_id,");
				sql.append("     o.org_name,");
				sql.append("     t.is_recommend,");
				sql.append("     u.andit_state,");
				sql.append("     b.submittedinfo_typename,");
				sql.append("    (select max(a.andit_time)");
				sql.append("      from ta_oa_infre_audit a");
				sql.append("      where a.submittedinfo_id = t.submittedinfo_id");
				sql.append("      and a.andit_state = '6'");
				sql.append("      group by a.submittedinfo_id) release_time,");
				sql.append("   t.infotype_id");
				sql.append("    from ta_oa_infre_submitted_info t");
				sql.append("  inner join ta_oa_infre_audit u on u.submittedinfo_id =");
				sql.append("                            t.submittedinfo_id");
				sql.append("  inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode =");
				sql.append("                                        to_number(u.andit_state)");
				sql.append("   inner join td_sm_organization o on o.org_id = t.department_id");
				sql.append(" where u.andit_person_id = "+toDoWorkSearchBean.getInputuser_id());
				sql.append("   and u.andit_state in ('7', '8', '9')) tt");
				sql.append(" where  submittedinfo_typename = '未查看'");
				sql.append(" order by start_time desc)");
			//电子邮件
			sql.append(" union all");
				sql.append("        select pri_id, info_type, work_name, input_user, start_time");
				sql.append("        ,'' fk_id,'' m_check_flag_name,'' m_check_flag,'' m_reg_user_id,'' m_reg_user_name");
				sql.append("         ,'' m_close_time,'' m_is_need_signup");
				sql.append("          from (  							");
				sql.append("	select to_char(tt.mid) as pri_id,						");
				sql.append("	       tt.sendpid,								");
				sql.append("	       tt.sendpname 	as 	input_user,			");
				sql.append("	       tt.title as work_name,					");
				sql.append("	       decode(t.readstate, '0', '未读', '1', '已读', '') as readstate,	");
				sql.append("	       tt.createtime  as start_time,			");
				sql.append("	       '电子邮件'  as info_type					");
				sql.append("	  from ymj_oa_user_mail t, ymj_oa_jbxx_mail tt	");
				sql.append("	 where 1 = 1									");
				sql.append("	   and t.mid = tt.mid							");
				sql.append("	   and t.receivepid =							");
				sql.append(toDoWorkSearchBean.getInputuser_id());
				sql.append("   		and (tt.state = '1' or tt.state = '-1')		");
				sql.append("   		and t.readstate = '0'						");
				sql.append("	 order by createtime desc						");
            sql.append(" )");   
            //交办的任务
            sql.append(" union all");
			sql.append("        select pri_id, info_type, work_name, input_user, start_time");
			sql.append("        ,'' fk_id,'' m_check_flag_name,'' m_check_flag,'' m_reg_user_id,'' m_reg_user_name");
			sql.append("         ,'' m_close_time,'' m_is_need_signup");
			sql.append("          from (  							");
			sql.append("select a.id as pri_id,");
			sql.append("       a.task_name as work_name,");
			sql.append("        '交办的任务' info_type,");
			sql.append("       to_char(a.start_time, 'yyyy-mm-dd hh24:mi') as start_time,");
			sql.append("       a.input_username as input_user,");
			sql.append("       to_char(a.end_time, 'yyyy-mm-dd hh24:mi') as end_time,");
			sql.append("       a.higher_level_task,");
			sql.append("       a.task_content,");
			sql.append("       a.task_needinfo,");
			sql.append("       a.degree_of_importance,");
			sql.append("       a.completion_rate,");
			sql.append("       a. task_type,");
			sql.append("       a.attach_id,");
			sql.append("       a.task_status,");
			sql.append("       decode(a.task_status, '3', '已办结', '2', '办理中', '未办理') as task_status_name,");
			sql.append("       a.input_userid,");
			sql.append("       a.input_orgid,");
			sql.append("       a.del_ident,");
			sql.append("       a.input_orgname,");
			sql.append("       a.receive_userid,");
			sql.append("       a.receive_username,");
			sql.append("       a.receive_orgid,");
			sql.append("       a.receive_orgname,");
			sql.append("       b.type_name,");
			sql.append("       (select count(*)");
			sql.append("          from oa_task_taskreport c");
			sql.append("         where a.id = c.task_id");
			sql.append("           and c.type = '0'");
			sql.append("           and c.user_id <> '"+toDoWorkSearchBean.getInputuser_id()+"') as report_count");
			sql.append("  from oa_task_baseinfo a");
			sql.append("  left join oa_task_type b on a.task_type = b.type_id");
			sql.append(" where a.input_userid = '"+toDoWorkSearchBean.getInputuser_id()+"'");
			sql.append(" and a.task_status = '2'");
			sql.append(" order by start_time desc");
			sql.append(" )");   
            //我的任务
			sql.append(" union all");
			sql.append("        select pri_id, info_type, work_name, input_user, start_time");
			sql.append("        ,'' fk_id,'' m_check_flag_name,m_check_flag,'' m_reg_user_id,'' m_reg_user_name");
			sql.append("         ,'' m_close_time,'' m_is_need_signup");
			sql.append("          from (  							");
			sql.append("select a.id as pri_id,");
			sql.append("       a.task_name as work_name,");
			sql.append("        '我的任务' info_type,");
			sql.append("       to_char(a.start_time, 'yyyy-mm-dd hh24:mi') as start_time,");
			sql.append("       a.input_username as input_user,");
			sql.append("       to_char(a.end_time, 'yyyy-mm-dd hh24:mi') as end_time,");
			sql.append("       a.higher_level_task,");
			sql.append("       a.task_content,");
			sql.append("       a.task_needinfo,");
			sql.append("       a.degree_of_importance,");
			sql.append("       a.completion_rate,");
			sql.append("       a. task_type,");
			sql.append("       a.attach_id,");
			sql.append("       a.task_status as m_check_flag,");
			sql.append("       decode(a.task_status, '3', '已办结', '2', '办理中', '未办理') as task_status_name,");
			sql.append("       a.input_userid,");
			sql.append("       a.input_orgid,");
			sql.append("       a.del_ident,");
			sql.append("       a.input_orgname,");
			sql.append("       a.receive_userid,");
			sql.append("       a.receive_username,");
			sql.append("       a.receive_orgid,");
			sql.append("       a.receive_orgname,");
			sql.append("       b.type_name,");
			sql.append("       (select count(*)");
			sql.append("          from oa_task_taskreport c");
			sql.append("         where a.id = c.task_id");
			sql.append("           and c.type = '0'");
			sql.append("           and c.user_id <> '"+toDoWorkSearchBean.getInputuser_id()+"') as report_count");
			sql.append("  from oa_task_baseinfo a");
			sql.append("  left join oa_task_type b on a.task_type = b.type_id");
			sql.append(" where a.receive_userid = '"+toDoWorkSearchBean.getInputuser_id()+"'");
			sql.append(" and (a.task_status = '2' or a.task_status = '1') ");
			sql.append(" order by start_time desc");
			sql.append(" )");
			
			 //传阅文件
			sql.append(" union all");
			sql.append("        select pri_id, info_type, work_name, input_user, start_time");
			sql.append("        ,fk_id,m_check_flag_name,m_check_flag,'' m_reg_user_id,'' m_reg_user_name");
			sql.append("         ,'' m_close_time,m_is_need_signup");
			sql.append("          from (  							");
			sql.append("select f.circularize_id as pri_id,");
			sql.append("       f.circularize_title as work_name,");
			sql.append("       '传阅文件' info_type,");
			sql.append("       to_char(f.entering_date, 'yyyy-mm-dd hh24:mi') as start_time,");
			sql.append("       f.receive_userid,");
			sql.append("       f.is_circularize,");
			sql.append("       f.action_form as m_check_flag_name,");
			sql.append("       f.ins_id as m_is_need_signup,");
			sql.append("       f.busi_id as fk_id,");
			sql.append("       f.send_userid,");
			sql.append("       u.user_realname as input_user,");
			sql.append("       f.busitype_code as m_check_flag,");
			sql.append("       decode(f.is_view, '1', '已查看', '未查看') as isViews,");
			sql.append("       f.template_id");
			sql.append("  from oa_circularize_flow f, td_sm_user u");
			sql.append(" where 1=1 ");
			sql.append("   and f.receive_userid = '"+toDoWorkSearchBean.getInputuser_id()+"'");
			sql.append("   and u.user_id = f.send_userid");
			sql.append("   and f.is_view is null");
			sql.append(" order by start_time desc");
			sql.append(" )");
			sql.append("tt ");
			sql.append(" where tt.pri_id is not null ");
		}
		return sql;
	}
}
