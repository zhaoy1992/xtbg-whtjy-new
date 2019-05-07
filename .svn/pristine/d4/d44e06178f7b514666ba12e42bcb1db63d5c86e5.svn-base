package com.chinacreator.xtbg.core.common.creatormaker.services;

import javax.xml.namespace.QName;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory;
/**
 *<p>Title:InvokWebservices.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-2
 */
public class InvokWebservices {

	/**
	*<b>Summary:</b>
	* invokeCxfService( 调用cxf 发布的 webservices )
	* @param wsdl  wsdl地址 包括 ?wsdl
	* @param nameSpace web服务的 namespace
	* @param method 调用的web服务方法
	* @param objects 参数
	* @return
	* @throws Exception
	 */
	public static Object[] invokeCxfService(String wsdl, String nameSpace, String method, Object...objects) throws Exception {
		JaxWsDynamicClientFactory factory = JaxWsDynamicClientFactory.newInstance();
		Client client = factory.createClient(wsdl);
		return client.invoke(new QName(nameSpace, method), objects);
	}
}
