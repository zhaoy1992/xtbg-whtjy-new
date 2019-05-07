package com.chinacreator.xtbg.yimingju.carmanage.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageYoukaDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.impl.CarManageYoukadaoImpl;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageYoukaBean;

/**
 * 油卡发放登记List
 * @author 王淑滨
 *
 */
public class CarManageYoukaList implements DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(CarManageYoukaList.class);

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		CarManageYoukaBean youkaBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			youkaBean = (CarManageYoukaBean) JSONObject.parseObject(parmjson,CarManageYoukaBean.class);
		}
		try {
			CarManageYoukaDao dao = new CarManageYoukadaoImpl();
			pb = dao.getYoukaList(youkaBean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
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
