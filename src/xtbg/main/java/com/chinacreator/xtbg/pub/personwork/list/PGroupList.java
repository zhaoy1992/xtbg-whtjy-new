package com.chinacreator.xtbg.pub.personwork.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.personwork.dao.PriManageDao;
import com.chinacreator.xtbg.pub.personwork.entity.PGroupBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class PGroupList implements DataInfoImpl {

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(PGroupList.class);

	/**
	 * @Description 查询文件列表
	 * 
	 * @param request
	 * @param response
	 * @return 返回JOSNOBJECT
	 * @exception
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PGroupBean pGroupBean=null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			pGroupBean = (PGroupBean) JSONObject.parseObject(parmjson,
					PGroupBean.class);
		}

		try {
			PriManageDao priManageDao = (PriManageDao) DaoImplClassUtil
					.getDaoImplClass("priManageDaoImpl");
			pb = priManageDao.queryGroup(pGroupBean, sortName, sortOrder, offset, maxPagesize);
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
