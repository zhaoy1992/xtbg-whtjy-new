package com.chinacreator.xtbg.core.notice.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao;
import com.chinacreator.xtbg.core.notice.entity.NoticeAuditBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeBaseInfoBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeReceiverUserBean;
import com.chinacreator.xtbg.core.notice.entity.NoticeReportAuditBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:NoticeBaseInfoDaoImpl.java</p>
 *<p>Description:基本信息Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-20
 */
public class NoticeBaseInfoDaoImpl  extends XtDbBaseDao implements NoticeBaseInfoDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getNoticeBaseInfoBean
	  * @param n_notice_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao#getNoticeBaseInfoBean(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getNoticeBaseInfoBean(String n_notice_id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select b.n_notice_id,");
		sql.append("       b.n_type,");
		sql.append("       b.n_title,");
		sql.append("       b.n_content,");
		sql.append("       b.n_creator_userid,");
		sql.append("       b.n_creator_username,");
		sql.append("       b.n_creator_time,");
		sql.append("       b.n_release_userid,");
		sql.append("       b.n_release_username,");
		sql.append("       b.n_release_time,");
		sql.append("       b.n_state,");
		sql.append("       b.n_attach_id,");
		sql.append("       b.n_orgid,");
		sql.append("       b.n_orgname,");
		sql.append("       b.n_unit_id,");
		sql.append("       b.n_unit_name,");
		sql.append("       b.n_unit_or_personal,");
		sql.append("       b.n_isphone,");
		sql.append("       b.n_megtype,");
		sql.append("       b.n_receiver_userid,");
		sql.append("       b.n_receiver_username,");
		sql.append("       b.n_receiver_orgid,");
		sql.append("       b.n_receiver_orgname,");
		sql.append("       b.n_is_msg,");
		sql.append("       b.n_is_sms,");
		sql.append("       b.n_is_mail,");
		sql.append("       b.n_is_rtx,");
		sql.append("       b.n_audit_name,");
		sql.append("       b.n_audit_id,");
		sql.append("       b.n_audit_state,");
		sql.append("       decode(b.n_select_type,'1','普通公告','2','公文公告','3','领导讲话','4','管理制度')n_select_type");
		sql.append("  from oa_notice_baseinfo b ");
		sql.append(" where b.n_notice_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), n_notice_id);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selNoticeTempList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao#selNoticeTempList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selNoticeTempList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		NoticeBaseInfoBean noticeBaseInfoBean = null;
		PagingBean pb = new PagingBean();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				noticeBaseInfoBean = (NoticeBaseInfoBean) JSONObject.parseObject(parmjson, NoticeBaseInfoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select b.n_notice_id,");
			sql.append("       b.n_title,");
			sql.append("       b.n_creator_userid,");
			sql.append("       b.n_creator_username,");
			sql.append("       b.n_creator_time,");
			sql.append("       decode(b.n_state, '0', '未发布', '2', '撤销','3','已送审','5','审核不通过') as n_state");
			sql.append("  from oa_notice_baseinfo b");
			sql.append(" where b.n_state != '1'  and b.n_state <>'4' ");
			
			if (noticeBaseInfoBean != null) {
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_creator_userid())) {
					sql.append(" and n_creator_userid = '" + noticeBaseInfoBean.getN_creator_userid() + "'");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_title())) {
					sql.append(" and b.n_title like '%" + noticeBaseInfoBean.getN_title() + "%'");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_state()) && !"--发布状态--".equals(noticeBaseInfoBean.getN_state())) {
					String n_state = "";
					if("未发布".equals(noticeBaseInfoBean.getN_state())) {
						n_state = "0";
					} else if("撤销".equals(noticeBaseInfoBean.getN_state())) {
						n_state = "2";
					}else if("审核不通过".equals(noticeBaseInfoBean.getN_state())){
						n_state = "5";
					}
					else if("已审核".equals(noticeBaseInfoBean.getN_state())){
						n_state = "3";
					}
					sql.append(" and b.n_state = '"+n_state+"'");
				}
				
				// 发起时间
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_creator_time()))) {
					sql.append(" and b.n_creator_time  >= to_date('" + noticeBaseInfoBean.getN_creator_time()
							+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				// 发起时间
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_release_time()))) {
					sql.append(" and b.n_creator_time  <= to_date('" + noticeBaseInfoBean.getN_release_time()
							+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			
			
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
			
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selNoticeReleasedList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao#selNoticeReleasedList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selNoticeReleasedList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		NoticeBaseInfoBean noticeBaseInfoBean = null;
		PagingBean pb = new PagingBean();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				noticeBaseInfoBean = (NoticeBaseInfoBean) JSONObject.parseObject(parmjson, NoticeBaseInfoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select b.n_notice_id,");
			sql.append("       b.n_title,");
			sql.append("       b.n_type,");
			sql.append("       b.n_release_userid,");
			sql.append("       b.n_release_username,");
			sql.append("       b.n_release_time");
			sql.append("  from oa_notice_baseinfo b");
			sql.append(" where b.n_state = '1' ");
			
			if (noticeBaseInfoBean != null) {
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_type())) {
					if(noticeBaseInfoBean.getN_type().equalsIgnoreCase("0")){
						sql.append(" and (b.n_type = '1' or b.n_type = '2' )");
					}else{
						sql.append(" and b.n_type = '" + noticeBaseInfoBean.getN_type() + "'");
					}
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_creator_userid())) {
					sql.append(" and n_creator_userid = '" + noticeBaseInfoBean.getN_creator_userid() + "'");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_title())) {
					sql.append(" and b.n_title like '%" + noticeBaseInfoBean.getN_title() + "%'");
				}
				
				
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_creator_time()))) {
					sql.append(" and b.n_release_time  >= to_date('" + noticeBaseInfoBean.getN_creator_time()
							+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_release_time()))) {
					sql.append(" and b.n_release_time  <= to_date('" + noticeBaseInfoBean.getN_release_time()
							+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			
			
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
			
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selNoticeViewSituation
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao#selNoticeViewSituation(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selNoticeViewSituation(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		NoticeBaseInfoBean noticeBaseInfoBean = null;
		
		try {
			
			if (!StringUtil.isBlank(parmjson)) {
				noticeBaseInfoBean = (NoticeBaseInfoBean) JSONObject.parseObject(parmjson, NoticeBaseInfoBean.class);
			}
			
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select o.org_id,");
			sql.append("       o.org_name,");
			sql.append("       (select count(*) noviewnum");
			sql.append("          from oa_notice_receiver_user re");
			sql.append("         where re.n_receiveruser_orgid = o.org_id");
			sql.append("           and re.n_notice_id = '"+noticeBaseInfoBean.getN_notice_id()+"'");
			sql.append("           and re.n_isview = '0') as noviewnum,");
			sql.append("       (select count(*) ");
			sql.append("          from oa_notice_receiver_user re");
			sql.append("         where re.n_receiveruser_orgid = o.org_id");
			sql.append("           and re.n_notice_id = '"+noticeBaseInfoBean.getN_notice_id()+"'");
			sql.append("           and re.n_isview = '1') as viewednum");
			sql.append("  from (select u.n_orgid as orgid, u.n_orgname as orgname");
			sql.append("          from oa_notice_receiver_unit u");
			sql.append("         where u.n_notice_id = '"+noticeBaseInfoBean.getN_notice_id()+"'");
			sql.append("        union");
			sql.append("        select r.n_receiveruser_orgid   as orgid,");
			sql.append("               r.n_receiveruser_orgname as orgname");
			sql.append("          from oa_notice_receiver_user r");
			sql.append("         where r.n_notice_id = '"+noticeBaseInfoBean.getN_notice_id()+"'");
			sql.append("         group by r.n_receiveruser_orgid, r.n_receiveruser_orgname) a,");
			sql.append("       td_sm_organization o");
			sql.append(" where a.orgid = o.org_id");
			sql.append(" order by o.org_sn");
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selUserNoViewAndViewCount
	  * @param n_notice_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao#selUserNoViewAndViewCount(java.lang.String, java.sql.Connection)
	 */
	public String selUserNoViewAndViewCount(String n_notice_id, Connection conn)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String noviewandview = "";
		StringBuffer sql = new StringBuffer();
		sql.append("select (select count(*)");
		sql.append("           from oa_notice_receiver_user re");
		sql.append("          where re.n_notice_id = '"+n_notice_id+"'");
		sql.append("            and re.n_isview = '0') || '#' ||");
		sql.append("        (select count(*) as viewednum");
		sql.append("           from oa_notice_receiver_user re");
		sql.append("          where re.n_notice_id = '"+n_notice_id+"'");
		sql.append("            and re.n_isview = '1') as noviewandview");
		sql.append("   from dual");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			noviewandview = pdb.getString(0, "noviewandview");
		}
		return noviewandview;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 setNoticeViewDetail
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao#setNoticeViewDetail(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean setNoticeViewDetail(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		NoticeReceiverUserBean noticeReceiverUserBean = null;
		try {
			if (!StringUtil.isBlank(parmjson)) {
				noticeReceiverUserBean = (NoticeReceiverUserBean) JSONObject.parseObject(parmjson, NoticeReceiverUserBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append(" select dd.*,job.same_job_user_sn y from (select r.n_receiverid,");
			sql.append("       r.n_notice_id,");
			sql.append("       r.n_receiver_userid,");
			sql.append("       r.n_receiver_username,");
			sql.append("       decode(r.n_isview, '0', '未查看' ， '已查看') as n_isview,");
			sql.append("       u.user_mobiletel1,o.org_name, o.org_id, u.user_id,o.org_sn");
			sql.append("  from oa_notice_receiver_user r, td_sm_user u,td_sm_orguser ou,td_sm_organization o");
			sql.append(" where r.n_receiver_userid = u.user_id and u.user_id=ou.user_id and ou.org_id=o.org_id ");
			sql.append("   and r.n_notice_id = '"+noticeReceiverUserBean.getN_notice_id()+"'");
			sql.append("   and r.n_receiveruser_orgid = '"+noticeReceiverUserBean.getN_receiveruser_orgid()+"'");
			
			if(!StringUtil.isBlank(noticeReceiverUserBean.getOrg_name()) && !("--所属部门--".equals(noticeReceiverUserBean.getOrg_name())) ){
				sql.append(" and org_name='"+noticeReceiverUserBean.getOrg_name()+"'");
			}
			sql.append("       ) dd left join td_sm_userjoborg job on dd.org_id = job.org_id and dd.user_id=job.user_id");
			
			sql.append("  order by org_sn,y");
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	
	/**
	*<b>Summary: </b>
	* selNoticeAndMeetingViewList()
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean selNoticeAndMeetingViewList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		NoticeBaseInfoBean noticeBaseInfoBean = null;
		PagingBean pb = new PagingBean();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				noticeBaseInfoBean = (NoticeBaseInfoBean) JSONObject.parseObject(parmjson, NoticeBaseInfoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select * from (");
			sql.append("select b.n_notice_id,");
			sql.append("       b.n_title,");
			sql.append("       b.n_orgname,");
			sql.append("       b.n_release_userid,");
			sql.append("       b.n_release_username,");
			sql.append("       b.n_release_time,");
			sql.append("       r.n_receiverid,");
			sql.append("       decode(r.n_isview,'0','未查看','1','已查看','2','撤销') as n_state,'0' ismeeting,null m_check_flag,null m_check_flag_name,null m_is_need_signup");
			sql.append("  from oa_notice_baseinfo b, oa_notice_receiver_user r");
			sql.append(" where r.n_notice_id = b.n_notice_id");
			sql.append("   and b.n_state in (1,2) and r.n_isdel != '1'");

			if (noticeBaseInfoBean != null) {
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_creator_userid())) {
					sql.append(" and r.n_receiver_userid = '" + noticeBaseInfoBean.getN_creator_userid() + "'");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_title())) {
					sql.append(" and b.n_title like '%" + noticeBaseInfoBean.getN_title() + "%'");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_orgname())) {
					sql.append(" and b.n_orgname like '%" + noticeBaseInfoBean.getN_orgname() + "%'");
				}
				
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_creator_time()))) {
					sql.append(" and b.n_release_time  >= to_date('" + noticeBaseInfoBean.getN_creator_time()
							+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_release_time()))) {
					sql.append(" and b.n_release_time  <= to_date('" + noticeBaseInfoBean.getN_release_time()
							+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_state()) && !"--请选择--".equals(noticeBaseInfoBean.getN_state())) {
					String n_state = "";
					if("未查看".equals(noticeBaseInfoBean.getN_state())) {
						n_state = "0";
					} else if("已查看".equals(noticeBaseInfoBean.getN_state())) {
						n_state = "1";
					} else if("撤销".equals(noticeBaseInfoBean.getN_state())){
						n_state = "2";
					}
					sql.append(" and r.n_isview = '"+n_state+"'");
				}
				sql.append(" union all select t.m_notice_id n_notice_id,");
				sql.append("               t.m_title,");
				sql.append("               t.m_create_unit_name,");
				sql.append("               t.m_current_user_id,");
				sql.append("               t.m_current_user_name,");
				sql.append("               t.m_current_time,");
				sql.append("               u.m_receiver_id,");
				sql.append(" decode(u.m_is_read, '1', '已查看', '未查看'),'1' ismeeting,t.m_check_flag,t.m_check_flag_name,t.m_is_need_signup");
				sql.append("          from oa_meeting_notice        t,");
				sql.append("               oa_meeting_room          r,");
				sql.append("               oa_meeting_receiver_user u");
				sql.append("         where t.m_room_id = r.m_room_id(+)");
				sql.append("           and t.m_notice_id = u.m_notice_id");
				sql.append("           and u.m_receiver_user_id = '"+noticeBaseInfoBean.getN_creator_userid()+"'");
				sql.append("           and u.m_is_read <> '1'");
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_creator_time()))) {
					sql.append(" and t.m_current_time  >= to_date('" + noticeBaseInfoBean.getN_creator_time()
							+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_release_time()))) {
					sql.append(" and t.m_current_time  <= to_date('" + noticeBaseInfoBean.getN_release_time()
							+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
				}
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_title())) {
					sql.append(" and t.m_title like '%" + noticeBaseInfoBean.getN_title() + "%'");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_orgname())) {
					sql.append(" and t.m_create_unit_name like '%" + noticeBaseInfoBean.getN_orgname() + "%'");
				}
				sql.append("           and (t.m_check_flag = '4' or t.m_check_flag = '5')");				
				
				sql.append(" union all select grinfo_id,　");
				sql.append("               grinfo_titile,");
				sql.append("               grinfo_org,");
				sql.append("               grinfo_sendpersonid,");
				sql.append("               user_realname,");
				sql.append("               grinfo_createtime,");
				sql.append("                pid,");
				sql.append(" decode(staticid, '4', '已查看', '未查看'),'2' ismeeting, null m_check_flag, null m_check_flag_name, null m_is_need_signup ");
				sql.append("          from ( select  a.grinfo_id, ");
				sql.append("    a.grinfo_sendpersonid,  u.user_realname,  a.grinfo_titile, a.grinfo_receptionorg, a.grinfo_startime, ");
				sql.append("   a.grinfo_endtime, a.grinfo_org,a.grinfo_createtime, b.pid, b.staticid, c.grstatus_name, b.userid ");
				sql.append("  from oa_guestreception_info a, td_sm_user u, oa_guestinforeceivelist b, oa_guestreception_type  c ");
				sql.append("  where a.grinfo_sendpersonid=u.user_id and a.grinfo_id=b.grinfo_id and b.staticid=c.grstatus_id ) t ");
				sql.append("   where t.userid ='"+noticeBaseInfoBean.getN_creator_userid()+"'");
				sql.append("           and t.staticid <> '4'");
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_creator_time()))) {
					sql.append(" and grinfo_createtime  >= to_date('" + noticeBaseInfoBean.getN_creator_time()
							+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_release_time()))) {
					sql.append(" and grinfo_createtime  <= to_date('" + noticeBaseInfoBean.getN_release_time()
							+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
				}
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_title())) {
					sql.append(" and grinfo_titile like '%" + noticeBaseInfoBean.getN_title() + "%'");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_orgname())) {
					sql.append(" and grinfo_org like '%" + noticeBaseInfoBean.getN_orgname() + "%' ");
				}
				sql.append(")");
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getIsmeeting())) {
					sql.append(" where ismeeting='"+StringUtil.deNull(noticeBaseInfoBean.getIsmeeting())+"'");
				}
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
			
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selNoticeViewList 等待阅读
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao#selNoticeViewList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean selNoticeViewList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		NoticeBaseInfoBean noticeBaseInfoBean = null;
		PagingBean pb = new PagingBean();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				noticeBaseInfoBean = (NoticeBaseInfoBean) JSONObject.parseObject(parmjson, NoticeBaseInfoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select b.n_notice_id,");
			sql.append("       b.n_title,");
			sql.append("       b.n_unit_name,");
			sql.append("       b.n_release_userid,");
			sql.append("       b.n_release_username,");
			sql.append("       b.n_release_time,");
			sql.append("       r.n_receiverid,");
			sql.append("       decode(r.n_isview,'0','未查看','1','已查看','2','撤销') as n_state ");
			sql.append("  from oa_notice_baseinfo b, oa_notice_receiver_user r");
			sql.append(" where r.n_notice_id = b.n_notice_id");
			sql.append("   and b.n_state in (1,2) and r.n_isdel != '1'");

			if (noticeBaseInfoBean != null) {
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_creator_userid())) {
					sql.append(" and r.n_receiver_userid = '" + noticeBaseInfoBean.getN_creator_userid() + "'");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_title())) {
					sql.append(" and b.n_title like '%" + noticeBaseInfoBean.getN_title() + "%'");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_orgname())) {
					sql.append(" and b.n_orgname like '%" + noticeBaseInfoBean.getN_orgname() + "%'");
				}
				
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_creator_time()))) {
					sql.append(" and b.n_release_time  >= to_date('" + noticeBaseInfoBean.getN_creator_time()
							+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_release_time()))) {
					sql.append(" and b.n_release_time  <= to_date('" + noticeBaseInfoBean.getN_release_time()
							+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
				}
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_select_type()))) {
							sql.append(" and  b.n_select_type  ='"+noticeBaseInfoBean.getN_select_type()+"'");
				}
				
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_state()) && !"--请选择--".equals(noticeBaseInfoBean.getN_state())) {
					String n_state = "";
					if("未查看".equals(noticeBaseInfoBean.getN_state())) {
						n_state = "0";
					} else if("已查看".equals(noticeBaseInfoBean.getN_state())) {
						n_state = "1";
					} else if("撤销".equals(noticeBaseInfoBean.getN_state())){
						n_state = "2";
					}
					sql.append(" and r.n_isview = '"+n_state+"'");
				}
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
			
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public PagingBean selNoticeAuditList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		 AccessControl accesscontroler;
		 accesscontroler = AccessControl.getAccessControl();
		Connection conn = null;
		NoticeBaseInfoBean noticeBaseInfoBean = null;
		//当前用户ID
		String userId =accesscontroler.getUserID();
		PagingBean pb = new PagingBean();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				noticeBaseInfoBean = (NoticeBaseInfoBean) JSONObject.parseObject(parmjson, NoticeBaseInfoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select b.n_notice_id, b.n_title,b.n_creator_userid,b.n_creator_username,");
			sql.append("        to_char(b.n_creator_time,'yyyy-mm-dd hh24:mi')n_creator_time,b.n_unit_name, ");
			sql.append(" decode(b.n_audit_state ,'1','未审核','2','已审核')n_audit_state");
			sql.append("        from oa_notice_baseinfo b  ");
			sql.append("         where  b.n_audit_state  = '1' and b.n_audit_id ='"+userId+"'");
			if (noticeBaseInfoBean != null) {
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_title())) {
					sql.append(" and b.n_title like '%" + noticeBaseInfoBean.getN_title() + "%'");
				}
				// 发起时间
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_creator_time()))) {
					sql.append(" and b.n_creator_time  >= to_date('" + noticeBaseInfoBean.getN_creator_time()
							+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
				}
				// 发起时间
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_release_time()))) {
					sql.append(" and b.n_creator_time  <= to_date('" + noticeBaseInfoBean.getN_release_time()
							+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
			
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public PagingBean selNoticeIsAuditList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		 AccessControl accesscontroler;
		 accesscontroler = AccessControl.getAccessControl();
		Connection conn = null;
		NoticeBaseInfoBean noticeBaseInfoBean = null;
		//当前用户ID
		String userId =accesscontroler.getUserID();
		PagingBean pb = new PagingBean();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				noticeBaseInfoBean = (NoticeBaseInfoBean) JSONObject.parseObject(parmjson, NoticeBaseInfoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append(" select b.n_notice_id, b.n_title,b.n_creator_userid,b.n_creator_username, ");
			sql.append(" to_char(b.n_creator_time,'yyyy-mm-dd hh24:mi')n_creator_time,b.n_unit_name,  ");
			sql.append(" a.id,decode(a.n_audit_state_view,'1','已审核','2','已审核')n_audit_state_view,a.n_view ");
			sql.append(" from oa_notice_baseinfo b  ,oa_notice_audit a   ");
			sql.append("         where  b.n_audit_id ='"+userId+"'  and a.notice_id = b.n_notice_id ");
			if (noticeBaseInfoBean != null) {
				if (!StringUtil.nullOrBlank(noticeBaseInfoBean.getN_title())) {
					sql.append(" and b.n_title like '%" + noticeBaseInfoBean.getN_title() + "%'");
				}
				// 发起时间
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_creator_time()))) {
					sql.append(" and b.n_creator_time  >= to_date('" + noticeBaseInfoBean.getN_creator_time()
							+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
				}
				// 发起时间
				if (!StringUtil.nullOrBlank(StringUtil.deNull(noticeBaseInfoBean.getN_release_time()))) {
					sql.append(" and b.n_creator_time  <= to_date('" + noticeBaseInfoBean.getN_release_time()
							+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
				}
				
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
			
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public Map<String, String> getNoticeIsAuditBaseInfoBean(String n_notice_id,String id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select b.n_notice_id,");
		sql.append("       b.n_title,");
		sql.append("       b.n_content,");
		sql.append("       b.n_creator_userid,");
		sql.append("       b.n_creator_username,");
		sql.append("       b.n_creator_time,");
		sql.append("       b.n_release_userid,");
		sql.append("       b.n_release_username,");
		sql.append("       b.n_release_time,");
		sql.append("       b.n_state,");
		sql.append("       b.n_attach_id,");
		sql.append("       b.n_orgid,");
		sql.append("       b.n_orgname,");
		sql.append("       b.n_unit_id,");
		sql.append("       b.n_unit_name,");
		sql.append("       b.n_unit_or_personal,");
		sql.append("       b.n_isphone,");
		sql.append("       b.n_megtype,");
		sql.append("       b.n_receiver_userid,");
		sql.append("       b.n_receiver_username,");
		sql.append("       b.n_receiver_orgid,");
		sql.append("       b.n_receiver_orgname,");
		sql.append("       b.n_is_msg,");
		sql.append("       b.n_is_sms,");
		sql.append("       b.n_is_mail,");
		sql.append("       b.n_is_rtx,");
		sql.append("       b.n_audit_name,");
		sql.append("       b.n_audit_id,");
		sql.append("       b.n_audit_state,  a.n_view");
		sql.append("  from oa_notice_baseinfo b ,oa_notice_audit a ");
		sql.append(" where b.n_notice_id = ? and b.n_notice_id = a.notice_id and  a.id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), n_notice_id,id);
		
		return viewMap;
	}

	@Override
	public List<NoticeAuditBean> getNoticeAuditBeanView(String n_notice_id,
			Connection conn) throws Exception {
		List<NoticeAuditBean> viewList = new ArrayList<NoticeAuditBean>();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select a.n_view from oa_notice_audit a where a.notice_id =? and a.n_audit_state_view ='2' ");
		NoticeAuditBean bean = new NoticeAuditBean();
		viewList = (List<NoticeAuditBean>) queryToListBean(bean, sql.toString(), n_notice_id);
		return viewList;
	}
	
	/**
	*<b>Summary: </b>
	* selNoticeReportAuditList(公告评论列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selNoticeReportAuditList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception{
		
		Connection conn = null;
		NoticeReportAuditBean noticereportauditbean = null;
		PagingBean pb = new PagingBean();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				noticereportauditbean = (NoticeReportAuditBean) JSONObject.parseObject(parmjson, NoticeReportAuditBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select * from oa_notice_reportaudit  where 1=1 ");

			if (noticereportauditbean != null) {
				if (!StringUtil.nullOrBlank(noticereportauditbean.getNotice_id())) {
					sql.append(" and notice_id = '" + noticereportauditbean.getNotice_id() + "'");
				}
				
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
			
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	/**
	*<b>Summary: </b>
	* getNoticeReportAuditBean(查询公告栏评论信息)
	* @param noticereportauditbean
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String,String> getNoticeReportAuditBean(String  report_id,
														Connection conn)
														throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from oa_notice_reportaudit  where ");
		sql.append("  report_id = ? ");
		viewMap = (Map<String, String>) queryToSingleMap(sql.toString(), report_id);
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* deleteNoticeReportsById(删除评论信息 根据评论ID)
	* @param report_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public String deleteNoticeReportsById(String report_id,Connection conn) throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from oa_notice_reportaudit ");
		sql.append(" where report_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, report_id);
		pdb.executePrepared(conn);
		return "true";
	}

}
