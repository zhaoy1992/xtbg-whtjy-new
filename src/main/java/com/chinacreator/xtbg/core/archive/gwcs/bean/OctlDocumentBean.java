package com.chinacreator.xtbg.core.archive.gwcs.bean;

/**
 *<p>Title:保存WORD实体Bean</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-7-4
 */
public class OctlDocumentBean {
	
	private String documentid;//自动编号
	
	private String recordid;//文档编号
	
	private String template;//模板编号
	
	private String subject;//主题
	
	private String author;//作者
	
	private String filedate;//日期
	
	private String filetype;//文档类型
	
	private String htmlpath;//HTML路径
	
	private String status;//状态

	public String getDocumentid() {
		return documentid;
	}

	public void setDocumentid(String documentid) {
		this.documentid = documentid;
	}

	public String getRecordid() {
		return recordid;
	}

	public void setRecordid(String recordid) {
		this.recordid = recordid;
	}

	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getFiledate() {
		return filedate;
	}

	public void setFiledate(String filedate) {
		this.filedate = filedate;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String getHtmlpath() {
		return htmlpath;
	}

	public void setHtmlpath(String htmlpath) {
		this.htmlpath = htmlpath;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
