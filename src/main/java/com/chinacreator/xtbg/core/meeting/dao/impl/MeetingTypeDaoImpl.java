package com.chinacreator.xtbg.core.meeting.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingTypeDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:MeetingTypeDao.java
 * </p>
 *<p>
 * Description:会议类型管理dao接口
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-21
 */
public class MeetingTypeDaoImpl extends XtDbBaseDao implements MeetingTypeDao {
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findMeetingTypePageBean
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingTypeDao#findMeetingTypePageBean(com.chinacreator.xtbg.core.meeting.entity.MeetingTypeBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findMeetingTypePageBean(MeetingTypeBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			sql
					.append(" select m_type_id, m_type_code, m_type_name, m_unit_id,"
							+ " m_unit_name,m_is_use_flag, "
							+ "to_char(m_is_use_time, 'yyyy-mm-dd')"
							+ " as m_is_use_time, m_reg_user_id, "
							+ " m_reg_user_name, to_char(m_reg_time, 'yyyy-mm-dd')"
							+ " as m_reg_time, m_remark "
							+ " from oa_meeting_type where m_type_id is not null ");
			if (!StringUtil.nullOrBlank(bean.getM_unit_id())) {
				sql.append("and m_unit_id=?");
				conditionValues.add(StringUtil.deNull(bean.getM_unit_id().trim()));
			}
			if (!StringUtil.nullOrBlank(bean.getM_type_name())) {
				sql.append("and m_type_name  like '%'||?||'%' ");
				conditionValues.add(StringUtil.deNull(bean.getM_type_name().trim()));
			}
			sql.append(" order by " + sortName + " " + sortOrder);

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	

	/**
	 * 
	*<b>Summary:判断会议类型是否已经被引用 </b>
	* isMeetingTypeUsed(请用一句话描述这个方法的作用)
	* @param id  会议类型id
	* @param conn 数据库连接
	* @return    是否存在的表示， true ：已经被引用 false：尚未被引用
	* @throws SQLException 数据库操作
	 */
	public boolean isMeetingTypeUsed(String id, Connection conn)
			throws SQLException {

		if (StringUtil.nullOrBlank(id)) {
			return false;
		}
		StringBuffer sql = new StringBuffer("select count(*) count"
				+ " from oa_meeting_notice where m_type_id = ?");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, id.trim());
		pdb.executePrepared(conn);
		if (pdb.size() >= 0) {
			// 得到记录数
			int count = pdb.getInt(0, 0);
			// 存在一条及以上被引用的记录，则返回true，表示会议类型已经被使用
			if (count > 0) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 
	*<b>Summary: 根据会议类型名名，机构id判断会议类型是否已经存在</b>
	* isMeetingTypeExist(请用一句话描述这个方法的作用)
	* @param typeName  会议类型名
	* @param orgId    机构id
	* @return         是否存在的bolean值。存在：true，不存在：false
	 * @throws Exception 
	 */
	public boolean isMeetingTypeExist(String typeName,String orgId,Connection conn) throws Exception{
		
		StringBuffer sql = new StringBuffer("select count(*) count"
				+ " from oa_meeting_type where m_type_name = ? and m_unit_id=?");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, typeName);
		pdb.setString(2, orgId);
		pdb.executePrepared(conn);
		if (pdb.size() >= 0) {
			// 得到记录数
			int count = pdb.getInt(0, 0);
			// 存在一条及以上记录，则返回true，表示会议类型已经存在
			if (count > 0) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryListMeetingTypeByOrgId
	  * @param orgId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.meeting.dao.MeetingTypeDao#queryListMeetingTypeByOrgId(java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingTypeBean> queryListMeetingTypeByOrgId(String orgId) throws Exception{
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append(" select m_type_id, m_type_code, m_type_name, m_unit_id,"
				+ " m_unit_name,m_is_use_flag, "
				+ "to_char(m_is_use_time, 'yyyy-mm-dd')"
				+ " as m_is_use_time, m_reg_user_id, "
				+ " m_reg_user_name, to_char(m_reg_time, 'yyyy-mm-dd')"
				+ " as m_reg_time, m_remark "
				+ " from oa_meeting_type where m_is_use_flag ='1' and m_unit_id=?");
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, orgId);
			//调父类的方法
			return pdb.executePreparedForList(conn,MeetingTypeBean.class);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
}
