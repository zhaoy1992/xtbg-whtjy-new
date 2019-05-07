package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 *<p>Title:ArchiveAffixButTag.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-9
 */
public class ArchiveAffixButTag extends TagSupport{

	private static final Log LOG = LogFactory.getLog(ArchiveAffixButTag.class);
	
	private static final long serialVersionUID = 1L;

	private String table;//表名
	
	private String column;//字段名
	
	private String butName; //按钮显示内容
	
	private String title; //标题
	
	private String typeFilter;
	
	private String operType; //操作按钮
	
	private String addCallBackJsFn;//回调
	
	private String delCallBackJsFn;//回调
	
	private String convertToTif;
	/**
	 * 为归档而初始化附件ID(DJBH编号)<br>
	 * (归档需要提前生成附件内容)
	 */
	private String initFjDJBHForArchive;
	public String getDelCallBackJsFn() {
		if(delCallBackJsFn==null||delCallBackJsFn.length()==0){
			return "''";
		}
		return delCallBackJsFn;
	}

	public void setDelCallBackJsFn(String delCallBackJsFn) {
		this.delCallBackJsFn = delCallBackJsFn;
	}

	public String getAddCallBackJsFn() {
		if(addCallBackJsFn==null||addCallBackJsFn.length()==0){
			return "''";
		}
		return addCallBackJsFn;
	}

	public void setAddCallBackJsFn(String addCallBackJsFn) {
		this.addCallBackJsFn = addCallBackJsFn;
	}
	
	public String getOperType() {
		return operType;
	}

	public void setOperType(String operType) {
		this.operType = operType;
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
	
	public String getButName() {
		return butName;
	}

	public void setButName(String butName) {
		this.butName = butName;
	}
	
	

	@Override
	public int doEndTag() throws JspException {
		table = table.toUpperCase();
		column = column.toUpperCase();
		if(!StringUtil.isBlank(title)){
			title = title.replace(" ", "&nbsp;");
		}
		
		String path  =((HttpServletRequest)pageContext.getRequest()).getContextPath();
		
		BaseInitTag data = (BaseInitTag) this.getParent(); // 获得父标签实例
		Map<String, List<Map<String, String>>>  archivedate = data.getArchivedata();//公文数据
		Map<String, Map<String, ColumnDisplayBean>> columnDisplay =   data.getColumnDisplay();//字段表现形式
		ColumnDisplayBean columnDisplayBean = new ColumnDisplayBean();//默认形式
		if(columnDisplay!=null && columnDisplay.containsKey(table) && columnDisplay.get(table).containsKey(column)){
			columnDisplayBean = columnDisplay.get(table).get(column);
		}else{
			LOG.debug(column + "字段没有定义显示形式，  采用默认显示形式");
		}
		Map<String,String> examParam = data.getExamParam();
		List<Map<String, String>> values = archivedate.get(table);//根据表名获取数据  绝大多数为一条数据，少数情况出现多条数据。
		StringBuffer value = new StringBuffer(); //默认值为新的uuid
		if(values != null){
			for(Map<String, String> map : values){
				if(map.get(column) != null && !"".equals(map.get(column))){
					value.append(map.get(column));
				}
			}
		}else{
			LOG.debug(column + "字段  input框没有值");
		}
		if(StringUtil.isBlank(value.toString()) ){
			if(StringUtil.isBlank(initFjDJBHForArchive)){
				value.append(UUID.randomUUID().toString());
			}else{
				//归档时,附件编号生成时间提前(归档需要提前准备附件内容)
				value.append(initFjDJBHForArchive);
			}
		}
		//LOG.info("附件编号id=="+value.toString());
		String html = "";
		if(!StringUtil.isBlank(title)){
			if(columnDisplayBean.isRequired()){//必填
				html += "<span style='color: red;padding-left:5px;padding-top:10px;float:left;'>*</span><span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>";
			}else{
				html += "<span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>";
			}	
		}
		html += "<script type=\"text/javascript\"> jQuery(function() {";
		
		
		boolean ismodify = true;
		if(columnDisplayBean.isDisable() || columnDisplayBean.isReadonly()){//如果是只读，或者不可用
			ismodify = false;
		}
		if(StringUtil.isBlank(operType)){
			operType ="111";
		}
		if(columnDisplayBean.isDisable()|| columnDisplayBean.isReadonly()|| columnDisplayBean.isHide()){//如果是只读，那么对附件进行控制
			operType ="011";
		}
		if(examParam!=null){
			String initType = examParam.get("initType"); //父标签中取得环节类型4为只读打开。
			if("4".equals(initType)){//如果是只读，那么对附件进行控制
				operType ="011";
			}
		}
		
		html += "MyFancyupload.createUpload('_fileshow', '#_filebut', '"+path+"', '"
				+path+"/servlet/pubFileUpload?buessid="+value.toString()+"', "+ismodify+", '"+value.toString()+"',"+this.getTypeFilter()+","+this.getAddCallBackJsFn()+",'"+operType+"',"+this.getDelCallBackJsFn()+","+this.getConvertToTif()+");";
		if(columnDisplayBean.isDisable()|| columnDisplayBean.isReadonly()){
			html += "jQuery(\".swiff-uploader-box\").hide()";
			butName = "";
		}
		
		html += "});</script>";
		//把10px改成0px 是为了修改档案管理中的文件管理中附件，与请选择再同一行中对不齐的问题  add by lixing
		html += "<span style='float:left;padding-left:5px;padding-top:5px;'><a href=\"#\" id=\"_filebut\" >"+butName+"</a></span>";
		html += "<input type='hidden' id='"+table+Constant.SEPARATOR+column+"' name='"+table+Constant.SEPARATOR+column+"' value='"+value.toString()+"'/>" ;
		
		try {
			pageContext.getOut().write(html);
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		
		return EVAL_PAGE;
	}

	public String getConvertToTif() {
		if(convertToTif==null||convertToTif.length()==0){
			return "false";
		}
		return convertToTif;
	}

	public void setConvertToTif(String convertToTif) {
		this.convertToTif = convertToTif;
	}

	public String getTypeFilter() {
		if(typeFilter==null||typeFilter.length()==0){
			return "''";
		}
		return typeFilter;
	}

	public void setTypeFilter(String typeFilter) {
		this.typeFilter = typeFilter;
	}

	public String getInitFjDJBHForArchive() {
		return initFjDJBHForArchive;
	}

	public void setInitFjDJBHForArchive(String initFjDJBHForArchive) {
		this.initFjDJBHForArchive = initFjDJBHForArchive;
	}

	


}
