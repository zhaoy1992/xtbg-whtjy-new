package com.chinacreator.xtbg.core.common.util;

/**
 * 
 *<p>Title:ResultCode.java</p>
 *<p>Description:错误代码结果集</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Apr 28, 2013
 */
public class ResultCode {
	private int index;
	public ResultCode (int code){
		this.index = code;
	}
	
	
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + index;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final ResultCode other = (ResultCode) obj;
		if (index != other.index)
			return false;
		return true;
	}

	/**
	 * 成功
	 */
	public static final ResultCode OK = new ResultCode(0);
	/**
	 * 失败
	 */
	public static final ResultCode FAIL = new ResultCode(-1);
	
	/**
	 * 数据已存在
	 */
	public static final ResultCode EXIST = new ResultCode(-2); 
	/**
	 * 数据不存在
	 */
	public static final ResultCode UNEXIST = new ResultCode(-3);
	/**
	 * 缺少字典类型名称
	 */
	public static final ResultCode MISS_DICT_TYPE_NAME = new ResultCode(-4);
	/**
	 * 字典类型重复
	 */
	public static final ResultCode EXIST_TYPE_TYPE_NAME = new ResultCode(-5);
	/**
	 * 缺少字典类型ID
	 */
	public static final ResultCode MISS_DICT_TYPE_ID = new ResultCode(-6);
	/**
	 * 缺少字典名称
	 */
	public static final ResultCode MISS_DICT_NAME = new ResultCode(-7);
	/**
	 * 字典名称已存在
	 */
	public static final ResultCode EXIST_DICT_NAME = new ResultCode(-8);
	/**
	 * 字典编码已存在
	 */
	public static final ResultCode EXIST_DICT_CODE = new ResultCode(-9);
	/**
	 * 缺少字典ID
	 */
	public static final ResultCode MISS_DICT_ID = new ResultCode(-10);
	/**
	 * 缺少字典编码
	 */
	public static final ResultCode MISS_DICT_CODE = new ResultCode(-11);
	/**
	 * 缺少部门ID
	 */
	public static final ResultCode MISS_DEPT_ID = new ResultCode(-12);
	/**
	 * 缺少用户ID
	 */
	public static final ResultCode MISS_USER_ID = new ResultCode(-13);
	/**
	 * 缺少计划年份
	 */
	public static final ResultCode MISS_PLAN_YEAR = new ResultCode(-14);
	/**
	 * 缺少周计划开始时间
	 */
	public static final ResultCode MISS_START_DATE = new ResultCode(-15);
	/**
	 * 缺少周计划结束时间
	 */
	public static final ResultCode MISS_END_DATE = new ResultCode(-16);
	/**
	 * 缺少计划ID
	 */
	public static final ResultCode MISS_PLAN_ID = new ResultCode(-17);
	/**
	 *缺少牵头人 
	 */
	public static final ResultCode MISS_HEADER = new ResultCode(-18);
	/**
	 * 缺少责任人
	 */
	public static final ResultCode MISS_OWNER = new ResultCode(-19);
	/**
	 * 缺少详细计划类型（本周总结或下周计划）
	 */
	public static final ResultCode MISS_DETAIL_TYPE = new ResultCode(-20);
	/**
	 * 任务来源类型为空（新增或遗留）
	 */
	public static final ResultCode MISS_DETAIL_FROM_TYPE = new ResultCode(-21);
	/**
	 * 缺少任务描述
	 */
	public static final ResultCode MISS_DETAIL_ITEMS = new ResultCode(-22);
	/**
	 * 缺少详细计划ID
	 */
	public static final ResultCode MISS_DETAIL_ID = new ResultCode(-23);
	/**
	 * 缺少将要copy的遗留任务的id字符串
	 */
	public static final ResultCode MISS_OLD_IDS = new ResultCode(-24);
	/**
	 * 缺少计划变更前的时间
	 */
	public static final ResultCode MISS_DETAIL_END_TIME = new ResultCode(-25);
	/**
	 * 缺少计划变更后的时间
	 */
	public static final ResultCode MISS_DETAIL_CHANGE_END_TIME = new ResultCode(-26);
	/**
	 * 计划开始时间大于结束时间
	 */
	public static final ResultCode START_DATE_GREATER_END_DATE = new ResultCode(-27);
	/**
	 * 排序号重复
	 */
	public static final ResultCode EXIST_ORDER_NO = new ResultCode(-28);
	/**
	 * 任务为交办时，交办人和交办时间为空
	 */
	public static final ResultCode MISS_URGEUSER_AND_URGETIME = new ResultCode(-29);
	/**
	 * 任务完成时，任务实际完成时间为空
	 */
	public static final ResultCode MISS_FINISH_TIME = new ResultCode(-30);
	/**
	 * 缺少年份信息
	 */
	public static final ResultCode MISS_YEAR = new ResultCode(-31);
	/**
	 * 缺少批量查询项目栏目定义的id串号
	 */
	public static final ResultCode MISS_PROJECT_COLUMN_IDS = new ResultCode(-32);
	/**
	 * 缺少项目实例ID
	 */
	public static final ResultCode MISS_PROJECT_INS_ID = new ResultCode(-33);
	/**
	 * 缺少项目栏目信息ID
	 */
	public static final ResultCode PROJECT_COLUMN_INFO_ID = new ResultCode(-34);
	/**
	 * 缺少项目栏目ID
	 */
	public static final ResultCode MISS_PROJECT_COLUMN_ID = new ResultCode(-35);
	/**
	 * 缺少土地类型ID
	 */
	public static final ResultCode MISSLANDTYPE = new ResultCode(-36);
	/**
	 * 缺少土地位置
	 */
	public static final ResultCode MISSLANDLOCATION = new ResultCode(-37);
	/**
	 * 缺少土地编号
	 */
	public static final ResultCode MISS_LAND_ID = new ResultCode(-38);
	/**
	 * 缺少ID
	 */
	public static final ResultCode MISS_ID = new ResultCode(-39);
	/**
	 * 缺少知识库分类ID
	 */
	public static final ResultCode MISS_ZSFL_NAME = new ResultCode(-40);
	/**
	 * 缺少档案目录索引标题
	 */
	public static final ResultCode MISS_CATALOGUE_TITLE = new ResultCode(-41);
	/**
	 * 缺少资金申报月份
	 */
	public static final ResultCode MISS_MONTH = new ResultCode(-42);
	
	/**
	 * 缺少公共信息分类模块的分类名称
	 */
	public static final ResultCode MISS_INFO_SORT_NAME = new ResultCode(-43);
	/**
	 * 缺少公共信息分类模块的分类类别
	 */
	public static final ResultCode MISS_SORT_TYPE = new ResultCode(-44);
	/**
	 * 缺少拆分文件名称
	 */
	public static final ResultCode MISS_SPLIT_FILENAME = new ResultCode(-45);
	/**
	 * 缺少督办标题
	 */
	public static final ResultCode MISS_URGE_TITLE = new ResultCode(-46);
	/**
	 * 指标文_缺少附件名称
	 */
	public static final ResultCode MISS_SHOWN_NAME = new ResultCode(-47);
	/**
	 * 缺少文件路径
	 */
	public static final ResultCode MISS_FILE_PATH = new ResultCode(-48);
	/**
	 * 指标文拆分_缺少拆分单位
	 */
	public static final ResultCode MISS_UNIT_ID = new ResultCode(-49);
}
