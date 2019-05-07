package com.chinacreator.xtbg.core.common.mail.cache;

import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;


/**
 *<p>Title:MailCacheBean.java</p>
 *<p>Description:邮件相关配置信息</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-7
 */
public class MailCacheBean {
	
	private static MailCacheBean mailCacheBean = null;
	
	private MailCacheBean() {
		
	}
	
	/**
	*<b>Summary: </b>
	* getInstance(单例模式从spring容器中获取实例)
	* @return
	*/
	public static MailCacheBean getInstance() {
		synchronized (MailCacheBean.class) {
			if (mailCacheBean == null) {
				mailCacheBean = (MailCacheBean) LoadSpringContext.getApplicationContext().getBean("mailCacheBean");
			}
		}
		return mailCacheBean;
	}
	
	private boolean innerMail;//是否内部邮件，没有邮件服务器
	
	private String mailAddr;//内部邮件地址后缀

	public boolean isInnerMail() {
		return innerMail;
	}

	public void setInnerMail(boolean innerMail) {
		this.innerMail = innerMail;
	}

	public String getMailAddr() {
		return mailAddr;
	}

	public void setMailAddr(String mailAddr) {
		this.mailAddr = mailAddr;
	}

}
