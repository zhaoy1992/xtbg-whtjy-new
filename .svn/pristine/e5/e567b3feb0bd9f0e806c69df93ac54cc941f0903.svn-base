package com.chinacreator.xtbg.core.file.entity;


import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:FileDocBean.java</p>
 *<p>Description:文件管理实体bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-7-23
 */
public class FileDocBean extends XtDbBaseBean{
	
	public static final String F_PROGRAM_ID_WEN_SHU  = "f0fe0a05-e472-45da-a5e9-94dbbffe6e6c";
	public static final String F_PROGRAM_ID_GUANG_PAN  = "fff6a4a1-5943-46dd-bc6c-07591e5c6ebd";
	public static final String F_PROGRAM_ID_SHI_PIN  = "fc74cac7-8256-4d0f-902d-0316e7fb2b7e";
	public static final String F_PROGRAM_ID_ZAHO_PIAN  = "ed635d24-fced-4353-81f9-86b18e378ef6";
	public FileDocBean(){
		//在构造器里面设置好表名和主键，具体进行更新，删除等操作时可以重新设置updateKey，deleteKey，及主键
		super("oa_file_doc", "f_doc_id");
	}
	private String f_doc_id;		//文件ID
	private String f_doc_name;		//文件标题
	private String f_doc_fontsize;		//文件字号
	private String f_type_id;		//档案分类ID
	private String f_type_name;		//档案分类名称
	private String f_doc_keywords;		//主题词
	private String f_doc_year;		//档案年份
	private String f_secrecy_id;		//密级ID
	private String f_secrecy_name;		//密级名称
	private String f_org_id;		//所属的单位ID
	private String f_org_name;		//所属单位名称
	private String f_dept_id;		//所属部门ID
	private String f_dept_name;		//所属部门名
	private String f_doc_checkuser;		//审批人
	private String f_doc_blname;		//责任者
	private Object f_file_formtime;		//文件形成日期
	private String f_file_quantity;		//数量
	private String f_type_remark;		//备注
	private String f_user_id;		//登记人ID
	private String f_user_name;		//登记姓名
	private Object f_creator_time;		//登记时间
	private String f_doc_content;		//内容
	private String f_attach_id;		//附件ID
	private String f_doc_state;		//归档状态
	private String f_doc_state_name;		//归档状态name
	private String f_file_no;		//档号(全综号_档案分类号_保管期限_案卷号_件号)
	private String f_typeno;		//档案分类号
	private String f_doc_num;		//件号
	private String f_info_num;		//参见号
	private String f_doc_media;		//介质类型
	private String f_doc_media_name;		//介质类型name
	private String f_entity_type;		//实物类型
	private String f_entity_type_name;		//实物类型name
	private String f_burn_user_id;		//刻录人id
	private String f_burn_user_name;		//刻录人name
	private String f_file_num;		//归档数量
	private String f_doc_deadline;		//保管期限
	private String f_doc_deadline_name;//保管期限名
	private String f_file_userid;		//归档人ID
	private String f_file_username;		//归档人姓名
	private Object f_file_time;		//归档日期
	private String f_info_type;
	private String f_info_type_name;
	private String f_gongwen_id;
	public String getF_gongwen_id() {
		return f_gongwen_id;
	}
	public void setF_gongwen_id(String f_gongwen_id) {
		this.f_gongwen_id = f_gongwen_id;
	}
	public String getF_info_type() {
		return f_info_type;
	}
	public void setF_info_type(String f_info_type) {
		this.f_info_type = f_info_type;
	}
	public String getF_info_type_name() {
		return f_info_type_name;
	}
	public void setF_info_type_name(String f_info_type_name) {
		this.f_info_type_name = f_info_type_name;
	}
	private String f_destroy_state;		//销毁状态  1是已销毁
	private String f_file_num_unit_name;//数量单位name
	private String f_file_num_unit;//数量单位
	private String notInId; //页面参数 
	private String f_zihao_type_name;		//字号类型
	private String f_wenhao;		//文号(文件字号的后面部分)
	
	private String f_attach_id_min;
	private String f_attach_id_max;
	
	private String start_time;
	private String end_time;
	//
	private String f_flow_state;
	private String f_rollback_idea;
	private String f_submit_user_id;
	private String f_submit_user_name;
	private String f_submit_time;
	
