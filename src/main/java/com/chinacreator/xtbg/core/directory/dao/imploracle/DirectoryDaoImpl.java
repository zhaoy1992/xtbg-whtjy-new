package com.chinacreator.xtbg.core.directory.dao.imploracle;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.constant.DirectoryConstant;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.directory.entity.HeTongBean;
import com.chinacreator.xtbg.core.directory.entity.ListShowUtilBean;
import com.chinacreator.xtbg.core.directory.entity.UserinfoBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:DirectoryDaoImpl.java
 * </p>
 *<p>
 * Description:名录管理实例类
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-14
 */
public class DirectoryDaoImpl implements DirectoryDao {

	/** 
	 * 
	 * <b>Summary:名录管理列表 </b> 复写方法 findTypeList
	 * 
	 * @param typeBean
	 *            查询参数
	 * @param sortName
	 *            排序字段
	 * @param sortOrder
	 *            排序方式
	 * @param offset
	 *            从第几页开始
	 * @param maxPagesize
	 *            当前页数
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#findTypeList(com.chinacreator.xtbg.core.directory.entity.DirectoryBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findTypeList(DirectoryBean typeBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		
		AccessControl accesscontroler = AccessControl.getAccessControl();
		Connection conn = DbManager.getInstance().getConnection();
		String userid = accesscontroler.getUserID();	
		try {

			PagingBean pb = new PagingBean();
			PreparedDBUtil db = new PreparedDBUtil();
			List<DirectoryBean> list = new ArrayList<DirectoryBean>();
			StringBuffer sql = new StringBuffer();
			
			sql
					.append("select o.org_id,o.org_name, job.job_name,u.user_id, u.user_name,u.user_realname,u.user_mobiletel1,u.user_sn,");
			sql.append(" decode(u.USER_SEX,'M','男','F','女','未知')as directorysex,u.USER_BIRTHDAY as directoryyear, ");
			sql
					.append("u.user_mobiletel2,u.user_worktel,u.user_email,u.remark2,usn.*");
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
			sql.append(" left join td_sm_job job on a.job_id = job.job_id ");
			sql
					.append("   left join oa_hetong ht on u.user_id = ht.hetong_userands_id");
			sql.append(" where (u.user_name is not null)");
			//sql.append("   and u.user_isvalid != '3'");
			//特检院 OA 【人员配置管理】 人员信息查看  start
			//是否部门管理员
			boolean isManager = accesscontroler.isOrganizationManager(typeBean.getOrgid());
			if(!StringUtil.nullOrBlank(typeBean.getStrRoles()) && "adminUser".equals(typeBean.getStrRoles())){

			}else{
				if(isManager==true||"1".equals(userid)){
				} else {
					sql.append(" and instr((select t.ids || ',"+typeBean.getUserid()+"'  ");
					sql.append("	from ta_oa_resources_config t ");
					sql.append("	 where t.resources_id = '16' ");
					sql.append("	       and t.resources_configtype = '2' ");
					sql.append("	       and t.resources_configtypeid = '"+userid+"'),u.user_id,1,1)>0");
				}
			}
			//特检院 OA 【人员配置管理】  人员信息查看  end
			if (!StringUtil.nullOrBlank(typeBean.getLikevalue())) {
				sql.append(" and (user_realname like ?  or");
				sql.append("      o.org_name like ? or ");

				sql
						.append(" user_mobiletel1 like ?  or user_email like ? or user_worktel like ? or user_hometel like ?) ");
			}

			if (!StringUtil.nullOrBlank(typeBean.getNameindex())) {
				sql.append(" and user_name like ? ");
			}
			// 是否是党政一把手
			if (!StringUtil.nullOrBlank(typeBean.getDepartment())) {
				if ("是".equals(typeBean.getDepartment().trim())) {
					sql.append(" and numberone = '"
							+ typeBean.getDepartment().trim() + "'");
				} else {
					sql.append(" and (numberone = '"
							+ typeBean.getDepartment().trim()
							+ "' or numberone is null) ");
				}
			}
			// 级别
			String array[] = typeBean.getDirectorylevel().split(",");
			if (!StringUtil.nullOrBlank(typeBean.getDirectorylevel())) {

				sql.append(" and ( usn.directorylevel like ?");
				for (int i = 0; i < array.length - 1; i++) {
					sql.append(" or usn.directorylevel like ?  ");
				}
				// sql.append(" and usn.directorylevel   like ? ");
				sql.append(" ) ");
			}
			// 职务
			String arrayZW[] = typeBean.getDuties().split(",");
			for (int i = 0; i < arrayZW.length; i++) {
				if ("院长".equals(arrayZW[i])) {
					arrayZW[i] = "1";
				} else if ("党委书记".equals(arrayZW[i])) {
					arrayZW[i] = "2";
				} else if ("副院长".equals(arrayZW[i])) {
					arrayZW[i] = "3";
				} else if ("省院总工程师".equals(arrayZW[i])) {
					arrayZW[i] = "4";
				} else if ("纪检书记".equals(arrayZW[i])) {
					arrayZW[i] = "5";
				} else if ("分院院长".equals(arrayZW[i])) {
					arrayZW[i] = "6";
				} else if ("部长".equals(arrayZW[i])) {
					arrayZW[i] = "7";
				} else if ("省院副总工程师".equals(arrayZW[i])) {
					arrayZW[i] = "8";
				} else if ("副部长".equals(arrayZW[i])) {
					arrayZW[i] = "9";
				} else if ("分院副院长".equals(arrayZW[i])) {
					arrayZW[i] = "10";
				} else if ("分院总工".equals(arrayZW[i])) {
					arrayZW[i] = "11";
				}else if ("院长助理".equals(arrayZW[i])) {
					arrayZW[i] = "12";
				}else if ("主任".equals(arrayZW[i])) {
					arrayZW[i] = "13";
				}else if ("副主任".equals(arrayZW[i])) {
					arrayZW[i] = "14";
				}else if ("部长兼省院副总工程师".equals(arrayZW[i])) {
					arrayZW[i] = "15";
				}else if ("总经理".equals(arrayZW[i])) {
					arrayZW[i] = "16";
				}else if ("副总经理".equals(arrayZW[i])) {
					arrayZW[i] = "17";
				}else if ("工会主席".equals(arrayZW[i])) {
					arrayZW[i] = "18";
				}else if ("分院工会主席".equals(arrayZW[i])) {
					arrayZW[i] = "19";
				}else if ("其他".equals(arrayZW[i])) {
					arrayZW[i] = "20";
				}
			}
			if (!StringUtil.nullOrBlank(typeBean.getDuties())) {
				sql.append(" and ( usn.duties like ?");
				for (int i = 0; i < arrayZW.length - 1; i++) {
					sql.append(" or usn.duties like ?  ");
				}
				// sql.append(" and usn.directorylevel   like ? ");
				sql.append(" ) ");
			}
			// 政治面貌
			String parray[] = typeBean.getPolitics().split(",");
			if (!StringUtil.nullOrBlank(typeBean.getPolitics())) {
				sql.append(" and ( usn.politics = ?");
				for (int i = 0; i < parray.length - 1; i++) {
					sql.append(" or usn.politics  =?  ");
				}
				sql.append(" ) ");

			}
			// 所在单位
			if (!StringUtil.nullOrBlank(typeBean.getOrgids())) {
				String orgids = StringUtil.splitString(typeBean.getOrgids(), ",", "'");
				sql.append(" and o.org_id  in("+orgids+")");
			}
			// 岗位
			if(!StringUtil.nullOrBlank(typeBean.getJob_name())){
				sql.append(" and job.job_name = '"+typeBean.getJob_name()+"' ");
			}
			// 现合同终止期
			if (!StringUtil.nullOrBlank(typeBean.getHetong_nowsend_date1())) {
				sql.append(" and ht.hetong_nowsend_date  >= to_date(?,'yyyy-MM-dd') ");
			}
			// 现合同终止期
			if (!StringUtil.nullOrBlank(typeBean.getHetong_nowsend_date2())) {
				sql.append(" and ht.hetong_nowsend_date  <= to_date(?,'yyyy-MM-dd') ");
			}
			// 合同试用终止期
			if (!StringUtil.nullOrBlank(typeBean.getHetong_tryend_date1())) {
				sql.append(" and ht.hetong_tryend_date  >= to_date(?,'yyyy-MM-dd') ");
			}
			// 合同试用终止期
			if (!StringUtil.nullOrBlank(typeBean.getHetong_tryend_date2())) {
				sql.append(" and ht.hetong_tryend_date  <= to_date(?,'yyyy-MM-dd') ");
			}
			// 离职日期起始时间
			if (!StringUtil.nullOrBlank(typeBean.getLeavetime_date1())) {
				sql.append(" and usn.leavetime  >= to_date('"+typeBean.getLeavetime_date1()+"','yyyy-MM-dd') ");
			}
			// 离职日期结束时间
			if (!StringUtil.nullOrBlank(typeBean.getLeavetime_date2())) {
				sql.append(" and usn.leavetime  <= to_date('"+typeBean.getLeavetime_date2()+"','yyyy-MM-dd') ");
			}
			// 出生日期查询开始日期
			if (!StringUtil.nullOrBlank(typeBean.getDirectoryyear1())) {
				sql.append(" and u.USER_BIRTHDAY  >= to_date(?,'yyyy-MM-dd') ");
			}
			// 出生日期查询结束日期
			if (!StringUtil.nullOrBlank(typeBean.getDirectoryyear2())) {
				sql.append(" and u.USER_BIRTHDAY  <= to_date(?,'yyyy-MM-dd') ");
			}
			// 
			if (!StringUtil.nullOrBlank(typeBean.getNew_user_type())) {
				sql.append(" and instr(',"+typeBean.getNew_user_type()+",',','||decode(usn.new_user_type, 'bnzg', '编内职工', 'bwzg', '编外职工','txzg','退休职工','未知')||',')>0");
			}
			// 
			if (!StringUtil.nullOrBlank(typeBean.getDirectorysex())) {
				sql.append(" and u.USER_SEX='"+typeBean.getDirectorysex()+"'");
			}
			//
			if (!StringUtil.nullOrBlank(typeBean.getNew_zg_xl())) {
				// 学历
				String zew_zgxlParm[] = typeBean.getNew_zg_xl().split(",");
					if(zew_zgxlParm.length>0){
					for (int i = 0; i < zew_zgxlParm.length; i++) {
						if(i==0){
							sql.append(" and ( usn.new_zg_xl = '"+ DirectoryConstant.parseEducation(zew_zgxlParm[i],false)+"'");
						} else{
							sql.append(" or usn.new_zg_xl  = '"+ DirectoryConstant.parseEducation(zew_zgxlParm[i],false)+"'");
						}
						
					}
					sql.append(" ) ");
				}

			}
			if (!StringUtil.nullOrBlank(typeBean.getNew_zg_xw())) {
				//学位
				String zew_zgxwParm[] = typeBean.getNew_zg_xw().split(",");
				if(zew_zgxwParm.length>0){
					for (int i = 0; i < zew_zgxwParm.length; i++) {
						if(i==0){
							sql.append(" and ( usn.new_zg_xw = '"+ DirectoryConstant.parseDegree(zew_zgxwParm[i],false)+"'");
						} else{
							sql.append(" or usn.new_zg_xw  = '"+ DirectoryConstant.parseDegree(zew_zgxwParm[i],false)+"'");
						}
						
					}
					sql.append(" ) ");
				}
			}
			//技术职称
			if (!StringUtil.nullOrBlank(typeBean.getNew_jszc())) {
				String zew_jszcParm[] = typeBean.getNew_jszc().split(",");
				if(zew_jszcParm.length>0){
					for (int i = 0; i < zew_jszcParm.length; i++) {
						if(i==0){
							sql.append(" and ( usn.new_jszc = '"+ DirectoryConstant.parseNewjszc(zew_jszcParm[i],false)+"'");
						} else{
							sql.append(" or usn.new_jszc  = '"+ DirectoryConstant.parseNewjszc(zew_jszcParm[i],false)+"'");
						}
						
					}
					sql.append(" ) ");
				}
			}
			if (!StringUtil.nullOrBlank(typeBean.getIntime1())) {
				sql.append(" and usn.new_in_hosb >= to_date('"+typeBean.getIntime1()+"','yyyy-MM-dd') ");
			}
			if (!StringUtil.nullOrBlank(typeBean.getIntime2())) {
				sql.append(" and usn.new_in_hosb <= to_date('"+typeBean.getIntime2()+"','yyyy-MM-dd') ");
			}
			sql.append(" order by to_number(o.index_sn),a.same_job_user_sn,  u.user_sn ");
			if (maxPagesize == -1) {
				db.preparedSelect(sql.toString());
			} else {
				db.preparedSelect(sql.toString(), offset, maxPagesize);
			}

			int j = 1;
			db.setString(j++, typeBean.getOrgid());
			if (!StringUtil.nullOrBlank(typeBean.getLikevalue())) {
				db.setString(j++, "%" + typeBean.getLikevalue() + "%");
				db.setString(j++, "%" + typeBean.getLikevalue() + "%");

				db.setString(j++, "%" + typeBean.getLikevalue() + "%");
				db.setString(j++, "%" + typeBean.getLikevalue() + "%");
				db.setString(j++, "%" + typeBean.getLikevalue() + "%");
				db.setString(j++, "%" + typeBean.getLikevalue() + "%");
			}
			// 是否是党政一把手
			if (!StringUtil.nullOrBlank(typeBean.getDepartment())) {
				sql.append(" and numberone = '" + typeBean.getDepartment()
						+ "' ");
			}
			// 级别
			if (!StringUtil.nullOrBlank(typeBean.getDirectorylevel())) {
				for (int i = 0; i < array.length; i++) {
					db.setString(j++, "%" + array[i] + "%");
				}
			}
			// 职务
			if (!StringUtil.nullOrBlank(typeBean.getDuties())) {
				for (int i = 0; i < arrayZW.length; i++) {
					db.setString(j++, "%" + arrayZW[i] + "%");
				}
			}
			// 政治面貌
			if (!StringUtil.nullOrBlank(typeBean.getPolitics())) {
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
			// 现合同终止期起始时间
			if (!StringUtil.nullOrBlank(typeBean.getHetong_nowsend_date1())) {
				db.setString(j++, typeBean.getHetong_nowsend_date1());
			}
			// 现合同终止期截止时间
			if (!StringUtil.nullOrBlank(typeBean.getHetong_nowsend_date2())) {
				db.setString(j++, typeBean.getHetong_nowsend_date2());
			}
			// 合同试用终止期起始时间
			if (!StringUtil.nullOrBlank(typeBean.getHetong_tryend_date1())) {
				db.setString(j++, typeBean.getHetong_tryend_date1());
			}
			// 合同试用终止期截止时间
			if (!StringUtil.nullOrBlank(typeBean.getHetong_tryend_date2())) {
				db.setString(j++, typeBean.getHetong_tryend_date2());
			}
			// 出生日期查询开始日期
			if (!StringUtil.nullOrBlank(typeBean.getDirectoryyear1())) {
				db.setString(j++, typeBean.getDirectoryyear1());
			}
			// 出生日期查询结束日期
			if (!StringUtil.nullOrBlank(typeBean.getDirectoryyear2())) {
				db.setString(j++, typeBean.getDirectoryyear2());
			}
			if (!StringUtil.nullOrBlank(typeBean.getNameindex())) {
				db.setString(j++, typeBean.getNameindex().toLowerCase() + "%");
			}
			db.executePrepared(conn);

			for (int i = 0; i < db.size(); i++) {
				DirectoryBean ab = new DirectoryBean();
				ab.setDirectoryid(db.getString(i, "user_id"));
				ab.setDirectoryname(db.getString(i, "user_realname"));
				//【人员信息管理】列表页取消【办公手机】、【办公电话】、【级别】、【一把手】列，用【出生年月】、【性别】、【人员类别】、【工号】四列替代。
				ab.setNew_user_type(DirectoryConstant.parsePersonType(db.getString(i, "new_user_type"),true));//人员类别
				ab.setNew_job_no(db.getString(i, "new_job_no"));//工号
				/**
				 * 由于新系统没有配置功能，故屏蔽
				 * 
				 * @alter date 2013-6-9
				 */
				// 判断当前用户是否有对当前名录数据的查看权限，没权限就只能看姓名和职务两个字段，并且页面不展示详细记录
				if ("add".equals(typeBean.getListtype())) {

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
									+ typeBean.getUserid() + "' ");
					if ("1".equals(typeBean.getUserid()) || (!StringUtil.nullOrBlank(typeBean.getStrRoles()) && "adminUser".equals(typeBean.getStrRoles()))) {// 系统管理员
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
					} else if (userDeptId.equals(typeBean.getOrgid())) { // 默认显示本单位权限
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
					}else{
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
	*<b>Summary: 根据用户id查询所能查看的人员id并重新拼接</b>
	* queryUserIds(请用一句话描述这个方法的作用)
	* @param userid
	* @return
	 */
	String queryUserIds(String userid) throws SQLException{
		Connection conn = DbManager.getInstance().getConnection();
		String ids = "";
		try {
			StringBuffer sql = new StringBuffer();
			sql.append("select to_char(trc.ids)ids from TA_OA_RESOURCES_CONFIG trc where trc.resources_configtypeid = '"+userid+"' and trc.resources_id = '16'");
			PreparedDBUtil db = new PreparedDBUtil();
			db.preparedSelect(sql.toString());
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				ids = db.getString(i, "ids");
			}
			if(ids.length()>0){
				String[] id = ids.split(",");
				for (int i = 0; i < id.length; i++) {
					if(i == (id.length-1)){
						ids = "'"+id[i]+"'";
					}else{
						ids = "'"+id[i]+"',";
					}
				}
			}
		} finally {
			DbManager.closeConnection(conn);
		}
		
		return ids;
	}

