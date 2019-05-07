package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 *<p>Title:ArchiveViewTag.java</p>
 *<p>Description:公文意见标签</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-20
 */
public class ArchiveViewTag extends TagSupport {
	
	private static final Log LOG = LogFactory.getLog(ArchiveViewTag.class);
	
	private static final long serialVersionUID = 1L;

	private String table;//表名
	
	private String column;//字段名
	
	private String style;//样式
	
	private String other;//其他
	
	private String rows = "5";//行
	
	private String cols = "20";//列
	
	private String title; //标题
	
	private String cntab; //内容、署名缩进 比如c2,n2 代表 内容缩进2T，名字缩进2T
	
	public String getCntab() {
		return cntab;
	}

	public void setCntab(String cntab) {
		this.cntab = cntab;
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
		if(!StringUtil.isBlank(title)){
			title = title.replace(" ", "&nbsp;");
		}
		ArchiveInitTag data = (ArchiveInitTag) this.getParent(); // 获得父标签实例
		//Map<String, List<Map<String, String>>>  archivedate = data.getArchivedata();//公文数据
		Map<String, Map<String, ColumnDisplayBean>> columnDisplay =   data.getColumnDisplay();//字段表现形式
		//readonly='readonly'
		String name = "YJ"+Constant.SEPARATOR+table+Constant.SEPARATOR+column;
		String areaname = table+Constant.SEPARATOR+column;
		String hisname = "HIS"+Constant.SEPARATOR+table+Constant.SEPARATOR+column;//此变量用于记录初始化意见信息
		//每次将意见框加入init 列表
		String viewList = data.getViewList();
		if(!StringUtil.isBlank(viewList)){
			viewList = viewList+","+name;
		}else{
			viewList = name;
		}
		//取意见值
		data.setViewList(viewList);
		String value = "";
		Map<String,String> viewMap = data.getViewString();
		if(viewMap!=null){
			if(viewMap.containsKey(areaname)){
				value = data.getViewString().get(areaname);
			}
		}
		
		
		
		/*List<Map<String, String>> values = archivedate.get(table);
		StringBuffer value = new StringBuffer();
		if(values != null){
			for(Map<String, String> map : values){
				if(map.get(column) != null && !"".equals(map.get(column))){
					value.append(map.get(column));
				}
			}
		}*/
		ColumnDisplayBean columnDisplayBean = new ColumnDisplayBean();//默认形式
		if(columnDisplay.containsKey(table) && columnDisplay.get(table).containsKey(column)){
			columnDisplayBean = columnDisplay.get(table).get(column);
		}else{
			LOG.debug(column + "字段没有定义显示形式，  采用默认显示形式");
		}
		String buttonhtml  = "";
		if(!StringUtil.isBlank(title)){
			if(columnDisplayBean.isRequired()){//必填
				buttonhtml += "<span style='color: red;padding-left:5px;padding-top:10px;float:left;'>*</span><span style='float:left;padding-left:5px;padding-top:5px;'>"+title+"</span>";
			}else{
				buttonhtml += "<span style='float:left;padding-left:5px;padding-top:5px;'>"+title+"</span>";
			}	
		}
		String textareahtml = "<textarea readonly='readonly' name='"+areaname+"' id='"+areaname+"'  style='"+style+"'  " ;
		 buttonhtml += " <input type='button' class='but_y_01'  value='填写意见' onclick=\"inputidea('"+table+"','"+column+"','"+cntab+"')\" ";
		String hiddenhtml = "<input name='"+name+"' id='"+name+"' type='hidden' /><input name='"+hisname+"' id='"+hisname+"' value = '"+value +"' type='hidden' />" ;
		
		
		if(columnDisplayBean.isHide()){//隐藏
			buttonhtml += " style= 'display: none' ";
			buttonhtml += " readonly='readonly'";
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
			buttonhtml += " style= 'display: none' ";
			buttonhtml += " readonly='readonly'";
		}
		
		if(columnDisplayBean.isDisable()){//禁用
			buttonhtml += " disabled='disabled' ";
		}
		
		buttonhtml += "/>";
		
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
				textareahtml += other;
			}else{
				textareahtml += other;
			}
		}else{
			if(columnDisplayBean.isRequired()){//必填
				textareahtml += " class='validate[required]' ";
			}
		}
		
		textareahtml += ">"+value+"</textarea>";
		try {
			pageContext.getOut().write(buttonhtml+textareahtml+hiddenhtml);
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		
		return EVAL_PAGE;
	}
}
