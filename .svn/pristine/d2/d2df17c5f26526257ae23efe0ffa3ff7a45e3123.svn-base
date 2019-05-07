package com.chinacreator.xtbg.core.workbench.services.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.workbench.cache.WorkbenchConfCache;
import com.chinacreator.xtbg.core.workbench.dao.WorkbenchDao;
import com.chinacreator.xtbg.core.workbench.dao.impl.WorkbenchDaoImpl;
import com.chinacreator.xtbg.core.workbench.entity.PendingBean;
import com.chinacreator.xtbg.core.workbench.entity.PendingItemBean;
import com.chinacreator.xtbg.core.workbench.entity.ShowItemBean;
import com.chinacreator.xtbg.core.workbench.services.WorkbenchService;
/**
 *<p>Title:WorkbenchServiceImpl.java</p>
 *<p>Description:工作台服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
 */
public class WorkbenchServiceImpl implements WorkbenchService {
	
	private static final Log LOG = LogFactory.getLog(WorkbenchServiceImpl.class);

	/**
	  * <b>Summary: </b>
	  *     复写方法 queryUserData
	  * @param itemID
	  * @param userID
	  * @return 
	  * @see com.chinacreator.xtbg.core.workbench.services.WorkbenchService#queryUserData(java.lang.String, java.lang.String)
	 */
	@Override
	public List<Map<String, String>> queryUserData(String itemID, String userID) {
		ShowItemBean showItemBean = WorkbenchConfCache.getShowItemMap().get(itemID);//first_config.xml配置信息
		List<Map<String, String>> list = null;
		Connection conn = null;
		try {
			if(showItemBean != null){
				conn = DbManager.getInstance().getConnection();
				list = new ArrayList<Map<String,String>>();
				String sql = showItemBean.getSql();
				List<String> params = new ArrayList<String>();
				for (int i = 0; i < showItemBean.getParamCount(); i++) {//默认sql中的所有参数只能为userid
					params.add(userID);
				}
				String columnString =  showItemBean.getShowColumns();//显示字段
				
				if(!"".equals(columnString) && !"".equals(showItemBean.getRealShowColumns())){//加样式的显示字段
					columnString += "," + showItemBean.getRealShowColumns();
				}
				
				if(!"".equals(columnString) && !"".equals(showItemBean.getUrlParamColumns())){//url参数字段
					columnString += "," + showItemBean.getUrlParamColumns();
				}
				
				if(!"".equals(columnString) && !"".equals(showItemBean.getDynamicUrlColumns())){//动态连接地址
					columnString += "," + showItemBean.getDynamicUrlColumns();
				}
				List<String> dbColumns = Arrays.asList(columnString.split(","));
				
				WorkbenchDao dao = new WorkbenchDaoImpl();
				list = dao.queryUserData(sql, params, dbColumns,showItemBean.getMaxRownum(), conn);
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 queryPendingNum
	  * @param objs
	  * @return 
	  * @see com.chinacreator.xtbg.core.workbench.services.WorkbenchService#queryPendingNum(org.apache.ecs.xhtml.object[])
	 */
	@Override
	public Map<String,Integer> queryPendingNum(List<String> params) {
		PendingBean pendingBean = WorkbenchConfCache.getPendingBean();
		Map<String,Integer> map = null;
		Connection conn = null;
		try {
			if(pendingBean != null){
				conn = DbManager.getInstance().getConnection();
				map = new HashMap<String, Integer>();
				String functionSql = pendingBean.getFunctionSql();
				List<PendingItemBean> list = pendingBean.getList();
				WorkbenchDao dao = new WorkbenchDaoImpl();
				String result = dao.queryPendingNum(functionSql, params, conn);
				String[] results = result.split(",");
				int total = 0;//所有的待办统计数
				for(int i = 0 ; i < results.length ; i++){//每一小块统计数据
					int count = Integer.parseInt(results[i]);
					String pendingID = list.get(i).getId();
					map.put(pendingID, count);
					total += count;
				}
				map.put("total", total);
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return map;
	}

}
