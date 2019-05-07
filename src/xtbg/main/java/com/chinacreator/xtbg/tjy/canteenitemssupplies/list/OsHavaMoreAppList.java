package com.chinacreator.xtbg.tjy.canteenitemssupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.OsHavaObjectDao;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.impl.OsHavaObjectDaoImpl;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsApplanBean;

/**
 * 
 *<p>Title:OsHavaMoreAppList.java</p>
 *<p>Description:易耗品相关计划表列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-11
 */
public class OsHavaMoreAppList extends DataInfoImpl {
	private static final Log LOG=LogFactory.getLog(OsHavaMoreAppList.class);

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl
	  * #getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb=new PagingBean();
		OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
		OsApplanBean osApplanBean = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			osApplanBean = (OsApplanBean) JSONObject.parseObject(parmjson, OsApplanBean.class);
		}
		try {
			pb = osHavaObjectDao.findOsAppList(osApplanBean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}

}
