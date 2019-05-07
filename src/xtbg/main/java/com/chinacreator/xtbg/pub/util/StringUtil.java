package com.chinacreator.xtbg.pub.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;


/**
 * 
 * <p>Title: 行政审批基础版</p>
 * <p>Description: xzsp</p>
 * <p>Copyright: Copyright (c) 2009</p>
 * <p>Company: chinacreator</p>
 * @author yiping.huang
 * @version 1.0
 * @date 2011-6-10
 */
public class StringUtil {
	/**
	 * 将字符串转换为 int.出现异常返回0
	 * @param input 输入的字串
	 * @date 2005-07-29
	 * @return 结果数字
	 */
	public static int parseInt(String input) {
		try {
			return Integer.parseInt(input);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return 0;
	}
	/**
	 * 
	*<b>Summary: String转double,出现异常返回0.0</b>
	* parseDouble()
	* @param input
	* @return
	 */
	public static double parseDouble(String input) {
		try {
			return Double.parseDouble(input);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return 0.0;
	}
	
	public static final String EMPTY_STRING = "";

	private StringUtil() {
	}

	public static boolean getBoolean(String property) {
		return Boolean.valueOf(property).booleanValue();
	}

	public static boolean getBoolean(String property, boolean defaultValue) {
		return (property == null) ? defaultValue : Boolean.valueOf(property)
				.booleanValue();
	}

	public static int getInt(String property) {
		return Integer.parseInt(property);
	}

	public static int getInt(String property, int defaultValue) {
		return (property == null) ? defaultValue : Integer.parseInt(property);
	}

	public static String getString(String property, String defaultValue) {
		return (property == null) ? defaultValue : property;
	}

	public static Integer getInteger(String property) {
		return (property == null) ? null : Integer.valueOf(property);
	}

	public static Integer getInteger(String property, Integer defaultValue) {
		return (property == null || property.equals("")) ? defaultValue
				: getInteger(property);
	}

	public static long getLong(String property) {
		return Long.parseLong(property);
	}

	public static long getLong(String property, long defaultValue) {
		return (property == null || property.equals("")) ? defaultValue
				: getLong(property);
	}

	public static double getDouble(String property) {
		return Double.parseDouble(property);
	}

	public static double getDouble(String property, double defaultValue) {
		return (property == null || property.equals("")) ? defaultValue
				: getDouble(property);
	}

	public static float getFloat(String property) {
		return Float.parseFloat(property);
	}

	public static float getFloat(String property, float defaultValue) {
		return (property == null || property.equals("")) ? defaultValue
				: getFloat(property);
	}

	public static java.sql.Date getDate(String str) {
		return str == null ? null : java.sql.Date.valueOf(str);
	}

	public static java.sql.Time getTime(String str) {
		return str == null ? null : java.sql.Time.valueOf(str);
	}

	public static java.sql.Timestamp getTimeStamp(String str) {
		return str == null ? null : java.sql.Timestamp.valueOf(str);
	}

	/**
	 * 获得类对象名字
	 * @param className String
	 * @return String
	 */
	public static String getObjectName(String className) {
		StringBuffer result = new StringBuffer();
		if (className.indexOf(" ") != -1) {
			result.append(className.substring(className.lastIndexOf(" ") + 1));
		}
		if (className.indexOf(".") != -1) {
			result.append(className.substring(className.lastIndexOf(".") + 1));
		}
		return result.toString().toUpperCase();
	}

	/**
	 *
	 * @param property String
	 * @param delim String
	 * @return Map
	 */
	public static Map toMap(String property, String delim) {
		Map map = new HashMap();
		if (property != null) {
			StringTokenizer tokens = new StringTokenizer(property, delim);
			while (tokens.hasMoreTokens()) {
				map.put(tokens.nextToken(), tokens.hasMoreElements() ? tokens
						.nextToken() : EMPTY_STRING);
			}
		}
		return map;
	}

	public static String[] toStringArray(String propValue, String delim) {
		if (propValue != null) {
			return propValue.split(delim);
		} else {
			return null;
		}
	}

	public static String fieldValue2String(Object object) {
		if (object != null) {
			return object.toString();
		} else {
			return null;
		}
	}

	/**
	 * 返回指定对象的字符串值
	 * @param object
	 * @return
	 */
	public static String getValue(Object object) {
		String result = "";
		if (object != null) {
			result = String.valueOf(object);
			result = result.equals("null") ? "" : result;
		}
		return result;
	}

	/**
	 * 将字符串参数格式成sql格式
	 * @param paramStr String   源参数
	 * @param splitStr String   分割字符：如","
	 * @return String
	 */
	public static String returnParam(String paramStr, String splitStr) {
		StringBuffer result = new StringBuffer();
		String[] params = paramStr.split(splitStr);
		for (int i = 0; i < params.length; i++) {
			if (i == 0) {
				result.append("'" + params[i] + "'");
			} else {
				result.append("," + "'" + params[i] + "'");
			}
		}
		return result.toString();
	}

	/**
	 * 判断是否是数字
	 * @param: String param
	 * @return: boolean
	 */
	public static boolean isValidNumber(String param) {
		try {
			Integer.parseInt(param);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	/**
	 * 截取标题为指定长度的标题...
	 * @param str String
	 * @param len int
	 * @return String
	 */
	public static String replaceTitle(String str, int len, String taget) {
		StringBuffer buf2 = new StringBuffer();
		if (str.length() > len) {
			buf2.append(str.substring(0, len));
			buf2.append(taget);
		} else {
			buf2.append(str);
		}
		return buf2.toString();
	}

	/**
	 * 判断字符是否为空
	 * @param: String param
	 * @return: boolean
	 */
	public static boolean nullOrBlank(String param) {
		return (param == null || param.trim().equals("") || param.equals("null")) ? true : false;
	}
	
	/**
	 * 过滤掉为null的字符串
	 * @param: String param
	 * @return: String
	 */
	public static String deNull(String param) {
		if(nullOrBlank(param))
			return "";
		return param.trim();
	}
	
	/**
	 * 
	*<b>Summary: 重载方法</b>
	* deNull(请用一句话描述这个方法的作用)
	* @param param 
	* @return
	* @author 戴连春
	 */
	public static String deNull(Object param){
		String str = String.valueOf(param);
		return deNull(str);
	}

	/**
	 * 提供精确的小数位四舍五入处理。
	 * @param v 需要四舍五入的数字
	 * @param scale 小数点后保留几位
	 * @return 四舍五入后的结果
	 */
	public static float round(float v, int scale) {
		if (scale < 0) {
			throw new IllegalArgumentException(
					"The scale must be a positive integer or zero");
		}
		BigDecimal b = new BigDecimal(Double.toString(v));
		BigDecimal one = new BigDecimal("1");
		return b.divide(one, scale, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	/**
	 * 显示定长的数据
	 * @param str String
	 * @param length int
	 * @return String
	 */
	public static String subString(String str, int length) {
		int len = str.length();
		String strnew = "";
		if (len >= length) {
			strnew = str.substring(0, length - 2) + "....";
		} else {
			strnew = str;
		}
		return strnew;
	}

	/**
	 * 根据提供的文字连续生成该内容
	 * @param str String
	 * @param length int
	 * @return String
	 */
	public static String makeString(String str, int length) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			sb.append(str);
		}
		return sb.toString();
	}

	/**
	 *
	 * @param str String
	 * @param num int
	 * @param tag String
	 * @return String
	 */
	public static String newString(String str, int num, String tag) {
		StringBuffer sb = new StringBuffer();

		int len = str.length();
		int t = len / num;
		if (t > 0) {
			for (int i = 1; i <= t; i++) {
				if (i == 1) {
					sb.append(str.substring(0, num));
				} else {
					sb.append(tag + str.substring(num * (i - 1), num * (i)));
				}
			}
			sb.append(tag + str.substring(num * t));
		} else {
			sb.append(str);
		}
		return sb.toString();
	}

	/**
	 * html过滤
	 * @param str
	 * @return
	 */
	public static final String htmlFilter(String str) {
		if (str == null)
			return "&nbsp;";
		char toCompare;
		StringBuffer replaceChar = new StringBuffer(str.length() + 256);
		int maxLength = str.length();
		try {
			for (int i = 0; i < maxLength; i++) {
				toCompare = str.charAt(i);
				// 所有的 " 替换成 : &quot;
				if (toCompare == '"')
					replaceChar.append("&quot;");
				// 所有的 < 替换成： &lt;
				else if (toCompare == '<')
					replaceChar.append("&lt;");
				// 所有的 > 替换成： &gt;
				else if (toCompare == '>')
					replaceChar.append("&gt;");
				// 所有的 & 替换嘏: &amp;
				else if (toCompare == '&') {
					if (i < maxLength - 1)
						if (str.charAt(i + 1) == '#') {
							replaceChar.append("&#");
							i++;
						} else
							replaceChar.append("&amp;");
				} else if (toCompare == ' ')
					replaceChar.append("&nbsp;");
				// 所有的 \r\n （using System.getProperty("line.separator") to get it ） 替换成　<br>lihjk
				else if (toCompare == '\r')
					;//replaceChar.append("<br>");
				else if (toCompare == '\n')
					replaceChar.append("<br>");
				else
					replaceChar.append(toCompare);
			}//end for
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			return replaceChar.toString();
		}
	}

	/**
	 * 将字符串 t_String 中的 value1 替换为 value2
	 * @param t_String
	 * @param value1 原字符
	 * @param value2 新字符
	 * @return
	 */
	public static String replaceString(String t_String, String value1,
			String value2) {
		while (t_String.indexOf(value1) != -1) {
			t_String = t_String.substring(0, t_String.indexOf(value1))
					+ value2
					+ t_String.substring(t_String.indexOf(value1)
							+ value1.length(), t_String.length());
		}
		return t_String;
	}

	/**
	 * 字符串输出指定的长度,长度不够则右边空格补
	 * @param t_String
	 * @param len
	 * @return
	 */
	public static String formatStrWithBlank(String t_String, int len) {
		return formatStrWithBlank(t_String, len, " ", true);
	}

	/**
	 * 字符串输出指定的长度,长度不够则右边空格补
	 * @param t_String
	 * @param len
	 * @return
	 */
	public static String formatStrWithBlank(String t_String, int len,
			String defaultStr) {
		return formatStrWithBlank(t_String, len, defaultStr, true);
	}

	/**
	 * 字符串输出指定的长度,长度不够则空格补
	 * @param t_String 源字符串
	 * @param len 长度
	 * @param bl 默认为右空格补齐
	 * @return
	 */
	public static String formatStrWithBlank(String t_String, int len,
			String defaultStr, boolean bl) {
		StringBuffer sbf = new StringBuffer();
		if (t_String.length() >= len) {
			return t_String.substring(0, len);
		} else {
			if (bl) {//右补齐空格
				sbf.append(t_String);
				for (int i = 0; i < len - t_String.length(); i++) {
					sbf.append(defaultStr);
				}
			} else {
				sbf.append("");
				for (int i = 0; i < len - t_String.length(); i++) {
					sbf.append(defaultStr);
				}
				sbf.append(t_String);
			}
			return sbf.toString();
		}
	}

	/**
	 * Number转换字符
	 * @param1: 转换数据
	 * @param2: 格式：##.##
	 */
	public static String convertNumberToString(double number, String pattern) {
		String returnValue = "";
		try {
			DecimalFormat df = new DecimalFormat(pattern);
			returnValue = df.format(number);
		} catch (Exception e) {
		}
		return returnValue;
	}

	/**
	 * 格式化空字符串为缺省字符串
	 * @param fmtStr 
	 * @param defaultStr  返回fmtStr为空或""时的缺省字符串
	 * @return
	 */
	public static String formatNull(String fmtStr, String defaultStr) {
		String tmp = defaultStr;
		if (fmtStr == null || fmtStr.trim().length() == 0)
			return defaultStr;
		else
			return fmtStr;

	}

	/**字符串解码
	 * @param str
	 * @param enc 编码,例"GBK"
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String formatStrDecoder(String str, String enc) {
		String formatStr = null;
		if (str != null)
			try {
				formatStr = URLDecoder.decode(str, enc);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		return formatStr;
	}

	/**字符串编码
	 * @param str
	 * @param enc
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String formatStrEncoder(String str, String enc) {
		String formatStr = null;
		if (str != null)
			try {
				formatStr = URLEncoder.encode(str, enc);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		return formatStr;
	}

	public static String convertTimeToString(Timestamp time, String style) {
		String timeStr = "";
		if (style == null || style.length() == 0)
			style = "yyyy-MM-dd HH:mm:ss";
		if (time == null)
			return "";
		try {
			SimpleDateFormat df = new SimpleDateFormat(style);
			timeStr = df.format(time);
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}

		return timeStr;
	}

	public static String convertTimeToString(Timestamp time, String style,
			String defaultStr) {
		String timeStr = "";
		if (style == null || style.length() == 0)
			style = "yyyy-MM-dd HH:mm:ss";
		if (time == null)
			return defaultStr;
		try {
			SimpleDateFormat df = new SimpleDateFormat(style);
			timeStr = df.format(time);
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}

		return timeStr;
	}

	public static Date convertStringToDate(String srcStr, String style) {

		Date dateTmp = null;
		if (srcStr == null || srcStr.length() == 0)
			return null;
		if (style == null || style.length() == 0)
			style = "yyyy-MM-dd HH:mm:ss";

		try {
			SimpleDateFormat df = new SimpleDateFormat(style);
			dateTmp = df.parse(srcStr);
		} catch (Exception e) {
			e.printStackTrace();
			return new Date();
		}

		return dateTmp;
	}

	public static Timestamp convertStringToTimestamp(String timeStr) {
		if (timeStr == null || timeStr.length() == 0)
			return null;
		return Timestamp.valueOf(timeStr);
	}

	public static String getLastStrWithSplit(String srcStr, String split) {
		if (srcStr.lastIndexOf(split) != -1) {
			return srcStr.substring(srcStr.lastIndexOf(split), srcStr.length());
		}
		return "";
	}

	/**
	 * 源字符串为777,888改为'777','888'
	 * @param strStr
	 * @param split 源字符串的分隔符
	 * @param addSplit 需要追加的引号
	 * @return
	 */
	public static String splitString(String strStr, String split,
			String addSplit) {
		if (strStr == null || strStr.length() == 0) {
			return "' '";
		}
		String id[] = strStr.split(split);
		StringBuffer tmp = new StringBuffer();
		for (int i = 0; i < id.length; i++) {
			tmp.append(addSplit + id[i] + addSplit + split);
		}
		strStr = tmp.toString().substring(0, tmp.toString().length() - 1);
		
		if (strStr == null || strStr.length() == 0) {
			strStr = "' '";
		}
		return strStr;
	}

	/**
	 * srcStr是否包含destStr
	 * @param srcStr
	 * @param destStr
	 * @return
	 */
	public static boolean isContain(String srcStr, String destStr, boolean split) {
		boolean is = false;
		if (srcStr == null || srcStr.length() < 1) {
			return is;
		}
		if (split) {
			srcStr = StringUtil.splitString(srcStr, ",", "'");
			destStr = StringUtil.splitString(destStr, ",", "'");
		}
		int post = srcStr.indexOf(destStr);
		if (post >= 0) {
			is = true;
		}
		return is;
	}

	public static boolean isContain(String srcStr, String destStr) {
		return StringUtil.isContain(srcStr, destStr, false);
	}

	/**
	 * 去掉所有空格
	 * @param value
	 * @return
	 */
	public static String trimAll(String value) {
		String result = value;
		if (result == null)
			return result;
		char ch[] = result.toCharArray();
		StringBuffer strBuf = new StringBuffer();
		strBuf.append("");
		int endIndex = -1;
		for (int i = 0; i < ch.length; i++) {
			if (Character.isWhitespace(ch[i])) {
				endIndex = i;
			} else {
				strBuf.append(ch[i]);
			}
		}

		return strBuf.toString();
	}

	/**
	 * 在字符串前和末尾增加分割府
	 * @param srcStr
	 * @param split
	 * @return
	 */
	public static String addSplitAndFB(String srcStr, String split) {
		//如果以split结尾，则末尾不加了,如果以split开始，则开头不加了
		if (srcStr == null || srcStr.length() == 0)
			return "";
		if (!split.equalsIgnoreCase(srcStr.substring(0, 1))) {
			srcStr = split + srcStr;
		}
		if (!split.equalsIgnoreCase(srcStr.substring(srcStr.length() - 1))) {
			srcStr = srcStr + split;
		}
		return srcStr;
	}

	/**
	 * 去掉前后的分割符
	 * @param srcStr
	 * @param split
	 * @return
	 */
	public static String offSplitAndFB(String srcStr, String split) {
		if (srcStr == null || srcStr.length() == 0)
			return "";
		if (split.equalsIgnoreCase(srcStr.substring(0, 1))) {
			if (srcStr.length() > 1) {
				srcStr = srcStr.substring(1, srcStr.length());
			} else {
				return "";
			}
		}
		if (split.equalsIgnoreCase(srcStr.substring(srcStr.length() - 1))) {
			if (srcStr.length() > 1) {
				srcStr = srcStr.substring(0, srcStr.length() - 1);
			} else {
				return "";
			}
		}

		return srcStr;
	}

	/**
	 * 解决重复出现的单词
	 * @param srcStr
	 * @return
	 */
	public static String offReStr(String srcStr, String split) {
		StringBuffer tmp = new StringBuffer();
		srcStr = StringUtil.offSplitAndFB(srcStr, split);
		String[] newIDs = srcStr.split(split);
		for (int count = 0; count < newIDs.length; count++) {
			if (StringUtil.isContain(tmp.toString(), newIDs[count], true)) {

			} else {
				tmp.append(newIDs[count] + split);
			}
		}
		return tmp.toString();
	}

	/**
	 *
	 * @param o String
	 * @return String
	 */

	public static void main(String[] args) {
		String b = "JScript 小数后给定位数后四舍五入的函数是"
				+ "什么？ ...... 发表人, 主题: JScript 小数后"
				+ "给定位数后四舍五入的函数是什么？ ... JScri" + "pt 的round()我看了说明只有一个参数取整和"
				+ "vbs 的round() 相似的可以取得给定位数的四"
				+ "舍五入函数是什么？ 如1.237802456 ---> 1" + "基于对象的JavaScript语言... subs"
				+ "tring(start,end) 从start开始到end的字"
				+ "符全部返回。 ２)、算术函数的math ... abs()正弦余弦"
				+ "值：sin(),cos() 反正弦反余弦:asin(), acos() "
				+ "正切反正切：tan(),atan()四舍五入：round() 平方"
				+ "根 ... 2、javascript中的系统函数javascript中的"
				+ "系统函数又称内部 ... www.dapt.org/Article_Pri"
				+ "nt.asp?ArticleID=34 - 17k - 补充材料 - 网页快" + "照 - 类似网页 ";
		//byte[] b2 = b.getBytes();

		//ArrayList arylist = StringUtil.cutString(b);
		//		String a = StringUtil.GetsplitString(b,1,15,"UTF8");

	}

	/**
	 * 将字符串strText 从strInFormat 格式 转换成strOutFormat格式
	 * 
	 * @param strText
	 *            String 输入字符串
	 * @param strInFormat
	 *            String 输入格式
	 * @param strOutFormat
	 *            输出格式
	 * @throws Exception
	 * @return String
	 */
	public static String switch1(String strText, String strInFormat,
			String strOutFormat) {
		String strResults = "";
		try {
			strResults = new String(strText.getBytes(strInFormat), strOutFormat);
		} catch (Exception ex) {

		}
		return strResults;
	}

	/**
	 * 将字符串strText 从strInFormat 格式 转换成strOutFormat格式
	 * 
	 * @param strText
	 *            String 输入字符串
	 * @param strOutFormat
	 *            输出格式
	 * @throws Exception
	 * @return String
	 * 
	 * FIXME  命名不规范 垃圾代码
	 */
	public static String switch1(String strText, String strOutFormat) {
		String strResults = "";
		try {
			 strResults = new String(strText.getBytes(), strOutFormat);
		} catch (Exception ex) {

		}
		return strResults;
	}

	/**
	 * 截取中英文混合长度字符串方法
	 * @param res      被截取字符串
	 * @param start    开始位置
	 * @param length   截取长度
	 * @param CharSet  截取后字符串编码格式，例如中文格式为：UTF8（UTF8包含字符集更广，不能使用GBK，某些字符串不兼容，例如：中文“、”号）
	 * @return
	 * 
	 * FIXME 命名不规范
	 */
	public static String getsplitString(String res, int start, int length,
			String CharSet) {
		int istart, ilen, i, j, ilenByte, is, il;
		istart = 0;
		is = 0;
		ilen = 0;
		il = 0;

		try {
			byte[] resBytes = res.getBytes(CharSet);
			ilenByte = resBytes.length;

			for (i = 0; i < ilenByte; i++) {
				istart = istart + 1;
				if (istart <= start) {
					is = is + 1;
				}
				if (istart >= start) {
					ilen = ilen + 1;
					il = il + 1;
				}
				if (resBytes[i] < 0) {
					i = i + 2;
					istart = istart + 1;
					if (istart < start) {
						is = is + 2;
					}
					if (istart >= start) {
						ilen = ilen + 1;
						il = il + 2;
					}
				}
				if (ilen >= length)
					i = ilenByte;
			}

			byte[] dest = new byte[il];

			for (j = 0; j < il; j++) {
				dest[j] = resBytes[is + j - 1];
			}

			return new String(dest, CharSet);

		} catch (Exception e) {
			return null;
		}
	}

	public static ArrayList cutString(String str) {
		ArrayList arylist = new ArrayList();

		// 短信内容长度
		int allLength = str.length();
		// 截取后剩余长度
		int lastLength = allLength;

		String lastStr = "";
		String strCut = "";

		int intCut = 80;

		if (allLength > intCut) {
			while (lastLength >= 0) {

				if (str.length() < intCut) {
					strCut = str;
				} else {
					strCut = StringUtil.getsplitString(str, 1, intCut, "UTF8");
					lastStr = StringUtil.getsplitString(str, intCut, str
							.length() * 2, "UTF8");
				}

				str = lastStr + " ";

				arylist.add(strCut);

				lastLength = lastLength - strCut.length();

			}
		}
		return arylist;
	}
	
	
	public static String escape2Sql(String str) {
		if(str==null) {
		return null;
		}
		str = str.replaceAll("'","'||chr(39)||'");
	    str = str.replaceAll("&","'||chr(38)||'");
	    str = str.replaceAll("<","'||chr(60)||'");
	    str = str.replaceAll(">","'||chr(62)||'");
	    str = str.replaceAll("%","'||chr(37)||'");
		return str;

	}
	
	public   static    String StringFilter(String    str)   throws    PatternSyntaxException    {      
        // 只允许字母和数字        
        // String    regEx   =   "[^a-zA-Z0-9]";                      
           // 清除掉所有特殊字符   
	   String regEx="[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";   
	   Pattern    p    =    Pattern.compile(regEx);      
	   Matcher    m    =    p.matcher(str);      
	   return    m.replaceAll("").trim();      
   }      


	/**
	 * 功能描述：分割字符串
	 * 
	 * @param str
	 *            String 原始字符串
	 * @param splitsign
	 *            String 分隔符
	 * @return String[] 分割后的字符串数组
	 */
	public static String[] split(String str, String splitsign) {
		int index;
		if (str == null || splitsign == null) {
			return null;
		}
		ArrayList al = new ArrayList();
		while ((index = str.indexOf(splitsign)) != -1) {
			al.add(str.substring(0, index));
			str = str.substring(index + splitsign.length());
		}
		al.add(str);
		return (String[]) al.toArray(new String[0]);
	}

	/**
	 * 功能描述：替换字符串
	 * 
	 * @param from
	 *            String 原始字符串
	 * @param to
	 *            String 目标字符串
	 * @param source
	 *            String 母字符串
	 * @return String 替换后的字符串
	 */
	public static String replace(String from, String to, String source) {
		if (source == null || from == null || to == null)
			return null;
		StringBuffer str = new StringBuffer("");
		int index = -1;
		while ((index = source.indexOf(from)) != -1) {
			str.append(source.substring(0, index) + to);
			source = source.substring(index + from.length());
			index = source.indexOf(from);
		}
		str.append(source);
		return str.toString();
	}

	/**
	 * 替换字符串，能能够在HTML页面上直接显示(替换双引号和小于号)
	 * 
	 * @param str
	 *            String 原始字符串
	 * @return String 替换后的字符串
	 */
	public static String htmlencode(String str) {
		if (str == null) {
			return null;
		}
		return replace("\"", "&quot;", replace("<", "&lt;", str));
	}

	/**
	 * 替换字符串，将被编码的转换成原始码（替换成双引号和小于号）
	 * 
	 * @param str
	 *            String
	 * @return String
	 */
	public static String htmldecode(String str) {
		if (str == null) {
			return null;
		}

		return replace("&quot;", "\"", replace("&lt;", "<", str));
	}

	private static final String _BR = "<br/>";

	/**
	 * 功能描述：在页面上直接显示文本内容，替换小于号，空格，回车，TAB
	 * 
	 * @param str
	 *            String 原始字符串
	 * @return String 替换后的字符串
	 */
	public static String htmlshow(String str) {
		if (str == null) {
			return null;
		}

		str = replace("<", "&lt;", str);
		str = replace(" ", "&nbsp;", str);
		str = replace("\r\n", _BR, str);
		str = replace("\n", _BR, str);
		str = replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;", str);
		return str;
	}

	/**
	 * 功能描述：返回指定字节长度的字符串
	 * 
	 * @param str
	 *            String 字符串
	 * @param length
	 *            int 指定长度
	 * @return String 返回的字符串
	 */
	public static String toLength(String str, int length) {
		if (str == null) {
			return null;
		}
		if (length <= 0) {
			return "";
		}
		try {
			if (str.getBytes("GBK").length <= length) {
				return str;
			}
		} catch (Exception e) {
		}
		StringBuffer buff = new StringBuffer();

		int index = 0;
		char c;
		length -= 3;
		while (length > 0) {
			c = str.charAt(index);
			if (c < 128) {
				length--;
			} else {
				length--;
				length--;
			}
			buff.append(c);
			index++;
		}
		buff.append("...");
		return buff.toString();
	}

	/**
	 * 功能描述：判断是否为整数
	 * 
	 * @param str
	 *            传入的字符串
	 * @return 是整数返回true,否则返回false
	 */
	public static boolean isInteger(String str) {
		Pattern pattern = Pattern.compile("^[-\\+]?[\\d]+$");
		return pattern.matcher(str).matches();
	}

	/**
	 * 判断是否为浮点数，包括double和float
	 * 
	 * @param str
	 *            传入的字符串
	 * @return 是浮点数返回true,否则返回false
	 */
	public static boolean isDouble(String str) {
		Pattern pattern = Pattern.compile("^[-\\+]?\\d+\\.\\d+$");
		return pattern.matcher(str).matches();
	}

	/**
	 * 判断是不是合法字符 c 要判断的字符
	 */
	public static boolean isLetter(String str) {
		if (str == null || str.length() < 0) {
			return false;
		}
		Pattern pattern = Pattern.compile("[\\w\\.-_]*");
		return pattern.matcher(str).matches();
	}

	/**
	 * 从指定的字符串中提取Email content 指定的字符串
	 * 
	 * @param content
	 * @return
	 */
	public static String parse(String content) {
		String email = null;
		if (content == null || content.length() < 1) {
			return email;
		}
		// 找出含有@
		int beginPos;
		int i;
		String token = "@";
		String preHalf = "";
		StringBuffer sufHalf = new StringBuffer();

		beginPos = content.indexOf(token);
		if (beginPos > -1) {
			// 前项扫描
			String s = null;
			i = beginPos;
			while (i > 0) {
				s = content.substring(i - 1, i);
				if (isLetter(s))
					preHalf = s + preHalf;
				else
					break;
				i--;
			}
			// 后项扫描
			i = beginPos + 1;
			while (i < content.length()) {
				s = content.substring(i, i + 1);
				if (isLetter(s))
					sufHalf.append(s);
				else
					break;
				i++;
			}
			// 判断合法性
			email = preHalf + "@" + sufHalf.toString();
			if (isEmail(email)) {
				return email;
			}
		}
		return null;
	}

	/**
	 * 功能描述：判断输入的字符串是否符合Email样式.
	 * 
	 * @param str
	 *            传入的字符串
	 * @return 是Email样式返回true,否则返回false
	 */
	public static boolean isEmail(String email) {
		if (email == null || email.length() < 1 || email.length() > 256) {
			return false;
		}
		Pattern pattern = Pattern
				.compile("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$");
		return pattern.matcher(email).matches();
	}

	/**
	 * 功能描述：判断输入的字符串是否为纯汉字
	 * 
	 * @param str
	 *            传入的字符窜
	 * @return 如果是纯汉字返回true,否则返回false
	 */
	public static boolean isChinese(String str) {
		Pattern pattern = Pattern.compile("[\u0391-\uFFE5]+$");
		return pattern.matcher(str).matches();
	}

	/**
	 * 功能描述：是否为空白,包括null和""
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isBlank(String str) {
		return str == null || str.trim().length() == 0 || "null".equals(str);
	}

	/**
	 * 功能描述：判断是否为质数
	 * 
	 * @param x
	 * @return
	 */
	public static boolean isPrime(int x) {
		if (x <= 7) {
			if (x == 2 || x == 3 || x == 5 || x == 7)
				return true;
		}
		int c = 7;
		if (x % 2 == 0)
			return false;
		if (x % 3 == 0)
			return false;
		if (x % 5 == 0)
			return false;
		int end = (int) Math.sqrt(x);
		while (c <= end) {
			if (x % c == 0) {
				return false;
			}
			c += 4;
			if (x % c == 0) {
				return false;
			}
			c += 2;
			if (x % c == 0) {
				return false;
			}
			c += 4;
			if (x % c == 0) {
				return false;
			}
			c += 2;
			if (x % c == 0) {
				return false;
			}
			c += 4;
			if (x % c == 0) {
				return false;
			}
			c += 6;
			if (x % c == 0) {
				return false;
			}
			c += 2;
			if (x % c == 0) {
				return false;
			}
			c += 6;
		}
		return true;
	}

	/**
	 * 功能描述：人民币转成大写
	 * 
	 * @param str
	 *            数字字符串
	 * @return String 人民币转换成大写后的字符串
	 */
	public static String hangeToBig(String str) {
		double value;
		try {
			value = Double.parseDouble(str.trim());
		} catch (Exception e) {
			return null;
		}
		char[] hunit = { '拾', '佰', '仟' }; // 段内位置表示
		char[] vunit = { '万', '亿' }; // 段名表示
		char[] digit = { '零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖' }; // 数字表示
		long midVal = (long) (value * 100); // 转化成整形
		String valStr = String.valueOf(midVal); // 转化成字符串

		String head = valStr.substring(0, valStr.length() - 2); // 取整数部分
		String rail = valStr.substring(valStr.length() - 2); // 取小数部分

		StringBuffer prefix = new StringBuffer(); // 整数部分转化的结果
		StringBuffer suffix = new StringBuffer(); // 小数部分转化的结果
		// 处理小数点后面的数
		if (rail.equals("00")) { // 如果小数部分为0
			suffix.append("整");
		} else {
			suffix.append(digit[rail.charAt(0) - '0'] + "角"
					+ digit[rail.charAt(1) - '0'] + "分"); // 否则把角分转化出来
		}
		// 处理小数点前面的数
		char[] chDig = head.toCharArray(); // 把整数部分转化成字符数组
		char zero = '0'; // 标志'0'表示出现过0
		byte zeroSerNum = 0; // 连续出现0的次数
		for (int i = 0; i < chDig.length; i++) { // 循环处理每个数字
			int idx = (chDig.length - i - 1) % 4; // 取段内位置
			int vidx = (chDig.length - i - 1) / 4; // 取段位置
			if (chDig[i] == '0') { // 如果当前字符是0
				zeroSerNum++; // 连续0次数递增
				if (zero == '0') { // 标志
					zero = digit[0];
				} else if (idx == 0 && vidx > 0 && zeroSerNum < 4) {
					prefix.append(vunit[vidx - 1]);
					zero = '0';
				}
				continue;
			}
			zeroSerNum = 0; // 连续0次数清零
			if (zero != '0') { // 如果标志不为0,则加上,例如万,亿什么的
				prefix.append(zero);
				zero = '0';
			}
			prefix.append(digit[chDig[i] - '0']); // 转化该数字表示
			if (idx > 0)
				prefix.append(hunit[idx - 1]);
			if (idx == 0 && vidx > 0) {
				prefix.append(vunit[vidx - 1]); // 段结束位置应该加上段名如万,亿
			}
		}

		if (prefix.length() > 0)
			prefix.append('圆'); // 如果整数部分存在,则有圆的字样
		return prefix.append(suffix).toString(); // 返回正确表示
	}

	/**
	 * 功能描述：去掉字符串中重复的子字符串
	 * 
	 * @param str
	 *            原字符串，如果有子字符串则用空格隔开以表示子字符串
	 * @return String 返回去掉重复子字符串后的字符串
	 */
	private static String removeSameString(String str) {
		Set mLinkedSet = new LinkedHashSet();// set集合的特征：其子集不可以重复
		String[] strArray = str.split(" ");// 根据空格(正则表达式)分割字符串
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < strArray.length; i++) {
			if (!mLinkedSet.contains(strArray[i])) {
				mLinkedSet.add(strArray[i]);
				sb.append(strArray[i] + " ");
			}
		}
		return sb.toString();
	}

	/**
	 * 功能描述：过滤特殊字符
	 * 
	 * @param src
	 * @return
	 */
	public static String encoding(String src) {
		if (src == null)
			return "";
		StringBuilder result = new StringBuilder();
		if (src != null) {
			src = src.trim();
			for (int pos = 0; pos < src.length(); pos++) {
				switch (src.charAt(pos)) {
				case '\"':
					result.append("&quot;");
					break;
				case '<':
					result.append("&lt;");
					break;
				case '>':
					result.append("&gt;");
					break;
				case '\'':
					result.append("&apos;");
					break;
				case '&':
					result.append("&amp;");
					break;
				case '%':
					result.append("&pc;");
					break;
				case '_':
					result.append("&ul;");
					break;
				case '#':
					result.append("&shap;");
					break;
				case '?':
					result.append("&ques;");
					break;
				default:
					result.append(src.charAt(pos));
					break;
				}
			}
		}
		return result.toString();
	}

	/**
	 * 功能描述：判断是不是合法的手机号码
	 * 
	 * @param handset
	 * @return boolean
	 */
	public static boolean isHandset(String handset) {
		try {
			String regex = "^1[\\d]{10}$";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(handset);
			return matcher.matches();

		} catch (RuntimeException e) {
			return false;
		}
	}

	/**
	 * 功能描述：反过滤特殊字符
	 * 
	 * @param src
	 * @return
	 */
	public static String decoding(String src) {
		if (src == null)
			return "";
		String result = src;
		result = result.replace("&quot;", "\"").replace("&apos;", "\'");
		result = result.replace("&lt;", "<").replace("&gt;", ">");
		result = result.replace("&amp;", "&");
		result = result.replace("&pc;", "%").replace("&ul", "_");
		result = result.replace("&shap;", "#").replace("&ques", "?");
		return result;
	}
	
	public static String replaceAll(String str) {
		if(str==null) {
		return null;
		}
		str = str.replace("chr(41)", "{'");
		str = str.replace("chr(42)", "'}");
		str = str.replace("chr(43)", "','");
		str = str.replace("chr(44)", "':'");
		str = str.replace("chr(39)", "\\'");
		str = str.replace("chr(38)", "&");
		str = str.replace("chr(60)", "<");
		str = str.replace("chr(62)", ">");
		str = str.replace("chr(37)", "%");
		str = str.replace("chr(50)", "#");
		str = str.replace("chr(40)", "\\\\");
		str = str.replace("chr(64)", "\\\r\\\n");
		return str;

	}
	
	public static String replaceAllNew(String str) {
		if(str==null) {
		return null;
		}
		str = str.replace("chr(41)", "{'");
		str = str.replace("chr(42)", "'}");
		str = str.replace("chr(43)", "','");
		str = str.replace("chr(44)", "':'");
		str = str.replace("chr(39)", "\'");
		str = str.replace("chr(38)", "&");
		str = str.replace("chr(60)", "<");
		str = str.replace("chr(62)", ">");
		str = str.replace("chr(37)", "%");
		str = str.replace("chr(50)", "#");
		str = str.replace("chr(40)", "\\\\");
		str = str.replace("chr(64)", "\\\r\\\n");
		return str;

	}
	
	public static String getSingleQm(String str) {
		String singleStr = "";
		if(!isBlank(str)) {
			String[] strTemArr = str.split(",");
			for(int i = 0; i < strTemArr.length; i++) {
				singleStr += "'"+ strTemArr[i] + "',";
			}
			singleStr = singleStr.substring(0, singleStr.length() - 1);
		}
		return singleStr;
		
	}
	/**
	 *  @author pingan.liu
	 *  @date 2013-4-19
	*<b>Summary: </b>
	* isBlankStringArray(判断一个String数组是不是为空或者是不是里面的所有值为绝对控制)
	* 如果为空返回true，否则返回false
	* @param str
	* @return 
	 */
	public static boolean isBlankStringArray(String[] str){
		if(str == null){
			return true;
		}
		for(int i =0;i<str.length;i++){
			if(str[i] != null && !"".equals(str[i].trim())){
				//如果不为空，并且不为空串
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* splitStr(请用一句话描述这个方法的作用)
	* 按照逗号分隔字符串
	* @param str
	* @return 返回一个字符串数组
	 */
	public static String[] splitStr(String str){
		String[] arrStr = null;
		arrStr = str.split(",");
		return arrStr;
	}
	/**
	 * 读取html中所有元素(用于手机端展示正文)
	 * --(也可在手机端用网络爬虫方式-待实现)
	 * @param id
	 * @return String
	 * @author 刘春元
	 */
	public static String readHtml(String id) throws FileNotFoundException,IOException{
		BufferedReader br=null; 

		StringBuffer sb = new StringBuffer();
		String temps = StringUtil.class.getResource("/").getPath().replaceAll("/WEB-INF/classes/", "");
		String path = temps+"/ccapp/xtbg/resources/plug/iWebOffice2009/HTML/"+id+".htm";
		try {
			br=new BufferedReader(new InputStreamReader(new FileInputStream(path), "GBK"));

			String temp=null;String temp1=null;String temp2=null;
			while((temp=br.readLine())!=null){
				sb.append(temp);  
			} 

		}finally{
			try {
				if(br!=null){
					br.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//System.out.println("GBK"+sb.toString());
		return sb.toString();  
	} 
	
	/**
	 * 获得UUID的值
	 * 
	 * @return uuid序列值
	 * @throws Exception
	 */
	public static String getUUID() {
		String uuid =  UUID.randomUUID().toString();
		return uuid;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* isHave(判断字符是否包含在字符串数组中)
	* @param strs
	* @param s
	* @return
	 */
	public static boolean isHave(List<String> strs,String s){
	  for(int i=0;i<strs.size();i++){
		   if(strs.get(i).equals(s)){
		    return true;
		   }
	  }
	  return false;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* replaceIdeaStyle(去掉流程意见中的样式)
	* @param strIdea
	* @return
	 */
	public static String replaceIdeaStyle(String strIdea){
		if("".equals(deNull(strIdea))){
			return "";
		} else{
			return strIdea.replaceAll("class=\"idea_title\"","style='list-style-type : none;'")
			.replaceAll("class=\"idea_content\"","style='list-style-type : none;text-align : right;line-height:0px;'");
		}
	}
}