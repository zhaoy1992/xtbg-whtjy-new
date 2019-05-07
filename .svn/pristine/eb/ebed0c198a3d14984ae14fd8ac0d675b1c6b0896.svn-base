package com.chinacreator.xtbg.core.paper.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.paper.dao.PaperReceiveNoticeDao;
import com.chinacreator.xtbg.core.paper.entity.PaperMakeNoticeBean;
import com.chinacreator.xtbg.core.paper.entity.PaperReceiveNoticeBean;
/**
 * 
 *<p>Title:PaperReceiveNoticeDaoImpl.java</p>
 *<p>Description:约稿通知接收接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-11
 */
public class PaperReceiveNoticeDaoImpl extends XtDbBaseDao implements PaperReceiveNoticeDao {

	/**
	 * 
	  * <b>Summary:查询约稿通知接收列表 </b>
	  *     复写方法 selReceiveNoticeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperReceiveNoticeDao#selReceiveNoticeList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selReceiveNoticeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PaperReceiveNoticeBean bean= new PaperReceiveNoticeBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				bean = (PaperReceiveNoticeBean) JSONObject.parseObject(parmjson, PaperReceiveNoticeBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select * from (select a.*,row_number() over(partition by p_receive_unit_name order by user_name) rownumb ");
			sql.append(" from (select t.p_notice_id, ");
			sql.append(" t.p_receive_unit_name, ");
			sql.append(" v.username user_name,v.userid user_id ,");
			sql.append(" v.user_mobiletel1 user_phone, ");
			sql.append(" t.p_read_time,  ");
			sql.append(" t.p_read_status ");
			sql.append(" from OA_PAPER_RECEIVE_NOTICE t ");
			sql.append(" left join v_user_info v ");
			sql.append(" on t.p_receive_unit_id = v.unitid ");
			sql.append(" left join td_sm_userrole ur on ur.user_id=v.userid ");
			sql.append(" left join td_sm_role r on ur.role_id=r.role_id ");
			sql.append(" where 1=1 and r.role_name='接收约稿通知者角色' ");
			sql.append(" and t.p_notice_id = ? ");
			sql.append(" and t.p_read_status = ? ");
			sql.append(" order by user_name) a) ");
			sql.append(" where rownumb = 1  ");
			
			sql.append(" order by " + sortName + " " + sortOrder);
			condition.add(bean.getP_notice_id());
			condition.add(bean.getP_read_status());
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary:约稿通知查询列表 </b>
	  *     复写方法 selReceiveList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperReceiveNoticeDao#selReceiveList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selReceiveList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PaperReceiveNoticeBean bean= new PaperReceiveNoticeBean();
		PaperMakeNoticeBean makebean=new PaperMakeNoticeBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				bean = (PaperReceiveNoticeBean) JSONObject.parseObject(parmjson, PaperReceiveNoticeBean.class);
				makebean=(PaperMakeNoticeBean) JSONObject.parseObject(parmjson, PaperMakeNoticeBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select rn.p_receive_id, ");
			sql.append(" rn.p_notice_id, ");
			sql.append(" rn.p_title,rn.p_receive_unit_name, ");
			sql.append(" mn.p_send_unit_id,");
			sql.append(" mn.p_send_unit_name, ");
			sql.append(" mn.p_send_time  ");
			sql.append(" from oa_paper_receive_notice rn ");
			sql.append(" left join oa_paper_make_notice mn ");
			sql.append(" on rn.p_notice_id = mn.p_notice_id ");
			sql.append(" where 1=1 ");
			if(bean!=null){
				if (!StringUtil.nullOrBlank(bean.getP_title())) {
					sql.append(" and rn.p_title like '%'||?||'%'");
					condition.add(bean.getP_title());
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))){
					String beginTime = StringUtil.deNull(bean.getStart_time())+" 00:00:00";
					sql.append(" and mn.p_send_time >= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
					condition.add(beginTime);
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))){
					String beginTime = StringUtil.deNull(bean.getEnd_time())+" 23:59:59";
					sql.append(" and mn.p_send_time <= to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
					condition.add(beginTime);
				}	
				if (!StringUtil.nullOrBlank(bean.getP_receive_unit_id())) {
					sql.append(" and rn.p_receive_unit_id =? ");
					condition.add(bean.getP_receive_unit_id());
				}
			}
			if(makebean!=null){
				if (!StringUtil.nullOrBlank(makebean.getP_send_unit_name())) {
					sql.append(" and mn.p_send_unit_name like '%'||?||'%'");
					condition.add(makebean.getP_send_unit_name());
				}
			}
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

}
