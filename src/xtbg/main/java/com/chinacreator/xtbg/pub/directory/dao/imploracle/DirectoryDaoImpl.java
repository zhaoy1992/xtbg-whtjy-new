package com.chinacreator.xtbg.pub.directory.dao.imploracle;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.sysmgrcore.entity.User;
import com.chinacreator.sysmgrcore.entity.UserAndSn;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.pub.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.pub.directory.entity.ListShowUtilBean;
import com.chinacreator.xtbg.pub.directory.entity.UserinfoBean;
import com.chinacreator.xtbg.pub.tree.dao.impl.TreeBusinessDaoImpl;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.PinyinUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionManager;

/**
 *<p>Title:DirectoryDaoImpl.java</p>
 *<p>Description:名录管理实例类</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-2-16
 */
public class DirectoryDaoImpl implements DirectoryDao {

	private static final Logger LOG = Logger.getLogger(DirectoryDaoImpl.class);
	
	/**
	 * @throws Exception 
	 * @Description  名录管理列表
	 * 
	 * @param ScheduleCanViewBean  //查询参数
	 * @param sortName  //排序字段
	 * @param sortOrder  //排序方式
	 * @param offset  //从第几天开始
	 * @param maxPagesize	//当前页数
	 * @return  List
	 * @exception 
	 */
	
