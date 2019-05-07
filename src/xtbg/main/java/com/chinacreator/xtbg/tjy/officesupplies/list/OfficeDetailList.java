
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OfficeDetailList.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-9   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.officesupplies.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsofficeAccountDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsofficeAccountDaoImpl;

/**
 *<p>Title:OfficeDetailList.java</p>
 *<p>Description:固定资产台帐详细列表界面</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-9
 */
public class OfficeDetailList extends DataInfoImpl {

	private static final Log LOG=LogFactory.getLog(OfficeDetailList.class);
	 /** 
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
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = null;
		try {
			OsofficeAccountDao daojson = new OsofficeAccountDaoImpl();
			pb = daojson.OsofficeDetailList(parmjson, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String) 
	  */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}

}
