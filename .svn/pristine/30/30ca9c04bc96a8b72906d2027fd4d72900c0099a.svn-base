package com.chinacreator.xtbg.core.archive.gwcs.services;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.archive.gwcs.bean.Organization;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwcsXmlBean;

/**
 * 
 *<p>Title:OaArchiveHandlerIfc.java</p>
 *<p>Description:oa公文传输数据处理类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *Aug 8, 2013
 */
public interface OaArchiveHandlerIfc {
	
	/**
	 * 
	*<b>Summary: </b>
	* gwcsOrgSynHandler(对于电子公文传输系统传送过来的地址本数据的【初始化】处理方法)
	* @param type 地址本xml文件类型,0：地址本初始化xml文件;1：地址本单条或多条更新xml文件
	* @param content 地址本 xml文件，转换为byte[]
	* @param organizations 将地址本xml中的要素解析形成的 list<公文传输机构bean>
	* @throws Exception
	 */
	public void gwcsOrgSynInitHandler( byte[] content, ArrayList<Organization> organizations, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* gwcsOrgSynSingleOrg2DbHandler(对于电子公文传输系统传送过来的地址本数据的【更新|插入|删除】处理方法)
	* @param content
	* @param organization
	* @throws Exception
	 */
	public void gwcsOrgSynSingleOrg2DbHandler(byte[] content, Organization organization, Connection con) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* recvCebFileHandler(盖章ceb文件回传的数据处理方法)
	* @param uuid word上传返回的uuid
	* @param content ceb文件的byte数组
	* @param cebFile ceb文件对象
	* @throws Exception
	 */
	public void recvCebFileHandler(String uuid, byte[] content, File cebFile, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* recvArchive(公文落地接口)
	* @param filenames 多个公文名称之间用英文逗号隔开
	*	第一个为 公文*.ceb(此名称与zip包中的文件名称一致,使用英文命名)
	*	第二个为xml要素文件 (注意此名称与zip包中的文件名称一致,使用英文命名)
	*	之后的为附件需要包括后缀名(注意此名称与zip包中的文件名称一致,使用英文命名) 没有附件时不设置
	* @param content  公文要素xml文件+脱密后的ceb文件+附件打包为zip文件后，转换为byte[]（大小控制在5M以下）
	* @param receiveGwcsXmlBean 公文要素转换形成的对应bean
	* @param cebFile ceb文件(名称已转换为真实名)
	* @param attachFiles 附件集合(附件名称已转换为真实名)
	* @param con (数据库连接)
	* @throws Exception
	 */
	public void recvArchive(String filenames, byte[] content, ReceiveGwcsXmlBean receiveGwcsXmlBean,File cebFile,List<File> attachFiles, Connection con) throws Exception;
	
}
