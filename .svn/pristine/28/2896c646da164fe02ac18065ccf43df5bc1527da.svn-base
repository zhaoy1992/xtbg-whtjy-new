package com.chinacreator.xtbg.core.codegenerator.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *<p>Title:CodeUtil.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Mar 20, 2014
 */
public class CodeUtil {
	/**
	*<b>Summary: 由数据库类型生成java bean类型</b>
	* columnTypeParse()
	* @param comment_type
	* @return
	 */
	public static String columnTypeParse(String columnType){
		if ("date".equals(columnType)){
			columnType = "String";//默认date类型也为String，可以自行设置
		}else{
			columnType = "String";
		}
		return columnType;
	}
	
	public static String createGetAndSetMethod(String column_name,String comments,String comment_type){
		StringBuffer sql = new StringBuffer();
		sql.append("    /**\r\n");
		sql.append("     * <b>Summary: 获取"+comments+"</b>\r\n");
		sql.append("     */\r\n");
		sql.append("    public "+comment_type+" get"+upperCaseFirst(column_name)+"() {\r\n");
		sql.append("	    return "+column_name+";\r\n");
		sql.append("    }\r\n");
		sql.append("    /**\r\n");
		sql.append("     * <b>Summary: 设置"+comments+"</b>\r\n");
		sql.append("     */\r\n");
		sql.append("    public void set"+upperCaseFirst(column_name)+"("+comment_type+" "+column_name+") {\r\n");
		sql.append("	    this."+column_name+" = "+column_name+";\r\n");
		sql.append("    }\r\n");
		return sql.toString();
	}
	
	public static String upperCaseFirst(String name){
		if(name == null || "".equals(name)){
			return "";
		} else {
			char ch = (char) (name.charAt(0) - 32);
			name = ch + name.substring(1);
			return name;
		}
	}
	
	public static String getLogTime(){
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss SSS");
		return sdf.format(new Date());
	}
}
