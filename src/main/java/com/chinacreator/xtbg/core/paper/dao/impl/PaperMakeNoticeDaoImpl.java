package com.chinacreator.xtbg.core.paper.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.paper.dao.PaperMakeNoticeDao;
import com.chinacreator.xtbg.core.paper.entity.PaperMakeNoticeBean;
/**
 * 
 *<p>Title:PaperMakeNoticeDaoImpl.java</p>
 *<p>Description:约稿通知接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-11
 */
public class PaperMakeNoticeDaoImpl extends XtDbBaseDao implements PaperMakeNoticeDao {

	/**
	 * 
	  * <b>Summary: 查询约稿通知信息列表</b>
	  *     复写方法 selMakeNoticeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperMakeNoticeDao#selMakeNoticeList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selMakeNoticeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PaperMakeNoticeBean bean= new PaperMakeNoticeBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				bean = (PaperMakeNoticeBean) JSONObject.parseObject(parmjson, PaperMakeNoticeBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select m.p_notice_id,m.p_title, ");
			sql.append(" ((select count(*) from oa_paper_receive_notice r ");
			sql.append(" where r.p_notice_id=m.p_notice_id and r.p_read_status='1') || '/' ||");
			sql.append(" (select count(*) from  oa_paper_receive_notice r ");
			sql.append(" where r.p_notice_id=m.p_notice_id)) isread, ");
			sql.append(" m.p_send_time  ");
			sql.append(" from oa_paper_make_notice m ");
			sql.append(" where 1=1 ");
			if(bean!=null){
				if (!StringUtil.nullOrBlank(bean.getP_title())) {
					sql.append(" and m.p_title like '%'||?||'%'");
					condition.add(bean.getP_title());
				}
				if (!StringUtil.nullOrBlank(bean.getP_send_unit_id())) {
					sql.append(" and m.p_send_unit_id =? ");
					condition.add(bean.getP_send_unit_id());
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))){
					String beginTime = StringUtil.deNull(bean.getStart_time())+" 00:00:00";
					sql.append(" and m.p_send_time >= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
					condition.add(beginTime);
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))){
					String beginTime = StringUtil.deNull(bean.getEnd_time())+" 23:59:59";
					sql.append(" and pm.p_send_time <= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
					condition.add(beginTime);
				}	
			}
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary:根据id查询约稿通知信息 </b>
	  *     复写方法 getMakeNoticeBean
	  * @param con
	  * @param id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperMakeNoticeDao#getMakeNoticeBean(java.sql.Connection, java.lang.String)
	 */
	public Map<String, String> getMakeNoticeBean(Connection con, String id)
			throws Exception {
		Map<String, String> map=new HashMap<String, String>();
		String sql="select * from oa_paper_make_notice where p_notice_id=? ";
		map=queryToSingleMap(con, sql, id);
		
		return map;
	}

	
}
