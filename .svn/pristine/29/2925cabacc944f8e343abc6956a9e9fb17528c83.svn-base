package com.chinacreator.xtbg.core.kbm.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

public class KbmDocBean extends XtDbBaseBean {
	public KbmDocBean(){
		//在构造器里面设置好表名和主键，具体进行更新，删除等操作时可以重新设置updateKey，deleteKey，及主键
		super("OA_KBM_DOC", "k_doc_id");
	}
	private String k_doc_id;          //知识库id
	private String k_title;      //标题
	private String k_code;       //编号
	private String k_type_id;         //分类
	private String k_type_name;       //分类name
	private String k_key;        //关键字
	private String k_secrecy_id;      //密级
	private String k_secrecy_name;        //密级name
	private String k_unit;       //单位
	private String k_unit_name;       //单位name
	private String k_dept;       //部门
	private String k_dept_name;       //部门name
	private Object k_first_time;      //文件形成时间
	private Object k_create_time;         //文件登记时间
	private String k_create_user;         //文件登记人
	private String k_create_user_name;         //文件登记人name
	private String k_contents;        //内容
	private String k_attach_id;       //附件id
	private String k_flag;       //文档状态(0草稿、1通过、2不通过)
	private String k_flag_name;       //文档状态name
	private String k_remark;          //修改备注
	private Object k_check_time;      //审核时间
	private String k_check_user;      //审核人
	private String k_check_user_name;     //审核人name
	private String k_dcount;          //下载次数
	private String k_check_info;      //审核意见
	private Object k_update_time;      //更新时间
	//特检院OA 追加 批准人 批准意见字段   2014-03-27 start
	private Object k_approval_time;      //批准时间
	private String k_approval_user;      //批准人
	private String k_approval_user_name; //批准人name
	private String k_approval_info;      //批准意见
	//特检院OA 追加 批准人 批准意见 字段  2014-03-27 end
	
	//特检院OA 追加 适用部门Id,适用部门名称字段   2014-03-31 start
	private String k_receive_deptid;     	 //适应部门ID
	private String k_receive_deptname;      //适用部门名称
	//特检院OA 追加 适用部门Id,适用部门名称字段   2014-03-31 end

	//特检院OA 追加 上传类型 字段   2014-04-03 start
	private String k_upload_type;
	//特检院OA 追加 上传类型字段   2014-04-03 end
	
	private String v_number; //阅读率
	
	private String k_user;
	private String opentype;
	private String m_msg_contents;
	private String m_msg_type;
	
	private String djsn;//附件id
	private String file_type;//附件类型
	private String filename;//附件名
	
