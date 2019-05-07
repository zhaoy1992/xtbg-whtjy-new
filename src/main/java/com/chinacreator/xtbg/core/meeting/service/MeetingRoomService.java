package com.chinacreator.xtbg.core.meeting.service;

import java.util.List;

import com.chinacreator.xtbg.core.meeting.entity.MeetingRoomBean;

/**
 * 
 *<p>Title:MeetingRoomService.java</p>
 *<p>Description:会议室管理业务接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-25
 */
public interface MeetingRoomService {
	/**
	 * 
	 *<b>Summary:根据id删除会议室 </b> deleteListMeetingRoom(请用一句话描述这个方法的作用)
	 * 
	 * @param ids
	 *            id字符串，用','连接
	 * @return 是否删除成功的提示信息
	 */
	public String deleteListMeetingRoom(String ids);

	/**
	 * 
	 *<b>Summary: 根据id装载会议室数据</b> queryToMeetingTypeBean(请用一句话描述这个方法的作用)
	 * 
	 * @param id
	 *            会议室id
	 * @return 会议室bean对象
	 */
	public MeetingRoomBean queryToMeetingRoomBean(String id);

	/**
	 * 
	 *<b>Summary: 插入会议室</b> insertMeetingRoomBean(请用一句话描述这个方法的作用)
	 * 
	 * @param json
	 *            可转换为会议室持久对象的json字符串
	 * @return
	 */
	public boolean insertMeetingRoomBean(String json);

	/**
	 * 
	 *<b>Summary: 更新会议室</b> insertMeetingRoomBean(请用一句话描述这个方法的作用)
	 * 
	 * @param json
	 *            可转换为会议室持久对象的json字符串
	 * @return
	 */
	public boolean updateMeetingRoomBean(String json);

	/**
	 * 
	 *<b>Summary:根据条件查询会议室信息 </b> queryListMeetingRoom()
	 * 
	 * @param orgId
	 * @return
	 */
	public List<MeetingRoomBean> queryListMeetingRoom(String orgId);
	
	
	/**
	*<b>Summary: </b>
	* isMeetingRoomUsed(判断会议室是否已经被使用)
	* @param json
	* @return 
	*/
	public boolean isMeetingRoomUsed(String json);
}
