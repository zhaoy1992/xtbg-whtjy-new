package com.chinacreator.xtbg.tjy.officesupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAccountHistoryDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAccountHistoryDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountHistoryBean;
/**
 * 固定资产使用历史记录列表
 * @author 王淑滨
 *
 */
public class OsAccountHistoryList extends DataInfoImpl{
	private static final Log LOG=LogFactory.getLog(OsAccountHistoryList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		OsAccountHistoryBean bean = new OsAccountHistoryBean();
		OsAccountHistoryDao dao = new OsAccountHistoryDaoImpl();
		if (!StringUtil.isBlank(parmjson)) {
			bean = (OsAccountHistoryBean) JSONObject.parseObject(parmjson, OsAccountHistoryBean.class);
		}
		try {
			pb  = dao.getAccountHistoryList(bean, sortName, sortOrder, offset, maxPagesize);
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
