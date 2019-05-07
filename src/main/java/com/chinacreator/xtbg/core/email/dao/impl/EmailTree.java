package com.chinacreator.xtbg.core.email.dao.impl;

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
 *<p>Title:EmailTree.java</p>
 *<p>Description:邮件树</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-18
 */
public class EmailTree extends TreeDataInfo {
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
		String menu_id = request.getParameter("menu_id");
		if(menu_id==null){
			Connection conn = null;
			try{
				PreparedDBUtil pdb = new PreparedDBUtil();
				String sql="select menu_id,menu_name,menu_parentid,menu_remark from  oa_mail_menu ";

				pdb.preparedSelect(sql.toString());
				conn = DbManager.getInstance().getConnection();
				pdb.executePrepared(conn);
				Map<String,String> tempVal = null;
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "menu_id"));
					tempVal.put("item_code", pdb.getString(i, "menu_id"));
					tempVal.put("menu_id", pdb.getString(i, "menu_id"));
					tempVal.put("name", pdb.getString(i, "menu_name"));
					tempVal.put("menu_remark", pdb.getString(i, "menu_remark"));
					tempVal.put("parent_id", pdb.getString(i, "menu_parentid"));	
					tempVal.put("open", "true");
					
					list.add(tempVal);
				}
				
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