	private String userRole;
	
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	public String getF_flow_state() {
		return f_flow_state;
	}
	public void setF_flow_state(String f_flow_state) {
		this.f_flow_state = f_flow_state;
	}
	public String getF_rollback_idea() {
		return f_rollback_idea;
	}
	public void setF_rollback_idea(String f_rollback_idea) {
		this.f_rollback_idea = f_rollback_idea;
	}
	public String getF_submit_user_id() {
		return f_submit_user_id;
	}
	public void setF_submit_user_id(String f_submit_user_id) {
		this.f_submit_user_id = f_submit_user_id;
	}
	public String getF_submit_user_name() {
		return f_submit_user_name;
	}
	public void setF_submit_user_name(String f_submit_user_name) {
		this.f_submit_user_name = f_submit_user_name;
	}
	public String getF_submit_time() {
		return f_submit_time;
	}
	public void setF_submit_time(String f_submit_time) {
		this.f_submit_time = f_submit_time;
	}

	
	/**
	 * 模式1:案卷外新增
	 */
	public static final String MODEL_A = "1";
	/**
	 * 模式2:案卷外修改
	 */
	public static final String MODEL_B = "2";
	/**
	 * 模式3:案卷内新增
	 */
	public static final String MODEL_C = "3";
	/**
	 * 模式4:案卷内修改
	 */
	public static final String MODEL_D = "4";
	/**
	 * 模式5:只读
	 */
	public static final String MODEL_E = "5";
	/**
	 * 状态:已归档
	 */
	public static final String STATE_YGD = "2";
	public static final String STATE_YGD_NM = "已归档";
	/**
	 * 状态:已移交
	 */
	public static final String STATE_YYJ = "8";
	public static final String STATE_YYJ_NM = "已移交";
	/**
	 * 状态:已销毁
	 */
	public static final String STATE_YXH = "9";
	/**
	 * 状态:待归档
	 */
	public static final String STATE_DGD = "0";
	public static final String STATE_DGD_NM = "待归档";
	/**
	 * 状态:不需归档
	 */
	public static final String STATE_BXGD = "1";
	/**
	 * 销毁状态:未销毁
	 */
	public static final String F_DESTROY_STATE_ONE = "0";
	/**
	 * 销毁状态:已销毁
	 */
	public static final String F_DESTROY_STATE_TWO = "1";
	
