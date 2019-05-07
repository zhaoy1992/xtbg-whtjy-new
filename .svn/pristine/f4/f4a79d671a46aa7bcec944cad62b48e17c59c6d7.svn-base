package com.chinacreator.xtbg.tjy.officesupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAccountManageDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAccountManageDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountManagerBean;

/**
 * 固定资产使用管理记录
 * @author 王淑滨
 *
 */
public class OsAccountManageList extends DataInfoImpl{
	private static final Log LOG=LogFactory.getLog(OsAccountManageList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		OsAccountManagerBean bean = new OsAccountManagerBean();
		OsAccountManageDao dao = new OsAccountManageDaoImpl();
		try {
			if(!StringUtil.nullOrBlank(parmjson)){
				bean = (OsAccountManagerBean) JSONObject.parseObject(parmjson, OsAccountManagerBean.class);
			}
			pb = dao.getAccountManageList(bean, sortName, sortOrder, offset, maxPagesize);
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
