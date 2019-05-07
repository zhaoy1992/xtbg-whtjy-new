package com.chinacreator.xtbg.tjy.detectionsupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsHavaObjectDao;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.impl.OsHavaObjectDaoImpl;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsHavaLYObjectBean;

/**
 * 
 *<p>Title:OsHavaLingYongobjectList.java</p>
 *<p>Description: 物品领用列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-13
 */
public class OsHavaLingYongobjectList extends DataInfoImpl {
	private static final Log LOG=LogFactory.getLog(OsHavaLingYongobjectList.class);

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
		OsHavaLYObjectBean osHavaLYObjectBean = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			osHavaLYObjectBean = (OsHavaLYObjectBean) JSONObject.parseObject(parmjson, OsHavaLYObjectBean.class);
		}
		try {
			pb = osHavaObjectDao.findOsHavaLYObjectList(osHavaLYObjectBean, sortName, sortOrder, offset, maxPagesize);
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
