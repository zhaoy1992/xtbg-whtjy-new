package com.chinacreator.xtbg.pub.oagwcs.service.impl;

import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;
import org.apache.axis.AxisFault;
import org.apache.log4j.Logger;
import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.oagwcs.dao.SendGwDao;
import com.chinacreator.xtbg.pub.oagwcs.dao.SendGwgetOrgCodeDao;
import com.chinacreator.xtbg.pub.oagwcs.dao.imploracle.HuaihuaSendGwDaoImpl;
import com.chinacreator.xtbg.pub.oagwcs.oa.service.ArchiveToGWCSServiceSoapBindingStub;
import com.chinacreator.xtbg.pub.oagwcs.oa.service.ArchiveToGWCSService_ServiceLocator;
import com.chinacreator.xtbg.pub.oagwcs.oa.service.SendArchiveRequestBean;
import com.chinacreator.xtbg.pub.oagwcs.oa.service.SendArchiveResponseBean;
import com.chinacreator.xtbg.pub.oagwcs.service.SendGwIfc;
import com.chinacreator.xtbg.pub.oagwcs.service.util.GwConstant;

/**
 * Title:SendGwImpl.java
 * Description:公文传输接口实现
 * Copyright:Copyright (c) 2013
 * Company:湖南科创
 * @author 夏天
 * @version 1.0 2013-4-23
 */
public class SendGwImpl implements SendGwIfc {
	private static final Logger Log = Logger.getLogger(SendGwImpl.class);
	private SendGwDao sendGwDao = null;

	public SendGwImpl(SendGwDao sendGwDao) {
		super();
		this.sendGwDao = sendGwDao;
	}

