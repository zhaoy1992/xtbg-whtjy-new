package com.chinacreator.xtbg.core.common.mail.services.impl;

import java.sql.Connection;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.mail.cache.MailCacheBean;
import com.chinacreator.xtbg.core.common.mail.dao.MailDao;
import com.chinacreator.xtbg.core.common.mail.entity.MailAffixBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailRecvBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailTopicBean;
import com.chinacreator.xtbg.core.common.mail.services.MailService;
import com.chinacreator.xtbg.core.common.mail.support.MailConstants;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 *<p>Title:MailServiceImpl.java</p>
 *<p>Description:邮件发送服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-6
 */
public class MailServiceImpl implements MailService {
	
	private static final Log LOG = LogFactory.getLog(MailServiceImpl.class);

	/**
	  * <b>Summary: </b>
	  *     复写方法 sendMail
	  * @param bean
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.mail.services.MailService#sendMail(com.chinacreator.xtbg.core.common.mail.entity.MailBean, java.sql.Connection)
	 */
	@Override
	public boolean sendMail(MailBean bean,Connection conn) throws Exception {
		boolean innerConn = false; //是否为内部连接
		boolean success = true;//操作成功
		try{
			MailTopicBean mailTopicBean = getMailTopicBean(bean.getMailTopicBean());
			List<MailRecvBean> recvList = getRecvList(bean.getRecvList(), mailTopicBean.getMail_id());
			List<MailAffixBean> affixList = getAffixList(bean.getAffixList(), mailTopicBean.getMail_id());
			
			if(conn == null){//外部传入连接为null 
				conn = DbManager.getInstance().getTransactionConnection();
				innerConn = true;
			}
			
			MailDao mailDao = (MailDao) LoadSpringContext.getApplicationContext().getBean("mailDao");
			
			success = mailDao.insertMailTopic(mailTopicBean, conn) //主题信息入库
							&& mailDao.insertMailRecv(recvList, conn) //接收人信息入库
							&& mailDao.insertMailAffix(affixList, conn);//附件信息入库
			
		}catch (Exception e) {
			LOG.error(e.getMessage(), e);
			if(innerConn){//内部自己产生的连接  数据回滚
				DbManager.rollBackNoThrow(conn);
			}
			throw e;
		}finally{
			if(innerConn){//内部自己产生的连接  关闭连接
				DbManager.closeConnection(conn);
			}
		}
		return success;
	}
	
	/**
	*<b>Summary: </b>
	* getMailTopicBean(完善邮件主题信息)
	* @param bean
	* @return
	 * @throws Exception 
	*/
	private MailTopicBean getMailTopicBean(MailTopicBean bean) throws Exception{
		if(bean != null){
			bean.setMail_id(StringUtil.getUUID());
			if(MailCacheBean.getInstance().isInnerMail()){//内部邮件，邮件状态为已发送
				bean.setStatus(MailConstants.HAS_SEND);
			}
			return bean;
		}else{
			throw new Exception("邮件主题信息不能为空");
		}
	}
	
	/**
	*<b>Summary: </b>
	* getRecvList(完善邮件接收人信息)
	* @param recvList
	* @param mailID
	* @return
	 * @throws Exception 
	*/
	private List<MailRecvBean> getRecvList(List<MailRecvBean> recvList,String mailID) throws Exception{
		if(recvList != null){
			for(MailRecvBean bean : recvList){
				bean.setMail_id(mailID);
				bean.setRecv_id(StringUtil.getUUID());
				if(MailCacheBean.getInstance().isInnerMail()){//内部邮件，邮件接收状态为待阅读
					bean.setStatus(MailConstants.WAIT_READ);
				}
			}
			return recvList;
		}else{
			throw new Exception("邮件接收人信息不能为空");
		}
	}
	
	/**
	*<b>Summary: </b>
	* getAffixList(完善邮件附件信息)
	* @param affixList
	* @param mailID
	* @return
	*/
	private List<MailAffixBean> getAffixList(List<MailAffixBean> affixList,String mailID){
		if(affixList != null){
			for(MailAffixBean bean : affixList){
				bean.setMail_id(mailID);
				bean.setAffix_id(StringUtil.getUUID());
			}
		}
		return affixList;
	}

}
