package com.chinacreator.xtbg.tjy.officesupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppRegObjectDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAppRegObjectDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegObjectBean;

public class OsBumenTzList extends DataInfoImpl{
	private static final Log LOG=LogFactory.getLog(OsBumenTzList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		OsAppRegObjectBean bean = null;
		PagingBean pb = new PagingBean();
		OsAppRegObjectDao dao = new OsAppRegObjectDaoImpl();
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (OsAppRegObjectBean) JSONObject.parseObject(parmjson, OsAppRegObjectBean.class);
		}
		try {
			pb = dao.getListByOrg(bean, sortName, sortOrder, offset, maxPagesize);
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
