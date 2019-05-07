package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FileStorageLocationTree.java</p>
 *<p>Description:档案存放位置树</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-24
 */
public class FileStorageLocationTree extends TreeDataInfo {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTreeDateInfo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		String f_storage_id=request.getParameter("f_storage_id");
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		if(StringUtil.isBlank(f_storage_id)){
			String f_org_id =UserCache.getUserCacheBean(accesscontroler.getUserID()).getUnit_id();
			PreparedDBUtil pdb = new PreparedDBUtil();
			String sql="select * from  oa_file_storage_location where f_org_id='"+f_org_id+"' order by f_order_num";
					
			pdb.executeSelect(sql);
			Map<String, String> tempVal = null;
					//if(pdb.size()>0){
			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "f_storage_id"));
				tempVal.put("item_code", pdb.getString(i,"f_storage_id"));
				tempVal.put("org_id", pdb.getString(i,"f_storage_id"));
				tempVal.put("name", pdb.getString(i,"f_storage_shotname"));
				tempVal.put("parent_id", pdb.getString(i,"f_perant_id"));
				tempVal.put("open", "true");
				list.add(tempVal);
				}
				//	}
			//模拟根节点
			tempVal = new HashMap<String, String>();
			tempVal.put("id","0");
			tempVal.put("item_code", "0");
			tempVal.put("org_id", "0");
			tempVal.put("name","档案存放位置");
			tempVal.put("parent_id","-1");
			tempVal.put("isParent","true");
			tempVal.put("open", "true");
			list.add(tempVal);
		}
		if (0 == list.size()) {
			return "";
		}
		
		return list;
	}

}
