package com.chinacreator.xtbg.core.businessclassmanager.dao.impl;

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
 *<p>Title:FormClassTree.java</p>
 *<p>Description:业务类型树</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-30
 */
public class FormClassTree extends TreeDataInfo {

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
		String ec_id = request.getParameter("ec_id");
		if(ec_id==null){
			Connection conn = null;
			try{
				PreparedDBUtil pdb = new PreparedDBUtil();
				String sql="Select * from tb_form_class  order by ec_sn";

				pdb.preparedSelect(sql);
				conn = DbManager.getInstance().getConnection();
				pdb.executePrepared(conn);
				Map<String,String> tempVal = null;
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ec_id"));
					tempVal.put("item_code", pdb.getString(i, "ec_id"));
					tempVal.put("ec_id", pdb.getString(i, "ec_id"));
					tempVal.put("name", pdb.getString(i, "ec_name"));
					tempVal.put("parent_id", pdb.getString(i, "ec_upid"));	
					tempVal.put("open", "true");
					
					list.add(tempVal);
				}
				
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id","0");
				tempVal.put("item_code", "0");
				tempVal.put("ec_id", "0");
				tempVal.put("name","业务类别");
				tempVal.put("parent_id","");
				tempVal.put("open", "true");
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
