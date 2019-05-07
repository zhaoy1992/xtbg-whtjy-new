package com.chinacreator.xtbg.pub.personwork.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.personwork.dao.PersonInfoDao;
import com.chinacreator.xtbg.pub.personwork.entity.ListShowUtilBean;
import com.chinacreator.xtbg.pub.personwork.entity.PersonExtraInfoBean;
import com.chinacreator.xtbg.pub.personwork.entity.PersonExtraShowBean;
import com.chinacreator.xtbg.pub.personwork.entity.PersonInfoBean;
import com.chinacreator.xtbg.pub.personwork.entity.PersonSearchBean;
import com.chinacreator.xtbg.pub.personwork.entity.PublicAddressDirectoryBean;
import com.chinacreator.xtbg.pub.tree.dao.impl.TreeBusinessDaoImpl;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DictDropDownList;
import com.chinacreator.xtbg.pub.util.PinyinUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class PersonInfoDaoImpl implements PersonInfoDao {

	private static final Logger LOG = Logger.getLogger(PersonInfoDaoImpl.class);
	
	@Override
	public PagingBean findPersonalAddressBookList(PersonSearchBean personSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<PersonInfoBean> list = new ArrayList<PersonInfoBean>();
		StringBuffer sql = new StringBuffer();
		/*sql.append("select distinct(t.person_id), ");
		sql.append("       name,");
		sql.append("       (select t1.field_value");
		sql.append("          from ta_oa_personwork_extrainfo t1");
		sql.append("         where t1.person_id = t.person_id");
		sql.append("           and t1.field_name = 'qq'   and rownum = 1) qq,");
		sql.append("       (select t1.field_value");
		sql.append("          from ta_oa_personwork_extrainfo t1");
		sql.append("         where t1.person_id = t.person_id");
		sql.append("           and t1.field_name = '常用手机'   and rownum = 1) commonlymobile,");
		sql.append("       (select t1.field_value");
		sql.append("          from ta_oa_personwork_extrainfo t1");
		sql.append("         where t1.person_id = t.person_id");
		sql.append("           and t1.field_name = '电子邮箱'   and rownum = 1) email,");
		sql.append("       (select wmsys.wm_concat(g.group_name) ");
		sql.append("  		from ta_oa_personwork_group g");
		sql.append(" 		inner join ta_oa_personwork_persongroup t1 on t1.group_id = g.group_id");
		sql.append(" 		where t.person_id = t1.person_id) group_name,");
		sql.append("       (select wmsys.wm_concat(t1.group_id) ");
		sql.append(" 		from ta_oa_personwork_persongroup t1 ");
		sql.append(" 		where t.person_id = t1.person_id) group_id");
		sql.append("  		from ta_oa_personwork_personinfo t");
		sql.append("  		 left join ta_oa_personwork_extrainfo e on t.person_id = e.person_id");
		sql.append(" where t.user_id = ?");
		sql.append("  and t.info_type = 'personal' ");*/
		
		
		
		
		/*sql.append(" select * from( ");
		sql.append(" select distinct (t.person_id), ");
		sql.append("            name, ");
		sql.append("            (select t1.field_value ");
		sql.append("               from ta_oa_personwork_extrainfo t1 ");
		sql.append("              where t1.person_id = t.person_id ");
		sql.append("                and t1.field_name = 'qq' ");
		sql.append("                and rownum = 1) qq, ");
		sql.append("            (select t1.field_value ");
		sql.append("               from ta_oa_personwork_extrainfo t1 ");
		sql.append("              where t1.person_id = t.person_id ");
		sql.append("                and t1.field_name = '常用手机' ");
		sql.append("                and rownum = 1) commonlymobile, ");
		sql.append("            (select t1.field_value ");
		sql.append("               from ta_oa_personwork_extrainfo t1 ");
		sql.append("              where t1.person_id = t.person_id ");
		sql.append("                and t1.field_name = '电子邮箱' ");
		sql.append("                and rownum = 1) email, ");
		sql.append("            (select to_char(wmsys.wm_concat(g.group_name)) ");
		sql.append("               from ta_oa_personwork_group g ");
		sql.append("              inner join ta_oa_personwork_persongroup t1 on t1.group_id = ");
		sql.append("                                                            g.group_id ");
		sql.append("              where t.person_id = t1.person_id) group_name, ");
		sql.append("            (select to_char(wmsys.wm_concat(t1.group_id)) ");
		sql.append("               from ta_oa_personwork_persongroup t1 ");
		sql.append("              where t.person_id = t1.person_id) group_id, ");
		sql.append("            'personaladdress' info_source, ");
		sql.append("   '个人通讯录' as info_source_name, ");
		sql.append("            t.user_id, ");
		sql.append("            t.eng_name ");
		sql.append(" from ta_oa_personwork_personinfo t ");
		sql.append(" left join ta_oa_personwork_extrainfo e on t.person_id = e.person_id ");
		sql.append(" where t.info_type = 'personal' ");
		sql.append(" union ");
		sql.append(" select t3.directoryid as person_id, ");
		sql.append("   t3.directoryname as name, ");
		sql.append("   '' as qq, ");
		sql.append("   t3.mobile as commonlymobile, ");
		sql.append("   t3.email, ");
		sql.append("   '' as group_name, ");
		sql.append("   '' as group_id, ");
		sql.append("   'directory' as info_source, ");
		sql.append("   '公共通讯录' as info_source_name, ");
		sql.append("   r.user_id, ");
		sql.append("   t3.eng_name ");
		sql.append(" from ta_oa_directory_manage t3 ");
		sql.append(" inner join ta_oa_persondirect_relation r on r.directoryid = t3.directoryid ");
		sql.append(" ) tt where tt.user_id = ? ");*/

		
		sql.append("select *");
		sql.append("  from (select distinct (t.person_id),");
		sql.append("                        name,");
		sql.append("                        (select t1.field_value");
		sql.append("                           from ta_oa_personwork_extrainfo t1");
		sql.append("                          where t1.person_id = t.person_id");
		sql.append("                            and t1.field_name = 'qq'");
		sql.append("                            and rownum = 1) qq,");
		sql.append("                        (select t1.field_value");
		sql.append("                           from ta_oa_personwork_extrainfo t1");
		sql.append("                          where t1.person_id = t.person_id");
		sql.append("                            and t1.field_name = '办公手机'");
		sql.append("                            and rownum = 1) commonlymobile,");
		sql.append("                        (select t1.field_value");
		sql.append("                           from ta_oa_personwork_extrainfo t1");
		sql.append("                          where t1.person_id = t.person_id");
		sql.append("                            and t1.field_name = '电子邮箱'");
		sql.append("                            and rownum = 1) email,");
		sql.append("                        (select to_char(wmsys.wm_concat(g.group_name))");
		sql.append("                           from ta_oa_personwork_group g");
		sql.append("                          inner join ta_oa_personwork_persongroup t1");
		sql.append("                             on t1.group_id = g.group_id");
		sql.append("                          where t.person_id = t1.person_id) group_name,");
		sql.append("                        (select to_char(wmsys.wm_concat(t1.group_id))");
		sql.append("                           from ta_oa_personwork_persongroup t1");
		sql.append("                          where t.person_id = t1.person_id) group_id,");
		sql.append("                        'personaladdress' info_source,");
		sql.append("                        '个人通讯录' as info_source_name,");
		sql.append("                        t.user_id,");
		sql.append("                        t.eng_name");
		sql.append("          from ta_oa_personwork_personinfo t");
		sql.append("          left join ta_oa_personwork_extrainfo e");
		sql.append("            on t.person_id = e.person_id");
		sql.append("         where t.info_type = 'personal'");
		sql.append("        union");
		sql.append("        select to_char(t3.user_id) as person_id,");
		sql.append("               t3.user_realname as name,");
		sql.append("               '' as qq,");
		sql.append("               t3.user_mobiletel1 as commonlymobile,");
		sql.append("               t3.user_email,");
		sql.append("               '' as group_name,");
		sql.append("               '' as group_id,");
		sql.append("               'directory' as info_source,");
		sql.append("               '公共通讯录' as info_source_name,");
		sql.append("               r.user_id,");
		sql.append("               t3.user_name");
		sql.append("          from td_sm_user t3");
		sql.append("         inner join ta_oa_persondirect_relation r");
		sql.append("            on r.directoryid = t3.user_id) tt");
		sql.append("  where tt.user_id = ? ");
		
		
		
		
		
		if(!StringUtil.nullOrBlank(personSearchBean.getLikevalue())){
			sql.append("and ( upper(tt.name) like ?  or");
			sql.append("	       tt.commonlymobile like ?  or upper(tt.email) like ?)");
		}
		
		if(!StringUtil.nullOrBlank(personSearchBean.getNameindex())){
			sql.append("and lower(tt.eng_name) like ? ");
		}
		// 分组名称
		if(!StringUtil.nullOrBlank(personSearchBean.getGroupname())){
			//sql.append("and group_name in ( '"+personSearchBean.getGroupname()+"' )");
			sql.append("and group_name like ? ");
		}
		
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	db.setString(j++, personSearchBean.getUserid());
	    	if(!StringUtil.nullOrBlank(personSearchBean.getLikevalue())){
				db.setString(j++, "%"+personSearchBean.getLikevalue().toUpperCase()+"%");
				db.setString(j++, "%"+personSearchBean.getLikevalue()+"%");
				db.setString(j++, "%"+personSearchBean.getLikevalue().toUpperCase()+"%");
			}

			if(!StringUtil.nullOrBlank(personSearchBean.getNameindex())){
					db.setString(j++, personSearchBean.getNameindex().toLowerCase()+"%");
			}
			// 分组名称
			if(!StringUtil.nullOrBlank(personSearchBean.getGroupname())){
				String Strgroupname = personSearchBean.getGroupname();
				String groupname = Strgroupname.replace("...", "");
				db.setString(j++, "%"+groupname+"%");
		}
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	PersonInfoBean personInfoBean = new PersonInfoBean();
		    	personInfoBean.setPerson_id(db.getString(i, "person_id"));
		    	personInfoBean.setName(db.getString(i, "name"));
		    	personInfoBean.setQqNum(db.getString(i, "qq"));
		    	personInfoBean.setCommonlymobile(db.getString(i, "commonlymobile"));
		    	personInfoBean.setEmail(db.getString(i, "email"));
		    	personInfoBean.setGroup(db.getString(i, "group_name"));
		    	personInfoBean.setGroup_id(db.getString(i, "group_id"));
		    	personInfoBean.setInfo_source(db.getString(i, "info_source"));
		    	personInfoBean.setUser_id(db.getString(i, "user_id"));
		    	personInfoBean.setInfo_source_name(db.getString(i, "info_source_name"));
		    	list.add(personInfoBean);
		    }
	    } catch (SQLException e) {
			LOG.error("执行个人通讯录列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	

	/*@Override
	public PagingBean findPublicAddressBook4RoleuserList(
			PersonSearchBean personSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<PersonInfoBean> list = new ArrayList<PersonInfoBean>();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		
		sql1.append("select leaders_userid from ta_oa_personwork_role where user_id = ?");
		
		String roleLeaders = "";
		try {
			db.preparedSelect(sql1.toString());
			db.setString(1, personSearchBean.getUserid());
			db.executePrepared();
			
			if(db.size() > 0){
				roleLeaders = db.getString(0, "leaders_userid");
			}
			
			sql.append("select distinct(t.person_id),");
			sql.append("       t.name,");
			sql.append("       (select t1.field_value");
			sql.append("          from ta_oa_personwork_extrainfo t1");
			sql.append("         where t1.person_id = t.person_id");
			sql.append("           and t1.field_name = '办公电话'   and rownum = 1) officephone,");
			sql.append("       (select t1.field_value");
			sql.append("          from ta_oa_personwork_extrainfo t1");
			sql.append("         where t1.person_id = t.person_id");
			sql.append("           and t1.field_name = '常用手机'   and rownum = 1) commonlymobile,");
			sql.append("       (select t1.field_value");
			sql.append("          from ta_oa_personwork_extrainfo t1");
			sql.append("         where t1.person_id = t.person_id");
			sql.append("           and t1.field_name = '家庭电话'   and rownum = 1) homephone,");
			sql.append("       (select t1.field_value");
			sql.append("          from ta_oa_personwork_extrainfo t1");
			sql.append("         where t1.person_id = t.person_id");
			sql.append("           and t1.field_name = '电子邮箱'   and rownum = 1) email,");
			sql.append("       o.org_name");
			sql.append("  from ta_oa_personwork_personinfo t");
			sql.append("  left join ta_oa_personwork_extrainfo e on t.person_id = e.person_id");
			sql.append("  left join TD_SM_ORGANIZATION o on t.org_id = o.org_id");
			sql.append(" where t.org_id = ?");
			sql.append("  and t.info_type = 'public' ");
			sql.append("  and t.person_id in ("+roleLeaders+") ");
			int j = 0;
			if(!StringUtil.nullOrBlank(personSearchBean.getLikevalue())){
				sql.append("and (t.name like ?  or");
				sql.append("	       e.field_value like ?  and e.type in ('1','3'))");
				j++;
			}
			
			if(!StringUtil.nullOrBlank(personSearchBean.getNameindex())){
				sql.append("and t.eng_name like ? ");
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			
			
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.setString(1, personSearchBean.getOrgid());
	    	if(!StringUtil.nullOrBlank(personSearchBean.getLikevalue())){
				db.setString(2, "%"+personSearchBean.getLikevalue()+"%");
				db.setString(3, "%"+personSearchBean.getLikevalue()+"%");
			}

			if(!StringUtil.nullOrBlank(personSearchBean.getNameindex())){
				if(j == 0)
					db.setString(2, personSearchBean.getNameindex().toLowerCase()+"%");
				else
					db.setString(4, personSearchBean.getNameindex().toLowerCase()+"%");
			}
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	PersonInfoBean personInfoBean = new PersonInfoBean();
		    	personInfoBean.setPerson_id(db.getString(i, "person_id"));
		    	personInfoBean.setName(db.getString(i, "name"));
		    	personInfoBean.setOfficphone(db.getString(i, "officephone"));
		    	personInfoBean.setCommonlymobile(db.getString(i, "commonlymobile"));
		    	personInfoBean.setHomephone(db.getString(i, "homephone"));
		    	personInfoBean.setEmail(db.getString(i, "email"));
		    	personInfoBean.setOrg_name(db.getString(i, "org_name"));
		    	list.add(personInfoBean);
		    }
	    } catch (SQLException e) {
			LOG.error("执行公共通讯录(有权限用户)列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}*/

	@Override
	public PagingBean findPublicAddressBook4ManagerInfoList(
			PersonSearchBean personSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<PersonInfoBean> list = new ArrayList<PersonInfoBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select distinct(t.person_id),");
		sql.append("       t.name,");
		sql.append("       (select t1.field_value");
		sql.append("          from ta_oa_personwork_extrainfo t1");
		sql.append("         where t1.person_id = t.person_id");
		sql.append("           and t1.field_name = '办公电话'   and rownum = 1) officephone,");
		sql.append("       (select t1.field_value");
		sql.append("          from ta_oa_personwork_extrainfo t1");
		sql.append("         where t1.person_id = t.person_id");
		sql.append("           and t1.field_name = '常用手机'   and rownum = 1) commonlymobile,");
		sql.append("       (select t1.field_value");
		sql.append("          from ta_oa_personwork_extrainfo t1");
		sql.append("         where t1.person_id = t.person_id");
		sql.append("           and t1.field_name = '家庭电话'   and rownum = 1) homephone,");
		sql.append("       (select t1.field_value");
		sql.append("          from ta_oa_personwork_extrainfo t1");
		sql.append("         where t1.person_id = t.person_id");
		sql.append("           and t1.field_name = '电子邮箱'   and rownum = 1) email,");
		sql.append("       o.org_name");
		sql.append("  from ta_oa_personwork_personinfo t");
		sql.append("  left join ta_oa_personwork_extrainfo e on t.person_id = e.person_id");
		sql.append("  left join TD_SM_ORGANIZATION o on t.org_id = o.org_id");
		sql.append(" where t.org_id = ? ");
		sql.append("  and info_type = 'public' ");

		int j = 0;
		if(!StringUtil.nullOrBlank(personSearchBean.getLikevalue())){
			sql.append("and (t.name like ?  or");
			sql.append("	       e.field_value like ?  and e.type in ('1','3'))");
			j++;
		}
		
		if(!StringUtil.nullOrBlank(personSearchBean.getNameindex())){
			sql.append("and t.eng_name like ? ");
		}
		
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.setString(1, personSearchBean.getOrgid());
	    	if(!StringUtil.nullOrBlank(personSearchBean.getLikevalue())){
				db.setString(2, "%"+personSearchBean.getLikevalue()+"%");
				db.setString(3, "%"+personSearchBean.getLikevalue()+"%");
			}

			if(!StringUtil.nullOrBlank(personSearchBean.getNameindex())){
				if(j == 0)
					db.setString(2, personSearchBean.getNameindex().toLowerCase()+"%");
				else
					db.setString(4, personSearchBean.getNameindex().toLowerCase()+"%");
			}
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	PersonInfoBean personInfoBean = new PersonInfoBean();
		    	personInfoBean.setPerson_id(db.getString(i, "person_id"));
		    	personInfoBean.setName(db.getString(i, "name"));
		    	personInfoBean.setOfficphone(db.getString(i, "officephone"));
		    	personInfoBean.setCommonlymobile(db.getString(i, "commonlymobile"));
		    	personInfoBean.setHomephone(db.getString(i, "homephone"));
		    	personInfoBean.setEmail(db.getString(i, "email"));
		    	personInfoBean.setOrg_name(db.getString(i, "org_name"));
		    	list.add(personInfoBean);
		    }
	    } catch (SQLException e) {
			LOG.error("执行公共通讯录(管理者)列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public List<PersonSearchBean> findOrgidList(String orgid){
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<PersonSearchBean> list = new ArrayList<PersonSearchBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.org_id ");
		sql.append(" from td_sm_organization a ");
		sql.append(" connect by prior a.org_id=a.parent_id ");/**父节点parent_id在左边是向上递归，在右边是向下递归**/
		sql.append(" start with a.org_id='");
		sql.append( orgid);
		sql.append("'  order by a.org_sn");
		
		try {
			db.executeSelect(sql.toString());
			for (int i = 0; i < db.size(); i++) {
				PersonSearchBean personSearchBean = new PersonSearchBean();
				personSearchBean.setOrgid(db.getString(i, "org_id"));
				list.add(personSearchBean);
			}
		} catch (Exception e) {
			LOG.error(e);
		}
		
		return list;
}
	@Override
	public PagingBean findPublicAddressBook4RoleuserList(
			PersonSearchBean personSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		String areacode = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//判断是否是苏仙项目
		boolean isNotShowAuthority = CacheCommonManageProxy.getBooleanSystemParam("personwork.isNotShowAuthority");//通讯录查看，如果没有查看权限的人员不应显示在列表中
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<PublicAddressDirectoryBean> list = new ArrayList<PublicAddressDirectoryBean>();
		StringBuffer sql = new StringBuffer();
		/*2013.03.07 下午14：15，问过二黄，没有此需求
		 * if (!StringUtil.nullOrBlank(personSearchBean.getLikevalue())
				||!StringUtil.nullOrBlank(personSearchBean.getDepartment())
				||!StringUtil.nullOrBlank(personSearchBean.getDirectorylevel())
				||!StringUtil.nullOrBlank(personSearchBean.getPolitics())
				||!StringUtil.nullOrBlank(personSearchBean.getOrgname())
		) {

			try {
				String org_id = DaoUtil
						.SqlToField("select o.org_id from td_sm_organization o where o.parent_id = '0' ");
				personSearchBean.setOrgid(org_id);
			} catch (SQLException e) {
				LOG.info(e.getMessage());
			}
		}*/
		
	
			String role_ids = TreeBusinessDaoImpl.inqueryPersonRule("69",personSearchBean.getUserid());

			
			/*sql.append("select u.user_id, u.user_name," );
			sql.append("  u.user_mobiletel1,u.user_mobiletel2,u.user_worktel,u.user_email, ");
			sql.append("  u.remark2, ");
			sql.append("  u.user_realname,o.org_id, o.org_name, t.five_major_org, usn.* ");
			sql.append("  from (select rownum index_sn, org.org_id, org.org_name");
			sql.append("          from td_sm_organization org");
			sql.append("         start with org.org_id = ? ");
			sql.append("        connect by prior org.org_id = org.parent_id");
			sql.append("         order siblings by org.org_sn) o");
			 
			sql.append("  left join ta_oa_organdtype t on t.org_id=o.org_id ");
			sql.append("  left join td_sm_orguser ou");
			sql.append("    on ou.org_id = o.org_id");
			sql.append("  left join td_sm_user u");
			sql.append("    on u.user_id = ou.user_id");
			sql.append("     left join ta_oa_userandsn usn");
			sql.append("    on u.user_id = usn.userid");
			sql.append("  left join td_sm_userjoborg a");
			sql.append("    on a.user_id = ou.user_id");
			sql.append("   and ou.org_id = a.org_id");
			sql.append(" where u.user_id is not null");*/
			
			
			sql.append("select o.org_id,o.org_name, u.user_id, u.user_name, u.user_realname,u.user_mobiletel1,u.user_sn,");
			sql.append("u.user_mobiletel2,u.user_worktel,u.user_email,u.remark2,usn.*");
			sql.append("  from (select rownum index_sn, org.org_id, org.org_name ");
			sql.append("          from td_sm_organization org ");
			sql.append("         start with org.org_id = ? ");
			sql.append("        connect by prior org.org_id = org.parent_id");
			sql.append("         order siblings by org.org_sn) o");
			sql.append("  left join td_sm_orguser ou on ou.org_id = o.org_id");
			sql.append("  left join td_sm_user u on u.user_id = ou.user_id");
			sql.append("  left join td_sm_userjoborg a on a.user_id = ou.user_id");
			sql.append("                              and ou.org_id = a.org_id");
			sql.append("   left join ta_oa_userandsn usn on u.user_id = usn.userid");
			sql.append(" where (u.user_name is not null)");
			//sql.append("   and u.user_isvalid != '3'");
		
			
			
			if(!StringUtil.nullOrBlank(personSearchBean.getLikevalue())){
				sql.append(" and (u.user_realname like ?  or");
				sql.append("      o.org_name like ? or ");
				if(!"431003".equals(areacode)){ //苏仙没有职位查询 
					sql.append("      usn.duties like ? or ");
				}
				sql.append("	  u.user_mobiletel1 like ?  or u.user_email like ? or u.user_worktel like ? or u.user_hometel like ?)");
			}
			//是否是党政一把手
			if(!StringUtil.nullOrBlank(personSearchBean.getDepartment())){
				if("是".equals(personSearchBean.getDepartment().trim())){
				 sql.append(" and numberone = '"+personSearchBean.getDepartment().trim()+"'");
				}else{
					 sql.append(" and (numberone = '"+personSearchBean.getDepartment().trim()+"' or numberone is null) ");	
				}
			}
			//级别
			String array[]=	personSearchBean.getDirectorylevel().split(",");
			if(!StringUtil.nullOrBlank(personSearchBean.getDirectorylevel())){
				
				sql.append(" and ( usn.directorylevel like ?");
				for (int i=0;i<array.length-1;i++){
					sql.append(" or usn.directorylevel like ?  ");
				}
				//sql.append(" and usn.directorylevel   like ? ");
				sql.append(" ) ");
			}
			//政治面貌
			String parray[]=	personSearchBean.getPolitics().split(",");
			if(!StringUtil.nullOrBlank(personSearchBean.getPolitics())){
				sql.append(" and ( usn.politics = ?");
				for (int i=0;i<parray.length-1;i++){
					sql.append(" or usn.politics  =?  ");
				}
				sql.append(" ) ");
				
				
			}
			//所在单位
			if(!StringUtil.nullOrBlank(personSearchBean.getOrgname())){
				sql.append(" and o.org_name  like ? ");
			}
			if(!StringUtil.nullOrBlank(personSearchBean.getNameindex())){
				sql.append(" and u.user_name like ? ");
			}
	
			/*if(StringUtil.nullOrBlank(sortName)){
				sql.append(" order by  to_number(o.index_sn),a.orderby,m.directory_sn");
			}else{
				sql.append(" order by " + sortName + " " + sortOrder);
			}*/
			sql.append(" order by to_number(o.index_sn),a.same_job_user_sn, u.user_sn");
		
		try {
			//通讯录导出 0:不分页
			if(!StringUtil.nullOrBlank(personSearchBean.getPageValue()) && "0".equals(personSearchBean.getPageValue())){
				db.preparedSelect(sql.toString());
			}else{
				db.preparedSelect(sql.toString(), offset, maxPagesize);
			}
	    
	    	
	    
	    	int j = 1;
	    	db.setString(j++, personSearchBean.getOrgid());
	    	if(!StringUtil.nullOrBlank(personSearchBean.getLikevalue())){
	    		String name = personSearchBean.getLikevalue();
	    		String email = personSearchBean.getLikevalue();
	    		db.setString(j++, "%"+name.toLowerCase()+"%");
	    		db.setString(j++, "%"+personSearchBean.getLikevalue()+"%");
	    		if(!"431003".equals(areacode)){ //苏仙没有职位查询 
	    			db.setString(j++, "%"+personSearchBean.getLikevalue()+"%");
				}
				db.setString(j++, "%"+personSearchBean.getLikevalue()+"%");
				db.setString(j++, "%"+email.toLowerCase()+"%");
				db.setString(j++, "%"+personSearchBean.getLikevalue()+"%");
				db.setString(j++, "%"+personSearchBean.getLikevalue()+"%");
			}
	    	//是否是党政一把手
	    	if(!StringUtil.nullOrBlank(personSearchBean.getDepartment())){
				sql.append(" and numberone = '"+personSearchBean.getDepartment()+"' ");
			}
			//级别
			if(!StringUtil.nullOrBlank(personSearchBean.getDirectorylevel())){
			 for(int i = 0;i < array.length;i++){
				db.setString(j++, "%"+array[i]+"%");
			 }
			}
			//政治面貌
			if(!StringUtil.nullOrBlank(personSearchBean.getPolitics())){
				 for(int i = 0;i < parray.length;i++){
					 if("中共党员".equals(parray[i])){
							parray[i] = "1";
						}else if("中共预备党员".equals(parray[i])){
							parray[i] = "2";
						}else if("共青团员".equals(parray[i])){
							parray[i] = "3";
						}else if("民革党员".equals(parray[i])){
							parray[i] = "4";
						}else if("民盟盟员".equals(parray[i])){
							parray[i] = "5";
						}else if("民建会员".equals(parray[i])){
							parray[i] = "6";
						}else if("民进会员".equals(parray[i])){
							parray[i] = "7";
						}else if("农工党党员".equals(parray[i])){
							parray[i] = "8";
						}else if("致公党党员".equals(parray[i])){
							parray[i] = "9";
						}else if("九三学社社员".equals(parray[i])){
							parray[i] = "10";
						}else if("台盟盟员".equals(parray[i])){
							parray[i] = "11";
						}else if("无党派民主人士".equals(parray[i])){
							parray[i] = "12";
						}else if("群众".equals(parray[i])){
							parray[i] = "13";
						}
					db.setString(j++, ""+parray[i]+"");
				}
			}
			//所在单位
			if(!StringUtil.nullOrBlank(personSearchBean.getOrgname())){
				db.setString(j++, "%"+personSearchBean.getOrgname()+"%");
			}
			if(!StringUtil.nullOrBlank(personSearchBean.getNameindex())){
					db.setString(j++, personSearchBean.getNameindex().toLowerCase()+"%");
			}

	    	
	    	db.executePrepared();
	    	
	    	String dirs = getHasSetDirecttoryRelationship(personSearchBean.getUserid());
	      
	        if("431003".equals(areacode)){ 
	        	 for(int i = 0;i < db.size();i++){
	 		    	PublicAddressDirectoryBean ab = new PublicAddressDirectoryBean();
	 		    	ab.setDirectoryid(db.getString(i, "user_id"));
	 		    	ab.setIs_relation((dirs.indexOf(db.getString(i, "user_id")) == -1)?"未引用":"已引用");
	 		    	ab.setDirectoryname(db.getString(i, "user_realname"));
	 		    	ab.setIshasviewrole("false");
	 		    	
	 		    	if("Y".equals(db.getString(i, "five_major_org"))){//判断是否是五大机构
	 		    		//判断当前用户是否有对当前通讯录数据的查看权限，没权限就只能看姓名，并且页面不展示详细记录
	 		 		   if("add".equals(personSearchBean.getListtype()) || (","+role_ids+",").indexOf(","+db.getString(i, "user_id")+",") != -1){
	 		 		    	ab.setDirectoryyear(db.getString(i, "directoryyear"));
	 		 		    	ab.setDirectorysex(db.getString(i, "directorysex"));
	 		 		    	ab.setPost(db.getString(i, "duties"));
	 		 		    	
	 		 		    	ab.setDirectorystate(db.getString(i, "directorystate"));
	 		 		    	ab.setEducation(db.getString(i, "education"));
	 		 		    	ab.setDegree(db.getString(i, "degree"));
	 		 		    	ab.setSeniority(db.getString(i, "seniority"));
	 		 		    	
	 		 		    	ab.setSchool(db.getString(i, "school"));
	 		 		    	ab.setNation(db.getString(i, "nation"));
	 		 		    	
	 		 		    	ab.setNatives(db.getString(i, "natives"));
	 		 		    	
	 		 		  	    ab.setDirectorylevel(db.getString(i, "directorylevel"));
	 		 		  	   if(!StringUtil.nullOrBlank(db.getString(i, "politics"))){
	 		 		    	String politics ="";
	 		 		    	Integer  number = Integer.parseInt(db.getString(i, "politics"));
	 		 		    	if(number>0){
	 		 		    	switch (Integer.parseInt(db.getString(i, "politics"))) {
	 						case 1:  politics = "中共党员"; break;
	 						case 2:  politics = "中共预备党员"; break;
	 						case 3:  politics = "共青团员"; break;
	 						case 4:  politics = "民革党员"; break;
	 						case 5:  politics = "民盟盟员"; break;
	 						case 6:  politics = "民建会员"; break;
	 						case 7:  politics = "民进会员"; break;
	 						case 8:  politics = "农工党党员"; break;
	 						case 9:  politics = "致公党党员"; break;
	 						case 10: politics = "九三学社社员"; break;
	 						case 11: politics = "台盟盟员"; break;
	 						case 12: politics = "无党派民主人士"; break;
	 						case 13: politics = "群众";break;
	 						}
	 		 		    	}
	 		 		    	ab.setPolitics( politics);
	 		 		    	}else{
	 		 		    		ab.setPolitics(db.getString(i,  "politics"));
	 		 		    	}
	 		 		  	    if("是".equals(db.getString(i, "numberone"))){
	 		 		  	     ab.setDepartment("是");
	 		 		  	    }else{
	 		 		  	     ab.setDepartment("否");
	 		 		  	    }
	 		 		  	   
	 		 		    	ab.setSpecialty(db.getString(i, "specialty"));
	 		 		    	ab.setMobile(db.getString(i, "user_mobiletel1"));
	 		 		    	ab.setMobile2(db.getString(i, "user_mobiletel2"));
	 		 		    	ab.setHomeadress(db.getString(i, "homeadress"));
	 		 		    	ab.setWorkphone(db.getString(i, "user_worktel"));
	 		 		    	
	 		 		    	ab.setWorkadress(db.getString(i, "workadress"));
	 		 		    	ab.setHomephone(db.getString(i, "user_worktel"));
	 		 		    	ab.setEmail(db.getString(i, "user_email"));
	 		 		    	ab.setRemark2(db.getString(i,"remark2"));
	 		 		    	ab.setDuty(db.getString(i, "duty"));
	 		 		    	
	 		 		    	ab.setResume(db.getString(i, "resume"));
	 		 		    	ab.setOrgid(db.getString(i, "org_id"));
	 		 		    	ab.setOrgname(db.getString(i, "org_name"));
	 		 		    	ab.setDuties(db.getString(i, "duties"));
	 		 		    	ab.setIshasviewrole("true");
	 		 		    	}
	 		 		    	list.add(ab);
	 		    	}else{
	 		    	//判断当前用户是否有对当前通讯录数据的查看权限，没权限就只能看姓名，并且页面不展示详细记录
	 		    //   if("add".equals(personSearchBean.getListtype()) || (","+role_ids+",").indexOf(","+db.getString(i, "user_id")+",") != -1){
	 		    	ab.setDirectoryyear(db.getString(i, "directoryyear"));
	 		    	ab.setDirectorysex(db.getString(i, "directorysex"));
	 		    	ab.setPost(db.getString(i, "duties"));
	 		    	
	 		    	ab.setDirectorystate(db.getString(i, "directorystate"));
	 		    	ab.setEducation(db.getString(i, "education"));
	 		    	ab.setDegree(db.getString(i, "degree"));
	 		    	ab.setSeniority(db.getString(i, "seniority"));
	 		    	
	 		    	ab.setSchool(db.getString(i, "school"));
	 		    	ab.setNation(db.getString(i, "nation"));
	 		    	ab.setNatives(db.getString(i, "natives"));
	 		    
	 		    	if(!StringUtil.nullOrBlank(db.getString(i, "politics"))){
	 		    	String politics ="";
	 		    	Integer  number = Integer.parseInt(db.getString(i, "politics"));
	 		    	if(number>0){
	 		    	switch (number) {
					case 1:  politics = "中共党员"; break;
					case 2:  politics = "中共预备党员"; break;
					case 3:  politics = "共青团员"; break;
					case 4:  politics = "民革党员"; break;
					case 5:  politics = "民盟盟员"; break;
					case 6:  politics = "民建会员"; break;
					case 7:  politics = "民进会员"; break;
					case 8:  politics = "农工党党员"; break;
					case 9:  politics = "致公党党员"; break;
					case 10: politics = "九三学社社员"; break;
					case 11: politics = "台盟盟员"; break;
					case 12: politics = "无党派民主人士"; break;
					case 13: politics = "群众";break;
					}
	 		    	}
	 		    	ab.setPolitics( politics);
	 		    	}else{
	 		    		ab.setPolitics(db.getString(i,  "politics"));
	 		    	}
	 		    	ab.setDirectorylevel(db.getString(i, "directorylevel"));
		 		  	 if("是".equals(db.getString(i, "numberone"))){
		 		  	     ab.setDepartment( "是");
		 		  	    }else{
		 		  	     ab.setDepartment("否");
		 		  	    }
	 		    	ab.setSpecialty(db.getString(i, "specialty"));
	 		    	ab.setMobile(db.getString(i, "user_mobiletel1"));
	 		    	ab.setMobile2(db.getString(i, "user_mobiletel2"));
	 		    	ab.setHomeadress(db.getString(i, "homeadress"));
	 		    	ab.setWorkphone(db.getString(i, "user_worktel"));
	 		    	
	 		    	ab.setWorkadress(db.getString(i, "workadress"));
	 		    	ab.setHomephone(db.getString(i, "user_worktel"));
	 		    	ab.setEmail(db.getString(i, "user_email"));
	 		    	ab.setRemark2(db.getString(i,"remark2"));
	 		    	ab.setDuty(db.getString(i, "duty"));
	 		    	
	 		    	ab.setResume(db.getString(i, "resume"));
	 		    	ab.setOrgid(db.getString(i, "org_id"));
	 		    	ab.setOrgname(db.getString(i, "org_name"));
	 		    	ab.setDuties(db.getString(i, "duties"));
	 		    	ab.setIshasviewrole("true");
	 		    //	}
	 		    	list.add(ab);
	 		    	}
	 		     }

	        }else{
		    for(int i = 0;i < db.size();i++){
		    	PublicAddressDirectoryBean ab = new PublicAddressDirectoryBean();
		    	ab.setDirectoryid(db.getString(i, "user_id"));
		    	ab.setIs_relation((dirs.indexOf(db.getString(i, "user_id")) == -1)?"未引用":"已引用");
		    	ab.setDirectoryname(db.getString(i, "user_realname"));
		    	ab.setIshasviewrole("false");
		    	//判断当前用户是否有对当前通讯录数据的查看权限，没权限就只能看姓名，并且页面不展示详细记录
		       if("add".equals(personSearchBean.getListtype()) || (","+role_ids+",").indexOf(","+db.getString(i, "user_id")+",") != -1){
		    	ab.setDirectoryyear(db.getString(i, "directoryyear"));
		    	ab.setDirectorysex(db.getString(i, "directorysex"));
		    	ab.setPost(db.getString(i, "duties"));
		    	
		    	ab.setDirectorystate(db.getString(i, "directorystate"));
		    	ab.setEducation(db.getString(i, "education"));
		    	ab.setDegree(db.getString(i, "degree"));
		    	ab.setSeniority(db.getString(i, "seniority"));
		    	
		    	ab.setSchool(db.getString(i, "school"));
		    	ab.setNation(db.getString(i, "nation"));
		    	ab.setPolitics(db.getString(i, "politics"));
		    	ab.setNatives(db.getString(i, "natives"));
		    	
		    	ab.setSpecialty(db.getString(i, "specialty"));
		    	ab.setMobile(db.getString(i, "user_mobiletel1"));
		    	ab.setMobile2(db.getString(i, "user_mobiletel2"));
		    	ab.setHomeadress(db.getString(i, "homeadress"));
		    	ab.setWorkphone(db.getString(i, "user_worktel"));
		    	
		    	ab.setWorkadress(db.getString(i, "workadress"));
		    	ab.setHomephone(db.getString(i, "user_worktel"));
		    	ab.setEmail(db.getString(i, "user_email"));
		    	ab.setRemark2(db.getString(i,"remark2"));
		    	ab.setDuty(db.getString(i, "duty"));
		    	
		    	ab.setResume(db.getString(i, "resume"));
		    	ab.setOrgid(db.getString(i, "org_id"));
		    	ab.setOrgname(db.getString(i, "org_name"));
		    	ab.setDuties(db.getString(i, "duties"));
		    	ab.setIshasviewrole("true");
		    	} else {
		    		//通讯录查看，如果没有查看权限的人员不应显示在列表
			        if(isNotShowAuthority){
			        	continue;
			        }
		    	}
		    	list.add(ab);
		     }
	        }
	    } catch (Exception e) {
	    	e.printStackTrace();
			LOG.error("执行公共通讯录列表查询报错："+e.getMessage());
			
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}



	@Override
	public String savePersonBaseInfo(PersonInfoBean personInfoBean,Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		String person_id = personInfoBean.getPerson_id();
		sql1.append("select * from ta_oa_personwork_personinfo t where t.person_id = ?");
		sql.append("select seq_personwork_personinfo.nextval new_person_id from dual");
		
		try{
			pdb.preparedSelect(sql1.toString());
			pdb.setString(1, person_id);
			pdb.executePrepared();
			if(pdb.size() > 0){
				sql2.append("update ta_oa_personwork_personinfo");
				sql2.append("   set user_id     = ?,");
				sql2.append("       name        = ?,");
				sql2.append("       info_type   = ?,");
				sql2.append("       nick_name   = ?,");
				sql2.append("       create_time = ?,");
				sql2.append("       eng_name    = ?,");
				sql2.append("       org_id      = ?");
				sql2.append(" where person_id = ?");
				
				pdb.preparedUpdate(sql2.toString());
				
				pdb.setString(1, StringUtil.deNull(personInfoBean.getUser_id()));
				pdb.setString(2, StringUtil.deNull(personInfoBean.getName()));
				pdb.setString(3, StringUtil.deNull(personInfoBean.getInfo_type()));
				pdb.setString(4, StringUtil.deNull(personInfoBean.getNick_name()));
				pdb.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
				pdb.setString(6, PinyinUtil.hanziToPinyin(StringUtil.deNull(personInfoBean.getName())));
				pdb.setString(7, StringUtil.deNull(personInfoBean.getOrg_id()));
				pdb.setString(8, person_id);
				pdb.executePrepared(con);
				
				sql.setLength(0);
				sql.append("delete from ta_oa_personwork_persongroup where person_id = ?");
				pdb.preparedDelete(sql.toString());
				pdb.setString(1, personInfoBean.getPerson_id());
				pdb.executePrepared(con);
				
				sql.setLength(0);
				sql.append("insert into ta_oa_personwork_persongroup ");
				sql.append("  (persongroup_id, person_id, group_id)");
				sql.append("values");
				sql.append("  (seq_personwork_persongroup.nextval, ?, ?)");
				String[] groupids = null;
				if(!StringUtil.nullOrBlank(personInfoBean.getGroup_id())){
					groupids = personInfoBean.getGroup_id().split(",");
					for(int i = 0 ; i < groupids.length ; i ++){
						pdb.preparedInsert(sql.toString());
						pdb.setString(1, personInfoBean.getPerson_id());
						pdb.setString(2, groupids[i]);
						pdb.addPreparedBatch();
					}
					pdb.executePreparedBatch(con);
				}
			}else{
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared();
				person_id = pdb.getString(0, "new_person_id");
				
				sql2.append("insert into ta_oa_personwork_personinfo");
				sql2.append("  (person_id,");
				sql2.append("   user_id,");
				sql2.append("   name,");
				sql2.append("   info_type,");
				sql2.append("   nick_name,");
				sql2.append("   create_time,");
				sql2.append("   eng_name,");
				sql2.append("   org_id)");
				sql2.append("values");
				sql2.append("  (?, ?, ?, ?, ?, ?, ?, ?)");
				
				pdb.preparedInsert(sql2.toString());
				pdb.setString(1, person_id);
				pdb.setString(2, StringUtil.deNull(personInfoBean.getUser_id()));
				pdb.setString(3, StringUtil.deNull(personInfoBean.getName()));
				pdb.setString(4, StringUtil.deNull(personInfoBean.getInfo_type()));
				pdb.setString(5, StringUtil.deNull(personInfoBean.getNick_name()));
				pdb.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
				pdb.setString(7, PinyinUtil.hanziToPinyin(StringUtil.deNull(personInfoBean.getName())));
				pdb.setString(8, StringUtil.deNull(personInfoBean.getOrg_id()));
				pdb.executePrepared(con);
				
				sql.setLength(0);
				sql.append("insert into ta_oa_personwork_persongroup ");
				sql.append("  (persongroup_id, person_id, group_id)");
				sql.append("values");
				sql.append("  (seq_personwork_persongroup.nextval, ?, ?)");
				String[] groupids = null;
				if(!StringUtil.nullOrBlank(personInfoBean.getGroup_id())){
					groupids = personInfoBean.getGroup_id().split(",");
					for(int i = 0 ; i < groupids.length ; i ++){
						pdb.preparedInsert(sql.toString());
						pdb.setString(1, person_id);
						pdb.setString(2, groupids[i]);
						pdb.addPreparedBatch();
					}
					pdb.executePreparedBatch(con);
				}
			}
		
			
			
		}catch(SQLException e){
			throw e;
		}
		return person_id;
	}

	@Override
	public void savePersonExtraInfo(
			String person_id,String type,List<PersonExtraInfoBean> personExtraInfoList,Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		sql1.append("delete from ta_oa_personwork_extrainfo t where t.person_id = ? and t.type = ?");
		
		sql.append("insert into ta_oa_personwork_extrainfo");
		sql.append("  (extra_id, person_id, field_name, field_value, type, showindex)");
		sql.append("values");
		sql.append("  (seq_personwork_extrainfo.nextval, ?, ?, ?, ?, ?)");
	
		try{
			pdb.preparedDelete(sql1.toString());
			pdb.setString(1, person_id);
			pdb.setString(2, type);
			pdb.executePrepared(con);
			
			if(personExtraInfoList != null && personExtraInfoList.size() > 0){
				for(int i = 0 ; i < personExtraInfoList.size() ; i ++ ){
					PersonExtraInfoBean personExtraInfoBean = personExtraInfoList.get(i);
					pdb.preparedInsert(sql.toString());
					pdb.setString(1, person_id);
					pdb.setString(2, StringUtil.deNull(personExtraInfoBean.getField_name()));
					pdb.setString(3, StringUtil.deNull(personExtraInfoBean.getField_value()));
					pdb.setString(4, type);
					pdb.setString(5, StringUtil.deNull(personExtraInfoBean.getShowindex()));

					pdb.addPreparedBatch();
				}
				pdb.executePreparedBatch(con);
			}
			
		}catch(SQLException e){
			throw e;
		}
		
	}

	@Override
	public PersonInfoBean findPersonBaseInfo(String personId) {
		PreparedDBUtil  db = new PreparedDBUtil ();

		StringBuffer sql = new StringBuffer();
		sql.append("select ");
		sql.append("   t.name,");
		sql.append("   t.info_type,");
		sql.append("   t.nick_name,");
		sql.append("   t.org_id,");
		sql.append("   o.org_name,");
		sql.append("       (select to_char(wmsys.wm_concat(g.group_name)) ");
		sql.append("  		from ta_oa_personwork_group g");
		sql.append(" 		inner join ta_oa_personwork_persongroup t1 on t1.group_id = g.group_id");
		sql.append(" 		where t1.person_id = t.person_id");
		sql.append("  		) group_name,");
		sql.append("       (select to_char(wmsys.wm_concat(g.group_id)) ");
		sql.append("  		from ta_oa_personwork_persongroup g");
		sql.append(" 		where g.person_id = t.person_id");
		sql.append("  		) group_id");
		sql.append("   from ta_oa_personwork_personinfo t ");
		sql.append("   left join td_sm_organization o on o.org_id = t.org_id ");
		sql.append("   where person_id = ?");

		PersonInfoBean personInfoBean = new PersonInfoBean();
		try {
	    	db.preparedSelect(sql.toString());
	    	db.setString(1, personId);
	    	db.executePrepared();
		   if(db.size() > 0){
		    	
		    	personInfoBean.setPerson_id(personId);
		    	personInfoBean.setName(db.getString(0, "name"));
		    	personInfoBean.setNick_name(db.getString(0, "nick_name"));
		    	personInfoBean.setInfo_type(db.getString(0, "info_type"));
		    	personInfoBean.setGroup_id(db.getString(0, "group_id"));
		    	personInfoBean.setGroup(db.getString(0, "group_name"));
		    	personInfoBean.setOrg_id(db.getString(0, "org_id"));
		    	personInfoBean.setOrg_name(db.getString(0, "org_name"));
		    }
	    } catch (SQLException e) {
			LOG.error("执行人员信息查询报错："+e.getMessage());
		}

		return personInfoBean;

	}

	@Override
	public List<PersonExtraShowBean> findPersonExtraInfoList(String personId,String type) {
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<PersonExtraShowBean> list = new ArrayList<PersonExtraShowBean>();
		String selectname = "";
		String selectedvalue = "";
		switch(Integer.parseInt(type)){
		case 1: selectname = "phone";selectedvalue = "办公手机"; break;
		case 2: selectname = "fox"; break;
		case 3: selectname = "email"; break;
		case 4: selectname = "qq"; break;
		case 5: selectname = "birth"; break;
		case 6: selectname = "company"; break;
		case 7: selectname = "position"; break;
		case 8: selectname = "address"; break;
		case 9: selectname = "website"; break;
		default :  ;	
	}
		String selectHtml = "";
		try {
			if("4567".indexOf(type) == -1){
				selectHtml = getPersonExtraInfoDictDropDownList(type,selectname,selectedvalue);
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
		}
		
		StringBuffer sql = new StringBuffer();
		sql.append("select field_name,field_value,showindex");
		sql.append("  from ta_oa_personwork_extrainfo");
		sql.append(" where person_id = ?");
		sql.append("   and type = ?");
		
		
		try {
	    	db.preparedSelect(sql.toString());
	    	db.setString(1, personId);
	    	db.setString(2, type);
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	PersonExtraShowBean personExtraShowBean = new PersonExtraShowBean();
		    	personExtraShowBean.setField(db.getString(i, "field_name"));
		    	personExtraShowBean.setValue(db.getString(i, "field_value"));
		    	selectHtml = selectHtml.replace("selected", "");
		    	personExtraShowBean.setSelectHtml(selectHtml.replace(">"+db.getString(i, "field_name"), " selected>"+db.getString(i, "field_name")));

		    	list.add(personExtraShowBean);
		    }
		    if(list.size() <= 0){
		    	PersonExtraShowBean personExtraShowBean = new PersonExtraShowBean();
		    	personExtraShowBean.setSelectHtml(selectHtml);
		    	personExtraShowBean.setValue("");
		    	list.add(personExtraShowBean);
		    }
	    } catch (SQLException e) {
			LOG.error("执行人员扩展信息查询报错："+e.getMessage());
		}

		return list;
	}

	public String getPersonExtraInfoDictDropDownList(String type,String selectname,String selectedvalue)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select field_name as field,field_name from TA_OA_PERSONWORK_PERSONINFOPAR where parent_id = '")
		   .append(type)
		   .append("' and is_pc = 'Y'");

		
		String sceneTypeList = DictDropDownList.buildSelect(sql
				.toString(), selectname, selectedvalue, "", false, "");
		return sceneTypeList;
	}

	@Override
	public void deletePersonInfo(String personids,Connection con) throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();

		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		if(StringUtil.nullOrBlank(personids))
			return;
		String[] personidarry = personids.split(",");
		sql.append("delete from ta_oa_personwork_personinfo where person_id = ? ");
		sql1.append("delete from ta_oa_personwork_persongroup where person_id = ? ");
		sql2.append("delete from ta_oa_personwork_extrainfo where person_id = ? ");
		
		try {
			for(int i = 0 ; i < personidarry.length ; i ++){
		    	db.preparedDelete(sql1.toString());
				db.setString(1, personidarry[i]);
		    	db.addPreparedBatch();
		    	db.preparedDelete(sql2.toString());
				db.setString(1, personidarry[i]);
		    	db.addPreparedBatch();
				db.preparedDelete(sql.toString());
				db.setString(1, personidarry[i]);
				db.addPreparedBatch();

			}
	    	db.executePreparedBatch(con);
	    } catch (SQLException e) {
			LOG.error("删除人员信息报错："+e.getMessage());
			throw e;
		}
	}

	@Override
	public void savePersonGroupInfo(String personids, String groupids ,Connection con)
			throws Exception {
		if(StringUtil.nullOrBlank(personids))
			return;
		String[] personArry = personids.split(",");
		
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		PreparedDBUtil pdb1 = new PreparedDBUtil();
		
		sql.append("delete from ta_oa_personwork_persongroup where person_id = ?");
		
		sql1.append("insert into ta_oa_personwork_persongroup ");
		sql1.append("  (persongroup_id, person_id, group_id)");
		sql1.append("values");
		sql1.append("  (seq_personwork_persongroup.nextval, ?, ?)");
		
		sql2.append("select * from ta_oa_personwork_group where group_id = ?");
		try{
			for(int i = 0 ; i < personArry.length ; i ++){
				pdb.preparedDelete(sql.toString());
				pdb.setString(1, personArry[i]);
				pdb.addPreparedBatch();
				
				if(!StringUtil.nullOrBlank(personids)){
					String[] groupArry = groupids.split(",");
					for(int j = 0 ; j < groupArry.length ; j ++){
						pdb1.preparedSelect(sql2.toString());
						pdb1.setString(1, groupArry[j]);
						pdb1.executePrepared();
						if( pdb1.size() > 0){
							pdb.preparedInsert(sql1.toString());
							pdb.setString(1, personArry[i]);
							pdb.setString(2, groupArry[j]);
							pdb.addPreparedBatch();
						}
					}
				}
			}
		
			pdb.executePreparedBatch(con);
		}catch(Exception e){
			throw e;
		}
			
	}

	@Override
	public String getGroupSelectHtml(String userid) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select group_id,group_name from TA_OA_PERSONWORK_GROUP where user_id = '")
		   .append(userid)
		   .append("' ");

		String sceneTypeList = DictDropDownList.buildSelect(sql
				.toString(), "combobox", "", "", false, "");
		return sceneTypeList;
	}

	@Override
	public String getOrgNameByOrgId(String orgid) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select org_name from td_sm_organization where org_id = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, orgid);
		pdb.executePrepared();
		String orgname = "";
		if(pdb.size() > 0){
			orgname = pdb.getString(0, "org_name");
		}
		return orgname;
	}

	@Override
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid,String infoType)
			throws Exception {
		List<ListShowUtilBean> list = new ArrayList<ListShowUtilBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		String firstCodeAreaStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuffer sql = new StringBuffer();
		
		/*sql.append(" select t.person_id from ta_oa_personwork_personinfo t where t.eng_name like ? and t.info_type = ?");
		sql.append(" and t.user_id = ?");
		sql.append("  union");
		sql.append(" select t3.directoryid from ta_oa_directory_manage t3 ");
		sql.append(" inner join ta_oa_persondirect_relation r on r.directoryid = t3.directoryid");
		sql.append(" where t3.eng_name like ?  ");
		sql.append(" and r.user_id = ?");*/
		
		sql.append(" select t.person_id");
		sql.append("  from ta_oa_personwork_personinfo t");
		sql.append(" where t.eng_name like ?");
		sql.append("   and t.info_type = ?");
		sql.append("   and t.user_id = ?");
		sql.append(" union");
		sql.append(" select to_char(t3.user_id) ");
		sql.append("  from td_sm_user t3 ");
		sql.append(" inner join ta_oa_persondirect_relation r ");
		sql.append("    on r.directoryid = t3.user_id  ");
		sql.append(" where t3.user_name like ? ");
		sql.append("   and r.user_id = ?");
		
		
		/*sql.append(" select t.user_id  from td_sm_user t ");
		sql.append(" left join td_sm_orguser us on t.user_id = us.user_id");
		sql.append(" where t.user_name like ? ");
		sql.append("    and exists(select 1 from (select a.org_id ");
		sql.append("          from td_sm_organization a ");
		sql.append("        connect by prior a.org_id = a.parent_id ");
		sql.append("         start with a.org_id = '"+orgoruserid+"') o where o.org_id = us.org_id");
		sql.append("         )  ");*/

		for(int i = 0 ; i < firstCodeAreaStr.length() ; i++){
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, String.valueOf(firstCodeAreaStr.charAt(i)).toLowerCase()+"%");
			pdb.setString(2, infoType);
			pdb.setString(4, String.valueOf(firstCodeAreaStr.charAt(i)).toLowerCase()+"%");
		if(!StringUtil.nullOrBlank(orgoruserid)){
				pdb.setString(3, orgoruserid);
				pdb.setString(5, orgoruserid);
			}
			pdb.executePrepared();
			ListShowUtilBean bean = new ListShowUtilBean();
			bean.setFirstCode(String.valueOf(firstCodeAreaStr.charAt(i)));
			if(pdb.size() > 0)
				bean.setExsit(true);
			else
				bean.setExsit(false);
			list.add(bean);
		}
		
		return list;
	}

	@Override
	public List<ListShowUtilBean> getFirstCodeShowInfo4PublicAddress(
			String orgoruserid) throws Exception {
		List<ListShowUtilBean> list = new ArrayList<ListShowUtilBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		String firstCodeAreaStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuffer sql = new StringBuffer();
		
		/*sql.append("select directoryid from ta_oa_directory_manage t where eng_name like ? ");
		sql.append("and exists(select 1 from (select a.org_id ");
		sql.append("		  from td_sm_organization a ");
		sql.append("		connect by prior a.org_id = a.parent_id ");
		sql.append("		 start with a.org_id = '"+orgoruserid+"') o where o.org_id = t.orgid ");
		sql.append("		 )  ");*/
		
		sql.append(" select t.user_id  from td_sm_user t ");
		sql.append(" left join td_sm_orguser us on t.user_id = us.user_id");
		sql.append(" where t.user_name like ? ");
		sql.append("    and exists(select 1 from (select a.org_id ");
		sql.append("          from td_sm_organization a ");
		sql.append("        connect by prior a.org_id = a.parent_id ");
		sql.append("         start with a.org_id = '"+orgoruserid+"') o where o.org_id = us.org_id");
		sql.append("         )  ");
				
			//1lower
			for(int j = 0 ; j < firstCodeAreaStr.length() ; j++){
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, String.valueOf(firstCodeAreaStr.charAt(j)).toLowerCase()+"%");
				/*if(!StringUtil.nullOrBlank(orgoruserid)){
					pdb.setString(2,orgoruserid);
				}*/
				pdb.executePrepared();
				ListShowUtilBean bean = new ListShowUtilBean();
				bean.setFirstCode(String.valueOf(firstCodeAreaStr.charAt(j)));
				if(pdb.size() > 0)
					bean.setExsit(true);
				else
					bean.setExsit(false);
				list.add(bean);
		}
		
		return list;
	}

	@Override
	public void setPersonalDirectoryRelationship(String userid,
			String directoryids) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		if(!StringUtil.nullOrBlank(directoryids)){
			
			String[] directoryidArry = directoryids.split(",");
			
			sql.append(" insert into ta_oa_persondirect_relation ");
			sql.append(" (RELATIONSHIP_ID,USER_ID,DIRECTORYID)");
			sql.append("  values (seq_persondirect_relation.nextval,?,?) ");
			String dirs = getHasSetDirecttoryRelationship(userid);
			int a = 0;
			for(int i = 0 ; i < directoryidArry.length ; i ++ ){
				if(dirs.indexOf(directoryidArry[i]) == -1){
					a++;
					pdb.preparedInsert(sql.toString());
					pdb.setString(1, userid);
					pdb.setString(2, directoryidArry[i]);
					pdb.addPreparedBatch();
				}
			}
			if(a > 0){
				pdb.executePreparedBatch();
			}
			
		}

	}

	@Override
	public void cancelPersonalDirectoryRelationship(String userid,
			String directoryids,Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		if(!StringUtil.nullOrBlank(directoryids) && !StringUtil.nullOrBlank(userid)){
			
			sql.append(" delete from ta_oa_persondirect_relation ");
			sql.append(" where user_id = '"+userid+"' and directoryid in ("+directoryids+")");

			pdb.preparedDelete(sql.toString());
			pdb.executePrepared(con);
		}
	}



	@Override
	public String getHasSetDirecttoryRelationship(String userid)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select to_char(wmsys.wm_concat(DIRECTORYID)) dirs from ta_oa_persondirect_relation where user_id = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, userid);
		pdb.executePrepared();
		
		String dirs = "";
		if(pdb.size() > 0){
			dirs = pdb.getString(0, "dirs");
		}
		return dirs;
	}



	/**
	 * 查询用户id是否存在
	 */
	public int queryUser(String username) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select u.user_id from td_sm_user u");
		sql.append(" where u.user_realname='"+username+"'");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pdb.size();
	}



	/**
	 * 通过orgname查orgid
	 */
	public String queryOrgId(String orgname) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String orgid="";
		sql.append(" select o.org_id from td_sm_organization o");
		sql.append(" where o.org_name='"+orgname+"'");
		sql.append("  and rownum=1 ");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				orgid=pdb.getString(i, "org_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orgid;
	}
	
	



}
