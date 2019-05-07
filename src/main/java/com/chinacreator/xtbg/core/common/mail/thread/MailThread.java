package com.chinacreator.xtbg.core.common.mail.thread;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.mail.services.AbstractMailSendService;

/**
 *<p>Title:MailThread.java</p>
 *<p>Description:邮件发送线程</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-7
 */
public class MailThread extends Thread {
	
	private static final Log LOG = LogFactory.getLog(MailThread.class);
	
	private Object lock = new Object();
	
	private boolean mailused = false;//是否启动邮件线程 默认为关闭
	
	private long interval;//线程执行间隔时间
	
	private AbstractMailSendService mailSendService;
	
	public void setMailused(boolean mailused) {
		this.mailused = mailused;
	}

	public void setInterval(long interval) {
		this.interval = interval;
	}

	public void setMailSendService(AbstractMailSendService mailSendService) {
		this.mailSendService = mailSendService;
	}



	@Override
	public void run() {
		if(mailused){
			LOG.info("mail send thread start ok ");
			synchronized (lock) {			
				while(true){
					try{	
						if(mailSendService == null){
							LOG.error("spring send 注入有误，请检查bean-mail.xml配置文件");
						}else{
							mailSendService.doMailSend();//邮件发送接口
						}
					}catch(Throwable e){
						LOG.error(e.getMessage(),e);
					}finally{
						try {
							lock.wait(interval);
						} catch (Exception e) {
							LOG.error(e.getMessage(),e);
						}
					}
				}			
			}		
		}else{
			LOG.info("mail send thread is turn off ");
		}
	}

}
