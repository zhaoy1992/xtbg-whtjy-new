package com.chinacreator.xtbg.core.workbench.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.workbench.cache.WorkbenchConfCache;
import com.chinacreator.xtbg.core.workbench.cache.WorkbenchUserCache;
import com.chinacreator.xtbg.core.workbench.entity.ItemValueBean;
import com.chinacreator.xtbg.core.workbench.entity.PendingBean;
import com.chinacreator.xtbg.core.workbench.entity.PendingItemBean;
import com.chinacreator.xtbg.core.workbench.entity.ShowItemBean;
import com.chinacreator.xtbg.core.workbench.entity.ShowItemDataBean;
import com.chinacreator.xtbg.core.workbench.entity.ShowItemDetailDataBean;
import com.chinacreator.xtbg.core.workbench.services.WorkbenchService;
import com.chinacreator.xtbg.core.workbench.services.impl.WorkbenchServiceImpl;
import com.chinacreator.xtbg.core.workbench.session.SessionListener;
import com.chinacreator.xtbg.core.workbench.support.WorkbenchConstants;
/**
 *<p>Title:WorkbenchServlet.java</p>
 *<p>Description:工作台servlet</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-27
 */
public class WorkbenchServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	private static final Log LOG = LogFactory.getLog(WorkbenchServlet.class);
	
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
		if(WorkbenchConstants.PENDING_ACTION.equals(action)){//获取待办统计数据操作类型
			resultJson = pendingAction(userID);
		}else if(WorkbenchConstants.ONLINE_USER_ACTION.equals(action)){//获取在线用户数据和最高在线用户数据操作类型
			resultJson = onlineUserAction();
		}else if(WorkbenchConstants.SHOW_ITEM_ACTION.equals(action)){//获取展示栏数据操作类型
			String itemID = request.getParameter("itemID");
			resultJson = showItemAction(itemID, userID);
		}else{
			LOG.error("工作台没有你要请求的类型--->"+action);
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
	* pendingAction(获取待办统计数据操作)
	* @param userID
	* @return
	*/
	private String pendingAction(String userID){
		WorkbenchService workbenchService = new WorkbenchServiceImpl();
		List<String> params = new ArrayList<String>();
		params.add(userID);
		Map<String, Integer> resMap = workbenchService.queryPendingNum(params);//查询数据
		
		List<PendingItemBean> pendingItemConfList = WorkbenchConfCache.getPendingBean().getList();//配置信息
		PendingBean dataPendingBean = new PendingBean();//数据实例
		dataPendingBean.setTotal(resMap.get("total"));
		for(PendingItemBean confBean : pendingItemConfList){
			PendingItemBean dataBean = new PendingItemBean();
			dataBean.setClickurl(path+confBean.getClickurl());
			dataBean.setId(confBean.getId());
			dataBean.setName(confBean.getName());
			dataBean.setCount(resMap.get(confBean.getId()));
			dataPendingBean.setPendingItemBean(dataBean);
		}
		return JSONObject.toJSON(dataPendingBean).toString();
	}
	
	/**
	*<b>Summary: </b>
	* onlineUserAction(获取在线用户数据和最高在线用户数据操作)
	* @return
	*/
	private String onlineUserAction() {
		int onlineUser = SessionListener.getOnlineUser().size();//在线用户数
		int maxOnlineUser = WorkbenchUserCache.getOnlineTopBean().getPersonnum();//最高在线用户数
		return JSONObject.toJSON(new int[]{onlineUser,maxOnlineUser}).toString();
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
		ShowItemBean showItemBean = WorkbenchConfCache.getShowItemMap().get(itemID);//模块配置信息
		ShowItemDataBean showItemDataBean = new ShowItemDataBean();
		showItemDataBean.setItemID(showItemBean.getId());
		showItemDataBean.setShowMaxRowNum(showItemBean.getMaxRownum());
		
		String[] showColumns = showItemBean.getShowColumns().split(",");
		String[] realShowColumns = showItemBean.getRealShowColumns().split(",");
		String[] urlParamColumns = showItemBean.getUrlParamColumns().split(",");
		String columnsWidths = showItemBean.getColumnsWidth();
		showItemDataBean.setShowTypeCount(showColumns.length);//显示字段的个数
		
		String dynamicUrlColumns = showItemBean.getDynamicUrlColumns();//动态url地址字段名称
		for(Map<String, String> dateMap : resList){
			ShowItemDetailDataBean showItemDetailDataBean = new ShowItemDetailDataBean();
			
			String clickUrl = path+showItemBean.getClickurl();
			if("uuid-1103".equals(dateMap.get("busiTypeCode"))){//签呈
				clickUrl = clickUrl.replaceAll("/ccapp/oa/archive/showWordConext.jsp", dateMap.get("action_form"));
			}else if("uuid-1106".equals(dateMap.get("busiTypeCode"))){//收文
				clickUrl = clickUrl.replaceAll("/ccapp/oa/archive/showWordConext.jsp", dateMap.get("action_form"));
				clickUrl = clickUrl + "&circutype=circutype";
			}
			String moreUrl = path+showItemBean.getMoreUrl();//add by shuqi.liu　点击首页为弹出框时的列表URL
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
			showItemDetailDataBean.setMoreUrl(moreUrl);
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
