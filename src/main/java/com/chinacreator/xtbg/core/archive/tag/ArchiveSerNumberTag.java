package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao;
import com.chinacreator.xtbg.core.wordnumdef.dao.impl.WordNumDefDaoImpl;
import com.chinacreator.xtbg.core.wordnumdef.entity.SerialNumberBean;

/**
 * 
 *<p>Title:ArchiveSerNumberTag.java</p>
 *<p>Description:流水号标签</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2014-1-2
 */
public class ArchiveSerNumberTag extends TagSupport {
	
	private static final Log LOG = LogFactory.getLog(ArchiveSerNumberTag.class);
	
	private static final long serialVersionUID = 1L;

	private String table;//表名
	
	private String column;//字段名
	
	private String style;//样式
	
	private String other;//其他
	
	private String title; //标题
	
	private String value; //值
	
	private String sernumrule; //流水号生成规则
	
	public String getSernumrule() {
		return sernumrule;
	}

	public void setSernumrule(String sernumrule) {
		this.sernumrule = sernumrule;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
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


	public int doEndTag() throws JspException {
		table = table.toUpperCase();
		column = column.toUpperCase();
		if(!StringUtil.isBlank(title)){
			title = title.replace(" ", "&nbsp;");
		}
		BaseInitTag data = (BaseInitTag) this.getParent(); // 获得父标签实例
		StringBuffer inputhtml = new StringBuffer();
		StringBuffer serNumString = new StringBuffer();
		String bottonhtml = "";
		Map<String, List<Map<String, String>>>  archivedate = data.getArchivedata();//公文数据
		Map<String,String> examParam = data.getExamParam();
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
		inputhtml.append("<input type='").append("text").append("' name='").append(table).append(Constant.SEPARATOR).append(column).append("' id='").append(table).append(Constant.SEPARATOR).append(column).append("' ");
		
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
		//如果有规则那么按照规则生成默认值
		if("".equals(value.toString()) && this.sernumrule != null){
			WordNumDefDao wordNumDefDao = new WordNumDefDaoImpl();
			String serNum = "";
			try {
				SerialNumberBean serialNumberBean = wordNumDefDao.findSerialcode(this.sernumrule,null);
				if(serialNumberBean!=null){
					serNum = serialNumberBean.getS_allcode();
					JSONObject serialNumberBeanOBJ = (JSONObject) JSONObject.toJSON(serialNumberBean);
					String serialNumberBeanStr = serialNumberBeanOBJ.toJSONString();
					serNumString.append("<input type='hidden' id ='serialNumberBeanStr' name ='serialNumberBeanStr' value='"+serialNumberBeanStr+"' />");
					serNumString.append("<input type='hidden' id ='isSerialNumberBeanStr' name ='isSerialNumberBeanStr' value='1' />");
				}
			} catch (Exception e) {
				LOG.debug(column + "无法根据规则生成正确的流水号。");
			}
			value.append(serNum);
		}
		//如果有默认值，那么复制默认值
		if("".equals(value.toString()) && this.value != null){
			value.append(this.value);
		}
		String serId = table+Constant.SEPARATOR+column;
		bottonhtml = "<input type='button' class='but_y_01'  style='margin-top:3px;' value='流水号' onclick='serialLSH(\""+sernumrule+"\",\""+serId+"\")' />";
		if(columnDisplayBean.isHide()){//隐藏
			if(style == null){
				inputhtml.append(" style= 'display: none'");
			}else{
				inputhtml.append(" style= 'display: none;").append(style).append("'");
			}
			bottonhtml = "";
		}else{
			if(style != null){
				inputhtml.append(" style= '").append(style).append("'");
			}
		}
		

		if(columnDisplayBean.isReadonly()){//只读
			inputhtml.append(" readonly='readonly' ");
			bottonhtml = "";
		}
		
		if(columnDisplayBean.isDisable()){//禁用
			inputhtml.append(" disabled='disabled' ");
			bottonhtml = "";
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
			pageContext.getOut().write(inputhtml.toString()+bottonhtml+serNumString.toString());
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		return EVAL_PAGE;
	}
}