	@Override
	public boolean SendGwToWebService(String send_id, String user_id) {
		Log.error(" start  =========");
		boolean issucess = false;
		if (null == sendGwDao) {
			Log.error("公文传输持久层实现接口：sendGwDao没有设置！");
			return issucess;
		}
		try {
			Log.error(" sendGwWork  ========="
					+ CacheCommonManageProxy
							.getBooleanSystemParam("sendGwWork"));
			if (!CacheCommonManageProxy.getBooleanSystemParam("sendGwWork")) {
				String endPoint = GwConstant.GWCS_WEB_URL
						+ GwConstant.ARCHIVE_TO_GWCSSERVICE;
				Log.info("endPoint========" + endPoint);
				ArchiveToGWCSService_ServiceLocator service = new ArchiveToGWCSService_ServiceLocator();
				ArchiveToGWCSServiceSoapBindingStub stub = new ArchiveToGWCSServiceSoapBindingStub(
						new URL(endPoint), service);

				SendArchiveRequestBean requestBean = sendGwDao
						.createSendArchiveRequestBeanBySendId(send_id, user_id);

				SendArchiveResponseBean responseBean = stub
						.callArchiveToGWCS(requestBean);
				Log.info("messageid:" + responseBean.getMessageid());
				Log.info("businessid:" + responseBean.getBusinessid());
				Log.info("summary:" + responseBean.getSummary());
				Log.info("exception:" + responseBean.getException());
				if ("RES000".equals(responseBean.getMessageid())) {
					issucess = true;
				}
				// 怀化单独公文传输处理
			} else {
				Log.info("GWCS_WEB_URL========" + GwConstant.GWCS_WEB_URL);
				String[] endPoints = GwConstant.GWCS_WEB_URL.split(",");
				// 市委
				String endPoint0 = endPoints[0]
						+ GwConstant.ARCHIVE_TO_GWCSSERVICE;
				// 区县
				String endPoint1 = endPoints[1]
						+ GwConstant.ARCHIVE_TO_GWCSSERVICE;
				Log.info("市委endPoint0========" + endPoint0);
				Log.info("区县endPoint1========" + endPoint1);

				String endPoint = "";
				HuaihuaSendGwDaoImpl hhsendGw = new HuaihuaSendGwDaoImpl();
				// 得到发起人的机构名称和地址码
				String[] orgs = hhsendGw.getOrgByUserId(user_id);
				// 机构地址码
				String org_address = orgs[1];
				Log.info("机构地址码:" + org_address);
				if (!StringUtil.nullOrBlank(org_address)
						&& org_address.length() > 6) {
					String org_top = org_address.substring(0, 5);
					Log.info("机构地址码前五位:" + org_top);
					// 市委
					if ("11090".equals(org_top)) {
						endPoint = endPoint0;
						// 区县委
					} else if ("11091".equals(org_top)) {
						endPoint = endPoint1;
					}
				}
				Log.info("送往公文传输地址:" + endPoint);
				ArchiveToGWCSService_ServiceLocator service = new ArchiveToGWCSService_ServiceLocator();
				ArchiveToGWCSServiceSoapBindingStub stub = new ArchiveToGWCSServiceSoapBindingStub(
						new URL(endPoint), service);

				SendArchiveRequestBean requestBean = sendGwDao
						.createSendArchiveRequestBeanBySendId(send_id, user_id);

				SendArchiveResponseBean responseBean = stub
						.callArchiveToGWCS(requestBean);
				Log.info("messageid:" + responseBean.getMessageid());
				Log.info("businessid:" + responseBean.getBusinessid());
				Log.info("summary:" + responseBean.getSummary());
				Log.info("exception:" + responseBean.getException());
				if ("RES000".equals(responseBean.getMessageid())) {
					issucess = true;
				}
			}
			// to do
		} catch (AxisFault e) {
			e.printStackTrace();
			Log.error(e.getMessage());
		} catch (MalformedURLException e) {
			e.printStackTrace();
			Log.error(e.getMessage());
		} catch (RemoteException e) {
			e.printStackTrace();
			Log.error(e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			Log.error(e.getMessage());
		}
		return issucess;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 SendGwToWebService 怀化内部签呈送公文传输
	  * @param send_id
	  * @param user_id
	  * @param classname
	  * @return 
	  * @see com.chinacreator.xtbg.pub.oagwcs.service.SendGwIfc#SendGwToWebService(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public boolean SendGwToWebService(String send_id, String user_id, String classname) {
		Log.error(" start  =========");
		boolean issucess = false;
		if (null == sendGwDao) {
			Log.error("公文传输持久层实现接口：sendGwDao没有设置！");
			return issucess;
		}
		try {
			Log.error(" sendGwWork  ========="
					+ CacheCommonManageProxy
							.getBooleanSystemParam("sendGwWork"));
			Log.info("GWCS_WEB_URL========" + GwConstant.GWCS_WEB_URL);
			String[] endPoints = GwConstant.GWCS_WEB_URL.split(",");
			// 市委
			String endPoint0 = endPoints[0] + GwConstant.ARCHIVE_TO_GWCSSERVICE;
			// 区县
			String endPoint1 = endPoints[1] + GwConstant.ARCHIVE_TO_GWCSSERVICE;
			Log.info("市委endPoint0========" + endPoint0);
			Log.info("区县endPoint1========" + endPoint1);

			String endPoint = "";
			SendGwgetOrgCodeDao hhsendGw = (SendGwgetOrgCodeDao) Class.forName(classname).newInstance();
			// 得到发起人的机构名称和地址码
			String[] orgs = hhsendGw.getOrgByUserId(user_id);
			// 机构地址码
			String org_address = orgs[1];
			Log.info("机构地址码:" + org_address);
			if (!StringUtil.nullOrBlank(org_address)
					&& org_address.length() > 6) {
				String org_top = org_address.substring(0, 5);
				Log.info("机构地址码前五位:" + org_top);
				// 市委
				if ("11090".equals(org_top)) {
					endPoint = endPoint0;
					// 区县委
				} else if ("11091".equals(org_top)) {
					endPoint = endPoint1;
				}
			}
			Log.info("送往公文传输地址:" + endPoint);
			ArchiveToGWCSService_ServiceLocator service = new ArchiveToGWCSService_ServiceLocator();
			ArchiveToGWCSServiceSoapBindingStub stub = new ArchiveToGWCSServiceSoapBindingStub(
					new URL(endPoint), service);

			SendArchiveRequestBean requestBean = sendGwDao
					.createSendArchiveRequestBeanBySendId(send_id, user_id);

			SendArchiveResponseBean responseBean = stub
					.callArchiveToGWCS(requestBean);
			Log.info("messageid:" + responseBean.getMessageid());
			Log.info("businessid:" + responseBean.getBusinessid());
			Log.info("summary:" + responseBean.getSummary());
			Log.info("exception:" + responseBean.getException());
			if ("RES000".equals(responseBean.getMessageid())) {
				issucess = true;
			}
			// to do
		} catch (AxisFault e) {
			e.printStackTrace();
			Log.error(e.getMessage());
		} catch (MalformedURLException e) {
			e.printStackTrace();
			Log.error(e.getMessage());
		} catch (RemoteException e) {
			e.printStackTrace();
			Log.error(e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			Log.error(e.getMessage());
		}
		return issucess;
	}

}
