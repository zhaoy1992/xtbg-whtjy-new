package com.chinacreator.xtbg.core.directory.constant;

import com.chinacreator.xtbg.pub.util.BusinessUtil;

/**
 * 
 *<p>Title:DirectoryConstant.java</p>
 *<p>Description:人员信息管理的常量类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2014-3-9
 */
public class DirectoryConstant {
	/**
	 * 
	*<b>Summary: </b>
	* parsePersonSex(解析人员性别)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parsePersonSex(String str,boolean iskeytovalue){
		String[][] keyvalues = {{"M","男"},{"F","女"}};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parsePersonType(解析人员类别)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parsePersonType(String str,boolean iskeytovalue){
		String[][] keyvalues = {{"bnzg","编内职工"},{"bwzg","编外职工"},{"txzg","退休职工"}};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parsetrueto1(转化字符串，是为1，否为0)
	* @return
	 */
	public static String parseBoolean(String str,boolean iskeytovalue){
		String[][] keyvalues = {{"1","是"},{"0","否"}};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parseJobState(解析在岗状态)
	* @return
	 */
	public static String parseJobState(String str,boolean iskeytovalue){
		String[][] keyvalues = {{"1","编内在岗职工"},{"2","省院内部借调职工"},{"3","质监系统借调职工"},{"4","在编不在岗职工"},{"5","无固定期劳动合同(参编职工)"},{"6","岳阳事业部编内"}};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parseJobSet(解析岗位设置)
	* @return
	 */
	public static String parseJobSet(String str,boolean iskeytovalue){
		String[][] keyvalues = {{"glgw","管理岗位"},{"zjgw","专技岗位"},{"gqgw","工勤岗位"}};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	/**
	 * 
	*<b>Summary: </b>
	* parsePolitics(解析政治面貌)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parsePolitics(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "1", "中共党员" }, { "2", "中共预备党员" },
				{ "3", "共青团员" }, { "4", "民革党员" }, { "5", "民盟盟员" },
				{ "6", "民建会员" }, { "7", "民进会员" }, { "8", "农工党党员" },
				{ "9", "致公党党员" }, { "10", "九三学社社员" }, { "11", "台盟盟员" },
				{ "12", "无党派民主人士" }, { "13", "群众" } };
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parseEducation(解析学历)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parseEducation(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "phd", "研究生" }, { "graduate", "硕士研究生" },
				{ "undergraduate", "本科" }, { "specialist", "专科" },
				{ "highschool", "高中" }, { "secondary", "中专" },
				{ "juniorhighschool", "初中" }, { "primaryschool", "小学" },
				{ "other", "其他" } };
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parseDegree(解析学位)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parseDegree(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "xs", "学士" }, { "ss", "硕士" },
				{ "bs", "博士" } };
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parseNewjszc(解析技术职称)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parseNewjszc(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "yjygjgcs", "研究员级高级工程师" }, { "gjgcs", "高级工程师" },
				{ "gcs", "工程师" }, { "zlgcs", "助理工程师" }, { "jsy", "技术员" },
				{ "gjjjs", "高级经济师" }, { "jjs", "经济师" }, { "zljjs", "助理经济师" },
				{ "gjkjy", "高级会计师" }, { "zlkjy", "助理会计师" }, { "kjy", "会计员" }};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	/**
	 * 
	*<b>Summary: </b>
	* parseHetongtype(解析合同类别)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parseHetongtype(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "timeHT", "固定期劳动合同" }, { "notimeHT", "无固定期劳动合同" },
				{ "notimeHTCB", "无固定期劳动合同(参编)" }, { "lwpqHT", "劳务派遣合同" }, 
				{ "lwHT", "劳务合同" }};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parsePost(解析职务)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parsePost(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "1", "院长" }, { "2", "党委书记" },
				{ "3", "副院长" }, { "4", "省院总工程师" }, 
				{ "5", "纪检书记" }, { "6", "部长" }, { "7", "分院院长" }, 
				{ "8", "省院副总工程师" }, { "9", "副部长" }, { "10", "分院副院长" },
				{ "11", "分院总工" },{ "12", "院长助理" },{ "13", "主任" },
				{ "14", "副主任" },{ "15", "部长兼省院副总工程师" },{ "16", "总经理" },
				{ "17", "副总经理" },{ "18", "工会主席" },{ "19", "分院工会主席" }};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	/**
	 * 
	*<b>Summary: </b>
	* parseDirectorystate(在职状态)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parseDirectorystate(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "jobing", "在职" }, { "departure", "离职" },
				{ "retirement", "退休" }};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parseDirectoryhold_org(审职机构)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parseDirectoryhold_org(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "0", "国家" }, { "1", "省局" },
				{ "2", "中国计量" }};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parseDirectoryhold_state(证书是否注册)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parseDirectoryhold_state(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "1", "是" }, { "0", "否" }};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parsePersionhold_state(人员持证状态)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parsePersionhold_state(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "ycz", "已持证" }, { "dfz", "待发证" },{ "ydx", "已吊销" }, { "hzz", "换证中" }, { "bgz", "变更中" },{ "ycq", "已超期" }};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parseTrain_level(人员持证培训级别
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parseTrain_level(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "0", "非专业" }, { "1", "专业技术" },{"2","其它项目"}};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parseDev_stockflag(仪器设备使用状态)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parseDev_stockflag(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "1", "在库" }, { "2", "借出" }};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* parseDev_state(仪器设备完好状态)
	* @param str
	* @param iskeytovalue
	* @return
	 */
	public static String parseDev_state(String str,boolean iskeytovalue){
		String[][] keyvalues = { { "1", "完好" }, { "2", "在修"},{"3", "报废"},{"4", "损耗"},{"5", "停用"}};
		return BusinessUtil.parseValueAndKey(str, keyvalues, iskeytovalue);
	}
	
	
	
}
