package com.chinacreator.xtbg.core.paper.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.paper.dao.PaperReceiveInfoDao;
import com.chinacreator.xtbg.core.paper.entity.PaperReceiveInfoBean;
/**
 * 
 *<p>Title:PaperReceiveNoticeDaoImpl.java</p>
 *<p>Description:信息发布后的接收方明细情况接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-11
 */
public class PaperReceiveInfoDaoImpl extends XtDbBaseDao implements PaperReceiveInfoDao {

	/**
	 * 
	  * <b>Summary:查询信息发布后的接收方明细情况列表 </b>
	  *     复写方法 selReceiveNoticeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperReceiveInfoDao#selReceiveInfoList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selReceiveInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PaperReceiveInfoBean bean= new PaperReceiveInfoBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				bean = (PaperReceiveInfoBean) JSONObject.parseObject(parmjson, PaperReceiveInfoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select t.*,u.user_mobiletel1 user_phone,u.user_realname user_name ");
			sql.append("from oa_paper_receive_info t ");
			sql.append("left outer join td_sm_user u ");
			sql.append("on t.p_receive_user_id = u.user_id ");
			sql.append("where 1 = 1 and t.p_manage_id = ? and t.p_read_status=? and t.p_type_id=? ");
			sql.append("and 1=1 ");
			sql.append(" order by " + sortName + " " + sortOrder);
			condition.add(bean.getP_manage_id());
			condition.add(bean.getP_read_status());
			condition.add(bean.getP_type_id());
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}


}
