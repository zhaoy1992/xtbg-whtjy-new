package com.chinacreator.xtbg.pub.util;

import java.util.Calendar;

import com.chinacreator.eform.util.Escape;

/**
	 *<p>Title:</p>
	 *<p>Description:数据操作类</p>
	 *<p>Copyright:Copyright (c) 2011</p>
	 *<p>Company:湖南科创</p>
	 *@author yin.liu
	 *@version 1.0
	 *@date Jul 5, 2011
	 */
public class DataControlUtil {
	
	/**
	 * 对Double数据类型数据四舍五入并保留一位小数
	 * @param data Double的数据
	 * @return String
	 */
	public static String formatNum(Double data){	
	
		//BigDecimal b = new 	BigDecimal(data*10);
		//double f = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();//对Double数据类型数据四舍五入并保留两位小数
		//return f/10 + "";
		String f = Math.round(data*10)/10.0+"";
		return f.replace(".0", "");
	}
	/**
	 * 转义字符串
	 * @param str
	 * @return
	 */
	public static String replaceStr(String str){
		
		if(str != null && !"".equals(str)){
			str = str.replace("chr(41)", "{'");
			str = str.replace("chr(42)", "'}");
			str = str.replace("chr(46)", "}");
			str = str.replace("chr(47)", "{");
			str = str.replace("chr(43)", "','");
			str = str.replace("chr(44)", "':'");
			str = str.replace("chr(39)", "\'");
			str = str.replace("chr(45)", "\"");
			str = str.replace("chr(38)", "&");
			str = str.replace("chr(60)", "<");
			str = str.replace("chr(62)", ">");
			str = str.replace("chr(37)", "%");
			str = str.replace("chr(50)", "#");
			str = str.replace("chr(40)", "\\");
			str = str.replace("chr(64)", "\r\n");
			
		}
		return str;
	}
	
	public static String descape(String str){
		if(str != null && !"".equals(str)){
			str = str.replace("{'","chr(41)");
			str = str.replace("'}","chr(42)");
			str = str.replace("','","chr(43)");
			str = str.replace("':'","chr(44)");
			str = str.replace("#","chr(50)");
			str = str.replace("'","chr(39)");
			str = str.replace("&","chr(38)");
			str = str.replace("<","chr(60)");
			str = str.replace(">","chr(62)");
			str = str.replace("%","chr(37)");
			str = str.replace("\\","chr(40)");
			str = str.replace("\r\n","chr(64)");
		}
		return str;
	}
	
	/**
	 * 专门针对页面间通过url后面的param参数传值引起的中文乱码问题，前端需要两次escape,后端也需要两次unescape即可
	 * @param str
	 * @return
	 */
	public static String pageUnEscape(String str){
		return Escape.unescape(Escape.unescape(str));
	}
	
	/**
	 * 获得当前日期与本周日相差的天数
	 * @return
	 */
    public static int getMondayPlus() {    
        Calendar cd = Calendar.getInstance();    
        // 获得今天是一周的第几天，星期日是第一天，星期一是第二天......    
        int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK)-1;      
        
        return dayOfWeek;
    } 
	
}
