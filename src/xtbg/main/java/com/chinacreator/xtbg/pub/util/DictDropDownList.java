package com.chinacreator.xtbg.pub.util;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
			strBuf.append("<select  id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='width:290px;' class='select_188_box' size='1'>")
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
			
			str = "<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='width:290px;' class='select_188_box' size='1'>";
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

	/**
	*<b>Summary: </b>
	* buildSelect(查询字典数据生成下拉框)
	* @param sql  查询数据的sql语句，其中只查询两个值，字典数据的id和value
	* @param selectName 下拉框的名称
	* @param selectedOptionName  被选中的值
	* @param onchangeNethodName  onchange事件调用的js函数名称
	* @param sign  为0 标识 如果没有被选中的值，添加默认的空值---请选择--- 其他则不添加
	* @param defaultNullString 可自己制定默认空值的字符串显示，如果没有值，则显示---请选择---
	* @param selectStyle 下拉框的样式
	* @return
	* @throws SQLException 
	*/
	public static  String buildSelect(String sql,String selectName,String selectedOptionName, String onchangeNethodName, boolean sign,String defaultNullString,String selectStyle) throws SQLException {
		String str = "";
		 String[][]  dictData = queryDictData(sql);
		if (dictData == null) {
			StringBuffer strBuf = new StringBuffer();
			strBuf.append("<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='"+selectStyle+"' >")
				.append("<option value='' selected >");
				if(StringUtil.nullOrBlank(defaultNullString)){
					strBuf.append("---请选择---");
				}else if("space".equals(defaultNullString)){	//显示空白的默认选项
					strBuf.append("");
				} else {
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
				} else if("space".equals(defaultNullString)){	//显示空白的默认选项
					str+="></option>";
				} else{
					str+=">"+defaultNullString+"</option>";
				}
				
			}
			str += strBuf.toString()+"</select>";
		}
		return str;
	}
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
	public static String buildSelect(String sql,String selectName,String selectedOptionName, String onchangeNethodName, boolean sign,String defaultNullString,List<String> list) throws SQLException {
		String str = "";
		String[][]  dictData = queryDictData(sql);
		List<String> list1=new ArrayList<String>();
		if (dictData == null) {
			StringBuffer strBuf = new StringBuffer();
			strBuf.append("<select  id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='width:290px;' class='select_188_box' size='1'>")
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
			
			str = "<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='width:290px;' class='select_188_box' size='1'>";
			StringBuffer strBuf = new StringBuffer();
			for (int i = 0; i < dictData.length; i++) {
				String [] arr = dictData[i];
				if(list.size()>0){
					for (int j = 0; j < list.size(); j++) {
						if((arr[1].indexOf(list.get(j)))!=-1){
							String select = selectedOptionName.equalsIgnoreCase(arr[0])?"selected":"";
							if(select.length()>0){
								selected=true;
							}
							strBuf.append("<option  " + select);
							if(!StringUtil.nullOrBlank(arr[0])){
								strBuf.append(" value='"+ arr[0] +"'");
							}
							strBuf.append(">"+ arr[1] + "</option>");
							list1.add(arr[0]);
						}
					}
				}else{
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
			}
			if(sign){
				str+="<option  value='";
				for (int i = 0; i < list1.size(); i++) {
					if(i==list1.size()-1){
						str+=list1.get(i);
					}else{
						str+=list1.get(i)+",";
					}
				}
				   str+="'";
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
			strBuf.append("<select  id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='width:290px;' class='select_188_box' size='1'")
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
			
			str = "<select id='" + selectName+ "' name='" + selectName+ "' onchange='"+onchangeNethodName+"' style='width:290px;' class='select_188_box' size='1'>";
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
}
