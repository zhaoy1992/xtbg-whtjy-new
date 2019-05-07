package com.chinacreator.xtbg.core.common.tree.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 办公用品分类表
 * @author 王淑滨
 *
 */
public class OsupplieTypeTree extends TreeDataInfo{

	@Override
	public Object getTreeDateInfo() throws Exception {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String oftype_id = request.getParameter("nodeId");
		UserCacheBean u = UserCache.getUserCacheBean(accesscontroler.getUserID());
		String jigoubianhao = u.getUnit_id();
		if(oftype_id!=null){
			return list;
		}
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select a.oftype_id, a.oftype_name, a.parent_id from TA_OA_OSUPPLIETYPE a");
		//sql.append("   where a.unit_id = '"+jigoubianhao+"'");
		sql.append("  order by a.oftype_no");
		pdb.executeSelect(sql.toString());
		Map<String, String> tempVal = null;
		for (int i = 0; i < pdb.size(); i++) {
			tempVal = new HashMap<String, String>();
			tempVal.put("id", pdb.getString(i, "oftype_id"));
			tempVal.put("name", pdb.getString(i, "oftype_name"));
			tempVal.put("parent_id", pdb.getString(i, "parent_id"));
			tempVal.put("open", "true");
			list.add(tempVal);
		}
		return list;
	}

}
