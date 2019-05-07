package com.chinacreator.xtbg.core.common.tree.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 固定资产分类树
 * @author 王淑滨
 *
 */
public class AccountTypeTree extends TreeDataInfo{

	@Override
	public Object getTreeDateInfo() throws Exception {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String type = request.getParameter("type");
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select d.dictdata_id, d.dictdata_name");
		sql.append("  from oa_dict_data d, oa_dict_type t");
		sql.append(" where t.dict_id = d.dict_id");
		sql.append("   and d.dictdata_is_valid = '1'");
		sql.append("   and t.dict_is_valid = '1'");
		sql.append("   and t.dict_code = '"+type+"'");
		sql.append(" order by d.dictdata_order");
		pdb.executeSelect(sql.toString());
		Map<String, String> tempVal = null;
		for (int i = 0; i < pdb.size(); i++) {
			tempVal = new HashMap<String, String>();
			tempVal.put("id", pdb.getString(i, "dictdata_id"));
			tempVal.put("name", pdb.getString(i, "dictdata_name"));
			tempVal.put("open", "true");
			list.add(tempVal);
		}
		return list;
	}

}
