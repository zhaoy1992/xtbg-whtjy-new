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
 *<p>Title:ArchiveInputTag.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-7
 */
public class ArchiveInputTag extends TagSupport {
	
	private static final Log LOG = LogFactory.getLog(ArchiveInputTag.class);
	
	private static final long serialVersionUID = 1L;

	private String table;//表名
	
	private String column;//字段名
	
	private String value;//字段默认值
	
	private String type;//input 类型
	
	private String style;//样式
	
	private String other;//其他属性
	
	private String title; //标题
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public int doEndTag() throws JspException {
		table = table.toUpperCase();
		column = column.toUpperCase();
		if(!StringUtil.isBlank(title)){
			title = title.replace(" ", "&nbsp;");
		}
		BaseInitTag data = (BaseInitTag) this.getParent(); // 获得父标签实例
		StringBuffer inputhtml = new StringBuffer();
		Map<String, List<Map<String, String>>>  archivedate = data.getArchivedata();//公文数据
		Map<String,  Map<String, ColumnDisplayBean>> columnDisplay =   data.getColumnDisplay();//字段表现形式
		ColumnDisplayBean columnDisplayBean = new ColumnDisplayBean();//默认形式
		if(columnDisplay!= null && columnDisplay.containsKey(table) && columnDisplay.get(table).containsKey(column)){
			columnDisplayBean = columnDisplay.get(table).get(column);
		}else{
			LOG.debug(column + "字段没有定义显示形式，  采用默认显示形式");
		}
	
		
		if(!StringUtil.isBlank(title)){
			if(columnDisplayBean.isRequired()){//必填
				inputhtml.append("<span style='color: red;padding-left:5px;padding-top:10px;float:left;'>*</span>").append("<span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>");
			}else{
				inputhtml.append("<span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>");
			}	
		}
		inputhtml.append("<input type='").append(type).append("' name='").append(table).append(Constant.SEPARATOR).append(column).append("' id='").append(table).append(Constant.SEPARATOR).append(column).append("' ");
		
		List<Map<String, String>> values = archivedate.get(table);//根据表名获取数据  绝大多数为一条数据，少数情况出现多条数据。
		StringBuffer value = new StringBuffer();
		if(values != null){
			for(Map<String, String> map : values){
				if(map.get(column) != null && !"".equals(map.get(column))){
					value.append(map.get(column));
				}
			}
		}else{
			LOG.debug(column + "字段  input框没有值");
		}
		//环节设置为禁用  某一自动填充的元素是禁用的属性那么就只展示从数据库取回来的数据，不自动填充数据在栏目中 start 
		if(columnDisplayBean.isDisable()){
			
		} else{
			if("".equals(value.toString()) && this.value != null){
				value.append(this.value);
			}
		}
		//环节设置为禁用  某一自动填充的元素是禁用的属性那么就只展示从数据库取回来的数据，不自动填充数据在栏目中 end
		
		if(columnDisplayBean.isHide()){//隐藏
			if(style == null){
				inputhtml.append(" style= 'display: none'");
			}else{
				inputhtml.append(" style= 'display: none;").append(style).append("'");
			}
		}else{
			if(style != null){
				inputhtml.append(" style= '").append(style).append("'");
			}
		}
		
		if(columnDisplayBean.isReadonly()){//只读
			inputhtml.append(" readonly='readonly' ");
		}
		
		if(columnDisplayBean.isDisable()){//禁用
			inputhtml.append(" disabled='disabled' ");
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
				inputhtml.append(" "+other);
			}else{
				inputhtml.append(" "+other);
			}
		}else{
			if(columnDisplayBean.isRequired()){//必填
				inputhtml.append(" class='validate[required]' ");
			}
		}
		
		inputhtml.append(" value = '"+value.toString()+"'/>");
		try {
			pageContext.getOut().write(inputhtml.toString());
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		return EVAL_PAGE;
	}
}
