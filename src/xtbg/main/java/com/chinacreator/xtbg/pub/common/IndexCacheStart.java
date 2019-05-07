package com.chinacreator.xtbg.pub.common;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ThreadPoolExecutor;

import com.chinacreator.xtbg.pub.thread.LoadFristDataThread;
import com.chinacreator.xtbg.pub.thread.ThreadPoolUtils;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 开发人员姓名
 *@version 1.0
 *@date 2013-4-9
 */
public class IndexCacheStart {

	
	private static int consumeTaskSleepTime = 10;//塞任务停顿500毫秒
	
	private static ThreadPoolExecutor threadPool = ThreadPoolUtils.getInstance();
	
	public static void initIndexCache() {
		Connection conn = null;
		try {
		
			conn = DbconnManager.getInstance().getTransactionConnection();
			PreparedDBUtil pdb = new PreparedDBUtil();
			String sql = "select u.user_id,u.user_name from td_sm_user u where u.user_name != 'admin'";
			pdb.preparedSelect(sql);
			pdb.executePrepared(conn);
			
			for (int i = 0; i < pdb.size(); i++) {
				threadPool.execute(new LoadFristDataThread(pdb.getString(i, "user_id"), pdb.getString(i, "user_name")));
				Thread.sleep(consumeTaskSleepTime);
			}
		} catch (Exception e) {
			e.printStackTrace();
			DbconnManager.rollback(conn);
		} finally {
			DbconnManager.closeConnection(conn);
		}
	}

}
