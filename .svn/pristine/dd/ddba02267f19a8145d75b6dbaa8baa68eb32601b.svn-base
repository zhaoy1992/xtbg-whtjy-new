package com.chinacreator.xtbg.tjy.officesupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsapPlanDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsapPlanDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean;

public class OsapPlanList extends DataInfoImpl{
	private static final Log LOG=LogFactory.getLog(OsapPlanList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		OsApplanBean bean = null;
		PagingBean pb = new PagingBean();
		OsapPlanDao dao = new OsapPlanDaoImpl();
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (OsApplanBean) JSONObject.parseObject(parmjson, OsApplanBean.class);
		}
		try {
			pb = dao.getAppList(bean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
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
