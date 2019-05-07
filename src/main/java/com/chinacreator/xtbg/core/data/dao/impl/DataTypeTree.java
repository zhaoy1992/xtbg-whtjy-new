package com.chinacreator.xtbg.core.data.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import com.chinacreator.xtbg.core.common.util.DbManager;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:DataTypeTree.java</p>
 *<p>Description:资料分类树</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-19
 */
public class DataTypeTree extends TreeDataInfo {

	private List<Map<String, String>> list = new ArrayList<Map<String, String>>();
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTreeDateInfo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		String d_type_id = request.getParameter("d_type_id");
		if(d_type_id==null){
			Connection conn = null;
			try{
				UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
				String d_type_unit_id = userBean.getUnit_id();
				
				PreparedDBUtil pdb = new PreparedDBUtil();
				String sql="select d_type_id,d_type_name,d_type_level,decode(d_type_parent_id,null,'0',d_type_parent_id) d_type_parent_id from  oa_data_type  where d_type_unit_id='"+d_type_unit_id+"'  order by d_type_order";

				pdb.preparedSelect(sql.toString());
				conn = DbManager.getInstance().getConnection();
				pdb.executePrepared(conn);
				Map<String,String> tempVal = null;
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "d_type_id"));
					tempVal.put("item_code", pdb.getString(i, "d_type_id"));
					tempVal.put("d_type_id", pdb.getString(i, "d_type_id"));
					tempVal.put("name", pdb.getString(i, "d_type_name"));
					tempVal.put("parent_id", pdb.getString(i, "d_type_parent_id"));	
					tempVal.put("d_type_level", pdb.getString(i, "d_type_level"));
					tempVal.put("open", "true");
					if(pdb.getInt(i, "d_type_level")!=2){
						tempVal.put("isParent", "true");
					}
					tempVal.put("open", "true");
					
					list.add(tempVal);
				}
				
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id","Hello World!");
				tempVal.put("item_code", "0");
				tempVal.put("d_type_id", "0");
				tempVal.put("name","资料分类");
				tempVal.put("parent_id","");
				tempVal.put("isParent","true");
				tempVal.put("open", "true");
				tempVal.put("k_type_level", "-1");
				list.add(tempVal);
			}catch (Exception e) {
				e.printStackTrace();
			}finally{
				DbManager.closeConnection(conn);
			}
		}
	if(0 == list.size()){
		return "";
	}
	return list;

		
	}

}
