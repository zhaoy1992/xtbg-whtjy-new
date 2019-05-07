package com.chinacreator.xtbg.core.meeting.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingMinutesBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingMinutesReaderBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;

/**
 * 
 *<p>Title:MeetingMinuteDao.java</p>
 *<p>Description:会议纪要持久层操作接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-26
 */
public interface MeetingMinutesDao {
	/**
	 * 
	 *<b>Summary: 根据条件查询会议纪要列表</b> findMeetingMinutePageBean(请用一句话描述这个方法的作用)
	 * 
	 * @param bean
	 *            会议纪要对象，存放查询条件
	 * @param sortName
	 *            排序字段
	 * @param sortOrder
	 *            排序序列（升序，降序等）
	 * @param offset
	 *            当前页数
	 * @param maxPagesize
	 *            总页数
	 * @return 列表分页对象
	 * @throws Exception
	 */
	public PagingBean findMeetingMinutePageBean(MeetingMinutesBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;

	/**
	 * 
	 *<b>Summary:批量插入会议纪要阅读人员信息 </b> insertMinutesReader(请用一句话描述这个方法的作用)
	 * 
	 * @param minuteId
	 *            会议纪要id
	 * @param userIds
	 *            人员id列表
	 * @param conn
	 *            数据库连接
	 */
	public void insertMinutesReader(String minuteId, String userIds,
			Connection conn) throws Exception;
	
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
			throws Exception;

	/**
	 * 
	*<b>Summary: 阅读人员接收会议纪要列表</b>
	* findMeetingMinutePageBean4View()
	* @param bean   会议纪要对象
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findMeetingMinutePageBean4View(MeetingMinutesBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception ;

	/**
	 * 
	*<b>Summary:查询其可选的会议记录 </b>
	* findMeetingNotice4minutes()
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findMeetingNotice4minutes(MeetingNoticeBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
}
