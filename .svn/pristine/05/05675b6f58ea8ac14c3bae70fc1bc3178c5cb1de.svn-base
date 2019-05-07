package com.chinacreator.xtbg.caizhengting.ibrary.list;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryTreeDao;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.impl.IbraryTreeDaoImpl;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryTreeBean;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:IbraryTreeList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public class IbraryTreeList implements DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(IbraryTreeList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		IbraryTreeBean bean = new IbraryTreeBean();
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			bean = (IbraryTreeBean) JSONObject.parseObject(parmjson, IbraryTreeBean.class);
		}
		IbraryTreeDao dao = new IbraryTreeDaoImpl();
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			pb = dao.list(bean, sortName, sortOrder, offset, maxPagesize, con);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		} finally {
			DbconnManager.closeConnection(con);
		}
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}
}
