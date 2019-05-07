package com.chinacreator.xtbg.yimingju.carmanage.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageApplyinfoDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoSearchBean;

public class CarManageApplyinfoYmjList implements DataInfoImpl{
	
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(CarManageApplyinfoYmjList.class);
	
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		CarManageApplyinfoSearchBean carManageApplyinfoSearchBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			carManageApplyinfoSearchBean = (CarManageApplyinfoSearchBean) JSONObject.parseObject(parmjson, CarManageApplyinfoSearchBean.class);
		}
		try {
			CarManageApplyinfoDao carManageApplyinfoDao = (CarManageApplyinfoDao)DaoImplClassUtil.getDaoImplClass("carManageApplyinfoDaoImplymj");
			pb = carManageApplyinfoDao.findCarManageApplyinfoList(carManageApplyinfoSearchBean, sortName, sortOrder, offset, maxPagesize);	
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}

}
