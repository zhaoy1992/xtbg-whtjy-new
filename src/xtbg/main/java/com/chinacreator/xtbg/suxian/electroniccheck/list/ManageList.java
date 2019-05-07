package com.chinacreator.xtbg.suxian.electroniccheck.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectInfoDaoImpl;

/**
 * 电子考勤流程后台管理
 * @author Administrator
 *
 */
public class ManageList implements DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(ManageList.class);

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		WorkFlowSearchBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (WorkFlowSearchBean) JSONObject.parseObject(parmjson,WorkFlowSearchBean.class);
		}
		try {

			ElectInfoDao impl = new ElectInfoDaoImpl();
			pb = impl.getManageList(bean, sortName, sortOrder, offset, maxPagesize);

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
