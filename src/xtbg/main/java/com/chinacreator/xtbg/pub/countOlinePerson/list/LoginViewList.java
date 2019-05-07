package com.chinacreator.xtbg.pub.countOlinePerson.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.countOlinePerson.dao.SessionListenerDao;
import com.chinacreator.xtbg.pub.countOlinePerson.entity.LoginUserbean;
import com.chinacreator.xtbg.pub.countOlinePerson.service.SessionListener;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class LoginViewList implements DataInfoImpl {

	private static final Logger LOG = Logger
			.getLogger(LoginViewList.class);

	/**
	 * @Description 查询在线用户信息
	 * 
	 * @param request
	 * @param response
	 * @return 返回JOSNOBJECT
	 * @exception
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		LoginUserbean loginUserbean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			loginUserbean = (LoginUserbean) JSONObject.parseObject(parmjson,
					LoginUserbean.class);
		}
		try {
			SessionListenerDao sessionListenerDao = (SessionListenerDao) DaoImplClassUtil
					.getDaoImplClass("sessionListenerDaoImpl");
			pb = sessionListenerDao.findloginsList(SessionListener.getSessions(),loginUserbean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}

	public PagingBean getDataList(String parmStr, String sortName,
			String sortOrder) {

		return null;
	}

}
