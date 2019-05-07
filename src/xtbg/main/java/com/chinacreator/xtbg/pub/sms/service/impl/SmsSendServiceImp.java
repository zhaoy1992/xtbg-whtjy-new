package com.chinacreator.xtbg.pub.sms.service.impl;


import com.chinacreator.xtbg.pub.sms.dao.SmsSendDaoImplYMJ;
import com.chinacreator.xtbg.pub.sms.dao.SmsSenddao;
import com.chinacreator.xtbg.pub.sms.dao.impl.SmsSenddaoImp;
import com.chinacreator.xtbg.pub.sms.entity.SmsBean;
import com.chinacreator.xtbg.pub.sms.service.SmsSendService;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
public class SmsSendServiceImp implements SmsSendService{

	@Override
	public boolean sendSms(SmsBean smsBean) throws Exception {
		SmsSenddao smsSenddao = new SmsSenddaoImp();
		return smsSenddao.sendSms(smsBean);
	}

	@Override
	public boolean sendSmsymj(SmsBean smsBean) throws Exception {
		boolean flag = false ;
		SmsSendDaoImplYMJ dao = (SmsSendDaoImplYMJ)DaoImplClassUtil.getDaoImplClass("SmsSendDaoImplYMJ");
		flag = dao.smsSendDao(smsBean);
		return flag;
	}
	
}
