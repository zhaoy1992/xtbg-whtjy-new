package com.chinacreator.xtbg.core.file.entity;


/**
 * 
 *<p>Title:FileFilesQueryBean.java</p>
 *<p>Description:档案管理-档案查询(涉及文件bean,档案bean)</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 23, 2013
 */
public class FileFilesQueryBean extends FileDocPhotoBean{
	private String f_filesno;
	
	private String attach_num;
	
	private String f_creator_time_str;
	//支持filefilesquerylist.jsp
	private String query_page;//OA_FILE_PROGRAM_PAGE.F_FILE_DETAIL
	//支持filefilescollectindex.jsp
	private String f_favorites_id;//OA_FILE_FAVORITES.F_FAVORITES_ID
	//支持filefilesqueryjyllist.jsp
	private String f_detail_id;//OA_FILE_LENDING_DETAIL.F_DETAIL_ID

	private String f_files_id;
	private String out_side_detail_ids;
	//vo
	private String dagly_id;//档案管理员
	public String getF_favorites_id() {
		return f_favorites_id;
	}

	public void setF_favorites_id(String f_favorites_id) {
		this.f_favorites_id = f_favorites_id;
	}

	public String getF_creator_time_str() {
		return f_creator_time_str;
	}

	public void setF_creator_time_str(String f_creator_time_str) {
		this.f_creator_time_str = f_creator_time_str;
	}

	public String getAttach_num() {
		return attach_num;
	}

	public void setAttach_num(String attach_num) {
		this.attach_num = attach_num;
	}

	public String getF_filesno() {
		return f_filesno;
	}

	public void setF_filesno(String f_filesno) {
		this.f_filesno = f_filesno;
	}

	public String getQuery_page() {
		return query_page;
	}

	public void setQuery_page(String query_page) {
		this.query_page = query_page;
	}

	public String getF_detail_id() {
		return f_detail_id;
	}

	public void setF_detail_id(String f_detail_id) {
		this.f_detail_id = f_detail_id;
	}

	public String getDagly_id() {
		return dagly_id;
	}

	public void setDagly_id(String dagly_id) {
		this.dagly_id = dagly_id;
	}

	public String getOut_side_detail_ids() {
		return out_side_detail_ids;
	}

	public void setOut_side_detail_ids(String out_side_detail_ids) {
		this.out_side_detail_ids = out_side_detail_ids;
	}

	public String getF_files_id() {
		return f_files_id;
	}

	public void setF_files_id(String f_files_id) {
		this.f_files_id = f_files_id;
	}

	
	
}
