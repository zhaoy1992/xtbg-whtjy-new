package com.chinacreator.xtbg.zhangjiajie.inforeported.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoStaDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoStaBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class InfoStaDetailList implements DataInfoImpl {

	private static final Logger LOG = Logger
			.getLogger(InfoStaDetailList.class);

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
		InfoStaBean infoStaBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			infoStaBean = (InfoStaBean) JSONObject.parseObject(parmjson,
					InfoStaBean.class);
		}
		try {
			InfoStaDao infoStaDao = (InfoStaDao) DaoImplClassUtil
					.getDaoImplClass("infoStaDaoImpl");
			pb = infoStaDao.findInfoStaDetailList(infoStaBean, sortName, sortOrder, offset, maxPagesize);
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
