package com.chinacreator.xtbg.core.file.action;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PublicAjaxAction;
import com.chinacreator.xtbg.core.file.cache.FileCache;
import com.chinacreator.xtbg.core.file.entity.ItemValueBean;
import com.chinacreator.xtbg.core.file.entity.ShowItemBean;
import com.chinacreator.xtbg.core.file.entity.ShowItemDataBean;
import com.chinacreator.xtbg.core.file.entity.ShowItemDetailDataBean;
import com.chinacreator.xtbg.core.file.service.FileFirstPageService;
import com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl;

/**
 * 
 *<p>Title:FileFirstPageAction.java</p>
 *<p>Description:档案管理首页处理action</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-10-22
 */
public class FileFirstPageAction extends PublicAjaxAction {
	private static final Logger LOG = Logger
			.getLogger(FileFirstPageAction.class);
	private String itemId;// 首页数据模块id
	private String userId; // 当前登录用户id

	/**
	 * 
	 *<b>Summary: 查询档案首页的数据</b> queryListData()
	 */
	public void queryListData(){
		try{
		
		String path = getRequest().getContextPath();//系统上下文目录
		FileFirstPageService service = new FileFilesServiceImpl();
		List<Map<String, String>> resList = service.queryFirstPageData(itemId, userId);//查询数据
		ShowItemBean showItemBean = FileCache.getShowItemMap().get(itemId);//模块配置信息
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
		
		super.write4Json(showItemDataBean);	
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
		}
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

}
