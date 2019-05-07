package com.chinacreator.xtbg.core.workbench.tree;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.workbench.dao.OnlineTopDao;
import com.chinacreator.xtbg.core.workbench.dao.impl.OnlineTopDaoImpl;
import com.chinacreator.xtbg.core.workbench.entity.UserSessionBean;
import com.chinacreator.xtbg.core.workbench.session.SessionListener;

public class OnlineTree extends TreeDataInfo {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTreeDateInfo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		Connection conn = null;
		OnlineTopDao onlineTopDao = new OnlineTopDaoImpl();
		List<Map<String, String>> onlineTreeListMap = new ArrayList<Map<String, String>>();
		List<Map<String, String>> userTreeListMap = new ArrayList<Map<String, String>>();
		List<Map<String, String>> orgListMap = new ArrayList<Map<String, String>>();
		Map<String, String> tempVal = null;
		Map<String, String> treeMap = null;
		UserSessionBean userSessionBean = null;
		String onlineuserIds = "";
		String orgId = "";
		int orgOnlineCount = 0;
		
		
		 //当前在线用户数
	   List<UserSessionBean> onlineUser = new ArrayList<UserSessionBean>();
	   onlineUser = SessionListener.getOnlineUser();
	   
	   onlineTreeListMap = onlineTopDao.getOnlineTree("", conn);
	   int usernum = 0;
		if (onlineTreeListMap != null) {
			for (int i = 0; i < onlineTreeListMap.size(); ++i) {
				tempVal = new HashMap<String, String>();
				treeMap = new HashMap<String, String>();
				treeMap = onlineTreeListMap.get(i);
				String treeName = "";
				if (!StringUtil.isBlank(treeMap.get("org_name"))) {
					treeName = treeMap.get("org_name");
				} else {
					treeName = treeMap.get("remark5");
				}
				orgId = treeMap.get("org_id");
				
				if(onlineUser.size() > 0) {
					   for(int j = 0; j < onlineUser.size(); j++) {
						   userSessionBean = onlineUser.get(j);
						   if(usernum == 0) {
							   onlineuserIds += userSessionBean.getUser_id() + ",";
						   }
						   UserCacheBean userCacheBean = UserCache.getUserCacheBean(userSessionBean.getUser_id());
							   if(userCacheBean != null) {
							   String unit_ids = userCacheBean.getUnit_ids();
							   unit_ids = "," + unit_ids + ",";
							   if(unit_ids.indexOf(","+orgId+",") >= 0) {
									orgOnlineCount ++;
							   }
						   }
					   }
					   usernum = 1;
					   if(i == 0) {
						   onlineuserIds = "," + onlineuserIds;
					   }
				}
				
				tempVal.put("id", orgId);
				tempVal.put("item_code", orgId);
				tempVal.put("org_id", orgId);
				tempVal.put("name", treeName+"(在线"+orgOnlineCount+"人)");
				tempVal.put("parent_id", treeMap.get("parent_id"));
				orgOnlineCount = 0;
				orgListMap.add(tempVal);
			}
			
			userTreeListMap = onlineTopDao.getOnlineUser(conn);
			
			for (int k = 0; k < userTreeListMap.size(); k++) {
				treeMap = new HashMap<String, String>();
				tempVal = new HashMap<String, String>();
				treeMap = userTreeListMap.get(k);
				tempVal.put("id", treeMap.get("user_id"));
				tempVal.put("item_code", treeMap.get("user_id"));
				tempVal.put("org_id", treeMap.get("user_id"));
				tempVal.put("name", treeMap.get("user_realname"));
				tempVal.put("parent_id", treeMap.get("org_id"));
				if(onlineuserIds.indexOf("," + treeMap.get("user_id") + ",") >= 0) {
					tempVal.put("icon", "../../resources/style/blue/images/user_nonFolder.gif");
				} else {
					tempVal.put("icon", "../../resources/style/blue/images/userDown.gif");
				}
				orgListMap.add(tempVal);
			}
		}
	
		
		if(0 == onlineTreeListMap.size()){
			return "'none'";
		}
	
		return orgListMap;
	}

}
