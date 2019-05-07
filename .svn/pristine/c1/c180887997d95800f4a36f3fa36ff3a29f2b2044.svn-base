package com.chinacreator.xtbg.core.paper.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.commonlist.PublicAjaxAction;
import com.chinacreator.xtbg.core.paper.entity.PaperMakeNoticeBean;
import com.chinacreator.xtbg.core.paper.service.PaperMakeNoticeService;
import com.chinacreator.xtbg.core.paper.service.impl.PaperMakeNoticeServiceImpl;
/**
 * 
 *<p>Title:PaperNoticeAction.java</p>
 *<p>Description:约稿通知前台请求类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-12
 */
public class PaperNoticeAction extends PublicAjaxAction {

	private static final Log LOG=LogFactory.getLog(PaperNoticeAction.class);
	private PaperMakeNoticeBean makebean;
	/**
	 * 
	*<b>Summary: </b>
	* savePaperNotice(保存约稿通知信息)
	 */
	public void savePaperNotice() {
		try {
			PaperMakeNoticeService service=new PaperMakeNoticeServiceImpl();
			boolean flag = service.savePaperMakeNotice(makebean);
			if (flag) {
				write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
			} else {
				write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);

			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");

		}
	}
	/**
	 * 
	*<b>Summary: </b>
	* sendMSG(发送短信提示)
	 */
	public void sendMSG(){
		try {
			PaperMakeNoticeService service=new PaperMakeNoticeServiceImpl();
			boolean flag = service.sendMakeNoticeMsg(makebean);
			if (flag) {
				write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
			} else {
				write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);

			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");

		}
	}
	public PaperMakeNoticeBean getMakebean() {
		return makebean;
	}
	public void setMakebean(PaperMakeNoticeBean makebean) {
		this.makebean = makebean;
	}

    
	
}
