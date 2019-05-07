package com.chinacreator.xtbg.core.wordnumdef.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:WordNumTree.java</p>
 *<p>Description:文号维护树实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-17
 */
public class WordNumTree extends TreeDataInfo {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTreeDateInfo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String d_type_id = request.getParameter("number_type");
		if(d_type_id==null){
			Connection conn = null;
			try{
				/*UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
				String d_type_unit_id = userBean.getUnit_id();*/
				
				PreparedDBUtil pdb = new PreparedDBUtil();
				String sql="select number_type,number_year from oa_word_number_def order by number_year desc,number_order";

				pdb.preparedSelect(sql.toString());
				conn = DbManager.getInstance().getConnection();
				pdb.executePrepared(conn);
				String count="";
				Map<String,String> tempVal = null;
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "number_type"));
					tempVal.put("name", pdb.getString(i, "number_type"));
					tempVal.put("parent_id", pdb.getString(i, "number_year"));
					tempVal.put("open", "true");
					
					tempVal.put("tree_level", "3");
					
					list.add(tempVal);
					if(!pdb.getString(i, "number_year").equals(count) ){
						count=pdb.getString(i, "number_year");
						tempVal = new HashMap<String, String>();
						tempVal.put("id", count);
						tempVal.put("name", count);
						tempVal.put("parent_id", "字号维护");
						tempVal.put("open", "true");
						
						tempVal.put("tree_level", "2");
						
						list.add(tempVal);
					}
				}
				
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id","字号维护");
				tempVal.put("name","字号维护");
				tempVal.put("parent_id","");
				tempVal.put("open", "true");
				
				tempVal.put("tree_level", "1");
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
