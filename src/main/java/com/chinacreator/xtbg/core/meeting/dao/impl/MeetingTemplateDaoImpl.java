package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingTemplateDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingTemplateBean;
/**
 * 
 *<p>Title:MeetingTemplateDaoImpl.java</p>
 *<p>Description:会议模板接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-29
 */
public class MeetingTemplateDaoImpl extends XtDbBaseDao implements MeetingTemplateDao {

    /**
     * 
      * <b>Summary: </b>
      *     复写方法 findMeetingTemplatePageBean
      * @param bean
      * @param sortName
      * @param sortOrder
      * @param offset
      * @param maxPagesize
      * @return
      * @throws Exception 
      * @see com.chinacreator.xtbg.core.meeting.dao.MeetingTemplateDao#findMeetingTemplatePageBean(com.chinacreator.xtbg.core.meeting.entity.MeetingTemplateBean, java.lang.String, java.lang.String, long, int)
     */
	public PagingBean findMeetingTemplatePageBean(MeetingTemplateBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select m_tmp_id,");
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
			sql.append("       m_is_need_signup,");
			sql.append("       m_tmp_contents,");
			sql.append("       m_tmp_create_time,");
			sql.append("       m_tmp_creator_id,");
			sql.append("       m_tmp_creator_name,");
			sql.append("       m_tmp_unit_id, m_tmp_unit_name ");
			sql.append("  from oa_meeting_template ");
			sql.append("where m_tmp_id is not null and (m_room_id is null or m_room_id IN (select t.m_room_id from OA_MEETING_ROOM t where t.m_is_use_flag=1)) ");
			// 拼接的值
			if (!StringUtil.nullOrBlank(bean.getM_tmp_unit_id())) {
				sql.append("and m_tmp_unit_id=?");
				conditionValues.add(StringUtil.deNull(bean.getM_tmp_unit_id()
						.trim()));
			}
			// 根据名字搜索
			if (!StringUtil.nullOrBlank(bean.getM_title())) {
				sql
						.append("and  m_title  like '%'||?||'%' ");
				conditionValues.add(StringUtil.deNull(bean.getM_title()
						.trim()));
			}
			//根据会议开始时间进行搜索
			if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getM_begin_time()))){
				String beginTime = StringUtil.deNull(bean.getM_begin_time())+" 00:00:00";
				sql.append(" and m_tmp_create_time >= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
				conditionValues.add(beginTime);
			}
			//根据会议开始时间进行搜索
			if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getM_begin_time_end()))){
				String beginTime = StringUtil.deNull(bean.getM_begin_time_end())+" 23:59:59";
				sql.append(" and m_tmp_create_time <= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
				conditionValues.add(beginTime);
			}
			if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getM_type_id()))){
				sql.append(" and m_type_id = ? ");
				conditionValues.add(StringUtil.deNull(bean.getM_type_id()));
			}
			sql.append(" order by " + sortName + " " + sortOrder);

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
}
