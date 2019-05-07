package com.chinacreator.xtbg.core.common.util;

import java.sql.SQLException;

import com.frameworkset.common.poolman.DBUtil;

/**
 *<p>Title:DictDropDownList.java</p>
 *<p>Description:字典数据下拉框工具类</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2011-6-30
 */
public class DictDropDownList {
	
	/**
	*<b>Summary: </b>
	* buildSelect(查询字典数据生成下拉框)
	* @param sql  查询数据的sql语句，其中只查询两个值，字典数据的id和value
	* @param selectName 下拉框的名称
	* @param selectedOptionName  被选中的值
	* @param onchangeNethodName  onchange事件调用的js函数名称
	* @param sign  为0 标识 如果没有被选中的值，添加默认的空值---请选择--- 其他则不添加
	* @param defaultNullString 可自己制定默认空值的字符串显示，如果没有值，则显示---请选择---
	* @return
	* @throws SQLException 
	*/
	public static String buildSelect(String sql,String selectName,String selectedOptionName, String onchangeNethodName, boolean sign,String defaultNullString) throws SQLException {
		String str = "";
		 String[][]  dictData = queryDictData(sql);
		if (dictData == null) {
			StringBuffer strBuf = new StringBuffer();
			strBuf.append("<select  id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='width:188px;' class='select_188_box' size='1'>")
				.append("<option  value='' selected >");
				if(StringUtil.nullOrBlank(defaultNullString)){
					strBuf.append("---请选择---");
				}else{
					strBuf.append(defaultNullString);
				}
				strBuf.append("</option>")
				.append("</select>");
				str += strBuf.toString();
			return str;
		} else {
			boolean selected = false;
			
			str = "<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='width:188px;' class='select_188_box' size='1'>";
			StringBuffer strBuf = new StringBuffer();
			for (int i = 0; i < dictData.length; i++) {
				String [] arr = dictData[i];
				String select = selectedOptionName.equalsIgnoreCase(arr[0])?"selected":"";
				if(select.length()>0){
					selected=true;
				}
				strBuf.append("<option  " + select);
				if(!StringUtil.nullOrBlank(arr[0])){
					strBuf.append(" value='"+ arr[0] +"'");
				}
				strBuf.append(">"+ arr[1] + "</option>");
			}
			if(sign){
				str+="<option  value='' ";
				if(!selected){
					str += "selected";
				}
				if(StringUtil.nullOrBlank(defaultNullString)){
					str+=">---请选择---</option>";
				}else{
					str+=">"+defaultNullString+"</option>";
				}
				
			}
			str += strBuf.toString()+"</select> ";
		}
		return str;
	}

	
	public static  String buildSelect(String sql,String selectName,String selectedOptionName, String onchangeNethodName, boolean sign,String defaultNullString,String selectStyle) throws SQLException {
		String str = "";
		 String[][]  dictData = queryDictData(sql);
		if (dictData == null) {
			StringBuffer strBuf = new StringBuffer();
			strBuf.append("<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' class='"+selectStyle+"' >")
				.append("<option value='' selected >");
				if(StringUtil.nullOrBlank(defaultNullString)){
					strBuf.append("---请选择---");
				}else{
					strBuf.append(defaultNullString);
				}
				strBuf.append("</option>")
				.append("</select>");
				str += strBuf.toString();
			
			return str;
		} else {
			boolean selected = false;
			str = "<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='"+selectStyle+"'>";
			StringBuffer strBuf = new StringBuffer();
			for (int i = 0; i < dictData.length; i++) {
				String [] arr = dictData[i];
				String select = selectedOptionName.equalsIgnoreCase(arr[0])?"selected":"";
				if(select.length()>0){
					selected=true;
				}
				strBuf.append("<option  " + select);
				if(!StringUtil.nullOrBlank(arr[0])){
					strBuf.append(" value='"+ arr[0] +"'");
				}
				strBuf.append(">"+ arr[1] + "</option>");
			}
			if(sign){
				str+="<option  value='' ";
				if(!selected){
					str += "selected";
				}
				if(StringUtil.nullOrBlank(defaultNullString)){
					str+=">---请选择---</option>";
				}else{
					str+=">"+defaultNullString+"</option>";
				}
				
			}
			str += strBuf.toString()+"</select>";
		}
		return str;
	}
	
