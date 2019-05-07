package com.chinacreator.xtbg.core.guestreception.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.guestreception.dao.GuestreceptionDao;
import com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean;

public class GuestreceptionReceiveList extends DataInfoImpl {

	private static final Logger LOG = Logger
			.getLogger(GuestreceptionReceiveList.class);

	/**
	 * @Description 查询个人通讯录人员信息列表
	 * 
	 * @param request
	 * @param response
	 * @return 返回JOSNOBJECT
	 * @exception
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		GuestreceptionBean guestreceptionBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			guestreceptionBean = (GuestreceptionBean) JSONObject.parseObject(parmjson,GuestreceptionBean.class);
		}
		try {
			GuestreceptionDao guestreceptionDao = (GuestreceptionDao)LoadSpringContext.getApplicationContext().getBean("guestreceptionDaoImpl");
			pb = guestreceptionDao.queryViewGuestInfo(guestreceptionBean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e);
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
