package com.chinacreator.xtbg.core.purviewmanager.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.purviewmanager.dao.GroupDao;
import com.chinacreator.xtbg.core.purviewmanager.entity.GroupBean;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserBean;
/**
 * 
 *<p>Title:GroupDaoImpl.java</p>
 *<p>Description:用户组接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-2
 */
public class GroupDaoImpl extends XtDbBaseDao implements GroupDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selGroupList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.GroupDao#selGroupList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selGroupList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		GroupBean groupBean= new GroupBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				groupBean = (GroupBean) JSONObject.parseObject(parmjson, GroupBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("  select * from ( ");
			sql.append(" select g.group_id,g.group_name,g.group_desc,g.parent_id, ");
			sql.append("  g.owner_id, u.user_name || '【' || u.user_realname || '】' remark5 ");
			sql.append("  from td_sm_group g left join td_sm_user u on g.owner_id = u.user_id ) ");
			sql.append("  where 1=1");
			
			if(groupBean!=null){
				if (!StringUtil.nullOrBlank(groupBean.getGroup_name())) {
					sql.append(" and group_name like '%'||?||'%'");
					condition.add(groupBean.getGroup_name());
				}
				if (!StringUtil.nullOrBlank(groupBean.getGroup_desc())) {
					sql.append(" and group_desc like '%'||?||'%'");
					condition.add(groupBean.getGroup_desc());
				}
				if (!StringUtil.nullOrBlank(groupBean.getRemark5())) {
					sql.append(" and remark5 like '%'||?||'%'");
					condition.add(groupBean.getRemark5());
				}
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selUserGroupList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.GroupDao#selUserGroupList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selUserGroupList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		UserBean userBean= new UserBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				userBean = (UserBean) JSONObject.parseObject(parmjson, UserBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("  select t.user_id, t.user_name, t.user_realname, ");
			sql.append("   decode(t.user_mobiletel1,'',t.user_mobiletel1,t.user_mobiletel1) user_mobiletel1,t.org_id, t.org_name, t.group_id ");
			sql.append("  from (select u.*, o.*, g.*  from td_sm_user u  ");
			sql.append("   left join td_sm_usergroup ug on u.user_id = ug.user_id ");
			sql.append(" left join td_sm_orguser ou on ou.user_id = u.user_id ");
			sql.append(" left join td_sm_organization o on ou.org_id = o.org_id ");
			sql.append("   left join td_sm_group g on ug.group_id = g.group_id) t ");
			sql.append("  where 1=1");
			
			if(userBean!=null){
				if (!StringUtil.nullOrBlank(userBean.getRemark1())) {
					sql.append(" and t.group_id = ? ");
					condition.add(userBean.getRemark1());
				}
				if (!StringUtil.nullOrBlank(userBean.getUser_realname())) {
					sql.append(" and t.user_realname like '%'||?||'%'");
					condition.add(userBean.getUser_realname());
				}
				if (!StringUtil.nullOrBlank(userBean.getUser_name())) {
					sql.append(" and t.user_name like '%'||?||'%'");
					condition.add(userBean.getUser_name());
				}
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

}
