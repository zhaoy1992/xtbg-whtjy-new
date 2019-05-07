package com.chinacreator.xtbg.tjy.officesupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppObjectDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAppObjectDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean;

/**
 * 出库台账
 * @author 王淑滨
 *
 */
public class OsAppObjectList extends DataInfoImpl{
	private static final Log LOG=LogFactory.getLog(OsAppObjectList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		OsAppObjectBean bean = null;
		PagingBean pb = new PagingBean();
		OsAppObjectDao dao = new OsAppObjectDaoImpl();
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (OsAppObjectBean) JSONObject.parseObject(parmjson, OsAppObjectBean.class);
		}
		try {
			pb = dao.getObjectList(bean, sortName, sortOrder, offset, maxPagesize);
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
