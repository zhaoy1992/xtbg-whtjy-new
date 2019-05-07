package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dataresources.util.DataResourcesUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingReceiverUnitDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUnitBean;
import com.chinacreator.xtbg.core.meeting.util.MeetingConstants;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:MeetingReceiverUnitDaoImpl.java</p>
 *<p>Description:会议单位接收Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-24
 */
public class MeetingReceiverUnitDaoImpl  extends XtDbBaseDao  implements MeetingReceiverUnitDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveMeetingReceiverUnit
	  * @param receiver_unit_ids
	  * @param m_check_flag
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingReceiverUnitDao#saveMeetingReceiverUnit(java.lang.String, java.lang.String)
	 */
	public String saveMeetingReceiverUnit(String m_notice_id, String receiver_unit_ids,
			String m_check_flag, Connection conn) throws Exception {
		String unit_receiver_userids = "";//单位接收人
		String all_org_receiverusers = "";//所有单位的接收人
		String n_receiver_orgidArray[] = null;
		MeetingReceiverUnitBean meetingReceiverUnitBean = new MeetingReceiverUnitBean();
		if(!StringUtil.isBlank(receiver_unit_ids)) {
			n_receiver_orgidArray = receiver_unit_ids.split(",");
			for(int i = 0; i < n_receiver_orgidArray.length; i++) {
				
				meetingReceiverUnitBean = new MeetingReceiverUnitBean();
				meetingReceiverUnitBean.setM_receiver_id(StringUtil.getUUID());
				meetingReceiverUnitBean.setM_notice_id(m_notice_id);
				meetingReceiverUnitBean.setM_receiver_unit_id(n_receiver_orgidArray[i]);
				meetingReceiverUnitBean.setM_receiver_unit_name(DaoUtil.sqlToField("select org_name from td_sm_organization where org_id = '" + n_receiver_orgidArray[i] + "'"));
				if("bufa".equals(m_check_flag)) {
					meetingReceiverUnitBean.setM_is_addrend(MeetingConstants.STATUS_TRUE);
				} else if("chongfa".equals(m_check_flag)) {
					meetingReceiverUnitBean.setM_is_resend(MeetingConstants.STATUS_TRUE);
				}
				insert(meetingReceiverUnitBean, conn);//保存会议接收单位
				// 获得单位接收人
				unit_receiver_userids = DataResourcesUtil.getDataResourcesRecipient(n_receiver_orgidArray[i], "meetingunitresion");
				if(!StringUtil.isBlank(unit_receiver_userids)) {
					all_org_receiverusers += "," + unit_receiver_userids;
				}
				
			}
		}
		return all_org_receiverusers;
	}

	/** 
	  * <b>Summary: </b>
	  *     复写方法 findMeetingReceiverUnitList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingDao#findMeetingReceiverUnitList(com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUnitBean, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean findMeetingReceiverUnitList(MeetingReceiverUnitBean model,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception{
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select t.* from OA_MEETING_RECEIVER_UNIT t where 1=1 ");
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
			sql.append(" order by " + sortName + " " + sortOrder);
			//调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		}finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isMeetingReceiverUnit
	  * @param m_receiver_unit_id
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingReceiverUnitDao#isMeetingReceiverUnit(java.lang.String, java.sql.Connection)
	 */
	public int isMeetingReceiverUnit(String m_receiver_unit_id, Connection conn) throws Exception {
		int ucounts = 0;
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		sql.append("select count(*) as ucounts");
		sql.append("  from oa_meeting_receiver_unit u");
		sql.append(" where u.m_receiver_unit_id = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, m_receiver_unit_id);
		pdb.executePrepared(conn);
		
		if(pdb.size() > 0) {
			ucounts = pdb.getInt(0, ucounts);
		}
		
		return ucounts;
	}
	
}
