package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingRoomDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingRoomBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:MeetingRoomDaoImpl.java
 * </p>
 *<p>
 * Description:会议室管理的dao接口实现类
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-24
 */
public class MeetingRoomDaoImpl extends XtDbBaseDao implements MeetingRoomDao{

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
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingRoomDao#findMeetingRoomPageBean(com.chinacreator.xtbg.core.meeting.entity.MeetingRoomBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findMeetingRoomPageBean(MeetingRoomBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer(
					" select m_room_id, m_room_code,"
							+ " m_room_name, m_unit_id, m_address, m_people_num, "
							+ " m_dept_id, m_dept_name,m_is_need_check, m_reg_user_id,m_unit_name, "
							+ " m_reg_user_name, to_char(m_reg_time,'YYYY-mm-dd') "
							+ " as m_reg_time, m_remark,m_is_use_flag,administrator_ids,administrator_names from "
							+ " oa_meeting_room where m_room_id is not null ");
			// 拼接的值
			if (!StringUtil.nullOrBlank(bean.getM_unit_id())) {
				sql.append("and m_unit_id=?");
				conditionValues.add(StringUtil.deNull(bean.getM_unit_id()
						.trim()));
			}
			// 根据会议室名字或地址搜索
			if (!StringUtil.nullOrBlank(bean.getM_room_name())) {
				sql.append("and  m_room_name  like '%'||?||'%'");
				conditionValues.add(StringUtil.deNull(bean.getM_room_name()
						.trim()));
			}
			if(!StringUtil.nullOrBlank(bean.getM_address())){
				sql.append("and  m_address like '%'||?||'%' ");
				conditionValues.add(StringUtil.deNull(bean.getM_address()
						.trim()));
			}
			sql.append(" order by " + sortName + " " + sortOrder);

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	
	/**
	 * 
	*<b>Summary:判断会议室是否已经被引用 </b>
	* isMeetingTypeUsed(请用一句话描述这个方法的作用)
	* @param id  会议室id
	* @param conn 数据库连接
	* @return    是否存在的表示， true ：已经被使用  false：尚未被使用
	* @throws SQLException 数据库操作
	 */
	public boolean isMeetingRoomUsed(String id, Connection conn)
			throws SQLException {

		if (StringUtil.nullOrBlank(id)) {
			return false;
		}
		StringBuffer sql = new StringBuffer("select count(*) count"
				+ " from oa_meeting_notice where m_room_id = ?");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, id.trim());
		pdb.executePrepared(conn);
		if (pdb.size() >= 0) {
			// 得到记录数
			int count = pdb.getInt(0, 0);
			// 存在一条及以上被引用的记录，则返回true，表示会议类型已经被使用
			if (count > 0) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 
	*<b>Summary:批量插入会议室管理员信息 </b>
	* insertRoomAdministor(请用一句话描述这个方法的作用)
	* @param roomId  会议室id
	* @param userIds 管理员id列表，以 逗号（,）拼接
	* @param conn    数据库连接对象
	* @throws SQLException
	 */
	public void insertRoomAdministor(String roomId,String userIds,Connection conn) throws SQLException{

		PreparedDBUtil pdb = new PreparedDBUtil();
		if (StringUtil.nullOrBlank(roomId) || StringUtil.nullOrBlank(userIds)) {
			return;
		}		
		// 批量插入语句
		StringBuffer sql = new StringBuffer(
				"insert into oa_meeting_room_administrator "
						+ " (m_id, m_user_id, m_user_name, m_room_id) "
						+ " select sys_guid(),user_id,user_realname,? as m_room_id "
						+ " from td_sm_user where user_id is not null "
						+ " and instr (','||?||',',','||user_id||',')>0");
						
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, roomId);
		pdb.setString(2, userIds);
		pdb.executePrepared(conn);	
	}
	
	/**
	 * 
	*<b>Summary:根据条件查询会议室信息 </b>
	* queryListMeetingRoom()
	* @param orgId 机构id
	* @param con   数据库连接
	* @return List<MeetingRoomBean>形式的会议室数据集合
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingRoomBean> queryListMeetingRoom(String orgId,Connection con) throws Exception{
		StringBuffer sql = new StringBuffer(
				" select m_room_id, m_room_code,"
						+ " m_room_name, m_unit_id, m_address, m_people_num, "
						+ " m_dept_id, m_is_need_check, m_reg_user_id,m_unit_name, "
						+ " m_reg_user_name, to_char(m_reg_time,'YYYY-mm-dd') "
						+ " as m_reg_time, m_remark,m_is_use_flag from "
						+ " oa_meeting_room where m_is_use_flag='1' and m_unit_id = ? ");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, orgId);
		
		return pdb.executePreparedForList(con, MeetingRoomBean.class);
	}
}
