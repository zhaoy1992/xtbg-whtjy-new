package com.chinacreator.xtbg.core.archive.service.impl;

import java.sql.Connection;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.archive.service.WorkCountService;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowInstanceDataSaveDaoImpl;

/**
 *<p>Title:WorkCountServiceImpl.java</p>
 *<p>Description:发文登记薄 业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2014-6-10
 */
public class WorkCountServiceImpl implements WorkCountService{
	
	private static final Log LOG = LogFactory.getLog(WorkCountServiceImpl.class);
	
	@Override
	public boolean sendToFileByInsId(String userId, String insId) {
		Connection conn = null;
		boolean flag = false;
		try {
			String [] insIds = insId.split(",");
			conn = DbManager.getInstance().getTransactionConnection();
			FlowInstanceDataSaveDaoImpl dao = new FlowInstanceDataSaveDaoImpl();
			for (String ids : insIds) {
				dao.sendToFileByInsId(userId, ids, conn);
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
		
}
