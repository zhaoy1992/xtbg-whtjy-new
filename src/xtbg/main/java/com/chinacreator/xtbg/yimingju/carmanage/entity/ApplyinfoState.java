package com.chinacreator.xtbg.yimingju.carmanage.entity;
/**
 * 车辆申请管理状态
 * @author haiyun
 *
 */
public class ApplyinfoState {
	/**-----   车辆申请管理状态       -----**/
	public static final String APPLYINFO_WRIT_FP = "1";//等待车辆分派
	
	public static final String APPLYINFO_WRIT_SP = "2";//已派车
	
	public static final String APPLYINFO_SP_NOPASS = "3";//审批未通过
	
	public static final String APPLYINFO_SP_PASS = "4";//审批通过
	
	public static final String APPLYINFO_PC_END = "5";// 派车结束
	
	public static final String APPLYINFO_NO_FP = "6";// 派车不通过
	
	public static final String APPLYINFO_WRIT_FP_NAME = "等待派车";//等待车辆分派
	
	public static final String APPLYINFO_WRIT_SP_NAME = "审批通过";//审批通过
	
	public static final String APPLYINFO_SP_NOPASS_NAME = "审批未通过";//审批未通过
	
	public static final String APPLYINFO_SP_PASS_NAME = "等待审批";//等待审批 已经派车
	
	public static final String APPLYINFO_PC_END_NAME = "派车结束";// 派车结束
	
	public static final String APPLYINFO_NO_FP_NAME = "派车不通过";// 派车结束
	
	/**-----   车辆当前状态       -----**/
	public static final String CAR_WAIT_PC = "1";//等待派车
	
	public static final String CAR_SP_NOPASS = "2";//审批未通过
	
	public static final String CAR_PC = "3";//已派车
	
	public static final String CAR_PC_END = "4";// 结束派车
	
	public static final String CAR_WAIT_PC_NAME = "等待派车";//等待派车
	
	public static final String CAR_SP_NOPASS_NAME = "审批未通过";//审批未通过
	
	public static final String CAR_PC_NAME = "已派车";//已派车
	
	public static final String CAR_PC_END_NAME = "已结束";// 派车结束
	
	/**-----   车辆维修保养状态       -----**/
	public static final String WXBY_WRIT_SP = "1";//待审批
	
	public static final String WXBY_SP_NOPASS = "2";//审批未通过
	
	public static final String WXBY_SP_PASS = "3";//审批通过
	/**-----   车辆维修保养类型       -----**/
	public static final String WXBY_TYPE_BY = "1"; // 保养
	
	public static final String WXBY_TYPE_WX = "2"; // 维修
	
	
}
