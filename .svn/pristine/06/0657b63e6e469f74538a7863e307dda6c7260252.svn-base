package com.chinacreator.xtbg.core.archive.gwcs.client.impl;

import java.net.MalformedURLException;
import java.rmi.RemoteException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.gwcs.oa.service.UnionArchiveResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.ArchiveClientCallGWCSService;
import com.chinacreator.xtbg.core.archive.gwcs.client.InvokeGWCSService;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendArchiveRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendArchiveResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordRequestBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean;
/**
 *<p>Title:ArchiveClientCallGWCSServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-23
 */
public class ArchiveClientCallGWCSServiceImpl extends InvokeGWCSService implements
		ArchiveClientCallGWCSService {
	
	private static final Log LOG = LogFactory.getLog(ArchiveClientCallGWCSServiceImpl.class);
	
	private String wordToGwcsWsdl;//word 上传ws接口地址
	
	private String archiveSendWsdl;//公文传输接受地址。
	
	private String archiveServerSendWsdl;//公文发送接口（先盖章后发送，传送UUID）
	
	private String unionArchiveSendWsdl;//联合发文接口
	
	public void setUnionArchiveSendWsdl(String unionArchiveSendWsdl) {
		this.unionArchiveSendWsdl = unionArchiveSendWsdl;
	}

	public void setArchiveServerSendWsdl(String archiveServerSendWsdl) {
		this.archiveServerSendWsdl = archiveServerSendWsdl;
	}
	
	public void setWordToGwcsWsdl(String wordToGwcsWsdl) {
		this.wordToGwcsWsdl = wordToGwcsWsdl;
	}

	public void setArchiveSendWsdl(String archiveSendWsdl) {
		this.archiveSendWsdl = archiveSendWsdl;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 callWordToGWCS
	  * @param bean
	  * @param wordToGwcsWsdl
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.client.ArchiveClientCallGWCSService#callWordToGWCS(com.chinacreator.xtbg.core.archive.gwcs.client.entity.WordRequestBean)
	 */
	@Override
	public String callWordToGWCS(WordRequestBean bean,String wordToGwcsWsdlConfig) {
		//获取配置地址
		if(!StringUtil.isBlank(wordToGwcsWsdlConfig)){
			wordToGwcsWsdl = wordToGwcsWsdlConfig;
		}
		String uuid = "";
		try {
			uuid = super.wordToGwcs(wordToGwcsWsdl,bean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return uuid;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 callArchiveSend
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.client.ArchiveClientCallGWCSService#callArchiveSend(com.chinacreator.xtbg.core.archive.gwcs.client.entity.SendRequestBean)
	 */
	@Override
	public SendResponseBean callArchiveSend(SendRequestBean bean) throws Exception{
		String uuid = bean.getId();
		//获取发文地址配置
		OaGwcsConfigBean oaGwcsConfigBean = getArchiveConfig(uuid);
		if(oaGwcsConfigBean!=null){
			archiveServerSendWsdl = oaGwcsConfigBean.getArchiveserversendwsdl();
		}
		SendResponseBean  responseBean = super.callArchiveSend(archiveServerSendWsdl, bean);
		return responseBean;
	}

	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 callArchiveToGwcs
	  * @param bean
	  * @return
	  * @throws MalformedURLException
	  * @throws RemoteException 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.client.ArchiveClientCallGWCSService#callArchiveToGwcs(com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendArchiveRequestBean)
	 */
	@Override
	public SendArchiveResponseBean callArchiveToGwcs(SendArchiveRequestBean bean) throws MalformedURLException,RemoteException {
		
		SendArchiveResponseBean responseBean = super.callArchiveToGwcs(archiveSendWsdl, bean);
		return responseBean;
		
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 callUnionArchiveToGwcs
	  * @param bean
	  * @return
	  * @throws MalformedURLException
	  * @throws RemoteException 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.client.ArchiveClientCallGWCSService#callUnionArchiveToGwcs(com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendRequestBean)
	 */
	@Override
	public SendResponseBean callUnionArchiveToGwcs(SendRequestBean bean) throws Exception {
		String uuid = bean.getId();
		//获取发文地址配置
		OaGwcsConfigBean oaGwcsConfigBean = getArchiveConfig(uuid);
		if(oaGwcsConfigBean!=null){
			unionArchiveSendWsdl = oaGwcsConfigBean.getUnionarchivesendwsdl();
		}
		SendResponseBean responseBean = super.callUnionArchiveToGwcs(unionArchiveSendWsdl, bean);
		return responseBean;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 callUnionArchiveFeedBack
	  * @param businessid
	  * @return
	 * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.client.ArchiveClientCallGWCSService#callUnionArchiveFeedBack(java.lang.String)
	 */
	@Override
	public UnionArchiveResponseBean callUnionArchiveFeedBack(String businessid, String unionArchiveSendWsdlConfig)throws Exception {
		//获取配置地址
		if(!StringUtil.isBlank(unionArchiveSendWsdlConfig)){
			unionArchiveSendWsdl = unionArchiveSendWsdlConfig;
		}
		UnionArchiveResponseBean unionArchiveResponseBean= super.callUnionArchiveFeedBack(unionArchiveSendWsdl, businessid);
		UnionArchiveResponseBean  responseBean =unionArchiveResponseBean ;
		return responseBean;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doUnionArchiveToGwcs
	  * @param bean
	  * @return
	  * @throws MalformedURLException
	  * @throws RemoteException 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.client.ArchiveClientCallGWCSService#doUnionArchiveToGwcs(com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendRequestBean)
	 */
	@Override
	public SendResponseBean doUnionArchiveToGwcs(SendRequestBean bean) throws Exception {
		String uuid = bean.getId();
		//获取发文地址配置
		OaGwcsConfigBean oaGwcsConfigBean = getArchiveConfig(uuid);
		if(oaGwcsConfigBean!=null){
			unionArchiveSendWsdl = oaGwcsConfigBean.getUnionarchivesendwsdl();
		}
		SendResponseBean responseBean = super.doUnionArchiveToGwcs(unionArchiveSendWsdl, bean);
		return responseBean;
	}
	
}
