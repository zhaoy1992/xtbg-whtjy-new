package com.chinacreator.xtbg.core.meeting.action;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.commonlist.PublicAjaxAction;
import com.chinacreator.xtbg.core.common.excel.ExcelUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.impl.MeetingNoticeViewDaoImpl;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;

/**
 * 
 *<p>Title:MeetingExportAction.java</p>
 *<p>Description:会议通知查询，用来导出数据的页面</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-8-28
 */
public class MeetingSearchAction extends PublicAjaxAction{

	/**
	 * 会议通知对象
	 */
	private MeetingNoticeBean bean = null;
	private String exportKey ;//导出要用到的key
	private String exportHeader;//表头数组
	private static final Logger LOG = Logger
	.getLogger(MeetingSearchAction.class);

	/**
	 * 
	*<b>Summary: 导出会议列表数据</b>
	* exportMeeting()
	 */
	@SuppressWarnings("unchecked")
	public void exportMeeting() {
		try {
			PagingBean pb = null;
			// 暂时调用list查询的方法，设置最大可导出一万条数据
			pb = new MeetingNoticeViewDaoImpl().findMeetingNooticePageBean(
					bean, getPage().getSortName(), getPage().getSortOrder(), 0,
					50000);
			List<Map<String, String>> list = (List<Map<String, String>>) pb
					.getList();
			// 导出的列的key
			String[] key = null;
			if (null != exportKey && !StringUtil.nullOrBlank(exportKey)) {
				key = exportKey.split("\\,");
			}
			String[] header = null;
			if (null != exportHeader && !StringUtil.nullOrBlank(exportHeader)) {
				header = exportHeader.split("\\,");
			}
			// 导出工具
			ExcelUtil excel = new ExcelUtil();
			excel.exportExcel(list, header, key, "会议通知", getRequest(),
					getResponse());

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}


	public MeetingNoticeBean getBean() {
		return bean;
	}


	public void setBean(MeetingNoticeBean bean) {
		this.bean = bean;
	}


	public String getExportKey() {
		return exportKey;
	}


	public void setExportKey(String exportKey) {
		this.exportKey = exportKey;
	}


	public String getExportHeader() {
		return exportHeader;
	}


	public void setExportHeader(String exportHeader) {
		this.exportHeader = exportHeader;
	}
	
	
	
}
