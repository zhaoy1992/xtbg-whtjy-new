package com.chinacreator.xtbg.core.archive.gwcs.services;

import javax.jws.WebService;

/**
 *<p>Title:GwcsOrgSynService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-22
 */
@WebService
public interface OaArchiveWebService {
	/**
	*<b>Summary: </b>
	* gwcsOrgSyn(解析电子公文传输系统传送过来的地址本数据，并返回处理结果给电子公文传输系统)
	* @param type	地址本xml文件类型,0：地址本初始化xml文件;1：地址本单条或多条更新xml文件
	* @param content 地址本 xml文件，转换为byte[]
	* @return 处理过程无异常返回0否则返回1
	*/
	public String gwcsOrgSyn(int type,byte[] content);
	
	/**
	*<b>Summary: </b>
	* recvCebFile(盖章ceb文件回传)
	* @param uuid	word上传返回的uuid
	* @param content	ceb文件
	* @return
	 */
	public String recvCebFile(String uuid,byte[] content);
	
	/**
	*<b>Summary: </b>
	* recvArchive(公文落地接口)
	* @param filenames  String filenames：多个公文名称之间用英文逗号隔开
	*									第一个为 公文*.ceb(此名称与zip包中的文件名称一致,使用英文命名)
	*									第二个为xml要素文件 (注意此名称与zip包中的文件名称一致,使用英文命名)
	*									之后的为附件需要包括后缀名(注意此名称与zip包中的文件名称一致,使用英文命名) 没有附件时不设置
	* @param content	byte[] content：公文要素xml文件+脱密后的ceb文件+附件打包为zip文件后，转换为byte[]（大小控制在5M以下）
	* @return
	*/
	public String recvArchive(String filenames,byte[] content);
	
	/**
	*<b>Summary: </b>
	* recvArchiveReceipt(接收公文发送后的回执状态)
	* @param content
	* @return
	*/
	public String recvArchiveReceipt(byte[] content);
	
	/**
	 * @Description  公文落地接口
	 * 解析gwcs传送过来的公文数据，并返回处理结果给电子公文传输系统
	 * @param filenames 多个公文名称之间用英文逗号隔开
	 * 第一个为 公文*.ceb(此名称与zip包中的文件名称一致,使用英文命名)
	 * 第二个为xml要素文件 (注意此名称与zip包中的文件名称一致,使用英文命名)
	 * 之后的为附件需要包括后缀名(注意此名称与zip包中的文件名称一致,使用英文命名)没有附件时不设置
	 * @param content 公文要素xml文件+脱密后的ceb文件+附件打包为zip文件后，转换为byte[]（大小控制在5M以下）
	 * @return 返回值类型String 处理过程无异常返回0否则返回1
	 * @throws IOException 
	 * @exception 异常说明
	 * 
	 */
	public String resciveGw(String filenames, byte[] content);
}
