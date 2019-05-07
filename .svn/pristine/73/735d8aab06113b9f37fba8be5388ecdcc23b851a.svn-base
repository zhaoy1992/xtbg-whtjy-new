package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.tree.dao.ResourceConfigDao;
import com.chinacreator.xtbg.core.common.tree.dao.impl.ResouceConfigDaoImpl;
import com.chinacreator.xtbg.core.common.tree.entity.ResourceRoleUserBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingAttenderDao;
import com.chinacreator.xtbg.core.meeting.dao.MeetingDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingAttenderBean;
import com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc;
import com.chinacreator.xtbg.core.sysparam.service.impl.SysParamServiceImpl;

/**
 * 
 *<p>Title:MeetingAttenderDaoImpl.java</p>
 *<p>Description:议参会人dao服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-26
 */
public class MeetingAttenderDaoImpl extends XtDbBaseDao implements MeetingAttenderDao {

	public List<Map<String,String>> getMeetingAttenderList(Map<String,String> map) throws Exception {
		String m_notice_id = StringUtil.deNull(map.get("m_notice_id"));
		String gg_ids = StringUtil.deNull(map.get("m_receiver_other_unit_ids"));//公共通讯录   
		String gr_ids = StringUtil.deNull(map.get("m_receiver_other_user_ids"));//个人通讯录
		String person_ids = "";
		if (!StringUtil.nullOrBlank(gg_ids) && !StringUtil.nullOrBlank(gr_ids)){
			person_ids = gg_ids+","+gr_ids;
		}else if (!StringUtil.nullOrBlank(gg_ids)){
			person_ids = gg_ids;
		}else if (!StringUtil.nullOrBlank(gr_ids)){
			person_ids = gr_ids;
		}
		if (!StringUtil.nullOrBlank(person_ids)){
			person_ids = "'"+person_ids.replaceAll(",", "','")+"'";
		}else{
			person_ids = "''";
		}
		String m_link_tel = "''";
		Map<String, String> viewMap = new HashMap<String, String>();
		SysParamServiceIfc SysParamServiceIfc=new SysParamServiceImpl();
		viewMap=SysParamServiceIfc.getSysParamByPcode("linktel");
		if (viewMap.size()>0){
			String p_content = StringUtil.deNull(viewMap.get("p_content"));
			if("0".equalsIgnoreCase(p_content)){
				m_link_tel = "v.user_worktel";
			}else if ("1".equalsIgnoreCase(p_content)){
				m_link_tel = "v.user_mobiletel1";
			}
		}
		StringBuffer sql = new StringBuffer();
		sql.append(" select rownum id,rr.* from (select r.* from (");
		sql.append(" select v.user_realname username,v.org_name userunit,'' userposition, "+m_link_tel+" usertel from (");
		sql.append("    select a.m_user_id ");//参加的
		sql.append("      from oa_meeting_attender a, oa_meeting_receiver_user u");
		sql.append("     where a.m_receiver_id = u.m_receiver_id and u.m_is_reply <> '9'");
		sql.append("       and u.m_notice_id = '"+m_notice_id+"'");
		sql.append("    union");
		sql.append("    select u.m_receiver_user_id");//接收人
		sql.append("      from oa_meeting_receiver_user u");
		sql.append("     where u.m_notice_id = '"+m_notice_id+"'");
		sql.append("       and u.m_is_reply <> '9'");
		sql.append(" ) dd inner join V_USER_ORG_INFO v on v.user_id=dd.m_user_id ");
		sql.append(" union all ");
		sql.append(" select t.name username,d3.field_value userunit,d2.field_value userposition, d.field_value usertel");
		sql.append("      from oa_personwork_personinfo t ");
		sql.append("      left join oa_personwork_extrainfo d  on d.field_name = '办公手机'    and t.person_id= d.person_id");
		sql.append("      left join oa_personwork_extrainfo d2 on d2.field_name = 'position' and t.person_id=d2.person_id");
		sql.append("      left join oa_personwork_extrainfo d3 on d3.field_name = 'company'  and t.person_id=d3.person_id");
		sql.append("     where 1=1 ");
		sql.append("       and t.person_id in ("+person_ids+")");
		sql.append(") r order by r.username ) rr ");
		return queryToListMap(sql.toString());
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveMeetingAttender
	  * @param m_receiver_id
	  * @param m_attender_ids
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingAttenderDao#saveMeetingAttender(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean saveMeetingAttender(String m_receiver_id, String m_attender_ids, Connection conn) throws Exception{
		String[] m_attender_idsArray = null;
		MeetingAttenderBean meetingAttenderBean = null;
		MeetingDao meetingDao = null;
		ResourceConfigDao resourceConfigDao = new ResouceConfigDaoImpl();
		if(!StringUtil.isBlank(m_attender_ids)) {
			meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			meetingAttenderBean = new MeetingAttenderBean();
			meetingAttenderBean.setDeleteKey("m_receiver_id");
			((BaseDao)meetingDao).deleteListById(meetingAttenderBean,conn, m_receiver_id);//先清空再重新插入
			m_attender_idsArray = m_attender_ids.split(",");
			for(int i = 0; i < m_attender_idsArray.length; i++) {
				meetingAttenderBean = new MeetingAttenderBean();
				meetingAttenderBean.setM_id(StringUtil.getUUID());
				meetingAttenderBean.setM_receiver_id(m_receiver_id);
				meetingAttenderBean.setM_user_id(m_attender_idsArray[i]);
				ResourceRoleUserBean resourceRoleUserBean = resourceConfigDao.queryUserMatchOrg(m_attender_idsArray[i]);//获取用户所属的单位
				meetingAttenderBean.setM_user_name(resourceRoleUserBean.getUsername());
				meetingAttenderBean.setM_unit_id(resourceRoleUserBean.getOrgid());
				meetingAttenderBean.setM_unit_name(resourceRoleUserBean.getOrgname());
				((BaseDao)meetingDao).insert(meetingAttenderBean, conn);
			}
		}
		return false;
	}
	
	

}
