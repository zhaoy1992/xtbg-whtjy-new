package com.chinacreator.xtbg.core.archive.gwcs.client.impl;

import java.io.File;
import java.io.IOException;

import javax.xml.namespace.QName;

import junit.framework.TestCase;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory;

import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.ZipUtil;

public class GWCSServiceCallOaArchiveClientTest extends TestCase{
	private String wsdl = "http://172.16.17.21:8080/xtbgbase/services/OaArchiveWebService?wsdl";

	public void testCallGwcsToOa(){
		String path = "C:\\oa\\temp\\archive\\archive.xml";
		File xmlFile = new File(path);
		byte[] filebytes = FileUtil.getBytesFromFile(xmlFile);
		
		JaxWsDynamicClientFactory factory = JaxWsDynamicClientFactory.newInstance();
		//System.getProperties().setProperty("http.proxyHost","172.16.17.1");
		//System.getProperties().setProperty("http.proxyPort","808");
		Client client = factory.createClient(wsdl);
		
		try {
			Object[] o = client.invoke(new QName("http://services.gwcs.archive.core.xtbg.chinacreator.com/", "gwcsOrgSyn"), 1,filebytes);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*OaArchiveWebService_ServiceLocator sl = new OaArchiveWebService_ServiceLocator();
		try {
			OaArchiveWebServiceSoapBindingStub stub = new OaArchiveWebServiceSoapBindingStub(new URL(wsdl),sl);
			
			System.out.println(stub.gwcsOrgSyn(0, filebytes));
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/

	}
	public void testCallOaArchiveWebService(){
		String path = "C:\\oa\\temp\\archive\\archive.xml";
		File xmlFile = new File(path);
		byte[] filebytes = FileUtil.getBytesFromFile(xmlFile);
		JaxWsDynamicClientFactory factory = JaxWsDynamicClientFactory.newInstance();
		Client client = factory.createClient(wsdl);
		
		try {
			Object[] o = client.invoke(new QName("http://services.gwcs.archive.core.xtbg.chinacreator.com/", "recvCebFile"), "11",filebytes);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void testCallOaReceArchive(){
		ZipUtil zipUtil = new ZipUtil();
		//2.解压zip包,(filenames文件名称与zip包文件数验证)
		try {
			zipUtil.unZipFile("C:\\oa\\temp\\tmp.zip", "C:\\oa\\temp\\zipdir\\");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//解压缩zip文件
	}
}
