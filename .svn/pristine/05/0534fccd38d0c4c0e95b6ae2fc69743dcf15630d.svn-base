package com.chinacreator.xtbg.core.common.tree.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class PurviewGroupTree extends TreeDataInfo {

	/**
	 * 
	  * <b>Summary: 查询用户组树</b>
	  *     复写方法 getTreeDateInfo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String sql="select * from  td_sm_group  order by group_id";
		
		pdb.executeSelect(sql);
		Map<String, String> tempVal = null;
		for (int i = 0; i < pdb.size(); i++) {
			tempVal = new HashMap<String, String>();
			tempVal.put("id", pdb.getString(i, "group_id"));
			tempVal.put("item_code", pdb.getString(i,"group_id"));
			tempVal.put("org_id", pdb.getString(i,"group_id"));
			tempVal.put("name", pdb.getString(i,"group_name"));
			tempVal.put("parent_id", pdb.getString(i,"parent_id"));
			tempVal.put("open", "true");
			list.add(tempVal);
		}
		if (0 == list.size()) {
			return "";
		}

		return list;
	}

}
