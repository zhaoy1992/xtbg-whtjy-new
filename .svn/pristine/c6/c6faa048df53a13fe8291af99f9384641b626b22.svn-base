package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 *<p>Title:ArchiveDateTag.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-15
 */
public class ArchiveDateTag extends TagSupport {
	
	private static final Log LOG = LogFactory.getLog(ArchiveDateTag.class);
	
	private static final long serialVersionUID = 1L;

	private String table;//表名
	
	private String column;//字段名
	
	private String dateFmt;//日期格式，显示格式
	
	private String minDate;//最小值
	
	private String onpicked;//日期选择联动
	
	private String style;//样式
	
	private String other;//其他属性
	
	private String title; //标题
	
	private String maxDate;//最大值
	
	private String defaultValue;//默认日期 如果取当前日期为sysDate
	
	private String realDateFmt; //真实格式，保存到数据库里的格式 例如 如果dateFmt为yyyy年MM月dd日，那么将无法再数据库中保存为日期类型，那么要将 realDateFmt 设置为对应的yyyy-MM-dd
	
	/**
	 * <b>Summary: </b>
	 *     获取defaultValue的值
	 */
	public String getDefaultValue() {
		return defaultValue;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 defaultValue 的值 
	 * @param defaultvalue 
	 */
	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	public String getRealDateFmt() {
		return realDateFmt;
	}

	public void setRealDateFmt(String realDateFmt) {
		this.realDateFmt = realDateFmt;
	}

	public String getMaxDate() {
		return maxDate;
	}

	public void setMaxDate(String maxDate) {
		this.maxDate = maxDate;
	}

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
		this.table = table;
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}
	
	public String getDateFmt() {
		return dateFmt;
	}

	public void setDateFmt(String dateFmt) {
		this.dateFmt = dateFmt;
	}

	public String getMinDate() {
		return minDate;
	}

	public void setMinDate(String minDate) {
		this.minDate = minDate;
	}

	public String getOnpicked() {
		return onpicked;
	}

	public void setOnpicked(String onpicked) {
		this.onpicked = onpicked;
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
		if(StringUtil.isBlank(realDateFmt)){
			realDateFmt = dateFmt;
		}
		if(!StringUtil.isBlank(title)){
			title = title.replace(" ", "&nbsp;");
		}
		BaseInitTag data = (BaseInitTag) this.getParent(); // 获得父标签实例
		Map<String, List<Map<String, String>>>  archivedate = data.getArchivedata();//公文数据
		//将该日期的FORMAT格式放入隐藏域
		StringBuffer htmlString =  new StringBuffer();
		htmlString.append("<input name='datelist' type='hidden' value='"+table+column+","+(StringUtil.isBlank(realDateFmt)?dateFmt:realDateFmt)+"'/>");
		
		Map<String, Map<String, ColumnDisplayBean>> columnDisplay =   data.getColumnDisplay();//字段表现形式
		ColumnDisplayBean columnDisplayBean = new ColumnDisplayBean();//默认形式
		if(columnDisplay!=null && columnDisplay.containsKey(table) && columnDisplay.get(table).containsKey(column)){
			columnDisplayBean = columnDisplay.get(table).get(column);
		}else{
			LOG.debug(column + "字段没有定义显示形式，  采用默认显示形式");
		}
		String datehtml = "";
		if(!StringUtil.isBlank(title)){
			if(columnDisplayBean.isRequired()){//必填
				datehtml += "<span style='color: red;padding-left:5px;padding-top:10px;float:left;'>*</span><span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>";
			}else{
				datehtml += "<span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>";
			}	
		}
		datehtml += "<input type='text' name='dis_"+table+Constant.SEPARATOR+column+"' id='dis_"+table+Constant.SEPARATOR+column+"'" ;
		
		String onfocusscritp = "onclick= \"WdatePicker({";
		
		if(onpicked != null && !"".equals(onpicked)){
			onfocusscritp += "onpicked:"+onpicked+",";
		}
		
		if(minDate != null && !"".equals(minDate)){
			onfocusscritp += "minDate:'"+minDate+"',";
		}
		if(maxDate != null && !"".equals(maxDate)){
			onfocusscritp += "maxDate:'"+maxDate+"',";
		}
		onfocusscritp += "dateFmt:'"+dateFmt+"',";
		onfocusscritp += "vel:'"+table+Constant.SEPARATOR+column+"'";
		onfocusscritp +="})\" ";
		
		datehtml += onfocusscritp;
		
		List<Map<String, String>> values = archivedate.get(table);//根据表名获取数据  绝大多数为一条数据，少数情况出现多条数据。
		String value = defaultValue;
		if("sysDate".equals(defaultValue)){
			value = DateUtil.getCurrentDateTime();
		}
		
		if(values != null){
			for(Map<String, String> map : values){
				if(map.get(column) != null && !"".equals(map.get(column))){
					value = map.get(column);
				}
			}
		}else{
			LOG.debug(column + "字段  date框没有值");
		}
		
		if(columnDisplayBean.isHide()){//隐藏
			if(style == null){
				datehtml += " style= 'display: none'";
			}else{
				datehtml += " style= 'display: none;"+style+"'";
			}
		}else{
			if(style != null){
				datehtml += " style= '"+style+"'";
			}
		}
		
		if(columnDisplayBean.isReadonly()){//只读
			datehtml += " readonly='readonly'";
		}
		
		if(columnDisplayBean.isDisable()){//禁用
			datehtml += " disabled='disabled' ";
		}
		if(columnDisplayBean.isRequired()){//必填
			datehtml += " class='validate[required]' ";
		}
		//如果日期不为空
		String fmtValue = "";
	    if(!StringUtil.isBlank(value)){
	    	SimpleDateFormat realFmt = new SimpleDateFormat(realDateFmt);//真实的格式
	    	SimpleDateFormat fmt =   new SimpleDateFormat(dateFmt);//显示格式
	    	Date date1 = null;
	    	try {
				//date1 = new Date(StringUtil.convertStringToTimestamp(value, dateFmt).getTime());
	    		date1 = realFmt.parse(value); 
			} catch (ParseException e) {
				LOG.error(e.getMessage(), e);
			}
			if(date1!=null){
				fmtValue = fmt.format(date1);	
			}
	    }
	    
		if(other != null){
			datehtml += other;
		}
		
		datehtml += " value = '"+fmtValue.toString()+"'/>";
		datehtml +=  "<input type='hidden' name='"+table+Constant.SEPARATOR+column+"' id='"+table+Constant.SEPARATOR+column+"' ";
		if(!StringUtil.isBlank(value)){
			datehtml +=	" value = '"+value.toString()+"'";
		}
		datehtml += "/>" ;
		try {
			pageContext.getOut().write(datehtml+htmlString);
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		return EVAL_PAGE;
	}
}
