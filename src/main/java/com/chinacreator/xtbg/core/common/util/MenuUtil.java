package com.chinacreator.xtbg.core.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinacreator.framework.Item;
import com.chinacreator.framework.ItemQueue;
import com.chinacreator.framework.MenuHelper;
import com.chinacreator.framework.Module;
import com.chinacreator.framework.ModuleQueue;
import com.chinacreator.security.AccessControl;

/**
 * 
 *<p>Title:MenuUtil.java</p>
 *<p>Description:菜单工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-10-10
 */
public class MenuUtil {
	
	/**
	 * 
	*<b>Summary: </b>
	* getFristMenus(获取当前用户的所有授权的一级菜单列表)
	* @param request
	* @param response
	* @return
	 */
	public List<Map<String, String>> getMenus(HttpServletRequest request, HttpServletResponse response) {
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		
		MenuHelper menuHelper = new MenuHelper(control);
		String contextPath = request.getContextPath();
		
		List<Map<String, String>> nodes = new ArrayList<Map<String, String>>();
		addNode("$root", "", menuHelper, contextPath, nodes);
		
		return nodes;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* addNode(获取当前用户的指定菜单模块下的授权菜单列表)
	* @param pModuleId
	* @param moduleId
	* @param menuHelper
	* @param contextPath
	* @param nodes
	 */
	public void addNode(String pModuleId, String moduleId, MenuHelper menuHelper, String contextPath, List<Map<String, String>> nodes) {
		Map<String, String> node = null;
		String modulePath = "module::menu://sysmenu"+pModuleId;
		ModuleQueue moduleQueue = menuHelper.getSubModules(modulePath);
		for(int k=0; moduleQueue!=null&&k<moduleQueue.size(); k++){
			Module module = moduleQueue.getModule(k);
			if(!module.isUsed()){
				continue;
			}
			
			node = new HashMap<String, String>();
			node.put("id", module.getId());
			node.put("name", module.getName());
			node.put("pid", moduleId);
			
			String icon = module.getMouseclickimg()==null ? "func_an1" : module.getMouseclickimg();
			String description = module.getDescription();
			System.out.println(description);
			String headimg = module.getHeadimg();
			
			node.put("icon", icon);
			node.put("url", "");
			node.put("nType", "module");
			node.put("nocheck", "true");
			node.put("description", description);
			node.put("headimg", headimg);
			nodes.add(node);
			addNode(pModuleId+"/"+module.getId()+"$module", module.getId(), menuHelper, contextPath, nodes);
		}
		
		ItemQueue itemQueue = menuHelper.getSubItems(modulePath);
		for (int i=0; i<itemQueue.size(); i++) {
			Item item = itemQueue.getItem(i);
			if(!item.isUsed()){
				continue;
			}
			
			String description = "";
			String headimg = item.getHeadimg();
			
			node = new HashMap<String, String>();
			node.put("id", item.getId());
			node.put("name", item.getName());
			node.put("pid", moduleId);
			node.put("icon", "");
			node.put("url", contextPath+"/"+item.getWorkspaceContent());
			node.put("nType", "item");
			node.put("description", description);
			node.put("headimg", headimg);
			nodes.add(node);
		}
	}

}
