package com.chinacreator.xtbg.core.kbm.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.kbm.dao.WorkbenchDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:WorkbenchDaoImpl.java</p>
 *<p>Description:知识库dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-8-16
 */
public class WorkbenchDaoImpl implements WorkbenchDao{

	/**
	  * <b>Summary: </b>
	  *     复写方法 queryUserData
	  * @param sql
	  * @param params
	  * @param dbColumns
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.workbench.dao.WorkbenchDao#queryUserData(java.lang.String, java.util.List, java.util.List, java.sql.Connection)
	 */
	@Override
	public List<Map<String, String>> queryUserData(String sql,
			List<String> params, List<String> dbColumns,int maxRownum, Connection conn)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql,0,maxRownum);
		int i = 1;
		for(String param : params){//设置查询参数
			pdb.setString(i, param);
			i++;
		}
		pdb.executePrepared(conn);
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		if(pdb.size() > 0){
			for(int j = 0 ; j < pdb.size() ; j++){//遍历查询出的每行数据
				Map<String, String> map = new HashMap<String, String>();
				for(String column : dbColumns){//遍历每行中的字段
					map.put(column, pdb.getString(j, column));
				}
				list.add(map);
			}
		}
		return list;
	}

	
}
