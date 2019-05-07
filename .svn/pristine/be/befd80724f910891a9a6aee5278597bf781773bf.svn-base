package com.chinacreator.xtbg.core.archive.gwcs.services;

import java.net.MalformedURLException;
import java.rmi.RemoteException;

import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.OA2ExchangerDataBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendResponseBean;
import com.chinacreator.gwcs.oa.service.UnionArchiveResponseBean;

/**
 *<p>Title:GwcsOrgSynService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-22
 */
public interface OaSendArchiveService {
	
	/**
	 * 
	*<b>Summary: 解析oa上传过来的公文数据，传送正文，在公文传输中生成代办记录,并返回处理结果给电子政务内网系统</b>
	* callArchiveSend(公文上传)
	* @param send_id 公文业务主键
	* @param receiveGwcsXmlBean 公文要素bean，请调用者自行将数据填充好,bean里面有相关字段说明
	* @param affixpaths 附件路径数组，请调用者自行将附件生成到指定位置
	* @return
	 */
	public String callArchiveSendCeb(String[] textpathArry,ArchiveGwcsXmlBean archiveGwcsXmlBean,String[] affixpaths) throws Exception;
	
	/**
	 * 
	*<b>Summary: 解析oa上传过来的公文数据，同时把数据导入电子公文传输系统后进行公文发送,并返回处理结果给电子政务内网系统</b>
	* callArchiveSend(公文上传)
	* @param send_id 公文业务主键
	* @param receiveGwcsXmlBean 公文要素bean，请调用者自行将数据填充好,bean里面有相关字段说明
	* @param affixpaths 附件路径数组，请调用者自行将附件生成到指定位置
	* @param uuid 公文上传WORD后返回的UUID
	* @return
	 */
	public String callArchiveSend(ArchiveGwcsXmlBean archiveGwcsXmlBean,String[] affixpaths,String uuid) throws Exception;

	
	/**
	*<b>Summary: </b>
	* sendToFZOA(上传到公文传输系统)
	* @param oA2ExchangerDataBean 
	*/
	public String sendToFZOA(OA2ExchangerDataBean oA2ExchangerDataBean,ArchiveDispatchBean archiveDispatchBean)throws Exception;
	
	/**
	 * 
	*<b>Summary: 解析oa系统传送过来的相关数据，确定好参与盖章单位的顺序，发送给下一个协办单位进行盖章,并返回处理结果给电子政务内网系统</b>
	* callUnionArchiveSend(联合盖章发送)
	* @param receiveGwcsXmlBean 公文要素bean，请调用者自行将数据填充好,bean里面有相关字段说明
	* @param affixpaths 附件路径数组，请调用者自行将附件生成到指定位置
	* @param uuid 公文上传WORD后返回的UUID
	* @return
	 */
	public String callUnionArchiveSend(ArchiveGwcsXmlBean archiveGwcsXmlBean,String[] affixpaths,String uuid) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* callUnionArchiveFeedBack(流程监控接口，收取公文后，ceb文件数据传输给oa系统)
	* @param businessid
	 * @param unionArchiveSendWsdl 
	* @return
	* @throws MalformedURLException
	* @throws RemoteException
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
	public SendResponseBean doUnionArchiveToGwcs(ArchiveGwcsXmlBean archiveGwcsXmlBean,String[] affixpaths,String uuid) throws Exception;
}
