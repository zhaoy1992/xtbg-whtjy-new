package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:FileTypeBean.java</p>
 *<p>Description:档案分类bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 15, 2013
 */
public class FileTypeBean extends XtDbBaseBean {
	private String f_type_id;		//档案分类ID
	private String f_parent_type_id;		//所属上级分类
	private String f_type_name;		//档案分类名称
	private String f_type_level;		//分类层次
	private String f_org_id;		//所属的单位ID
	private String f_org_name;		//所属的单位名称
	private String f_dept_id;		//所属的部门ID
	private String f_dept_name;		//所属的部门名称
	private String f_typeno;		//分类号
	private String f_type_order;		//排序号
	private String f_program_id;		//程序界面ID
	private String f_program_page;		//程序界面
	private String f_isrecursion_page;		//程序界面 是否递归(1递归0不递归)
	private String f_page_by_isre;		//程序界面是否来自递归
	private String f_type_admin;		//档案管理员ID
	private String f_type_adminname;		//档案管理员名称
	private String f_isrecursion_admin;		//档案管理员是否递归(1递归0不递归)
	private String f_admin_by_isre;		//档案管理员是否来自递归
	private String f_template_content;		//案卷内容模板
	private String f_isrecursion_content;		//案卷内容模板 是否递归(1递归0不递归)
	private String f_content_by_isre;		//案卷内容是否来自递归
	private String f_template_file;		//文件内容模板
	private String f_isrecursion_file;		//文件内容模板 是否递归(1递归0不递归)
	private String f_file_by_isre;		//文件内容是否来自递归
	private String f_template_record_table;		//备考表模板
	private String f_isrecursion_record_table;		//备考表是否递归(1递归0不递归)
	private String f_record_table_by_isre;		//备考表是否来自递归
	private String f_type_remark;		//备注
	private String f_user_id;		//登记人ID
	private String f_user_name;		//登记姓名
	private Object f_creator_time;		//登记时间
	private String f_type_parentname;		//从上到下所有类型名称连接
	private String f_type_parentid;		//从上到下所有类型ID用逗号分开
	private String f_type_table;		//类型对应的表
	private String f_fileno_template;		//档案档号模板
	private String f_fileno_template_isrecursion;		//档号是否递归（1递归，0不递归）
	public FileTypeBean() {
		super("oa_file_type", "f_type_id");
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
	*<b>Summary: 获取所属上级分类</b>
	*/
	public String getF_parent_type_id() {
		return f_parent_type_id;
	}
	/**
	*<b>Summary: 设置所属上级分类</b>
	*/
	public void setF_parent_type_id(String f_parent_type_id) {
		this.f_parent_type_id = f_parent_type_id;
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
	*<b>Summary: 获取分类层次</b>
	*/
	public String getF_type_level() {
		return f_type_level;
	}
	/**
	*<b>Summary: 设置分类层次</b>
	*/
	public void setF_type_level(String f_type_level) {
		this.f_type_level = f_type_level;
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
	*<b>Summary: 获取所属的单位名称</b>
	*/
	public String getF_org_name() {
		return f_org_name;
	}
	/**
	*<b>Summary: 设置所属的单位名称</b>
	*/
	public void setF_org_name(String f_org_name) {
		this.f_org_name = f_org_name;
	}
	/**
	*<b>Summary: 获取所属的部门ID</b>
	*/
	public String getF_dept_id() {
		return f_dept_id;
	}
	/**
	*<b>Summary: 设置所属的部门ID</b>
	*/
	public void setF_dept_id(String f_dept_id) {
		this.f_dept_id = f_dept_id;
	}
	/**
	*<b>Summary: 获取所属的部门名称</b>
	*/
	public String getF_dept_name() {
		return f_dept_name;
	}
	/**
	*<b>Summary: 设置所属的部门名称</b>
	*/
	public void setF_dept_name(String f_dept_name) {
		this.f_dept_name = f_dept_name;
	}
	/**
	*<b>Summary: 获取分类号</b>
	*/
	public String getF_typeno() {
		return f_typeno;
	}
	/**
	*<b>Summary: 设置分类号</b>
	*/
	public void setF_typeno(String f_typeno) {
		this.f_typeno = f_typeno;
	}
	/**
	*<b>Summary: 获取排序号</b>
	*/
	public String getF_type_order() {
		return f_type_order;
	}
	/**
	*<b>Summary: 设置排序号</b>
	*/
	public void setF_type_order(String f_type_order) {
		this.f_type_order = f_type_order;
	}
	/**
	*<b>Summary: 获取程序界面ID</b>
	*/
	public String getF_program_id() {
		return f_program_id;
	}
	/**
	*<b>Summary: 设置程序界面ID</b>
	*/
	public void setF_program_id(String f_program_id) {
		this.f_program_id = f_program_id;
	}
	/**
	*<b>Summary: 获取程序界面</b>
	*/
	public String getF_program_page() {
		return f_program_page;
	}
	/**
	*<b>Summary: 设置程序界面</b>
	*/
	public void setF_program_page(String f_program_page) {
		this.f_program_page = f_program_page;
	}
	/**
	*<b>Summary: 获取程序界面 是否递归(1递归0不递归)</b>
	*/
	public String getF_isrecursion_page() {
		return f_isrecursion_page;
	}
	/**
	*<b>Summary: 设置程序界面 是否递归(1递归0不递归)</b>
	*/
	public void setF_isrecursion_page(String f_isrecursion_page) {
		this.f_isrecursion_page = f_isrecursion_page;
	}
	/**
	*<b>Summary: 获取程序界面是否来自递归</b>
	*/
	public String getF_page_by_isre() {
		return f_page_by_isre;
	}
	/**
	*<b>Summary: 设置程序界面是否来自递归</b>
	*/
	public void setF_page_by_isre(String f_page_by_isre) {
		this.f_page_by_isre = f_page_by_isre;
	}
	/**
	*<b>Summary: 获取档案管理员ID</b>
	*/
	public String getF_type_admin() {
		return f_type_admin;
	}
	/**
	*<b>Summary: 设置档案管理员ID</b>
	*/
	public void setF_type_admin(String f_type_admin) {
		this.f_type_admin = f_type_admin;
	}
	/**
	*<b>Summary: 获取档案管理员名称</b>
	*/
	public String getF_type_adminname() {
		return f_type_adminname;
	}
	/**
	*<b>Summary: 设置档案管理员名称</b>
	*/
	public void setF_type_adminname(String f_type_adminname) {
		this.f_type_adminname = f_type_adminname;
	}
	/**
	*<b>Summary: 获取档案管理员是否递归(1递归0不递归)</b>
	*/
	public String getF_isrecursion_admin() {
		return f_isrecursion_admin;
	}
	/**
	*<b>Summary: 设置档案管理员是否递归(1递归0不递归)</b>
	*/
	public void setF_isrecursion_admin(String f_isrecursion_admin) {
		this.f_isrecursion_admin = f_isrecursion_admin;
	}
	/**
	*<b>Summary: 获取档案管理员是否来自递归</b>
	*/
	public String getF_admin_by_isre() {
		return f_admin_by_isre;
	}
	/**
	*<b>Summary: 设置档案管理员是否来自递归</b>
	*/
	public void setF_admin_by_isre(String f_admin_by_isre) {
		this.f_admin_by_isre = f_admin_by_isre;
	}
	/**
	*<b>Summary: 获取案卷内容模板</b>
	*/
	public String getF_template_content() {
		return f_template_content;
	}
	/**
	*<b>Summary: 设置案卷内容模板</b>
	*/
	public void setF_template_content(String f_template_content) {
		this.f_template_content = f_template_content;
	}
	/**
	*<b>Summary: 获取案卷内容模板 是否递归(1递归0不递归)</b>
	*/
	public String getF_isrecursion_content() {
		return f_isrecursion_content;
	}
	/**
	*<b>Summary: 设置案卷内容模板 是否递归(1递归0不递归)</b>
	*/
	public void setF_isrecursion_content(String f_isrecursion_content) {
		this.f_isrecursion_content = f_isrecursion_content;
	}
	/**
	*<b>Summary: 获取案卷内容是否来自递归</b>
	*/
	public String getF_content_by_isre() {
		return f_content_by_isre;
	}
	/**
	*<b>Summary: 设置案卷内容是否来自递归</b>
	*/
	public void setF_content_by_isre(String f_content_by_isre) {
		this.f_content_by_isre = f_content_by_isre;
	}
	/**
	*<b>Summary: 获取文件内容模板</b>
	*/
	public String getF_template_file() {
		return f_template_file;
	}
	/**
	*<b>Summary: 设置文件内容模板</b>
	*/
	public void setF_template_file(String f_template_file) {
		this.f_template_file = f_template_file;
	}
	/**
	*<b>Summary: 获取文件内容模板 是否递归(1递归0不递归)</b>
	*/
	public String getF_isrecursion_file() {
		return f_isrecursion_file;
	}
	/**
	*<b>Summary: 设置文件内容模板 是否递归(1递归0不递归)</b>
	*/
	public void setF_isrecursion_file(String f_isrecursion_file) {
		this.f_isrecursion_file = f_isrecursion_file;
	}
	/**
	*<b>Summary: 获取文件内容是否来自递归</b>
	*/
	public String getF_file_by_isre() {
		return f_file_by_isre;
	}
	/**
	*<b>Summary: 设置文件内容是否来自递归</b>
	*/
	public void setF_file_by_isre(String f_file_by_isre) {
		this.f_file_by_isre = f_file_by_isre;
	}
	/**
	*<b>Summary: 获取备考表模板</b>
	*/
	public String getF_template_record_table() {
		return f_template_record_table;
	}
	/**
	*<b>Summary: 设置备考表模板</b>
	*/
	public void setF_template_record_table(String f_template_record_table) {
		this.f_template_record_table = f_template_record_table;
	}
	/**
	*<b>Summary: 获取备考表是否递归(1递归0不递归)</b>
	*/
	public String getF_isrecursion_record_table() {
		return f_isrecursion_record_table;
	}
	/**
	*<b>Summary: 设置备考表是否递归(1递归0不递归)</b>
	*/
	public void setF_isrecursion_record_table(String f_isrecursion_record_table) {
		this.f_isrecursion_record_table = f_isrecursion_record_table;
	}
	/**
	*<b>Summary: 获取备考表是否来自递归</b>
	*/
	public String getF_record_table_by_isre() {
		return f_record_table_by_isre;
	}
	/**
	*<b>Summary: 设置备考表是否来自递归</b>
	*/
	public void setF_record_table_by_isre(String f_record_table_by_isre) {
		this.f_record_table_by_isre = f_record_table_by_isre;
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
	*<b>Summary: 获取从上到下所有类型名称连接</b>
	*/
	public String getF_type_parentname() {
		return f_type_parentname;
	}
	/**
	*<b>Summary: 设置从上到下所有类型名称连接</b>
	*/
	public void setF_type_parentname(String f_type_parentname) {
		this.f_type_parentname = f_type_parentname;
	}
	/**
	*<b>Summary: 获取从上到下所有类型ID用逗号分开</b>
	*/
	public String getF_type_parentid() {
		return f_type_parentid;
	}
	/**
	*<b>Summary: 设置从上到下所有类型ID用逗号分开</b>
	*/
	public void setF_type_parentid(String f_type_parentid) {
		this.f_type_parentid = f_type_parentid;
	}
	/**
	*<b>Summary: 获取类型对应的表</b>
	*/
	public String getF_type_table() {
		return f_type_table;
	}
	/**
	*<b>Summary: 设置类型对应的表</b>
	*/
	public void setF_type_table(String f_type_table) {
		this.f_type_table = f_type_table;
	}
	/**
	 * 第一层档案分类
	 */
	public static final String F_TYPE_LEVEL_ONE = "1";
	/**
	 * 中间层档案分类
	 */
	public static final String F_TYPE_LEVEL_TWO = "2";
	/**
	 * 最底层档案分类
	 */
	public static final String F_TYPE_LEVEL_THREE = "3";
	/**
	 * 递归
	 */
	public static final String IS_RECURSION_YES = "1";
	/**
	 * 不递归
	 */
	public static final String IS_RECURSION_NO = "0";
	/**
	 * 备考表模板参数存在 OA_DICT_DATA 和 OA_DICT_TYPE 中的 DICT_ID
	 */
	public static final String BKB_DICT_ID = "10";
	/**
	 * 档号模板参数存在 OA_DICT_DATA 和 OA_DICT_TYPE 中的 DICT_ID
	 */
	public static final String DH_DICT_ID = "10";
	
	private String f_type_level_name;
	private String f_parent_name;
	public String getF_type_level_name() {
		return f_type_level_name;
	}

	public void setF_type_level_name(String f_type_level_name) {
		this.f_type_level_name = f_type_level_name;
	}
	public String getF_parent_name() {
		return f_parent_name;
	}

	public void setF_parent_name(String f_parent_name) {
		this.f_parent_name = f_parent_name;
	}
	public String getF_fileno_template() {
		return f_fileno_template;
	}
	public void setF_fileno_template(String fFilenoTemplate) {
		f_fileno_template = fFilenoTemplate;
	}
	public String getF_fileno_template_isrecursion() {
		return f_fileno_template_isrecursion;
	}
	public void setF_fileno_template_isrecursion(String fFilenoTemplateIsrecursion) {
		f_fileno_template_isrecursion = fFilenoTemplateIsrecursion;
	}
	
}
