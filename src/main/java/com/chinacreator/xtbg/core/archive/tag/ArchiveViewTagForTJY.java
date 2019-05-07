package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *公文管理->页面意见标签  特检院专用
 *<p>Title:ArchiveViewTagTJY.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-6-15
 */
public class ArchiveViewTagForTJY extends TagSupport {
	
	private static final Log LOG = LogFactory.getLog(ArchiveViewTagForTJY.class);
	
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
		//0
		table = table.toUpperCase();
		column = column.toUpperCase();
		if(!StringUtil.isBlank(title)){
			title = title.replace(" ", "&nbsp;");
		}
		
		String areaname = table + Constant.SEPARATOR + column;  // TEXTAREA 的名字,用于显示存储在当前位置的 当前的意见 + 历史的意见
		String name = "YJ" + Constant.SEPARATOR + areaname;		// INPUT[hidden] 的名字, 用于存储当前的意见
		String hisname = "HIS" + Constant.SEPARATOR + areaname; // INPUT[hidden] 的名字, 用户存储 历史的意见
		
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String insId = request.getParameter("ins_id");
		ArchiveInitTagForTJY data = (ArchiveInitTagForTJY) this.getParent();
		
		//获得DB配置
		Map<String, Map<String, ColumnDisplayBean>> columnDisplay = data.getColumnDisplay();
		ColumnDisplayBean columnDisplayBean = null;
		if(columnDisplay.containsKey(table)
				&& columnDisplay.get(table).containsKey(column)){
			columnDisplayBean = columnDisplay.get(table).get(column);
		}else{
			columnDisplayBean = new ColumnDisplayBean();
			LOG.debug(column + "字段没有定义显示形式，  采用默认显示形式");
		}
		//获得数据
		String allVal = data.getAllViewByLocation(areaname); 
		String thisViewVal = data.getThisActionViewByLocation(areaname);
		String historyViewVal = data.getHistoryViewByLocation(areaname);
		//1:将该意见名字 登记到 ArchiveInitTagForTJY
		data.appendViewList(name);
		//2:编辑HTML
		//2.1：button HTML
		String buttonHTML = this.createBtnHTMLCode(columnDisplayBean,allVal,insId);
		//2.2: textarea HTML
		String textareaHTML = this.createTextAreaHTMLCode(columnDisplayBean,areaname,allVal);
		//2.3: hidden HTML
		String hiddenHTML = this.createHiddenTHMLCode(columnDisplayBean,name,thisViewVal,hisname,historyViewVal);
		
		try {
			//3
			pageContext.getOut().write(buttonHTML+textareaHTML+hiddenHTML);
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		
		return EVAL_PAGE;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * createHiddenTHMLCode()
	 * @param columnDisplayBean  DB配置
	 * @param name 当前环节的意见值的存放处
	 * @param thisViewVal 当前环节的意见
	 * @param hisname 历史意见存放处
	 * @param historyViewVal 历史意见值
	 * @return
	 */
	private String createHiddenTHMLCode(ColumnDisplayBean columnDisplayBean,
			String name, 
			String thisViewVal, 
			String hisname,
			String historyViewVal) {
		StringBuffer code = new StringBuffer();
		code.append("<input name='").append(name)
		.append("' id='").append(name)
		.append("' type='hidden' ");
		if(!StringUtil.nullOrBlank(thisViewVal)){
			code.append("value='").append(thisViewVal).append("'");
		}
		code.append("/>");
		
		code.append("<input name='").append(hisname)
		.append("' id='").append(hisname)
		.append("' type='hidden' ");
		if(!StringUtil.nullOrBlank(historyViewVal)){
			code.append("value='").append(historyViewVal).append("'");
		}
		code.append("/>");
		return code.toString();
	}

	private String createTextAreaHTMLCode(ColumnDisplayBean columnDisplayBean,
			String areaname, String allVal) {
		StringBuffer code = new StringBuffer();
		code.append("<textarea readonly='readonly' name='").append(areaname)
		.append("' id='").append(areaname).append("' ");
		
		if(columnDisplayBean.isHide()){
			if(this.style==null){
				code.append("style='display: none' ");
			}else{
				code.append("style='display: none;").append(style).append("' ");
			}
		}else{
			if(this.style!=null){
				code.append("style='").append(style).append("' ");
			}
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
				code.append(other);
			}else{
				code.append(other);
			}
		}else{
			if(columnDisplayBean.isRequired()){//必填
				code.append("class='validate[required]' ");
			}
		}
		
		code.append(">").append(allVal).append("</textarea>");
		return code.toString();
	}

	private String createBtnHTMLCode(ColumnDisplayBean columnDisplayBean,String allVal,String insId) {
		StringBuffer code = new StringBuffer();
		if(!StringUtil.isBlank(this.title)){
			if(columnDisplayBean.isRequired()){//必填
				code.append("<span style='color: red;padding-left:5px;padding-top:10px;float:left;'>*</span>");
			}
			code.append("<span style='float:left;padding-left:5px;padding-top:5px;'>");
			code.append(title);
			code.append("</span>");
		}
		
		code.append("<input type='button' class='but_y_01'  value='填写意见' onclick=\"inputidea('"+table+"','"+column+"','"+cntab+"')\"");
		if(columnDisplayBean.isHide()
				||columnDisplayBean.isReadonly()){
			code.append(" style= 'display: none' ");
			code.append(" readonly='readonly' ");
		}else if(columnDisplayBean.isDisable()){
			code.append(" disabled='disabled' ");
		}
		code.append("/>");
		
		if(allVal.length()>0
				&&!columnDisplayBean.isHide()){
		code.append("<span style='display:block;float: left;'>&nbsp;&nbsp;</span>");
		code.append("<input type='button' class='but_y_01'  value='详细意见' onclick=\"inputideaareaJS.showAllView('"+insId+"','"+table+"','"+column+"')\"");
		code.append("/>");
		}
		return code.toString();
	}
}
