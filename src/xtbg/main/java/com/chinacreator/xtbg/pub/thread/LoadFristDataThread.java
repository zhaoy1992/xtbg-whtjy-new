package com.chinacreator.xtbg.pub.thread;

import java.sql.SQLException;
import java.util.HashMap;

import com.chinacreator.xtbg.pub.common.IndexCache;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 开发人员姓名
 *@version 1.0
 *@date 2013-4-9
 */
public class LoadFristDataThread implements Runnable {
	
	private String user_id; 
	
	private String user_name; 
	
	public LoadFristDataThread(String user_id, String user_name){
		this.user_id = user_id;
		this.user_name = user_name;

	}
	@Override
	public void run() {
		HashMap<String, Object> result = new HashMap<String, Object>();
		try {
			result = IndexCache.queryUserIndexData(user_id, user_name);
			IndexCache.setUserIndexMap(user_id, result);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
}
