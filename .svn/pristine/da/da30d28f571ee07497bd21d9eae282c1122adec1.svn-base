package com.chinacreator.xtbg.pub.sms.dao.impl;

import java.sql.Connection;
import java.util.HashMap;
import com.chinacreator.security.AccessControl;
import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl;
import com.chinacreator.xtbg.pub.ema6.InvokeEMA6NoteWebService;
import com.chinacreator.xtbg.pub.ema6.MtMessage;
import com.chinacreator.xtbg.pub.sms.dao.SmsSenddao;
import com.chinacreator.xtbg.pub.sms.entity.SmsBean;
import com.chinacreator.xtbg.pub.util.DbConnection;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
public class SmsSenddaoImp implements SmsSenddao{
	private String userArea = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	@Override
	public boolean sendSms(SmsBean smsBean)  throws Exception{
		InvokeEMA6NoteWebService service =  null;
		MtMessage message = null;
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer strbu =new StringBuffer();
		
		String extcode = CacheCommonManageProxy.getSystemParam("extcode");
		String reqdeliveryreport = CacheCommonManageProxy.getSystemParam("reqdeliveryreport");
		String msgfmt = CacheCommonManageProxy.getSystemParam("msgfmt");
		String sendmethod = CacheCommonManageProxy.getSystemParam("sendmethod");
		String applicationid = CacheCommonManageProxy.getSystemParam("applicationid");
		String ecid = CacheCommonManageProxy.getSystemParam("ecid");
		//怀化
		String endpoint =  CacheCommonManageProxy.getSystemParam("hh_tele_url");
//		String account  =  CacheCommonManageProxy.getSystemParam("hh_tele_user");
//		String password  =  CacheCommonManageProxy.getSystemParam("hh_tele_password");
//		String orgCode  =  CacheCommonManageProxy.getSystemParam("hh_tele_orgCode");
		String hh_app_code  = CacheCommonManageProxy.getSystemParam("hh_app_code");
		//如果是怀化那就做webservice接口
		if(("421004").equals(StringUtil.deNull(userArea))){
			 AccessControl accesscontroler = AccessControl.getAccessControl();
			 String sendUserName = accesscontroler.getUserAccount();//当前发送人 登录名
			 HashMap<String,String> sendSmsMap = querySmsByUserName(sendUserName);
			 service =  new  InvokeEMA6NoteWebService(endpoint, 
					 								  StringUtil.deNull(sendSmsMap.get("sendaccount")), 
					 								  StringUtil.deNull(sendSmsMap.get("sendpassword")));
					 								 //StringUtil.deNull(sendSmsMap.get("sendorgcode"))); 
			 message = new MtMessage();
			 message.setContent(smsBean.getContent());
			 if(!StringUtil.isBlank(smsBean.getTel())){
				 strbu.append(smsBean.getTel()).append(";");
				 message.setPhoneNumber(strbu.toString().split(";"));
				 message.setSubCode(smsBean.getSubCode());
			 }
			service.sendSms(message);
		}else if(("430800").equals(StringUtil.deNull(userArea))||("421003").equals(StringUtil.deNull(userArea))){
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
		return true;
		}
		
	
	public Connection getConnection()  {
		Connection sqlConn = null;
		String smsSqlurl;
		try {
			smsSqlurl = CacheCommonManageProxy.getSystemParam("Smssqlurl");
			String Smssqlname = CacheCommonManageProxy.getSystemParam("Smssqlname");
			String Smssqlpwd = CacheCommonManageProxy.getSystemParam("Smssqlpwd");
			//mysql
			sqlConn = DbConnection.getInstrance().getMySqlConnection(smsSqlurl,Smssqlname,Smssqlpwd);
			//oralce
			//sqlConn = DBUtil.getConection();
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
	
		return sqlConn;
	}
	
	/**
	*<b>Summary: </b>
	* querySmsByUserName(怀化短信发送  根据当前用户登录名 查询机构的子码和发送短信帐号和密码)
	* @param userName
	* @return
	* @throws Exception
	 */
	public HashMap<String,String> querySmsByUserName(String userName) throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append("select org.sendaccount,org.sendpassword,org.sendorgcode");
		sql.append("  from td_sm_user t, td_sm_orguser o, ta_oa_organdtype org");
		sql.append(" where t.user_id = o.user_id");
		sql.append("   and o.org_id = org.org_id");
		sql.append("   and t.user_name = ?");
		sql.append("");
		PreparedDBUtil db = new PreparedDBUtil();
		HashMap<String,String> sendSmsMap = new HashMap<String,String>();
		db.preparedSelect(sql.toString()); 
		db.setString(1, userName);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			sendSmsMap.put("sendaccount",db.getString(i, "sendaccount"));
			sendSmsMap.put("sendpassword",db.getString(i, "sendpassword"));
			sendSmsMap.put("sendorgcode",db.getString(i, "sendorgcode"));
		}
		return sendSmsMap;
	}

}
