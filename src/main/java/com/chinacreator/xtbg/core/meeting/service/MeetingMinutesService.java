package com.chinacreator.xtbg.core.meeting.service;

import com.chinacreator.xtbg.core.meeting.entity.MeetingMinutesBean;

/**
 * 
 *<p>Title:MeetingMinutesService.java</p>
 *<p>Description:会议纪要处理接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-26
 */
public interface MeetingMinutesService {
	/**
	 * 
	*<b>Summary: 根据id查询得到会议纪要对象</b>
	* queryToMeetingMinutesBean(请用一句话描述这个方法的作用)
	* @param id  会议纪要id
	* @return    会议纪要对象
	 */
	public MeetingMinutesBean queryToMeetingMinutesBean(String id);
	
	/**
	 * 
	*<b>Summary: 插入会议纪要</b>
	* insertMeetingRoomBean(请用一句话描述这个方法的作用)
	* @param bean 会议纪要对象
	* @return 是否插入成功的标示
	 */
	public boolean insertMeetingMinutesBean(MeetingMinutesBean bean);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateMeetingMinutesBean(请用一句话描述这个方法的作用)
	* @param bean 会议纪要对象
	* @return
	 */
	public boolean updateMeetingMinutesBean(MeetingMinutesBean bean);
	
	/**
	 * 
	*<b>Summary: 根据会议纪要id和用户id更新用户阅读信息</b>
	* updateMeetingMinutesReader()
	* @param minutesId 会议纪要id
	* @param userId    用户id    
	 */
	public void updateMeetingMinutesReader(String minutesId,String userId);

	/**
	 * 
	*<b>Summary: 根据id列表删除会议纪要信息</b>
	* deleteListMeetingMinutes()
	* @param ids  id按","拼接
	* @return 是否删除成功的标志 true ：成功 ；false：失败
	 */
	public boolean deleteListMeetingMinutes(String ids) ;
}
