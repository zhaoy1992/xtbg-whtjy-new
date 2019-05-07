package com.chinacreator.xtbg.core.kbm.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.kbm.cache.KbmConfCache;
import com.chinacreator.xtbg.core.kbm.dao.WorkbenchDao;
import com.chinacreator.xtbg.core.kbm.dao.impl.WorkbenchDaoImpl;
import com.chinacreator.xtbg.core.kbm.entity.ShowItemBean;
import com.chinacreator.xtbg.core.kbm.service.WorkbenchService;

/**
 *<p>Title:WorkbenchServiceImpl.java</p>
 *<p>Description:知识库服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-8-16
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
		ShowItemBean showItemBean = KbmConfCache.getShowItemMap().get(itemID);//first_config.xml配置信息
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

	

}