	/**
	 * 归档状态:已销毁
	 */
	public static final String F_DOC_STATE_DESTROY = "9";
	public String getNotInId() {
		return notInId;
	}
	public void setNotInId(String notInId) {
		this.notInId = notInId;
	}
	private String f_type;  //档案销毁 页面参赛  查询不同的结果集
	public String getF_type() {
		return f_type;
	}
	public void setF_type(String f_type) {
		this.f_type = f_type;
	}
	/**
	*<b>Summary: 获取文件ID</b>
	*/
	public String getF_doc_id() {
		return f_doc_id;
	}
	/**
	*<b>Summary: 设置文件ID</b>
	*/
	public void setF_doc_id(String f_doc_id) {
		this.f_doc_id = f_doc_id;
	}
	/**
	*<b>Summary: 获取文件标题</b>
	*/
	public String getF_doc_name() {
		return f_doc_name;
	}
	/**
	*<b>Summary: 设置文件标题</b>
	*/
	public void setF_doc_name(String f_doc_name) {
		this.f_doc_name = f_doc_name;
	}
	/**
	*<b>Summary: 获取文件字号</b>
	*/
	public String getF_doc_fontsize() {
		return f_doc_fontsize;
	}
	/**
	*<b>Summary: 设置文件字号</b>
	*/
	public void setF_doc_fontsize(String f_doc_fontsize) {
		this.f_doc_fontsize = f_doc_fontsize;
	}
	/**
	*<b>Summary: 获取档案分类ID</b>
	*/
	public String getF_type_id() {
		return f_type_id;
	}
	/**
	*<b>Summary: 设置档案分类ID</b>
	*/
	public void setF_type_id(String f_type_id) {
		this.f_type_id = f_type_id;
	}
	/**
	*<b>Summary: 获取档案分类名称</b>
	*/
	public String getF_type_name() {
		return f_type_name;
	}
	/**
	*<b>Summary: 设置档案分类名称</b>
	*/
	public void setF_type_name(String f_type_name) {
		this.f_type_name = f_type_name;
	}
	/**
	*<b>Summary: 获取主题词</b>
	*/
	public String getF_doc_keywords() {
		return f_doc_keywords;
	}
	/**
	*<b>Summary: 设置主题词</b>
	*/
	public void setF_doc_keywords(String f_doc_keywords) {
		this.f_doc_keywords = f_doc_keywords;
	}
	/**
	*<b>Summary: 获取档案年份</b>
	*/
	public String getF_doc_year() {
		return f_doc_year;
	}
	/**
	*<b>Summary: 设置档案年份</b>
	*/
	public void setF_doc_year(String f_doc_year) {
		this.f_doc_year = f_doc_year;
	}
	/**
	*<b>Summary: 获取密级ID</b>
	*/
	public String getF_secrecy_id() {
		return f_secrecy_id;
	}
	/**
	*<b>Summary: 设置密级ID</b>
	*/
	public void setF_secrecy_id(String f_secrecy_id) {
		this.f_secrecy_id = f_secrecy_id;
	}
	/**
	*<b>Summary: 获取密级名称</b>
	*/
	public String getF_secrecy_name() {
		return f_secrecy_name;
	}
	/**
	*<b>Summary: 设置密级名称</b>
	*/
	public void setF_secrecy_name(String f_secrecy_name) {
		this.f_secrecy_name = f_secrecy_name;
	}
	/**
	*<b>Summary: 获取所属的单位ID</b>
	*/
	public String getF_org_id() {
		return f_org_id;
	}
	/**
	*<b>Summary: 设置所属的单位ID</b>
	*/
	public void setF_org_id(String f_org_id) {
		this.f_org_id = f_org_id;
	}
	/**
	*<b>Summary: 获取所属单位名称</b>
	*/
	public String getF_org_name() {
		return f_org_name;
	}
	/**
	*<b>Summary: 设置所属单位名称</b>
	*/
	public void setF_org_name(String f_org_name) {
		this.f_org_name = f_org_name;
	}
	/**
	*<b>Summary: 获取所属部门ID</b>
	*/
	public String getF_dept_id() {
		return f_dept_id;
	}
	/**
	*<b>Summary: 设置所属部门ID</b>
	*/
	public void setF_dept_id(String f_dept_id) {
		this.f_dept_id = f_dept_id;
	}
	/**
	*<b>Summary: 获取所属部门名</b>
	*/
	public String getF_dept_name() {
		return f_dept_name;
	}
	/**
	*<b>Summary: 设置所属部门名</b>
	*/
	public void setF_dept_name(String f_dept_name) {
		this.f_dept_name = f_dept_name;
	}
	/**
	*<b>Summary: 获取审批人</b>
	*/
	public String getF_doc_checkuser() {
		return f_doc_checkuser;
	}
	/**
	*<b>Summary: 设置审批人</b>
	*/
	public void setF_doc_checkuser(String f_doc_checkuser) {
		this.f_doc_checkuser = f_doc_checkuser;
	}
	/**
	*<b>Summary: 获取责任者</b>
	*/
	public String getF_doc_blname() {
		return f_doc_blname;
	}
	/**
	*<b>Summary: 设置责任者</b>
	*/
	public void setF_doc_blname(String f_doc_blname) {
		this.f_doc_blname = f_doc_blname;
	}
	/**
	*<b>Summary: 获取文件形成日期</b>
	*/
	public Object getF_file_formtime() {
		return f_file_formtime;
	}
	/**
	*<b>Summary: 设置文件形成日期</b>
	*/
	public void setF_file_formtime(Object f_file_formtime) {
		this.f_file_formtime = f_file_formtime;
	}
	/**
	*<b>Summary: 获取数量</b>
	*/
	public String getF_file_quantity() {
		return f_file_quantity;
	}
	/**
	*<b>Summary: 设置数量</b>
	*/
	public void setF_file_quantity(String f_file_quantity) {
		this.f_file_quantity = f_file_quantity;
	}
	/**
	*<b>Summary: 获取备注</b>
	*/
	public String getF_type_remark() {
		return f_type_remark;
	}
	/**
	*<b>Summary: 设置备注</b>
	*/
	public void setF_type_remark(String f_type_remark) {
		this.f_type_remark = f_type_remark;
	}
	/**
	*<b>Summary: 获取登记人ID</b>
	*/
	public String getF_user_id() {
		return f_user_id;
	}
	/**
	*<b>Summary: 设置登记人ID</b>
	*/
	public void setF_user_id(String f_user_id) {
		this.f_user_id = f_user_id;
	}
	/**
	*<b>Summary: 获取登记姓名</b>
	*/
	public String getF_user_name() {
		return f_user_name;
	}
	/**
	*<b>Summary: 设置登记姓名</b>
	*/
	public void setF_user_name(String f_user_name) {
		this.f_user_name = f_user_name;
	}
	/**
	*<b>Summary: 获取登记时间</b>
	*/
	public Object getF_creator_time() {
		return f_creator_time;
	}
	/**
	*<b>Summary: 设置登记时间</b>
	*/
	public void setF_creator_time(Object f_creator_time) {
		this.f_creator_time = f_creator_time;
	}
	/**
	*<b>Summary: 获取内容</b>
	*/
	public String getF_doc_content() {
		return f_doc_content;
	}
	/**
	*<b>Summary: 设置内容</b>
	*/
	public void setF_doc_content(String f_doc_content) {
		this.f_doc_content = f_doc_content;
	}
	/**
	*<b>Summary: 获取附件ID</b>
	*/
	public String getF_attach_id() {
		return f_attach_id;
	}
	/**
	*<b>Summary: 设置附件ID</b>
	*/
	public void setF_attach_id(String f_attach_id) {
		this.f_attach_id = f_attach_id;
	}
	/**
	*<b>Summary: 获取归档状态</b>
	*/
	public String getF_doc_state() {
		return f_doc_state;
	}
	/**
	*<b>Summary: 设置归档状态</b>
	*/
	public void setF_doc_state(String f_doc_state) {
		this.f_doc_state = f_doc_state;
	}
	/**
	*<b>Summary: 获取归档状态name</b>
	*/
	public String getF_doc_state_name() {
		return f_doc_state_name;
	}
	/**
	*<b>Summary: 设置归档状态name</b>
	*/
	public void setF_doc_state_name(String f_doc_state_name) {
		this.f_doc_state_name = f_doc_state_name;
	}
	/**
	*<b>Summary: 获取档号(全综号_档案分类号_保管期限_案卷号_件号)</b>
	*/
	public String getF_file_no() {
		return f_file_no;
	}
	/**
	*<b>Summary: 设置档号(全综号_档案分类号_保管期限_案卷号_件号)</b>
	*/
	public void setF_file_no(String f_file_no) {
		this.f_file_no = f_file_no;
	}
	/**
	*<b>Summary: 获取档案分类号</b>
	*/
	public String getF_typeno() {
		return f_typeno;
	}
	/**
	*<b>Summary: 设置档案分类号</b>
	*/
	public void setF_typeno(String f_typeno) {
		this.f_typeno = f_typeno;
	}
	/**
	*<b>Summary: 获取件号</b>
	*/
	public String getF_doc_num() {
		return f_doc_num;
	}
	/**
	*<b>Summary: 设置件号</b>
	*/
	public void setF_doc_num(String f_doc_num) {
		this.f_doc_num = f_doc_num;
	}
	/**
	*<b>Summary: 获取参见号</b>
	*/
	public String getF_info_num() {
		return f_info_num;
	}
	/**
	*<b>Summary: 设置参见号</b>
	*/
	public void setF_info_num(String f_info_num) {
		this.f_info_num = f_info_num;
	}
	/**
	*<b>Summary: 获取介质类型</b>
	*/
	public String getF_doc_media() {
		return f_doc_media;
	}
	/**
	*<b>Summary: 设置介质类型</b>
	*/
	public void setF_doc_media(String f_doc_media) {
		this.f_doc_media = f_doc_media;
	}
	/**
	*<b>Summary: 获取介质类型name</b>
	*/
	public String getF_doc_media_name() {
		return f_doc_media_name;
	}
	/**
	*<b>Summary: 设置介质类型name</b>
	*/
	public void setF_doc_media_name(String f_doc_media_name) {
		this.f_doc_media_name = f_doc_media_name;
	}
	/**
	*<b>Summary: 获取实物类型</b>
	*/
	public String getF_entity_type() {
		return f_entity_type;
	}
	/**
	*<b>Summary: 设置实物类型</b>
	*/
	public void setF_entity_type(String f_entity_type) {
		this.f_entity_type = f_entity_type;
	}
	/**
	*<b>Summary: 获取实物类型name</b>
	*/
	public String getF_entity_type_name() {
		return f_entity_type_name;
	}
	/**
	*<b>Summary: 设置实物类型name</b>
	*/
	public void setF_entity_type_name(String f_entity_type_name) {
		this.f_entity_type_name = f_entity_type_name;
	}
	/**
	*<b>Summary: 获取刻录人id</b>
	*/
	public String getF_burn_user_id() {
		return f_burn_user_id;
	}
	/**
	*<b>Summary: 设置刻录人id</b>
	*/
	public void setF_burn_user_id(String f_burn_user_id) {
		this.f_burn_user_id = f_burn_user_id;
	}
	/**
	*<b>Summary: 获取刻录人name</b>
	*/
	public String getF_burn_user_name() {
		return f_burn_user_name;
	}
	/**
	*<b>Summary: 设置刻录人name</b>
	*/
	public void setF_burn_user_name(String f_burn_user_name) {
		this.f_burn_user_name = f_burn_user_name;
	}
	/**
	*<b>Summary: 获取归档数量</b>
	*/
	public String getF_file_num() {
		return f_file_num;
	}
	/**
	*<b>Summary: 设置归档数量</b>
	*/
	public void setF_file_num(String f_file_num) {
		this.f_file_num = f_file_num;
	}
	/**
	*<b>Summary: 获取保管期限</b>
	*/
	public String getF_doc_deadline() {
		return f_doc_deadline;
	}
	/**
	*<b>Summary: 设置保管期限</b>
	*/
	public void setF_doc_deadline(String f_doc_deadline) {
		this.f_doc_deadline = f_doc_deadline;
	}
	/**
	*<b>Summary: 获取归档人ID</b>
	*/
	public String getF_file_userid() {
		return f_file_userid;
	}
	/**
	*<b>Summary: 设置归档人ID</b>
	*/
	public void setF_file_userid(String f_file_userid) {
		this.f_file_userid = f_file_userid;
	}
	/**
	*<b>Summary: 获取归档人姓名</b>
	*/
	public String getF_file_username() {
		return f_file_username;
	}
	/**
	*<b>Summary: 设置归档人姓名</b>
	*/
	public void setF_file_username(String f_file_username) {
		this.f_file_username = f_file_username;
	}
	/**
	*<b>Summary: 获取归档日期</b>
	*/
	public Object getF_file_time() {
		return f_file_time;
	}
	/**
	*<b>Summary: 设置归档日期</b>
	*/
	public void setF_file_time(Object f_file_time) {
		this.f_file_time = f_file_time;
	}
	