	private String k_luojishanchu;//逻辑删除 更新记录用
	
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getDjsn() {
		return djsn;
	}
	public void setDjsn(String djsn) {
		this.djsn = djsn;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String fileType) {
		file_type = fileType;
	}
	/**
	*<b>Summary: 获取知识库id</b>
	*/
	public String getK_doc_id() {
	     return k_doc_id;
	}
	/**
	*<b>Summary: 设置知识库id</b>
	*/
	public void setK_doc_id(String k_doc_id) {
	     this.k_doc_id = k_doc_id;
	}
	/**
	*<b>Summary: 获取标题</b>
	*/
	public String getK_title() {
	     return k_title;
	}
	/**
	*<b>Summary: 设置标题</b>
	*/
	public void setK_title(String k_title) {
	     this.k_title = k_title;
	}
	/**
	*<b>Summary: 获取编号</b>
	*/
	public String getK_code() {
	     return k_code;
	}
	/**
	*<b>Summary: 设置编号</b>
	*/
	public void setK_code(String k_code) {
	     this.k_code = k_code;
	}
	/**
	*<b>Summary: 获取分类</b>
	*/
	public String getK_type_id() {
	     return k_type_id;
	}
	/**
	*<b>Summary: 设置分类</b>
	*/
	public void setK_type_id(String k_type_id) {
	     this.k_type_id = k_type_id;
	}
	/**
	*<b>Summary: 获取分类name</b>
	*/
	public String getK_type_name() {
	     return k_type_name;
	}
	/**
	*<b>Summary: 设置分类name</b>
	*/
	public void setK_type_name(String k_type_name) {
	     this.k_type_name = k_type_name;
	}
	/**
	*<b>Summary: 获取关键字</b>
	*/
	public String getK_key() {
	     return k_key;
	}
	/**
	*<b>Summary: 设置关键字</b>
	*/
	public void setK_key(String k_key) {
	     this.k_key = k_key;
	}
	/**
	*<b>Summary: 获取密级</b>
	*/
	public String getK_secrecy_id() {
	     return k_secrecy_id;
	}
	/**
	*<b>Summary: 设置密级</b>
	*/
	public void setK_secrecy_id(String k_secrecy_id) {
	     this.k_secrecy_id = k_secrecy_id;
	}
	/**
	*<b>Summary: 获取密级name</b>
	*/
	public String getK_secrecy_name() {
	     return k_secrecy_name;
	}
	/**
	*<b>Summary: 设置密级name</b>
	*/
	public void setK_secrecy_name(String k_secrecy_name) {
	     this.k_secrecy_name = k_secrecy_name;
	}
	/**
	*<b>Summary: 获取单位</b>
	*/
	public String getK_unit() {
	     return k_unit;
	}
	/**
	*<b>Summary: 设置单位</b>
	*/
	public void setK_unit(String k_unit) {
	     this.k_unit = k_unit;
	}
	/**
	*<b>Summary: 获取单位name</b>
	*/
	public String getK_unit_name() {
	     return k_unit_name;
	}
	/**
	*<b>Summary: 设置单位name</b>
	*/
	public void setK_unit_name(String k_unit_name) {
	     this.k_unit_name = k_unit_name;
	}
	/**
	*<b>Summary: 获取部门</b>
	*/
	public String getK_dept() {
	     return k_dept;
	}
	/**
	*<b>Summary: 设置部门</b>
	*/
	public void setK_dept(String k_dept) {
	     this.k_dept = k_dept;
	}
	/**
	*<b>Summary: 获取部门name</b>
	*/
	public String getK_dept_name() {
	     return k_dept_name;
	}
	/**
	*<b>Summary: 设置部门name</b>
	*/
	public void setK_dept_name(String k_dept_name) {
	     this.k_dept_name = k_dept_name;
	}
	/**
	*<b>Summary: 获取文件形成时间</b>
	*/
	public Object getK_first_time() {
	     return k_first_time;
	}
	/**
	*<b>Summary: 设置文件形成时间</b>
	*/
	public void setK_first_time(Object k_first_time) {
	     this.k_first_time = k_first_time;
	}
	/**
	*<b>Summary: 获取文件登记时间</b>
	*/
	public Object getK_create_time() {
	     return k_create_time;
	}
	/**
	*<b>Summary: 设置文件登记时间</b>
	*/
	public void setK_create_time(Object k_create_time) {
	     this.k_create_time = k_create_time;
	}
	/**
	*<b>Summary: 获取文件登记人</b>
	*/
	public String getK_create_user() {
	     return k_create_user;
	}
	/**
	*<b>Summary: 设置文件登记人</b>
	*/
	public void setK_create_user(String k_create_user) {
	     this.k_create_user = k_create_user;
	}
	/**
	*<b>Summary: 获取文件登记人name</b>
	*/
	public String getK_create_user_name() {
	     return k_create_user_name;
	}
	/**
	*<b>Summary: 设置文件登记人name</b>
	*/
	public void setK_create_user_name(String k_create_user_name) {
	     this.k_create_user_name = k_create_user_name;
	}
	/**
	*<b>Summary: 获取内容</b>
	*/
	public String getK_contents() {
	     return k_contents;
	}
	/**
	*<b>Summary: 设置内容</b>
	*/
	public void setK_contents(String k_contents) {
	     this.k_contents = k_contents;
	}
	/**
	*<b>Summary: 获取附件id</b>
	*/
	public String getK_attach_id() {
	     return k_attach_id;
	}
	/**
	*<b>Summary: 设置附件id</b>
	*/
	public void setK_attach_id(String k_attach_id) {
	     this.k_attach_id = k_attach_id;
	}
	/**
	*<b>Summary: 获取文档状态(0草稿、1通过、2不通过)</b>
	*/
	public String getK_flag() {
	     return k_flag;
	}
	/**
	*<b>Summary: 设置文档状态(0草稿、1通过、2不通过)</b> 
	*/
	public void setK_flag(String k_flag) {
	     this.k_flag = k_flag;
	}
	/**
	*<b>Summary: 获取文档状态name</b>
	*/
	public String getK_flag_name() {
	     return k_flag_name;
	}
	/**
	*<b>Summary: 设置文档状态name</b>
	*/
	public void setK_flag_name(String k_flag_name) {
	     this.k_flag_name = k_flag_name;
	}
	/**
	*<b>Summary: 获取修改备注</b>
	*/
	public String getK_remark() {
	     return k_remark;
	}
	/**
	*<b>Summary: 设置修改备注</b>
	*/
	public void setK_remark(String k_remark) {
	     this.k_remark = k_remark;
	}
	/**
	*<b>Summary: 获取审核时间</b>
	*/
	public Object getK_check_time() {
	     return k_check_time;
	}
	/**
	*<b>Summary: 设置审核时间</b>
	*/
	public void setK_check_time(Object k_check_time) {
	     this.k_check_time = k_check_time;
	}
	/**
	*<b>Summary: 获取审核人</b>
	*/
	public String getK_check_user() {
	     return k_check_user;
	}
	/**
	*<b>Summary: 设置审核人</b>
	*/
	public void setK_check_user(String k_check_user) {
	     this.k_check_user = k_check_user;
	}
	/**
	*<b>Summary: 获取审核人name</b>
	*/
	public String getK_check_user_name() {
	     return k_check_user_name;
	}
	/**
	*<b>Summary: 设置审核人name</b>
	*/
	public void setK_check_user_name(String k_check_user_name) {
	     this.k_check_user_name = k_check_user_name;
	}
	/**
	*<b>Summary: 获取下载次数</b>
	*/
	public String getK_dcount() {
	     return k_dcount;
	}
	/**
	*<b>Summary: 设置下载次数</b>
	*/
	public void setK_dcount(String k_dcount) {
	     this.k_dcount = k_dcount;
	}
	/**
	*<b>Summary: 获取审核意见</b>
	*/
	public String getK_check_info() {
		return k_check_info;
	}
	/**
	*<b>Summary: 设置审核时间</b>
	*/
	public void setK_check_info(String k_check_info) {
		this.k_check_info = k_check_info;
	}
	/**
	*<b>Summary: 获取更新时间</b>
	*/
	public Object getK_update_time() {
		return k_update_time;
	}
	/**
	*<b>Summary: 设置更新时间</b>
	*/
	public void setK_update_time(Object k_update_time) {
		this.k_update_time = k_update_time;
	}
	public String getOpentype() {
		return opentype;
	}
	public void setOpentype(String opentype) {
		this.opentype = opentype;
	}
	public String getK_user() {
		return k_user;
	}
	public void setK_user(String k_user) {
		this.k_user = k_user;
	}
	public String getM_msg_contents() {
		return m_msg_contents;
	}
	public void setM_msg_contents(String m_msg_contents) {
		this.m_msg_contents = m_msg_contents;
	}
	public String getM_msg_type() {
		return m_msg_type;
	}
	public void setM_msg_type(String m_msg_type) {
		this.m_msg_type = m_msg_type;
	}
	public Object getK_approval_time() {
		return k_approval_time;
	}
	public void setK_approval_time(Object k_approval_time) {
		this.k_approval_time = k_approval_time;
	}
	public String getK_approval_user() {
		return k_approval_user;
	}
	public void setK_approval_user(String k_approval_user) {
		this.k_approval_user = k_approval_user;
	}
	public String getK_approval_user_name() {
		return k_approval_user_name;
	}
	public void setK_approval_user_name(String k_approval_user_name) {
		this.k_approval_user_name = k_approval_user_name;
	}
	public String getK_approval_info() {
		return k_approval_info;
	}
	public void setK_approval_info(String k_approval_info) {
		this.k_approval_info = k_approval_info;
	}
	public String getK_receive_deptid() {
		return k_receive_deptid;
	}
	public void setK_receive_deptid(String k_receive_deptid) {
		this.k_receive_deptid = k_receive_deptid;
	}
	public String getK_receive_deptname() {
		return k_receive_deptname;
	}
	public void setK_receive_deptname(String k_receive_deptname) {
		this.k_receive_deptname = k_receive_deptname;
	}
	public String getK_upload_type() {
		return k_upload_type;
	}
	public void setK_upload_type(String k_upload_type) {
		this.k_upload_type = k_upload_type;
	}
	public String getV_number() {
		return v_number;
	}
	public void setV_number(String v_number) {
		this.v_number = v_number;
	}
	public String getK_luojishanchu() {
		return k_luojishanchu;
	}
	public void setK_luojishanchu(String kLuojishanchu) {
		k_luojishanchu = kLuojishanchu;
	}
	
	
	
	
}
