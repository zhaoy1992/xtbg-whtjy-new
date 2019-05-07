
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PsdataTypeTree.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-12   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.persondata.dao.imploracle;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:PsdataTypeTree.java</p>
 *<p>Description:资料分类树</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-12
 */
public class PsdataTypeTree extends TreeDataInfo{
	
	private List<Map<String, String>> list = new ArrayList<Map<String, String>>();
     /**
	  * <b>Summary: </b> 复写方法 getTreeDateInfo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		
		UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
		//获取单位ID
		String p_type_unit = userBean.getUnit_id();
		//获取主键ID
		String p_type_id = request.getParameter("p_type_id");
		//当前用户ID
		String userId =accesscontroler.getUserID();
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select p_type_id,");
		sql.append("       p_type_name,");
		sql.append("       p_type_unit,");
		sql.append("       decode(p_type_parentid,null,'Hello World!','','Hello World!',p_type_parentid) p_type_parentid ,");
		sql.append("       p_type_order,");
		sql.append("       p_remark,");
		sql.append("       p_creater_userid,");
		sql.append("       p_creater_username,");
		sql.append("       p_creater_time");
		sql.append("  from oa_persondata_type");
		sql.append("  where p_type_unit='"+p_type_unit+"' and p_creater_userid='"+userId+"' order by  p_type_order ");

		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		Map<String,String> tempVal = null;
		for (int i = 0; i < pdb.size(); i++) {
			tempVal = new HashMap<String, String>();
			tempVal.put("id", pdb.getString(i, "p_type_id"));
			tempVal.put("item_code", pdb.getString(i, "p_type_id"));
			tempVal.put("p_type_id", pdb.getString(i, "p_type_id"));
			tempVal.put("name", pdb.getString(i, "p_type_name"));
			tempVal.put("parent_id", pdb.getString(i, "p_type_parentid"));	
			tempVal.put("open", "true");
			list.add(tempVal);
		}
		if(p_type_id==null){
			//模拟根节点
			tempVal = new HashMap<String, String>();
			tempVal.put("id","");
			tempVal.put("item_code", "0");
			tempVal.put("p_type_id", "0");
			tempVal.put("name","资料分类");
			tempVal.put("parent_id","");
			tempVal.put("isParent","true");
			tempVal.put("open", "true");
			list.add(tempVal);
		}
		if(0 == list.size()){
			return "";
		}
		return list;
	}

}
