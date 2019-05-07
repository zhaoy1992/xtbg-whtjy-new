package com.chinacreator.xtbg.tjy.officesupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsExaminationObjectDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsExaminationObjectDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean;

/**
 * 
 *<p>Title:OSExaShowOrgList.java</p>
 *<p>Description:查看已汇总的常用物品的明细列表类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-6-4
 */
public class OSExaShowOrgList extends DataInfoImpl {
	
	private static final Log LOG=LogFactory.getLog(OSExaShowOrgList.class);
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
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb=new PagingBean();
		OsExaminationObjectDao osExaminationObjectDao = new OsExaminationObjectDaoImpl();
		OsAppObjectBean osappobjectbean = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			osappobjectbean = (OsAppObjectBean) JSONObject.parseObject(parmjson, OsAppObjectBean.class);
		}
		try {
			pb = osExaminationObjectDao.findOsShowOrgList(osappobjectbean, sortName, sortOrder, offset, maxPagesize);
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
