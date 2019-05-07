package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.DBUtil;

/**
 *<p>Title:ArchiveSelectTag.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-7
 */
public class ArchiveSelectTag extends TagSupport {
	
	private static final Log LOG = LogFactory.getLog(ArchiveSelectTag.class);
	
	private static final long serialVersionUID = 1L;
	
	private String table;//表名
	
	private String column;//字段名
	
	private String style;//样式
	
	private String optionsql;//选项的sql
	
	private String other;//其他属性
	
	private String initDefautValue;//初始化默认值
	
	private String defautValue;//默认选中的值
	
	private String title; //标题
	
	private String dictType; //字典
	
	private String hiddenName; //2013-07-19 hai.huang 定义一个隐藏域
	
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

	public String getOptionsql() {
		return optionsql;
	}

	public void setOptionsql(String optionsql) {
		this.optionsql = optionsql;
	}

	public String getInitDefautValue() {
		return initDefautValue;
	}

	public void setInitDefautValue(String initDefautValue) {
		this.initDefautValue = initDefautValue;
	}

	public String getDefautValue() {
		return defautValue;
	}

	public void setDefautValue(String defautValue) {
		this.defautValue = defautValue;
	}
	

	public String getDictType() {
		return dictType;
	}

	public void setDictType(String dictType) {
		this.dictType = dictType;
	}

	public String getHiddenName() {
		return hiddenName;
	}

	public void setHiddenName(String hiddenName) {
		this.hiddenName = hiddenName;
	}

	@Override
	public int doStartTag() throws JspException {
		table = table.toUpperCase();
		column = column.toUpperCase();
		if(!StringUtil.isBlank(title)){
			title = title.replace(" ", "&nbsp;");
		}
		BaseInitTag data = (BaseInitTag) this.getParent(); // 获得父标签实例
		Map<String, List<Map<String, String>>>  archivedate = data.getArchivedata();//公文数据
		Map<String, Map<String, ColumnDisplayBean>> columnDisplay = data.getColumnDisplay();//字段表现形式
		ColumnDisplayBean columnDisplayBean = new ColumnDisplayBean();//默认形式
		if(columnDisplay!=null && columnDisplay.containsKey(table) && columnDisplay.get(table).containsKey(column)){
			columnDisplayBean = columnDisplay.get(table).get(column);
		}else{
			LOG.debug(column + "字段没有定义显示形式，  采用默认显示形式");
		}
		
		
		StringBuffer selecthtml = new StringBuffer();
		StringBuffer hiddenhtml = new StringBuffer();//2013-07-19 hai.huang 定义一个隐藏域
		boolean haveValInhiddenHtml = false;
		if(!StringUtil.isBlank(title)){
			if(columnDisplayBean.isRequired()){//必填
				selecthtml.append("<span style='color: red;padding-left:5px;padding-top:10px;float:left;'>*</span>").append("<span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>");
			}else{
				selecthtml.append("<span style='float:left;padding-left:5px;padding-top:10px;'>"+title+" </span>");
			}	
		}
		selecthtml.append("<select name='").append(table).append(Constant.SEPARATOR).append(column).append("' ");
		selecthtml.append("  id='").append(table).append(Constant.SEPARATOR).append(column).append("' ");
		
		
		
		
		StringBuffer value = new StringBuffer();
		List<Map<String, String>> values = archivedate.get(table);
		if(values != null){
			for(Map<String, String> map : values){
				if(map.get(column) != null && !"".equals(map.get(column))){
					value.append(map.get(column));
				}
			}
		}
		
		
		if(!"".equals(value.toString())){//如果产生了业务数据，则默认值为 value
			defautValue = value.toString();
		}
		
		
		
		if(columnDisplayBean.isHide()){//隐藏
			if(style == null){
				selecthtml.append(" style= 'display: none'");
			}else{
				selecthtml.append(" style= 'display: none;").append(style).append("'");
			}
		}else{
			if(style != null){
				selecthtml.append(" style= '").append(style).append("'");
			}
		}
		
		if(columnDisplayBean.isReadonly()){//只读
			selecthtml.append(" readonly='readonly'");
		}
		if(columnDisplayBean.isDisable()){//禁用
			selecthtml.append(" disabled='disabled' ");
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
				selecthtml.append(other);
			}else{
				selecthtml.append(other);
			}
		}else{
			if(columnDisplayBean.isRequired()){//必填
				selecthtml.append(" class='validate[required]' ");
			}
		}
		
		
		//new edit hai.huang 2013-07-18 加字典类型的select查询 详见方法注释  ----   begin
		String[][] arrs = null;
		if (!StringUtil.nullOrBlank(dictType)){
			arrs = queryDictDataByType(StringUtil.deNull(dictType));
		}else{
			if(optionsql != null && !"".equals(optionsql)){
				arrs = queryDictData(optionsql);
			}
		}
		if(arrs!=null){//标签负责数据源
			boolean isFirst = true;
			String hv = "";
			
			if (!StringUtil.nullOrBlank(hiddenName)){//要设隐藏域时
				selecthtml.append(" onchange=setHiddenValue(this,\'"+table+Constant.SEPARATOR+hiddenName+"\') ");
				selecthtml.append(" >");
				hiddenhtml.append("<input type='hidden' id ='").append(table).append(Constant.SEPARATOR).append(hiddenName).append("' ");
				hiddenhtml.append(" name ='").append(table).append(Constant.SEPARATOR).append(hiddenName).append("' ");
			}else{
				selecthtml.append(" >");
			}
			for(String[] ar : arrs){
				selecthtml.append("<option value='").append(ar[0]).append("' ");
				if(defautValue != null && defautValue.equals(ar[0])){
					selecthtml.append(" selected ");
					if (!StringUtil.nullOrBlank(hiddenName)){//要设隐藏域时
						hiddenhtml.append(" value='").append(ar[1]).append("' ");
						haveValInhiddenHtml = true;
					}
				}else if (!StringUtil.nullOrBlank(hiddenName) && isFirst){//没有默认值defautValue时隐藏域标签的处理：加第一个项作为隐藏域的初始值
					hv=ar[1];
				}
				selecthtml.append(" > ").append(ar[1]).append("</option>");
				isFirst = false;
			}
			if (!StringUtil.nullOrBlank(hiddenName)){//要设隐藏域时
				if(!haveValInhiddenHtml){
					hiddenhtml.append(" value='").append(hv).append("' ");
				}
				hiddenhtml.append("/>");
			}
		}else{
			if (!StringUtil.nullOrBlank(hiddenName)){//要设隐藏域时
				selecthtml.append(" onchange=setHiddenValue(this,\'"+table+Constant.SEPARATOR+hiddenName+"\') ");
				selecthtml.append(" >");
				hiddenhtml.append("<input type='hidden' id ='").append(table).append(Constant.SEPARATOR).append(hiddenName).append("' ");
				hiddenhtml.append(" name ='").append(table).append(Constant.SEPARATOR).append(hiddenName).append("' ");
				hiddenhtml.append(" /> ");
			}else{
				selecthtml.append(" >");
			}
		}
		
		
		//new edit  ---------------------------------------------------      end
		
