package com.chinacreator.xtbg.core.personwork.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.DictDropDownList;
import com.chinacreator.xtbg.core.common.util.PinyinUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.constant.DirectoryConstant;
import com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao;
import com.chinacreator.xtbg.core.personwork.entity.ListShowUtilBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonExtraInfoBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonExtraShowBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonInfoBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonSearchBean;
import com.chinacreator.xtbg.core.personwork.entity.PublicAddressDirectoryBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:PersonInfoDaoImpl.java
 * </p>
 *<p>
 * Description:通讯录管理dao类实现
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-13
 */
public class PersonInfoDaoImpl extends XtDbBaseDao implements PersonInfoDao {

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findPersonalAddressBookList
	 * 
	 * @param personSearchBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#findPersonalAddressBookList(com.chinacreator.xtbg.core.personwork.entity.PersonSearchBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findPersonalAddressBookList(
			PersonSearchBean personSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();

		try {
			PagingBean pb = new PagingBean();
			PreparedDBUtil db = new PreparedDBUtil();
			List<PersonInfoBean> list = new ArrayList<PersonInfoBean>();
			StringBuffer sql = new StringBuffer();

			sql.append("select *");
			sql.append("  from (select distinct (t.person_id),");
			sql.append("                        name,");
			sql.append("                        (select t1.field_value");
			sql
					.append("                           from oa_personwork_extrainfo t1");
			sql
					.append("                          where t1.person_id = t.person_id");
			sql.append("                            and t1.field_name = 'qq'");
			sql.append("                            and rownum = 1) qq,");
			sql.append("                        (select t1.field_value");
			sql
					.append("                           from oa_personwork_extrainfo t1");
			sql
					.append("                          where t1.person_id = t.person_id");
			sql
					.append("                            and t1.field_name = '办公手机'");
			sql
					.append("                            and rownum = 1) commonlymobile,");
			sql.append("                        (select t1.field_value");
			sql
					.append("                           from oa_personwork_extrainfo t1");
			sql
					.append("                          where t1.person_id = t.person_id");
			sql
					.append("                            and t1.field_name = '电子邮箱'");
			sql.append("                            and rownum = 1) email,");
			sql
					.append("                        (select to_char(wmsys.wm_concat(g.group_name))");
			sql.append("                           from oa_personwork_group g");
			sql
					.append("                          inner join oa_personwork_persongroup t1");
			sql
					.append("                             on t1.group_id = g.group_id");
			sql
					.append("                          where t.person_id = t1.person_id) group_name,");
			sql
					.append("                        (select to_char(wmsys.wm_concat(t1.group_id))");
			sql
					.append("                           from oa_personwork_persongroup t1");
			sql
					.append("                          where t.person_id = t1.person_id) group_id,");
			sql
					.append("                        'personaladdress' info_source,");
			sql.append("                        '个人通讯录' as info_source_name,");
			sql.append("                        t.user_id,");
			sql.append("                        t.eng_name");
			sql.append("          from oa_personwork_personinfo t");
			sql.append("          left join oa_personwork_extrainfo e");
			sql.append("            on t.person_id = e.person_id");
			sql.append("         where t.info_type = 'personal' and t.is_public = ? ");

			if (StringUtil.deNull(personSearchBean.getIs_public()).equals("1")) {//公共通讯录，所有人都可以查看
				sql.append(") tt");
				sql.append("  where 1 = 1 ");
			} else {
				sql.append("        union");
				sql.append("        select to_char(t3.user_id) as person_id,");
				sql.append("               t3.user_realname as name,");
				sql.append("               '' as qq,");
				sql.append("               t3.user_mobiletel1 as commonlymobile,");
				sql.append("               t3.user_email,");
				sql.append("               '' as group_name,");
				sql.append("               '' as group_id,");
				sql.append("               'directory' as info_source,");
				sql.append("               '单位通讯录' as info_source_name,");
				sql.append("               r.user_id,");
				sql.append("               t3.user_name");
				sql.append("          from td_sm_user t3");
				sql.append("         inner join oa_persondirect_relation r");
				sql.append("            on r.directoryid = t3.user_id");
				sql.append(") tt");
				sql.append("  where tt.user_id = ? ");
			}
			
			if (!StringUtil.nullOrBlank(personSearchBean.getLikevalue())) {
				sql.append("and ( upper(tt.name) like ?  or");
				sql
						.append("	       tt.commonlymobile like ?  or upper(tt.email) like ?)");
			}

			if (!StringUtil.nullOrBlank(personSearchBean.getNameindex())) {
				sql.append("and lower(tt.eng_name) like ? ");
			}
			// 分组名称
			if (!StringUtil.nullOrBlank(personSearchBean.getGroupname())) {
				// sql.append("and group_name in ( '"+personSearchBean.getGroupname()+"' )");
				sql.append("and group_name like ? ");
			}

			sql.append(" order by " + sortName + " " + sortOrder);

			db.preparedSelect(sql.toString(), offset, maxPagesize);
			int j = 1;
			db.setString(j++, personSearchBean.getIs_public());
			if (StringUtil.deNull(personSearchBean.getIs_public()).equals("1")) {//公共通讯录，所有人都可以查看
			} else {
				db.setString(j++, personSearchBean.getUserid());
			}
			
			if (!StringUtil.nullOrBlank(personSearchBean.getLikevalue())) {
				db.setString(j++, "%"
						+ personSearchBean.getLikevalue().toUpperCase() + "%");
				db.setString(j++, "%" + personSearchBean.getLikevalue() + "%");
				db.setString(j++, "%"
						+ personSearchBean.getLikevalue().toUpperCase() + "%");
			}

			if (!StringUtil.nullOrBlank(personSearchBean.getNameindex())) {
				db.setString(j++, personSearchBean.getNameindex().toLowerCase()
						+ "%");
			}
			// 分组名称
			if (!StringUtil.nullOrBlank(personSearchBean.getGroupname())) {
				String Strgroupname = personSearchBean.getGroupname();
				db.setString(j++, "%" + Strgroupname.trim() + "%");
			}
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				PersonInfoBean personInfoBean = new PersonInfoBean();
				personInfoBean.setPerson_id(db.getString(i, "person_id"));
				personInfoBean.setName(db.getString(i, "name"));
				personInfoBean.setQqNum(db.getString(i, "qq"));
				personInfoBean.setCommonlymobile(db.getString(i,
						"commonlymobile"));
				personInfoBean.setEmail(db.getString(i, "email"));
				personInfoBean.setGroup(db.getString(i, "group_name"));
				personInfoBean.setGroup_id(db.getString(i, "group_id"));
				personInfoBean.setInfo_source(db.getString(i, "info_source"));
				personInfoBean.setUser_id(db.getString(i, "user_id"));
				personInfoBean.setInfo_source_name(db.getString(i,
						"info_source_name"));
				list.add(personInfoBean);
			}

