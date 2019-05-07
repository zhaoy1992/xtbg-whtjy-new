package com.chinacreator.xtbg.core.common.creatormaker.webservices;

import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;

import org.apache.axis.AxisFault;

import com.chinacreator.xtbg.core.common.cache.OASystemCache;

/**
 *<p>Title:InvokeCreatorPDFMaker.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-1
 */
public class InvokeCreatorPDFMaker {
	
	private String wsdlurl;//服务地址
	
	private CreatorPDFMakerServiceLocator sl;
	private  CreatorPDFMakerServiceSoapBindingStub stub;
	
	public InvokeCreatorPDFMaker() throws AxisFault, MalformedURLException{
		this.wsdlurl = OASystemCache.getContextProperty("maker_wsdl"); //OASystemCacheBean.getInstance().getMaker_wsdl();
		sl = new CreatorPDFMakerServiceLocator();
		stub = new CreatorPDFMakerServiceSoapBindingStub(new URL(wsdlurl),sl);
	}
	
	/*public static void main(String[] args) {
		try {
			InvokeCreatorPDFMaker InvokeCreatorPDFMaker = new InvokeCreatorPDFMaker();
			byte[] pdf = InvokeCreatorPDFMaker.word2pdf(FileCopyUtils.copyToByteArray(new File("D:\\工作\\OA\\test.doc")));
			FileCopyUtils.copy(pdf,new File("D:\\工作\\OA\\testsdfdsf.pdf"));
			
		} catch (AxisFault e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}*/
	
	
	/**
	*<b>Summary: </b>
	* word2pdf(word转pdf)
	* @param content
	* @return
	* @throws RemoteException
	 */
	public byte[] word2pdf(byte[] content) throws RemoteException{
		return stub.doc2Pdf(content);
	}

}
