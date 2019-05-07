package com.chinacreator.xtbg.core.common.tree.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.sysmgrcore.entity.Organization;
import com.chinacreator.sysmgrcore.manager.db.OrgCacheManager;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:PurviewOrgTree.java</p>
 *<p>Description:查询系统管理的机构树</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-16
 */
public class PurviewOrgTree extends TreeDataInfo{

	private List<Map<String, String>> list = new ArrayList<Map<String, String>>();
	/**
	 * 
	  * <b>Summary:查询系统管理的机构树 </b>
	  *     复写方法 getTreeDateInfo
	  * @return 
	 * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
			String attriOrgId = (String) request.getAttribute("org_id");
			
			String org_id = StringUtil.deNull(request.getParameter("org_id"));
			if(StringUtil.isBlank(org_id)) {
				org_id = StringUtil.deNull(request.getParameter("toporgId"));
			}
			
			if(!StringUtil.isBlank(attriOrgId)) {
				org_id = attriOrgId;
			}
			String orgids = ","+(String) request.getParameter("orgids")+",";
			List orglist = OrgCacheManager.getInstance().getSubOrganizations(org_id);//从平台缓存只取出数据
			Map<String,String> tempVal = null;
			if (orglist != null) {
				for (int i = 0; i < orglist.size(); ++i) {
					tempVal = new HashMap<String, String>();
					Organization sonorg = (Organization)orglist.get(i);
					String treeName = "";
//					if ((sonorg.getRemark5() == null) || (sonorg.getRemark5().trim().equals(""))) {
//						treeName = sonorg.getOrgName();
//					} else {
//						treeName = sonorg.getRemark5();
//					}
					treeName = sonorg.getOrgName();
					String orgId = sonorg.getOrgId();
					tempVal.put("id", orgId);
					tempVal.put("item_code", orgId);
					tempVal.put("org_id", orgId);
					tempVal.put("name", treeName);
					tempVal.put("parent_id", sonorg.getParentId());
					tempVal.put("deptType",  sonorg.getRemark4());
					tempVal.put("org_xzqm", sonorg.getOrg_xzqm());
					//if(orgids.indexOf(","+orgId+",") >= 0) {
					if(orgids.equals(",,")||orgids.indexOf(","+orgId+",") >= 0) {
						tempVal.put("open", "true");
					} 
					if(OrgCacheManager.getInstance().hasSubOrg(orgId)) {
						getSonOrg(orgId);
						tempVal.put("isParent",  "true");
					}
					list.add(tempVal);
				}
			}
		
			if(0 == list.size()){
				return "";
			}
		
			return list;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getSonOrg(获得子机构的节点)
	* @param orgId
	* @throws Exception
	 */
	public void getSonOrg(String orgId) throws Exception {
		request.setAttribute("org_id", orgId);
		getTreeDateInfo();
	}

}
