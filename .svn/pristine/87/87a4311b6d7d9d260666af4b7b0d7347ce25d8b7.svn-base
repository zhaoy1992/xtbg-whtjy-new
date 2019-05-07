package com.chinacreator.xtbg.core.meeting.service;

import com.chinacreator.xtbg.core.meeting.entity.MeetingTemplateBean;

/**
 * 
 *<p>Title:MeetingTemplateService.java</p>
 *<p>Description:会议模板管理service接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-29
 */
public interface MeetingTemplateService {
	/**
	 * 
	*<b>Summary: 根据id列表删除会议模板信息</b>
	* deleteListMeetingMinutes()
	* @param ids  id按","拼接
	* @return 是否删除成功的标志 true ：成功 ；false：失败
	 */
	public boolean deleteListMeetingTemplate(String ids);
	/**
	 * 
	*<b>Summary: </b>
	* queryToMeetingTemplateBean()
	* @param id
	* @return
	 */
	public MeetingTemplateBean queryToMeetingTemplateBean(String id);
	/**
	 * 
	*<b>Summary: 插入会议模板</b>
	* insertMeetingTemplate()
	* @param bean 会议模板对象
	* @return 插入是否成功的标志
	 */
	public boolean insertMeetingTemplate(MeetingTemplateBean bean);
	/**
	 * 
	*<b>Summary: 更新会议模板</b>
	* insertMeetingTemplate()
	* @param bean 会议模板对象
	* @return 插入是否成功的标志
	 */
	public boolean updateMeetingTemplate(MeetingTemplateBean bean);
	/**
	 * 
	*<b>Summary: 根据id查询模板信息</b>
	* queryToMeetingTemplateJSON()
	* @param id 模板id
	* @return 返回json字符串
	 */
	public String queryToMeetingTemplateJSON(String id) ;
}
