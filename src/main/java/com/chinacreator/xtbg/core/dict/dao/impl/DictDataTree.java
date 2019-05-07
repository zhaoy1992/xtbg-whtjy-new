package com.chinacreator.xtbg.core.dict.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:DictDataTree.java</p>
 *<p>Description:字典数据树</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-24
 */
public class DictDataTree extends TreeDataInfo {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTreeDateInfo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String orgid=request.getParameter("orgid");
		String sql="select * from  oa_dict_data  where dict_id='"+orgid+"' order by dictdata_order";
		
		pdb.executeSelect(sql);
		Map<String, String> tempVal = null;
		for (int i = 0; i < pdb.size(); i++) {
			tempVal = new HashMap<String, String>();
			tempVal.put("id", pdb.getString(i, "dictdata_id"));
			tempVal.put("item_code", pdb.getString(i,"dictdata_id"));
			tempVal.put("org_id", pdb.getString(i,"dictdata_id"));
			tempVal.put("name", pdb.getString(i,"dictdata_name"));
			tempVal.put("parent_id", pdb.getString(i,"dictdata_parent_id"));
			tempVal.put("open", "true");
			list.add(tempVal);
		}
		if (0 == list.size()) {
			return "";
		}

		return list;
	}

}
