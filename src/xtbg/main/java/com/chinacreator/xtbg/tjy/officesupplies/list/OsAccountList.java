package com.chinacreator.xtbg.tjy.officesupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAccountDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAccountDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean;

/**
 * 固定资产台帐清单
 * @author 王淑滨
 *
 */
public class OsAccountList extends DataInfoImpl{
	private static final Log LOG=LogFactory.getLog(OsAccountList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		OsAccountBean bean = new OsAccountBean();
		OsAccountDao dao = new OsAccountDaoImpl();
		if (!StringUtil.isBlank(parmjson)) {
			bean = (OsAccountBean) JSONObject.parseObject(parmjson, OsAccountBean.class);
		}
		try {
			pb  = dao.getAccountList(bean, sortName, sortOrder, offset, maxPagesize);
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
