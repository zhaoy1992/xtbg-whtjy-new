package com.chinacreator.xtbg.core.meeting.util;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;

/**
 * 
 *<p>Title:MeetingUtil.java</p>
 *<p>Description:会议的工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-10
 */
public class MeetingUtil {

	public void MeetingMsgDo(MeetingNoticeBean meetingNoticeBean){
		String is_sms=meetingNoticeBean.getIs_sms();
		String is_mail=meetingNoticeBean.getIs_mail();
		String is_msg=meetingNoticeBean.getIs_msg();
		String is_rtx=meetingNoticeBean.getIs_rtx();
		if(StringUtil.isBlank(is_sms)){
			is_sms="0";
		}
		if(StringUtil.isBlank(is_mail)){
			is_mail="0";
		}
		if(StringUtil.isBlank(is_msg)){
			is_msg="0";
		}
		if(StringUtil.isBlank(is_rtx)){
			is_rtx="0";
		}
		meetingNoticeBean.setIs_sms(is_sms);
		meetingNoticeBean.setIs_mail(is_mail);
		meetingNoticeBean.setIs_msg(is_msg);
		meetingNoticeBean.setIs_rtx(is_rtx);
	}
}