	/**
	 * 
	 *<b>Summary: 根据value值获得对应的学历名称</b> getEducationNameByValue(请用一句话描述这个方法的作用)
	 * 
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
	 * 
	 * <b>Summary:根据名录管理ID获得名录管理 </b> 复写方法 getTypeBeanById
	 * 
	 * @param id
	 * @param listtype
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#getTypeBeanById(java.lang.String,
	 *      java.lang.String)
	 */
	public DirectoryBean getTypeBeanById(String id, String listtype)
			throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			StringBuffer sql = new StringBuffer();
			sql.append("select ");
			sql
					.append(" USER_IDCARD ,user_name,USER_REALNAME,decode(USER_SEX,'M','男','F','女','未知')as user_sex,USER_BIRTHDAY ,");
			sql
					.append("   u.POLITICS ,DUTIES,DIRECTORYLEVEL,EDUCATION,SCHOOL,DEGREE,WORKTIME,JOINPARTTIME,DIRECTORYSTATE  ,");
			sql
					.append(" USER_MOBILETEL2,USER_MOBILETEL1,USER_WORKNUMBER,USER_WORKTEL,m.REMARK4,m.REMARK5 ,o.org_name department,");
			sql
					.append(" new_user_type,new_job_state,new_job_no,new_job_set ,to_char(new_join_zzdate,'yyyy-MM-dd') new_join_zzdate,to_char(new_in_hosb,'yyyy-MM-dd')new_in_hosb ,to_char(new_toother_date,'yyyy-MM-dd')new_toother_date ,new_first_xingshi ,");
			sql
					.append(" new_first_zy,to_char(new_first_bydate,'yyyy-MM-dd')new_first_bydate,new_zg_byyx,new_zg_xl ,");
			sql
					.append(" new_zg_xw,new_zg_xingshi,new_zg_zy,to_char(new_zg_bydate,'yyyy-MM-dd')new_zg_bydate ,");
			sql
					.append(" new_jszc,to_char(new_zc_getdate,'yyyy-MM-dd')new_zc_getdate ,to_char(new_zc_pydate,'yyyy-MM-dd')new_zc_pydate ,");
			//特检院 OA 薪酬信息
			sql.append(" new_xc_gwgz,new_xc_xjgz ,new_xc_yfgz,new_xc_yb ,new_xc_ylbx,new_xc_sybx,");
			sql.append(" new_xc_gjj,new_xc_cb ,new_xc_cbhj,new_xc_sfhj,");
			sql.append(" HOMEADRESS,USER_HOMETEL,USER_EMAIL ,u.*");
			