	public PagingBean findTypeList(DirectoryBean typeBean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception {
	   	String areacode = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//判断是否是苏仙项目
	   	boolean isNotShowAuthority = CacheCommonManageProxy.getBooleanSystemParam("personwork.isNotShowAuthority");//通讯录查看，如果没有查看权限的人员不应显示在列表中
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<DirectoryBean> list = new ArrayList<DirectoryBean>();
		String ids = TreeBusinessDaoImpl.inqueryPersonRule("7",typeBean.getUserid());
		StringBuffer sql = new StringBuffer();
		/*if (!StringUtil.nullOrBlank(typeBean.getLikevalue())
				||!StringUtil.nullOrBlank(typeBean.getDepartment())
				||!StringUtil.nullOrBlank(typeBean.getDirectorylevel())
				||!StringUtil.nullOrBlank(typeBean.getPolitics())
				||!StringUtil.nullOrBlank(typeBean.getOrgname())
		) {

			try {
				String org_id = DaoUtil
						.SqlToField("select o.org_id from td_sm_organization o where o.parent_id = '0' ");
				typeBean.setOrgid(org_id);
			} catch (SQLException e) {
				LOG.info(e.getMessage());
			}
		}*/
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
		sql.append("   and u.user_isvalid != '3'");
		if(!StringUtil.nullOrBlank(typeBean.getLikevalue())){
			sql.append(" and (user_realname like ?  or");
			sql.append("      o.org_name like ? or ");
			if(!"431003".equals(areacode)){ //苏仙没有职位查询 
				sql.append("      usn.duties like ? or ");
			}
			sql.append(" user_mobiletel1 like ?  or user_email like ? or user_worktel like ? or user_hometel like ?) ");
		}
		
		if(!StringUtil.nullOrBlank(typeBean.getNameindex())){
			sql.append(" and user_name like ? ");
		}
		//是否是党政一把手
		if(!StringUtil.nullOrBlank(typeBean.getDepartment())){
			if("是".equals(typeBean.getDepartment().trim())){
			 sql.append(" and numberone = '"+typeBean.getDepartment().trim()+"'");
			}else{
				 sql.append(" and (numberone = '"+typeBean.getDepartment().trim()+"' or numberone is null) ");	
			}
		}
		//级别
		String array[]=	typeBean.getDirectorylevel().split(",");
		if(!StringUtil.nullOrBlank(typeBean.getDirectorylevel())){
			
			sql.append(" and ( usn.directorylevel like ?");
			for (int i=0;i<array.length-1;i++){
				sql.append(" or usn.directorylevel like ?  ");
			}
			//sql.append(" and usn.directorylevel   like ? ");
			sql.append(" ) ");
		}
		//政治面貌
		String parray[]=	typeBean.getPolitics().split(",");
		if(!StringUtil.nullOrBlank(typeBean.getPolitics())){
			sql.append(" and ( usn.politics = ?");
			for (int i=0;i<parray.length-1;i++){
				sql.append(" or usn.politics  =?  ");
			}
			sql.append(" ) ");
			
			
		}
		//所在单位
		if(!StringUtil.nullOrBlank(typeBean.getOrgname())){
			sql.append(" and o.org_name  like ? ");
		}
		
		sql.append(" order by to_number(o.index_sn),a.same_job_user_sn,  u.user_sn ");
		if(maxPagesize == -1){
			db.preparedSelect(sql.toString());
		}else{
			db.preparedSelect(sql.toString(), offset, maxPagesize);
		}
		
		int j = 1;
    	db.setString(j++, typeBean.getOrgid());
    	if(!StringUtil.nullOrBlank(typeBean.getLikevalue())){
    		db.setString(j++, "%"+typeBean.getLikevalue()+"%");
			db.setString(j++, "%"+typeBean.getLikevalue()+"%");
			if(!"431003".equals(areacode)){ //苏仙没有职位查询 
				db.setString(j++, "%"+typeBean.getLikevalue()+"%");
			}
			db.setString(j++, "%"+typeBean.getLikevalue()+"%");
			db.setString(j++, "%"+typeBean.getLikevalue()+"%");
			db.setString(j++, "%"+typeBean.getLikevalue()+"%");
			db.setString(j++, "%"+typeBean.getLikevalue()+"%");
		}
    	//是否是党政一把手
    	if(!StringUtil.nullOrBlank(typeBean.getDepartment())){
			sql.append(" and numberone = '"+typeBean.getDepartment()+"' ");
		}
		//级别
		if(!StringUtil.nullOrBlank(typeBean.getDirectorylevel())){
		 for(int i = 0;i < array.length;i++){
			db.setString(j++, "%"+array[i]+"%");
		 }
		}
		//政治面貌
		if(!StringUtil.nullOrBlank(typeBean.getPolitics())){
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
		if(!StringUtil.nullOrBlank(typeBean.getOrgname())){
			db.setString(j++, "%"+typeBean.getOrgname()+"%");
		}
		if(!StringUtil.nullOrBlank(typeBean.getNameindex())){
				db.setString(j++, typeBean.getNameindex().toLowerCase()+"%");
		}
    	db.executePrepared();
 
	    if("431003".equals(areacode)){ 
	    for(int i = 0;i < db.size();i++){
	    	DirectoryBean ab = new DirectoryBean();
	    	ab.setDirectoryid(db.getString(i, "user_id"));
	    	ab.setDirectoryname(db.getString(i, "user_realname"));
	    	
	    	//if("Y".equals(db.getString(i, "five_major_org"))){//判断是否是五大机构
	    	//判断当前用户是否有对当前名录数据的查看权限，没权限就只能看姓名和职务两个字段，并且页面不展示详细记录
	    	if("add".equals(typeBean.getListtype()) || ids.indexOf(db.getString(i, "user_id")) != -1){
	    		ab.setDirectoryyear(DateUtil.GetTimeString(db.getTimestamp(i, "directoryyear")) );
		    	ab.setDirectorysex(db.getString(i, "directorysex"));
		    	ab.setPost(db.getString(i, "duties"));
		    	ab.setDirectorystate(db.getString(i, "directorystate"));
		    	ab.setEducation(getEducationNameByValue(db.getString(i, "education")));
		    	ab.setDegree(getDegreeNameByValue(db.getString(i, "degree")));
		    	ab.setSeniority(db.getString(i, "seniority"));
		    	
		    	ab.setSchool(db.getString(i, "school"));
		    	ab.setNation(db.getString(i, "nation"));
		    	ab.setPolitics(getPoliticsNameByValue(db.getString(i, "politics")));
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
		    	
		    	ab.setNumberone(StringUtil.nullOrBlank(db.getString(i,"numberone"))?"否":db.getString(i,"numberone"));
		    	ab.setDirectorylevel(db.getString(i,"directorylevel"));
		    	ab.setIshasviewrole("true");
	    	//}
	    	} else{
	    		String userorgid = DaoUtil.SqlToField("select * from td_sm_orguser where user_id='"+typeBean.getUserid()+"' ");
	    		String userDeptId = DaoUtil.SqlToField("select t.org_id from td_sm_orguser t  where t.user_id='"+typeBean.getUserid()+"' ");
	    		if("1".equals(typeBean.getUserid())){//系统管理员
	    			ab.setDirectoryyear(DateUtil.GetTimeString(db.getTimestamp(i, "directoryyear")) );
			    	ab.setDirectorysex(db.getString(i, "directorysex"));
			    	
			    	ab.setDirectorystate(db.getString(i, "directorystate"));
			    	ab.setEducation(getEducationNameByValue(db.getString(i, "education")));
			    	ab.setDegree(getDegreeNameByValue(db.getString(i, "degree")));
			    	ab.setSeniority(db.getString(i, "seniority"));
			    	
			    	ab.setSchool(db.getString(i, "school"));
			    	ab.setNation(db.getString(i, "nation"));
			    	ab.setPolitics(getPoliticsNameByValue(db.getString(i, "politics")));
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
			    	
			    	ab.setNumberone(StringUtil.nullOrBlank(db.getString(i,"numberone"))?"否":db.getString(i,"numberone"));
			    	ab.setDirectorylevel(db.getString(i,"directorylevel"));
			    	ab.setIshasviewrole("true");
	    		}else if(userDeptId.equals(typeBean.getOrgid()))  { //默认显示本单位权限
		    		ab.setDirectoryyear(DateUtil.GetTimeString(db.getTimestamp(i, "directoryyear")));
			    	ab.setDirectorysex(db.getString(i, "directorysex"));
			    	
			    	ab.setDirectorystate(db.getString(i, "directorystate"));
			    	ab.setEducation(getEducationNameByValue(db.getString(i, "education")));
			    	ab.setDegree(getDegreeNameByValue(db.getString(i, "degree")));
			    	ab.setSeniority(db.getString(i, "seniority"));
			    	
			    	ab.setSchool(db.getString(i, "school"));
			    	ab.setNation(db.getString(i, "nation"));
			    	ab.setPolitics(getPoliticsNameByValue(db.getString(i, "politics")));
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
			    	
			    	ab.setNumberone(StringUtil.nullOrBlank(db.getString(i,"numberone"))?"否":db.getString(i,"numberone"));
			    	ab.setDirectorylevel(db.getString(i,"directorylevel"));
			    	ab.setIshasviewrole("true");
	    	 } 
	    	}
	    	list.add(ab);
	    }
	    	
	    } else if("421005".equals(areacode)){	//望城需要的list
	    	for(int i = 0;i < db.size();i++){
	 	    	DirectoryBean ab = new DirectoryBean();
	 	    	ab.setDirectoryid(db.getString(i, "user_id"));
	 	    	ab.setDirectoryname(db.getString(i, "user_realname"));
	 	    	ab.setIshasviewrole("false");
 	    		ab.setDirectoryyear(DateUtil.GetTimeString(db.getTimestamp(i, "directoryyear")) );
 		    	ab.setDirectorysex(db.getString(i, "directorysex"));

	 	    	ab.setPost(db.getString(i, "duties"));
 		    	ab.setDirectorystate(db.getString(i, "directorystate"));
 		    	ab.setEducation(getEducationNameByValue(db.getString(i, "education")));
 		    	ab.setDegree(getDegreeNameByValue(db.getString(i, "degree")));
 		    	ab.setSeniority(db.getString(i, "seniority"));
 		    	
 		    	ab.setSchool(db.getString(i, "school"));
 		    	ab.setNation(db.getString(i, "nation"));
 		    	ab.setPolitics(db.getString(i, "politics"));
 		    	ab.setNatives(db.getString(i, "natives"));
 		    	
 		    	ab.setSpecialty(db.getString(i, "specialty"));
 		    	ab.setMobile2(db.getString(i, "user_mobiletel1"));
 		    	ab.setHomeadress(db.getString(i, "homeadress"));
 		    	ab.setWorkphone(db.getString(i, "workphone"));
 		    	
 		    	ab.setWorkadress(db.getString(i, "workadress"));
 		    	ab.setHomephone(db.getString(i, "homephone"));
 		    	ab.setEmail(db.getString(i, "email"));
 		    	ab.setDuty(db.getString(i, "duty"));
 		    	
 		    	ab.setResume(db.getString(i, "resume"));
 		    	ab.setOrgid(db.getString(i, "org_id"));
 		    	ab.setOrgname(db.getString(i, "org_name"));
 		    	ab.setDuties(db.getString(i, "duties"));
 		    	
 		    	ab.setIshasviewrole("true");
 		    	ab.setNation(db.getString(i, "nation"));
 		    	ab.setNatives(db.getString(i, "natives"));
 		    	
 		    	String politics = db.getString(i, "politics");
 		    	
 		    	if("1".equals(politics)){
 		    		ab.setPolitics("中共党员");
				} else if("2".equals(politics)){
					ab.setPolitics("中共预备党员");
				}else if("3".equals(politics)){
					ab.setPolitics("共青团员");
				}else if("4".equals(politics)){
					ab.setPolitics("民革党员");
				}else if("5".equals(politics)){
					ab.setPolitics("民盟盟员");
				}else if("6".equals(politics)){
					ab.setPolitics("民建会员");
				}else if("7".equals(politics)){
					ab.setPolitics("民进会员");
				}else if("8".equals(politics)){
					ab.setPolitics("农工党党员");
				}else if("9".equals(politics)){
					ab.setPolitics("致公党党员");
				}else if("10".equals(politics)){
					ab.setPolitics("九三学社社员");
				}else if("11".equals(politics)){
					ab.setPolitics("台盟盟员");
				}else if("12".equals(politics)){
					ab.setPolitics("无党派民主人士");
				}else if("13".equals(politics)){
					ab.setPolitics("群众");
				} else {
					ab.setPolitics("群众");
				}
	 	    	list.add(ab);
	    	}
	    } else{
	    	 for(int i = 0;i < db.size();i++){
	 	    	DirectoryBean ab = new DirectoryBean();
	 	    	ab.setDirectoryid(db.getString(i, "user_id"));
	 	    	ab.setDirectoryname(db.getString(i, "user_realname"));
	 	    	
	 	    	ab.setIshasviewrole("false");
	 	    	//判断当前用户是否有对当前名录数据的查看权限，没权限就只能看姓名和职务两个字段，并且页面不展示详细记录
	 	    	if("add".equals(typeBean.getListtype()) || ids.indexOf(db.getString(i, "user_id")) != -1||"1".equals(typeBean.getUserid())){
	 	    		ab.setDirectoryyear(DateUtil.GetTimeString(db.getTimestamp(i, "directoryyear")) );
	 		    	ab.setDirectorysex(db.getString(i, "directorysex"));

		 	    	ab.setPost(db.getString(i, "duties"));
	 		    	ab.setDirectorystate(db.getString(i, "directorystate"));
	 		    	ab.setEducation(getEducationNameByValue(db.getString(i, "education")));
	 		    	ab.setDegree(getDegreeNameByValue(db.getString(i, "degree")));
	 		    	ab.setSeniority(db.getString(i, "seniority"));
	 		    	
	 		    	ab.setSchool(db.getString(i, "school"));
	 		    	ab.setNation(db.getString(i, "nation"));
	 		    	ab.setPolitics(getPoliticsNameByValue(db.getString(i, "politics")));
	 		    	ab.setNatives(db.getString(i, "natives"));
	 		    	
	 		    	ab.setSpecialty(db.getString(i, "specialty"));
	 		    	ab.setMobile2(db.getString(i, "user_mobiletel1"));
	 		    	ab.setHomeadress(db.getString(i, "homeadress"));
	 		    	ab.setWorkphone(db.getString(i, "workphone"));
	 		    	
	 		    	ab.setWorkadress(db.getString(i, "workadress"));
	 		    	ab.setHomephone(db.getString(i, "homephone"));
	 		    	ab.setEmail(db.getString(i, "email"));
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
		
		
		
		
		/*String ids = TreeBusinessDaoImpl.inqueryPersonRule("7",typeBean.getUserid());
*/
		/*//sql.append("select");
		sql.append(" t.directoryid, t.directoryname, t.directoryyear, t.directorysex,");
		sql.append(" t.directorystate, t.education, t.degree, t.seniority,");
		sql.append(" t.school, t.nation, t.politics, t.natives,");
		sql.append(" t.specialty, t.mobile2, t.homeadress, t.workphone,");
		sql.append(" t.workadress, t.homephone, t.email, t.duty,");
		sql.append(" t.resume, t.orgid, t.orgname, t.duties, t.post ");
		sql.append(" from ta_oa_directory_manage t  left join ta_oa_userorderby  a on  a.user_id=t.directoryid ");
		if(typeBean != null && !"".equals(StringUtil.deNull(typeBean.getOrgid()))){
			sql.append(" and '"+StringUtil.deNull(typeBean.getOrgid())+"' = a.dept_id ");
		}
		//sql.append(" inner join td_sm_organization o on o.org_id = t.orgid ");
		//sql.append(" where 1=1 ");*/
		/*if (!StringUtil.nullOrBlank(typeBean.getLikevalue())
				|| StringUtil.nullOrBlank(typeBean.getOrgid())) {
			try {
				String org_id = DaoUtil
						.SqlToField("select o.org_id from td_sm_organization o where o.parent_id = '0' ");
				typeBean.setOrgid(org_id);
			} catch (SQLException e) {
				LOG.info(e.getMessage());
			}
		}
		sql.append("select  m.* from  (select rownum index_sn, org.org_id, org.org_name  from td_sm_organization org  start with org.org_id = ? connect by prior org.org_id = org.parent_id  order siblings by org.org_sn) o left join ta_oa_directory_manage m on m.dept_id = o.org_id or m.orgid=o.org_id left join ta_oa_userorderby  a on  a.user_id=m.directoryid  and (o.org_id= a.dept_id) where m.orgid is not null");
		//if(typeBean != null) {
				//sql.append(" and (t.orgid = '"+StringUtil.deNull(typeBean.getOrgid())+"' or  instr(t.dept_id,'"+StringUtil.deNull(typeBean.getOrgid())+"') > 0) ");
		//}
		if(!StringUtil.nullOrBlank(typeBean.getLikevalue())){
			sql.append(" and (m.directoryname like ?  or");
			sql.append(" m.mobile2 like ?  or m.email like ? or m.workphone like ? or m.homephone like ?) ");
		}
		
		if(!StringUtil.nullOrBlank(typeBean.getNameindex())){
			sql.append(" and m.eng_name like ? ");
		}
		if(StringUtil.nullOrBlank(sortName)){
			sql.append(" order by to_number(o.index_sn),a.orderby,m.directory_sn");
		}else{
			sql.append(" order by a.orderby,"  + sortName + " " + sortOrder);
		}
		
		try {
			
	    	
	    	int j = 1;
	    	db.setString(j++, typeBean.getOrgid());
	    	if(!StringUtil.nullOrBlank(typeBean.getLikevalue())){
	    		db.setString(j++, "%"+typeBean.getLikevalue()+"%");
				db.setString(j++, "%"+typeBean.getMobile2()+"%");
				db.setString(j++, "%"+typeBean.getEmail()+"%");
				db.setString(j++, "%"+typeBean.getWorkphone()+"%");
				db.setString(j++, "%"+typeBean.getHomephone()+"%");
			}

			if(!StringUtil.nullOrBlank(typeBean.getNameindex())){
					db.setString(j++, typeBean.getNameindex().toLowerCase()+"%");
			}
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	DirectoryBean ab = new DirectoryBean();
		    	ab.setDirectoryid(db.getString(i, "directoryid"));
		    	ab.setDirectoryname(db.getString(i, "directoryname"));
		    	
		    	ab.setPost(db.getString(i, "post"));
		    	ab.setIshasviewrole("false");
		    	//判断当前用户是否有对当前名录数据的查看权限，没权限就只能看姓名和职务两个字段，并且页面不展示详细记录
		    	if("add".equals(typeBean.getListtype()) || ids.indexOf(db.getString(i, "directoryid")) != -1){
		    		ab.setDirectoryyear(db.getString(i, "directoryyear"));
			    	ab.setDirectorysex(db.getString(i, "directorysex"));
			    	
			    	ab.setDirectorystate(db.getString(i, "directorystate"));
			    	ab.setEducation(getEducationNameByValue(db.getString(i, "education")));
			    	ab.setDegree(getDegreeNameByValue(db.getString(i, "degree")));
			    	ab.setSeniority(db.getString(i, "seniority"));
			    	
			    	ab.setSchool(db.getString(i, "school"));
			    	ab.setNation(db.getString(i, "nation"));
			    	ab.setPolitics(getPoliticsNameByValue(db.getString(i, "politics")));
			    	ab.setNatives(db.getString(i, "natives"));
			    	
			    	ab.setSpecialty(db.getString(i, "specialty"));
			    	ab.setMobile2(db.getString(i, "mobile2"));
			    	ab.setHomeadress(db.getString(i, "homeadress"));
			    	ab.setWorkphone(db.getString(i, "workphone"));
			    	
			    	ab.setWorkadress(db.getString(i, "workadress"));
			    	ab.setHomephone(db.getString(i, "homephone"));
			    	ab.setEmail(db.getString(i, "email"));
			    	ab.setDuty(db.getString(i, "duty"));
			    	
			    	ab.setResume(db.getString(i, "resume"));
			    	ab.setOrgid(db.getString(i, "orgid"));
			    	ab.setOrgname(db.getString(i, "orgname"));
			    	ab.setDuties(db.getString(i, "duties"));
			    	
			    	ab.setIshasviewrole("true");
		    	}
		    	
		    	list.add(ab);
		    }
	    } catch (SQLException e) {
			LOG.error("执行名录管理列表查询报错："+e.getMessage());
		}*/
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	/*
	 * 根据value值获得对应的学历名称
	 */
	public String getEducationNameByValue(String value){
		String [][] names = {{"phd","研究生"},
				{"graduate","硕士研究生"},
				{"undergraduate","本科"},
				{"specialist","专科"},
				{"highschool","高中"},
				{"secondary","中专"},
				{"juniorhighschool","初中"},
				{"primaryschool","小学"},
				{"other","其他"}};
		String resultName = "";
		for(int i = 0 ; i < names.length ; i ++){
			if(names[i][0].equals(value)){
				resultName = names[i][1];
			}
		}
		return resultName;
	}
	
	/*
	 * 根据value值获得对应的政治面貌名称
	 */
	public String getPoliticsNameByValue(String value){
		String [][] names = {{"1","中共党员"},
							{"2","中共预备党员"},
							{"3","共青团员"},
							{"4","民革党员"},
							{"5","民盟盟员"},
							{"6","民建会员"},
							{"7","民进会员"},
							{"8","农工党党员"},
							{"9","致公党党员"},
							{"10","九三学社社员"},
							{"11","台盟盟员"},
							{"12","无党派民主人士"},
							{"13","群众"}};
		String resultName = "";
		for(int i = 0 ; i < names.length ; i ++){
			if(names[i][0].equals(value)){
				resultName = names[i][1];
			}
		}
		return resultName;
	}
	
	/*
	 * 根据value值获得对应的政治面貌名称
	 */
	public String getDegreeNameByValue(String value){
		String [][] names = {{"xueshi","学士"},
							{"shoushi","硕士"},
							{"boshi","博士"}};
		String resultName = "";
		for(int i = 0 ; i < names.length ; i ++){
			if(names[i][0].equals(value)){
				resultName = names[i][1];
			}
		}
		return resultName;
	} 

	/**
	 * @Description 添加名录管理
	 * @param typeBean名录管理Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public String addType(DirectoryBean directoryBean) throws Exception {
		StringBuffer buf = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		
		buf.append("select SEQ_DIRECTORY_MANAGE.nextval from dual");
		db.preparedSelect(buf.toString());
		db.executePrepared();
		String new_directory_id = "";
		if(db.size()>0){
			new_directory_id = db.getString(0, 0);
		}else{
			return new_directory_id;
		}
		 buf.setLength(0);
		buf.append(" insert into ta_oa_directory_manage");
		buf.append(" (directoryid, ");
		buf.append(" directoryname, directoryyear, directorysex,directorystate,education,");
		buf.append("   degree, seniority,school, nation, politics,");
		buf.append("   natives,specialty, mobile, homeadress, workphone,");
		buf.append("  workadress, homephone, email, duty, resume,");
		buf.append("  orgid, orgname, duties, eng_name, idnumber,");
		buf.append("  worktime, joinparttime, post, directorylevel, department,directory_sn,mobile2,portalandoa_id,photo,dept_id,dept_name)");
		buf.append(" values(?, ?, ?, ?, ?, ?,");
		buf.append("?, ?, ?, ?, ?,");
		buf.append("?, ?, ?, ?, ?,");
		buf.append("?, ?, ?, ?, ?,");
		buf.append("?, ?, ?, ?, ?,");
		buf.append("?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)");
		
		db.preparedInsert(buf.toString());
		db.setString(1, new_directory_id);
		db.setString(2, directoryBean.getDirectoryname());
		db.setString(3, directoryBean.getDirectoryyear());
		db.setString(4, directoryBean.getDirectorysex());
		db.setString(5, directoryBean.getDirectorystate());
		db.setString(6, directoryBean.getEducation());
		
		db.setString(7, directoryBean.getDegree());
		db.setString(8, directoryBean.getSeniority());
		db.setString(9, directoryBean.getSchool());
		db.setString(10, directoryBean.getNation());
		db.setString(11, directoryBean.getPolitics());
		
		db.setString(12, directoryBean.getNatives());
		db.setString(13, directoryBean.getSpecialty());
		db.setString(14, directoryBean.getMobile());
		db.setString(15, directoryBean.getHomeadress());
		db.setString(16, directoryBean.getWorkphone());
		
		db.setString(17, directoryBean.getWorkadress());
		db.setString(18, directoryBean.getHomephone());
		db.setString(19, directoryBean.getEmail());
		db.setString(20, directoryBean.getDuty());
		db.setString(21, directoryBean.getResume());
		
		db.setString(22, directoryBean.getOrgid());
		db.setString(23, directoryBean.getOrgname());
		db.setString(24, directoryBean.getDuties());
		db.setString(25, PinyinUtil.hanziToPinyin(directoryBean.getDirectoryname()));
		db.setString(26, directoryBean.getIdnumber());
		
		db.setTimestamp(27, DateUtil.parseTimeString(directoryBean.getWorktime()));
		db.setTimestamp(28, DateUtil.parseTimeString(directoryBean.getJoinparttime()));
		db.setString(29, directoryBean.getPost());
		db.setString(30, directoryBean.getDirectorylevel());
		db.setString(31, directoryBean.getDepartment());
		
		db.setString(32, directoryBean.getDirectory_sn());
		db.setString(33, directoryBean.getMobile2());
		db.setString(34, directoryBean.getPortalandoa_id());
		db.setBlob(35, directoryBean.getPhoto());
		db.setString(36, directoryBean.getDeptId());
		db.setString(37, directoryBean.getDeptName());
		db.executePrepared();
		
		return new_directory_id;
	}
	
	/**
	 * @Description 添加名录管理
	 * @param typeBean名录管理Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addTypeCS(DirectoryBean directoryBean) throws Exception {
		StringBuffer buf = new StringBuffer();
		 
		buf.append(" insert into ta_oa_directory_manage_cs");
		buf.append(" (directoryid, ");
		buf.append(" directoryname, directoryyear, directorysex,directorystate,education,");
		buf.append("   degree, seniority,school, nation, politics,");
		buf.append("   natives,specialty, mobile, homeadress, workphone,");
		buf.append("  workadress, homephone, email, duty, resume,");
		buf.append("  org_code, orgname, duties, eng_name, idnumber,");
		buf.append("  worktime, joinparttime, post, directorylevel, department,directory_sn,mobile2,portalandoa_id,photo)");
		buf.append(" values(SEQ_DIRECTORY_MANAGE_CS.nextval, ?, ?, ?, ?, ?,");
		buf.append("?, ?, ?, ?, ?,");
		buf.append("?, ?, ?, ?, ?,");
		buf.append("?, ?, ?, ?, ?,");
		buf.append("?, ?, ?, ?, ?,");
		buf.append("?, ?, ?, ?, ?, ?, ?, ?, ?)");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(buf.toString());
		db.setString(1, directoryBean.getDirectoryname());
		db.setString(2, directoryBean.getDirectoryyear());
		db.setString(3, directoryBean.getDirectorysex());
		db.setString(4, directoryBean.getDirectorystate());
		db.setString(5, directoryBean.getEducation());
		
		db.setString(6, directoryBean.getDegree());
		db.setString(7, directoryBean.getSeniority());
		db.setString(8, directoryBean.getSchool());
		db.setString(9, directoryBean.getNation());
		db.setString(10, directoryBean.getPolitics());
		
		db.setString(11, directoryBean.getNatives());
		db.setString(12, directoryBean.getSpecialty());
		db.setString(13, directoryBean.getMobile());
		db.setString(14, directoryBean.getHomeadress());
		db.setString(15, directoryBean.getWorkphone());
		
		db.setString(16, directoryBean.getWorkadress());
		db.setString(17, directoryBean.getHomephone());
		db.setString(18, directoryBean.getEmail());
		db.setString(19, directoryBean.getDuty());
		db.setString(20, directoryBean.getResume());
		
		db.setString(21, directoryBean.getOrg_code());
		db.setString(22, directoryBean.getOrgname());
		db.setString(23, directoryBean.getDuties());
		db.setString(24, PinyinUtil.hanziToPinyin(directoryBean.getDirectoryname()));
		db.setString(25, directoryBean.getIdnumber());
		
		db.setTimestamp(26, DateUtil.parseTimeString(directoryBean.getWorktime()));
		db.setTimestamp(27, DateUtil.parseTimeString(directoryBean.getJoinparttime()));
		db.setString(28, directoryBean.getPost());
		db.setString(29, directoryBean.getDirectorylevel());
		db.setString(30, directoryBean.getDepartment());
		
		db.setString(31, directoryBean.getDirectory_sn());
		db.setString(32, directoryBean.getMobile2());
		db.setString(33, directoryBean.getPortalandoa_id());
		db.setBlob(34, directoryBean.getPhoto());
		db.executePrepared();
	}

	/**
	 * @Description 修改名录管理
	 * @param typeBean 名录管理Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateType(DirectoryBean typeBean) throws Exception {
		StringBuffer buf = new StringBuffer();
		StringBuffer buf1 = new StringBuffer();
        
        buf.append(" update ta_oa_directory_manage ");
        buf.append(" set  ");
        if(!StringUtil.nullOrBlank(typeBean.getDeptId())){
        	buf.append(" dept_name  = ?,dept_id = ?,");
        }
        else{
        	buf.append(" dept_name  = '',dept_id = '',");
        }
        if(!StringUtil.nullOrBlank(typeBean.getDirectoryname()))
        	buf.append(" directoryname  = ?,eng_name = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDirectoryyear()))
			buf.append(" directoryyear  = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDirectorysex()))
			buf.append(" directorysex   = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDirectorystate()))
			buf.append(" directorystate = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getEducation()))
			buf.append(" education      = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDegree()))
			buf.append(" degree         = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getSeniority()))
			buf.append(" seniority      = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getSchool()))
			buf.append(" school         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getNation()))
			buf.append(" nation         = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getPolitics()))
			buf.append(" politics       = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getNatives()))
			buf.append(" natives        = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getSpecialty()))
			buf.append(" specialty      = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getMobile()))
			buf.append(" mobile         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getMobile2()))
			buf.append(" mobile2         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getHomeadress()))
			buf.append(" homeadress     = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getWorkphone()))
			buf.append(" workphone      = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getWorkadress()))
			buf.append(" workadress     = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getHomephone()))
			buf.append(" homephone      = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getEmail()))
			buf.append(" email          = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDuty()))
			buf.append(" duty           = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getResume()))
			buf.append(" resume         = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getOrgid()))
			buf.append(" orgid          = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getOrgname()))
			buf.append(" orgname        = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDuties()))
			buf.append(" duties         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getIdnumber()))
			buf.append(" idnumber          = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getWorktime()))
			buf.append(" worktime           = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getJoinparttime()))
			buf.append(" joinparttime         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getPost()))
			buf.append(" post          = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDirectorylevel())){
			buf.append(" directorylevel        = ?,");
		//}
		//if(!StringUtil.nullOrBlank(typeBean.getDepartment()))
		    buf.append(" department         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDirectory_sn()))
			buf.append(" directory_sn = ?,");
		if(null != typeBean.getPhoto())
			buf.append(" photo = ?,");
		buf1.append(buf.substring(0, buf.length()-1));
		if(!StringUtil.nullOrBlank(typeBean.getDirectoryid()))
			buf1.append(" where directoryid = ? ");

		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(buf1.toString());
		int a = 1;
		if(!StringUtil.nullOrBlank(typeBean.getDeptId())){
			db.setString(a++, typeBean.getDeptName());
			db.setString(a++, typeBean.getDeptId());
		}
		if(!StringUtil.nullOrBlank(typeBean.getDirectoryname())){
			db.setString(a++, typeBean.getDirectoryname());
			db.setString(a++, PinyinUtil.hanziToPinyin(typeBean.getDirectoryname()));
		}
		//if(!StringUtil.nullOrBlank(typeBean.getDirectoryyear()))
			db.setString(a++, typeBean.getDirectoryyear());
		if(!StringUtil.nullOrBlank(typeBean.getDirectorysex()))
			db.setString(a++, typeBean.getDirectorysex());
		if(!StringUtil.nullOrBlank(typeBean.getDirectorystate()))
			db.setString(a++, typeBean.getDirectorystate());
		if(!StringUtil.nullOrBlank(typeBean.getEducation()))
			db.setString(a++, typeBean.getEducation());
		if(!StringUtil.nullOrBlank(typeBean.getDegree()))
			db.setString(a++, typeBean.getDegree());
		if(!StringUtil.nullOrBlank(typeBean.getSeniority()))
			db.setString(a++, typeBean.getSeniority());
		//if(!StringUtil.nullOrBlank(typeBean.getSchool()))
			db.setString(a++, typeBean.getSchool());
		//if(!StringUtil.nullOrBlank(typeBean.getNation()))
			db.setString(a++, typeBean.getNation());
		if(!StringUtil.nullOrBlank(typeBean.getPolitics()))
			db.setString(a++, typeBean.getPolitics());
		//if(!StringUtil.nullOrBlank(typeBean.getNatives()))
			db.setString(a++, typeBean.getNatives());
		if(!StringUtil.nullOrBlank(typeBean.getSpecialty()))
			db.setString(a++, typeBean.getSpecialty());
		if(!StringUtil.nullOrBlank(typeBean.getMobile()))
			db.setString(a++, typeBean.getMobile());
		//if(!StringUtil.nullOrBlank(typeBean.getMobile2()))
			db.setString(a++, typeBean.getMobile2());
		//if(!StringUtil.nullOrBlank(typeBean.getHomeadress()))
			db.setString(a++, typeBean.getHomeadress());
		//if(!StringUtil.nullOrBlank(typeBean.getWorkphone()))
			db.setString(a++, typeBean.getWorkphone());
		//if(!StringUtil.nullOrBlank(typeBean.getWorkadress()))
			db.setString(a++, typeBean.getWorkadress());
		//if(!StringUtil.nullOrBlank(typeBean.getHomephone()))
			db.setString(a++, typeBean.getHomephone());
		//if(!StringUtil.nullOrBlank(typeBean.getEmail()))
			db.setString(a++, typeBean.getEmail());
		//if(!StringUtil.nullOrBlank(typeBean.getDuty()))
			db.setString(a++, typeBean.getDuty());
		//if(!StringUtil.nullOrBlank(typeBean.getResume()))
			db.setString(a++, typeBean.getResume());
		if(!StringUtil.nullOrBlank(typeBean.getOrgid()))
			db.setString(a++, typeBean.getOrgid());
		if(!StringUtil.nullOrBlank(typeBean.getOrgname()))
			db.setString(a++, typeBean.getOrgname());
		if(!StringUtil.nullOrBlank(typeBean.getDuties()))
			db.setString(a++, typeBean.getDuties());
		//if(!StringUtil.nullOrBlank(typeBean.getIdnumber()))
			db.setString(a++, typeBean.getIdnumber());
		//if(!StringUtil.nullOrBlank(typeBean.getWorktime()))
			db.setTimestamp(a++, DateUtil.parseTimeString(typeBean.getWorktime()));
		//if(!StringUtil.nullOrBlank(typeBean.getJoinparttime()))
			db.setTimestamp(a++, DateUtil.parseTimeString(typeBean.getJoinparttime()));
		//if(!StringUtil.nullOrBlank(typeBean.getPost()))
			db.setString(a++, typeBean.getPost());
		//if(!StringUtil.nullOrBlank(typeBean.getDirectorylevel()))
			db.setString(a++, typeBean.getDirectorylevel());
		//if(!StringUtil.nullOrBlank(typeBean.getDepartment()))
			db.setString(a++, typeBean.getDepartment());
		//if(!StringUtil.nullOrBlank(typeBean.getDirectory_sn()))
			db.setString(a++, typeBean.getDirectory_sn());
		if(null != typeBean.getPhoto())
			db.setBlob(a++, typeBean.getPhoto());
		if(!StringUtil.nullOrBlank(typeBean.getDirectoryid()))
			db.setString(a++, typeBean.getDirectoryid());

		db.executePrepared();
	}
	
	/**
	 * @Description 修改名录管理根据身份证（用于数据传输）
	 * @param typeBean 名录管理Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateTypeByIdNum(DirectoryBean typeBean) throws Exception {
		StringBuffer buf = new StringBuffer();
		StringBuffer buf1 = new StringBuffer();
        
        buf.append(" update ta_oa_directory_manage ");
        buf.append(" set  ");
        
        if(!StringUtil.nullOrBlank(typeBean.getDirectoryname()))
        	buf.append(" directoryname  = ?,eng_name = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDirectoryyear()))
			buf.append(" directoryyear  = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDirectorysex()))
			buf.append(" directorysex   = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDirectorystate()))
			buf.append(" directorystate = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getEducation()))
			buf.append(" education      = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDegree()))
			buf.append(" degree         = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getSeniority()))
			buf.append(" seniority      = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getSchool()))
			buf.append(" school         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getNation()))
			buf.append(" nation         = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getPolitics()))
			buf.append(" politics       = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getNatives()))
			buf.append(" natives        = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getSpecialty()))
			buf.append(" specialty      = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getMobile()))
			buf.append(" mobile         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getMobile2()))
			buf.append(" mobile2         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getHomeadress()))
			buf.append(" homeadress     = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getWorkphone()))
			buf.append(" workphone      = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getWorkadress()))
			buf.append(" workadress     = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getHomephone()))
			buf.append(" homephone      = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getEmail()))
			buf.append(" email          = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDuty()))
			buf.append(" duty           = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getResume()))
			buf.append(" resume         = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getOrgid()))
			buf.append(" orgid          = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getOrgname()))
			buf.append(" orgname        = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDuties()))
			buf.append(" duties         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getIdnumber()))
			buf.append(" idnumber          = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getWorktime()))
			buf.append(" worktime           = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getJoinparttime()))
			buf.append(" joinparttime         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getPost()))
			buf.append(" post          = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDirectorylevel())){
			buf.append(" directorylevel        = ?,");
		//}
		//if(!StringUtil.nullOrBlank(typeBean.getDepartment()))
		    buf.append(" department         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDirectory_sn()))
			buf.append(" directory_sn = ?,");
		if(null != typeBean.getPhoto())
			buf.append(" photo = ?,");
		buf1.append(buf.substring(0, buf.length()-1));
		if(!StringUtil.nullOrBlank(typeBean.getPortalandoa_id()))
			buf1.append(" where portalandoa_id = ? ");

		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(buf1.toString());
		int a = 1;
		if(!StringUtil.nullOrBlank(typeBean.getDirectoryname())){
			db.setString(a++, typeBean.getDirectoryname());
			db.setString(a++, PinyinUtil.hanziToPinyin(typeBean.getDirectoryname()));
		}
		//if(!StringUtil.nullOrBlank(typeBean.getDirectoryyear()))
			db.setString(a++, typeBean.getDirectoryyear());
		if(!StringUtil.nullOrBlank(typeBean.getDirectorysex()))
			db.setString(a++, typeBean.getDirectorysex());
		if(!StringUtil.nullOrBlank(typeBean.getDirectorystate()))
			db.setString(a++, typeBean.getDirectorystate());
		if(!StringUtil.nullOrBlank(typeBean.getEducation()))
			db.setString(a++, typeBean.getEducation());
		if(!StringUtil.nullOrBlank(typeBean.getDegree()))
			db.setString(a++, typeBean.getDegree());
		if(!StringUtil.nullOrBlank(typeBean.getSeniority()))
			db.setString(a++, typeBean.getSeniority());
		//if(!StringUtil.nullOrBlank(typeBean.getSchool()))
			db.setString(a++, typeBean.getSchool());
		//if(!StringUtil.nullOrBlank(typeBean.getNation()))
			db.setString(a++, typeBean.getNation());
		if(!StringUtil.nullOrBlank(typeBean.getPolitics()))
			db.setString(a++, typeBean.getPolitics());
		//if(!StringUtil.nullOrBlank(typeBean.getNatives()))
			db.setString(a++, typeBean.getNatives());
		if(!StringUtil.nullOrBlank(typeBean.getSpecialty()))
			db.setString(a++, typeBean.getSpecialty());
		if(!StringUtil.nullOrBlank(typeBean.getMobile()))
			db.setString(a++, typeBean.getMobile());
		//if(!StringUtil.nullOrBlank(typeBean.getMobile2()))
			db.setString(a++, typeBean.getMobile2());
		//if(!StringUtil.nullOrBlank(typeBean.getHomeadress()))
			db.setString(a++, typeBean.getHomeadress());
		//if(!StringUtil.nullOrBlank(typeBean.getWorkphone()))
			db.setString(a++, typeBean.getWorkphone());
		//if(!StringUtil.nullOrBlank(typeBean.getWorkadress()))
			db.setString(a++, typeBean.getWorkadress());
		//if(!StringUtil.nullOrBlank(typeBean.getHomephone()))
			db.setString(a++, typeBean.getHomephone());
		//if(!StringUtil.nullOrBlank(typeBean.getEmail()))
			db.setString(a++, typeBean.getEmail());
		//if(!StringUtil.nullOrBlank(typeBean.getDuty()))
			db.setString(a++, typeBean.getDuty());
		//if(!StringUtil.nullOrBlank(typeBean.getResume()))
			db.setString(a++, typeBean.getResume());
		if(!StringUtil.nullOrBlank(typeBean.getOrgid()))
			db.setString(a++, typeBean.getOrgid());
		if(!StringUtil.nullOrBlank(typeBean.getOrgname()))
			db.setString(a++, typeBean.getOrgname());
		if(!StringUtil.nullOrBlank(typeBean.getDuties()))
			db.setString(a++, typeBean.getDuties());
		//if(!StringUtil.nullOrBlank(typeBean.getIdnumber()))
			db.setString(a++, typeBean.getIdnumber());
		//if(!StringUtil.nullOrBlank(typeBean.getWorktime()))
			db.setTimestamp(a++, DateUtil.parseTimeString(typeBean.getWorktime()));
		//if(!StringUtil.nullOrBlank(typeBean.getJoinparttime()))
			db.setTimestamp(a++, DateUtil.parseTimeString(typeBean.getJoinparttime()));
		//if(!StringUtil.nullOrBlank(typeBean.getPost()))
			db.setString(a++, typeBean.getPost());
		//if(!StringUtil.nullOrBlank(typeBean.getDirectorylevel()))
			db.setString(a++, typeBean.getDirectorylevel());
		//if(!StringUtil.nullOrBlank(typeBean.getDepartment()))
			db.setString(a++, typeBean.getDepartment());
		//if(!StringUtil.nullOrBlank(typeBean.getDirectory_sn()))
			db.setString(a++, typeBean.getDirectory_sn());
		if(null != typeBean.getPhoto())
			db.setBlob(a++, typeBean.getPhoto());
		if(!StringUtil.nullOrBlank(typeBean.getPortalandoa_id()))
			db.setString(a++, typeBean.getPortalandoa_id());

		db.executePrepared();
	}
	
	/**
	 * @Description 修改名录管理根据身份证（用于数据传输）(数据传输表)
	 * @param typeBean 名录管理Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateTypeCSByIdNum(DirectoryBean typeBean) throws Exception {
		StringBuffer buf = new StringBuffer();
		StringBuffer buf1 = new StringBuffer();
        
        buf.append(" update ta_oa_directory_manage_cs ");
        buf.append(" set  ");
        
        if(!StringUtil.nullOrBlank(typeBean.getDirectoryname()))
        	buf.append(" directoryname  = ?,eng_name = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDirectoryyear()))
			buf.append(" directoryyear  = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDirectorysex()))
			buf.append(" directorysex   = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDirectorystate()))
			buf.append(" directorystate = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getEducation()))
			buf.append(" education      = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDegree()))
			buf.append(" degree         = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getSeniority()))
			buf.append(" seniority      = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getSchool()))
			buf.append(" school         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getNation()))
			buf.append(" nation         = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getPolitics()))
			buf.append(" politics       = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getNatives()))
			buf.append(" natives        = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getSpecialty()))
			buf.append(" specialty      = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getMobile()))
			buf.append(" mobile         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getMobile2()))
			buf.append(" mobile2         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getHomeadress()))
			buf.append(" homeadress     = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getWorkphone()))
			buf.append(" workphone      = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getWorkadress()))
			buf.append(" workadress     = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getHomephone()))
			buf.append(" homephone      = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getEmail()))
			buf.append(" email          = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDuty()))
			buf.append(" duty           = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getResume()))
			buf.append(" resume         = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getOrgid()))
			buf.append(" org_code          = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getOrgname()))
			buf.append(" orgname        = ?,");
		if(!StringUtil.nullOrBlank(typeBean.getDuties()))
			buf.append(" duties         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getIdnumber()))
			buf.append(" idnumber          = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getWorktime()))
			buf.append(" worktime           = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getJoinparttime()))
			buf.append(" joinparttime         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getPost()))
			buf.append(" post          = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDirectorylevel())){
			buf.append(" directorylevel        = ?,");
		//}
		//if(!StringUtil.nullOrBlank(typeBean.getDepartment()))
		    buf.append(" department         = ?,");
		//if(!StringUtil.nullOrBlank(typeBean.getDirectory_sn()))
			buf.append(" directory_sn = ?,");
		if(null != typeBean.getPhoto())
			buf.append(" photo = ?,");
		buf1.append(buf.substring(0, buf.length()-1));
		if(!StringUtil.nullOrBlank(typeBean.getPortalandoa_id()))
			buf1.append(" where portalandoa_id = ? ");

		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(buf1.toString());
		int a = 1;
		if(!StringUtil.nullOrBlank(typeBean.getDirectoryname())){
			db.setString(a++, typeBean.getDirectoryname());
			db.setString(a++, PinyinUtil.hanziToPinyin(typeBean.getDirectoryname()));
		}
		//if(!StringUtil.nullOrBlank(typeBean.getDirectoryyear()))
			db.setString(a++, typeBean.getDirectoryyear());
		if(!StringUtil.nullOrBlank(typeBean.getDirectorysex()))
			db.setString(a++, typeBean.getDirectorysex());
		if(!StringUtil.nullOrBlank(typeBean.getDirectorystate()))
			db.setString(a++, typeBean.getDirectorystate());
		if(!StringUtil.nullOrBlank(typeBean.getEducation()))
			db.setString(a++, typeBean.getEducation());
		if(!StringUtil.nullOrBlank(typeBean.getDegree()))
			db.setString(a++, typeBean.getDegree());
		if(!StringUtil.nullOrBlank(typeBean.getSeniority()))
			db.setString(a++, typeBean.getSeniority());
		//if(!StringUtil.nullOrBlank(typeBean.getSchool()))
			db.setString(a++, typeBean.getSchool());
		//if(!StringUtil.nullOrBlank(typeBean.getNation()))
			db.setString(a++, typeBean.getNation());
		if(!StringUtil.nullOrBlank(typeBean.getPolitics()))
			db.setString(a++, typeBean.getPolitics());
		//if(!StringUtil.nullOrBlank(typeBean.getNatives()))
			db.setString(a++, typeBean.getNatives());
		if(!StringUtil.nullOrBlank(typeBean.getSpecialty()))
			db.setString(a++, typeBean.getSpecialty());
		if(!StringUtil.nullOrBlank(typeBean.getMobile()))
			db.setString(a++, typeBean.getMobile());
		//if(!StringUtil.nullOrBlank(typeBean.getMobile2()))
			db.setString(a++, typeBean.getMobile2());
		//if(!StringUtil.nullOrBlank(typeBean.getHomeadress()))
			db.setString(a++, typeBean.getHomeadress());
		//if(!StringUtil.nullOrBlank(typeBean.getWorkphone()))
			db.setString(a++, typeBean.getWorkphone());
		//if(!StringUtil.nullOrBlank(typeBean.getWorkadress()))
			db.setString(a++, typeBean.getWorkadress());
		//if(!StringUtil.nullOrBlank(typeBean.getHomephone()))
			db.setString(a++, typeBean.getHomephone());
		//if(!StringUtil.nullOrBlank(typeBean.getEmail()))
			db.setString(a++, typeBean.getEmail());
		//if(!StringUtil.nullOrBlank(typeBean.getDuty()))
			db.setString(a++, typeBean.getDuty());
		//if(!StringUtil.nullOrBlank(typeBean.getResume()))
			db.setString(a++, typeBean.getResume());
		if(!StringUtil.nullOrBlank(typeBean.getOrgid()))
			db.setString(a++, typeBean.getOrgid());
		if(!StringUtil.nullOrBlank(typeBean.getOrgname()))
			db.setString(a++, typeBean.getOrgname());
		if(!StringUtil.nullOrBlank(typeBean.getDuties()))
			db.setString(a++, typeBean.getDuties());
		//if(!StringUtil.nullOrBlank(typeBean.getIdnumber()))
			db.setString(a++, typeBean.getIdnumber());
		//if(!StringUtil.nullOrBlank(typeBean.getWorktime()))
			db.setTimestamp(a++, DateUtil.parseTimeString(typeBean.getWorktime()));
		//if(!StringUtil.nullOrBlank(typeBean.getJoinparttime()))
			db.setTimestamp(a++, DateUtil.parseTimeString(typeBean.getJoinparttime()));
		//if(!StringUtil.nullOrBlank(typeBean.getPost()))
			db.setString(a++, typeBean.getPost());
		//if(!StringUtil.nullOrBlank(typeBean.getDirectorylevel()))
			db.setString(a++, typeBean.getDirectorylevel());
		//if(!StringUtil.nullOrBlank(typeBean.getDepartment()))
			db.setString(a++, typeBean.getDepartment());
		//if(!StringUtil.nullOrBlank(typeBean.getDirectory_sn()))
			db.setString(a++, typeBean.getDirectory_sn());
		if(null != typeBean.getPhoto())
			db.setBlob(a++, typeBean.getPhoto());
		if(!StringUtil.nullOrBlank(typeBean.getPortalandoa_id()))
			db.setString(a++, typeBean.getPortalandoa_id());

		db.executePrepared();
	}
	
	/**
	 * @Description  删除名录管理
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delType(String userIds) throws SQLException {
		String sql = "delete from ta_oa_directory_manage where directoryid in ("+ userIds + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;
	}

	@Override
	public boolean delTypeByPortalandoa_id(String portalandoaId)
			throws SQLException {
		String sql = "delete from ta_oa_directory_manage where portalandoa_id = '"+ portalandoaId + "'";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;
	}

	@Override
	public boolean delTypeCsByPortalandoa_id(String portalandoaId)
			throws SQLException {
		String sql = "delete from ta_oa_directory_manage_cs where portalandoa_id = '"+ portalandoaId + "'";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;
	}

	/**
	 * @Description 根据名录管理ID获得名录管理
	 * @param typeBean 类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public DirectoryBean getTypeBeanById(String id,String listtype) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("select ");
		sql.append(" USER_IDCARD ,USER_REALNAME,decode(USER_SEX,'M','男','F','女','未知')as user_sex,USER_BIRTHDAY ,");
		sql.append("   u.POLITICS ,DUTIES,DIRECTORYLEVEL,EDUCATION,SCHOOL,DEGREE,WORKTIME,JOINPARTTIME,DIRECTORYSTATE  ,");
		sql.append(" USER_MOBILETEL2,USER_MOBILETEL1,USER_WORKNUMBER,USER_WORKTEL ,");
		sql.append(" HOMEADRESS,USER_HOMETEL,USER_EMAIL ,REMARK2,u.*");
		/*sql.append(" m.directoryid, m.directoryname, m.directoryyear, m.directorysex,");
		sql.append(" m.directorystate, m.education, m.degree, m.seniority,");
		sql.append(" m.school, m.nation, m.politics, m.natives,");
		sql.append(" m.specialty, m.mobile, m.homeadress, m.workphone,");
		sql.append(" m.workadress, m.homephone, m.email, m.duty,");
		sql.append(" m.resume, m.orgid, m.orgname, m.duties, ");
		sql.append(" m.idnumber, m.worktime, m.joinparttime, m.post, m.directorylevel, m.department, m.directory_sn, m.mobile2,m.dept_name,m.dept_id");
		sql.append(" from ta_oa_directory_manage m");
		sql.append(" where directoryid=? ");*/
		sql.append("  from td_sm_user m ");
		sql.append(" left join ta_oa_userandsn u on m.user_id = u.userid ");
		sql.append(" where user_id =? ");
		PreparedDBUtil db = new PreparedDBUtil();
		DirectoryBean ab = new DirectoryBean();
		db.preparedSelect(sql.toString()); 
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			ab.setDirectoryid(db.getString(i, "directoryid"));
	    	ab.setDirectoryname(db.getString(i, "USER_REALNAME"));
	    	ab.setDirectoryyear(DateUtil.GetTimeString(db.getTimestamp(i, "USER_BIRTHDAY")));
	    	ab.setDirectorysex(db.getString(i, "USER_SEX"));
	    	
	    	ab.setDirectorystate(db.getString(i, "directorystate"));
	    	
	    	if("view".equals(listtype)){
	    		//ab.setDegree(getDegreeNameByValue(db.getString(i, "degree")));
		    	ab.setEducation(getEducationNameByValue(db.getString(i, "education")));
		    	ab.setPolitics(getPoliticsNameByValue(db.getString(i, "politics")));
	    	}else{
	    		//ab.setDegree(db.getString(i, "degree"));
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
	    	
	    	ab.setWorkadress(db.getString(i, "USER_WORKNUMBER"));
	    	ab.setHomephone(db.getString(i, "USER_HOMETEL"));
	    	ab.setEmail(db.getString(i, "USER_EMAIL"));
	    	ab.setDuty(db.getString(i, "duty"));
	    	
	    	ab.setResume(db.getString(i, "resume"));
	    	ab.setOrgid(db.getString(i, "orgid"));
	    	ab.setOrgname(db.getString(i, "orgname"));
	    	ab.setDuties(db.getString(i, "duties"));
	    	
	    	ab.setIdnumber(db.getString(i, "USER_IDCARD"));
	    	ab.setWorktime(DateUtil.GetTimeString(db.getTimestamp(i, "worktime")));
	    	ab.setJoinparttime(DateUtil.GetTimeString(db.getTimestamp(i, "joinparttime")));
	    	ab.setPost(db.getString(i, "DUTIES"));
	    	ab.setDirectorylevel(db.getString(i, "directorylevel"));
	    	ab.setDepartment(db.getString(i, "department"));
	    	
	    	ab.setDirectory_sn(db.getString(i, "directory_sn"));
	    	
	    	ab.setNumberone(db.getString(i, "numberone"));
	    	
	    	ab.setDeptName(db.getString(i, "dept_name"));
	    	ab.setDeptId(db.getString(i, "dept_id"));
	    	//教育考试院手机短码
	    	ab.setRemark2(db.getString(i, "remark2"));
		}
		return ab;
	}

	@Override
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid)
			throws Exception {
		List<ListShowUtilBean> list = new ArrayList<ListShowUtilBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		String firstCodeAreaStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuffer sql = new StringBuffer();

		if (StringUtil.nullOrBlank(orgoruserid)) {
			try {
				String org_id = DaoUtil
						.SqlToField("select o.org_id from td_sm_organization o where o.parent_id = '0' ");
				orgoruserid = org_id;
			} catch (SQLException e) {
				LOG.info(e.getMessage());
			}
		}
		sql.setLength(0);
		sql.append("select t.user_id from td_sm_user t  left join td_sm_orguser u on u.user_id =t.user_id where t.user_name like ? ");
		if(!StringUtil.nullOrBlank(orgoruserid)){
			sql.append(" and exists(select 1 from (select a.org_id ");
			sql.append("		  from td_sm_organization a ");
			sql.append("		connect by prior a.org_id = a.parent_id ");
			sql.append("		 start with a.org_id = ?) o where o.org_id = u.org_id ");
			sql.append("		 )  ");
		}
		for(int i = 0 ; i < firstCodeAreaStr.length() ; i++){
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, String.valueOf(firstCodeAreaStr.charAt(i)).toLowerCase()+"%");
			if(!StringUtil.nullOrBlank(orgoruserid)){
				pdb.setString(2, orgoruserid);
			}
			pdb.executePrepared();
			ListShowUtilBean bean = new ListShowUtilBean();
			bean.setFirstCode(String.valueOf(firstCodeAreaStr.charAt(i)));
			if(!StringUtil.nullOrBlank(orgoruserid) && pdb.size() > 0)
				bean.setExsit(true);
			else
				bean.setExsit(false);
			list.add(bean);
		}
		
		return list;
	}
	
	private static final String DEL_USERORDERBY = "delete from ta_oa_userorderby a where a.dept_id=?";
	private static final String INSERT_USERORDERBY = "insert into ta_oa_userorderby A (A.DEPT_ID,A.USER_ID,A.ORDERBY) values(?,?,?)";
	public static String insertUserOrderBy(String orgId,String userids,String orderBys){
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedDelete(DEL_USERORDERBY);
			pdb.setString(1, orgId);
			pdb.addPreparedBatch();
			if(null != userids && !"".equals(userids)){
				String[] userArray = userids.split(",");
				String[] orderArray = orderBys.split(",");
				for(int i = 0;i < userArray.length;i++){
					pdb.preparedInsert(INSERT_USERORDERBY);
					pdb.setString(1, orgId);
					pdb.setString(2, userArray[i]);
					pdb.setString(3, orderArray[i]);
					pdb.addPreparedBatch();
				}
				pdb.executePreparedBatch();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	
	
	
	
	/**
	 * @Description 管理员修改用户信息
	 * @param UserinfoBean 用户信息封装Bean
	 * @return void
	 * @throws SQLException 
	 */
	public void updateUserinfo(UserinfoBean userinfoBean) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		TransactionManager tm = new TransactionManager();
		int i = 1;
		int j = 1;
		try {
			tm.begin();
			sql.append("  update td_sm_user set ");
			sql.append("       USER_IDCARD=?,");
			sql.append("       USER_REALNAME=?,");
			sql.append("       USER_SEX=?,");
			sql.append("       USER_BIRTHDAY = to_date(?,'yyyy-mm-dd'),");
			sql.append("       USER_MOBILETEL1=?,");
			sql.append("       USER_MOBILETEL2=?,");
			sql.append("       USER_EMAIL=?,");
			sql.append("       USER_HOMETEL=?,");
			sql.append("       USER_WORKTEL=?");
			sql.append(" where user_id = ? ");
			pdb.preparedUpdate(sql.toString());
			pdb.setString(j++, userinfoBean.getUserIdcard());
			pdb.setString(j++, userinfoBean.getUserRealname());
			pdb.setString(j++, userinfoBean.getUserSex());
			pdb.setString(j++, userinfoBean.getUserBirthday());
			pdb.setString(j++, userinfoBean.getUserMobiletel1());
			pdb.setString(j++, userinfoBean.getUserMobiletel2());
			pdb.setString(j++, userinfoBean.getMail());
			pdb.setString(j++, userinfoBean.getHomePhone());
			pdb.setString(j++, userinfoBean.getUserWorktel());
			pdb.setString(j++, userinfoBean.getUserid());
			pdb.executePrepared();
			if(!queryuser(userinfoBean.getUserid())){
				insertuser(userinfoBean.getUserid());
			}
			sql2.append("  update ta_oa_userandsn set ");
			sql2.append("  directorystate = ?, education = ?, degree = ?, politics = ?, ");
			sql2.append("  school = ?,nation = ?,natives = ?, ");
			sql2.append("  homeadress = ?,joinparttime = to_date(?,'yyyy-mm-dd'),worktime = to_date(?,'yyyy-mm-dd'),duties = ?,directorylevel = ? ,");
			sql2.append("  duty = ?,resume= ?,numberone=?  ");
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
			db.setString(i++, userinfoBean.getDuty());
			db.setString(i++, userinfoBean.getResume());
			db.setString(i++, userinfoBean.getNumberOne());
			db.setString(i++, userinfoBean.getUserid());
			db.executePrepared();
			tm.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tm.rollback();
		}
	}

	/**
	 * 查询查询用户是否在ta_oa_userandsn表中就记录
	 * @return 存在返回true,否则返回false
	 * @param usreid
	 * @throws Exception
	 */
	public boolean queryuser(String userid) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		boolean flag=false;
		sql.append("	select sn.id from ta_oa_userandsn sn");
		sql.append("	where sn.userid="+userid+" ");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			if(pdb.size()>0){
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/**
	 * 往ta_oa_userandsn中插入一条扩展记录
	 * @param usreid
	 * @throws Exception
	 */
	public void insertuser(String userid) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		sql.append(" insert into ta_oa_userandsn s (id,userid) values(seq_oa_userandsn.nextval,"+userid+")");
		try{
			pdb.preparedInsert(sql.toString());
			pdb.executePrepared();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 	刘为玮2013-04-24修改
	  * <b>Summary: </b>
	  *     复写方法 Insertimg
	  * @param imgsrc
	  * @param imgid
	  * @return 
	  * @see com.chinacreator.xtbg.pub.directory.dao.DirectoryDao#Insertimg(java.lang.String, java.lang.String)
	 */
	public String Insertimg(String imgsrc, String imgid) {
		String res = "上传成功";
		String sql ="insert into wc_oa_user_image(image_id,image_parth,image_yewu_id) " +
				"values(seq_wc_oa_user_image.Nextval,?,?)";
		PreparedDBUtil db = new PreparedDBUtil();
		try {
			delCarImg(imgid);
			db.preparedInsert(sql.toString());
			db.setString(1, StringUtil.deNull(imgsrc));
			db.setString(2, StringUtil.deNull(imgid));
			db.executePrepared();
		} catch (Exception e) {
			e.printStackTrace();
			return res="上传失败";
		}
		return res;
	}
	/**
	 * @Description 根据车辆Photoid删除关联图片
	 * @param imgsrc
	 * @return boolean
	 * @throws SQLException 
	 */
	
	public void delCarImg(String imgid)
	{
		String sql="delete wc_oa_user_image t where t.image_yewu_id in("+imgid+")";
		PreparedDBUtil  db = new PreparedDBUtil ();
		try {
			db.executeDelete(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateUserinfowc
	  * @param user
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.pub.directory.dao.DirectoryDao#updateUserinfowc(com.chinacreator.sysmgrcore.entity.User)
	 */
	public void updateUserinfowc(User user) throws Exception {
		TransactionManager tm = new TransactionManager();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		StringBuffer sql1=new StringBuffer();
		try {
		tm.begin();
		sql.append("  update td_sm_user u");
		sql.append("  set u.user_realname=?,");
		sql.append("  u.user_sex=?,");
		sql.append("  u.user_hometel=?,");
		sql.append("  u.user_worktel=?,");
		sql.append("  u.user_mobiletel1=?,");
		sql.append("  u.user_fax=?,");
		sql.append("  u.user_birthday=to_date(?,'yyyy-mm-dd'),");
		sql.append("  u.user_email=?,");
		sql.append("  u.user_postalcode=?,");
		sql.append("  u.user_idcard=?,");
		sql.append("  u.user_address=?");
		sql.append("  where u.user_id=?  "); 
		pdb.preparedUpdate(sql.toString());
		int i=1;
		pdb.setString(i++, user.getUserRealname());
		pdb.setString(i++, user.getUserSex());
		pdb.setString(i++, user.getUserHometel());
		pdb.setString(i++, user.getUserWorktel());
		pdb.setString(i++, user.getUserMobiletel1());
		pdb.setString(i++, user.getUser_fax());
		pdb.setString(i++, user.getUserAndSn().getBirthday());
		pdb.setString(i++, user.getUser_email());
		pdb.setString(i++, user.getUserPostalcode());
		pdb.setString(i++, user.getUserIdcard());
		pdb.setString(i++, user.getUserAddress());
		pdb.setString(i++, user.getUser_id());
		pdb.executePrepared();
		sql1.append("	update ta_oa_userandsn us");
		sql1.append("  	set us.education = ?,");
		sql1.append("    us.degree = ?,");
		sql1.append("   us.school = ?,");
		sql1.append("   us.nation = ?,");
		sql1.append("   us.politics=? ,");
		sql1.append("   us.natives = ?,");
		sql1.append("   us.specialty=?,");
		sql1.append("   us.resume=?,");
		sql1.append("   us.oldusername=?,");
		sql1.append("   us.worktime=to_date(?,'yyyy-mm-dd'),");
		sql1.append("   us.jointime=to_date(?,'yyyy-mm-dd'),");
		sql1.append("   us.nativesaddress=?,");
		sql1.append("   us.userfilespace=?,");
		sql1.append("   us.languagetype=?,");
		sql1.append("   us.languagelevel=?,");
		sql1.append("   us.familymembers=?,");
		sql1.append("   us.jcrecord=?,");
		sql1.append("    us.pxrecord=?,");
		sql1.append("   us.certificate=?,");
		sql1.append("   us.remark=?,");
		sql1.append("   us.attachmentid=?,");
		sql1.append("   us.picid=?,");
		sql1.append("   us.duties=?,");
		sql1.append("   us.ismarry=?,");
		sql1.append("   us.titles=?,");
		sql1.append("   us.usernumber=?,");
		sql1.append("   us.usertype=?,");
		sql1.append("   us.titletype=?,");
		sql1.append("   us.health_state=?,");
		sql1.append("   us.blood_type=?,");
		sql1.append("   us.stature=?,");
		sql1.append("   us.vision=? ");
		sql1.append("	where us.userid=?  ");
		pdb.preparedUpdate(sql1.toString());
		int j=1;
		pdb.setString(j++, user.getUserAndSn().getEducation());
		pdb.setString(j++, user.getUserAndSn().getDegree());
		pdb.setString(j++, user.getUserAndSn().getSchool());
		pdb.setString(j++, user.getUserAndSn().getNation());
		pdb.setString(j++, user.getUserAndSn().getPolitics());
		pdb.setString(j++, user.getUserAndSn().getNatives());
		pdb.setString(j++, user.getUserAndSn().getSpecialty());
		pdb.setString(j++, user.getUserAndSn().getResume());
		pdb.setString(j++, user.getUserAndSn().getOldusername());
		pdb.setString(j++, user.getUserAndSn().getWorktime());
		pdb.setString(j++, user.getUserAndSn().getJointime());
		pdb.setString(j++, user.getUserAndSn().getNativesaddress());
		pdb.setString(j++, user.getUserAndSn().getUserfilespace());
		pdb.setString(j++, user.getUserAndSn().getLanguagetype());
		pdb.setString(j++, user.getUserAndSn().getLanguagelevel());
		pdb.setString(j++, user.getUserAndSn().getFamilymembers());
		pdb.setString(j++, user.getUserAndSn().getJcrecord());
		pdb.setString(j++, user.getUserAndSn().getPxrecord());
		pdb.setString(j++, user.getUserAndSn().getCertificate());
		pdb.setString(j++, user.getUserAndSn().getRemark());
		pdb.setString(j++, user.getUserAndSn().getAttachmentid());
		pdb.setString(j++, user.getUserAndSn().getPicid());
		pdb.setString(j++, user.getUserAndSn().getDuties());
		pdb.setString(j++, user.getUserAndSn().getIsmarry());
		pdb.setString(j++, user.getUserAndSn().getTitles());
		pdb.setString(j++, user.getUserAndSn().getUsernumber());
		pdb.setString(j++, user.getUserAndSn().getUsertype());
		pdb.setString(j++, user.getUserAndSn().getTitletype());
		pdb.setString(j++, user.getUserAndSn().getHealth_state());
		pdb.setString(j++, user.getUserAndSn().getBlood_type());
		pdb.setString(j++, user.getUserAndSn().getStature());
		pdb.setString(j++, user.getUserAndSn().getVision());
		pdb.setString(j++, user.getUser_id());
		pdb.executePrepared();
		tm.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tm.rollback();
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getuserinfo
	  * @param id
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.pub.directory.dao.DirectoryDao#getuserinfo(java.lang.String)
	 */
	public User getuserinfo(String id) throws SQLException {
		String areacode = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		User user=new User();
		UserAndSn userAndSn=new UserAndSn();
		sql.append(" select u.user_id,");
		sql.append("  u.user_mobiletel1,");
		sql.append("  u.user_hometel,");
		sql.append("  u.user_worktel,");
		sql.append("  u.user_sex,");
		sql.append("   u.user_fax,");
		sql.append("   u.user_birthday,");
		sql.append("   u.user_idcard,");
		sql.append("   u.user_realname,");
		sql.append("   u.user_postalcode,");
		sql.append("  u.user_email,");
		sql.append("   u.user_address,");
		sql.append("    us.oldusername,");
		sql.append("   us.education,");
		sql.append("   us.degree,");
		sql.append("   us.school,");
		sql.append("  us.nation,");
		sql.append("   us.politics,");
		sql.append("  us.natives,");
		sql.append("  us.specialty,");
	    sql.append("   us.resume,");
	    sql.append("  us.duties,");
	    sql.append("  to_char(us.worktime,'yyyy-mm-dd') worktime,");
	    sql.append("  us.ismarry,");
	    sql.append("  to_char(us.familymembers) familymembers,");
	    sql.append("  us.jcrecord,");
	    sql.append("  us.pxrecord,");
	    sql.append("  us.certificate,");
	    sql.append("  us.remark,");
	    sql.append("  us.attachmentid,");
	    sql.append("  us.picid, ");
	    sql.append("  us.usernumber, ");
	    sql.append("  us.titles, ");
	    sql.append("  us.userfilespace, ");
	    sql.append("  to_char(us.jointime,'yyyy-mm-dd') jointime,");
	    sql.append("  us.languagetype,");
	    sql.append("  us.languagelevel,");
	    sql.append("  us.usertype,");
	    sql.append("  us.attachmentid,");
	    sql.append("  us.picid,");
	    sql.append("  us.titletype,");
	    sql.append("  us.nativesaddress,");
	    sql.append("  us.health_state,");
	    sql.append("  us.blood_type,");
	    sql.append("  us.stature,");
	    sql.append("  us.vision,");
	    sql.append("  img.image_parth");
	    sql.append("  from td_sm_user u");
	    sql.append("  left join ta_oa_userandsn us on u.user_id = us.userid");
	    sql.append("  left join wc_oa_user_image img on us.picid=img.image_yewu_id");
		sql.append("    where u.user_id='"+id+"'");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		try {
		for (int i = 0; i < pdb.size(); i++) {
			user.setUser_id(pdb.getString(i, "user_id"));
			user.setUserMobiletel1(pdb.getString(i, "user_mobiletel1"));
			user.setUserHometel(pdb.getString(i, "USER_HOMETEL"));
			user.setUserWorktel(pdb.getString(i, "USER_WORKTEL"));
			user.setUserPostalcode(pdb.getString(i, "USER_POSTALCODE"));
			user.setUser_email(pdb.getString(i, "USER_EMAIL"));
			user.setUser_fax(pdb.getString(i, "USER_FAX"));
			user.setUserIdcard(pdb.getString(i, "USER_IDCARD"));
			user.setUserPostalcode(pdb.getString(i, "USER_POSTALCODE"));
			user.setUserRealname(pdb.getString(i,"USER_REALNAME"));
			if("421005".equals(areacode)){
				user.setUserSex(pdb.getString(i, "USER_SEX"));
			} else {
				user.setUserSex("F".equals(pdb.getString(i, "USER_SEX"))?"女":"男");				
			}
			user.setUserAddress(pdb.getString(i, "user_address"));
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			if(!StringUtil.isBlank(pdb.getString(i, "USER_BIRTHDAY"))){
					userAndSn.setBirthday(sdf.format(sdf.parse(pdb.getString(i, "USER_BIRTHDAY"))));
			}
			/*userAndSn.setBirthday(pdb.getString(i, "USER_BIRTHDAY"));*/
			userAndSn.setOldusername(pdb.getString(i, "oldusername"));
			userAndSn.setCertificate(pdb.getString(i, "certificate"));
			userAndSn.setAttachmentid(pdb.getString(i, "attachmentid"));
			userAndSn.setEducation(pdb.getString(i, "EDUCATION"));
			userAndSn.setDegree(pdb.getString(i, "DEGREE"));
			userAndSn.setSchool(pdb.getString(i, "SCHOOL"));
			userAndSn.setPolitics(pdb.getString(i, "POLITICS"));
			userAndSn.setSpecialty(pdb.getString(i, "SPECIALTY"));
			userAndSn.setNativesaddress(pdb.getString(i, "NATIVESADDRESS"));
			userAndSn.setUserfilespace(pdb.getString(i, "USERFILESPACE"));
			userAndSn.setLanguagetype(pdb.getString(i, "LANGUAGETYPE"));
			userAndSn.setLanguagelevel(pdb.getString(i, "LANGUAGELEVEL"));
			userAndSn.setWorktime(pdb.getString(i, "WORKTIME"));
			userAndSn.setJointime(pdb.getString(i, "JOINTIME"));
			userAndSn.setPicid(pdb.getString(i, "PICID"));
			userAndSn.setDuties(pdb.getString(i, "DUTIES"));
			userAndSn.setFamilymembers(pdb.getString(i, "FAMILYMEMBERS"));
			userAndSn.setJclist(splitstr(pdb.getString(i, "JCRECORD")));
			userAndSn.setPxlist(splitstr(pdb.getString(i, "PXRECORD")));
			userAndSn.setNation(pdb.getString(i, "NATION"));
			userAndSn.setNatives(pdb.getString(i, "NATIVES"));
			userAndSn.setIsmarry(pdb.getString(i, "ISMARRY"));
			userAndSn.setTitles(pdb.getString(i, "TITLES"));
			userAndSn.setUserfilespace(pdb.getString(i, "userfilespace"));
			userAndSn.setUsernumber(pdb.getString(i, "usernumber"));
			userAndSn.setLanguagelevel(pdb.getString(i, "languagelevel"));
			userAndSn.setLanguagetype(pdb.getString(i, "languagetype"));
			userAndSn.setUsertype(pdb.getString(i, "usertype"));
			userAndSn.setResume(pdb.getString(i, "resume"));
			userAndSn.setRemark(pdb.getString(i, "remark"));
			userAndSn.setAttachmentid(pdb.getString(i, "attachmentid"));
			userAndSn.setPicid(pdb.getString(i, "picid"));
			userAndSn.setImage_parth(pdb.getString(i, "image_parth"));
			userAndSn.setTitletype(pdb.getString(i, "titletype"));
			userAndSn.setHealth_state(pdb.getString(i, "health_state"));
			userAndSn.setBlood_type(pdb.getString(i, "blood_type"));
			userAndSn.setStature(pdb.getString(i, "stature"));
			userAndSn.setVision(pdb.getString(i, "vision"));
			user.setUserAndSn(userAndSn);
		}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return user;
	}
	/**
	 * 
	*<b>Summary: </b>
	* splitstr(将字符串已@@分割为list)
	* @param str
	* @return
	 */
	public List<String> splitstr(String str){
		List<String> list=new ArrayList<String>() ;
		String[] newstr=str.split("@@");
		for (int i = 0; i < newstr.length; i++) {
			list.add(newstr[i]);
		}
		return list;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* selecthtml(按字典表生成select控件内容)
	* @return
	 */
	public String selecthtml(String typeid,String selected,String name){
		String shtml="";
		String value="";
		String html="";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		sql.append("select * from TA_OA_USERINFOTYPE  t where t.typeid='"+typeid+"'");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				value=pdb.getString(i, "value");
				html=pdb.getString(i, "html");
			}
			String[] values=value.split(",");
			String[] htmls=html.split(",");
			if(values.length==htmls.length){
					for (int i = 0; i < htmls.length; i++) {
						if(selected.equals(values[i])){
							shtml+="<option value='"+values[i]+"' selected='selected'>"+htmls[i]+"</option>";
						}else{
							shtml+="<option value='"+values[i]+"'>"+htmls[i]+"</option>";
						}
							
					}
			}
			shtml="<select name='"+name+"'>"+shtml+"</select>";
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return shtml;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 createSelectHtml
	  * @param viewName
	  * @param selected
	  * @param selectName
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.pub.directory.dao.DirectoryDao#createSelectHtml(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public String createSelectHtml(String viewName, String selected,String selectName) throws SQLException {
		StringBuffer shtml = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		sql.append("select dict_id,dict_name from "+viewName);
		
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			String value=pdb.getString(i, "dict_id");
			String html=pdb.getString(i, "dict_name");
			if(selected.equals(value)){
				shtml.append("<option value='"+value+"' selected='selected'>"+html+"</option>");
			}else{
				shtml.append("<option value='"+value+"'>"+html+"</option>");
			}
		}
		String selectHtml="<select name='"+selectName+"'>"+shtml.toString()+"</select>";
		return selectHtml;
	}

	@Override
	public String getSystemParameter(String paramId) throws SQLException {
		String value = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		sql.append("select t.system_param_value from system_parameter t where t.system_param_id = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, paramId);
		pdb.executePrepared();
		if(pdb.size() > 0){
			value = pdb.getString(0,"system_param_value");
		}
		return value;
	}
	
}
