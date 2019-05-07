package com.chinacreator.xtbg.core.common.mail.entity;

import java.util.List;

/**
 *<p>Title:MailBean.java</p>
 *<p>Description:邮件</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-7
 */
public class MailBean {
	
	private String mailType;//邮箱类型，站内邮箱或者外部邮箱
	
	/**
	 * 邮件主题信息，不能为空
	 */
	private MailTopicBean mailTopicBean;
	
	/**
	 * 邮件接收人信息，不能为空
	 */
	private List<MailRecvBean> recvList;
	
	/**
	 * 邮件附件信息，可以为空
	 */
	private List<MailAffixBean> affixList;
	
	public String getMailType() {
		return mailType;
	}

	public void setMailType(String mailType) {
		this.mailType = mailType;
	}

	public MailTopicBean getMailTopicBean() {
		return mailTopicBean;
	}

	public void setMailTopicBean(MailTopicBean mailTopicBean) {
		this.mailTopicBean = mailTopicBean;
	}

	public List<MailRecvBean> getRecvList() {
		return recvList;
	}

	public void setRecvList(List<MailRecvBean> recvList) {
		this.recvList = recvList;
	}

	public List<MailAffixBean> getAffixList() {
		return affixList;
	}

	public void setAffixList(List<MailAffixBean> affixList) {
		this.affixList = affixList;
	}
}
