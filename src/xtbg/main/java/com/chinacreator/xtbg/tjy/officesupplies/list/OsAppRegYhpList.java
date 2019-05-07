package com.chinacreator.xtbg.tjy.officesupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppRegYhpDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAppRegYhpDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegYhpBean;

/**
 * 领用出库
 * @author 王淑滨
 *
 */
public class OsAppRegYhpList extends DataInfoImpl{

	private static final Log LOG=LogFactory.getLog(OsAppRegYhpList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		OsAppRegYhpBean bean = null;
		PagingBean pb = new PagingBean();
		OsAppRegYhpDao dao = new OsAppRegYhpDaoImpl();
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (OsAppRegYhpBean) JSONObject.parseObject(parmjson, OsAppRegYhpBean.class);
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
