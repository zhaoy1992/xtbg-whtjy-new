package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingMinutesDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingMinutesBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingMinutesReaderBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:MeetingMinuteDaoImpl.java</p>
 *<p>Description:会议纪要持久层操作</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-26
 */
public class MeetingMinutesDaoImpl extends XtDbBaseDao implements MeetingMinutesDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findMeetingMinutePageBean
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingMinuteDao#findMeetingMinutePageBean(com.chinacreator.xtbg.core.meeting.entity.MeetingRoomBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findMeetingMinutePageBean(MeetingMinutesBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer(
					"select p.m_minutes_id, p.m_current_flag, p.m_title," +
					" p.m_reg_user_id, p.m_reg_user_name," +
					" to_char(p.m_reg_time,'yyyy-mm-dd hh24:mi') as m_reg_time," +
					" to_char(p.m_begin_time,'yyyy-mm-dd hh24:mi') as m_begin_time,"+
					" p.m_attach_id, p.m_notice_id, " +
					" (select decode(sum(m_flag),null,'0',sum(m_flag))||'/'||count(m_flag) from "
					+ " oa_meeting_minutes_reader  c where c.m_minutes_id= p.m_minutes_id) as rate "
					+"from oa_meeting_minutes p where  p.m_minutes_id is not null ");

			// 根据根据会议纪要标题搜索
			if (!StringUtil.nullOrBlank(bean.getM_title())) {
				sql.append(" and  p.m_title  like '%'||?||'%' ");
				conditionValues.add(StringUtil.deNull(bean.getM_title()
						.trim()));
			}	
			// 拼接的值
			if (!StringUtil.nullOrBlank(bean.getM_current_flag())) {
				sql.append(" and p.m_current_flag=?");
				conditionValues.add(StringUtil.deNull(bean.getM_current_flag()
						.trim()));
			}
			//根据会议开始时间进行搜索
			if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getM_begin_time()))){
				String beginTime = StringUtil.deNull(bean.getM_begin_time())+" 00:00:00";
				sql.append(" and p.m_begin_time >= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
				conditionValues.add(beginTime);
			}
			//根据会议开始时间进行搜索
			if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getM_begin_time_end()))){
				String beginTime = StringUtil.deNull(bean.getM_begin_time_end())+" 23:59:59";
				sql.append(" and p.m_begin_time <= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
				conditionValues.add(beginTime);
			}				
			
			//根据登记用户id搜索
			if(!StringUtil.nullOrBlank(bean.getM_reg_user_id())){
				sql.append(" and p.m_reg_user_id=?");
				conditionValues.add(StringUtil.deNull(bean.getM_reg_user_id()
						.trim()));
			}
			//根据会议id搜索
			if(!StringUtil.nullOrBlank(bean.getM_notice_id())){
				sql.append(" and p.m_notice_id=?");
				conditionValues.add(StringUtil.deNull(bean.getM_notice_id()
						.trim()));
			}
			if(!StringUtil.nullOrBlank(sortName)&& !StringUtil.nullOrBlank(sortOrder)){
                sql.append(" order by "+sortName+" "+sortOrder);
			}

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findMeetingMinutePageBean4View
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingMinutesDao#findMeetingMinutePageBean4View(com.chinacreator.xtbg.core.meeting.entity.MeetingMinutesBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findMeetingMinutePageBean4View(MeetingMinutesBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select a.m_minutes_id,");
			sql.append("       a.m_current_flag,");
			sql.append("       a.m_title,");
			sql.append("       a.m_reg_user_id,");
			sql.append("       a.m_reg_user_name,");
			sql.append("       to_char(a.m_reg_time, 'yyyy-mm-dd hh24:mi') as m_reg_time,");
			sql.append("       to_char(a.m_begin_time, 'yyyy-mm-dd hh24:mi') as m_begin_time,");
			sql.append("       a.m_attach_id,");
			sql.append("       a.m_notice_id,");
			sql.append("       b.m_flag ");
			sql.append("  from oa_meeting_minutes a ");
			sql.append("  left outer join oa_meeting_minutes_reader b on a.m_minutes_id =b.m_minutes_id");
			sql.append(" where a.m_current_flag = 1 and b.m_user_id = ? ");			
		    conditionValues.add(StringUtil.deNull(bean.getM_reg_user_id()
						.trim()));
			
			// 根据根据会议纪要标题搜索
			if (!StringUtil.nullOrBlank(bean.getM_title())) {
				sql.append(" and  a.m_title  like '%'||?||'%' ");
				conditionValues.add(StringUtil.deNull(bean.getM_title()
						.trim()));
			}
			//根据会议开始时间进行搜索
			if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getM_begin_time()))){
				String beginTime = StringUtil.deNull(bean.getM_begin_time())+" 00:00:00";
				sql.append(" and a.m_begin_time >= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
				conditionValues.add(beginTime);
			}
			//根据会议开始时间进行搜索
			if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getM_begin_time_end()))){
				String beginTime = StringUtil.deNull(bean.getM_begin_time_end())+" 23:59:59";
				sql.append(" and a.m_begin_time <= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
				conditionValues.add(beginTime);
			}
			if(!StringUtil.nullOrBlank(sortName)&& !StringUtil.nullOrBlank(sortOrder)){
                sql.append(" order by "+sortName+" "+sortOrder);
			}

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		}finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertMinutesReader
	  * @param minutesId
	  * @param userIds
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingMinutesDao#insertMinutesReader(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public void insertMinutesReader(String minutesId, String userIds,
			Connection conn) throws Exception{

		PreparedDBUtil pdb = new PreparedDBUtil();
		if (StringUtil.nullOrBlank(minutesId) || StringUtil.nullOrBlank(userIds)) {
			return;
		}
		
		// 插入数据时，增加排序字段		 
		StringBuffer sql = new StringBuffer(
				" insert into oa_meeting_minutes_reader(m_read_id, m_minutes_id,"
						+ " m_user_id, m_user_name, m_flag,order_no) "
						+ " select sys_guid(),?,g.user_id,g.user_realname,'0',rownum"
						+ " from ( "
						+ "  select  u.user_id, "
						+ "              u.user_realname "
						+ "         from (select rownum index_sn, org.org_id, org.org_name "
						+ "                 from td_sm_organization org "
						+ "                start with org.org_id in "
						+ "                           (select org_id "
						+ "                              from td_sm_organization cd "
						+ "                             where cd.parent_id = '0') "
						+ "               connect by prior org.org_id = org.parent_id "
						+ "                order siblings by org.org_sn) o "
						+ "         left join td_sm_orguser ou "
						+ "           on ou.org_id = o.org_id "
						+ "         left join td_sm_user u "
						+ "           on u.user_id = ou.user_id "
						+ "         left join td_sm_userjoborg a "
						+ "          on a.user_id = u.user_id and o.org_id = a.org_id "
						+ "        where u.user_id is not null ");
		// 传入了用户id列表，则插入传入了的id列表
		if (!StringUtil.nullOrBlank(userIds)) {

			String[] idArray = userIds.split(",");
			if (idArray.length < 1000) {
				sql.append(" and u.user_id in (" + userIds + ") ");
			} else {
				// 避免in语句包含的id过多，拼接多个"或"关系的in语句
				sql.append(joinSql(idArray, "u.user_id"));
			}

		}
		sql.append(" order by to_number(index_sn) ,a.same_job_user_sn   ) g");

		pdb.preparedInsert(sql.toString());
		pdb.setString(1, minutesId);
		pdb.executePrepared(conn);
	}

	/**
	 * 
	*<b>Summary: 查询阅读情况的分页信息</b>
	* findMinutesReaderPaginBean()
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findMinutesReaderPaginBean(MeetingMinutesReaderBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		// 创建sql语句
		StringBuffer sql = new StringBuffer();
		try {
			conn = DbManager.getInstance().getConnection();
			sql
					.append("select u.m_read_id, "
							+ "u.m_user_id, "
							+ " u.m_minutes_id, "
							+ "u.m_flag, "
							+ " s.user_realname, "
							+ " to_char(u.m_read_time,'yyyy-mm-dd hh24:mi') as m_read_time, "
							+ " s.user_sn, "
							+ "  s.org_name, "
							+ " s.org_id, "
							+ " s.user_mobiletel1 "
							+ " from (select u.user_id, "
							+ "             u.user_mobiletel1, "
							+ "             o.org_id, "
							+ "             o.org_name, "
							+ "             u.user_realname, "
							+ "            u.user_sn , o.index_sn,a.same_job_user_sn"
							+ "        from (select rownum index_sn, org.org_id, org.org_name "
							+ "                from td_sm_organization org "
							+ "               start with org.org_id in "
							+ "                          (select org_id "
							+ "                             from td_sm_organization cd "
							+ "                            where cd.parent_id = '0') "
							+ "              connect by prior org.org_id = org.parent_id "
							+ "               order siblings by org.org_sn) o "
							+ "        left join td_sm_orguser ou "
							+ "          on ou.org_id = o.org_id "
							+ "        left join td_sm_user u "
							+ "          on u.user_id = ou.user_id  "
							+ "left join td_sm_userjoborg a "
							+ " on a.user_id = u.user_id and o.org_id = a.org_id "
							+ "       where u.user_id is not null "
							+ "       order by to_number(index_sn), u.user_sn) s "
							+ " right join oa_meeting_minutes_reader u "
							+ "  on u.m_user_id = s.user_id"
							+ "						 where u.m_minutes_id is not null ");
			List<String> sqlCondition = new ArrayList<String>();
			// 查询条件不为空则拼接查询条件
			if (!StringUtil.nullOrBlank(bean.getM_flag())) {
				sql.append(" and u.m_flag = ? ");
				sqlCondition.add(bean.getM_flag().trim());
			}
			if (!StringUtil.nullOrBlank(bean.getM_minutes_id())) {
				sql.append(" and u.m_minutes_id = ? ");
				sqlCondition.add(bean.getM_minutes_id().trim());
			}
			// 排序字段不为空，则将排序拼接到sql
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" order by " + sortName + " " + sortOrder);
			} else {
				sql
						.append(" order by  to_number(s.index_sn),s.same_job_user_sn,s.user_sn");
			}

			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					sqlCondition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findMeetingNotice4minutes
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingMinutesDao#findMeetingNotice4minutes(com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findMeetingNotice4minutes(MeetingNoticeBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
				throws Exception {
			Connection conn = null;
			// 创建sql语句
			StringBuffer sql = new StringBuffer();
			//分页对象
			PagingBean pb = new PagingBean();
			try {
				conn = DbManager.getInstance().getConnection();
				sql.append("select a.m_notice_id, a.m_title,");
				sql.append("to_char(a.m_begin_time,'yyyy-mm-dd hh24:mi') as m_begin_time");
				sql.append("  from oa_meeting_notice a");
				sql.append(" where a.m_begin_time <= sysdate");
				//取发布状态或重新发布状态的数据（状态详情见常量类MeetingConstants）
				sql.append("   and (a.m_check_flag = '4' or a.m_check_flag = '5')");				
				List<String> sqlCondition = new ArrayList<String>();
				// 查询条件不为空则拼接查询条件
				if (!StringUtil.nullOrBlank(bean.getM_create_dept_id())) {
					sql.append("   and a.m_create_dept_id = ? ");
					sqlCondition.add(bean.getM_create_dept_id());
				}
				if (!StringUtil.nullOrBlank(bean.getM_create_unit_id())) {
					sql.append("   and a.m_create_unit_id = ? ");
					sqlCondition.add(bean.getM_create_unit_id());
				}
				
				/*if (!StringUtil.nullOrBlank(bean.getM_receiver_user_ids())) {
					sql.append("  and (','||a.m_receiver_user_ids||',' like '%,"+StringUtil.deNull(bean.getM_receiver_user_ids())+",%' )");
				}*/
				 
				//按会议标题查询
				if(!StringUtil.nullOrBlank(bean.getM_title())){
					sql.append("   and a.m_title like '%'||?||'%' ");
					sqlCondition.add(bean.getM_title());
				}
				//排序
				if(!StringUtil.nullOrBlank(sortName)&& !StringUtil.nullOrBlank(sortOrder)){
	                sql.append(" order by "+sortName+" "+sortOrder);
				}
				pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
						sqlCondition);
				return pb;
			} finally {
				DbManager.closeConnection(conn);
			}
	}

	/**
	 * 
	 *<b>Summary: in 语句最多一次只能存在1000条记录，避免报错，拼接or连接多个in </b>
	 * joinSql(请用一句话描述这个方法的作用)
	 * 
	 * @param idArray
	 *            id数据
	 * @param column
	 *            执行in查询的列
	 * @return
	 */
	private String joinSql(String[] idArray, String column) {

		StringBuffer sql = new StringBuffer();

		sql.append(" and( " + column + " in ( ");
		// 拼接sql
		for (int i = 0; i < idArray.length; i++) {

			// 第一千条或最后一条不拼接分隔符","
			if ((i + 1) % 1000 == 0 || i == idArray.length - 1) {
				sql.append(idArray[i]);
			} else {
				sql.append(idArray[i] + ",");
			}
			// 超过1000条，则拼接 or 语句
			if ((i + 1) % 1000 == 0) {
				sql.append(" ) or " + column + " in ( ");
			}
		}

		sql.append(" ) )");

		return sql.toString();
	}
}
