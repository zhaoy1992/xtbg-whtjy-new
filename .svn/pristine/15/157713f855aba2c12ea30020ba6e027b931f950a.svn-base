package com.chinacreator.xtbg.core.archive.tag;

import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao;
import com.chinacreator.xtbg.core.dssave.dao.impl.DsCRUDDaoImpl;
/**
 * 
 *<p>Title:ArchiveIsMsgTag.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-31
 */

public class ArchiveIsMsgTag extends TagSupport{
	private static final Log LOG = LogFactory.getLog(ArchiveIsMsgTag.class);
	
	private String title; //标题
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	private static final long serialVersionUID = 1L;

	@Override
	public int doEndTag() throws JspException {
		if(!StringUtil.isBlank(title)){
			title = title.replace(" ", "&nbsp;");
		}
		BaseInitTag data = (BaseInitTag) this.getParent(); // 获得父标签实例
		Map<String,String> examParam = data.getExamParam();
		String action_id = examParam.get("action_id"); //父标签中取得环节ID；
		try {
			String htmlString = "";
			if(!StringUtil.isBlank(title)){
				htmlString += "<span style='float:left;padding-left:5px;padding-top:10px;'>"+title;
				htmlString += " <input type='checkbox' name='isdxtx' value ='1'>&nbsp;短信&nbsp;&nbsp;&nbsp;&nbsp;";
				htmlString += " <input type='checkbox' name='isjsxx' value ='1'>&nbsp;即时信息</span>";
			}else{
				htmlString += "<span style='float:left;padding-left:5px;padding-top:10px;'>";
				htmlString += " <input type='checkbox' name='isdxtx' value ='1'>&nbsp;短信&nbsp;&nbsp;&nbsp;&nbsp;";
				htmlString += " <input type='checkbox' name='isjsxx' value ='1'>&nbsp;即时信息</span>";
			}
			
			// 根据环节ID 获取短信配置信息
			String msgTxt = "";
			if(!StringUtil.isBlank(action_id)){
				msgTxt = getMsgInfo(action_id);
			}
			htmlString += "<input type='hidden' name='msg_txt' value='"+ msgTxt +"' />" ;
			pageContext.getOut().write(htmlString);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		
		return EVAL_PAGE;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getMsgInfo(获取环节短信配置)
	* @param action_id
	* @return
	* @throws Exception
	 */
	private String getMsgInfo(String action_id) throws Exception{
		String msgTxt = "";
		DsCRUDDao dao = new DsCRUDDaoImpl();
		Map<String, String>  textContorl = dao.getTextContorlInfo(action_id, null);
		if(textContorl.containsKey("msg_txt")){
			msgTxt = textContorl.get("msg_txt");
		}
		return msgTxt;
	}
}
