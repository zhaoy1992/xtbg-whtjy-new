package com.chinacreator.xtbg.core.meeting.service;

import java.util.List;

import com.chinacreator.xtbg.core.meeting.entity.MeetingTypeBean;

/**
 * 
 *<p>Title:MeetingTypeService.java</p>
 *<p>Description:会议类型管理的service接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-22
 */
public interface MeetingTypeService {

	/**
	 * 
	 *<b>Summary:批量删除会议类型信息 </b> deleteListMeetingtype(请用一句话描述这个方法的作用)
	 * 
	 * @param ids
	 *            会议类型信息id列表
	 * @return 是否删除成功的标志
	 */
	public String deleteListMeetingtype(String ids);

	/**
	 * 
	 *<b>Summary: 根据id查询会议类型信息</b> queryToOAVotePaperBean(请用一句话描述这个方法的作用)
	 * 
	 * @param id
	 *            会议类型id
	 * @return 会议类型bean对象
	 */
	public MeetingTypeBean queryToMeetingTypeBean(String id);

	/**
	 * 
	 *<b>Summary: 插入会议类型</b> insertMeetingTypeBean(请用一句话描述这个方法的作用)
	 * 
	 * @param json
	 *            会议类型的json字符串
	 * @return 是否保存成功的标志
	 */
	public boolean insertMeetingTypeBean(String json);

	/**
	 * 
	 *<b>Summary:更新会议类型</b> insertMeetingTypeBean(请用一句话描述这个方法的作用)
	 * 
	 * @param json
	 *            会议类型的json字符串
	 * @return 是否更新成功的标志
	 */
	public boolean updateMeetingTypeBean(String json);
	   /**
     * 
    *<b>Summary:根据机构id查询会议类型信息 </b>
    * queryListMeetingTypeByOrgId()
    * @param orgId
    * @return
     */
	public List<MeetingTypeBean> queryListMeetingTypeByOrgId(String orgId) ;

}
