package com.chinacreator.xtbg.core.meeting.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.meeting.entity.MeetingMsgLogBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoteTemplateBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUserBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingTopicBean;

/**
 * 
 *<p>Title:MeetingHandleServiceIfc.java</p>
 *<p>Description:会议处理服务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-22
 */
public interface MeetingHandleServiceIfc {

	/**
	 * 
	*<b>Summary: </b>
	* tempNotice(会议暂存)
	* @param meetingNoticeBean
	* @param meetingTopicBeanList
	* @return
	 */
	public boolean tempNotice(MeetingNoticeBean meetingNoticeBean, List<MeetingTopicBean> meetingTopicBeanList, MeetingMsgLogBean meetingMsgLogBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* sentMenting(会议送审)
	* @param meetingNoticeBean
	* @param meetingTopicBeanList
	* @return
	 */
	public boolean sentMeeting(MeetingNoticeBean meetingNoticeBean, List<MeetingTopicBean> meetingTopicBeanList, MeetingMsgLogBean meetingMsgLogBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* checkMeeting(会议审批操作)
	* @param checkState
	* @param meetingNoticeBean
	* @return
	 */
	public boolean checkMeeting(String checkState, MeetingNoticeBean meetingNoticeBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* recoverMeeting(会议追回)
	* @param m_notice_id
	* @return
	 */
	public boolean recoverMeeting(String m_notice_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* releaseMenting(会议发布)
	* @param meetingNoticeBean
	* @param meetingTopicBeanList
	* @param meetingMsgLogBean
	* @return
	 */
	public boolean releaseMeeting(MeetingNoticeBean meetingNoticeBean, List<MeetingTopicBean> meetingTopicBeanList, MeetingMsgLogBean meetingMsgLogBean);
	
	
	/**
	*<b>Summary: </b>
	* reissueMeeting(会议补发)
	* @param meetingNoticeBean
	* @param reissue_receiver_unit_names
	* @param reissue_receiver_user_names
	* @param reissue_receiver_unit_ids
	* @param reissue_receiver_user_ids
	* @param reissue_receiver_other_unit_names
	* @param reissue_receiver_other_user_names
	* @param reissue_receiver_other_unit_ids
	* @param reissue_receiver_other_user_ids
	* @param meetingTopicBeanList
	* @param meetingMsgLogBean
	* @return 
	*/
	public boolean reissueMeeting(MeetingNoticeBean meetingNoticeBean,
			String reissue_receiver_unit_names,
			String reissue_receiver_user_names,
			String reissue_receiver_unit_ids,
			String reissue_receiver_user_ids,
			String reissue_receiver_other_unit_names, 
			String reissue_receiver_other_user_names, 
			String reissue_receiver_other_unit_ids, 
			String reissue_receiver_other_user_ids,
			String m_other_user_input,
			MeetingMsgLogBean meetingMsgLogBean);
	
	
	/**
	*<b>Summary: </b>
	* callsendMeeting(会议催发)
	* @param m_notice_id
	* @param userids
	* @param unitids
	* @param meetingMsgLogBean
	* @return 
	*/
	public boolean callsendMeeting(String m_notice_id, String userids, String unitids, MeetingMsgLogBean meetingMsgLogBean, String users);
	

	/**
	 * 
	*<b>Summary: </b>
	* resendNotice(会议重发)
	* @param meetingNoticeBean
	* @param meetingTopicBeanList
	* @param meetingMsgLogBean
	* @return
	 */
	public boolean resendNotice(MeetingNoticeBean meetingNoticeBean, List<MeetingTopicBean> meetingTopicBeanList, MeetingMsgLogBean meetingMsgLogBean, String m_is_need_resignup);
	
	/**
	*<b>Summary: </b>
	* revocationMeeting(会议撤销)
	* @param m_notice_id
	* @param meetingMsgLogBean
	* @param m_user_id
	* @param m_user_name
	* @return 
	*/
	public boolean revocationMeeting(String m_notice_id, MeetingMsgLogBean meetingMsgLogBean,String m_user_id,String m_user_name);
	
	/**
	 * 
	*<b>Summary: </b>
	* viewMeetingDetail(查询会议详细信息)
	* @param sourceState
	* @param m_notice_id
	* @return
	 */
	public Map<String, Object> viewMeetingDetail(String sourceState, String m_notice_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* viewMeeting(会议查看)
	* @param m_notice_id
	* @param m_receiver_id
	* @param m_receiver_unit_id
	* @param m_is_read
	* @return
	 */
	public Map<String, Object> viewMeeting(String m_notice_id, String m_receiver_id, String m_receiver_unit_id, String m_is_read);
	
	/**
	 * 
	*<b>Summary: </b>
	* signupMeeting(会议报名)
	* @param signupState
	* @param meetingReceiverUserBean
	* @return
	 */
	public boolean signupMeeting(String signupState, MeetingReceiverUserBean meetingReceiverUserBean,MeetingMsgLogBean meetingMsgLogBean);
	
	
	/**
	*<b>Summary: </b>
	* getMeetingNoticeBean(查询会议通知基本信息byId)
	* @param m_notice_id
	* @param conn
	* @return 
	*/
	public Map<String, String> getMeetingNoticeBean(String m_notice_id);
	
	
	/**
	*<b>Summary: </b>
	* getMeetingMsgLogMap(查询会议通知信息发送情况byId)
	* @param m_notice_id
	* @return 
	*/
	public Map<String, String> getMeetingMsgLogMap(String m_notice_id);
	
	
	
	/**
	*<b>Summary: </b>
	* getMeetingTopicBeanListMap(查询会议议题byId)
	* @param m_notice_id
	* @return 
	*/
	public List<Map<String, String>> getMeetingTopicBeanListMap(String m_notice_id);
	
	
	/**
	*<b>Summary: </b>
	* getMeetingReceiver(查询人员会议接收信息)
	* @param m_notice_id
	* @param m_user_id
	* @return 
	*/
	public Map<String, String> getMeetingReceiverInfo(String m_notice_id, String m_user_id);
	
	
	/**
	*<b>Summary: </b>
	* updateReadInfo(更新用户已读状态信息)
	* @param m_notice_id
	* @return 
	*/
	public void updateReadInfo(String m_receiver_id);
	
	
	/**
	*<b>Summary: </b>
	* deleteMeeting(删除会议)
	* @param m_notice_ids
	* @return 
	*/
	public boolean deleteMeeting(String m_notice_ids);
	
	
	/**
	*<b>Summary: </b>
	* deleteListMeetingNoteTemplate(删除短信模板)
	* @param ids
	* @return 
	*/
	public String deleteListMeetingNoteTemplate(String ids);
	
	
	/**
	*<b>Summary: </b>
	* getMeetingNoteTemplateBeanById(查询短信模板明细)
	* @param m_id
	* @return 
	*/
	public MeetingNoteTemplateBean getMeetingNoteTemplateBeanById(String m_id);
	
	
	/**
	*<b>Summary: </b>
	* updateMeetingNoteTemplateBean(保存短信模板)
	* @param json
	* @return 
	*/
	public boolean updateMeetingNoteTemplateBean(String json);
	
	
	/**
	*<b>Summary: </b>
	* getMeetingNoticeInfo(查询会议信息)
	* @param m_notice_id
	* @param m_receiver_user_id
	* @return 
	*/
	public Map<String, String> getMeetingNoticeInfo(String m_notice_id, String m_receiver_user_id);
	
	
	/**
	*<b>Summary: </b>
	* checkreleaseMeeting(审核并发布)
	* @param checkState
	* @param meetingNoticeBean
	* @param meetingMsgLogBean
	* @return 
	*/
	public boolean checkreleaseMeeting(String checkState,MeetingNoticeBean meetingNoticeBean,MeetingMsgLogBean meetingMsgLogBean);
	
	
	/**
	*<b>Summary: </b>
	* getKbmDocBeanById(由主键m_notice_id得到MeetingNoticeBean)
	* @param m_notice_id
	* @return 
	*/
	public MeetingNoticeBean getMeetingNoticeBeanById(String m_notice_id);
	
}
