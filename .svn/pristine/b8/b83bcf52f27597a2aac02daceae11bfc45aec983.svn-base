package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingNoticeViewDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;

/**
 * 
 *<p>Title:MeetingNoticeViewDaoImpl.java</p>
 *<p>Description:会议通知总查询功能dao接口实现类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-4
 */
public class MeetingNoticeViewDaoImpl extends XtDbBaseDao implements MeetingNoticeViewDao{
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findMeetingRoomPageBean
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingNoticeViewDao#findMeetingRoomPageBean(com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findMeetingNooticePageBean(MeetingNoticeBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> values = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select m_notice_id,");
			sql.append("       m_type_id,");
			sql.append("       m_type_name,");
			sql.append("       m_room_id,");
			sql.append("       m_room_name,");
			sql.append("       m_title,");
			sql.append("       to_char(m_begin_time,'yyyy-mm-dd hh24:mi') as m_begin_time,");
			sql.append("       to_char(m_end_time,'yyyy-mm-dd hh24:mi') as m_end_time,");
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
			sql.append("       m_remark,");
			sql.append("       (select count(*)");
			sql.append("          from oa_meeting_minutes b");
			sql.append("         where b.m_notice_id = a.m_notice_id) as minutes,");
			sql.append("       (select c.m_minutes_id");
			sql.append("          from oa_meeting_minutes c");
			sql.append("         where c.m_notice_id = a.m_notice_id");
			sql.append("           and rownum = 1) as m_minute_id");
			sql.append("  from oa_meeting_notice a");
			sql.append(" where a.m_check_flag in ('4', '5')");//状态为已发布或重新发布的才能查询出来
			//会议标题
			if(!StringUtil.nullOrBlank(bean.getM_title())){
				sql.append(" and a.m_title like '%'||?||'%' ");
				values.add(bean.getM_title());
			}
			//会议创建部门
			if(!StringUtil.nullOrBlank(bean.getM_create_dept_id())){
				sql.append(" and a.m_create_dept_id= ? ");
				values.add(bean.getM_create_dept_id());
			}
			//会议创建单位
			if(!StringUtil.nullOrBlank(bean.getM_create_unit_id())){
				sql.append(" and a.M_create_unit_id= ? ");
				values.add(bean.getM_create_unit_id());
			}
			//会议类型
			if(!StringUtil.nullOrBlank(bean.getM_type_id())){
				sql.append(" and  instr (','||?||',',','||a.m_type_name||',')>0  ");
				values.add(bean.getM_type_id().replaceAll("\\(\\@\\)", ","));//将字符替换回来
			}
			//根据会议开始时间进行搜索
			if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getM_begin_time()))){
				String beginTime = StringUtil.deNull(bean.getM_begin_time())+" 00:00:00";
				sql.append(" and a.m_begin_time >= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
				values.add(beginTime);
			}
			//根据会议开始时间进行搜索
			if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getM_begin_time_end()))){
				String beginTime = StringUtil.deNull(bean.getM_begin_time_end())+" 23:59:59";
				sql.append(" and a.m_begin_time <= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
				values.add(beginTime);
			}	
			//排序
			if(!StringUtil.nullOrBlank(sortName)&&!StringUtil.nullOrBlank(sortOrder)){
				sql.append( " order by "+sortName +" " + sortOrder );
			}

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					values);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	public static void main(String []args){
		System.out.println("hahaa(@)haha(@)".replaceAll("(@)", " "));
	}
	
}
