package com.chinacreator.xtbg.core.kbm.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.kbm.cache.KbmConfCache;
import com.chinacreator.xtbg.core.kbm.entity.ItemValueBean;
import com.chinacreator.xtbg.core.kbm.entity.ShowItemBean;
import com.chinacreator.xtbg.core.kbm.entity.ShowItemDataBean;
import com.chinacreator.xtbg.core.kbm.entity.ShowItemDetailDataBean;
import com.chinacreator.xtbg.core.kbm.service.WorkbenchService;
import com.chinacreator.xtbg.core.kbm.service.impl.WorkbenchServiceImpl;
import com.chinacreator.xtbg.core.kbm.util.KbmConstants;
/**
 * 
 *<p>Title:KbmServlet.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-8-15
 */
public class KbmServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	private static final Log LOG = LogFactory.getLog(KbmServlet.class);
	
	private String path = "";//系统上下文目录

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		AccessControl accesscontroler = AccessControl.getAccessControl();
		if(!accesscontroler.checkAccess(request, response)){
			return;
		}
		path = request.getContextPath();
		
		String action = request.getParameter("action");//获取数据的操作类型
		String userID = accesscontroler.getUserID();
		String resultJson = "";
		if(KbmConstants.SHOW_ITEM_ACTION.equals(action)){//获取展示栏数据操作类型
			String itemID = request.getParameter("itemID");
			resultJson = showItemAction(itemID, userID);
		}else{
			LOG.error("知识库没有你要请求的类型--->"+action);
		}
		//LOG.info(resultJson);
		responseProcess(resultJson, response);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}
	
	
	/**
	*<b>Summary: </b>
	* showItemAction(获取展示栏数据操作类型)
	* @param itemID
	* @param userID
	* @return
	 */
	private String showItemAction(String itemID, String userID){
		WorkbenchService workbenchService = new WorkbenchServiceImpl();
		List<Map<String, String>> resList = workbenchService.queryUserData(itemID, userID);//查询数据
		ShowItemBean showItemBean = KbmConfCache.getShowItemMap().get(itemID);//模块配置信息
		ShowItemDataBean showItemDataBean = new ShowItemDataBean();
		showItemDataBean.setItemID(showItemBean.getId());
		showItemDataBean.setShowMaxRowNum(showItemBean.getMaxRownum());
		
		String[] showColumns = showItemBean.getShowColumns().split(",");
		String[] realShowColumns = showItemBean.getRealShowColumns().split(",");
		String[] urlParamColumns = showItemBean.getUrlParamColumns().split(",");
		String showColumnsTitle = showItemBean.getShowColumnsTitle();
		String showColumnsTileLocation = showItemBean.getShowColumnsTileLocation();
		String columnsWidths = showItemBean.getColumnsWidth();
		showItemDataBean.setShowTypeCount(showColumns.length);//显示字段的个数
		showItemDataBean.setShowColumnsTitle(showColumnsTitle);
		showItemDataBean.setShowColumnsTileLocation(showColumnsTileLocation);
		showItemDataBean.setCloumnWidth(columnsWidths);
		
		String dynamicUrlColumns = showItemBean.getDynamicUrlColumns();//动态url地址字段名称
		for(Map<String, String> dateMap : resList){
			ShowItemDetailDataBean showItemDetailDataBean = new ShowItemDetailDataBean();
			
			String clickUrl = path+showItemBean.getClickurl();
			if(!"".equals(dynamicUrlColumns) && dateMap.containsKey(dynamicUrlColumns) && !"".equals(dateMap.get(dynamicUrlColumns))){//有动态连接地址
				clickUrl =  path+dateMap.get(dynamicUrlColumns);
			}
			if(clickUrl.indexOf("?") == -1) {
				clickUrl = clickUrl+"?1=1";
			}
			
			for(int i=0;i<showColumns.length;i++){
				ItemValueBean bean = new ItemValueBean();
				bean.setValue(dateMap.get(showColumns[i]));//真实值
				bean.setShowValue(dateMap.get(realShowColumns[i]));//显示值
				showItemDetailDataBean.setValue(bean);
			}
			
			for(String column : urlParamColumns){
				String value = "";
				if(dateMap.get(column) != null){
					value = dateMap.get(column).trim();
				}
				String param = "&"+column+"="+value;
				clickUrl += param;
			}
			showItemDetailDataBean.setClickUrl(clickUrl);
			showItemDetailDataBean.setCloumnWidth(columnsWidths);
			
			showItemDataBean.setShowItemDetailDataBean(showItemDetailDataBean);
		}
		return JSONObject.toJSON(showItemDataBean).toString();
	}
	
	/**
	*<b>Summary: </b>
	* responseProcess(页面响应处理方法)
	* @param resultJson
	* @param resp
	*/
	private void responseProcess(String resultJson,HttpServletResponse resp){
		resp.setContentType("text/plain; charset=UTF-8");
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setDateHeader("Expires", 0);
		PrintWriter write;
		try {
			write = resp.getWriter();
			write.print(resultJson);
			write.flush();
			write.close();
		} catch (IOException e) {
			LOG.error(e.getMessage());
		}
	}
}
