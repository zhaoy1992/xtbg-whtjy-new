package com.chinacreator.xtbg.pub.util;

/**
 * 
 *<p>Title:BusinessUtil.java</p>
 *<p>Description:业务相关的工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2014-3-9
 */
public class BusinessUtil {
	
	/**
	 * 
	*<b>Summary: </b>
	* parseValueAndKey(解析值和名称，常用于业务数据中的字典数据解析，如：性别“男”在系统中存的value是female)
	* @param str 需要解析的key
	* @param keyvalues 键值对二维数组 如 ：{{"bnzg","编内职工"},{"bwzg","编外职工"},{"txzg","退休职工"}}
	* @param iskeytovalue 是否为根据key找value，否则value找key
	* @return
	 */
	public static String parseValueAndKey(String str,String[][] keyvalues,boolean iskeytovalue){
		str = str.trim();
		for(int i = 0; i < keyvalues.length ; i++){
			if(iskeytovalue && keyvalues[i][0].equals(str)){
				return keyvalues[i][1];
			}else if(!iskeytovalue && keyvalues[i][1].equals(str)){
				return keyvalues[i][0];
			}
		}
		return str;
	}
}
