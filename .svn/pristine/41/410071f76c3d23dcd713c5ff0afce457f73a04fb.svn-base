package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:ArchiveSpanTag.java</p>
 *<p>Description:SPAN文本标签，此字段主要用于处理必填字段的*号</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-12-26
 */
public class ArchiveSpanTag extends TagSupport {
	
	private static final Log LOG = LogFactory.getLog(ArchiveSpanTag.class);
	
	private static final long serialVersionUID = 1L;

	private String table;//表名
	
	private String column;//字段名
	
	private String value;//字段默认值
	
	private String style;//样式
	
	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		this.table = table.toUpperCase();
	}

	public String getColumn() {
		return column.toUpperCase();
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}


	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public int doEndTag() throws JspException {
		table = table.toUpperCase();
		column = column.toUpperCase();
		BaseInitTag data = (BaseInitTag) this.getParent(); // 获得父标签实例
		StringBuffer spanhtml = new StringBuffer();
		Map<String,  Map<String, ColumnDisplayBean>> columnDisplay =   data.getColumnDisplay();//字段表现形式
		ColumnDisplayBean columnDisplayBean = new ColumnDisplayBean();//默认形式
		if(columnDisplay!= null && columnDisplay.containsKey(table) && columnDisplay.get(table).containsKey(column)){
			columnDisplayBean = columnDisplay.get(table).get(column);
		}
	
		
		if(!StringUtil.isBlank(value)){
			if(columnDisplayBean.isRequired()){//必填
				value = "<span style='color: red;padding-top:10px;'> * </span>"+value;
				spanhtml.append("<span style='").append(style).append("'>").append(value).append("</span>");
			}else{
				spanhtml.append("<span style='").append(style).append("'>").append(value).append("</span>");
			}	
		}
		try {
			pageContext.getOut().write(spanhtml.toString());
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		return EVAL_PAGE;
	}
}
