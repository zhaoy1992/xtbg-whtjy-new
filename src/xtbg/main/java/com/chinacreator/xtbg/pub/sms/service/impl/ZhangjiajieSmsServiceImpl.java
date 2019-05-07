package com.chinacreator.xtbg.pub.sms.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.jboss.logging.Logger;

import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl;
import com.chinacreator.xtbg.pub.sms.entity.SmsBean;
import com.chinacreator.xtbg.pub.sms.service.SmsServiceIfc;
import com.chinacreator.xtbg.pub.sms.smsutil.SmsUtil;
import com.chinacreator.xtbg.pub.util.DbConnection;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:ZhangjiajieSmsServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 李星
 *@version 1.0
 *2013-5-9
 */
public class ZhangjiajieSmsServiceImpl implements SmsServiceIfc{
	private static final Logger LOG = Logger.getLogger(ZhangjiajieSmsServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 smsDataAssembling
	  * @param map 
	  * @see com.chinacreator.xtbg.pub.sms.service.SmsServiceIfc#smsDataAssembling(java.util.Map)
	 */
	@Override
	public void smsDataAssembling(Map<String, String> map,Connection con) {
		SmsUtil smsUtil = new SmsUtil();
		if (null != map.get("user_id") && !"".equals(map.get("user_id")) && "y".equalsIgnoreCase(map.get("isSend"))) {
			try {
				List<SmsBean> list = (List<SmsBean>) smsUtil.twoSendPhone(map);
				if (list.size() > 0 && null != list) {
					for (int i = 0; i < list.size(); i++) {
						SmsBean smsBean = list.get(i);
						smsBean.setContent(map.get("content"));
						smsSendDao(smsBean);
					}
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(),e);
			} catch (Throwable e) {
				LOG.error(e.getMessage(),e);
			}
		}
	}
	/**
	 * 
	*<b>Summary: </b>
	* smsSendDao(请用一句话描述这个方法的作用)
	* 张家界使用跟外部进行交付进行短信发送
	* @param smsBean
	 * @throws Throwable 
	 */
	public void smsSendDao(SmsBean smsBean) throws Throwable{
		String extcode = CacheCommonManageProxy.getSystemParam("extcode");
		String reqdeliveryreport = CacheCommonManageProxy.getSystemParam("reqdeliveryreport");
		String msgfmt = CacheCommonManageProxy.getSystemParam("msgfmt");
		String sendmethod = CacheCommonManageProxy.getSystemParam("sendmethod");
		String applicationid = CacheCommonManageProxy.getSystemParam("applicationid");
		String ecid = CacheCommonManageProxy.getSystemParam("ecid");
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		Connection sqlConn = getConnection();
		
		OrgManagerImpl orgImp= new OrgManagerImpl();
		sql.append("insert into sms_outbox");
		sql.append("  (sismsid,");//主键
		sql.append("   extcode,");//扩展号码
		sql.append("   destaddr,");//手机号码
		sql.append("   messagecontent,");//短息内容
		sql.append("   reqdeliveryreport,");//状态报告
		sql.append("   msgfmt,");//消息那类型
		sql.append("   sendmethod,");//普通短息
		sql.append("   requesttime,");//创建时间
		sql.append("   applicationid,");//EC/SI 应用的ID
		sql.append("   ecid)");//企业ID，企业移动代理服务器模式可选提供 企
		sql.append("values");
		//mysql
		sql.append("  (?, ?, ?, ?, ?, ?, ?,now(), ?, ?)");
		//oralce
		//sql.append("  (?, ?, ?, ?, ?, ?, ?,sysdate, ?, ?)");
		db.preparedInsert(sql.toString());
	
		String uuid =  orgImp.getUUID();
		db.setString(1, uuid);
		db.setString(2, extcode);//存配置文件里面去取
		db.setString(3, smsBean.getTel());//手机号码
		db.setString(4, smsBean.getContent());//短息内容
		db.setString(5, reqdeliveryreport);
		db.setString(6, msgfmt);
		db.setString(7, sendmethod);
		db.setString(8, applicationid);//存配置文件里面去取
		db.setString(9, ecid);//存配置文件里面去取
		db.executePrepared(sqlConn);	//传con	
		
	}
	/**
	 * 
	*<b>Summary: </b>
	* getConnection(请用一句话描述这个方法的作用)
	* 取数据连接
	* @return
	 * @throws Throwable 
	 */
	public Connection getConnection() throws Throwable  {
		Connection sqlConn = null;
		String smsSqlurl;
			smsSqlurl = CacheCommonManageProxy.getSystemParam("Smssqlurl");
			String Smssqlname = CacheCommonManageProxy.getSystemParam("Smssqlname");
			String Smssqlpwd = CacheCommonManageProxy.getSystemParam("Smssqlpwd");
			//mysql
			sqlConn = DbConnection.getInstrance().getMySqlConnection(smsSqlurl,Smssqlname,Smssqlpwd);
			//oralce
			//sqlConn = DBUtil.getConection();
		return sqlConn;
	}
}
