package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
/**
 *<p>Title:ArchiveOptionTag.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-9
 */
public class ArchiveOptionTag extends TagSupport {
	
	private static final Log LOG = LogFactory.getLog(ArchiveOptionTag.class);

	private static final long serialVersionUID = 1L;
	
	private String other;
	
	private String optionValue; //option 的选项值 
	
	private String optionName; //option  的选项名称
	
	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}

	public String getOptionValue() {
		return optionValue;
	}

	public void setOptionValue(String optionValue) {
		this.optionValue = optionValue;
	}

	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}

	@Override
	public int doEndTag() throws JspException {
		ArchiveSelectTag data = (ArchiveSelectTag) this.getParent(); // 获得父标签实例
		String defautValue = data.getDefautValue();

		String optionhtml = "<option value='"+optionValue+"' ";
		
		if(optionValue.equals(defautValue)){
			optionhtml += " selected ";
		}
		
		if(other!= null){
			optionhtml += other;
		}
		optionhtml +=">"+optionName+"</option>";
		
		try {
			pageContext.getOut().write(optionhtml);
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		return EVAL_PAGE;
	}
}
