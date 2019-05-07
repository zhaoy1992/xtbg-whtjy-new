package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 *<p>Title:ArchiveTextareaTag.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-7
 */
public class ArchiveTextareaTag extends TagSupport {
	
	private static final Log LOG = LogFactory.getLog(ArchiveTextareaTag.class);
	
	private static final long serialVersionUID = 1L;

	private String table;//表名
	
	private String column;//字段名
	
	private String style;//样式
	
	private String other;//其他
	
	private String rows = "5";//行
	
	private String cols = "20";//列
	
	private String title; //标题
	
	/**
	 * <b>Summary: </b>
	 *     获取title的值
	 * @return title 
	 */
	public String getTitle() {
		return title;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 title 的值 
	 * @param title 
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		this.table = table;
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}

	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}

	public String getCols() {
		return cols;
	}

	public void setCols(String cols) {
		this.cols = cols;
	}

	public int doEndTag() throws JspException {
		table = table.toUpperCase();
		column = column.toUpperCase();
		BaseInitTag data = (BaseInitTag) this.getParent(); // 获得父标签实例
		Map<String, List<Map<String, String>>>  archivedate = data.getArchivedata();//公文数据
		Map<String, Map<String, ColumnDisplayBean>> columnDisplay =   data.getColumnDisplay();//字段表现形式
		ColumnDisplayBean columnDisplayBean = new ColumnDisplayBean();//默认形式
		if(columnDisplay!=null && columnDisplay.containsKey(table) && columnDisplay.get(table).containsKey(column)){
			columnDisplayBean = columnDisplay.get(table).get(column);
		}else{
			LOG.debug(column + "字段没有定义显示形式，  采用默认显示形式");
		}
		StringBuffer titlehtml = new StringBuffer();
		if(!StringUtil.isBlank(title)){
			if(columnDisplayBean.isRequired()){//必填
				titlehtml.append("<span style='color: red;padding-left:5px;padding-top:10px;float:left;'>*</span>").append("<span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>");
			}else{
				titlehtml.append("<span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>");
			}	
		}
		String textareahtml = titlehtml.toString()+ "<textarea id='"+table+Constant.SEPARATOR+column+"' name='"+table+Constant.SEPARATOR+column+"'" ;
		List<Map<String, String>> values = archivedate.get(table);
		StringBuffer value = new StringBuffer();
		if(values != null){
			for(Map<String, String> map : values){
				if(map.get(column) != null && !"".equals(map.get(column))){
					value.append(map.get(column));
				}
			}
		}
	
		
		if(columnDisplayBean.isHide()){//隐藏
			if(style == null){
				textareahtml += " style= 'display: none'";
			}else{
				textareahtml += " style= 'display: none;"+style+"'";
			}
		}else{
			if(style != null){
				textareahtml += " style= '"+style+"'";
			}
		}
		
		if(columnDisplayBean.isReadonly()){//只读
			textareahtml += " readonly='readonly'";
		}
		
		if(columnDisplayBean.isDisable()){//禁用
			textareahtml += " disabled='disabled' ";
		}
		
		if(other != null){
			if(columnDisplayBean.isRequired()){//必填
				String reg = "class\\s*=\\s*\'.*?\'";//查找class='' 的字符串
				String classStr = StringUtil.getRegStr(reg, other);
				if(!StringUtil.isBlank(classStr)){
					String reg2 = "\'.*\'";//查找''里的内容
					String classInStr = StringUtil.getRegStr(reg2, classStr);
					if(!StringUtil.isBlank(classInStr)){
						String str = classInStr.substring(0, classInStr.length()-1)+" validate[required]"+"'"; //在这里加上必填验证
						other = other.replace(classInStr, str);
					}
				}
				textareahtml = textareahtml +" "+other;
			}else{
				textareahtml = textareahtml +" "+other;
			}
		}else{
			if(columnDisplayBean.isRequired()){//必填
				textareahtml = textareahtml + " class='validate[required]' ";
			}
		}
		
		textareahtml += ">"+value+"</textarea>";
		
		try {
			pageContext.getOut().write(textareahtml);
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		
		return EVAL_PAGE;
	}
}