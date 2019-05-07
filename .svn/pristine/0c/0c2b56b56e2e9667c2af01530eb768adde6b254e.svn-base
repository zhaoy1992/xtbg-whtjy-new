
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     Tjy_FlowInfoTree.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-24   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.process.processconfig.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:Tjy_FlowInfoTree.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-24
 */
public class Tjy_FlowInfoTree  extends TreeDataInfo{
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
		String orgid=StringUtil.deNull(request.getParameter("orgid"));
		String busitype_type_code=StringUtil.deNull(request.getParameter("busitype_type_code"));
		StringBuffer sql=new StringBuffer();
		sql.append("select * from OA_FLOW_BUSITYPE_TYPE WHERE IS_VALID = '1' AND IS_FLOW = '0' ");
		sql.append(" and busitype_type_code in ( ");
		sql.append(" select t.busitype_type_code from oa_flow_busitype t where t.busitype_code in ( ");
		sql.append(" select b.busitype_code from oa_flow_baseinfo b   ");
		if(!StringUtil.isBlank(orgid)){
			sql.append(" where b.org_id='"+orgid+"'");
		}
		sql.append(" ) ) ");
		if(!StringUtil.isBlank(busitype_type_code)){
			sql.append(" and busitype_type_code in ('"+busitype_type_code+"')");
		}
		sql.append(" ORDER BY ORDER_NO");
		pdb.executeSelect(sql.toString());
		Map<String, String> tempVal = null;
		for (int i = 0; i < pdb.size(); i++) {
			tempVal = new HashMap<String, String>();
			tempVal.put("id", pdb.getString(i, "busitype_type_code"));
			tempVal.put("item_code", pdb.getString(i,"busitype_type_code"));
			tempVal.put("org_id", pdb.getString(i,"busitype_type_code"));
			tempVal.put("name", pdb.getString(i,"busitype_type_name"));
			tempVal.put("parent_id", "");
			tempVal.put("open", "true");
			tempVal.put("icon", "../resources/plug/JQuery zTree v3.0/blue/css/zTreeStyle/img/diy/3.png");
			list.add(tempVal);
		}
		if (0 == list.size()) {
			return "";
		}

		return list;
	}
}
