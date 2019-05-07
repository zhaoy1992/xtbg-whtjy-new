package com.chinacreator.xtbg.core.archive.gwcs.client;

import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;

import javax.xml.namespace.QName;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory;

import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToGWCSServiceSoapBindingStub;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToGWCSService_ServiceLocator;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToServerServiceLocator;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToServerServiceSoapBindingStub;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendArchiveRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendArchiveResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.UnionArchiveToServerServiceSoapBindingStub;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.UnionArchiveToServerService_ServiceLocator;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordToGWCSServiceLocator;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordToGWCSServiceSoapBindingStub;
import com.chinacreator.xtbg.core.archive.service.WordArchiveService;
import com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao;
import com.chinacreator.xtbg.core.subsystemmanage.dao.impl.GwcsOrgConfigDaoImpl;
import com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean;

/**
 *<p>Title:InvokeGWCSServices.java</p>
 *<p>Description:调用webservics类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-23
 */
public abstract class InvokeGWCSService {

	/**
	*<b>Summary: </b>
	* invokeService(动态调用cxf发布的webservices接口)
	* @param wsdl	接口地址 wsdl
	* @param nameSpace 接口命名空间
	* @param method	接口方法
	* @param objects	接口参数集合
	* @return
	* @throws Exception
	*/
	public Object[] invokeService(String wsdl, String nameSpace, String method, Object...objects) throws Exception {
		JaxWsDynamicClientFactory factory = JaxWsDynamicClientFactory.newInstance();
//		System.getProperties().setProperty("http.proxyHost","172.16.17.64");
//		System.getProperties().setProperty("http.proxyPort","5679");
		Client client = factory.createClient(wsdl);
		return client.invoke(new QName(nameSpace, method), objects);
	}
	
	/**
	*<b>Summary: </b>
	* wordToGwcs(远程调用word上传)
	* @param wsdl
	* @param bean
	* @return
	* @throws MalformedURLException
	* @throws RemoteException
	 */
	public String wordToGwcs(String wsdl,WordRequestBean bean) throws MalformedURLException, RemoteException{
		WordToGWCSServiceLocator sl = new WordToGWCSServiceLocator();
		WordToGWCSServiceSoapBindingStub stub = new WordToGWCSServiceSoapBindingStub(new URL(wsdl),sl);
		return stub.callWordToGWCS(bean);
	}
	
	/**
	*<b>Summary: </b>
	* callArchiveSend(远程调用公文，先调用改章，后调用)
	* @param wsdl
	* @param bean
	* @return
	* @throws MalformedURLException
	* @throws RemoteException
	*/
	public SendResponseBean callArchiveSend(String wsdl,SendRequestBean bean) throws MalformedURLException, RemoteException{
		ArchiveToServerServiceLocator sl = new ArchiveToServerServiceLocator();
		ArchiveToServerServiceSoapBindingStub stub = new ArchiveToServerServiceSoapBindingStub(new URL(wsdl),sl);
		return stub.callArchiveSend(bean);
	}
	
	/**
	*<b>Summary: </b>
	* callArchiveSend(远程调用公文上传并发送)
	* @param wsdl
	* @param bean
	* @return
	* @throws MalformedURLException
	* @throws RemoteException
	*/
	public SendArchiveResponseBean callArchiveToGwcs(String wsdl,SendArchiveRequestBean bean) throws MalformedURLException, RemoteException{
		ArchiveToGWCSService_ServiceLocator locator = new ArchiveToGWCSService_ServiceLocator();
		ArchiveToGWCSServiceSoapBindingStub stub = new ArchiveToGWCSServiceSoapBindingStub(new URL(wsdl), locator);
		return stub.callArchiveToGWCS(bean);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* callUnionArchiveToGwcs(解析oa系统传送过来的相关数据，确定好参与盖章单位的顺序，发送给下一个协办单位进行盖章,并返回处理结果给电子政务内网系统)
	* @param wsdl
	* @param bean
	* @return
	* @throws MalformedURLException
	* @throws RemoteException
	 */
	public SendResponseBean callUnionArchiveToGwcs(String wsdl,SendRequestBean bean) throws MalformedURLException, RemoteException{
		UnionArchiveToServerService_ServiceLocator locator = new UnionArchiveToServerService_ServiceLocator();
		UnionArchiveToServerServiceSoapBindingStub stub = new UnionArchiveToServerServiceSoapBindingStub(new URL(wsdl), locator);
		return stub.callUnionArchiveSend(bean);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* callUnionArchiveFeedBack(财政厅收取公文后，ceb文件数据传输给oa系统)
	* @param wsdl
	* @param businessid
	* @return
	 * @throws Exception 
	 */
	public com.chinacreator.gwcs.oa.service.UnionArchiveResponseBean callUnionArchiveFeedBack(String wsdl,String businessid)throws Exception{
		String nameSpace = "http://service.oa.gwcs.chinacreator.com/";
		String method = "callUnionArchiveFeedBack";
		JaxWsDynamicClientFactory factory = JaxWsDynamicClientFactory.newInstance();
		Client client = factory.createClient(wsdl+"?wsdl");
		Object[] object = null;
		object = client.invoke(new QName(nameSpace, method), new Object[]{businessid});
		com.chinacreator.gwcs.oa.service.UnionArchiveResponseBean  unionArchiveResponseBean = (com.chinacreator.gwcs.oa.service.UnionArchiveResponseBean) object[0];
		return unionArchiveResponseBean;
		//UnionArchiveToServerService_ServiceLocator locator = new UnionArchiveToServerService_ServiceLocator();
		//UnionArchiveToServerServiceSoapBindingStub stub = new UnionArchiveToServerServiceSoapBindingStub(new URL(wsdl), locator);
		//return stub.callUnionArchiveFeedBack(businessid);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* doUnionArchiveToGwcs(盖章完成后的公文，财政厅对该公文进行分发)
	* @param wsdl
	* @param bean
	* @return
	* @throws MalformedURLException
	* @throws RemoteException
	 */
	public SendResponseBean doUnionArchiveToGwcs(String wsdl,SendRequestBean bean) throws MalformedURLException, RemoteException{
		UnionArchiveToServerService_ServiceLocator locator = new UnionArchiveToServerService_ServiceLocator();
		UnionArchiveToServerServiceSoapBindingStub stub = new UnionArchiveToServerServiceSoapBindingStub(new URL(wsdl), locator);
		return stub.doUnionArchiveSend(bean);
	} 
	
	/**
	 * 
	*<b>Summary: </b>
	* getArchiveConfig(获取公文要素配置)
	 */
	public OaGwcsConfigBean getArchiveConfig(String uuid) throws Exception{
		//根据流程实例ID 获取公文要素配置
		WordArchiveService archiveService = new WordArchiveServiceImpl();
		ArchiveDispatchBean archiveDispatchBean = archiveService.getArchiveDispatch(uuid);
		OaGwcsConfigBean oaGwcsConfigBean = null;
		//根据配置ID 获取盖章页面
		String send_org_config = archiveDispatchBean.getSend_org_config();
		if(!StringUtil.isBlank(send_org_config)){
			SubSystemOrgConfigDao subSystemOrgConfigDao = (GwcsOrgConfigDaoImpl)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
			oaGwcsConfigBean = subSystemOrgConfigDao.getGwcsConfigByID(send_org_config);
		}
		return oaGwcsConfigBean;
	}
}
