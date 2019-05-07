package com.chinacreator.xtbg.core.common.mail.services.impl;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import junit.framework.TestCase;

import com.chinacreator.xtbg.core.common.mail.entity.MailAffixBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailRecvBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailTopicBean;
import com.chinacreator.xtbg.core.common.mail.services.MailService;
import com.chinacreator.xtbg.core.common.mail.support.MailConstants;

public class MailServiceImplTest extends TestCase {

	public void testSendMail(){
		MailService mailService = new MailServiceImpl();
		try {
			MailBean bean = new MailBean();
			bean.setMailTopicBean(getMailTopicBean());
			bean.setRecvList(getRecvList());
			bean.setAffixList(getAffixList());
			assertEquals(true, mailService.sendMail(bean, null));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public boolean sendmail() throws Exception{
		MailService mailService = new MailServiceImpl();
		MailBean bean = new MailBean();
		bean.setMailTopicBean(getMailTopicBean());
		bean.setRecvList(getRecvList());
		bean.setAffixList(getAffixList());
		return mailService.sendMail(bean, null);
	}
	
	private MailTopicBean getMailTopicBean(){
		MailTopicBean bean = new MailTopicBean();
		bean.setTopic("测试邮件发送");
		bean.setContent("测试邮件发送测试邮件发送测试邮件发送");
		bean.setMail_origin(MailConstants.DRAFT);
		bean.setSend_user("bo.wang@chinacreator.com");
		bean.setStatus(MailConstants.MAIL_DRAFT);
		bean.setCreate_date(new Timestamp(System.currentTimeMillis()));
		return bean;
	}
	
	private List<MailRecvBean> getRecvList(){
		 List<MailRecvBean> recvList = new ArrayList<MailRecvBean>();
		 MailRecvBean bean = new MailRecvBean();
		 bean.setRecv_user("bo.wang1@chinacreator.com");
		 bean.setSend_type(MailConstants.SEND_TYPE_M);
		 bean.setStatus(MailConstants.WAIT_READ);
		 recvList.add(bean);
		 
		 MailRecvBean bean1 = new MailRecvBean();
		 bean1.setRecv_user("bo.wang2@chinacreator.com");
		 bean1.setSend_type(MailConstants.SEND_TYPE_C);
		 bean1.setStatus(MailConstants.WAIT_READ);
		 recvList.add(bean1);
		 return recvList;
	}
	
	private List<MailAffixBean> getAffixList() {
		List<MailAffixBean> affixList = new ArrayList<MailAffixBean>();
		MailAffixBean bean = new MailAffixBean();
		File file = new File("D:/工作/协同办公系统流程开发规范.doc"); 
			bean.setContent(file);
		
		bean.setFilelocation("D:/工作/协同办公系统流程开发规范.doc");
		bean.setFilesize(file.length());
		bean.setFiletype("doc");
		bean.setOriginal_name("协同办公系统流程开发规范.doc");
		bean.setRealname("xx.doc");
		affixList.add(bean);
		
		return affixList;
	}
}