			sql.append("  from td_sm_user m ");
			sql.append(" left join oa_userandsn u on m.user_id = u.userid ");
			sql.append(" left join td_sm_orguser ou on m.user_id = ou.user_id ");
			sql.append(" left join td_sm_organization o on ou.org_id = o.org_id ");
			sql.append(" where m.user_id =? ");
			PreparedDBUtil db = new PreparedDBUtil();
			DirectoryBean ab = new DirectoryBean();
			db.preparedSelect(sql.toString());
			db.setString(1, id);
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				ab.setDirectoryid(db.getString(i, "directoryid"));
				ab.setEng_name(db.getString(i, "user_name"));
				ab.setDirectoryname(db.getString(i, "USER_REALNAME"));
				ab.setDirectoryyear(DateUtil.getTimeString(db.getTimestamp(i,
						"USER_BIRTHDAY")));
				ab.setDirectorysex(db.getString(i, "USER_SEX"));

				ab.setDirectorystate(db.getString(i, "directorystate"));

				if ("view".equals(listtype)) {
					// ab.setDegree(getDegreeNameByValue(db.getString(i,
					// "degree")));
					ab.setEducation(getEducationNameByValue(db.getString(i,
							"education")));
					ab.setPolitics(getPoliticsNameByValue(db.getString(i,
							"politics")));
				} else {
					// ab.setDegree(db.getString(i, "degree"));
					ab.setEducation(db.getString(i, "education"));
					ab.setPolitics(db.getString(i, "politics"));
				}

				ab.setDegree(db.getString(i, "degree"));
				ab.setPolitics(db.getString(i, "politics"));
				ab.setSeniority(db.getString(i, "seniority"));

				ab.setSchool(db.getString(i, "school"));
				ab.setNation(db.getString(i, "nation"));

				ab.setNatives(db.getString(i, "natives"));

				ab.setSpecialty(db.getString(i, "specialty"));
				ab.setMobile(db.getString(i, "USER_MOBILETEL1"));
				ab.setMobile2(db.getString(i, "USER_MOBILETEL2"));
				ab.setHomeadress(db.getString(i, "HOMEADRESS"));
				ab.setWorkphone(db.getString(i, "USER_WORKTEL"));
				
				ab.setRemark4(db.getString(i, "REMARK4"));
				ab.setRemark5(db.getString(i, "REMARK5"));
				

				ab.setWorkadress(db.getString(i, "USER_WORKNUMBER"));
				ab.setHomephone(db.getString(i, "USER_HOMETEL"));
				ab.setEmail(db.getString(i, "USER_EMAIL"));
				ab.setDuty(db.getString(i, "duty"));

				ab.setResume(db.getString(i, "resume"));
				ab.setOrgid(db.getString(i, "orgid"));
				ab.setOrgname(db.getString(i, "orgname"));
				ab.setDuties(db.getString(i, "duties"));

				ab.setIdnumber(db.getString(i, "USER_IDCARD"));
				ab.setWorktime(DateUtil.getTimeString(db.getTimestamp(i,
						"worktime")));
				//离职日期
				ab.setLeavetime(DateUtil.getTimeString(db.getTimestamp(i, "leavetime")));
				ab.setJoinparttime(DateUtil.getTimeString(db.getTimestamp(i,
						"joinparttime")));
				ab.setPost(db.getString(i, "DUTIES"));
				ab.setDirectorylevel(db.getString(i, "directorylevel"));
				ab.setDepartment(db.getString(i, "department"));

				ab.setDirectory_sn(db.getString(i, "directory_sn"));

				ab.setNumberone(db.getString(i, "numberone"));

				ab.setDeptName(db.getString(i, "dept_name"));
				ab.setDeptId(db.getString(i, "dept_id"));
				
