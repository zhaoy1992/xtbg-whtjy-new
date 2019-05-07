package com.chinacreator.xtbg.core.common.fancyuoload.entity;

import java.io.InputStream;
/**
 *<p>Title:FileInfoBean.java</p>
 *<p>Description:上传组件文件信息实体</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-10
 */
public class FileInfoBean {
	private String extend; // 后缀名字
	private String djbh; // 可能是业务编号 ？
	private String dj_sn; // 不清楚，没存数据库
	private String filename; // 原始文件名字
	private String attachid; // 存 uu id
	private String bz; // 不清楚不存
	private String djsn; // 不清楚，存改变好的文件名字
	private byte[] attachcontent; // 存文件内容
	private String filepos; // 上传后的文件路径和名字
	private String upload_mode; // 文件存储模式 1
	private String cc_form_instanceid; // 不清楚
	private String creator; // 存储人
	private String create_date; // 文件存储日期
	private String newName; // 新的名字
	private InputStream fileInput;
	private String filesize; // 文件大小

	public InputStream getFileInput() {
		return fileInput;
	}

	public void setFileInput(InputStream fileInput) {
		this.fileInput = fileInput;
	}

	public String getNewName() {
		return newName;
	}

	public void setNewName(String newName) {
		this.newName = newName;
	}

	public String getCreate_date() {
		return create_date;
	}

	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	public String getExtend() {
		return extend;
	}

	public void setExtend(String extend) {
		this.extend = extend;
	}

	public String getDjbh() {
		return djbh;
	}

	public void setDjbh(String djbh) {
		this.djbh = djbh;
	}

	public String getDj_sn() {
		return dj_sn;
	}

	public void setDj_sn(String dj_sn) {
		this.dj_sn = dj_sn;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getAttachid() {
		return attachid;
	}

	public void setAttachid(String attachid) {
		this.attachid = attachid;
	}

	public String getBz() {
		return bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	public String getDjsn() {
		return djsn;
	}

	public void setDjsn(String djsn) {
		this.djsn = djsn;
	}

	public byte[] getAttachcontent() {
		return attachcontent;
	}

	public void setAttachcontent(byte[] attachcontent) {
		this.attachcontent = attachcontent;
	}

	public String getFilepos() {
		return filepos;
	}

	public void setFilepos(String filepos) {
		this.filepos = filepos;
	}

	public String getUpload_mode() {
		return upload_mode;
	}

	public void setUpload_mode(String upload_mode) {
		this.upload_mode = upload_mode;
	}

	public String getCc_form_instanceid() {
		return cc_form_instanceid;
	}

	public void setCc_form_instanceid(String cc_form_instanceid) {
		this.cc_form_instanceid = cc_form_instanceid;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getFilesize() {
		return filesize;
	}

	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
}
