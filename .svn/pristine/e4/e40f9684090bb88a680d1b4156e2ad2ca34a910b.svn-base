package com.chinacreator.xtbg.core.common.cache.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.cache.dao.UserCacheDao;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:SystemCacheDaoImpl.java</p>
 *<p>Description:系统缓存Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-16
 */
public class UserCacheDaoImpl implements UserCacheDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getUserCacheList
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.cache.dao.UserCacheDao#getUserCacheList(java.sql.Connection)
	 */
	@Override
	public List<UserCacheBean> getUserCacheList(Connection conn) throws Exception{
		PreparedDBUtil db = new PreparedDBUtil();
		UserCacheBean userCacheBean = null;
		String unit_namesArray[] = null;
		String unit_names = "";
		String orderunit_names = "";
		List<UserCacheBean> userCacheBeanList = new ArrayList<UserCacheBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select o.org_id,");
		sql.append("       o.dept_org,");
		sql.append("       t.user_id,");
		sql.append("       t.user_name,");
		sql.append("       t.user_realname,");
		sql.append("       o.org_name,");
		sql.append("       t.user_mobiletel1,");
		sql.append("       t.user_worktel,");
		sql.append("       t.user_email,");
		sql.append("       t.user_sex,");
		sql.append("       t.user_password,");
		sql.append("       OA_USERPROPERTY(ou.org_id, '1') as unit_name,");
		sql.append("       OA_USERPROPERTY(ou.org_id, '2') as unit_id,");
		sql.append("       OA_USERPROPERTY(ou.org_id, '3') as unit_names,");
		sql.append("       OA_USERPROPERTY(ou.org_id, '4') as unit_ids");
		sql.append("  from (select rownum index_sn, org.org_id, org.org_name,org.dept_org");
		sql.append("          from td_sm_organization org where org.org_id  not in ( ");
		sql.append("          select distinct org_id from td_sm_organization  start with org_id in   ");
		sql.append("          (select distinct org_id from td_sm_organization where remark3='0') connect by prior  org_id=parent_id )  ");
		sql.append("         start with instr((select to_char(wmsys.wm_concat(org_id))");
		sql.append("                            from td_sm_organization cd");
		sql.append("                           where cd.parent_id = '0'),");
		sql.append("                          org.org_id) > 0");
		sql.append("        connect by prior org.org_id = org.parent_id");
		sql.append("         order siblings by org.org_sn) o");
		sql.append("  left join td_sm_orguser ou on ou.org_id = o.org_id");
		sql.append("  left join td_sm_user t on t.user_id = ou.user_id");
		sql.append("  left join td_sm_userjoborg a on a.user_id = ou.user_id");
		sql.append("                              and ou.org_id = a.org_id");
		sql.append(" where (t.user_name is not null)");
		sql.append("   and t.user_isvalid != '3'");
		sql.append(" order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn");
		db.preparedSelect(sql.toString());
		db.executePrepared(conn);
		for(int i = 0; i < db.size(); i++) {
			userCacheBean = new UserCacheBean();
			userCacheBean.setOrg_id(db.getString(i, "org_id"));
			userCacheBean.setUser_id(db.getString(i, "user_id"));
			userCacheBean.setUser_name(db.getString(i, "user_name"));
			userCacheBean.setUser_realname(db.getString(i, "user_realname"));
			userCacheBean.setOrg_name(db.getString(i, "org_name"));
			userCacheBean.setUser_mobiletel1(db.getString(i, "user_mobiletel1"));
			userCacheBean.setUser_worktel(db.getString(i, "user_worktel"));
			userCacheBean.setUser_email(db.getString(i, "user_email"));
			userCacheBean.setUnit_name(db.getString(i, "unit_name"));
			userCacheBean.setUnit_id(db.getString(i, "unit_id"));
			userCacheBean.setUser_sex(db.getString(i, "user_sex"));
			userCacheBean.setUnit_ids(db.getString(i, "unit_ids"));
			userCacheBean.setDept_org(db.getString(i, "dept_org"));
			unit_names = db.getString(i, "unit_names");
			
			if(!StringUtil.isBlank(unit_names)) {
				unit_namesArray = unit_names.split("->");
				for(int j = unit_namesArray.length -1; j >= 0; j--) {
					orderunit_names += unit_namesArray[j] + "->";
				}
				orderunit_names = orderunit_names.substring(0,orderunit_names.length() - 2);
			}
			userCacheBean.setUnit_names(orderunit_names);
			userCacheBean.setUser_password(db.getString(i, "user_password"));
			userCacheBeanList.add(userCacheBean);
		}
		return userCacheBeanList;
	}

}