				ab.setNew_user_type(db.getString(i, "new_user_type"));
				ab.setNew_job_state(db.getString(i, "new_job_state"));
				ab.setNew_job_no(db.getString(i, "new_job_no"));
				ab.setNew_job_set(db.getString(i, "new_job_set"));
				ab.setNew_join_zzdate(db.getString(i, "new_join_zzdate"));
				ab.setNew_in_hosb(db.getString(i, "new_in_hosb"));
				ab.setNew_toother_date(db.getString(i, "new_toother_date"));
				ab.setNew_first_xingshi(db.getString(i, "new_first_xingshi"));
				ab.setNew_first_zy(db.getString(i, "new_first_zy"));
				ab.setNew_first_bydate(db.getString(i, "new_first_bydate"));
				ab.setNew_zg_byyx(db.getString(i, "new_zg_byyx"));
				ab.setNew_zg_xl(db.getString(i, "new_zg_xl"));
				ab.setNew_zg_xw(db.getString(i, "new_zg_xw"));
				ab.setNew_zg_xingshi(db.getString(i, "new_zg_xingshi"));
				ab.setNew_zg_zy(db.getString(i, "new_zg_zy"));
				//专业级别（最高学历）
				ab.setNew_jb_zy(db.getString(i, "new_jb_zy"));
				ab.setNew_zg_bydate(db.getString(i, "new_zg_bydate"));
				ab.setNew_jszc(db.getString(i, "new_jszc"));
				ab.setNew_zc_getdate(db.getString(i, "new_zc_getdate"));
				ab.setNew_zc_pydate(db.getString(i, "new_zc_pydate"));
				//特检院 OA 薪酬信息
				ab.setNew_xc_gwgz(db.getString(i, "new_xc_gwgz"));
				ab.setNew_xc_xjgz(db.getString(i, "new_xc_xjgz"));
				ab.setNew_xc_yfgz(db.getString(i, "new_xc_yfgz"));
				ab.setNew_xc_yb(db.getString(i, "new_xc_yb"));
				ab.setNew_xc_ylbx(db.getString(i, "new_xc_ylbx"));
				ab.setNew_xc_sybx(db.getString(i, "new_xc_sybx"));
				ab.setNew_xc_gjj(db.getString(i, "new_xc_gjj"));
				ab.setNew_xc_cb(db.getString(i, "new_xc_cb"));
				ab.setNew_xc_cbhj(db.getString(i, "new_xc_cbhj"));
				ab.setNew_xc_sfhj(db.getString(i, "new_xc_sfhj"));
				
			}
			return ab;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getFirstCodeShowInfo
	 * 
	 * @param orgoruserid
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#getFirstCodeShowInfo(java.lang.String)
	 */
	@Override
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid)
			throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			List<ListShowUtilBean> list = new ArrayList<ListShowUtilBean>();
			PreparedDBUtil pdb = new PreparedDBUtil();
			String firstCodeAreaStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			StringBuffer sql = new StringBuffer();

			if (StringUtil.nullOrBlank(orgoruserid)) {

				String org_id = DaoUtil
						.sqlToField("select o.org_id from td_sm_organization o where o.parent_id = '0' ");
				orgoruserid = org_id;

			}
			sql.setLength(0);
			sql
					.append("select t.user_id from td_sm_user t  left join td_sm_orguser u on u.user_id =t.user_id where t.user_name like ? ");
			if (!StringUtil.nullOrBlank(orgoruserid)) {
				sql.append(" and exists(select 1 from (select a.org_id ");
				sql.append("		  from td_sm_organization a ");
				sql.append("		connect by prior a.org_id = a.parent_id ");
				sql
						.append("		 start with a.org_id = ?) o where o.org_id = u.org_id ");
				sql.append("		 )  ");
			}
			for (int i = 0; i < firstCodeAreaStr.length(); i++) {
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, String.valueOf(firstCodeAreaStr.charAt(i))
						.toLowerCase()
						+ "%");
				if (!StringUtil.nullOrBlank(orgoruserid)) {
					pdb.setString(2, orgoruserid);
				}
				pdb.executePrepared(conn);
				ListShowUtilBean bean = new ListShowUtilBean();
				bean.setFirstCode(String.valueOf(firstCodeAreaStr.charAt(i)));
				if (!StringUtil.nullOrBlank(orgoruserid) && pdb.size() > 0)
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
	 * <b>Summary: 管理员修改用户信息</b> 复写方法 updateUserinfo
	 * 
	 * @param userinfoBean
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#updateUserinfo(com.chinacreator.xtbg.core.directory.entity.UserinfoBean)
	 */
	public void updateUserinfo(UserinfoBean userinfoBean, HeTongBean heTongBean, Connection conn)
			throws Exception {

		PreparedDBUtil pdb = new PreparedDBUtil();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		StringBuffer sql3 = new StringBuffer();
		int i = 1;
		int j = 1;
		int k = 1;
		sql.append("  update td_sm_user set ");
		if(userinfoBean.getUserIdcard()!=null){
			sql.append("       USER_IDCARD=?,");
		}
		if(userinfoBean.getUserSex()!=null){
			sql.append("       USER_SEX=?,");
		}
		if(userinfoBean.getUserBirthday()!=null){
			sql.append("       USER_BIRTHDAY = to_date(?,'yyyy-mm-dd'),");
		}
		if(userinfoBean.getUserMobiletel1()!=null){
			sql.append("       USER_MOBILETEL1=?,");
		}
		if(userinfoBean.getUserMobiletel2()!=null){
			sql.append("       USER_MOBILETEL2=?,");
		}
		if(userinfoBean.getMail()!=null){
			sql.append("       USER_EMAIL=?,");
		}
		if(userinfoBean.getHomePhone()!=null){
			sql.append("       USER_HOMETEL=?,");
		}
		if(userinfoBean.getRemark4()!=null){
			sql.append("       REMARK4=?,");
		}
		if(userinfoBean.getUserWorktel()!=null){
			sql.append("       USER_WORKTEL=?, ");
		}
		sql.append("       USER_REALNAME=? ");
		sql.append(" where user_id = ? ");
		pdb.preparedUpdate(sql.toString());
		if(userinfoBean.getUserIdcard()!=null){
			pdb.setString(j++, userinfoBean.getUserIdcard());
		}
		if(userinfoBean.getUserSex()!=null){
			pdb.setString(j++, userinfoBean.getUserSex());
		}
		if(userinfoBean.getUserBirthday()!=null){
			pdb.setString(j++, userinfoBean.getUserBirthday());
		}
		if(userinfoBean.getUserMobiletel1()!=null){
			pdb.setString(j++, userinfoBean.getUserMobiletel1());
		}
		if(userinfoBean.getUserMobiletel2()!=null){
			pdb.setString(j++, userinfoBean.getUserMobiletel2());
		}
		if(userinfoBean.getMail()!=null){
			pdb.setString(j++, userinfoBean.getMail());
		}
		if(userinfoBean.getHomePhone()!=null){
			pdb.setString(j++, userinfoBean.getHomePhone());
		}
		if(userinfoBean.getRemark4()!=null){
			pdb.setString(j++, userinfoBean.getRemark4());
		}
		if(userinfoBean.getUserWorktel()!=null){
			pdb.setString(j++, userinfoBean.getUserWorktel());
		}
		pdb.setString(j++, userinfoBean.getUserRealname());
		pdb.setString(j++, userinfoBean.getUserid());
		pdb.executePrepared(conn);
		if (!queryuser(userinfoBean.getUserid())) {
			insertuser(userinfoBean.getUserid());
		}
		sql2.append("  update oa_userandsn set ");
		sql2.append("  directorystate = ?, education = ?, degree = ?, politics = ?, ");
		sql2.append("  school = ?,nation = ?,natives = ?, ");
		sql2.append("  homeadress = ?,joinparttime = to_date(?,'yyyy-mm-dd'),worktime = to_date(?,'yyyy-mm-dd'),duties = ?,directorylevel = ? ,");
		sql2.append("  new_user_type = ?, new_job_state = ?, new_job_no = ?, new_job_set = ?,");
		sql2.append("  new_in_hosb = to_date(?,'yyyy-mm-dd'),new_join_zzdate = to_date(?,'yyyy-mm-dd'),new_toother_date = to_date(?,'yyyy-mm-dd'),new_first_xingshi = ?,new_first_zy = ? ,");
		sql2.append("  new_first_bydate = to_date(?,'yyyy-mm-dd'),new_zg_byyx = ?, new_zg_xl = ?, new_zg_xw = ?, new_zg_xingshi = ?, new_zg_zy = ?, new_zg_bydate = to_date(?,'yyyy-mm-dd'),");
		sql2.append("  new_jszc = ?, new_zc_getdate = to_date(?,'yyyy-mm-dd'), new_zc_pydate = to_date(?,'yyyy-mm-dd'),");
		//特检院 OA 薪酬信息 start
		sql2.append("  new_xc_gwgz = ?, new_xc_xjgz = ?, new_xc_yfgz = ?,");
		sql2.append("  new_xc_yb = ?, new_xc_ylbx = ?, new_xc_sybx = ?,new_xc_gjj=?,");
		sql2.append("  new_xc_cb = ?, new_xc_cbhj = ?, new_xc_sfhj = ?, ");
		//特检院 OA 薪酬信息 end
		sql2.append("  duty = ?,resume= ?,numberone=?,remark=?,new_jb_zy=?,leavetime = to_date(?,'yyyy-mm-dd') ");
		sql2.append("  where userid= ?  ");
		db.preparedUpdate(sql2.toString());
		db.setString(i++, userinfoBean.getDirectorystate());
		db.setString(i++, userinfoBean.getEducation());
		db.setString(i++, userinfoBean.getDegree());
		db.setString(i++, userinfoBean.getPolitics());
		db.setString(i++, userinfoBean.getSchool());
		db.setString(i++, userinfoBean.getNation());
		db.setString(i++, userinfoBean.getNatives());
		db.setString(i++, userinfoBean.getHomeadress());
		db.setString(i++, userinfoBean.getJoinparttime());
		db.setString(i++, userinfoBean.getWorktime());
		db.setString(i++, userinfoBean.getDuties());
		db.setString(i++, userinfoBean.getDirectorylevel());
		db.setString(i++, userinfoBean.getNew_user_type());
		db.setString(i++, userinfoBean.getNew_job_state());
		db.setString(i++, userinfoBean.getNew_job_no());
		db.setString(i++, userinfoBean.getNew_job_set());
		db.setString(i++, userinfoBean.getNew_in_hosb());
		db.setString(i++, userinfoBean.getNew_join_zzdate());
		db.setString(i++, userinfoBean.getNew_toother_date());
		db.setString(i++, userinfoBean.getNew_first_xingshi());
		db.setString(i++, userinfoBean.getNew_first_zy());
		db.setString(i++, userinfoBean.getNew_first_bydate());
		db.setString(i++, userinfoBean.getNew_zg_byyx());
		db.setString(i++, userinfoBean.getNew_zg_xl());
		db.setString(i++, userinfoBean.getNew_zg_xw());
		db.setString(i++, userinfoBean.getNew_zg_xingshi());
		db.setString(i++, userinfoBean.getNew_zg_zy());
		db.setString(i++, userinfoBean.getNew_zg_bydate());
		db.setString(i++, userinfoBean.getNew_jszc());
		db.setString(i++, userinfoBean.getNew_zc_getdate());
		db.setString(i++, userinfoBean.getNew_zc_pydate());
		//特检院 OA 薪酬信息 start
		db.setString(i++, userinfoBean.getNew_xc_gwgz());
		db.setString(i++, userinfoBean.getNew_xc_xjgz());
		db.setString(i++, userinfoBean.getNew_xc_yfgz());
		db.setString(i++, userinfoBean.getNew_xc_yb());
		db.setString(i++, userinfoBean.getNew_xc_ylbx());
		db.setString(i++, userinfoBean.getNew_xc_sybx());
		db.setString(i++, userinfoBean.getNew_xc_gjj());
		db.setString(i++, userinfoBean.getNew_xc_cb());
		db.setString(i++, userinfoBean.getNew_xc_cbhj());
		db.setString(i++, userinfoBean.getNew_xc_sfhj());
		//特检院 OA 薪酬信息 end
		db.setString(i++, userinfoBean.getDuty());
		db.setString(i++, userinfoBean.getResume());
		db.setString(i++, userinfoBean.getNumberOne());
		db.setString(i++, userinfoBean.getRemark());
		//专业级别(最高学历)
		db.setString(i++, userinfoBean.getNew_jb_zy());
		//离职日期
		db.setString(i++, userinfoBean.getLeavetime());
		db.setString(i++, userinfoBean.getUserid());
		db.executePrepared(conn);
		//合同
		if (!queryHetong(userinfoBean.getUserid())) {
			insertHetong(userinfoBean.getUserid());
		}
		sql3.append("  update oa_hetong set ");
		sql3
				.append("  hetong_isold = ?, hetong_isyl = ?, hetong_issy = ?, hetong_isgs = ?, ");
		sql3.append("  hetong_isshiye = ?,hetong_isydwgm = ?, hetong_type = ?, hetong_number = ?, hetong_first_date = to_date(?,'yyyy-mm-dd'), hetong_nowstart_date = to_date(?,'yyyy-mm-dd'), ");
		sql3.append("  hetong_nowsend_date = to_date(?,'yyyy-mm-dd'), hetong_trystart_date = to_date(?,'yyyy-mm-dd'), hetong_tryend_date = to_date(?,'yyyy-mm-dd'),hetong_busiid = ?  ");
		sql3.append("  where hetong_userands_id= ?  ");
		db.preparedUpdate(sql3.toString());
		db.setString(k++, heTongBean.getHetong_isold());
		db.setString(k++, heTongBean.getHetong_isyl());
		db.setString(k++, heTongBean.getHetong_issy());
		db.setString(k++, heTongBean.getHetong_isgs());
		db.setString(k++, heTongBean.getHetong_isshiye());
		//原单位购买
		db.setString(k++, heTongBean.getHetong_isydwgm());
		db.setString(k++, heTongBean.getHetong_type());
		db.setString(k++, heTongBean.getHetong_number());
		db.setString(k++, heTongBean.getHetong_first_date());
		db.setString(k++, heTongBean.getHetong_nowstart_date());
		db.setString(k++, heTongBean.getHetong_nowsend_date());
		db.setString(k++, heTongBean.getHetong_trystart_date());
		db.setString(k++, heTongBean.getHetong_tryend_date());
		db.setString(k++, heTongBean.getHetong_busiid());
		db.setString(k++, userinfoBean.getUserid());
		db.executePrepared(conn);
	}

	/**
	 * 
	 * <b>Summary:查询查询用户是否在oa_userandsn表中就记录 </b> 复写方法 queryuser
	 * 
	 * @param userid
	 * @return 存在返回true,否则返回false
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#queryuser(java.lang.String)
	 */
	public boolean queryuser(String userid) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			boolean flag = false;
			sql.append("	select sn.id from oa_userandsn sn");
			sql.append("	where sn.userid=" + userid + " ");

			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			if (pdb.size() > 0) {
				flag = true;
			}

			return flag;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: 往oa_userandsn中插入一条扩展记录 </b> 复写方法 insertuser
	 * 
	 * @param userid
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#insertuser(java.lang.String)
	 */
	public void insertuser(String userid) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql.append(" insert into oa_userandsn s (id,userid) values(?,?)");

			pdb.preparedInsert(sql.toString());
			pdb.setString(1, StringUtil.getUUID());
			pdb.setString(2, userid);
			pdb.executePrepared(conn);
		} finally {
			DbManager.closeConnection(conn);
		}

	}
	
	/**
	 * 
	 *<b>Summary: </b> splitstr(将字符串已@@分割为list)
	 * 
	 * @param str
	 * @return
	 */
	public List<String> splitstr(String str) {
		List<String> list = new ArrayList<String>();
		String[] newstr = str.split("@@");
		for (int i = 0; i < newstr.length; i++) {
			list.add(newstr[i]);
		}
		return list;
	}

	/**
	 * 
	  * <b>Summary: 查询查询用户是否在oa_hetong表中就记录 </b> 
	  *     复写方法 queryHetong
	  * @param userid
	  * @return 存在返回true,否则返回false
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#queryHetong(java.lang.String)
	 */
	public boolean queryHetong(String userid) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			boolean flag = false;
			sql.append("	select sn.hetong_id from oa_hetong sn");
			sql.append("	where sn.hetong_userands_id='" + userid + "' ");

			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			if (pdb.size() > 0) {
				flag = true;
			}

			return flag;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: 往oa_hetong中插入一条扩展记录 </b>
	  *     复写方法 insertHetong
	  * @param userid
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#insertHetong(java.lang.String)
	 */
	public void insertHetong(String userid) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql.append(" insert into oa_hetong s (hetong_id,hetong_userands_id) values(?,?)");

			pdb.preparedInsert(sql.toString());
			pdb.setString(1, StringUtil.getUUID());
			pdb.setString(2, userid);
			pdb.executePrepared(conn);
		} finally {
			DbManager.closeConnection(conn);
		}

		
	}

	/**
	 * 
	  * <b>Summary: 根据用户ID获得合同信息</b>
	  *     复写方法 getHeTongBeanById
	  * @param id
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#getHeTongBeanById(java.lang.String)
	 */
	public HeTongBean getHeTongBeanById(String id) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			StringBuffer sql = new StringBuffer();
			sql.append("select ");
			sql
					.append(" hetong_isold ,hetong_isyl,hetong_issy,hetong_isgs ,hetong_busiid ,");
			sql
					.append("   hetong_isshiye ,hetong_isydwgm ,hetong_type,hetong_number,to_char(hetong_first_date,'yyyy-MM-dd') hetong_first_date,");
			sql
					.append(" to_char(hetong_nowstart_date,'yyyy-MM-dd') hetong_nowstart_date,to_char(hetong_nowsend_date,'yyyy-MM-dd') hetong_nowsend_date,to_char(hetong_trystart_date,'yyyy-MM-dd') hetong_trystart_date,to_char(hetong_tryend_date,'yyyy-MM-dd') hetong_tryend_date ");
			
			sql.append("  from td_sm_user m ");
			sql.append(" left join oa_hetong u on m.user_id = u.hetong_userands_id ");
			sql.append(" where user_id =? ");
			PreparedDBUtil db = new PreparedDBUtil();
			HeTongBean heTongBean = new HeTongBean();
			db.preparedSelect(sql.toString());
			db.setString(1, id);
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				heTongBean.setHetong_isold(db.getString(i, "hetong_isold"));
				heTongBean.setHetong_isyl(db.getString(i, "hetong_isyl"));
				heTongBean.setHetong_issy(db.getString(i, "hetong_issy"));
				heTongBean.setHetong_isgs(db.getString(i, "hetong_isgs"));
				heTongBean.setHetong_isshiye(db.getString(i, "hetong_isshiye"));
				heTongBean.setHetong_isydwgm(db.getString(i, "hetong_isydwgm"));
				heTongBean.setHetong_type(db.getString(i, "hetong_type"));
				heTongBean.setHetong_number(db.getString(i, "hetong_number"));
				heTongBean.setHetong_first_date(db.getString(i, "hetong_first_date"));
				heTongBean.setHetong_nowstart_date(db.getString(i, "hetong_nowstart_date"));
				heTongBean.setHetong_nowsend_date(db.getString(i, "hetong_nowsend_date"));
				heTongBean.setHetong_trystart_date(db.getString(i, "hetong_trystart_date"));
				heTongBean.setHetong_tryend_date(db.getString(i, "hetong_tryend_date"));
				heTongBean.setHetong_busiid(db.getString(i, "hetong_busiid"));
			}
			return heTongBean;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: 根据人员id查询其配置的可查看的薪酬人员id</b>
	  *     复写方法 queryPeizhiUserId
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#queryPeizhiUserId(java.lang.String)
	 */
	public String queryPeizhiUserId(String id) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		String ids = "";
		try {
			StringBuffer sql = new StringBuffer();
			sql.append("select to_char(trc.ids)ids from TA_OA_RESOURCES_CONFIG trc where trc.resources_configtypeid = '"+id+"' and trc.resources_id = '17'");
			PreparedDBUtil db = new PreparedDBUtil();
			db.preparedSelect(sql.toString());
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				ids = db.getString(i, "ids");
			}
		} finally {
			DbManager.closeConnection(conn);
		}
		return ids;
	}

	/**
	 * 
	  * <b>Summary: 根据条件查询合同预警的列表</b>
	  *     复写方法 findHetongList
	  * @param typeBeanJson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#findHetongList(com.chinacreator.xtbg.core.directory.entity.DirectoryBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findHetongList(DirectoryBean typeBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {

			PagingBean pb = new PagingBean();
			PreparedDBUtil db = new PreparedDBUtil();
			List<DirectoryBean> list = new ArrayList<DirectoryBean>();
			StringBuffer sql = new StringBuffer();
			
			sql
					.append("select o.org_id,o.org_name, u.user_id, u.user_name, u.user_realname,u.user_mobiletel1,u.user_sn,");
			sql.append(" to_char(ht.hetong_nowsend_date,'yyyy-MM-dd')hetong_nowsend_date,to_char(ht.hetong_tryend_date,'yyyy-MM-dd')hetong_tryend_date, ");
			sql
					.append("u.user_mobiletel2,u.user_worktel,u.user_email,u.remark2,u.remark4,u.remark5,usn.*");
			sql
					.append("  from td_sm_organization o ");
			sql.append("  left join td_sm_orguser ou on ou.org_id = o.org_id");
			sql.append("  left join td_sm_user u on u.user_id = ou.user_id");
			sql
					.append("  left join td_sm_userjoborg a on a.user_id = ou.user_id");
			sql
					.append("                              and ou.org_id = a.org_id");
			sql
					.append("   left join oa_userandsn usn on u.user_id = usn.userid");
			sql
					.append("   left join oa_hetong ht on u.user_id = ht.hetong_userands_id");
			sql.append(" where (u.user_name is not null)");
			sql.append("   and u.user_isvalid != '3'");
			sql.append("   and (((ht.hetong_nowsend_date-sysdate)>0 and (ht.hetong_nowsend_date-sysdate)<=30)");
			sql.append("   or ((ht.hetong_tryend_date-sysdate)>0 and (ht.hetong_tryend_date-sysdate)<=30))");
			if (!StringUtil.nullOrBlank(typeBean.getLikevalue())) {
				sql.append(" and (user_realname like ?  or");
				sql.append("      o.org_name like ? or ");

				sql
						.append(" user_mobiletel1 like ?  or user_email like ? or user_worktel like ? or user_hometel like ?) ");
			}

			if (!StringUtil.nullOrBlank(typeBean.getNameindex())) {
				sql.append(" and user_name like ? ");
			}
			// 是否是党政一把手
			if (!StringUtil.nullOrBlank(typeBean.getDepartment())) {
				if ("是".equals(typeBean.getDepartment().trim())) {
					sql.append(" and numberone = '"
							+ typeBean.getDepartment().trim() + "'");
				} else {
					sql.append(" and (numberone = '"
							+ typeBean.getDepartment().trim()
							+ "' or numberone is null) ");
				}
			}
			// 级别
			String array[] = typeBean.getDirectorylevel().split(",");
			if (!StringUtil.nullOrBlank(typeBean.getDirectorylevel())) {

				sql.append(" and ( usn.directorylevel like ?");
				for (int i = 0; i < array.length - 1; i++) {
					sql.append(" or usn.directorylevel like ?  ");
				}
				// sql.append(" and usn.directorylevel   like ? ");
				sql.append(" ) ");
			}
			// 政治面貌
			String parray[] = typeBean.getPolitics().split(",");
			if (!StringUtil.nullOrBlank(typeBean.getPolitics())) {
				sql.append(" and ( usn.politics = ?");
				for (int i = 0; i < parray.length - 1; i++) {
					sql.append(" or usn.politics  =?  ");
				}
				sql.append(" ) ");

			}
			// 所在单位
			if (!StringUtil.nullOrBlank(typeBean.getOrgname())) {
				sql.append(" and o.org_name  like ? ");
			}
			// 现合同终止期
			if (!StringUtil.nullOrBlank(typeBean.getHetong_nowsend_date1())) {
				sql.append(" and ht.hetong_nowsend_date  >= to_date(?,'yyyy-MM-dd') ");
			}
			// 现合同终止期
			if (!StringUtil.nullOrBlank(typeBean.getHetong_nowsend_date2())) {
				sql.append(" and ht.hetong_nowsend_date  <= to_date(?,'yyyy-MM-dd') ");
			}
			// 合同试用终止期
			if (!StringUtil.nullOrBlank(typeBean.getHetong_tryend_date1())) {
				sql.append(" and ht.hetong_tryend_date  >= to_date(?,'yyyy-MM-dd') ");
			}
			// 合同试用终止期
			if (!StringUtil.nullOrBlank(typeBean.getHetong_tryend_date2())) {
				sql.append(" and ht.hetong_tryend_date  <= to_date(?,'yyyy-MM-dd') ");
			}
			sql
					.append(" order by a.same_job_user_sn,  u.user_sn ");
			if (maxPagesize == -1) {
				db.preparedSelect(sql.toString());
			} else {
				db.preparedSelect(sql.toString(), offset, maxPagesize);
			}

			int j = 1;
			if (!StringUtil.nullOrBlank(typeBean.getLikevalue())) {
				db.setString(j++, "%" + typeBean.getLikevalue() + "%");
				db.setString(j++, "%" + typeBean.getLikevalue() + "%");

				db.setString(j++, "%" + typeBean.getLikevalue() + "%");
				db.setString(j++, "%" + typeBean.getLikevalue() + "%");
				db.setString(j++, "%" + typeBean.getLikevalue() + "%");
				db.setString(j++, "%" + typeBean.getLikevalue() + "%");
			}
			// 是否是党政一把手
			if (!StringUtil.nullOrBlank(typeBean.getDepartment())) {
				sql.append(" and numberone = '" + typeBean.getDepartment()
						+ "' ");
			}
			// 级别
			if (!StringUtil.nullOrBlank(typeBean.getDirectorylevel())) {
				for (int i = 0; i < array.length; i++) {
					db.setString(j++, "%" + array[i] + "%");
				}
			}
			// 政治面貌
			if (!StringUtil.nullOrBlank(typeBean.getPolitics())) {
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
			if (!StringUtil.nullOrBlank(typeBean.getOrgname())) {
				db.setString(j++, "%" + typeBean.getOrgname() + "%");
			}
			// 现合同终止期起始时间
			if (!StringUtil.nullOrBlank(typeBean.getHetong_nowsend_date1())) {
				db.setString(j++, typeBean.getHetong_nowsend_date1());
			}
			// 现合同终止期截止时间
			if (!StringUtil.nullOrBlank(typeBean.getHetong_nowsend_date2())) {
				db.setString(j++, typeBean.getHetong_nowsend_date2());
			}
			// 合同试用终止期起始时间
			if (!StringUtil.nullOrBlank(typeBean.getHetong_tryend_date1())) {
				db.setString(j++, typeBean.getHetong_tryend_date1());
			}
			// 合同试用终止期截止时间
			if (!StringUtil.nullOrBlank(typeBean.getHetong_tryend_date2())) {
				db.setString(j++, typeBean.getHetong_tryend_date2());
			}
			if (!StringUtil.nullOrBlank(typeBean.getNameindex())) {
				db.setString(j++, typeBean.getNameindex().toLowerCase() + "%");
			}
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				DirectoryBean ab = new DirectoryBean();
				ab.setDirectoryid(db.getString(i, "user_id"));
				ab.setDirectoryname(db.getString(i, "user_realname"));
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
				ab.setHomephone(db.getString(i, "user_worktel"));
				ab.setEmail(db.getString(i, "email"));
				ab.setDuty(db.getString(i, "duty"));
				ab.setRemark4(db.getString(i, "remark4"));
				ab.setRemark5(db.getString(i, "remark5"));
				
				

				ab.setResume(db.getString(i, "resume"));
				ab.setOrgid(db.getString(i, "org_id"));
				ab.setOrgname(db.getString(i, "org_name"));
				ab.setDuties(db.getString(i, "duties"));

				ab.setNumberone(StringUtil.nullOrBlank(db.getString(i,
						"numberone")) ? "否" : db.getString(i,
						"numberone"));
				ab.setDirectorylevel(db.getString(i, "directorylevel"));
				ab.setIshasviewrole("true");
				ab.setHetong_nowsend_date(db.getString(i, "hetong_nowsend_date"));
				ab.setHetong_tryend_date(db.getString(i, "hetong_tryend_date"));
				ab.setNew_job_no(db.getString(i, "new_job_no"));
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
	  * <b>Summary: 管理员修改用户薪酬信息</b>
	  *     复写方法 updateUserXCinfo
	  * @param userinfoBean
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#updateUserXCinfo(com.chinacreator.xtbg.core.directory.entity.UserinfoBean, java.sql.Connection)
	 */
	public void updateUserXCinfo(UserinfoBean userinfoBean, Connection conn)
			throws Exception {
		//人员信息
		if (!queryuser(userinfoBean.getUserid())) {
			insertuser(userinfoBean.getUserid());
		}
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql2 = new StringBuffer();
		int i = 1;
		sql2.append("  update oa_userandsn set ");
		//特检院 OA 薪酬信息 start
		sql2.append("  new_xc_gwgz = ?, new_xc_xjgz = ?, new_xc_yfgz = ?,");
		sql2.append("  new_xc_yb = ?, new_xc_ylbx = ?, new_xc_sybx = ?,new_xc_gjj=?,");
		sql2.append("  new_xc_cb = ?, new_xc_cbhj = ?, new_xc_sfhj = ? ");
		//特检院 OA 薪酬信息 end
		sql2.append("  where userid= ?  ");
		db.preparedUpdate(sql2.toString());
		//特检院 OA 薪酬信息 start
		db.setString(i++, userinfoBean.getNew_xc_gwgz());
		db.setString(i++, userinfoBean.getNew_xc_xjgz());
		db.setString(i++, userinfoBean.getNew_xc_yfgz());
		db.setString(i++, userinfoBean.getNew_xc_yb());
		db.setString(i++, userinfoBean.getNew_xc_ylbx());
		db.setString(i++, userinfoBean.getNew_xc_sybx());
		db.setString(i++, userinfoBean.getNew_xc_gjj());
		db.setString(i++, userinfoBean.getNew_xc_cb());
		db.setString(i++, userinfoBean.getNew_xc_cbhj());
		db.setString(i++, userinfoBean.getNew_xc_sfhj());
		//特检院 OA 薪酬信息 end
		db.setString(i++, userinfoBean.getUserid());
		db.executePrepared(conn);
		
	}

	/**
	 * 
	  * <b>Summary: 根据条件查询薪酬管理</b>
	  *     复写方法 findTypeXCList
	  * @param typeBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.directory.dao.DirectoryDao#findTypeXCList(com.chinacreator.xtbg.core.directory.entity.DirectoryBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findTypeXCList(DirectoryBean typeBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		AccessControl accesscontroler = AccessControl.getAccessControl();
		Connection conn = DbManager.getInstance().getConnection();
		String userid = accesscontroler.getUserID();	
		try {

			PagingBean pb = new PagingBean();
			PreparedDBUtil db = new PreparedDBUtil();
			List<DirectoryBean> list = new ArrayList<DirectoryBean>();
			StringBuffer sql = new StringBuffer();
			
			sql
					.append("select o.org_id,o.org_name, u.user_id, u.user_name, u.user_realname,u.user_mobiletel1,u.user_sn,");
			sql
					.append("u.user_mobiletel2,u.user_worktel,u.user_email,u.remark2,usn.*");
			sql
					.append("  from  ");
			sql.append("         td_sm_organization o");
			sql.append("  left join td_sm_orguser ou on ou.org_id = o.org_id");
			sql.append("  left join td_sm_user u on u.user_id = ou.user_id");
			sql
					.append("  left join td_sm_userjoborg a on a.user_id = ou.user_id");
			sql
					.append("                              and ou.org_id = a.org_id");
			sql
					.append("   left join oa_userandsn usn on u.user_id = usn.userid");
			sql
					.append("   left join oa_hetong ht on u.user_id = ht.hetong_userands_id");
			sql.append(" where (u.user_name is not null)");
			//sql.append("   and u.user_isvalid != '3'");
			//特检院 OA 【人员配置管理】 人员信息查看  start
			//是否部门管理员
			boolean isManager = accesscontroler.isOrganizationManager(typeBean.getOrgid());
			if(isManager==true||"1".equals(userid)){
			} else {
				/*sql.append(" and instr((select t.ids  ");
				sql.append("	from ta_oa_resources_config t ");
				sql.append("	 where t.resources_id = '16' ");
				sql.append("	       and t.resources_configtype = '2' ");
				sql.append("	       and t.resources_configtypeid = '"+userid+"'),u.user_id,1,1)>0");*/
			}
			if (!StringUtil.nullOrBlank(typeBean.getStrRoles())) {
				if(typeBean.getStrRoles().equals("putongUser")){   //普通人员
					sql.append(" and u.user_id = '"+typeBean.getUserid()+"'");
				}
				if(typeBean.getStrRoles().equals("adminUser")){       //薪酬管理员
									
				}
				if(typeBean.getStrRoles().equals("yuanldUser")){      //薪酬院领导
					
				}
				if(typeBean.getStrRoles().equals("orgUser")){      //薪酬部门责任人
					sql.append(" and o.org_id = '"+typeBean.getOrgid()+"'");
				}
			}

			if (!StringUtil.nullOrBlank(typeBean.getNameindex())) {
				sql.append(" and user_name like ? ");
			}
			if (!StringUtil.nullOrBlank(typeBean.getDirectoryname())) {
				sql.append(" and u.user_realname like '%"+typeBean.getDirectoryname()+"%'");
			}
			if (!StringUtil.nullOrBlank(typeBean.getOrg_id())) {
				sql.append(" and o.org_id = '"+typeBean.getOrg_id()+"'");
			}
			
			sql
					.append(" order by u.user_sn ");
			if (maxPagesize == -1) {
				db.preparedSelect(sql.toString());
			} else {
				db.preparedSelect(sql.toString(), offset, maxPagesize);
			}

			int j = 1;
			if (!StringUtil.nullOrBlank(typeBean.getNameindex())) {
				db.setString(j++, typeBean.getNameindex().toLowerCase() + "%");
			}
			db.executePrepared(conn);

			for (int i = 0; i < db.size(); i++) {
				DirectoryBean ab = new DirectoryBean();
				ab.setDirectoryid(db.getString(i, "user_id"));
				ab.setDirectoryname(db.getString(i, "user_realname"));

				/**
				 * 由于新系统没有配置功能，故屏蔽
				 * 
				 * @alter date 2013-6-9
				 */
					String userDeptId = DaoUtil
							.sqlToField("select t.org_id from td_sm_orguser t  where t.user_id='"
									+ typeBean.getUserid() + "' ");
					if ("1".equals(typeBean.getUserid())) {// 系统管理员
						ab.setDirectoryid(db.getString(i, "user_id"));
						ab.setDirectoryname(db.getString(i, "USER_REALNAME"));
						ab.setOrgid(db.getString(i, "org_id"));
						ab.setOrgname(db.getString(i, "org_name"));
						//特检院 OA 薪酬信息
						ab.setNew_xc_gwgz(db.getString(i, "new_xc_gwgz"));
						ab.setNew_xc_xjgz(db.getString(i, "new_xc_xjgz"));
						ab.setNew_xc_yfgz(db.getString(i, "new_xc_yfgz"));
						ab.setNew_xc_yb(db.getString(i, "new_xc_yb"));
						ab.setNew_xc_ylbx(db.getString(i, "new_xc_ylbx"));
						ab.setNew_xc_sybx(db.getString(i, "new_xc_sybx"));
						ab.setNew_xc_gjj(db.getString(i, "new_xc_gjj"));
						ab.setNew_xc_cb(db.getString(i, "new_xc_cb"));
						ab.setNew_xc_cbhj(db.getString(i, "new_xc_cbhj"));
						ab.setNew_xc_sfhj(db.getString(i, "new_xc_sfhj"));
						ab.setIshasviewrole("true");
					} else if (userDeptId.equals(typeBean.getOrgid())) { // 默认显示本单位权限
						ab.setDirectoryid(db.getString(i, "user_id"));
						ab.setDirectoryname(db.getString(i, "USER_REALNAME"));
						ab.setOrgid(db.getString(i, "org_id"));
						ab.setOrgname(db.getString(i, "org_name"));
						//特检院 OA 薪酬信息
						ab.setNew_xc_gwgz(db.getString(i, "new_xc_gwgz"));
						ab.setNew_xc_xjgz(db.getString(i, "new_xc_xjgz"));
						ab.setNew_xc_yfgz(db.getString(i, "new_xc_yfgz"));
						ab.setNew_xc_yb(db.getString(i, "new_xc_yb"));
						ab.setNew_xc_ylbx(db.getString(i, "new_xc_ylbx"));
						ab.setNew_xc_sybx(db.getString(i, "new_xc_sybx"));
						ab.setNew_xc_gjj(db.getString(i, "new_xc_gjj"));
						ab.setNew_xc_cb(db.getString(i, "new_xc_cb"));
						ab.setNew_xc_cbhj(db.getString(i, "new_xc_cbhj"));
						ab.setNew_xc_sfhj(db.getString(i, "new_xc_sfhj"));
						ab.setIshasviewrole("true");
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
	*<b>Summary: </b>
	* updateTopUserInfo(管理员修改首页顶部右上角【人员】用户信息)
	* @param userinfoBean
	* @param conn
	* @throws Exception
	 */
	public void updateTopUserInfo(UserinfoBean userinfoBean, Connection conn) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		int j = 1;
		sql.append("  update td_sm_user set ");
		if(userinfoBean.getUserIdcard()!=null){
			sql.append("       USER_IDCARD=?,");
		}
		if(userinfoBean.getUserSex()!=null){
			sql.append("       USER_SEX=?,");
		}
		if(userinfoBean.getUserBirthday()!=null){
			sql.append("       USER_BIRTHDAY = to_date(?,'yyyy-mm-dd'),");
		}
		if(userinfoBean.getUserMobiletel1()!=null){
			sql.append("       USER_MOBILETEL1=?,");
		}
		if(userinfoBean.getUserMobiletel2()!=null){
			sql.append("       USER_MOBILETEL2=?,");
		}
		if(userinfoBean.getMail()!=null){
			sql.append("       USER_EMAIL=?,");
		}
		if(userinfoBean.getHomePhone()!=null){
			sql.append("       USER_HOMETEL=?,");
		}
		if(userinfoBean.getRemark4()!=null){
			sql.append("       REMARK4=?,");
		}
		if(userinfoBean.getUserWorktel()!=null){
			sql.append("       USER_WORKTEL=?, ");
		}
		sql.append("       USER_REALNAME=? ");
		sql.append(" where user_id = ? ");
		pdb.preparedUpdate(sql.toString());
		if(userinfoBean.getUserIdcard()!=null){
			pdb.setString(j++, userinfoBean.getUserIdcard());
		}
		if(userinfoBean.getUserSex()!=null){
			pdb.setString(j++, userinfoBean.getUserSex());
		}
		if(userinfoBean.getUserBirthday()!=null){
			pdb.setString(j++, userinfoBean.getUserBirthday());
		}
		if(userinfoBean.getUserMobiletel1()!=null){
			pdb.setString(j++, userinfoBean.getUserMobiletel1());
		}
		if(userinfoBean.getUserMobiletel2()!=null){
			pdb.setString(j++, userinfoBean.getUserMobiletel2());
		}
		if(userinfoBean.getMail()!=null){
			pdb.setString(j++, userinfoBean.getMail());
		}
		if(userinfoBean.getHomePhone()!=null){
			pdb.setString(j++, userinfoBean.getHomePhone());
		}
		if(userinfoBean.getRemark4()!=null){
			pdb.setString(j++, userinfoBean.getRemark4());
		}
		if(userinfoBean.getUserWorktel()!=null){
			pdb.setString(j++, userinfoBean.getUserWorktel());
		}
		pdb.setString(j++, userinfoBean.getUserRealname());
		pdb.setString(j++, userinfoBean.getUserid());
		pdb.executePrepared(conn);
	}

	@Override
	public PagingBean getBirthdayList(DirectoryBean typeBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try{
			PagingBean pb = new PagingBean();
			PreparedDBUtil db = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			List<DirectoryBean> list = new ArrayList<DirectoryBean>();
			sql.append("select t.user_id,");
			sql.append("       t.user_realname,");
			sql.append("       to_char(t.user_birthday,'yyyy-MM-dd') as user_birthday,");
			sql.append("	   TO_DATE(to_char(t.user_birthday, 'MM-dd'), 'MM-DD') - TO_DATE(to_char(sysdate, 'MM-dd'), 'MM-DD') as a,");
			sql.append("       org.org_id,");
			sql.append("       org.org_name");
			sql.append("  from td_sm_user t");
			sql.append("  left join td_sm_orguser a");
			sql.append("    on t.user_id = a.user_id");
			sql.append("  left join td_sm_organization org");
			sql.append("    on a.org_id = org.org_id");
			sql.append("  where t.user_isvalid = '2'");		
			sql.append("  and user_birthday is not null");
		
			// 生日查询开始时间
			if (!StringUtil.nullOrBlank(StringUtil.deNull(typeBean.getDirectoryyear1()))) {
				sql.append("   and to_char(t.user_birthday, 'MM-dd') >= trim('"+typeBean.getDirectoryyear1()+"')");
			}
			
			if(!StringUtil.nullOrBlank(StringUtil.deNull(typeBean.getDirectoryyear2()))){
				sql.append("   and to_char(t.user_birthday, 'MM-dd') <= trim('"+typeBean.getDirectoryyear2()+"')");
			}
			sql.append("  order by (case  when a>=0 then 1 when a<0 then 2 else 99 end) ,a asc ");				
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared(conn);
			for(int i=0;i<db.size();i++){
				DirectoryBean bean = new DirectoryBean();
				bean.setDirectoryid(db.getString(i, "user_id"));
				bean.setDirectoryname(db.getString(i, "user_realname"));
				bean.setDirectoryyear(db.getString(i, "user_birthday"));
				bean.setOrg_id(db.getString(i, "org_id"));
				bean.setOrgname(db.getString(i, "org_name"));
				list.add(bean);
				
			}
	
			pb.setList(list);
			pb.setRecords((long) db.getTotalSize());
			return pb;
		}finally {
			DbManager.closeConnection(conn);
		}
	}

}
