package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.tree.dao.ResourceConfigDao;
import com.chinacreator.xtbg.core.common.tree.dao.impl.ResouceConfigDaoImpl;
import com.chinacreator.xtbg.core.common.tree.entity.ResourceRoleUserBean;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingReceiverUserDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUserBean;
import com.chinacreator.xtbg.core.meeting.util.MeetingConstants;
import com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao;

/**
 * 
 *<p>Title:MeetingReceiverUserDaoImpl.java</p>
 *<p>Description:会议接收人Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-24
 */
public class MeetingReceiverUserDaoImpl extends XtDbBaseDao implements MeetingReceiverUserDao {
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveMeetingReceiverUser
	  * @param m_notice_id
	  * @param receiver_user_ids
	  * @param m_check_flag
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingReceiverUserDao#saveMeetingReceiverUser(java.lang.String, java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean saveMeetingReceiverUser(String m_notice_id, List<String> allUserReceiverUser, String m_check_flag, Connection conn) throws Exception {
		boolean flag = false;
		Map<String, String> map = null;
		Map<String, String> viewMap = null;
		MeetingReceiverUserBean meetingReceiverUserBean = null;
		ResourceConfigDao resourceConfigDao = new ResouceConfigDaoImpl();
		UserManagerDao userManagerDao = (UserManagerDao)LoadSpringContext.getApplicationContext().getBean("userManagerDaoImpl");
		for (int j = 0; j < allUserReceiverUser.size(); j++) {
			map = this.findMeetingReceiverUserDetail(m_notice_id, allUserReceiverUser.get(j), conn);
			if(map.size()==0){
				meetingReceiverUserBean = new MeetingReceiverUserBean();
				meetingReceiverUserBean.setM_receiver_id(StringUtil.getUUID());
				meetingReceiverUserBean.setM_notice_id(m_notice_id);
				meetingReceiverUserBean.setM_receiver_user_id(allUserReceiverUser.get(j));
				ResourceRoleUserBean resourceRoleUserBean = resourceConfigDao.queryUserMatchOrg(allUserReceiverUser.get(j));//获取用户所属的单位
				meetingReceiverUserBean.setM_receiver_user_name(resourceRoleUserBean.getUsername());
				meetingReceiverUserBean.setM_receiver_unit_id(resourceRoleUserBean.getOrgid());
				meetingReceiverUserBean.setM_receiver_unit_name(resourceRoleUserBean.getOrgname());
				if("bufa".equals(m_check_flag)) {
					meetingReceiverUserBean.setM_is_addrend(MeetingConstants.STATUS_TRUE);
				} else if("chongfa".equals(m_check_flag)) {
					meetingReceiverUserBean.setM_is_resend(MeetingConstants.STATUS_TRUE);
				} else if("zhuangfa".equals(m_check_flag)){
					meetingReceiverUserBean.setM_is_other("1");//转发的在这里标记
					meetingReceiverUserBean.setM_is_addrend(MeetingConstants.STATUS_TRUE);
				}
				//加入电话 2013-09-10
				viewMap = userManagerDao.getUserBean(allUserReceiverUser.get(j), conn);
				if(!StringUtil.nullOrBlank(viewMap.get("user_mobiletel1"))){
					meetingReceiverUserBean.setM_link_tel(viewMap.get("user_mobiletel1"));
				}
			    insert(meetingReceiverUserBean, conn);//保存会议接收人信息
			}
		}
		flag = true;
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findMeetingReceiverUserList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingReceiverUserDao#findMeetingReceiverUserList(com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUserBean, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean findMeetingReceiverUserList(MeetingReceiverUserBean model,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception{
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append(" select t.*,(SELECT MIN(same_job_user_sn) y FROM td_sm_userjoborg  WHERE  user_id = t.m_receiver_user_id) y from OA_MEETING_RECEIVER_USER t,");
			sql.append(" (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org start with org.org_id in  ");
			sql.append(" (select org_id from td_sm_organization cd where cd.parent_id = '0') connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o ");
			sql.append(" where 1=1 and o.org_id=t.m_receiver_unit_id and t.m_is_other is null " );
			if (MeetingConstants.REPLY_YES.equalsIgnoreCase(StringUtil.deNull(model.getM_is_reply()))){//已报名
				sql.append(" and (t.m_is_reply = '"+MeetingConstants.REPLY_YES+"'  or t.m_is_reply = '"+MeetingConstants.REPLY_2+"' or t.m_is_reply = '"+MeetingConstants.REPLY_3+"' )");
			}else if ("no".equalsIgnoreCase(StringUtil.deNull(model.getM_is_reply()))){
				sql.append(" and ( t.m_is_reply = '"+MeetingConstants.REPLY_9+"' or t.m_is_reply = '"+MeetingConstants.REPLY_NO+"' )");
			}
			
			if(!StringUtil.nullOrBlank(model.getM_notice_id())){
				sql.append(" and t.m_notice_id = '"+model.getM_notice_id()+"'");
			}
			if(!StringUtil.nullOrBlank(model.getM_is_read())){
				sql.append(" and t.m_is_read = '"+model.getM_is_read()+"'");
			}
			sql.append(" order by to_number(o.index_sn) ,y");
			//调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		}finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findMeetingReceiverUserDetail
	  * @param m_notice_id
	  * @param m_user_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingReceiverUserDao#findMeetingReceiverUserDetail(java.lang.String, java.lang.String) 
	  */
	public Map<String, String> findMeetingReceiverUserDetail(
			String m_notice_id, String m_user_id, Connection conn)
			throws Exception {

		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" t.m_receiver_id,");
		sql.append(" t.m_notice_id,");
		sql.append(" t.m_receiver_user_id,");
		sql.append(" t.m_receiver_user_name,");
		sql.append(" t.m_receiver_unit_id,");
		sql.append(" t.m_receiver_unit_name,");
		sql.append(" t.m_is_other,");
		sql.append(" t.m_create_time,");
		sql.append(" t.m_is_addrend,");
		sql.append(" t.m_is_resend,");
		sql.append(" t.m_is_call,");
		sql.append(" t.m_call_type,");
		sql.append(" t.m_is_reply,");
		sql.append(" t.m_reply,");
		sql.append(" t.m_reply_time,");
		sql.append(" t.m_is_read,");
		sql.append(" t.m_read_time,");
		sql.append(" t.m_link_user_id,");
		sql.append(" t.m_link_user_name,");
		sql.append(" t.m_link_tel,");
		sql.append(" t.m_is_log,");
		sql.append(" t.m_attender_count,");
		sql.append(" t.m_attender_ids,");
		sql.append(" t.m_attender_names,");
		sql.append(" t.m_is_reply_name");
		sql.append(" from oa_meeting_receiver_user t");
		sql.append(" where t.m_notice_id = ? and t.m_receiver_user_id = ? and rownum = 1");
		viewMap = queryToSingleMap(conn, sql.toString(), m_notice_id, m_user_id);
		return viewMap;
	}
}
