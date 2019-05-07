
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     KbmDocReceiveUserServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-1   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.kbm.service.impl;

import java.sql.Connection;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocReceiveDao;
import com.chinacreator.xtbg.core.kbm.dao.impl.KbmDocReceiveDaoImpl;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocReceiverUserBean;
import com.chinacreator.xtbg.core.kbm.service.KbmDocReceiveUserService;

/**
 *<p>Title:KbmDocReceiveUserServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-1
 */
public class KbmDocReceiveUserServiceImpl implements KbmDocReceiveUserService{

	private static final Log LOG=LogFactory.getLog(KbmDocReceiveUserServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateDocReceiverUserState
	  * @param k_receiverid 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocReceiveUserService#updateDocReceiverUserState(java.lang.String) 
	  */
	@Override
	public void updateDocReceiverUserState(String k_receiverid) {
		
		Connection conn = null;
		KbmDocReceiverUserBean kbmdocreceiveruserbean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			kbmdocreceiveruserbean = new KbmDocReceiverUserBean();
			KbmDocReceiveDao kbmdocreceivedao = new KbmDocReceiveDaoImpl();
			kbmdocreceiveruserbean.setK_receiverid(k_receiverid);
			kbmdocreceiveruserbean.setK_isview("1");
			
			((BaseDao)kbmdocreceivedao).update(kbmdocreceiveruserbean, conn);//修改体系文件状态

		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		
	}

}