			pb.setList(list);
			pb.setRecords((long) db.getTotalSize());
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	
	/**
	 * 
	 * <b>Summary: </b> 复写方法 findOrgidList
	 * 
	 * @param orgid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#findOrgidList(java.lang.String)
	 */
	@Override
	public List<PersonSearchBean> findOrgidList(String orgid)
			throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil db = new PreparedDBUtil();
			List<PersonSearchBean> list = new ArrayList<PersonSearchBean>();
			StringBuffer sql = new StringBuffer();
			sql.append("select a.org_id ");
			sql.append(" from td_sm_organization a ");
			sql.append(" connect by prior a.org_id=a.parent_id ");
			/** 父节点parent_id在左边是向上递归，在右边是向下递归 **/
			sql.append(" start with a.org_id='");
			sql.append(orgid);
			sql.append("'  order by a.org_sn");

			db.executeSelect(sql.toString(), conn);
			for (int i = 0; i < db.size(); i++) {
				PersonSearchBean personSearchBean = new PersonSearchBean();
				personSearchBean.setOrgid(db.getString(i, "org_id"));
				list.add(personSearchBean);
			}

			return list;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findPublicAddressBook4RoleuserList
	 * 
	 * @param personSearchBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#findPublicAddressBook4RoleuserList(com.chinacreator.xtbg.core.personwork.entity.PersonSearchBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findPublicAddressBook4RoleuserList(
			PersonSearchBean personSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		AccessControl accesscontroler = AccessControl.getAccessControl();
		String userid = accesscontroler.getUserID();	
		try {
			PagingBean pb = new PagingBean();
			PreparedDBUtil db = new PreparedDBUtil();
			List<PublicAddressDirectoryBean> list = new ArrayList<PublicAddressDirectoryBean>();
			StringBuffer sql = new StringBuffer();

			sql
					.append("select o.org_id,o.org_name, u.user_id, u.user_name, u.user_realname,u.user_mobiletel1,u.user_sn,");
			sql
					.append("u.user_mobiletel2,u.user_worktel,u.user_hometel,u.user_email,u.remark2,u.remark4,u.remark5,usn.*");
			sql
					.append("  from (select rownum index_sn, org.org_id, org.org_name ");
			sql.append("          from td_sm_organization org ");
			sql.append("         start with org.org_id = ? ");
			sql.append("        connect by prior org.org_id = org.parent_id");
			sql.append("         order siblings by org.org_sn) o");
			sql.append("  left join td_sm_orguser ou on ou.org_id = o.org_id");
			sql.append("  left join td_sm_user u on u.user_id = ou.user_id");
			sql
					.append("  left join td_sm_userjoborg a on a.user_id = ou.user_id");
			sql
					.append("                              and ou.org_id = a.org_id");
			sql
					.append("   left join oa_userandsn usn on u.user_id = usn.userid");
			sql.append(" where (u.user_name is not null)");
			//特检院 OA 【人员配置管理】 人员持证查看  start
			//是否部门管理员
			boolean isManager = accesscontroler.isOrganizationManager(personSearchBean.getOrgid());
			if(isManager==true||"1".equals(userid)){
			} else {
				sql.append(" and instr((select t.config_ids  ");
				sql.append("	from oa_dataresources_config t ");
				sql.append("	 where t.resources_id = '39' ");
				sql.append("	       and t.config_type = '2' ");
				sql.append("	       and t.config_typeid = '"+userid+"'),u.user_id,1,1)>0");
			}
			//特检院 OA 【人员配置管理】  人员持证查看  end
			if (!StringUtil.nullOrBlank(personSearchBean.getLikevalue())) {
				sql.append(" and (u.user_realname like ?  or");
				sql.append("      o.org_name like ? or ");
				sql.append("	  u.user_mobiletel1 like ?  or ");
				sql.append("      u.user_email like ? or ");
				sql.append("      u.user_worktel like ? or ");
				sql.append("      u.user_hometel like ? or ");
				//追加增加对【短号】字段的查询
				sql.append("      remark4 like ?) ");
			}
			// 是否是党政一把手
			if (!StringUtil.nullOrBlank(personSearchBean.getDepartment())) {
				if ("是".equals(personSearchBean.getDepartment().trim())) {
					sql.append(" and numberone = '"
							+ personSearchBean.getDepartment().trim() + "'");
				} else {
					sql.append(" and (numberone = '"
							+ personSearchBean.getDepartment().trim()
							+ "' or numberone is null) ");
				}
			}
			// 级别
			String array[] = personSearchBean.getDirectorylevel().split(",");
			if (!StringUtil.nullOrBlank(personSearchBean.getDirectorylevel())) {

				sql.append(" and ( usn.directorylevel like ?");
				for (int i = 0; i < array.length - 1; i++) {
					sql.append(" or usn.directorylevel like ?  ");
				}
				sql.append(" ) ");
			}
			// 政治面貌
			String parray[] = personSearchBean.getPolitics().split(",");
			if (!StringUtil.nullOrBlank(personSearchBean.getPolitics())) {
				sql.append(" and ( usn.politics = ?");
				for (int i = 0; i < parray.length - 1; i++) {
					sql.append(" or usn.politics  =?  ");
				}
				sql.append(" ) ");

			}
			// 所在单位
			if (!StringUtil.nullOrBlank(personSearchBean.getOrgname())) {
				sql.append(" and o.org_name  like ? ");
			}
			if (!StringUtil.nullOrBlank(personSearchBean.getNameindex())) {
				sql.append(" and u.user_name like ? ");
			}

			sql
					.append(" order by to_number(o.index_sn), a.same_job_user_sn, u.user_sn");

			// 通讯录导出 0:不分页
			if (!StringUtil.nullOrBlank(personSearchBean.getPageValue())
					&& "0".equals(personSearchBean.getPageValue())) {
				db.preparedSelect(sql.toString());
			} else {
				db.preparedSelect(sql.toString(), offset, maxPagesize);
			}

			int j = 1;
			db.setString(j++, personSearchBean.getOrgid());
			if (!StringUtil.nullOrBlank(personSearchBean.getLikevalue())) {
				String name = personSearchBean.getLikevalue();
				String email = personSearchBean.getLikevalue();
				db.setString(j++, "%" + name.toLowerCase() + "%");
				db.setString(j++, "%" + personSearchBean.getLikevalue() + "%");
				db.setString(j++, "%" + personSearchBean.getLikevalue() + "%");
				db.setString(j++, "%" + email.toLowerCase() + "%");
				db.setString(j++, "%" + personSearchBean.getLikevalue() + "%");
				db.setString(j++, "%" + personSearchBean.getLikevalue() + "%");
				//追加增加对【短号】字段的查询
				db.setString(j++, "%" + personSearchBean.getLikevalue() + "%");
			}
			// 是否是党政一把手
			if (!StringUtil.nullOrBlank(personSearchBean.getDepartment())) {
				sql.append(" and numberone = '"
						+ personSearchBean.getDepartment() + "' ");
			}
			// 级别
			if (!StringUtil.nullOrBlank(personSearchBean.getDirectorylevel())) {
				for (int i = 0; i < array.length; i++) {
					db.setString(j++, "%" + array[i] + "%");
				}
			}
			// 政治面貌
			if (!StringUtil.nullOrBlank(personSearchBean.getPolitics())) {
				for (int i = 0; i < parray.length; i++) {
					if ("中共党员".equals(parray[i])) {
						parray[i] = "1";
					} else if ("中共预备党员".equals(parray[i])) {
						parray[i] = "2";
					} else if ("共青团员".equals(parray[i])) {
						parray[i] = "3";
					} else if ("民革党员".equals(parray[i])) {
						parray[i] = "4";
					} else if ("民盟盟员".equals(parray[i])) {
						parray[i] = "5";
					} else if ("民建会员".equals(parray[i])) {
						parray[i] = "6";
					} else if ("民进会员".equals(parray[i])) {
						parray[i] = "7";
					} else if ("农工党党员".equals(parray[i])) {
						parray[i] = "8";
					} else if ("致公党党员".equals(parray[i])) {
						parray[i] = "9";
					} else if ("九三学社社员".equals(parray[i])) {
						parray[i] = "10";
					} else if ("台盟盟员".equals(parray[i])) {
						parray[i] = "11";
					} else if ("无党派民主人士".equals(parray[i])) {
						parray[i] = "12";
					} else if ("群众".equals(parray[i])) {
						parray[i] = "13";
					}
					db.setString(j++, "" + parray[i] + "");
				}
			}
			// 所在单位
			if (!StringUtil.nullOrBlank(personSearchBean.getOrgname())) {
				db.setString(j++, "%" + personSearchBean.getOrgname() + "%");
			}
			if (!StringUtil.nullOrBlank(personSearchBean.getNameindex())) {
				db.setString(j++, personSearchBean.getNameindex().toLowerCase()
						+ "%");
			}

			db.executePrepared(conn);

			String dirs = getHasSetDirecttoryRelationship(personSearchBean
					.getUserid());

			for (int i = 0; i < db.size(); i++) {
				PublicAddressDirectoryBean ab = new PublicAddressDirectoryBean();
				ab.setDirectoryid(db.getString(i, "user_id"));
				ab
						.setIs_relation((dirs.indexOf(db
								.getString(i, "user_id")) == -1) ? "未引用"
								: "已引用");
				ab.setDirectoryname(db.getString(i, "user_realname"));
				ab.setIshasviewrole("false");

				if ("Y".equals(db.getString(i, "five_major_org"))) {// 判断是否是五大机构

					/**
					 * 由于新系统中没有资源配置表，故先屏蔽权限的判断
					 * 
					 * @alter by 戴连春
					 * @alter date 2013-6-8
					 */
					// 判断当前用户是否有对当前通讯录数据的查看权限，没权限就只能看姓名，并且页面不展示详细记录
					// if ("add".equals(personSearchBean.getListtype())
					// || ("," + role_ids + ",").indexOf(","
					// + db.getString(i, "user_id") + ",") != -1) {
					if ("add".equals(personSearchBean.getListtype())) {
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
						ab.setRemark4(db.getString(i, "remark4"));
						ab.setRemark5(db.getString(i, "remark5"));

						ab.setDirectorylevel(db.getString(i, "directorylevel"));
						if (!StringUtil
								.nullOrBlank(db.getString(i, "politics"))) {
							String politics = "";
							Integer number = Integer.parseInt(db.getString(i,
									"politics"));
							if (number > 0) {
								switch (Integer.parseInt(db.getString(i,
										"politics"))) {
								case 1:
									politics = "中共党员";
									break;
								case 2:
									politics = "中共预备党员";
									break;
								case 3:
									politics = "共青团员";
									break;
								case 4:
									politics = "民革党员";
									break;
								case 5:
									politics = "民盟盟员";
									break;
								case 6:
									politics = "民建会员";
									break;
								case 7:
									politics = "民进会员";
									break;
								case 8:
									politics = "农工党党员";
									break;
								case 9:
									politics = "致公党党员";
									break;
								case 10:
									politics = "九三学社社员";
									break;
								case 11:
									politics = "台盟盟员";
									break;
								case 12:
									politics = "无党派民主人士";
									break;
								case 13:
									politics = "群众";
									break;
								}
							}
							ab.setPolitics(politics);
						} else {
							ab.setPolitics(db.getString(i, "politics"));
						}
						if ("是".equals(db.getString(i, "numberone"))) {
							ab.setDepartment("是");
						} else {
							ab.setDepartment("否");
						}

						ab.setSpecialty(db.getString(i, "specialty"));
						ab.setMobile(db.getString(i, "user_mobiletel1"));
						ab.setMobile2(db.getString(i, "user_mobiletel2"));
						ab.setHomeadress(db.getString(i, "homeadress"));
						ab.setWorkphone(db.getString(i, "user_worktel"));

						ab.setWorkadress(db.getString(i, "workadress"));
						ab.setHomephone(db.getString(i, "USER_HOMETEL"));
						ab.setEmail(db.getString(i, "user_email"));
						ab.setRemark2(db.getString(i, "remark2"));
						ab.setDuty(db.getString(i, "duty"));

						ab.setResume(db.getString(i, "resume"));
						ab.setOrgid(db.getString(i, "org_id"));
						ab.setOrgname(db.getString(i, "org_name"));
						//特检院OA 个性化显示【职务】 start  
						//ab.setPost(db.getString(i, "duties"));
						ab.setPost(DirectoryConstant.parsePost(db.getString(i, "duties"), true));
						//特检院OA 个性化显示【职务】 end
						ab.setDuties(db.getString(i, "duties"));
						ab.setIshasviewrole("true");
					}
					list.add(ab);
				} else {

					ab.setDirectoryyear(db.getString(i, "directoryyear"));
					ab.setDirectorysex(db.getString(i, "directorysex"));
					//特检院OA 个性化显示【职务】 start  
					//ab.setPost(db.getString(i, "duties"));
					ab.setPost(DirectoryConstant.parsePost(db.getString(i, "duties"), true));
					//特检院OA 个性化显示【职务】 end
					ab.setDirectorystate(db.getString(i, "directorystate"));
					ab.setEducation(db.getString(i, "education"));
					ab.setDegree(db.getString(i, "degree"));
					ab.setSeniority(db.getString(i, "seniority"));

					ab.setSchool(db.getString(i, "school"));
					ab.setNation(db.getString(i, "nation"));
					ab.setNatives(db.getString(i, "natives"));

					if (!StringUtil.nullOrBlank(db.getString(i, "politics"))) {
						String politics = "";
						Integer number = Integer.parseInt(db.getString(i,
								"politics"));
						if (number > 0) {
							switch (number) {
							case 1:
								politics = "中共党员";
								break;
							case 2:
								politics = "中共预备党员";
								break;
							case 3:
								politics = "共青团员";
								break;
							case 4:
								politics = "民革党员";
								break;
							case 5:
								politics = "民盟盟员";
								break;
							case 6:
								politics = "民建会员";
								break;
							case 7:
								politics = "民进会员";
								break;
							case 8:
								politics = "农工党党员";
								break;
							case 9:
								politics = "致公党党员";
								break;
							case 10:
								politics = "九三学社社员";
								break;
							case 11:
								politics = "台盟盟员";
								break;
							case 12:
								politics = "无党派民主人士";
								break;
							case 13:
								politics = "群众";
								break;
							}
						}
						ab.setPolitics(politics);
					} else {
						ab.setPolitics(db.getString(i, "politics"));
					}
					ab.setDirectorylevel(db.getString(i, "directorylevel"));
					if ("是".equals(db.getString(i, "numberone"))) {
						ab.setDepartment("是");
					} else {
						ab.setDepartment("否");
					}
					ab.setSpecialty(db.getString(i, "specialty"));
					ab.setMobile(db.getString(i, "user_mobiletel1"));
					ab.setMobile2(db.getString(i, "user_mobiletel2"));
					ab.setHomeadress(db.getString(i, "homeadress"));
					ab.setWorkphone(db.getString(i, "user_worktel"));

					ab.setWorkadress(db.getString(i, "workadress"));
					ab.setHomephone(db.getString(i, "user_hometel"));
					ab.setEmail(db.getString(i, "user_email"));
					ab.setRemark2(db.getString(i, "remark2"));
					ab.setRemark4(db.getString(i, "remark4"));
					ab.setRemark5(db.getString(i, "remark5"));
					ab.setDuty(db.getString(i, "duty"));

					ab.setResume(db.getString(i, "resume"));
					ab.setOrgid(db.getString(i, "org_id"));
					ab.setOrgname(db.getString(i, "org_name"));
					//特检院OA 个性化显示【职务】 start 
					//ab.setPost(db.getString(i, "duties"));
					ab.setPost(DirectoryConstant.parsePost(db.getString(i, "duties"), true));
					//特检院OA 个性化显示【职务】 end
					ab.setDuties(db.getString(i, "duties"));
					ab.setIshasviewrole("true");
					// }
					list.add(ab);
				}
			}

			pb.setList(list);
			pb.setRecords((long) db.getTotalSize());
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 savePersonBaseInfo
	 * 
	 * @param personInfoBean
	 * @param con
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#savePersonBaseInfo(com.chinacreator.xtbg.core.personwork.entity.PersonInfoBean,
	 *      java.sql.Connection)
	 */
	@Override
	public String savePersonBaseInfo(PersonInfoBean personInfoBean,
			Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();

		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		String person_id = personInfoBean.getPerson_id();
		sql1.append("select * from oa_personwork_personinfo t where t.person_id = ?");
		pdb.preparedSelect(sql1.toString());
		pdb.setString(1, person_id);
		pdb.executePrepared(con);
		
		if (pdb.size() > 0) {
			sql2.append("update oa_personwork_personinfo");
			sql2.append("   set user_id     = ?,");
			sql2.append("       name        = ?,");
			sql2.append("       info_type   = ?,");
			sql2.append("       nick_name   = ?,");
			sql2.append("       create_time = ?,");
			sql2.append("       eng_name    = ?,");
			sql2.append("       org_id      = ?,");
			sql2.append("       remark      = ?");
			sql2.append(" where person_id = ?");

			pdb.preparedUpdate(sql2.toString());

			pdb.setString(1, StringUtil.deNull(personInfoBean.getUser_id()));
			pdb.setString(2, StringUtil.deNull(personInfoBean.getName()));
			pdb.setString(3, StringUtil.deNull(personInfoBean.getInfo_type()));
			pdb.setString(4, StringUtil.deNull(personInfoBean.getNick_name()));
			pdb.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			pdb.setString(6, PinyinUtil.hanziToPinyin(StringUtil
					.deNull(personInfoBean.getName())));
			pdb.setString(7, StringUtil.deNull(personInfoBean.getOrg_id()));
			pdb.setString(8, StringUtil.deNull(personInfoBean.getRemark()));
			pdb.setString(9, person_id);
			pdb.executePrepared(con);

			sql.setLength(0);
			sql
					.append("delete from oa_personwork_persongroup where person_id = ?");
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, personInfoBean.getPerson_id());
			pdb.executePrepared(con);

			sql.setLength(0);
			sql.append("insert into oa_personwork_persongroup ");
			sql.append("  (persongroup_id, person_id, group_id)");
			sql.append("values");
			sql.append("  (?, ?, ?)");
			String[] groupids = null;
			if (!StringUtil.nullOrBlank(personInfoBean.getGroup_id())) {
				groupids = personInfoBean.getGroup_id().split(",");
				for (int i = 0; i < groupids.length; i++) {
					pdb.preparedInsert(sql.toString());
					pdb.setString(1, StringUtil.getUUID());
					pdb.setString(2, personInfoBean.getPerson_id());
					pdb.setString(3, groupids[i]);
					pdb.addPreparedBatch();
				}
				pdb.executePreparedBatch(con);
			}
		} else {

			sql2.append("insert into oa_personwork_personinfo");
			sql2.append("  (person_id,");
			sql2.append("   user_id,");
			sql2.append("   name,");
			sql2.append("   info_type,");
			sql2.append("   nick_name,");
			sql2.append("   create_time,");
			sql2.append("   eng_name,");
			sql2.append("   org_id,is_public,remark)");
			sql2.append(" values ");
			sql2.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?,?)");

