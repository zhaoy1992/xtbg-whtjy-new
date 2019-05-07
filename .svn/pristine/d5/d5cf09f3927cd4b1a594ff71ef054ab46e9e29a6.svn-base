package com.chinacreator.xtbg.core.common.tree.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.cache.OrgCache;
import com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean;
import com.chinacreator.xtbg.core.common.tree.entity.TreeHashMap;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:UserOrderTree.java</p>
 *<p>Description:用户排序树</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-4
 */
public class UserOrderTree extends TreeDataInfo {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTreeDateInfo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> tempVal=new HashMap<String, String>();
		String orgid=request.getParameter("orgid");
		String path=request.getContextPath();
		OrgCacheBean orgCacheBean= OrgCache.getOrgCacheBean(orgid);
		
		if(!StringUtil.isBlank(orgid)){
			tempVal = new TreeHashMap<String, String>();
			tempVal.put("id", orgCacheBean.getOrg_id());
			tempVal.put("name", orgCacheBean.getOrg_name());
			tempVal.put("item_id", orgCacheBean.getOrg_id());

			tempVal.put("org_id", orgCacheBean.getOrg_id());
			tempVal.put("parent_id", orgCacheBean.getParent_id());
			tempVal.put("deptType", orgCacheBean.getOrg_level());
			tempVal.put("open", "true");
			list.add(tempVal);
		}
		String sql="select a.*,'"+orgid+"' as org_id, getUserorgjobinfos(to_char(a.user_id) || '') as org_job,"
        +"(SELECT MIN(same_job_user_sn) y FROM td_sm_userjoborg WHERE org_id = '"+orgid+"'"
        +"  and user_id = a.user_id) y from td_sm_user a where a.user_id in "
        +"(select distinct user_id from td_sm_userjoborg where org_id = '"+orgid+"') order by y, a.user_id";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i=0;i<pdb.size();i++) {
			tempVal = new TreeHashMap<String, String>();
			tempVal.put("id", pdb.getString(i, "user_id"));
			tempVal.put("name",pdb.getString(i, "user_realname"));
			tempVal.put("parent_id",orgid);
			tempVal.put("item_id",pdb.getString(i, "user_id"));
			tempVal.put("user_id", pdb.getString(i, "user_id"));
			tempVal.put("item_code",pdb.getString(i, "user_name"));
			tempVal.put("user_mobiletel1",pdb.getString(i, "user_mobiletel1"));
			tempVal.put("icon",path+"/ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
			list.add(tempVal);
		}
		if (0 == list.size()) {
			return "'none'";
		}
		
		return list;
	}

}
