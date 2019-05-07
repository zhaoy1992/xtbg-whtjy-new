package com.chinacreator.xtbg.core.common.mail.services.impl;

import java.sql.Connection;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.mail.entity.MailBean;
import com.chinacreator.xtbg.core.common.mail.services.AbstractMailSendService;
import com.chinacreator.xtbg.core.common.mail.support.MailConstants;
import com.chinacreator.xtbg.core.common.util.DbManager;
/**
 *<p>Title:MailSendServiceDemo.java</p>
 *<p>Description:邮件发送</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-7
 */
public class MailSendServiceImpl extends AbstractMailSendService{

	private static final Log LOG = LogFactory.getLog(MailSendServiceImpl.class);
	/**
	  * <b>Summary: </b>
	  *     复写方法 doMailSend
	  * @throws Throwable 
	  * @see com.chinacreator.xtbg.core.common.mail.services.AbstractMailSendService#doMailSend()
	 */
	@Override
	public void doMailSend() throws Throwable {
		List<MailBean> mailList = null;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			mailList = super.queryMail(conn);
			if(mailList == null || mailList.size() == 0){
				return;
			}
			super.updateMailSend(mailList, conn);//假设邮件发送成功
			for(MailBean bean : mailList){
				if(MailConstants.REMOTE.equals(bean.getMailType())){//外部邮件
					//TODO 外部邮件发送接口 实现具体发送。
				}
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
	}

}
