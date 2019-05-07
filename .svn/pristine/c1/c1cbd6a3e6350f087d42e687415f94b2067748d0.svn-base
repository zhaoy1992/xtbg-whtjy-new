package com.chinacreator.xtbg.core.meeting.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingRoomBean;

/**
 * 
 *<p>Title:MeetingRoomDao.java</p>
 *<p>Description:会议室管理dao接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-24
 */
public interface MeetingRoomDao {
	/**
	 * 
	 *<b>Summary: 根据条件查询会议室列表</b> findMeetingTypePageBean(请用一句话描述这个方法的作用)
	 * 
	 * @param bean
	 *            会议室对象，存放查询条件
	 * @param sortName
	 *            排序字段
	 * @param sortOrder
	 *            排序序列（升序，降序等）
	 * @param offset
	 *            当前页数
	 * @param maxPagesize
	 *            总页数
	 * @return 会议室列表分页对象
	 * @throws Exception
	 */
	public PagingBean findMeetingRoomPageBean(MeetingRoomBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;

	/**
	 * 
	 *<b>Summary:判断会议室是否已经被使用 </b> isMeetingTypeUsed(请用一句话描述这个方法的作用)
	 * 
	 * @param id
	 *            会议室id
	 * @param conn
	 *            数据库连接
	 * @return 是否存在的表示， true ：已经被使用 false：尚未被使用
	 * @throws SQLException
	 *             数据库操作
	 */
	public boolean isMeetingRoomUsed(String id, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary:批量插入会议室管理员信息 </b> insertRoomAdministor(请用一句话描述这个方法的作用)
	 * 
	 * @param roomId
	 *            会议室id
	 * @param userIds
	 *            管理员id列表，以 逗号（,）拼接
	 * @param conn
	 *            数据库连接对象
	 * @throws SQLException
	 */
	public void insertRoomAdministor(String roomId, String userIds,
			Connection conn) throws SQLException;

	/**
	 * 
	 *<b>Summary:根据条件查询会议室信息 </b> queryListMeetingRoom()
	 * 
	 * @param orgId
	 *            机构id
	 * @param con
	 *            数据库连接
	 * @return List<MeetingRoomBean>形式的会议室数据集合
	 */
	public List<MeetingRoomBean> queryListMeetingRoom(String orgId,
			Connection con) throws Exception;
}
