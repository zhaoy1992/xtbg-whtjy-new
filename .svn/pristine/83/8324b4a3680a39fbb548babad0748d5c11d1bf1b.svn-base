package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoteTemplateBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;
import com.chinacreator.xtbg.core.meeting.util.MeetingConstants;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:MeetingDaoImpl.java</p>
 *<p>Description:会议管理 数据访问层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-19
 */
public class MeetingDaoImpl extends XtDbBaseDao implements MeetingDao {
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 insertMeetingNotice
	  * @param conn
	  * @param model
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#saveMeetingNotice(java.sql.Connection, com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean) 
	  */
	public void insertMeetingNotice(Connection conn, MeetingNoticeBean model) throws Exception{
		//mark
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteMeetingNotice
	  * @param ids
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#deleteMeetingNotice(java.lang.String) 
	  */
	public boolean deleteMeetingNotice(String ids) throws Exception {
		String sql = "delete from oa_meeting_notice where m_notice_id in ("+ ids + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findMeetingNoticeList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#findMeetingNoticeList(com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean findMeetingNoticeList(MeetingNoticeBean model, String timesupflag, String dotype,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			if ("doview".equalsIgnoreCase(dotype)){
				sql.append("select u.m_receiver_id,");
				sql.append("       u.m_is_read,");
				sql.append("       u.m_is_other,");
				sql.append("       decode(u.m_is_read, '1', '已阅读', '<b>未阅读</b>') m_is_read_name,");
				sql.append("       decode(t.m_is_need_signup,'0','',decode(nvl(u.m_is_reply,''), '', '<b>未报名</b>', '0', '<b>未报名</b>', u.m_is_reply_name)) m_is_reply_name,");
				sql.append("       t.*,");
				sql.append("       r.m_reg_user_id,");
				sql.append("       r.m_reg_user_name,");
				sql.append("       r.administrator_ids,");
				sql.append("       r.administrator_names");
				sql.append("  from oa_meeting_notice t, oa_meeting_room r, oa_meeting_receiver_user u");
				sql.append(" where t.m_room_id = r.m_room_id(+)");
				sql.append("   and t.m_notice_id = u.m_notice_id");
			}else{
				sql.append("select t.*,");
				sql.append("       r.m_reg_user_id,");
				sql.append("       r.m_reg_user_name,");
				sql.append("       r.administrator_ids,");
				sql.append("       r.administrator_names,");
				sql.append("       decode(t.m_is_need_signup,");
				sql.append("              '0',");
				sql.append("              '',");
				sql.append("              ((select count(*)");
				sql.append("                  from oa_meeting_receiver_user u");
				sql.append("                 where u.m_notice_id = t.m_notice_id and u.m_is_other is null ");
				sql.append("                   and u.m_is_reply IN ('1','2','3') ) || '/' ||");
				sql.append("              (select count(*)");
				sql.append("                  from oa_meeting_receiver_user u");
				sql.append("                 where u.m_notice_id = t.m_notice_id  and u.m_is_other is null ))) signup_percent,");
				sql.append("              ((select count(*)");
				sql.append("                  from oa_meeting_receiver_user u");
				sql.append("                 where u.m_notice_id = t.m_notice_id  and u.m_is_other is null ");
				sql.append("                   and u.m_is_read = '1') || '/' ||");
				sql.append("              (select count(*)");
				sql.append("                  from oa_meeting_receiver_user u");
				sql.append("                 where u.m_notice_id = t.m_notice_id  and u.m_is_other is null )) read_percent");
				sql.append("  from oa_meeting_notice t, oa_meeting_room r");
				sql.append(" where t.m_room_id = r.m_room_id(+)");
			}
			
			if (!StringUtil.nullOrBlank(model.getM_title())){
				sql.append(" and t.m_title like '%"+model.getM_title()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getM_room_name())){
				sql.append(" and t.m_room_name like '%"+model.getM_room_name()+"%'");
			}
			
			if ("doview".equalsIgnoreCase(dotype) && !StringUtil.nullOrBlank(model.getM_receiver_user_ids())  ){
				sql.append(" and u.m_receiver_user_id = '"+model.getM_receiver_user_ids()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getM_create_user_id())  ){
				sql.append(" and t.m_create_user_id = '"+model.getM_create_user_id()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getAdministrator_ids())  ){  //会议审核时会传这个id
				sql.append(" and ','||r.administrator_ids||',' like '%,"+model.getAdministrator_ids()+",%'");
			}
			
			if (!StringUtil.nullOrBlank(model.getM_begin_time().toString())){
				if("yes".equalsIgnoreCase(StringUtil.deNull(timesupflag))){//查看过期的会议
					sql.append(" and to_date(to_char(t.m_begin_time, 'yyyy/mm/dd hh24:mi:ss'), 'yyyy/mm/dd hh24:mi:ss') <=to_date('"+model.getM_begin_time().toString()+"','yyyy/mm/dd hh24:mi:ss')");
				}else{
					sql.append(" and to_date(to_char(t.m_begin_time, 'yyyy/mm/dd hh24:mi:ss'), 'yyyy/mm/dd hh24:mi:ss') >=to_date('"+model.getM_begin_time().toString()+"','yyyy/mm/dd hh24:mi:ss')");
				}
				
			}
			if (model.getM_end_time()!=null && !StringUtil.nullOrBlank(model.getM_end_time().toString())){
				sql.append(" and to_date(to_char(t.m_begin_time, 'yyyy/mm/dd hh24:mi:ss'), 'yyyy/mm/dd hh24:mi:ss') <=to_date('"+model.getM_end_time().toString()+"','yyyy/mm/dd hh24:mi:ss')");
			}
			
			if (MeetingConstants.STATUS_PUBLISHED.equalsIgnoreCase(StringUtil.deNull(model.getM_check_flag()))){//已发布
				sql.append(" and (t.m_check_flag = '"+MeetingConstants.STATUS_PUBLISHED+"' or t.m_check_flag = '"+MeetingConstants.STATUS_REPUBLISHED+"' )"  );
			}else if ("nopublished".equalsIgnoreCase(StringUtil.deNull(model.getM_check_flag()))){//未发布的
				sql.append(" and (t.m_check_flag <> '"+MeetingConstants.STATUS_PUBLISHED+"' and t.m_check_flag <> '"+MeetingConstants.STATUS_REPUBLISHED+"' )");
			}else if (MeetingConstants.STATUS_PENDING.equalsIgnoreCase(StringUtil.deNull(model.getM_check_flag()))){//已送审 待审核的
				sql.append(" and (t.m_check_flag = '"+MeetingConstants.STATUS_PENDING+"' ) ");
			}else if ("checked".equalsIgnoreCase(StringUtil.deNull(model.getM_check_flag()))){//已审核过的，暂存、不通过的除外 
				sql.append(" and t.m_check_flag > '"+MeetingConstants.STATUS_PENDING+"' and t.m_check_flag<>'"+MeetingConstants.STATUS_DRAFT+"'  ");
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			//调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		}finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingNoticeBean
	  * @param m_notice_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#getMeetingNoticeBean(java.lang.String)
	 */
	public Map<String, String> getMeetingNoticeBean(String m_notice_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select m_notice_id,");
		sql.append("       m_type_id,");
		sql.append("       m_type_name,");
		sql.append("       m_room_id,");
		sql.append("       m_room_name,");
		sql.append("       m_title,");
		sql.append("       m_begin_time,");
		sql.append("       m_end_time,");
		sql.append("       m_address,");
		sql.append("       m_link_user_id,");
		sql.append("       m_link_user_name,");
		sql.append("       m_link_dept_id,");
		sql.append("       m_link_dept_name,");
		sql.append("       m_link_tel,");
		sql.append("       m_master_user_id,");
		sql.append("       m_master_user_name,");
		sql.append("       m_attender_count,");
		sql.append("       m_close_time,");
		sql.append("       m_send_name,");
		sql.append("       m_contents,");
		sql.append("       m_is_need_signup,");
		sql.append("       m_create_user_id,");
		sql.append("       m_create_user_name,");
		sql.append("       m_create_time,");
		sql.append("       m_create_dept_id,");
		sql.append("       m_create_dept_name,");
		sql.append("       m_check_flag,");
		sql.append("       m_check_flag_name,");
		sql.append("       m_check_user_id,");
		sql.append("       m_check_user_name,");
		sql.append("       m_check_time,");
		sql.append("       m_current_user_id,");
		sql.append("       m_current_user_name,");
		sql.append("       m_current_time,");
		sql.append("       m_is_addsend,");
		sql.append("       m_is_resend,");
		sql.append("       m_receiver_unit_ids,");
		sql.append("       m_receiver_user_ids,");
		sql.append("       m_receiver_other_unit_ids,");
		sql.append("       m_receiver_other_user_ids,");
		sql.append("       m_receiver_unit_names,");
		sql.append("       m_receiver_user_names,");
		sql.append("       m_receiver_other_unit_names,");
		sql.append("       m_receiver_other_user_names,");
		sql.append("       m_djbh,");
		sql.append("       m_other_user_input,");
		sql.append("       m_remark,");
		sql.append("       is_sms,");
		sql.append("       is_msg,");
		sql.append("       is_rtx,");
		sql.append("       is_mail");
		sql.append("  from oa_meeting_notice m");
		sql.append(" where m.m_notice_id = ?");
		
		viewMap = queryToSingleMap(conn, sql.toString(), m_notice_id);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 viewRoomOccupancy
	  * @param unit_id
	  * @param times
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#viewRoomOccupancy(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public PagingBean viewRoomOccupancy(String unit_id, String times,String sortName,
			String sortOrder) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select r.m_room_id,");
			sql.append("       r.m_room_name,");
			sql.append("       m.m_begin_time,");
			sql.append("       m.m_end_time,");
			sql.append("       m.m_title,");
			sql.append("       m.m_link_user_name,");
			sql.append("       m.m_link_tel");
			sql.append("  from oa_meeting_notice m, oa_meeting_room r");
			sql.append(" where m.m_room_id = r.m_room_name");
			sql.append("   and m.m_check_flag in (4, 5)");
			sql.append("   and (m.m_begin_time > sysdate or m.m_end_time > sysdate)");
			sql.append("   and r.m_unit_id = ?");
			sql.append("   and m.m_begin_time < ?");
			sql.append("   and m.m_end_time > ?");
			sql.append("   order by m.m_begin_time desc");
			pb = queryToPagingBean(sql.toString(), conn, unit_id, times, times);
			return pb;
		}finally {
			DbManager.closeConnection(conn);
		}
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateMeetingReceiver
	  * @param conn
	  * @param tablename
	  * @param ids
	  * @param m_call_type
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#updateMeetingReceiver(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String) 
	  */
	public void updateMeetingReceiver(Connection conn, String tablename, String ids ,String m_call_type)
		throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update "+tablename);
		sql.append(" set ");
		sql.append(" m_is_call = '1', m_call_type='"+m_call_type+"' ");
		sql.append(" where m_receiver_id IN  ("+ids+")");
		db.executeSql(sql.toString(), conn);
	}
	
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findMeetingNoteTemplateList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#findMeetingNoteTemplateList(com.chinacreator.xtbg.core.meeting.entity.MeetingNoteTemplateBean, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean findMeetingNoteTemplateList(
			MeetingNoteTemplateBean model, String sortName, String sortOrder,
			long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select * from OA_MEETING_NOTE_TEMPLATE where 1=1 ");
			if(!StringUtil.nullOrBlank(model.getM_name())){
				sql.append(" and m_name like '%"+model.getM_name()+"%' ");
			}
			sql.append(" order by " + sortName + " " + sortOrder);
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingNoticeInfo
	  * @param m_notice_id
	  * @param m_receiver_user_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#getMeetingNoticeInfo(java.lang.String, java.lang.String, java.sql.Connection) 
	  */
	public Map<String, String> getMeetingNoticeInfo(String m_notice_id,
			String m_receiver_user_id, Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select u.m_receiver_id,");
		sql.append("       u.m_is_read,");
		sql.append("       u.m_is_other,");
		sql.append("       t.*,");
		sql.append("       r.m_reg_user_id,");
		sql.append("       r.m_reg_user_name,");
		sql.append("       r.administrator_ids,");
		sql.append("       r.administrator_names");
		sql.append("  from oa_meeting_notice t, oa_meeting_room r, oa_meeting_receiver_user u");
		sql.append(" where t.m_room_id = r.m_room_id(+)");
		sql.append("   and t.m_notice_id = u.m_notice_id");
		sql.append("   and t.m_notice_id = ? ");
		sql.append("   and u.m_receiver_user_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), m_notice_id,
				m_receiver_user_id);
		return viewMap;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getUserNames
	  * @param userIds
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#getUserNames(java.lang.String, java.sql.Connection) 
	  */
	public String getUserNames(String userIds, Connection conn) throws Exception{
		String userNames = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		conn = DbManager.getInstance().getConnection();
		sql.append("select wm_concat(u.user_realname) userNames");
		sql.append("   from td_sm_user u");
		sql.append("  where u.user_id in ('"+userIds.replaceAll(",", "','")+"')");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		if(pdb.size() > 0) {
			userNames = pdb.getString(0, "userNames");
		}
		return userNames;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getReceiverUserNames
	  * @param ids
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#getReceiverUserNames(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getReceiverUserNames(String ids, Connection conn)
			throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select '<b>'||org_name||'</b>' org_name,wmsys.wm_concat('<span title='|| org_name||'-'||org_name||'>'||user_realname||'</span>') user_names from ");
		sql.append(" (select v.user_realname,o.org_name ");
		sql.append(" from table(split(?, ',')), td_sm_user v ,td_sm_orguser ou ,td_sm_organization o ");
		sql.append(" where v.user_id = column_value  and v.user_id=ou.user_id  and ou.org_id=o.org_id order by org_name desc) group by org_name ");
		viewMap = queryToListMap(sql.toString(), ids);
		return viewMap;
	}
}
