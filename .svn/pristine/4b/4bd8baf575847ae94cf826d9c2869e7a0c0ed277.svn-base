package com.chinacreator.xtbg.caizhengting.press.list;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.caizhengting.press.dao.PressDao;
import com.chinacreator.xtbg.caizhengting.press.dao.imploracle.PressDaoImpl;
import com.chinacreator.xtbg.caizhengting.press.entity.PressBean;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class PressList extends DataInfoImpl {
	private static final Logger LOG = Logger.getLogger(PressList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PressBean bean = new PressBean();
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			bean = (PressBean) JSONObject.parseObject(parmjson, PressBean.class);
		}
		PressDao dao = new PressDaoImpl();
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
