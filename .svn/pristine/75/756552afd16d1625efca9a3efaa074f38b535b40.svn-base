
 /**
 * [Product]
  *     xtbg-base
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     IbraryBookInfoList.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-9-3   rt    最初版本
   */
package com.chinacreator.xtbg.caizhengting.ibrary.list;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.impl.IbraryBookInfoDaoImpl;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:IbraryBookInfoList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public class IbraryBookInfoList implements DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(IbraryBookInfoList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		IbraryBookInfoBean bean = new IbraryBookInfoBean();
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);  
			parmjson = Escape.unescape(parmjson);
			bean = (IbraryBookInfoBean) JSONObject.parseObject(parmjson, IbraryBookInfoBean.class);
		}
		IbraryBookInfoDao dao = new IbraryBookInfoDaoImpl();
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			pb = dao.list(bean, sortName, sortOrder, offset, maxPagesize, con);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		} finally {
			DbconnManager.closeConnection(con);
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
