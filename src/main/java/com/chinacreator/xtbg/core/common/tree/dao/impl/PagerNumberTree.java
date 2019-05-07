package com.chinacreator.xtbg.core.common.tree.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;
public class PagerNumberTree extends TreeDataInfo {
		/**
		 * 
		  * <b>Summary: 查询用户组树</b>
		  *     复写方法 getTreeDateInfo
		  * @return
		  * @throws Exception 
		  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
		 */
		public Object getTreeDateInfo() throws Exception {
			List<Map<String, String>> list = new ArrayList<Map<String, String>>();
			String nodeId = request.getParameter("nodeId");
			if(nodeId!=null){
				return list;
			}
			PreparedDBUtil pdb = new PreparedDBUtil();
			String sql="select number_type,number_year,number_org_id from oa_word_number_def order by number_year desc,number_order";
			pdb.executeSelect(sql);
			Map<String, String> tempVal = null;
			String count="";
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
					tempVal.put("parent_id", "root");
					tempVal.put("open", "true");
					
					tempVal.put("tree_level", "2");
					
					list.add(tempVal);
				}
			}
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id","root");
				tempVal.put("name","字号库");
				tempVal.put("parent_id","");
				tempVal.put("isParent","true");
				tempVal.put("open", "true");
				list.add(tempVal);
				
			return list;
		}

}
