package com.chinacreator.xtbg.pub.oagwcs.oa.service;

import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;

import org.apache.axis.AxisFault;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.oagwcs.dao.SendGwDao;
import com.chinacreator.xtbg.pub.oagwcs.dao.imploracle.YmjSendGwDaoImpl;

public class Test {

	/**
	 *<b>Summary: </b>
	 * main(����һ�仰��������������)
	 * @param args 
	 * @throws MalformedURLException 
	 * @throws AxisFault 
	 */
	public static void main(String[] args) {
//		
//		try {
////			String endPoint = "http://172.16.17.147:8888/gwcs/services/ArchiveToGWCSService" ;
////			
////			ArchiveToGWCSService_ServiceLocator service = new ArchiveToGWCSService_ServiceLocator() ;
////			ArchiveToGWCSServiceSoapBindingStub stub = new ArchiveToGWCSServiceSoapBindingStub(new URL(endPoint), service) ;
////			SendGwDao sendGwDao = new YmjSendGwDaoImpl();
////			
////			SendArchiveRequestBean requestBean = sendGwDao.createSendArchiveRequestBeanBySendId("543","32");
////			
////			SendArchiveResponseBean responseBean = stub.callArchiveToGWCS(requestBean) ;
////			
////			System.out.println("messageid:"+responseBean.getMessageid());
////			System.out.println("businessid:"+responseBean.getBusinessid());
////			System.out.println("summary:"+responseBean.getSummary());
////			System.out.println("exception:"+responseBean.getException());
//			//to do
//		} catch (AxisFault e) {
//			e.printStackTrace();
//		} catch (MalformedURLException e) {
//			e.printStackTrace();
//		} catch (RemoteException e) {
//			e.printStackTrace();
//		}
		String str = StringUtil.getUUID();
		System.out.println("str======"+str);
	}

}
