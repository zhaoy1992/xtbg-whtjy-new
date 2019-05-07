package com.chinacreator.xtbg.pub.oagwcs.entity;

public class SendArchiveRequestBean {
	/**
	 * 公文正文名称，包括后缀名（只支持.doc或者.ceb）
	 *	请使用英文命名。非空
	 */
	private String fileName;
	
	/**
	 * 要素xml文件的名称请使用英文命名。非空
	 */
	private String xmlName;
	
	/**
	 * 附件的名称数组,包括后缀名。注意不支持.jsp,音频视频.htm,.html,等非法格式文件。请使用英文命名
	 */
	private String[] affixName;
	
	/**
	 * 客户端的标示字段。为客户端的某些特殊处理操作预留
	 */
	private String type;
	
	/**
	 * 公文正文(ceb或者doc)+要素xml文件(查看格式)+附件 打包为zip文件后 生成的byte[]或者DataHandler数据。
		采用了mtom机制。
		.net客户端，请使用byte[]。注意控制大小在5M以下。
		Java客户端，请使用DataHandler。大小请控制在20M以下。
	 */
	private byte[] db;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getXmlName() {
		return xmlName;
	}

	public void setXmlName(String xmlName) {
		this.xmlName = xmlName;
	}

	public String[] getAffixName() {
		return affixName;
	}

	public void setAffixName(String[] affixName) {
		this.affixName = affixName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public byte[] getDb() {
		return db;
	}

	public void setDb(byte[] db) {
		this.db = db;
	}
	
	
}
