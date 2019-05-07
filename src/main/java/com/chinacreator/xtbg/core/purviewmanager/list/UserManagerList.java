package com.chinacreator.xtbg.core.purviewmanager.list;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.sqltransition.api.factorys.RecursiveQueryFactory;
import com.chinacreator.sqltransition.api.interfaces.IRecursiveQuery;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:UserManagerList.java</p>
 *<p>Description:用户查询列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-24
 */
public class UserManagerList extends DataInfoImpl {

	private static final Logger LOG = Logger.getLogger(UserManagerList.class);
	/**
	 * 
	 * <b>Summary: </b> 复写方法 getDataList
	 * 
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {

		String userName = "";
		String userRealname = "";
		String orgId = "";
		String recursion = "";
		String userIsvalid = "";
		String userSex = "";
		String isOrgManager = "";
		String userType = "";
		String orgjob = "";
		PagingBean pagingBean = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		UserBean userBeanParm = null;// 查询参数

		try {

			if (!StringUtil.isBlank(parmjson)) {// 查询参数转换为对应的bean
				parmjson = DataControlUtil.replaceStr(parmjson);
				userBeanParm = (UserBean) JSONObject.parseObject(parmjson, UserBean.class);
			} else {
				userBeanParm = new UserBean();
			}
			
			userName = userBeanParm.getUser_name();
			userRealname = userBeanParm.getUser_realname();
			orgId = userBeanParm.getOrg_id();
			recursion = userBeanParm.getIntervalType();
			userIsvalid = userBeanParm.getUser_isvalid();
			userSex = userBeanParm.getUser_sex();
			isOrgManager = userBeanParm.getIsOrgManager();
			userType = userBeanParm.getUser_type();
			
			StringBuffer sb_user = new StringBuffer();
			/*sb_user.append("select a.*,'")
					.append(orgId)
					.append("' as org_id,getUserorgjobinfos(to_char(a.user_id) || '') as org_job,(SELECT  MIN (same_job_user_sn) y ")
					.append("FROM td_sm_userjoborg WHERE org_id = '")
					.append(orgId).append("' and user_id=a.user_id) y from ");*/
			sb_user.append("select a.*,");
			sb_user.append("       org_user.org_id as org_id,");
			sb_user.append("       getUserorgjobinfos(to_char(a.user_id) || '') as org_job,");
			sb_user.append("       (SELECT MIN(same_job_user_sn) y");
			sb_user.append("          FROM td_sm_userjoborg");
			sb_user.append("         WHERE org_id in (select t.org_id");
			sb_user.append("                  from td_sm_organization t");
			sb_user.append("                  start with t.org_id = '"+orgId+"' ");
			sb_user.append("                connect by prior t.org_id = t.parent_id");
			sb_user.append("                       ) ");
			sb_user.append("           and user_id = a.user_id) y");

			if (!StringUtil.isBlank(isOrgManager)) {
				/*sb_user
				.append(" td_sm_user a where a.user_id in(select user_id from td_sm_orgmanager where org_id='")
				.append(orgId).append("') ");*/
				
				sb_user.append(" from td_sm_user a,td_sm_orguser org_user,td_sm_organization orggan  where org_user.org_id = orggan.org_id and a.user_id=org_user.user_id and a.user_id in(select user_id from td_sm_orgmanager where org_id in(");
				sb_user.append("select t.org_id");
				sb_user.append("                  from td_sm_organization t");
				sb_user.append("                  start with t.org_id = '"+orgId+"' ");
				sb_user.append("                connect by prior t.org_id = t.parent_id");
				sb_user.append("                       ))");
			} else {
				/*sb_user
				.append(" td_sm_user a ")
				.append(" where a.user_id in (select distinct user_id from td_sm_userjoborg where org_id='")
				.append(orgId).append("') ");*/
				
				sb_user.append(" from td_sm_user a ,td_sm_orguser org_user,td_sm_organization orggan  ");
				sb_user.append(" where org_user.org_id = orggan.org_id and a.user_id=org_user.user_id and a.user_id in (select distinct user_id from td_sm_userjoborg where org_id in(");
				sb_user.append("select t.org_id");
				sb_user.append("                  from td_sm_organization t");
				sb_user.append("                  start with t.org_id = '"+orgId+"' ");
				sb_user.append("                connect by prior t.org_id = t.parent_id");
				sb_user.append("                      ))");
			}

			if (!StringUtil.isBlank(userName)) {
				sb_user.append("and a.user_name like '%" + userName + "%' ");
			}
			
			if (!StringUtil.isBlank(userRealname)) {
				sb_user.append("and a.user_realname like '%" + userRealname + "%' ");
			}

			if (!StringUtil.isBlank(userSex) && (!("NaN".equals(userSex)))) {
				sb_user.append("and a.user_sex ='" + userSex + "' ");
			}

			if (!StringUtil.isBlank(userType) && (!("NaN".equals(userType)))) {
				sb_user.append("and a.user_type ='").append(userType).append("' ");
			}

			if (!StringUtil.isBlank(userIsvalid) && (!("NaN".equals(userIsvalid)))) {
				sb_user.append("and a.user_Isvalid =" + userIsvalid + " ");
			}
			
