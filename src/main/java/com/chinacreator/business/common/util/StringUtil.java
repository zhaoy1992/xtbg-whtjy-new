package com.chinacreator.business.common.util;

import java.util.regex.Pattern;
/**
 * <p>
 * Title:ScheduleServlet.java
 * </p>
 * <p>
 * Description:字符串工具类
 * </p>
 * <p>
 * Company:湖南
 * </p>
 * @author 沈联成
 * @version 1.0 2012-11-20
 */
public class StringUtil {

	/**
	 * 字符串正则匹配方法
	 * @param string 要匹配的字符串
	 * @param regex 正则表达式
	 * @return
	 */
	public static boolean stringFilter(String string, String regex) {
		Pattern p = Pattern.compile(regex);
		return p.matcher(string).matches();
	}
}
