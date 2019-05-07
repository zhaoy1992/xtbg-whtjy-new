package com.chinacreator.xtbg.core.meeting.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingTypeBean;

/**
 * 
 *<p>Title:MeetingTypeDao.java</p>
 *<p>Description:会议类型管理dao接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-21
 */
public interface MeetingTypeDao {

	/**
	 * 
	*<b>Summary:查询会议类型列表数据 </b>
	* findMeetingTypePageBean(请用一句话描述这个方法的作用)
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findMeetingTypePageBean(MeetingTypeBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	
	/**
	 * 
	*<b>Summary:判断会议类型是否已经被引用 </b>
	* isMeetingTypeUsed(请用一句话描述这个方法的作用)
	* @param id  会议类型id
	* @param conn 数据库连接
	* @return    是否存在的表示， true ：已经被引用 false：尚未被引用
	* @throws SQLException 数据库操作异常
	 */
	public boolean isMeetingTypeUsed(String id, Connection conn)
			throws SQLException ;
	
	/**
	 * 
	 *<b>Summary: 根据xtdbBaseBean信息查询结果并封装成一个XtDbBaseBean,用于显示数据</b></br>
	 * 注意！！：必须要设置主键的值否则，只查出所有数据中的第一条记录
	 * 
	 * @param xtdbBaseBean
	 *            底层持久对象
	 * @return XtDbBaseBean
	 * @throws Exception
	 */
	public XtDbBaseBean queryToBean(XtDbBaseBean xtdbBaseBean) throws Exception;

    /**
     * 
    *<b>Summary:根据机构id查询会议类型信息 </b>
    * queryListMeetingTypeByOrgId()
    * @param orgId
    * @return
    * @throws Exception
     */
	public List<MeetingTypeBean> queryListMeetingTypeByOrgId(String orgId) throws Exception;
}