		if(initDefautValue !=null && !"".equals(initDefautValue)){
			selecthtml.append("<option value=''> ").append(initDefautValue).append("</option>");
		}
		try {
			if (!StringUtil.nullOrBlank(hiddenName)){//要设隐藏域时
				pageContext.getOut().write(hiddenhtml.toString()+selecthtml.toString());
			}else{
				pageContext.getOut().write(selecthtml.toString());
			}
			
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		
		if(optionsql != null && !"".equals(optionsql)){
			return EVAL_PAGE ;
		}else{
			return EVAL_BODY_INCLUDE;
		}
	}
	
	@Override
	public int doEndTag() throws JspException {
		try {
			pageContext.getOut().write(" </select> ");
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		return super.doEndTag();
	}

	/**
	*<b>Summary: </b>
	* queryDictData(查询字典数据)
	* @param sql 查询数据的sql语句，其中只查询两个值，字典数据的id和value
	* @return 二维数组
	*/
	private String[][] queryDictData(String sql){
		String[][] arr = null;
		try {
			DBUtil db = new DBUtil();
			db.executeSelect(sql);
			if(db.size()>0){
				arr = new String[db.size()][2];
				for(int i=0; i<db.size();i++){
					arr[i][0] = db.getString(i, 0).trim();
					arr[i][1] = db.getString(i, 1).trim();
				}
			}
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}
		return arr;
	}
	
	
	/**
	*<b>Summary: </b>
	* queryDictDataByType(根据字典类型查询字典数据项)
	* @param dictType
	* @return 
	*/
	private String[][] queryDictDataByType(String dictType){
		String sql = "select d.dictdata_value, d.dictdata_name";
		sql       += "  from OA_DICT_DATA d, OA_DICT_TYPE t ";
		sql       += " where t.dict_code = '"+dictType+"' ";
		sql       += "   and d.dict_id = t.dict_id ";
		sql       += "   and t.dict_is_valid = 1 ";
		sql       += "   and d.dictdata_is_valid = 1 order by d.dictdata_order";
		String[][] arr = null;
		try {
			DBUtil db = new DBUtil();
			db.executeSelect(sql);
			if(db.size()>0){
				arr = new String[db.size()][2];
				for(int i=0; i<db.size();i++){
					arr[i][0] = db.getString(i, 0).trim();
					arr[i][1] = db.getString(i, 1).trim();
				}
			}
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}
		return arr;
	}
}
