package com.chinacreator.xtbg.core.notice.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.notice.entity.NoticeAuditBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeBaseInfoBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeMsgBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeReportAuditBean;

/**
 * 
 *<p>Title:NoticeHandleServiceIfc.java</p>
 *<p>Description:通用公告处理服务类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-18
 */
public interface NoticeHandleServiceIfc {

	/**
	 * 
	*<b>Summary: </b>
	* handleNotic(通知公告处理)
	* @param noticeBaseInfoBean
	* @param noticMsgBean
	* @return
	 */
	public boolean handleNotice(NoticeBaseInfoBean noticeBaseInfoBean, NoticeMsgBean noticMsgBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* getNoticeBaseInfoBean(查询公告信息)
	* @param n_notice_id
	* @return
	 */
	public Map<String, String> getNoticeBaseInfoBean(String n_notice_id);
	/**
	 * 
	*<b>Summary: </b>
	* getNoticeBaseInfoBean(查询公告审核意见信息)
	* @param n_notice_id
	* @return
	 */
	public List<NoticeAuditBean> getNoticeAuditBeanView(String n_notice_id);
	/**
	 * 
	*<b>Summary: </b>
	* getNoticeBaseInfoBean(查询公告信息)
	* @param n_notice_id
	* @return
	 */
	public Map<String, String> getNoticeIsAuditBaseInfoBean(String n_notice_id,String id);
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteNotice(删除通知公告信息)
	* @param n_notice_ids
	* @return
	 */
	public boolean deleteNotice(String n_notice_ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* getUserNoViewAndViewCount(查询接收人查看数统计)
	* @param n_notice_id
	* @return
	 */
	public String selUserNoViewAndViewCount(String n_notice_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* cacelRelease(取消发布)
	* @param n_notice_ids
	* @return
	 */
	public boolean cacelRelease(String n_notice_ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateNoticeReceiverUserState(修改接收人查看状态)
	* @param n_receiverid
	 */
	public void updateNoticeReceiverUserState(String n_receiverid);
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteNoticeReceiverUser(删除接收人通知)
	* @param n_receiverids
	* @return
	 */
	public boolean deleteNoticeReceiverUser(String n_receiverids);
	
	/**
	*<b>Summary: </b>
	* findInfoReportAudit(根据评论ID 查询评论信息)
	* @param report_id
	* @return
	 */
	public  Map<String,String> findInfoReportAudit(String report_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateNoticeReportBean(增加和修改评论信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateNoticeReportBean(NoticeReportAuditBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteNoticeReportBeanByid(根据评论ID 删除评论信息)
	* @param bean
	* @return
	 */
	public String deleteNoticeReportBeanByid(String[] bean_ids);
	
	

	
}