			pdb.preparedInsert(sql2.toString());
			person_id = StringUtil.getUUID();// 生成id编码
			pdb.setString(1, person_id);
			pdb.setString(2, StringUtil.deNull(personInfoBean.getUser_id()));
			pdb.setString(3, StringUtil.deNull(personInfoBean.getName()));
			pdb.setString(4, StringUtil.deNull(personInfoBean.getInfo_type()));
			pdb.setString(5, StringUtil.deNull(personInfoBean.getNick_name()));
			pdb.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pdb.setString(7, PinyinUtil.hanziToPinyin(StringUtil
					.deNull(personInfoBean.getName())));
			pdb.setString(8, StringUtil.deNull(personInfoBean.getOrg_id()));
			pdb.setString(9, StringUtil.deNull(personInfoBean.getIs_public()));
			pdb.setString(10, StringUtil.deNull(personInfoBean.getRemark()));
			pdb.executePrepared(con);

			sql.setLength(0);
			sql.append("insert into oa_personwork_persongroup ");
			sql.append("  (persongroup_id, person_id, group_id)");
			sql.append(" values ");
			sql.append(" (?, ?, ?)");
			String[] groupids = null;
			if (!StringUtil.nullOrBlank(personInfoBean.getGroup_id())) {
				groupids = personInfoBean.getGroup_id().split(",");
				for (int i = 0; i < groupids.length; i++) {
					pdb.preparedInsert(sql.toString());
					pdb.setString(1, StringUtil.getUUID());
					pdb.setString(2, person_id);
					pdb.setString(3, groupids[i]);
					pdb.addPreparedBatch();
				}
				pdb.executePreparedBatch(con);
			}
		}

		return person_id;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 savePersonExtraInfo
	 * 
	 * @param person_id
	 * @param type
	 * @param personExtraInfoList
	 * @param con
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#savePersonExtraInfo(java.lang.String,
	 *      java.lang.String, java.util.List, java.sql.Connection)
	 */
	@Override
	public void savePersonExtraInfo(String person_id, String type,
			List<PersonExtraInfoBean> personExtraInfoList, Connection con)
			throws Exception {

		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		sql1
				.append("delete from oa_personwork_extrainfo t where t.person_id = ? and t.type = ?");

		sql.append("insert into oa_personwork_extrainfo");
		sql
				.append("  (extra_id, person_id, field_name, field_value, type, showindex)");
		sql.append("values");
		sql.append("  (?, ?, ?, ?, ?, ?)");

		pdb.preparedDelete(sql1.toString());
		pdb.setString(1, person_id);
		pdb.setString(2, type);
		pdb.executePrepared(con);

		if (personExtraInfoList != null && personExtraInfoList.size() > 0) {
			for (int i = 0; i < personExtraInfoList.size(); i++) {
				PersonExtraInfoBean personExtraInfoBean = personExtraInfoList
						.get(i);
				pdb.preparedInsert(sql.toString());
				pdb.setString(1, StringUtil.getUUID());
				pdb.setString(2, person_id);
				pdb.setString(3, StringUtil.deNull(personExtraInfoBean
						.getField_name()));
				pdb.setString(4, StringUtil.deNull(personExtraInfoBean
						.getField_value()));
				pdb.setString(5, type);
				pdb.setString(6, StringUtil.deNull(personExtraInfoBean
						.getShowindex()));

				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(con);
		}

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findPersonBaseInfo
	 * 
	 * @param personId
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#findPersonBaseInfo(java.lang.String)
	 */
	@Override
	public PersonInfoBean findPersonBaseInfo(String personId)
			throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil db = new PreparedDBUtil();

			StringBuffer sql = new StringBuffer();
			sql.append("select ");
			sql.append("   t.name,");
			sql.append("   t.info_type,");
			sql.append("   t.nick_name,");
			sql.append("   t.org_id,");
			sql.append("   o.org_name,");
			sql.append("   t.remark,");
			sql
					.append("       (select to_char(wmsys.wm_concat(g.group_name)) ");
			sql.append("  		from oa_personwork_group g");
			sql
					.append(" 		inner join oa_personwork_persongroup t1 on t1.group_id = g.group_id");
			sql.append(" 		where t1.person_id = t.person_id");
			sql.append("  		) group_name,");
			sql.append("       (select to_char(wmsys.wm_concat(g.group_id)) ");
			sql.append("  		from oa_personwork_persongroup g");
			sql.append(" 		where g.person_id = t.person_id");
			sql.append("  		) group_id");
			sql.append("   from oa_personwork_personinfo t ");
			sql
					.append("   left join td_sm_organization o on o.org_id = t.org_id ");
			sql.append("   where person_id = ?");

			PersonInfoBean personInfoBean = new PersonInfoBean();

			db.preparedSelect(sql.toString());
			db.setString(1, personId);
			db.executePrepared(conn);
			if (db.size() > 0) {

				personInfoBean.setPerson_id(personId);
				personInfoBean.setName(db.getString(0, "name"));
				personInfoBean.setNick_name(db.getString(0, "nick_name"));
				personInfoBean.setInfo_type(db.getString(0, "info_type"));
				personInfoBean.setGroup_id(db.getString(0, "group_id"));
				personInfoBean.setGroup(db.getString(0, "group_name"));
				personInfoBean.setOrg_id(db.getString(0, "org_id"));
				personInfoBean.setOrg_name(db.getString(0, "org_name"));
				personInfoBean.setRemark(db.getString(0, "remark"));
			}

			return personInfoBean;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findPersonExtraInfoList
	 * 
	 * @param personId
	 * @param type
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#findPersonExtraInfoList(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public List<PersonExtraShowBean> findPersonExtraInfoList(String personId,
			String type) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil db = new PreparedDBUtil();
			List<PersonExtraShowBean> list = new ArrayList<PersonExtraShowBean>();
			String selectname = "";
			String selectedvalue = "";
			switch (Integer.parseInt(type)) {
			case 1:
				selectname = "phone";
				selectedvalue = "办公手机";
				break;
			case 2:
				selectname = "fox";
				break;
			case 3:
				selectname = "email";
				break;
			case 4:
				selectname = "qq";
				break;
			case 5:
				selectname = "birth";
				break;
			case 6:
				selectname = "company";
				break;
			case 7:
				selectname = "position";
				break;
			case 8:
				selectname = "address";
				break;
			case 9:
				selectname = "website";
				break;
			default:
				;
			}
			String selectHtml = "";

			if ("4567".indexOf(type) == -1) {
				selectHtml = getPersonExtraInfoDictDropDownList(type,
						selectname, selectedvalue);
			}

			StringBuffer sql = new StringBuffer();
			sql.append("select field_name,field_value,showindex");
			sql.append("  from oa_personwork_extrainfo");
			sql.append(" where person_id = ?");
			sql.append("   and type = ?");

			db.preparedSelect(sql.toString());
			db.setString(1, personId);
			db.setString(2, type);
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				PersonExtraShowBean personExtraShowBean = new PersonExtraShowBean();
				personExtraShowBean.setField(db.getString(i, "field_name"));
				personExtraShowBean.setValue(db.getString(i, "field_value"));
				selectHtml = selectHtml.replace("selected", "");
				personExtraShowBean.setSelectHtml(selectHtml.replace(">"
						+ db.getString(i, "field_name"), " selected>"
						+ db.getString(i, "field_name")));

				list.add(personExtraShowBean);
			}
			if (list.size() <= 0) {
				PersonExtraShowBean personExtraShowBean = new PersonExtraShowBean();
				personExtraShowBean.setSelectHtml(selectHtml);
				personExtraShowBean.setValue("");
				list.add(personExtraShowBean);
			}

			return list;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 *<b>Summary: </b> getPersonExtraInfoDictDropDownList(请用一句话描述这个方法的作用)
	 * 
	 * @param type
	 * @param selectname
	 * @param selectedvalue
	 * @return
	 * @throws Exception
	 */
	public String getPersonExtraInfoDictDropDownList(String type,
			String selectname, String selectedvalue) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql
				.append(
						"select field_name as field,field_name from oa_PERSONWORK_PERSONINFOPAR where parent_id = '")
				.append(type).append("' and is_pc = 'Y'");

		String sceneTypeList = DictDropDownList.buildSelect(sql.toString(),
				selectname, selectedvalue, "", false, "");
		return sceneTypeList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deletePersonInfo
	 * 
	 * @param personids
	 * @param con
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#deletePersonInfo(java.lang.String,
	 *      java.sql.Connection)
	 */
	@Override
	public void deletePersonInfo(String personids, Connection con)
			throws Exception {

		PreparedDBUtil db = new PreparedDBUtil();

		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		if (StringUtil.nullOrBlank(personids))
			return;
		String[] personidarry = personids.split(",");
		sql.append("delete from oa_personwork_personinfo where person_id = ? ");
		sql1
				.append("delete from oa_personwork_persongroup where person_id = ? ");
		sql2.append("delete from oa_personwork_extrainfo where person_id = ? ");

		for (int i = 0; i < personidarry.length; i++) {
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

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 savePersonGroupInfo
	 * 
	 * @param personids
	 * @param groupids
	 * @param con
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#savePersonGroupInfo(java.lang.String,
	 *      java.lang.String, java.sql.Connection)
	 */
	@Override
	public void savePersonGroupInfo(String personids, String groupids,
			Connection con) throws Exception {
		if (StringUtil.nullOrBlank(personids))
			return;
		String[] personArry = personids.split(",");

		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		PreparedDBUtil pdb1 = new PreparedDBUtil();

		sql.append("delete from oa_personwork_persongroup where person_id = ?");

		sql1.append("insert into oa_personwork_persongroup ");
		sql1.append("  (persongroup_id, person_id, group_id)");
		sql1.append("values");
		sql1.append("  (?, ?, ?)");

		sql2.append("select * from oa_personwork_group where group_id = ?");

		for (int i = 0; i < personArry.length; i++) {
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, personArry[i]);
			pdb.addPreparedBatch();

			if (!StringUtil.nullOrBlank(personids)) {
				String[] groupArry = groupids.split(",");
				for (int j = 0; j < groupArry.length; j++) {
					pdb1.preparedSelect(sql2.toString());
					pdb1.setString(1, groupArry[j]);
					pdb1.executePrepared();
					if (pdb1.size() > 0) {
						pdb.preparedInsert(sql1.toString());
						pdb.setString(1, StringUtil.getUUID());
						pdb.setString(2, personArry[i]);
						pdb.setString(3, groupArry[j]);
						pdb.addPreparedBatch();
					}
				}
			}
		}

		pdb.executePreparedBatch(con);

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getGroupSelectHtml
	 * 
	 * @param userid
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#getGroupSelectHtml(java.lang.String)
	 */
	@Override
	public String getGroupSelectHtml(String userid, String is_public) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql
				.append(
						"select group_id,group_name from oa_PERSONWORK_GROUP where group_id is not null ");
		//如果是查找公共通讯录，则不使用用户id
		if(!"1".equals(is_public)){
		  sql .append(" and user_id = '")
			.append(userid+"'");
        }
		sql.append(" and is_public_group = '").append(is_public).append("'");
		String sceneTypeList = DictDropDownList.buildSelect(sql.toString(),
				"combobox", "", "", false, "");
		return sceneTypeList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getOrgNameByOrgId
	 * 
	 * @param orgid
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#getOrgNameByOrgId(java.lang.String)
	 */
	@Override
	public String getOrgNameByOrgId(String orgid) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql
					.append("select org_name from td_sm_organization where org_id = ?");
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, orgid);
			pdb.executePrepared(conn);
			String orgname = "";
			if (pdb.size() > 0) {
				orgname = pdb.getString(0, "org_name");
			}
			return orgname;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getFirstCodeShowInfo
	 * 
	 * @param orgoruserid
	 * @param infoType
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#getFirstCodeShowInfo(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid,
			String infoType) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			List<ListShowUtilBean> list = new ArrayList<ListShowUtilBean>();
			PreparedDBUtil pdb = new PreparedDBUtil();
			String firstCodeAreaStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			StringBuffer sql = new StringBuffer();
			sql.append(" select t.person_id");
			sql.append("  from oa_personwork_personinfo t");
			sql.append(" where t.eng_name like ?");
			sql.append("   and t.info_type = ?");
			sql.append("   and t.user_id = ?");
			sql.append(" union");
			sql.append(" select to_char(t3.user_id) ");
			sql.append("  from td_sm_user t3 ");
			sql.append(" inner join oa_persondirect_relation r ");
			sql.append("    on r.directoryid = t3.user_id  ");
			sql.append(" where t3.user_name like ? ");
			sql.append("   and r.user_id = ?");

			for (int i = 0; i < firstCodeAreaStr.length(); i++) {
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, String.valueOf(firstCodeAreaStr.charAt(i))
						.toLowerCase()
						+ "%");
				pdb.setString(2, infoType);
				pdb.setString(4, String.valueOf(firstCodeAreaStr.charAt(i))
						.toLowerCase()
						+ "%");
				if (!StringUtil.nullOrBlank(orgoruserid)) {
					pdb.setString(3, orgoruserid);
					pdb.setString(5, orgoruserid);
				}
				pdb.executePrepared(conn);
				ListShowUtilBean bean = new ListShowUtilBean();
				bean.setFirstCode(String.valueOf(firstCodeAreaStr.charAt(i)));
				if (pdb.size() > 0)
					bean.setExsit(true);
				else
					bean.setExsit(false);
				list.add(bean);
			}

			return list;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFirstCodeShowInfo
	  * @param orgoruserid
	  * @param infoType
	  * @param isPublic
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#getFirstCodeShowInfo(java.lang.String, java.lang.String, java.lang.String)
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid,
			String infoType,String isPublic) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			List<ListShowUtilBean> list = new ArrayList<ListShowUtilBean>();
			PreparedDBUtil pdb = new PreparedDBUtil();
			String firstCodeAreaStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			StringBuffer sql = new StringBuffer();
			sql.append(" select t.person_id");
			sql.append("  from oa_personwork_personinfo t");
			sql.append(" where (t.eng_name like ?||'%' or t.eng_name like ?||'%' )");
			sql.append("   and t.info_type = ?");
			if(!"1".equals(StringUtil.deNull(isPublic))){
			   sql.append("   and t.user_id = ?");
			}
			sql.append("   and t.IS_PUBLIC = ?");
			sql.append(" union");
			sql.append(" select to_char(t3.user_id) ");
			sql.append("  from td_sm_user t3 ");
			sql.append(" inner join oa_persondirect_relation r ");
			sql.append("    on r.directoryid = t3.user_id  ");
			sql.append(" where t3.user_name like ?||'%'  ");
			sql.append("   and r.user_id = ? ");

			for (int i = 0; i < firstCodeAreaStr.length(); i++) {
				pdb.preparedSelect(sql.toString());
				int j = 1;
				pdb.setString(j++, String.valueOf(firstCodeAreaStr.charAt(i))
						.toLowerCase());
				pdb.setString(j++, String.valueOf(firstCodeAreaStr.charAt(i))
						.toUpperCase());
				pdb.setString(j++, infoType);
				if (!"1".equals(StringUtil.deNull(isPublic))) {
					pdb.setString(j++, orgoruserid);
				}
				pdb.setString(j++, isPublic);
				pdb.setString(j++, String.valueOf(firstCodeAreaStr.charAt(i))
						.toLowerCase());
				pdb.setString(j++, orgoruserid);
				
				pdb.executePrepared(conn);
				ListShowUtilBean bean = new ListShowUtilBean();
				bean.setFirstCode(String.valueOf(firstCodeAreaStr.charAt(i)));
				if (pdb.size() > 0)
					bean.setExsit(true);
				else
					bean.setExsit(false);
				list.add(bean);
			}

			return list;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b> 复写方法 getFirstCodeShowInfo4PublicAddress
	 * 
	 * @param orgoruserid
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#getFirstCodeShowInfo4PublicAddress(java.lang.String)
	 */
	@Override
	public List<ListShowUtilBean> getFirstCodeShowInfo4PublicAddress(
			String orgoruserid) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			List<ListShowUtilBean> list = new ArrayList<ListShowUtilBean>();
			PreparedDBUtil pdb = new PreparedDBUtil();
			String firstCodeAreaStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			StringBuffer sql = new StringBuffer();

			sql.append(" select t.user_id  from td_sm_user t ");
			sql.append(" left join td_sm_orguser us on t.user_id = us.user_id");
			sql.append(" where t.user_name like ? ");
			sql.append("    and exists(select 1 from (select a.org_id ");
			sql.append("          from td_sm_organization a ");
			sql.append("        connect by prior a.org_id = a.parent_id ");
			sql.append("         start with a.org_id = '" + orgoruserid
					+ "') o where o.org_id = us.org_id");
			sql.append("         )  ");

			for (int j = 0; j < firstCodeAreaStr.length(); j++) {
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, String.valueOf(firstCodeAreaStr.charAt(j))
						.toLowerCase()
						+ "%");

				pdb.executePrepared(conn);
				ListShowUtilBean bean = new ListShowUtilBean();
				bean.setFirstCode(String.valueOf(firstCodeAreaStr.charAt(j)));
				if (pdb.size() > 0)
					bean.setExsit(true);
				else
					bean.setExsit(false);
				list.add(bean);
			}
			return list;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 setPersonalDirectoryRelationship
	 * 
	 * @param userid
	 * @param directoryids
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#setPersonalDirectoryRelationship(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public void setPersonalDirectoryRelationship(String userid,
			String directoryids,Connection conn) throws Exception {
		
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			if (!StringUtil.nullOrBlank(directoryids)) {

				String[] directoryidArry = directoryids.split(",");

				sql.append(" insert into oa_persondirect_relation ");
				sql.append(" (RELATIONSHIP_ID,USER_ID,DIRECTORYID)");
				sql.append("  values (?,?,?) ");
				String dirs = getHasSetDirecttoryRelationship(userid);
				int a = 0;
				for (int i = 0; i < directoryidArry.length; i++) {
					if (dirs.indexOf(directoryidArry[i]) == -1) {
						a++;
						pdb.preparedInsert(sql.toString());
						pdb.setString(1, StringUtil.getUUID());
						pdb.setString(2, userid);
						pdb.setString(3, directoryidArry[i]);
						pdb.addPreparedBatch();
					}
				}
				if (a > 0) {
					pdb.executePreparedBatch(conn);
				}

			}		
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 cancelPersonalDirectoryRelationship
	 * 
	 * @param userid
	 * @param directoryids
	 * @param con
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#cancelPersonalDirectoryRelationship(java.lang.String,
	 *      java.lang.String, java.sql.Connection)
	 */
	@Override
	public void cancelPersonalDirectoryRelationship(String userid,
			String directoryids, Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();

		if (!StringUtil.nullOrBlank(directoryids)
				&& !StringUtil.nullOrBlank(userid)) {

			sql.append(" delete from oa_persondirect_relation ");
			sql.append(" where user_id = '" + userid + "' and directoryid in ("
					+ directoryids + ")");

			pdb.preparedDelete(sql.toString());
			pdb.executePrepared(con);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getHasSetDirecttoryRelationship
	 * 
	 * @param userid
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#getHasSetDirecttoryRelationship(java.lang.String)
	 */
	@Override
	public String getHasSetDirecttoryRelationship(String userid)
			throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql
					.append("select to_char(wmsys.wm_concat(DIRECTORYID)) dirs from oa_persondirect_relation where user_id = ?");
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, userid);
			pdb.executePrepared(conn);

			String dirs = "";
			if (pdb.size() > 0) {
				dirs = pdb.getString(0, "dirs");
			}
			return dirs;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 queryUser
	 * 
	 * @param username
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#queryUser(java.lang.String)
	 */
	public int queryUser(String username) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			return queryUser(username, conn);
		} finally {
			DbManager.closeConnection(conn);
		}

	}

	public int queryUser(String username, Connection conn) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select u.user_id from td_sm_user u");
		sql.append(" where u.user_realname='" + username + "'");

		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);

		return pdb.size();
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 queryOrgId
	 * 
	 * @param orgname
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#queryOrgId(java.lang.String)
	 */
	public String queryOrgId(String orgname) throws SQLException {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			return queryOrgId(orgname, conn);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 queryOrgId
	 * 
	 * @param orgname
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao#queryOrgId(java.lang.String)
	 */
	public String queryOrgId(String orgname, Connection conn)
			throws SQLException {

		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String orgid = "";
		sql.append(" select o.org_id from td_sm_organization o");
		sql.append(" where o.org_name='" + orgname + "'");
		sql.append("  and rownum=1 ");

		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);

		for (int i = 0; i < pdb.size(); i++) {
			orgid = pdb.getString(i, "org_id");
		}

		return orgid;
	}

	/**
	 * 
	 *<b>Summary: 根据用户id判断用户是否添加了通讯录分组</b> isGroupExists(请用一句话描述这个方法的作用)
	 * 
	 * @param userId
	 *            用户id
	 * @return 是否存在分组的标志 true：存在，false:不存在
	 * @throws Exception
	 */
	public boolean isGroupExists(String userId,String isPublic) throws Exception {

		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接sql语句
			StringBuffer sql = new StringBuffer("select count(group_id) cnt "
					+ " from OA_PERSONWORK_GROUP where group_id is not null " );
			if(!"1".equals(isPublic)){
				sql.append(" and  user_id ='"+userId+"' ");	
			}
			sql.append(" and is_public_group = '"+isPublic+"'");		
			// 数据库操作工具类
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.preparedSelect(sql.toString());
			//pdb.setString(1, userId);
			pdb.executePrepared(conn);

			// 存在记录条数
			String count = "0";
			if ((pdb != null) && (pdb.size() > 0)) {
				count = pdb.getString(0, 0);
			}
			// 存在记录返回true，不存在返回false
			if (Integer.parseInt(count) > 0) {
				return true;
			}
			return false;

		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	*<b>Summary:查询顶级机构id </b>
	* queryRootOrg(请用一句话描述这个方法的作用)
	* @return
	* @throws SQLException
	 */
	public String queryRootOrg() throws SQLException {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接sql语句
			String sql = "select org_id from td_sm_organization where parent_id='0'";
			// 数据库操作工具类
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.executeSelect(sql.toString(),conn);

			//机构id
			String count = "";
			if ((pdb != null) && (pdb.size() > 0)) {
				count = pdb.getString(0, 0);
			}			
			return count;

		} finally {
			DbManager.closeConnection(conn);
		}

	}
	
	
	/**
	*<b>Summary: </b>
	* getPersonInfoBeanList(得到外部人员联系信息)
	* @param person_ids
	* @param conn
	* @return
	* @throws Exception 
	*/
	public List<Map<String, String>> getPersonInfoBeanList(String person_ids,
			Connection conn) throws Exception {
		List<Map<String, String>> personInfoBeanListMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.person_id, t.name, d.field_value tel");
		sql.append("  from oa_personwork_personinfo t, oa_personwork_extrainfo d");
		sql.append(" where t.person_id = d.person_id");
		sql.append("   and d.field_name = '办公手机'");
		sql.append("   and t.person_id in ("+person_ids+")");
		personInfoBeanListMap = queryToListMap(sql.toString());
        return  personInfoBeanListMap;
	}


	@Override
	public void savePersonExtraInfo(PersonExtraInfoBean bean, Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		PreparedDBUtil pdb1 = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		sql1.append("delete from oa_personwork_extrainfo t where t.person_id = ? and t.type = ? and t.showindex = ?");

		sql.append("insert into oa_personwork_extrainfo");
		sql.append("  (extra_id, person_id, field_name, field_value, type, showindex)");
		sql.append("values");
		sql.append("  (?, ?, ?, ?, ?, ?)");

		pdb.preparedDelete(sql1.toString());
		pdb.setString(1, bean.getPerson_id());
		pdb.setString(2, bean.getType());
		pdb.setString(3, bean.getShowindex());
		pdb.executePrepared(con);

		pdb1.preparedInsert(sql.toString());
		pdb1.setString(1, StringUtil.getUUID());
		pdb1.setString(2, bean.getPerson_id());
		pdb1.setString(3, StringUtil.deNull(bean.getField_name()));
		pdb1.setString(4, StringUtil.deNull(bean.getField_value()));
		pdb1.setString(5, bean.getType());
		pdb1.setString(6, StringUtil.deNull(bean.getShowindex()));
		pdb1.executePrepared(con);
	}
}