	/**
	*<b>Summary: </b>
	* queryDictData(查询字典数据)
	* @param dbName 数据源名称
	* @param sql 查询数据的sql语句，其中只查询两个值，字典数据的id和value
	* @return 二维数据
	* @throws SQLException
	 */
	public static String[][] queryDictData(String sql) throws SQLException{
		DBUtil db = new DBUtil();
		db.executeSelect(sql);
		String[][] arr = null;
		if(db.size()>0){
			arr = new String[db.size()][2];
			for(int i=0; i<db.size();i++){
				arr[i][0] = db.getString(i, 0).trim();
				arr[i][1] = db.getString(i, 1).trim();
			}
		}
		return arr;
	}
	public static String buildSelectNoDefault(String sql,String selectName,String selectedOptionName, String onchangeNethodName, boolean sign,String defaultNullString) throws SQLException {
		String str = "";
		 String[][]  dictData = queryDictData(sql);
		if (dictData == null) {
			StringBuffer strBuf = new StringBuffer();
			strBuf.append("<select  id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='width:188px;' class='select_188_box' size='1'")
				.append("<option  value='' selected >");
				if(StringUtil.nullOrBlank(defaultNullString)){
					//strBuf.append("---请选择---");
				}else{
					strBuf.append(defaultNullString);
				}
				strBuf.append("</option>")
				.append("</select>");
				str += strBuf.toString();
			return str;
		} else {
			boolean selected = false;
			
			str = "<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='width:188px;' class='select_188_box' size='1'>";
			StringBuffer strBuf = new StringBuffer();
			for (int i = 0; i < dictData.length; i++) {
				String [] arr = dictData[i];
				String select = selectedOptionName.equalsIgnoreCase(arr[0])?"selected":"";
				if(select.length()>0){
					selected=true;
				}
				strBuf.append("<option  " + select);
				if(!StringUtil.nullOrBlank(arr[0])){
					strBuf.append(" value='"+ arr[0] +"'");
				}
				strBuf.append(">"+ arr[1] + "</option>");
			}
			if(sign){
				str+="<option  value='' ";
				if(!selected){
					str += "selected";
				}
				if(StringUtil.nullOrBlank(defaultNullString)){
					//str+=">---请选择---</option>";
				}else{
					str+=">"+defaultNullString+"</option>";
				}
				
			}
			str += strBuf.toString()+"</select> ";
		}
		return str;
	}
	/**
	 * 根据sql获取jgrid字段上的filter数据集合字符串
	 * @param sql 查询的sql，只会取第一个字段
	 * @param defaultstr 默认显示的第一个值
	 * @return
	 * @throws SQLException
	 */
	public static String getJGridColumnFilterData(String sql,String defaultstr) throws SQLException{
		DBUtil db = new DBUtil();
		db.executeSelect(sql);
		String filterStr = "[\"\",\"--"+defaultstr+"--\"]";
		if(db.size()>0){
			for(int i=0; i<db.size();i++){
				filterStr += ",[\""+db.getString(i, 0).trim()+"\",\""+db.getString(i, 0).trim()+"\"]";
			}
			
		}
		return filterStr;
	}
	/**
	*<b>Summary: </b>
	* buildSelect4Expand(查询字典数据生成下拉框--可操作扩展字段)
	* @param sql  查询数据的sql语句，其中只查询两个值，字典数据的id和value
	* @param selectName 下拉框的名称
	* @param selectedOptionName  被选中的值
	* @param onchangeNethodName  onchange事件调用的js函数名称
	* @param sign  为0 标识 如果没有被选中的值，添加默认的空值---请选择--- 其他则不添加
	* @param defaultNullString 可自己制定默认空值的字符串显示，如果没有值，则显示---请选择---
	* @return
	* @throws SQLException 
	*/
	public static  String buildSelect4Expand(String sql,String selectName,String selectedOptionName, String onchangeNethodName, boolean sign,String defaultNullString,String selectStyle,String classname) throws SQLException {
		String str = "";
		 String[][]  dictData = queryDictData4Expand(sql);
		if (dictData == null) {
			StringBuffer strBuf = new StringBuffer();
			strBuf.append("<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='"+selectStyle+"' "+classname+" >")
				.append("<option option expandName='' value='' selected >");
				if(StringUtil.nullOrBlank(defaultNullString)){
					strBuf.append("---请选择---");
				}else{
					strBuf.append(defaultNullString);
				}
				strBuf.append("</option>")
				.append("</select>");
				str += strBuf.toString();
			
			return str;
		} else {
			boolean selected = false;
			str = "<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='"+selectStyle+"'    "+classname+" >";
			StringBuffer strBuf = new StringBuffer();
			for (int i = 0; i < dictData.length; i++) {
				String [] arr = dictData[i];
				String select = selectedOptionName.equalsIgnoreCase(arr[0])?"selected":"";
				if(select.length()>0){
					selected=true;
				}
				strBuf.append("<option  " + select);
				if(!StringUtil.nullOrBlank(arr[0])){
					strBuf.append(" value='"+ arr[0] +"' title='"+arr[1]+"'  expandName='"+ arr[2] +"' ");
				}
				if(arr[1].length()>15){
					strBuf.append(">"+ arr[1].substring(0, 12) + "...</option>");
				}else{
					strBuf.append(">"+ arr[1] + "</option>");
				}
				
			}
			if(sign){
				str+="<option expandName='' value='' ";
				if(!selected){
					str += "selected";
				}
				if(StringUtil.nullOrBlank(defaultNullString)){
					str+=">---请选择---</option>";
				}else{
					str+=">"+defaultNullString+"</option>";
				}
				
			}
			str += strBuf.toString()+"</select>";
		}
		return str;
	}
	
