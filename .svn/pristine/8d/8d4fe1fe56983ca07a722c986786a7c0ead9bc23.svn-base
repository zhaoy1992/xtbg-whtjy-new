package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingRoomoccupancyDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingRoomoccupancyBean;
import com.chinacreator.xtbg.core.meeting.util.MeetingConstants;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:MeetingRoomoccupancyDaoImpl.java</p>
 *<p>Description:会议室预约Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-28
 */
public class MeetingRoomoccupancyDaoImpl extends XtDbBaseDao implements MeetingRoomoccupancyDao {

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
	public List<Map<String, String>> viewRoomOccupancy(String unit_id, String times) throws Exception {
			List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
			StringBuffer sql = new StringBuffer();
			sql.append("select m_room_id,");
			sql.append("       room,");
			sql.append("       m_title,");
			sql.append("       blockSize,");
			sql.append("       case");
			sql.append("         when startBlock < 0 then");
			sql.append("          0");
			sql.append("         else");
			sql.append("          startBlock");
			sql.append("       end as startblock,");
			sql.append("       case");
			sql.append("         when endBlock > 900 then");
			sql.append("          900");
			sql.append("         else");
			sql.append("          endBlock");
			sql.append("       end as endblock,");
			sql.append("  orgname, ");
			sql.append("  m_link_username, ");
			sql.append("  m_link_tel ");
			sql.append("  from (select m.m_room_id,");
			sql.append("               m.m_room_name as room,");
			sql.append("               m.m_title,");
			sql.append("               (m.m_end_time - m.m_begin_time) * 24 * 60 as blockSize,");
			sql.append("               (m.m_begin_time -");
			sql.append("               to_date('"+times+" 08:00:00', 'yyyy-mm-dd hh24:mi:ss')) * 24 * 60 as startBlock,");
			sql.append("               (m.m_end_time -");
			sql.append("               to_date('"+times+" 08:00:00', 'yyyy-mm-dd hh24:mi:ss')) * 24 * 60 as endBlock,");
			sql.append("               m.m_begin_time,");
			sql.append("   '' orgname,");
			sql.append(" m.m_link_username, ");
			sql.append(" m.m_link_tel ");
			sql.append("          from oa_meeting_roomoccupancy m, oa_meeting_room r");
			sql.append("         where m.m_room_id = r.m_room_id");
			//sql.append("           and (m.m_begin_time > sysdate or m.m_end_time > sysdate)");
			sql.append("           and r.m_unit_id = '"+unit_id+"'");
			sql.append("           and ((m.m_begin_time >=");
			sql.append("               to_date('"+times+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_begin_time <=");
			sql.append("               to_date('"+times+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss')) or");
			sql.append("               (m.m_end_time >=");
			sql.append("               to_date('"+times+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_end_time <=");
			sql.append("               to_date('"+times+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss')) or");
			sql.append("               (m.m_begin_time <=");
			sql.append("               to_date('"+times+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_end_time >=");
			sql.append("               to_date('"+times+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss')))");
			sql.append("        union");
			sql.append("        select r.m_room_id,");
			sql.append("               r.m_room_name as room,");
			sql.append("               m.m_title,");
			sql.append("               (m.m_end_time - m.m_begin_time) * 24 * 60 as blockSize,");
			sql.append("               (m.m_begin_time -");
			sql.append("               to_date('"+times+" 08:00:00', 'yyyy-mm-dd hh24:mi:ss')) * 24 * 60 as startBlock,");
			sql.append("               (m.m_end_time -");
			sql.append("               to_date('"+times+" 08:00:00', 'yyyy-mm-dd hh24:mi:ss')) * 24 * 60 as endBlock,");
			sql.append("               m.m_begin_time, ");
			sql.append("   m.m_link_dept_name orgname,");
			sql.append("   m.m_link_user_name as m_link_username,  ");
			sql.append("   m.m_link_tel ");
			sql.append("          from oa_meeting_notice m, oa_meeting_room r");
			sql.append("         where m.m_room_id = r.m_room_id");
			sql.append("           and m.m_check_flag in (4, 5)");
			//sql.append("           and (m.m_begin_time > sysdate or m.m_end_time > sysdate)");
			sql.append("           and r.m_unit_id = '"+unit_id+"'");
			sql.append("           and ((m.m_begin_time >=");
			sql.append("               to_date('"+times+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_begin_time <=");
			sql.append("               to_date('"+times+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss')) or");
			sql.append("               (m.m_end_time >=");
			sql.append("               to_date('"+times+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_end_time <=");
			sql.append("               to_date('"+times+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') or");
			sql.append("               (m.m_begin_time <=");
			sql.append("               to_date('"+times+"' || ' 00:00:00',");
			sql.append("                          'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_end_time >=");
			sql.append("               to_date('"+times+"' || ' 23:59:59',");
			sql.append("                          'yyyy-mm-dd hh24:mi:ss'))))) t order by m_begin_time");
			listMap = queryToListMap(sql.toString());
			return listMap;
	
			
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingRoomList
	  * @param unit_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#getMeetingRoomList(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getMeetingRoomList(String unit_id,
			Connection conn) throws Exception {
		
		List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select m_room_id,");
		sql.append("       m_room_code,");
		sql.append("       m_room_name,");
		sql.append("       m_unit_id,");
		sql.append("       m_address,");
		sql.append("       m_people_num,");
		sql.append("       m_dept_id,");
		sql.append("       m_is_need_check,");
		sql.append("       m_reg_user_id,");
		sql.append("       m_unit_name,");
		sql.append("       m_reg_user_name,");
		sql.append("       to_char(m_reg_time, 'YYYY-mm-dd') as m_reg_time,");
		sql.append("       m_remark");
		sql.append("  from oa_meeting_room");
		sql.append(" where m_room_id is not null");
		sql.append("   and m_unit_id = ?");
		
		listMap = queryToListMap(sql.toString(), unit_id);
		return listMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getMeetingRoomViewList
	  * @param meetingRoomoccupancyBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#getMeetingRoomViewList(com.chinacreator.xtbg.core.meeting.entity.MeetingRoomoccupancyBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getMeetingRoomViewList(
			MeetingRoomoccupancyBean meetingRoomoccupancyBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select t.*,");
			sql.append("       (select wmsys.wm_concat(a.m_user_id)");
			sql.append("          from oa_meeting_room_administrator a");
			sql.append("         where a.m_room_id = t.m_room_id) as roomadmin");
			sql.append("  from (select m.m_room_id,");
			sql.append("               m.m_ro_id as m_id,");
			sql.append("               m.m_room_name as room,");
			sql.append("               m.m_begin_time,");
			sql.append("               m.m_end_time,");
			sql.append("               m.m_title,");
			sql.append("               to_char(m.m_begin_time, 'yyyy-mm-dd hh24:mi') || '至' ||");
			sql.append("               to_char(m.m_end_time, 'yyyy-mm-dd hh24:mi') as meetingtime,");
			sql.append("               m.m_link_username,");
			sql.append(" '' orgname, ");
			sql.append("               m.m_link_tel,");
			sql.append("               '会议室预约' as meetingtype,");
			sql.append("   0  m_attender_count, ");
			sql.append("  '' m_create_user_id, ");
			sql.append("  '' m_create_user_name");
			sql.append("          from oa_meeting_roomoccupancy m, oa_meeting_room r");
			sql.append("         where m.m_room_id = r.m_room_id");
			sql.append("           and r.m_unit_id = '"+meetingRoomoccupancyBean.getM_room_id()+"'");
			//sql.append("           and (m.m_begin_time > sysdate or m.m_end_time > sysdate)");
			sql.append("           and ((m.m_begin_time >=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_begin_time <=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss')) or");
			sql.append("               (m.m_end_time >=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_end_time <=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss')) or");
			sql.append("               (m.m_begin_time <=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_end_time >=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss')))");
			sql.append("        union");
			sql.append("        select r.m_room_id,");
			sql.append("               m.m_notice_id as m_id,");
			sql.append("               r.m_room_name as room,");
			sql.append("               m.m_begin_time,");
			sql.append("               m.m_end_time,");
			sql.append("               m.m_title,");
			sql.append("               to_char(m.m_begin_time, 'yyyy-mm-dd hh24:mi') || '至' ||");
			sql.append("               to_char(m.m_end_time, 'yyyy-mm-dd hh24:mi') as meetingtime,");
			sql.append("               m.m_link_user_name as m_link_username,");
			sql.append("  m.m_link_dept_name orgname, ");
			sql.append("               m.m_link_tel,");
			sql.append("               '会议通知' as meetingtype ,");
			sql.append("  nvl(m_attender_count,0), ");
			sql.append("  m.m_create_user_id,");
			sql.append("  m.m_create_user_name");
			sql.append("          from oa_meeting_notice m, oa_meeting_room r");
			sql.append("         where m.m_room_id = r.m_room_id");
			sql.append("           and m.m_check_flag in (4, 5)");
			sql.append("           and r.m_unit_id = '"+meetingRoomoccupancyBean.getM_room_id()+"'");
			//sql.append("           and (m.m_begin_time > sysdate or m.m_end_time > sysdate)");
			sql.append("           and ((m.m_begin_time >=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_begin_time <=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss')) or");
			sql.append("               (m.m_end_time >=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_end_time <=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss')) or");
			sql.append("               (m.m_begin_time <=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 00:00:00',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss') and");
			sql.append("               m.m_end_time >=");
			sql.append("               to_date('"+meetingRoomoccupancyBean.getM_begin_time()+"' || ' 23:59:59',");
			sql.append("                         'yyyy-mm-dd hh24:mi:ss')))");
			sql.append("        ");
			sql.append("        ) t");
			//sql.append(" order by m_begin_time");
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		}finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isRoomAdministrator
	  * @param user_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingRoomDao#isRoomAdministrator(java.lang.String, java.sql.Connection)
	 */
	public int isRoomAdministrator(String user_id, Connection conn)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		int roomcount = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) as roomcount");
		sql.append("  from oa_meeting_room_administrator a");
		sql.append(" where a.m_user_id = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, user_id);
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			roomcount = pdb.getInt(0, "roomcount");
		}
		return roomcount;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isCurRoomAdministrator
	  * @param room_id
	  * @param user_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingRoomDao#isCurRoomAdministrator(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public int isCurRoomAdministrator(String room_id, String user_id,
			Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		int roomcount = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) as roomcount");
		sql.append("  from oa_meeting_room r, oa_meeting_room_administrator a");
		sql.append(" where r.m_room_id = a.m_room_id");
		sql.append("   and r.m_room_id = ?");
		sql.append("   and a.m_user_id = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, room_id);
		pdb.setString(2, user_id);
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			roomcount = pdb.getInt(0, "roomcount");
		}
		return roomcount;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 geteMeetingRoomoccupancyBean
	  * @param m_ro_id
	  * @param meetingType
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingRoomoccupancyDao#geteMeetingRoomoccupancyBean(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> geteMeetingRoomoccupancyBean(String m_ro_id,
			String meetingType, Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		if(meetingType.equals(MeetingConstants.MEETINGTYPE_YUYUE)) {
			sql.append("select o.m_ro_id,");
			sql.append("       o.m_room_id,");
			sql.append("       o.m_room_name,");
			sql.append("       o.m_title,");
			sql.append("       o.m_begin_time,");
			sql.append("       o.m_end_time,");
			sql.append("       o.m_link_userid,");
			sql.append("       o.m_link_username,");
			sql.append("       o.m_link_tel");
			sql.append("  from oa_meeting_roomoccupancy o");
			sql.append(" where o.m_ro_id = ?");
		} else {
			sql.append(" select n.m_notice_id as m_ro_id,");
			sql.append("        n.m_room_id,");
			sql.append("        n.m_room_name,");
			sql.append("        n.m_title,");
			sql.append("        n.m_begin_time,");
			sql.append("        n.m_end_time,");
			sql.append("        n.m_link_user_id as m_link_userid,");
			sql.append("        n.m_link_user_name as m_link_username,");
			sql.append("        n.m_link_tel");
			sql.append("   from oa_meeting_notice n");
			sql.append("  where n.m_notice_id = ?");
		}
		viewMap = queryToSingleMap(conn, sql.toString(), m_ro_id);
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isRoomOccupancy
	  * @param m_begin_time
	  * @param m_end_time
	  * @param room_id
	  * @param m_ro_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingRoomoccupancyDao#isRoomOccupancy(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean isRoomOccupancy(String m_begin_time, String m_end_time,
			String room_id, String m_ro_id, String m_notice_id,Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		int roomcount = 0;
		boolean flag = false;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(m_room_id) as roomCount");
		sql.append("  from (select m.m_room_id");
		sql.append("          from oa_meeting_roomoccupancy m, oa_meeting_room r");
		sql.append("         where m.m_room_id = r.m_room_id");
		sql.append("           and m.m_room_id = '"+room_id+"'");
		if(!StringUtil.isBlank(m_ro_id)) {
			sql.append("           and m.m_ro_id != '"+m_ro_id+"'");
		}
		sql.append("           and ((m.m_begin_time <=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') + numtodsinterval(4,'minute') and");
		sql.append("               m.m_end_time >=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') + numtodsinterval(4,'minute')) or");
		sql.append("               (m.m_begin_time <=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss') - numtodsinterval(4,'minute') and");
		sql.append("               m.m_end_time >=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss') - numtodsinterval(4,'minute')) or");
		sql.append("               (m.m_begin_time >=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') + numtodsinterval(4,'minute') and");
		sql.append("               m.m_end_time <=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss') - numtodsinterval(4,'minute')))");
		sql.append("        ");
		sql.append("        union");
		sql.append("        select r.m_room_id");
		sql.append("          from oa_meeting_notice m, oa_meeting_room r");
		sql.append("         where m.m_room_id = r.m_room_id");
		sql.append("           and m.m_check_flag in (4, 5)");
		if(!StringUtil.nullOrBlank(m_notice_id)){
			sql.append("           and m.m_notice_id <> '"+m_notice_id+"' ");
		}
		sql.append("           and m.m_room_id = '"+room_id+"'");
		sql.append("           and ((m.m_begin_time <=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') + numtodsinterval(4,'minute') and");
		sql.append("               m.m_end_time >=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') + numtodsinterval(4,'minute')) or");
		sql.append("               (m.m_begin_time <=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss') - numtodsinterval(4,'minute') and");
		sql.append("               m.m_end_time >=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss') - numtodsinterval(4,'minute')) or");
		sql.append("               (m.m_begin_time >=");//--add begin
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') + numtodsinterval(4,'minute') and");
		sql.append("               m.m_end_time <=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss')  - numtodsinterval(4,'minute')) or");//--add end
		sql.append("               (m.m_begin_time >=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') + numtodsinterval(4,'minute') and");
		sql.append("               m.m_end_time <=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') + numtodsinterval(4,'minute')))) t");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			roomcount = pdb.getInt(0, "roomCount");
			if(roomcount == 0) {
				flag = true;
			}
		}
		return flag;
	}
	
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 isRoomOccupancyBym_notice_id 会议室是否被占用,同一个会议要剔除
	  * @param m_begin_time
	  * @param m_end_time
	  * @param room_id
	  * @param m_notice_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingRoomoccupancyDao#isRoomOccupancyBym_notice_id(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.sql.Connection) 
	  */
	/*public boolean isRoomOccupancyBym_notice_id(String m_begin_time, String m_end_time,
			String room_id, String m_notice_id, Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		int roomcount = 0;
		boolean flag = false;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(m_room_id) as roomCount");
		sql.append("  from (select m.m_room_id");
		sql.append("          from oa_meeting_roomoccupancy m, oa_meeting_room r");
		sql.append("         where m.m_room_id = r.m_room_id");
		sql.append("           and m.m_room_id = '"+room_id+"'");
		sql.append("           and ((m.m_begin_time <=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') and");
		sql.append("               m.m_end_time >=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss')) or");
		sql.append("               (m.m_begin_time <=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss') and");
		sql.append("               m.m_end_time >=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss')) or");
		sql.append("               (m.m_begin_time >=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') and");
		sql.append("               m.m_end_time <=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss')))");
		sql.append("        ");
		sql.append("        union");
		sql.append("        select r.m_room_id");
		sql.append("          from oa_meeting_notice m, oa_meeting_room r");
		sql.append("         where m.m_room_id = r.m_room_id");
		sql.append("           and m.m_check_flag in (4, 5)");
		if(!StringUtil.nullOrBlank(m_notice_id)){
			sql.append("           and m.m_notice_id <> '"+m_notice_id+"' ");
		}
		sql.append("           and m.m_room_id = '"+room_id+"'");
		sql.append("           and ((m.m_begin_time <=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') and");
		sql.append("               m.m_end_time >=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss')) or");
		sql.append("               (m.m_begin_time >=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') and");
		sql.append("               m.m_end_time <=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss')) or");
		sql.append("               (m.m_begin_time <=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss') and");
		sql.append("               m.m_end_time >=");
		sql.append("               to_date('"+m_end_time+"', 'yyyy-mm-dd hh24:mi:ss')) or");
		sql.append("               (m.m_begin_time >=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss') and");
		sql.append("               m.m_end_time <=");
		sql.append("               to_date('"+m_begin_time+"', 'yyyy-mm-dd hh24:mi:ss')))) t");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			roomcount = pdb.getInt(0, "roomCount");
			if(roomcount == 0) {
				flag = true;
			}
		}
		return flag;
	}
*/
}
