package com.chinacreator.xtbg.core.kbm.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 * <p>
 * Title:KbmDocTypeTree.java
 * </p>
 * <p>
 * Description:知识库文档分类树
 * </p>
 * <p>
 * Copyright:Copyright (c) 2013
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * 
 * @author 肖杰
 * @version 1.0 2013-8-6
 */
public class KbmDocTypeTree extends TreeDataInfo {

	private List<Map<String, String>> list = new ArrayList<Map<String, String>>();

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getTreeDateInfo
	 * 
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		// UserCacheBean userBean=
		// UserCache.getUserCacheBean(accesscontroler.getUserID());
		// String k_type_unit = userBean.getUnit_id();
		String k_type_id = request.getParameter("k_type_id");
		if (k_type_id == null) {
			PreparedDBUtil pdb = new PreparedDBUtil();
			String sql = "select k_type_id,k_type_name,k_type_level,decode(k_parent_type_id,null,'0','','0',k_parent_type_id) k_parent_type_id from  oa_kbm_doc_type  order by k_type_order";
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			Map<String, String> tempVal = null;
			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "k_type_id"));
				tempVal.put("item_code", pdb.getString(i, "k_type_id"));
				tempVal.put("k_type_id", pdb.getString(i, "k_type_id"));
				tempVal.put("name", pdb.getString(i, "k_type_name"));
				tempVal.put("parent_id", pdb.getString(i, "k_parent_type_id"));
				tempVal.put("open", "true");
				if (pdb.getInt(i, "k_type_level") != 3) {
					tempVal.put("isParent", "true");
				}
				list.add(tempVal);
			}
			if (k_type_id == null) {
				// 模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "0");
				tempVal.put("item_code", "0");
				tempVal.put("k_type_id", "0");
				//特检院 OA  2014-03-18 start "知识库" 改为 "体系文件"
				//tempVal.put("name", "知识库文档分类");
				tempVal.put("name", "体系文件文档分类");
				//特检院 OA  2014-03-18 end  第一环节 不记录痕迹
				tempVal.put("parent_id", "");
				tempVal.put("isParent", "true");
				tempVal.put("open", "true");
				tempVal.put("k_type_level", "-1");
				list.add(tempVal);
			}
			if (0 == list.size()) {
				return "";
			}
			return list;
		} else {
			return "";
		}
	}
}
