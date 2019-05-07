package com.chinacreator.xtbg.caizhengting.ibrary.list;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.impl.IbraryBookInfoDaoImpl;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 * 
 *<p>Title:IbraryRegBookInfoList.java</p>
 *<p>Description:查询图书申请表列表数据</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-21
 */
public class IbraryRegBookInfoList implements DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(IbraryRegBookInfoList.class);
	/**
	 * 
	  * <b>Summary: 查询图书申请表列表数据</b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.pub.common.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		IBraryRegBookInfoBean iBraryRegBookInfoBean = new IBraryRegBookInfoBean();
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			iBraryRegBookInfoBean = (IBraryRegBookInfoBean) JSONObject.parseObject(parmjson, IBraryRegBookInfoBean.class);
		}
		IbraryBookInfoDao dao = new IbraryBookInfoDaoImpl();
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			pb = dao.findRegBookInfoList(iBraryRegBookInfoBean, sortName, sortOrder, offset, maxPagesize);
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
