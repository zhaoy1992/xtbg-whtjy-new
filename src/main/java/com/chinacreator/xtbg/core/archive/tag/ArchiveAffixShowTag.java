package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 *<p>Title:ArchiveAffixShowTag.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-9
 */
public class ArchiveAffixShowTag extends TagSupport{
	private static final Log LOG = LogFactory.getLog(ArchiveAffixShowTag.class);
	
	private String title; //标题
	
	private String style;//样式
	
	private String ulstyle;//样式
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	
	/**
	 * <b>Summary: </b>
	 *     获取style的值
	 * @return style 
	 */
	public String getStyle() {
		return style;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 style 的值 
	 * @param style 
	 */
	public void setStyle(String style) {
		this.style = style;
	}

	/**
	 * <b>Summary: </b>
	 *     获取ulstyle的值
	 * @return ulstyle 
	 */
	public String getUlstyle() {
		return ulstyle;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 ulstyle 的值 
	 * @param ulstyle 
	 */
	public void setUlstyle(String ulstyle) {
		this.ulstyle = ulstyle;
	}



	private static final long serialVersionUID = 1L;

	@Override
	public int doEndTag() throws JspException {
		if(!StringUtil.isBlank(title)){
			title = title.replace(" ", "&nbsp;");
		}
		String htmlString = "";
		if(!StringUtil.isBlank(title)){
			htmlString += "<span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>";
		}
		if(!StringUtil.isBlank(style)&&!StringUtil.isBlank(ulstyle)){
			htmlString += "<div style='"+style+"'><ul style='"+ulstyle+"' id=\"_fileshow\" name=\"_fileshow\" ></div>";
		} else {
			htmlString += "<div style=\"height:29px;line-height:29px; background-color: white;\"><ul style=\"overflow-y: auto;overflow-x:hidden;height:29px;line-height:29px;margin:1px ;padding-left:10px;background:white;border:0px;max-height:29px;background:white;border:0;\" id=\"_fileshow\" ></div>";
		}
		try {
			pageContext.getOut().write(htmlString);
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		
		return EVAL_PAGE;
	}
}
