package com.chinacreator.xtbg.core.pubconfig.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FlowBusiTypeTree.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-9-13
 */
public class FlowBusiTypeTree extends TreeDataInfo {

	/**
	 * 
	  * <b>Summary:查询业务类型分类列表 </b>
	  *     复写方法 getTreeDateInfo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String sql="select * from OA_FLOW_BUSITYPE_TYPE ORDER BY ORDER_NO";
		pdb.executeSelect(sql);
		Map<String, String> tempVal = null;
		for (int i = 0; i < pdb.size(); i++) {
			tempVal = new HashMap<String, String>();
			tempVal.put("id", pdb.getString(i, "busitype_type_code"));
			tempVal.put("item_code", pdb.getString(i,"busitype_type_code"));
			tempVal.put("org_id", pdb.getString(i,"busitype_type_code"));
			tempVal.put("name", pdb.getString(i,"busitype_type_name"));
			tempVal.put("parent_id", "");
			tempVal.put("open", "true");
			tempVal.put("icon", "../../resources/plug/JQuery zTree v3.0/blue/css/zTreeStyle/img/diy/2.png");
			list.add(tempVal);
		}
		if (0 == list.size()) {
			return "";
		}

		return list;
	}

}