	/**
	 * queryDictData4Expand
	 * 根据sql获取jgrid字段上的filter数据集合字符串 (除value和text之外还一个expandName)
	 * @param sql 查询的sql
	 * @return 
	 * @throws SQLException
	 */
	public static String[][] queryDictData4Expand(String sql) throws SQLException{
		DBUtil db = new DBUtil();
		db.executeSelect(sql);
		String[][] arr = null;
		if(db.size()>0){
			arr = new String[db.size()][3];
			for(int i=0; i<db.size();i++){
				arr[i][0] = db.getString(i, 0).trim();
				arr[i][1] = db.getString(i, 1).trim();
				arr[i][2] = db.getString(i, 2).trim();
			}
		}
		return arr;
	}
	
	/**
	*<b>Summary: </b>
	* buildSelect4DictType(查询字典数据生成下拉框--可操作扩展字段)
	* @param type  字典类型
	* @param selectName 下拉框的名称
	* @param selectedOptionName  被选中的值
	* @param onchangeNethodName  onchange事件调用的js函数名称
	* @param sign  为0 标识 如果没有被选中的值，添加默认的空值---请选择--- 其他则不添加
	* @param defaultNullString 可自己制定默认空值的字符串显示，如果没有值，则显示---请选择---
	* @param selectStyle 自定义样式
	* @param classname 自定义css
	* @param dictdata_parent_id 字典数据的父ID
	* @return
	* @throws SQLException 
	*/
	public static String buildSelect4DictType(String type, String selectName,
			String selectedOptionName, String onchangeNethodName, boolean sign,
			String defaultNullString, String selectStyle, String classname, String dictdata_parent_id)
			throws SQLException {
		String str = "";
		if (StringUtil.nullOrBlank(classname)){
			classname = "class='select_240'";
		}
		StringBuffer sql = new StringBuffer();
		sql.append("select d.dictdata_id, d.dictdata_name, d.dictdata_value");
		sql.append("  from oa_dict_data d, oa_dict_type t");
		sql.append(" where t.dict_id = d.dict_id");
		sql.append(" and d.dictdata_is_valid='1' and t.dict_is_valid='1'");
		sql.append(" and t.dict_code = '"+type+"'");
		if(!StringUtil.isBlank(dictdata_parent_id)) {
			sql.append(" and d.dictdata_parent_id = '"+dictdata_parent_id+"'");
		}
		sql.append(" order by decode(d.dictdata_name,'普通',1,0) desc,d.dictdata_order ");
		String[][]  dictData = queryDictData4Expand(sql.toString());
		if (dictData == null) {
			StringBuffer strBuf = new StringBuffer();
			strBuf.append("<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='"+selectStyle+"' "+classname+" >")
				.append("<option option expandName='' value='' selected >");
				if(StringUtil.nullOrBlank(defaultNullString)){
					strBuf.append("---请选择---");
				}else{
					strBuf.append(defaultNullString);
				}
				strBuf.append("</option>")
				.append("</select>");
				str += strBuf.toString();
			
			return str;
		} else {
			boolean selected = false;
			str = "<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='"+selectStyle+"'    "+classname+" >";
			StringBuffer strBuf = new StringBuffer();
			for (int i = 0; i < dictData.length; i++) {
				String [] arr = dictData[i];
				String select = selectedOptionName.equalsIgnoreCase(arr[0])?"selected":"";
				if(select.length()>0){
					selected=true;
				}
				strBuf.append("<option  " + select);
				if(!StringUtil.nullOrBlank(arr[0])){
					strBuf.append(" value='"+ arr[0] +"' title='"+arr[1]+"'  expandName='"+ arr[2] +"' ");
				}
				if(arr[1].length()>15){
					strBuf.append(">"+ arr[1].substring(0, 12) + "...</option>");
				}else{
					strBuf.append(">"+ arr[1] + "</option>");
				}
				
			}
			if(sign){
				str+="<option expandName='' value='' ";
				if(!selected){
					str += "selected";
				}
				if(StringUtil.nullOrBlank(defaultNullString)){
					str+=">---请选择---</option>";
				}else{
					str+=">"+defaultNullString+"</option>";
				}
				
			}
			str += strBuf.toString()+"</select>";
		}
		return str;
	}
	
	
	/**
	*<b>Summary: </b>
	* buildSelect4Sql(查询sql生成下拉框)
	* @param sql
	* @param selectName
	* @param selectedOptionName
	* @param onchangeNethodName
	* @param sign
	* @param defaultNullString
	* @param selectStyle
	* @param classname
	* @param dictdata_parent_id
	* @return
	* @throws SQLException 
	*/
	public static String buildSelect4Sql(String sql, String selectName,
			String selectedOptionName, String onchangeNethodName, boolean sign,
			String defaultNullString, String selectStyle, String classname, String dictdata_parent_id)
			throws SQLException {
		String str = "";
		if (StringUtil.nullOrBlank(classname)){
			classname = "class='select_240'";
		}
		String[][]  dictData = queryDictData4Expand(sql);
		if (dictData == null) {
			StringBuffer strBuf = new StringBuffer();
			strBuf.append("<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='"+selectStyle+"' "+classname+" >")
				.append("<option option expandName='' value='' selected >");
				if(StringUtil.nullOrBlank(defaultNullString)){
					strBuf.append("---请选择---");
				}else{
					strBuf.append(defaultNullString);
				}
				strBuf.append("</option>")
				.append("</select>");
				str += strBuf.toString();
			
			return str;
		} else {
			boolean selected = false;
			str = "<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='"+selectStyle+"'    "+classname+" >";
			StringBuffer strBuf = new StringBuffer();
			for (int i = 0; i < dictData.length; i++) {
				String [] arr = dictData[i];
				String select = selectedOptionName.equalsIgnoreCase(arr[0])?"selected":"";
				if(select.length()>0){
					selected=true;
				}
				strBuf.append("<option  " + select);
				if(!StringUtil.nullOrBlank(arr[0])){
					strBuf.append(" value='"+ arr[0] +"' title='"+arr[1]+"'  expandName='"+ arr[2] +"' ");
				}
				if(arr[1].length()>15){
					strBuf.append(">"+ arr[1].substring(0, 12) + "...</option>");
				}else{
					strBuf.append(">"+ arr[1] + "</option>");
				}
				
			}
			if(sign){
				str+="<option expandName='' value='' ";
				if(!selected){
					str += "selected";
				}
				if(StringUtil.nullOrBlank(defaultNullString)){
					str+=">---请选择---</option>";
				}else{
					str+=">"+defaultNullString+"</option>";
				}
				
			}
			str += strBuf.toString()+"</select>";
		}
		return str;
	}
}
