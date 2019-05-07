package com.chinacreator.xtbg.core.common.commonlist;

/**
 *<p>Title:Constant.java</p>
 *<p>Description:记录系统中的常量</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *@date 2012-1-13
 */
public class Constant {

	public static final String STATUS_TRUE = "true"; 
	
	public static final String STATUS_FALSE = "false"; 
	
	public static final String STATUS_NULL = "";
	
	public static final String IS_SHOWANDACTSELECTTEXT = "isShowAndActSelectText"; //是否动态选择环节
	
	public static final String IS_SHOWANCACTSELECTUSERTEXT = "isShowAndActSelectUserText"; //是否动态选择执行人
	
	public static final String COLON = ":"; //冒号
	
	public static final String NULL = ""; //空值
	
	public static final String SEMICOLON = ";"; //分号
	
	public static final String WELLCOLON = "#"; //#号
	
	public static final String AREACOLON = "@"; //@号
	
	public static final String COMMA = ","; //逗号
	
	public static final String STATUS_Y = "Y"; //逗号
	
	public static final String IS_VIEW = "1"; //是否是意见字段

	//调查问卷相关静态变量
	public static final String DANXUANTI = "DANXUAN"; //单选题

	public static final String DUOXUANTI = "DUOXUAN"; //多选题

	public static final String TIANKONGTI = "TIANKONG"; //填空题
	
	public static final String ZTTP = "ZTTP"; //专题投票
	
	public static final String RYCP = "RYCP"; //人员测评投票
	
	public static final String COLUMNNAME = "姓名"; //人员测评投票时第一列的列头名称
	
	public static final String ZANCUN = "voteSave"; //acitonType为暂存
	
	public static final String TIJIAO = "voteSubmit"; //acitonType为暂存并提交


	//调查问卷相关静态变量END
    public static final String RYCPID = "DC3075FBC7A77E97E0430100007F2424";//人员测评的id

    //需要发送短信    
    public static final String SEND = "1";
    //已发布
    public static final String YIFABU = "1";
    
    //添加操作
    public static final String ACTION_ADD = "add";
    //更新操作
    public static final String ACTION_UPDATE = "update";
    //删除操作
    public static final String ACTION_DELETE = "delete";
    //查询操作
    public static final String ACTION_QUERY = "query";
    //分隔符（通用保存用） 两个下划线 ‘_’
    public static final String SEPARATOR = "__";
}
