package com.chinacreator.xtbg.core.common.note.services.impl.mas2.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.note.services.impl.mas2.dao.SmsOutBoxDao;
import com.chinacreator.xtbg.core.common.note.services.impl.mas2.entity.SmsOutBoxbean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:SmsOutBoxDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-18
 */
public class SmsOutBoxDaoImpl implements SmsOutBoxDao{

	/**
	  * <b>Summary: </b>
	  *     复写方法 insertSmsOutBox
	  * @param list
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.services.impl.mas2.dao.SmsOutBoxDao#insertSmsOutBox(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean insertSmsOutBox(List<SmsOutBoxbean> list, Connection conn)
			throws SQLException {
		String sql = "insert into sms_outbox (sismsid, extcode, destaddr, messagecontent," +
				"reqdeliveryreport,msgfmt,sendmethod,requesttime,applicationid) values " +
				"(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		if(list != null && list.size() > 0){
			PreparedDBUtil pdb = new PreparedDBUtil();
			for(SmsOutBoxbean bean : list){
				pdb.preparedInsert(sql);
				pdb.setString(1, bean.getSISMSID());
				pdb.setString(2, bean.getEXTCODE());
				pdb.setString(3, bean.getDESTADDR());
				pdb.setString(4, bean.getMESSAGECONTENT());
				pdb.setString(5, bean.getREQDELIVERYREPORT());
				pdb.setString(6, bean.getMSGFMT());
				pdb.setString(7, bean.getSENDMETHOD());
				pdb.setString(8, bean.getREQUESTTIME());
				pdb.setString(9, bean.getAPPLICATIONID());
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(conn);
			return true;
		}else{
			throw new SQLException("没有要入库的短信数据");
		}
		
	}
}
