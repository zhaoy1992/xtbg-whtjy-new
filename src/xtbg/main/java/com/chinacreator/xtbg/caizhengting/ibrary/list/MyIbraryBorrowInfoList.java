
 /**
 * [Product]
  *     xtbg-base
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     IbraryBorrowInfoList.java
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
import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBorrowInfoDao;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.impl.IbraryBorrowInfoDaoImpl;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBorrowInfoBean;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:IbraryBorrowInfoList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public class MyIbraryBorrowInfoList implements DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(MyIbraryBorrowInfoList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		IbraryBorrowInfoBean bean = new IbraryBorrowInfoBean();
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			bean = (IbraryBorrowInfoBean) JSONObject.parseObject(parmjson, IbraryBorrowInfoBean.class);
		}
		IbraryBorrowInfoDao dao = new IbraryBorrowInfoDaoImpl();
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			pb = dao.myList(bean, sortName, sortOrder, offset, maxPagesize, con);
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
