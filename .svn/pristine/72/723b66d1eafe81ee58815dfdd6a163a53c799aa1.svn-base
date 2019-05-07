package com.chinacreator.xtbg.core.archive.list;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.archive.dao.BudgetDetailDao;
import com.chinacreator.xtbg.core.archive.dao.impl.BudgetDetailDaoImpl;
import com.chinacreator.xtbg.core.archive.entity.BudgetDetailBean;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:SplitLogList.java</p>
 *<p>Description:拆分记录分页查询</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public class BudgetDetailList extends DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(BudgetDetailList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,String sortOrder, long offset, int maxPagesize) {
		BudgetDetailBean bean = new BudgetDetailBean();
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			bean = (BudgetDetailBean) JSONObject.parseObject(parmjson, BudgetDetailBean.class);
		}
		BudgetDetailDao dao = new BudgetDetailDaoImpl();
		Connection con = null;
		try {
			con = DbManager.getInstance().getConnection();
			pb = dao.list(bean, sortName, sortOrder, offset, maxPagesize, con);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		} finally {
			DbManager.closeConnection(con);
		}
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}
	
}
