package com.chinacreator.xtbg.pub.sms.dao.impl;

import java.sql.SQLException;

import com.chinacreator.xtbg.pub.sms.dao.SmsSendDaoImplYMJ;
import com.chinacreator.xtbg.pub.sms.entity.SmsBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class SmsSendDao implements SmsSendDaoImplYMJ{

	@Override
	public boolean smsSendDao(SmsBean smsBean) {
		boolean flag = false;
		PreparedDBUtil  pdb = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into  ");
		sql.append("   T_SendTask ( TaskID,DestNumber,Content )");
		sql.append("   values( SEQ_T_SendTask.nextval,?,? ) ");
		try {
			if(!StringUtil.isBlank(smsBean.getRECEIVERMOBILENO())){
				pdb.preparedInsert(sql.toString());
				pdb.setString(1,smsBean.getRECEIVERMOBILENO());
				pdb.setString(2,smsBean.getMSG());
				pdb.executePrepared();
			}
			if(!StringUtil.isBlank(smsBean.getRECEIVERMOBILENOOne())){
				pdb.preparedInsert(sql.toString());
				pdb.setString(1,smsBean.getRECEIVERMOBILENOOne());
				pdb.setString(2,smsBean.getMSG());
				pdb.executePrepared();
			}
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
			flag = false;
		}
		return flag;
	}
	
}
