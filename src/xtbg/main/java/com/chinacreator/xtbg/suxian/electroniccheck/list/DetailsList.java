package com.chinacreator.xtbg.suxian.electroniccheck.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectInfoDaoImpl;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.AttendanceLeaveBean;

public class DetailsList implements DataInfoImpl{

	private static final Logger LOG = Logger.getLogger(DetailsList.class);


	public PagingBean getDataList(String paramjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		AttendanceLeaveBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(paramjson)) {
			paramjson = DataControlUtil.replaceStr(paramjson);
			bean = (AttendanceLeaveBean) JSONObject.parseObject(paramjson,AttendanceLeaveBean.class);
		}
		try {
			ElectInfoDao dao = new ElectInfoDaoImpl();
			pb = dao.getDetails(bean, sortName, sortOrder, offset, maxPagesize);

		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}

/**
 * 
  * <b>Summary: </b>
  *     复写方法 getDataList
  * @param parmStr
  * @param sortName
  * @param sortOrder
  * @return 
  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String)
 */
	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}

}
