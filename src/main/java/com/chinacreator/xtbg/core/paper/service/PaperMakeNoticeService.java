package com.chinacreator.xtbg.core.paper.service;

import java.util.Map;

import com.chinacreator.xtbg.core.paper.entity.PaperMakeNoticeBean;

/**
 * 
 *<p>Title:PaperMakeNoticeService.java</p>
 *<p>Description:约稿通知服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-12
 */
public interface PaperMakeNoticeService {

	/**
	 * 
	*<b>Summary: </b>
	* savePaperMakeNotice(保存约稿通知信息)
	* @param bean
	* @return
	 */
	public boolean savePaperMakeNotice(PaperMakeNoticeBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* getMakeNoticeBean(根据id查询约稿通知信息)
	* @param id
	* @return
	 */
	public Map<String, String> getMakeNoticeBean(String id);
	/**
	 * 
	*<b>Summary: </b>
	* sendMakeNoticeMsg(发送约稿通知短信提示)
	* @param bean
	* @return
	 */
	public boolean sendMakeNoticeMsg(PaperMakeNoticeBean bean);
}
