package com.chinacreator.xtbg.core.archive.gwcs.client;

import java.net.MalformedURLException;
import java.rmi.RemoteException;

import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendArchiveRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendArchiveResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendResponseBean;
import com.chinacreator.gwcs.oa.service.UnionArchiveResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordRequestBean;

/**
 *<p>Title:ArchiveClientCallGWCSService.java</p>
 *<p>Description:调用公务传输系统服务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-23
 */
public interface ArchiveClientCallGWCSService {
	
	/**
	*<b>Summary: </b>
	* callWordToGWCS(word 上传)
	* @param bean
	* @param wordToGwcsWsdl
	* @return  UUID
	*/
	public String callWordToGWCS(WordRequestBean bean,String wordToGwcsWsdl);
	
	/**
	*<b>Summary: </b>
	* callArchiveSend(公文上传并发送)
	* @param bean
	* @return
	*/
	public SendResponseBean callArchiveSend(SendRequestBean bean)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* callArchiveToGwcs(远程调用公文上传)
	* @param bean
	* @return
	* @throws MalformedURLException
	* @throws RemoteException
	 */
	public SendArchiveResponseBean callArchiveToGwcs(SendArchiveRequestBean bean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* callUnionArchiveGwcs(联合盖章发送)
	* @param bean
	* @return
	* @throws MalformedURLException
	* @throws RemoteException
	 */
	public SendResponseBean callUnionArchiveToGwcs(SendRequestBean bean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* callUnionArchiveFeedBack(流程监控接口，收取公文后，ceb文件数据传输给oa系统)
	* @param businessid
	 * @param unionArchiveSendWsdl 
	* @return
	* @throws MalformedURLException
	* @throws RemoteException
	 * @throws Exception 
	 */
	public UnionArchiveResponseBean callUnionArchiveFeedBack(String businessid, String unionArchiveSendWsdl) throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* callUnionArchiveGwcs(联合公文发送)
	* @param bean
	* @return
	* @throws MalformedURLException
	* @throws RemoteException
	 */
	public SendResponseBean doUnionArchiveToGwcs(SendRequestBean bean) throws Exception;
}