	/**
	*<b>Summary: 获取字号类型</b>
	*/
	public String getF_zihao_type_name() {
		return f_zihao_type_name;
	}
	/**
	*<b>Summary: 设置字号类型</b>
	*/
	public void setF_zihao_type_name(String f_zihao_type_name) {
		this.f_zihao_type_name = f_zihao_type_name;
	}
	/**
	*<b>Summary: 获取文号(文件字号的后面部分)</b>
	*/
	public String getF_wenhao() {
		return f_wenhao;
	}
	/**
	*<b>Summary: 设置文号(文件字号的后面部分)</b>
	*/
	public void setF_wenhao(String f_wenhao) {
		this.f_wenhao = f_wenhao;
	}
	
	public String getF_destroy_state() {
		return f_destroy_state;
	}
	public void setF_destroy_state(String f_destroy_state) {
		this.f_destroy_state = f_destroy_state;
	}
	public String getF_file_num_unit_name() {
		return f_file_num_unit_name;
	}
	public void setF_file_num_unit_name(String fFileNumUnitName) {
		f_file_num_unit_name = fFileNumUnitName;
	}
	public String getF_file_num_unit() {
		return f_file_num_unit;
	}
	public void setF_file_num_unit(String fFileNumUnit) {
		f_file_num_unit = fFileNumUnit;
	}
	public String getF_doc_deadline_name() {
		return f_doc_deadline_name;
	}
	public void setF_doc_deadline_name(String fDocDeadlineName) {
		f_doc_deadline_name = fDocDeadlineName;
	}
	public String getF_attach_id_min() {
		return f_attach_id_min;
	}
	public void setF_attach_id_min(String f_attach_id_min) {
		this.f_attach_id_min = f_attach_id_min;
	}
	public String getF_attach_id_max() {
		return f_attach_id_max;
	}
	public void setF_attach_id_max(String f_attach_id_max) {
		this.f_attach_id_max = f_attach_id_max;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	
	
}
