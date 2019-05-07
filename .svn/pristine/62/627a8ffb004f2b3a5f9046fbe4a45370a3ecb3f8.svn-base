package com.chinacreator.xtbg.core.notice.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeAuditBean;

/**
 * 
 *<p>Title:NoticeBaseInfoDao.java</p>
 *<p>Description:通知公告基本信息Dao接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-19
 */
public interface NoticeBaseInfoDao {

	/**
	 * 
	*<b>Summary: </b>
	* getNoticeBaseInfoBean(查询通知公告基本信息)
	* @param n_notice_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getNoticeBaseInfoBean(String n_notice_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getNoticeBaseInfoBean(查询通知公告已审核基本信息)
	* @param n_notice_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getNoticeIsAuditBaseInfoBean(String n_notice_id,String id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getNoticeBaseInfoBean(查询通知公告已审核基本信息)
	* @param n_notice_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<NoticeAuditBean> getNoticeAuditBeanView(String n_notice_id,Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* selTempNoticeList(查询公告草稿列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selNoticeTempList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* selTempNoticeList(查询公告未审核列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selNoticeAuditList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* selTempNoticeList(查询公告已审核列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selNoticeIsAuditList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* selNoticeReleasedList(查询公告已发布列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selNoticeReleasedList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* selNoticeViewSituation(公告接收人查看情况)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selNoticeViewSituation(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception; 
	
	/**
	 * 
	*<b>Summary: </b>
	* selUserNoViewAndViewCount(查询接收人查看数统计)
	* @param n_notice_id
	* @return
	* @throws Exception
	 */
	public String selUserNoViewAndViewCount(String n_notice_id, Connection conn) throws Exception;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* selNoticeViewSituation(接收人查看详细)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean setNoticeViewDetail(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* selTempNoticeList(公告查看列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selNoticeViewList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* selNoticeAndMeetingViewList(等待阅读)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean selNoticeAndMeetingViewList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* selNoticeReportAuditList(公告评论列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selNoticeReportAuditList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getNoticeReportAuditBean(查询公告栏评论信息)
	* @param noticereportauditbean
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String,String> getNoticeReportAuditBean(String report_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteNoticeReportsById(删除评论信息 根据评论ID)
	* @param report_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public String deleteNoticeReportsById(String report_id,Connection conn) throws Exception;
	
}
