package com.chinacreator.xtbg.core.common.mail.services;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.mail.cache.MailCacheBean;
import com.chinacreator.xtbg.core.common.mail.dao.MailDao;
import com.chinacreator.xtbg.core.common.mail.entity.MailAffixBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailRecvBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailTopicBean;
import com.chinacreator.xtbg.core.common.mail.support.MailConstants;

/**
 *<p>Title:AbstractMailSendService.java</p>
 *<p>Description:邮件发送抽象类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-7
 */
public abstract class AbstractMailSendService {
	
	private static final Log LOG = LogFactory.getLog(AbstractMailSendService.class);
	
	private MailDao mailDao = null;

	public void setMailDao(MailDao mailDao) {
		this.mailDao = mailDao;
	}

	/**
	*<b>Summary: </b>
	* doMailSend(邮件发送)
	* @throws Throwable
	*/
	public abstract void doMailSend() throws Throwable;
	
	/**
	*<b>Summary: </b>
	* queryMail(查询一条待发送的邮件，按照站内邮件和外部邮件分组)
	* @param conn
	* @return
	* @throws SQLException
	*/
	protected List<MailBean> queryMail(Connection conn) throws SQLException{
		List<MailBean> list = new ArrayList<MailBean>();
		MailTopicBean mailTopicBean = mailDao.queryOneMailTopic(conn);
		if(mailTopicBean == null){
			return null;
		}
		List<MailAffixBean> affixList = mailDao.queryMailAffixsNoBlob(mailTopicBean.getMail_id(), conn);
		
		List<MailRecvBean> recvList = mailDao.queryMailRecvs(mailTopicBean.getMail_id(), conn);
		Map<String,List<MailRecvBean>> map = groupInnerMail(recvList);
		List<MailRecvBean> localList = map.get(MailConstants.LOCAL);
		if(localList != null && localList.size() > 0){
			MailBean bean = new MailBean();
			bean.setMailType(MailConstants.LOCAL);
			bean.setMailTopicBean(mailTopicBean);
			bean.setRecvList(localList);
			bean.setAffixList(affixList);
			list.add(bean);
		}
		List<MailRecvBean> remoteList = map.get(MailConstants.REMOTE);
		if(remoteList != null && remoteList.size() > 0){
			MailBean bean = new MailBean();
			bean.setMailType(MailConstants.REMOTE);
			bean.setMailTopicBean(mailTopicBean);
			bean.setRecvList(remoteList);
			bean.setAffixList(affixList);
			list.add(bean);
		}
		return list;
	}
	
	/**
	*<b>Summary: </b>
	* updateMailSend(站内邮件发送)
	* @param bean
	* @param conn
	* @return
	 * @throws SQLException 
	*/
	protected boolean updateMailSend(List<MailBean> mailList,Connection conn) throws SQLException{
		//站内邮件发送，1、更新邮件状态为已发送。2、站内接收人接收状态为待接收。3、外部邮箱接收人状态为已发送。
		boolean success = true;
		for(MailBean bean : mailList){
			List<String> mailIDS = new ArrayList<String>();
			mailIDS.add(bean.getMailTopicBean().getMail_id());
			if(MailConstants.LOCAL.equals(bean.getMailType())){
				if(MailCacheBean.getInstance().isInnerMail()){//整个系统都为内部邮件   那就所有接收人根据邮件id更新状态，减少运行时间
					success = success && mailDao.updateMailRecvStatusByMailId(mailIDS, MailConstants.HAS_SEND,conn) 
						&& mailDao.updateMailRecvStatusByMailId(mailIDS,MailConstants.WAIT_READ, conn);
				}else{//存在外部邮件
					List<String> recvIDS = new ArrayList<String>();
					List<MailRecvBean> recvList = bean.getRecvList();
					for(MailRecvBean recvBean : recvList){
						recvIDS.add(recvBean.getRecv_id());
					}
					success = success && mailDao.updateMailRecvStatusByMailId(mailIDS, MailConstants.HAS_SEND,conn) 
						&& mailDao.updateMailRecvStatus(recvIDS,MailConstants.WAIT_READ, conn);
				}
			}else if(MailConstants.REMOTE.equals(bean.getMailType())){
				List<String> recvIDS = new ArrayList<String>();
				List<MailRecvBean> recvList = bean.getRecvList();
				for(MailRecvBean recvBean : recvList){
					recvIDS.add(recvBean.getRecv_id());
				}
				success = success && mailDao.updateMailRecvStatusByMailId(mailIDS, MailConstants.HAS_SEND,conn) 
					&& mailDao.updateMailRecvStatus(recvIDS,MailConstants.HAS_SEND, conn);
			}else{
				LOG.error("没有此邮件类型"+bean.getMailType());
			}
		}
		return success;
	}
	
	/**
	*<b>Summary: </b>
	* groupInnerMail(接收人邮箱地址分组，第一个为站内，第二个为外部)
	* @param recvList
	* @return
	*/
	private Map<String,List<MailRecvBean>> groupInnerMail(List<MailRecvBean> recvList){
		Map<String,List<MailRecvBean>>  map = new HashMap<String,List<MailRecvBean>>();
		if(MailCacheBean.getInstance().isInnerMail()){//整个系统都为内部邮件
			map.put(MailConstants.LOCAL, recvList);
		}else{
			String mailAddr = MailCacheBean.getInstance().getMailAddr();
			List<MailRecvBean> local = new ArrayList<MailRecvBean>();
			List<MailRecvBean> remote = new ArrayList<MailRecvBean>();
			for(MailRecvBean bean : recvList){
				if(bean.getRecv_user().endsWith(mailAddr)){
					local.add(bean);
				}else{
					remote.add(bean);
				}
			}
			map.put(MailConstants.LOCAL, local);
			map.put(MailConstants.REMOTE, remote);
		}
		return map;
	}
 }