			sb_user.append("order by orggan.org_sn,y,a.user_id");

			if ((recursion != null) && (recursion != "") && (recursion.equals("1"))) {
				StringBuffer rec_user = new StringBuffer();
				StringBuffer sub_user = new StringBuffer();
				if (!StringUtil.isBlank(userName)) {
					sub_user.append("and t.user_name like '%" + userName + "%' ");
				}

				if (!StringUtil.isBlank(userRealname)) {
					sub_user.append("and t.user_realname like '%" + userRealname + "%' ");
				}

				if (!StringUtil.isBlank(userSex) && (!("NaN".equals(userSex)))) {
					sub_user.append("and t.user_sex ='" + userSex + "' ");
				}
				if (!StringUtil.isBlank(userIsvalid) && (!("NaN".equals(userIsvalid)))) {
					sub_user.append("and t.user_Isvalid =" + userIsvalid + " ");
				}
				
				String temp = getRecOrderUserSql(orgId, sub_user.toString(),isOrgManager);
				rec_user.append(temp);
				sql = rec_user;
				
			} else {
				sql = sb_user;
			}

			
			
			pdb.preparedSelect(sql.toString(),offset,maxPagesize);
			pdb.executePrepared();
			List<UserBean> userBeanlist = new ArrayList<UserBean>();
			
			for (int i = 0; i < pdb.size(); i++) {
				String userid = pdb.getString(i, "user_id");
				
				PreparedDBUtil pdb1 = new PreparedDBUtil();
				String str = "select getUserorgjobinfos('" + userid + "') as org from dual";
				
				pdb1.executeSelect(str);
				if ( pdb1.size() > 0) {
					orgjob = pdb1.getString(0, "org");
				}
				
				if (orgjob.endsWith("、")) {
					orgjob = orgjob.substring(0, orgjob.length() - 1);
				}
				
				UserBean userBean = new UserBean();
				userBean.setUser_id(pdb.getString(i, "user_id"));
				userBean.setUser_name(pdb.getString(i, "user_name"));
				userBean.setUser_realname(pdb.getString(i, "user_realname"));
				userBean.setUser_mobiletel1(pdb.getString(i, "user_mobiletel1"));
				userBean.setUser_type(pdb.getString(i, "user_type"));
				userBean.setUser_email(pdb.getString(i, "user_email"));
				userBean.setUser_sex(pdb.getString(i, "user_sex"));
				userBean.setUser_isvalid(pdb.getString(i, "user_isvalid"));
				userBean.setOrg_Name(orgjob);
				userBean.setOrg_id(pdb.getString(i, "org_id"));
				userBeanlist.add(userBean);
			}
			pagingBean.setList(userBeanlist);
			pagingBean.setRecords((long)pdb.getTotalSize());
			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return null;
		}
		return pagingBean;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName, String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 
	*<b>Summary: </b>
	* getRecOrderUserSql(用户记录排序)
	* @param orgId
	* @param wherestr
	* @param isOrgManager
	* @return
	 */
	private String getRecOrderUserSql(String orgId, String wherestr, String isOrgManager) {
		String oid = "0";
		if (orgId.matches("\\d+")) {
			oid = orgId;
		}

		IRecursiveQuery iRecursiveQuery = RecursiveQueryFactory.getIRecursiveQueryInstance();

		List querylist = new ArrayList();
		querylist = iRecursiveQuery.query("td_sm_organization", new String[] { "org_id" }, "org_id", "=", "'" + oid + "'", "parent_id", "", 2);

		StringBuffer sql = new StringBuffer()
				.append(" select  bb.same_job_user_sn,getUserorgjobinfos(to_char(t.user_id) || '') as org_job,  ")
				.append(" t.*, a.org_id,a.org_sn from  ")
				.append(" (select rownum as num,org_sn, a.org_id  from td_sm_organization a where a.org_id in('");

		if ((null != querylist) && (querylist.size() > 0)) {
			for (int i = 0; i < querylist.size(); ++i) {
				Map map = (Map) querylist.get(i);
				if (null != map) {
					sql.append(map.get("org_id"));
					if (i != querylist.size() - 1) {
						sql.append("','");
					}
				}
			}
		}

		sql
			.append("')) a, ")
			.append(" ( select min(tmp.same_job_user_sn) as same_job_user_sn,tmp.org_id,tmp.user_id from (  ")
			.append(" (select ujo.* from td_sm_userjoborg ujo)")
			.append(" )tmp group by  tmp.user_id ,tmp.org_id   ")
			.append("  ) bb, ");

		if ((isOrgManager != null) && (!("".equals(isOrgManager)))) {
			sql.append("(select a.* from td_sm_user a, td_sm_orgmanager b where a.user_id = b.user_id) t ");
		} else {
			sql.append(" td_sm_user t  ");
		}
		sql.append(" where a.org_id=bb.org_id and bb.user_id=t.user_id  ")
		   .append(wherestr).append(" order by a.num,bb.same_job_user_sn,t.user_id ");

		return sql.toString();
	}
	

}
