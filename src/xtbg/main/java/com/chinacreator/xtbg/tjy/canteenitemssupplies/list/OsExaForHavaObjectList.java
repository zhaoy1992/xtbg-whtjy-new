package com.chinacreator.xtbg.tjy.canteenitemssupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.OsExaminationObjectDao;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.impl.OsExaminationObjectDaoImpl;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsExaBean;

/**
 * 
 *<p>Title:OsExaForAppList.java</p>
 *<p>Description:查询出已办结的未入库的计划审批表列表类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-9
 */
public class OsExaForHavaObjectList extends DataInfoImpl {
	private static final Log LOG=LogFactory.getLog(OsExaForHavaObjectList.class);

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
		OsExaminationObjectDao osExaminationObjectDao = new OsExaminationObjectDaoImpl();
		OsExaBean osExaBean = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			osExaBean = (OsExaBean) JSONObject.parseObject(parmjson, OsExaBean.class);
		}
		try {
			pb = osExaminationObjectDao.findOsExaList(osExaBean, sortName, sortOrder, offset, maxPagesize);
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
