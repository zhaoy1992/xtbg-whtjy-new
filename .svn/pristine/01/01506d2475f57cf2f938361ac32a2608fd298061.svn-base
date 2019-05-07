
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     PersonHolderDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-21   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.personholder.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.core.util.TimeUtil;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.SqlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao;
import com.chinacreator.xtbg.core.personholder.entity.PersonHolder;
import com.chinacreator.xtbg.core.personholder.entity.TrainBean;
import com.chinacreator.xtbg.core.personholder.util.PersonHolderConstants;
import com.chinacreator.xtbg.core.personholder.util.PersonHolderUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:PersonHolderDaoImpl.java</p>
 *<p>Description:人员持证管理dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-21
 */
public class PersonHolderDaoImpl extends XtDbBaseDao implements PersonHolderDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selPersonList
	  * @param directorybean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao#selPersonList(com.chinacreator.xtbg.core.directory.entity.DirectoryBean, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selPersonList(DirectoryBean directorybean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		AccessControl accesscontroler = AccessControl.getAccessControl();
		String userid = accesscontroler.getUserID();	
		Connection conn = DbManager.getInstance().getConnection();
		try {

			PagingBean pb = new PagingBean();
			PreparedDBUtil db = new PreparedDBUtil();
			List<DirectoryBean> list = new ArrayList<DirectoryBean>();
			StringBuffer sql = new StringBuffer();

			sql.append("select o.org_id,o.org_name, u.user_id, u.user_name, u.user_realname,u.user_mobiletel1,u.user_sn,");
			sql.append("(select wm_concat(t.hold_name) from ta_oa_personholder t where t.hold_usesnid=u.user_id) as hold_name,");
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
			sql.append("   left join oa_userandsn usn on u.user_id = usn.userid");
			sql.append(" where (u.user_name is not null)");
			//sql.append("   and u.user_isvalid != '3'");
			//特检院 OA 【人员配置管理】 人员持证查看  start
			//是否部门管理员
			boolean isManager = accesscontroler.isOrganizationManager(directorybean.getOrgid());
			//人员持证管理员角色
			boolean isROLE = PersonHolderUtil.isRolesUser(userid, PersonHolderConstants.ROLE_NAME);
			if(isManager==true||"1".equals(userid)||isROLE==true){
			} else {
				sql.append(" and instr((select t.ids  ");
				sql.append("	from ta_oa_resources_config t ");
				sql.append("	 where t.resources_id = '18' ");
				sql.append("	       and t.resources_configtype = '2' ");
				sql.append("	       and t.resources_configtypeid = '"+userid+"'),u.user_id,1,1)>0");
			}
			//特检院 OA 【人员配置管理】  人员持证查看  end
			
			if (!StringUtil.nullOrBlank(directorybean.getLikevalue())) {
				sql.append(" and (user_realname like ?  or");
				sql.append("      o.org_name like ? or ");

				sql.append(" user_mobiletel1 like ?  or user_email like ? or user_worktel like ? or user_hometel like ?) ");
			}

			if (!StringUtil.nullOrBlank(directorybean.getNameindex())) {
				sql.append(" and user_name like ? ");
			}
			// 是否是党政一把手
			if (!StringUtil.nullOrBlank(directorybean.getDepartment())) {
				if ("是".equals(directorybean.getDepartment().trim())) {
					sql.append(" and numberone = '"
							+ directorybean.getDepartment().trim() + "'");
				} else {
					sql.append(" and (numberone = '"
							+ directorybean.getDepartment().trim()
							+ "' or numberone is null) ");
				}
			}
			// 级别
			String array[] = directorybean.getDirectorylevel().split(",");
			if (!StringUtil.nullOrBlank(directorybean.getDirectorylevel())) {

				sql.append(" and ( usn.directorylevel like ?");
				for (int i = 0; i < array.length - 1; i++) {
					sql.append(" or usn.directorylevel like ?  ");
				}
				sql.append(" ) ");
			}
			// 政治面貌
			String parray[] = directorybean.getPolitics().split(",");
			if (!StringUtil.nullOrBlank(directorybean.getPolitics())) {
				sql.append(" and ( usn.politics = ?");
				for (int i = 0; i < parray.length - 1; i++) {
					sql.append(" or usn.politics  =?  ");
				}
				sql.append(" ) ");

			}
			// 所在单位
			if (!StringUtil.nullOrBlank(directorybean.getOrgids())) {
				String orgids = StringUtil.splitString(directorybean.getOrgids(), ",", "'");
				sql.append(" and o.org_id  in("+orgids+")");
			}
			//人员类别
			if (!StringUtil.nullOrBlank(directorybean.getNew_user_type())) {
				sql.append(" and usn.new_user_type  = '"+directorybean.getNew_user_type()+"' ");
			}
			//在岗状态
			if (!StringUtil.nullOrBlank(directorybean.getNew_job_state())) {
				sql.append(" and usn.new_job_state  ='"+directorybean.getNew_job_state()+"' ");
			}
			//持证项目
			if (!StringUtil.nullOrBlank(directorybean.getPersionHold_name())) {
				sql.append(" and (select wm_concat(t.hold_name) ");
				sql.append("   from ta_oa_personholder t        ");
				sql.append("   where t.hold_usesnid = u.user_id)  like '%"+directorybean.getPersionHold_name()+"%' ");
			}
			//姓名
			if (!StringUtil.nullOrBlank(directorybean.getDirectoryname())) {
				sql.append(" and  u.user_realname like '%"+directorybean.getDirectoryname()+"%' ");
			}
			//初次取证日期
			if(!StringUtil.nullOrBlank(directorybean.getHold_ratify_starttime())&& StringUtil.nullOrBlank(directorybean.getHold_ratify_endtime())){
				sql.append(" and u.user_id in(select holder.hold_usesnid from ta_oa_personholder holder where 1=1 ");
				
				sql.append(" and holder.hold_ratifytime > to_date('").append(directorybean.getHold_ratify_starttime()).append("','yyyy-MM-dd') )");
			}
			if(StringUtil.nullOrBlank(directorybean.getHold_ratify_starttime())&&!StringUtil.nullOrBlank(directorybean.getHold_ratify_endtime())){
				sql.append(" and u.user_id in(select holder.hold_usesnid from ta_oa_personholder holder where 1=1 ");
				
				sql.append(" and holder.hold_ratifytime < to_date('").append(directorybean.getHold_ratify_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss') )");
			}
			if(!StringUtil.nullOrBlank(directorybean.getHold_ratify_starttime())&&!StringUtil.nullOrBlank(directorybean.getHold_ratify_endtime())){
				sql.append(" and u.user_id in (select holder.hold_usesnid from ta_oa_personholder holder where 1=1 ");
				sql.append(" and holder.hold_ratifytime > to_date('").append(directorybean.getHold_ratify_starttime()).append("','yyyy-MM-dd')");
				sql.append(" and holder.hold_ratifytime < to_date('").append(directorybean.getHold_ratify_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss') )");
			}
			sql.append(" order by to_number(o.index_sn),a.same_job_user_sn,  u.user_sn ");
			if (maxPagesize == -1) {
				db.preparedSelect(sql.toString());
			} else {
				db.preparedSelect(sql.toString(), offset, maxPagesize);
			}

			int j = 1;
			db.setString(j++, directorybean.getOrgid());
			if (!StringUtil.nullOrBlank(directorybean.getLikevalue())) {
				db.setString(j++, "%" + directorybean.getLikevalue() + "%");
				db.setString(j++, "%" + directorybean.getLikevalue() + "%");

				db.setString(j++, "%" + directorybean.getLikevalue() + "%");
				db.setString(j++, "%" + directorybean.getLikevalue() + "%");
				db.setString(j++, "%" + directorybean.getLikevalue() + "%");
				db.setString(j++, "%" + directorybean.getLikevalue() + "%");
			}
			// 是否是党政一把手
			if (!StringUtil.nullOrBlank(directorybean.getDepartment())) {
				sql.append(" and numberone = '" + directorybean.getDepartment()
						+ "' ");
			}
			// 级别
			if (!StringUtil.nullOrBlank(directorybean.getDirectorylevel())) {
				for (int i = 0; i < array.length; i++) {
					db.setString(j++, "%" + array[i] + "%");
				}
			}
			// 政治面貌
			if (!StringUtil.nullOrBlank(directorybean.getPolitics())) {
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
			if (!StringUtil.nullOrBlank(directorybean.getOrgname())) {
				db.setString(j++, "%" + directorybean.getOrgname() + "%");
			}
			if (!StringUtil.nullOrBlank(directorybean.getNameindex())) {
				db.setString(j++, directorybean.getNameindex().toLowerCase() + "%");
			}
			db.executePrepared(conn);

			for (int i = 0; i < db.size(); i++) {
				DirectoryBean ab = new DirectoryBean();
				ab.setDirectoryid(db.getString(i, "user_id"));
				ab.setDirectoryname(db.getString(i, "user_realname"));
				ab.setNew_user_type(db.getString(i, "new_user_type"));//人员类别
				ab.setNew_job_state(db.getString(i, "new_job_state"));//人员在岗状态
				ab.setNew_job_no(db.getString(i, "new_job_no"));//职工工号
				ab.setPersionHold_name(db.getString(i, "hold_name"));//职工工号
				ab.setNew_jszc(db.getString(i, "new_jszc"));//职称
				ab.setOrgid(db.getString(i, "org_id"));//部门ID
				ab.setOrgname(db.getString(i, "org_name"));//部门名称
				

				/**
				 * 由于新系统没有配置功能，故屏蔽
				 * 
				 * @alter date 2013-6-9
				 */
				// 判断当前用户是否有对当前名录数据的查看权限，没权限就只能看姓名和职务两个字段，并且页面不展示详细记录
				if ("add".equals(directorybean.getListtype())) {

					ab.setDirectoryyear(DateUtil.getTimeString(db.getTimestamp(
							i, "directoryyear")));
					ab.setDirectorysex(db.getString(i, "directorysex"));
					ab.setPost(db.getString(i, "duties"));
					ab.setDirectorystate(db.getString(i, "directorystate"));
					ab.setEducation(getEducationNameByValue(db.getString(i,
							"education")));
					ab
							.setDegree(getDegreeNameByValue(db.getString(i,
									"degree")));
					ab.setSeniority(db.getString(i, "seniority"));

					ab.setSchool(db.getString(i, "school"));
					ab.setNation(db.getString(i, "nation"));
					ab.setPolitics(getPoliticsNameByValue(db.getString(i,
							"politics")));
					ab.setNatives(db.getString(i, "natives"));

					ab.setSpecialty(db.getString(i, "specialty"));
					ab.setMobile2(db.getString(i, "user_mobiletel1"));
					ab.setHomeadress(db.getString(i, "homeadress"));
					ab.setWorkphone(db.getString(i, "user_worktel"));

					ab.setWorkadress(db.getString(i, "workadress"));
					ab.setHomephone(db.getString(i, "homephone"));
					ab.setEmail(db.getString(i, "email"));
					ab.setDuty(db.getString(i, "duty"));

					ab.setResume(db.getString(i, "resume"));
					ab.setOrgid(db.getString(i, "org_id"));
					ab.setOrgname(db.getString(i, "org_name"));
					ab.setDuties(db.getString(i, "duties"));

					ab.setNumberone(StringUtil.nullOrBlank(db.getString(i,
							"numberone")) ? "否" : db.getString(i, "numberone"));
					ab.setDirectorylevel(db.getString(i, "directorylevel"));
					ab.setIshasviewrole("true");
					// }
				} else {
					String userDeptId = DaoUtil
							.sqlToField("select t.org_id from td_sm_orguser t  where t.user_id='"
									+ directorybean.getUserid() + "' ");
					if ("1".equals(directorybean.getUserid())) {// 系统管理员
						ab.setDirectoryyear(DateUtil.getTimeString(db
								.getTimestamp(i, "directoryyear")));
						ab.setDirectorysex(db.getString(i, "directorysex"));

						ab.setDirectorystate(db.getString(i, "directorystate"));
						ab.setEducation(getEducationNameByValue(db.getString(i,
								"education")));
						ab.setDegree(getDegreeNameByValue(db.getString(i,
								"degree")));
						ab.setSeniority(db.getString(i, "seniority"));

						ab.setSchool(db.getString(i, "school"));
						ab.setNation(db.getString(i, "nation"));
						ab.setPolitics(getPoliticsNameByValue(db.getString(i,
								"politics")));
						ab.setNatives(db.getString(i, "natives"));

						ab.setSpecialty(db.getString(i, "specialty"));
						ab.setMobile2(db.getString(i, "user_mobiletel1"));
						ab.setHomeadress(db.getString(i, "homeadress"));
						ab.setWorkphone(db.getString(i, "user_worktel"));

						ab.setWorkadress(db.getString(i, "workadress"));
						ab.setHomephone(db.getString(i, "homephone"));
						ab.setEmail(db.getString(i, "email"));
						ab.setDuty(db.getString(i, "duty"));

						ab.setResume(db.getString(i, "resume"));
						ab.setOrgid(db.getString(i, "org_id"));
						ab.setOrgname(db.getString(i, "org_name"));
						ab.setDuties(db.getString(i, "duties"));

						ab.setNumberone(StringUtil.nullOrBlank(db.getString(i,
								"numberone")) ? "否" : db.getString(i,
								"numberone"));
						ab.setDirectorylevel(db.getString(i, "directorylevel"));
						ab.setIshasviewrole("true");
					} else if (userDeptId.equals(directorybean.getOrgid())) { // 默认显示本单位权限
						ab.setDirectoryyear(DateUtil.getTimeString(db
								.getTimestamp(i, "directoryyear")));
						ab.setDirectorysex(db.getString(i, "directorysex"));

						ab.setDirectorystate(db.getString(i, "directorystate"));
						ab.setEducation(getEducationNameByValue(db.getString(i,
								"education")));
						ab.setDegree(getDegreeNameByValue(db.getString(i,
								"degree")));
						ab.setSeniority(db.getString(i, "seniority"));

						ab.setSchool(db.getString(i, "school"));
						ab.setNation(db.getString(i, "nation"));
						ab.setPolitics(getPoliticsNameByValue(db.getString(i,
								"politics")));
						ab.setNatives(db.getString(i, "natives"));

						ab.setSpecialty(db.getString(i, "specialty"));
						ab.setMobile2(db.getString(i, "user_mobiletel1"));
						ab.setHomeadress(db.getString(i, "homeadress"));
						ab.setWorkphone(db.getString(i, "user_worktel"));

						ab.setWorkadress(db.getString(i, "workadress"));
						ab.setHomephone(db.getString(i, "homephone"));
						ab.setEmail(db.getString(i, "email"));
						ab.setDuty(db.getString(i, "duty"));

						ab.setResume(db.getString(i, "resume"));
						ab.setOrgid(db.getString(i, "org_id"));
						ab.setOrgname(db.getString(i, "org_name"));
						ab.setDuties(db.getString(i, "duties"));

						ab.setNumberone(StringUtil.nullOrBlank(db.getString(i,
								"numberone")) ? "否" : db.getString(i,
								"numberone"));
						ab.setDirectorylevel(db.getString(i, "directorylevel"));
						ab.setIshasviewrole("true");
					}
				}
				list.add(ab);
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
	 *<b>Summary: 根据value值获得对应的学历名称</b> getEducationNameByValue(请用一句话描述这个方法的作用)
	 * @param value
	 * @return
	 */
	public String getEducationNameByValue(String value) {
		String[][] names = { { "phd", "研究生" }, { "graduate", "硕士研究生" },
				{ "undergraduate", "本科" }, { "specialist", "专科" },
				{ "highschool", "高中" }, { "secondary", "中专" },
				{ "juniorhighschool", "初中" }, { "primaryschool", "小学" },
				{ "other", "其他" } };
		String resultName = "";
		for (int i = 0; i < names.length; i++) {
			if (names[i][0].equals(value)) {
				resultName = names[i][1];
			}
		}
		return resultName;
	}

	/**
	 * 
	 *<b>Summary: 根据value值获得对应的政治面貌名称</b>
	 * getPoliticsNameByValue(请用一句话描述这个方法的作用)
	 * 
	 * @param value
	 * @return
	 */
	public String getPoliticsNameByValue(String value) {
		String[][] names = { { "1", "中共党员" }, { "2", "中共预备党员" },
				{ "3", "共青团员" }, { "4", "民革党员" }, { "5", "民盟盟员" },
				{ "6", "民建会员" }, { "7", "民进会员" }, { "8", "农工党党员" },
				{ "9", "致公党党员" }, { "10", "九三学社社员" }, { "11", "台盟盟员" },
				{ "12", "无党派民主人士" }, { "13", "群众" } };
		String resultName = "";
		for (int i = 0; i < names.length; i++) {
			if (names[i][0].equals(value)) {
				resultName = names[i][1];
			}
		}
		return resultName;
	}
	/**
	 * 
	 *<b>Summary: 根据value值获得对应的政治面貌名称</b> getDegreeNameByValue(请用一句话描述这个方法的作用)
	 * 
	 * @param value
	 * @return
	 */
	public String getDegreeNameByValue(String value) {
		String[][] names = { { "xueshi", "学士" }, { "shoushi", "硕士" },
				{ "boshi", "博士" } };
		String resultName = "";
		for (int i = 0; i < names.length; i++) {
			if (names[i][0].equals(value)) {
				resultName = names[i][1];
			}
		}
		return resultName;
	}
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findPersonHolderList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao#findPersonHolderList(com.chinacreator.xtbg.core.personholder.entity.PersonHolder, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean findPersonHolderList(String parmjson,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		PersonHolder personholder= new PersonHolder();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				personholder = (PersonHolder) JSONObject.parseObject(parmjson, PersonHolder.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select hold_id,");
			sql.append("       hold_name,");
			sql.append("       hold_org,");
			sql.append("       hold_number,");
			sql.append("       to_char(hold_ratifytime,'yyyy-mm-dd') as hold_ratifytime,");
			sql.append("       to_char(hold_validtime,'yyyy-mm-dd') as hold_validtime,");
			sql.append("       to_char(hold_replactime,'yyyy-mm-dd') as hold_replactime,");
			sql.append("       hold_level,");
			sql.append("	   attachment_id as attachment_id,");
			sql.append(" 	   a.djsn as djsn,");
			sql.append("	   a.filepos as filepos,");
			sql.append("       decode(hold_state,'ybb','院本部','ycz','已持证','yjc','已借出','dfz','待发证','ydx','已吊销','hzz','换证中','bgz','变更中','ycq','已超期',hold_state) as hold_state,");
			sql.append("       decode(register_flag,'1','是','0','否') as register_flag,");
			sql.append("       creator_time,");
			sql.append("       hold_remark,");
			sql.append("       hold_usesnid,");
			sql.append("       a.filename as filename");
			sql.append("  from ta_oa_personholder left join fc_attach a on attachment_id = rtrim(a.djbh)");
			sql.append("  where 1=1");
			if(personholder!=null){
				if (!StringUtil.nullOrBlank(personholder.getHold_usesnid())) {
					sql.append(" and hold_usesnid = ? ");
					condition.add(personholder.getHold_usesnid());
				}
			}
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	
	 @Override
	public PagingBean findPersonHolderYujingList(String parmjson,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		 	Connection conn = null;
			PersonHolder personholder= new PersonHolder();
			PagingBean pb = new PagingBean();
			List<String> condition = new ArrayList<String>();
			try {
				if (!StringUtil.isBlank(parmjson)) {
					personholder = (PersonHolder) JSONObject.parseObject(parmjson, PersonHolder.class);
				}
				conn = DbManager.getInstance().getConnection();
				
				StringBuffer sql = new StringBuffer();
				sql.append("select p.hold_id,");
				sql.append("       u.user_realname hold_userrealname,");
				sql.append("       p.hold_name,");
				sql.append("       p.hold_org,");
				sql.append("       p.hold_number,");
				sql.append("       to_char(p.hold_ratifytime,'yyyy-mm-dd') as hold_ratifytime,");
				sql.append("       to_char(p.hold_validtime,'yyyy-mm-dd') as hold_validtime,");
				sql.append("       to_char(p.hold_replactime,'yyyy-mm-dd') as hold_replactime,");
				sql.append("       p.hold_level,");
				sql.append("       decode(hold_state,'ybb','院本部','ycz','已持证','yjc','已借出','dfz','待发证','ydx','已吊销','hzz','换证中','bgz','变更中','ycq','已超期','') as hold_state,");
				sql.append("       decode(p.register_flag,'1','是','0','否') as register_flag,");
				sql.append("       p.creator_time,");
				sql.append("       p.hold_usesnid as hold_usesnid ");
				sql.append("  from ta_oa_personholder p ");
				sql.append("  inner join td_sm_user u on u.user_id = p.hold_usesnid ");
				//机构
				sql.append("  inner join td_sm_orguser orguser on u.user_id = orguser.user_id ");
				sql.append("  inner join td_sm_organization org on org.org_id = orguser.org_id ");
				sql.append("  where 1=1 ");
				//同一个人的同一种持证项目，只预警有效日期为最新的一项。为了记录换证的历史记录，持证项目中有已换证的历史记录，那么是不应当被持证预警判定为过期证件的。
				sql.append(" and p.hold_name || ',' || p.hold_validtime || ',' || p.hold_usesnid in");
				sql.append("       (select holers.hold_name || ',' || max(holers.hold_validtime) || ',' ||");
				sql.append("               holers.hold_usesnid as hold_usesnid");
				sql.append("          from ta_oa_personholder holers");
				sql.append("         inner join td_sm_user u on u.user_id = holers.hold_usesnid");
				sql.append("         group by holers.hold_usesnid, holers.hold_name) ");
				if(personholder!=null){
					//默认为当前日期到一年以后为条件按照【有效日期】查询人员持证信息
					//有效日期开始时间
					if (!StringUtil.nullOrBlank(personholder.getValidStart_time())) {
						sql.append(" and p.hold_validtime >= ").append(" to_date('").append(personholder.getValidStart_time()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
					}
					//有效日期结束时间
					if (!StringUtil.nullOrBlank(personholder.getValidEtart_time())) { 
						sql.append(" and p.hold_validtime <= ").append(" to_date('").append(personholder.getValidEtart_time()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
					}
					if (!StringUtil.nullOrBlank(personholder.getHold_usesnid())) {
						sql.append(" and p.hold_usesnid = ? ");
						condition.add(personholder.getHold_usesnid());
					}
					//机构ID
					if (!StringUtil.nullOrBlank(personholder.getOrgIds())) { 
						String orgids = StringUtil.splitString(personholder.getOrgIds(), ",", "'");
						sql.append(" and org.org_id  in("+orgids+")");
					}
				}
				//排序
				sql.append(" order by " + sortName + " " + sortOrder);
				
				pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
				return pb;
			} finally {
				DbManager.closeConnection(conn);
			}
	}
	/** 
	  * <b>Summary: </b>
	  *     复写方法 getPersonHolder
	  * @param hold_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao#getPersonHolder(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getPersonHolder(String hold_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select hold_id,");
		sql.append("       hold_name,");
		sql.append("       hold_org,");
		sql.append("       attachment_id,");
		sql.append("       hold_number,");
		sql.append("       to_char(hold_ratifytime,'yyyy-mm-dd') as hold_ratifytime,");
		sql.append("       to_char(hold_validtime,'yyyy-mm-dd') as hold_validtime,");
		sql.append("       to_char(hold_replactime,'yyyy-mm-dd') as hold_replactime,");
		sql.append("       hold_level,");
		sql.append("       hold_state,");
		sql.append("       register_flag,");
		sql.append("       creator_time,");
		sql.append("       hold_usesnid,");
		sql.append("       hold_remark");
		sql.append("  from ta_oa_personholder");
		sql.append(" where hold_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), hold_id);
		return viewMap;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deletePersonHolderById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao#deletePersonHolderById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deletePersonHolderById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_personholder ");
		sql.append(" where hold_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findTrainList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao#findTrainList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean findTrainList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		TrainBean trainbean= new TrainBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				trainbean = (TrainBean) JSONObject.parseObject(parmjson, TrainBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select tr_id,");
			sql.append("       decode(tr_level,'1','专业技术','0','非专业','2','其它项目') as tr_level,");
			sql.append("       tr_title,");
			sql.append("       tr_content,");
			sql.append("       to_char(tr_time,'yyyy-mm-dd') as tr_time,");
			sql.append("       tr_hour,");
			sql.append("       tr_address,");
			sql.append("       tr_money,");
			sql.append("       tr_usersn,");
			sql.append("       tr_name,");
			sql.append("       tr_unit ");
			sql.append("  from ta_oa_train");
			sql.append("  where 1=1");
			if(trainbean!=null){
				if (!StringUtil.nullOrBlank(trainbean.getTr_usersn())) {
					sql.append(" and tr_usersn = ? ");
					condition.add(trainbean.getTr_usersn());
				}
			}
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getTrainBean
	  * @param tr_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao#getTrainBean(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getTrainBean(String tr_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from ta_oa_train ");
		sql.append(" where tr_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), tr_id);
		return viewMap;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteTrainBeanById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao#deleteTrainBeanById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteTrainBeanById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_train ");
		sql.append(" where tr_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	
	
	/**
	*<b>Summary: </b>
	* selPersonHolderData(根据用户id查询该人员所有的持证信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> selPersonHolderData(String user_Id) throws Exception{
		
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();;
		StringBuffer sql = new StringBuffer();
		List<String> condition = new ArrayList<String>();
		sql.append("select hold_id,");
		sql.append("       hold_name,");
		sql.append("       hold_org,");
		sql.append("       hold_number,");
		sql.append("       to_char(hold_ratifytime,'yyyy-mm-dd') as hold_ratifytime,");
		sql.append("       to_char(hold_validtime,'yyyy-mm-dd') as hold_validtime,");
		sql.append("       to_char(hold_replactime,'yyyy-mm-dd') as hold_replactime,");
		sql.append("       hold_level,");
		sql.append("       decode(hold_state,'ybb','院本部','ycz','已持证','yjc','已借出','dfz','待发证','ydx','已吊销','hzz','换证中','bgz','变更中','ycq','已超期',hold_state) as hold_state,");
		sql.append("       register_flag,");
		sql.append("       creator_time,");
		sql.append("       hold_usesnid,");
		sql.append("       hold_remark");
		sql.append("  from ta_oa_personholder ");
		if(!StringUtil.isBlank(user_Id)){
			sql.append("        where hold_usesnid = ?  ");
			condition.add(user_Id);
		}
		
		sql.append("  order by hold_name desc ,hold_validtime asc ");
		viewMap = queryToListMap(sql.toString(), condition);
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* selPersonTrainData(根据用户id查询该人员所有的持证培训记录信息)
	* @param conn
	* @param trainbean
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> selPersonTrainData(TrainBean trainbean) throws Exception{
		
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();;
		List<String> condition = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from ta_oa_train ");
		sql.append(" where   1=1 ");
		if(trainbean!=null){
			if(!StringUtil.isBlank(trainbean.getTr_usersn())){
				sql.append(" and tr_usersn = ? ");
				condition.add(trainbean.getTr_usersn());
			}
			if(!StringUtil.isBlank(trainbean.getTr_level())){
				sql.append(" and tr_level = ? ");
				condition.add(trainbean.getTr_level());
			}
			
		}
		sql.append(" order by tr_time desc ");
		viewMap = queryToListMap(sql.toString(), condition);
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* selPersonHolderYjToData(查询人员持证预警信息    用户导出人员预警信息)
	* @param personholder
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> selPersonHolderYjToData(PersonHolder personholder) throws Exception{
		Connection conn = null;
		List<String> condition = new ArrayList<String>();
		List<Map<String,String>> result = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select o.org_name department,");
			sql.append("       new_job_no,");
			sql.append("       duties,");
			sql.append("       new_jszc,");
			sql.append("       new_zc_getdate,");
			sql.append("       p.hold_id,");
			sql.append("       m.user_realname hold_userrealname,");
			sql.append("       p.hold_name,");
			sql.append("       p.hold_org,");
			sql.append("       p.hold_number,");
			sql.append("       to_char(p.hold_ratifytime, 'yyyy-mm-dd') as hold_ratifytime,");
			sql.append("       to_char(p.hold_validtime, 'yyyy-mm-dd') as hold_validtime,");
			sql.append("       to_char(p.hold_replactime, 'yyyy-mm-dd') as hold_replactime,");
			sql.append("       p.hold_level,");
			sql.append("       hold_state as hold_state,");
			sql.append("       p.register_flag as register_flag,");
			sql.append("       p.creator_time,");
			sql.append("       p.hold_usesnid as hold_usesnid");
			sql.append("  from ta_oa_personholder p");
			sql.append(" inner join td_sm_user m on m.user_id = p.hold_usesnid");
			sql.append(" inner join oa_userandsn u on m.user_id = u.userid");
			sql.append(" inner join td_sm_orguser ou on m.user_id = ou.user_id");
			sql.append(" inner join td_sm_organization o on ou.org_id = o.org_id ");
			sql.append("  where 1=1 ");
			if(personholder!=null){
				//默认为当前日期到一年以后为条件按照【有效日期】查询人员持证信息
				//有效日期开始时间
				if (!StringUtil.nullOrBlank(personholder.getValidStart_time())) {
					sql.append(" and p.hold_validtime >= ").append(" to_date('").append(personholder.getValidStart_time()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
				}
				//有效日期结束时间
				if (!StringUtil.nullOrBlank(personholder.getValidEtart_time())) { 
					sql.append(" and p.hold_validtime <= ").append(" to_date('").append(personholder.getValidEtart_time()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
				}
				if (!StringUtil.nullOrBlank(personholder.getHold_usesnid())) {
					sql.append(" and p.hold_usesnid = ? ");
					condition.add(personholder.getHold_usesnid());
				}
				//机构ID
				if (!StringUtil.nullOrBlank(personholder.getOrgIds())) { 
					String orgids = StringUtil.splitString(personholder.getOrgIds(), ",", "'");
					sql.append(" and o.org_id  in("+orgids+")");
				}
			}
			//排序
			sql.append(" order by hold_usesnid desc, hold_ratifytime desc");
			
			result = queryToListMap(sql.toString(),condition);
			return result;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	@Override
	public List<Map<String, String>> getMsgCount(String userid)
			throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();;
		List<String> condition = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		String nowtime = DateUtil.getCurrentDate();
		sql.append("select ");
		sql.append(" count(*) as amount, ");
		sql.append(" 'ccapp/oa/personholder/jsp/holderyujing.jsp' as clickurl ");
		sql.append(" from ta_oa_personholder t ");
		sql.append(" where (t.hold_validtime-to_date('"+nowtime+"','yyyy-MM-dd'))<16");
			if(!StringUtil.isBlank(userid)){
				sql.append(" and t.hold_usesnid = ? ");
				condition.add(userid);
			}
		viewMap = queryToListMap(sql.toString(), condition);
		return viewMap;
	}
	@Override
	public Integer getCountById(String hold_usesnid,String hold_name) throws Exception {
		Integer count = 0;
		PreparedDBUtil pdb = new PreparedDBUtil();
		String sql = "select count(p.hold_name) coun from ta_oa_personholder p where p.hold_usesnid = ? and trim(p.hold_name) = ?";
		pdb.preparedSelect(sql);
		pdb.setString(1, hold_usesnid);
		pdb.setString(2, hold_name);
		pdb.executePrepared();
		count = pdb.getInt(0, "coun");
		return count;
	}
	@Override
	public void insertHolder(PersonHolder bean, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_personholder (");
		sql.append(" hold_id, hold_name, hold_org, hold_number, hold_ratifytime, hold_validtime, hold_replactime, hold_level,");
		sql.append(" hold_state, register_flag, creator_time, hold_usesnid, hold_remark, attachment_id, unit_name)");
		sql.append(" values");
		sql.append("  (?,?,?,?,to_date(?,'yyyy-MM-dd'),to_date(?,'yyyy-MM-dd'),to_date(?,'yyyy-MM-dd'),?,?,?,to_date(?,'yyyy-MM-dd HH24:mi:ss'),?,?,?,?)");
		SqlUtil<PersonHolder> sqlUtil = new SqlUtil<PersonHolder>();
        sqlUtil.executeInsert(sql.toString(), bean, conn);
	}
	@Override
	public void updateHolder(PersonHolder bean, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update ta_oa_personholder p set");
		sql.append("  p.hold_org = ?,");
		sql.append("  p.hold_number = ?,");
		sql.append("  p.hold_ratifytime = to_date(?,'yyyy-MM-dd'),");
		sql.append("  p.hold_validtime = to_date(?,'yyyy-MM-dd'),");
		sql.append("  p.hold_replactime = to_date(?,'yyyy-MM-dd'),");
		sql.append("  p.hold_level = ?,");
		sql.append("  p.hold_state = ?,");
		sql.append("  p.register_flag = ?,");
		sql.append("  p.creator_time = to_date(?,'yyyy-MM-dd HH24:mi:ss'),");
		sql.append("  p.hold_remark = ?,");
		sql.append("  p.attachment_id = ?,");
		sql.append("  p.unit_name = ?");
		sql.append(" where p.hold_usesnid = ?");
		sql.append("  and p.hold_name = ?");
		SqlUtil<PersonHolder> sqlUtil = new SqlUtil<PersonHolder>();
		sqlUtil.executeUpdate(sql.toString(), bean, conn);
	}
	@Override
	public void updateHolder2(PersonHolder bean, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update ta_oa_personholder p set");
		sql.append("  p.hold_org = ?,");
		sql.append("  p.hold_number = ?,");
		sql.append("  p.hold_name = ?,");
		sql.append("  p.hold_ratifytime = to_date(?,'yyyy-MM-dd'),");
		sql.append("  p.hold_validtime = to_date(?,'yyyy-MM-dd'),");
		sql.append("  p.hold_replactime = to_date(?,'yyyy-MM-dd'),");
		sql.append("  p.hold_level = ?,");
		sql.append("  p.hold_state = ?,");
		sql.append("  p.register_flag = ?,");
		sql.append("  p.creator_time = to_date(?,'yyyy-MM-dd HH24:mi:ss'),");
		sql.append("  p.hold_remark = ?,");
		sql.append("  p.attachment_id = ?,");
		sql.append("  p.unit_name = ?");
		sql.append(" where p.hold_id = ?");
		SqlUtil<PersonHolder> sqlUtil = new SqlUtil<PersonHolder>();
		sqlUtil.executeUpdate(sql.toString(), bean, conn);
		
	}
}
