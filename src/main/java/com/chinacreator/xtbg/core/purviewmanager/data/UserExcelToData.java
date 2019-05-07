package com.chinacreator.xtbg.core.purviewmanager.data;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.constant.DirectoryConstant;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.entity.HeTongBean;
import com.chinacreator.xtbg.core.directory.entity.UserinfoBean;
import com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao;
import com.chinacreator.xtbg.core.purviewmanager.entity.OrgUserBean;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserBean;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserJobOrgBean;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;

/**
 * 
 *<p>Title:UserExcelToData.java</p>
 *<p>Description:用户信息导入</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2014-3-16
 */
public class UserExcelToData extends BusiExcelToData{
	public static final Logger LOG = Logger
			.getLogger(UserExcelToData.class.getName());
	@Autowired
	private DirectoryDao directoryDao = null;

	@Override
	public String exportExcelToData(Map<String, String> params) {
		
		return super.exportExcelToData(params);
	}

	@Override
	public String importExcelToData(String filepath) {
		Connection conn = null;
		UserManagerDao userManagerDao = (UserManagerDao)LoadSpringContext.getApplicationContext().getBean("userManagerDaoImpl");
		try {
			super.importExcelToData(filepath);
			super.cgdrNumber = 0;
			outStr = "";
			String user_realname = "";//用户真实名称
			String user_name = "";//用户名
			String work_number = "";//工作号码
			String telephone = "";//手机号码
			String short_num = "";//短号	
			String idcard = "";//身份证号	
			String sex = "";//性别
			String org_id = "";//工作部门	
			String second_org = "";//二级部门	
			String birthday = "";//出生日期	
			String duties = "";//职务/岗位
			String nation = "";//民族	
			String natives = "";//籍  贯	
			String politics = "";//政治面貌
			String new_join_zzdate = "";//参加组织日期	
			String worktime = "";//参加工作时间	
			String new_in_hosb = "";//入院时间
			String school = "";//毕业院校	
			String education = "";//学历	
			String degree = "";//学位	
			String new_first_xingshi = "";//学习形式	
			String new_first_zy = "";//专业	
			String new_first_bydate = "";//毕业时间

			String new_zg_byyx = "";//毕业院校	
			String new_zg_xl = "";//学历	
			String new_zg_xw = "";//学位	
			String new_zg_xingshi = "";//学习形式	
			String new_zg_zy = "";//专业	
			String new_zg_bydate = "";//毕业时间
			
			String new_jszc = "";//技术职称	
			String new_zc_getdate = "";//职称获取时间	
			String new_zc_pydate = "";//职称聘任时间	
			String hetong_busiid = "";//合同编号	
			String hetong_type = "";//合同类别	
			String hetong_number = "";//08-后劳动合同签订次数	
			String hetong_first_date = "";//首次合同签订日期	
			String hetong_nowstart_date = "";//现合同起始期	
			String hetong_nowsend_date = "";//现合同终止期	
			String hetong_trystart_date = "";//合同试用起始期	
			String hetong_tryend_date = "";//合同试用终止期	
			String new_remark = "";//备注
			
			String org_name = "";//机构名称
			
		    poiExcelUtil = new POIExcelUtil(filepath);
			conn = DbManager.getInstance().getTransactionConnection();
			String[][] datas = poiExcelUtil.readSheet();//将excel中的数据全部获取出来放置在二维数组中
			for(int i = 2 ; i < datas.length; i++){//从第二行开始读取
				
				
				String[] data = datas[i];
				org_name = data[8];
				/*if("院领导".equals(org_name)){
					org_name = "信息技术中心";
				}else if("内部待聘".equals(org_name)){
					org_name = "办公室";
				}else if("党委办公室".equals(org_name)){
					org_name = "党委办";
				}*/
				
				org_id = DaoUtil.sqlToField("select org_id from td_sm_organization o where o.org_name = '"+org_name+"'");
				if(StringUtil.nullOrBlank(org_id)){
					outStr = outStr + "序号为:"+data[0]+",姓名为:"+data[1]+"的记录，机构名为:"+org_name+",此机构不存在,请确认<br>";
					break;
				}
				user_realname = data[1];
				user_name = data[2];//用户名
				work_number = data[3];//工作号码
				telephone = data[4];//手机号码
				short_num = data[5];//短号	
				idcard = data[6];//身份证号	
				sex = data[7];//性别
				
				second_org = data[9];//二级部门	
				birthday = data[10];//出生日期	
				duties = data[11];//职务/岗位
				nation = data[12];//民族	
				natives = data[13];//籍  贯	
				politics = data[14];//政治面貌
				new_join_zzdate = data[15];//参加组织日期	
				worktime = data[16];//参加工作时间	
				new_in_hosb = data[17];//入院时间
				school = data[18];//毕业院校	
				education = data[19];//学历	
				degree = data[20];//学位	
				new_first_xingshi = data[21];//学习形式	
				new_first_zy = data[22];//专业	
				new_first_bydate = data[23];//毕业时间

				new_zg_byyx = data[24];//毕业院校	
				new_zg_xl = data[25];//学历	
				new_zg_xw = data[26];//学位	
				new_zg_xingshi = data[27];//学习形式	
				new_zg_zy = data[28];//专业	
				new_zg_bydate = data[29];//毕业时间
				
				new_jszc = data[30];//技术职称	
				new_zc_getdate = data[31];//职称获取时间	
				new_zc_pydate = data[32];//职称聘任时间	
				hetong_busiid = data[33];//合同编号	
				hetong_type = data[34];//合同类别	
				hetong_number = data[35];//08-后劳动合同签订次数	
				hetong_first_date = data[36];//首次合同签订日期	
				hetong_nowstart_date = data[37];//现合同起始期	
				hetong_nowsend_date = data[38];//现合同终止期	
				hetong_trystart_date = data[39];//合同试用起始期	
				hetong_tryend_date = data[40];//合同试用终止期	
				new_remark = data[41];//备注
				

				
				UserBean userbean = new UserBean();
				UserinfoBean userinfoBean = new UserinfoBean();
				HeTongBean heTongBean = new HeTongBean();
				
				userbean.setUser_id(DaoUtil.findBySequencsName("seq_td_sm_user", conn));//用户id
				userbean.setOrg_id(org_id);
				userbean.setOrg_Name(org_name);
				userbean.setUser_realname(data[1]);
				userbean.setUser_name(user_name);
				userbean.setUser_password("123456");
				userbean.setRemark4(short_num);
				userbean.setUser_worktel(work_number);
				userbean.setUser_mobiletel1(telephone);
				userbean.setUser_sn("1");//排序号
				userbean.setUser_isvalid("2");//是否启用
				userbean.setUser_type("0");//用户类型
				userbean.setUser_regdate(new Timestamp(new Date().getTime()));
				

				((BaseDao)userManagerDao).insert(userbean, conn);
				
				//保存用户岗位信息
				UserJobOrgBean userJobOrgBean = new UserJobOrgBean();
				userJobOrgBean.setUser_id(userbean.getUser_id());
				userJobOrgBean.setJob_id("1");
				userJobOrgBean.setOrg_id(userbean.getOrg_id());
				userJobOrgBean.setJob_sn("999");
				userJobOrgBean.setSame_job_user_sn(userManagerDao.getJobUserSn(userbean.getOrg_id(), conn));
				userJobOrgBean.setJob_starttime(new Timestamp(new Date().getTime()));
				((BaseDao)userManagerDao).insert(userJobOrgBean, conn);
				
				//保存机构用户关系
				OrgUserBean orgUserBean = new OrgUserBean();
				orgUserBean.setOrg_id(userbean.getOrg_id());
				orgUserBean.setUser_id(userbean.getUser_id());
				((BaseDao)userManagerDao).insert(orgUserBean, conn);
				//--------------------------以上是系统用户和机构操作----------------------------------------
				
				userinfoBean.setUserid(userbean.getUser_id());//用户id
				heTongBean.setHetong_userands_id(userbean.getUser_id());
				
				userinfoBean.setUserMobiletel1(telephone);
				userinfoBean.setUserWorktel(work_number);
				//userinfoBean.setNew_user_type(DirectoryConstant.parsePersonType(data[1],false));//人员类别
				//userinfoBean.setNew_job_state(DirectoryConstant.parseJobState(data[2], false));//在岗状态
				//userinfoBean.setNew_job_no(data[3]);//职工工号
				userinfoBean.setUserRealname(user_realname);//姓名
				
				//data[5]工作部门 字段不存
				userinfoBean.setDuties(DirectoryConstant.parsePost(duties, false));//职务
				//userinfoBean.setDirectorylevel(DirectoryConstant.parseJobState(data[7], false));//职务级别
				userinfoBean.setUserSex(DirectoryConstant.parsePersonSex(sex,false));//性别
				userinfoBean.setNation(nation);//民族
				userinfoBean.setNatives(natives);//籍贯
				//userinfoBean.setNew_job_set(DirectoryConstant.parseJobSet(data[11], false));//岗位设置
				
				userinfoBean.setRemark(new_remark);
				userinfoBean.setPolitics(DirectoryConstant.parsePolitics(politics, false));//政治面貌
				userinfoBean.setNew_join_zzdate(new_join_zzdate);//参加组织日期
				userinfoBean.setUserBirthday(birthday);//出生日期
				userinfoBean.setWorktime(worktime);//参加工作时间
				userinfoBean.setNew_in_hosb(new_in_hosb);//入院时间
				
				//userinfoBean.setNew_toother_date(data[17]);//借调时间
				userinfoBean.setUserIdcard(idcard);//身份证
				
				//data[19]备注不存
				userinfoBean.setSchool(school);//毕业院校(第一学历)
				userinfoBean.setEducation(DirectoryConstant.parseEducation(education, false));//学历(第一学历)
				userinfoBean.setDegree(DirectoryConstant.parseDegree(degree, false));//学位(第一学历)
				userinfoBean.setNew_first_xingshi(new_first_xingshi);//学习形式(第一学历)
				userinfoBean.setNew_first_zy(new_first_zy);//专业(第一学历)
				userinfoBean.setNew_first_bydate(new_first_bydate);//毕业时间(第一学历)
				
				userinfoBean.setNew_zg_byyx(new_zg_byyx);//毕业院校(最高学历)
				userinfoBean.setNew_zg_xl(DirectoryConstant.parseEducation(new_zg_xl, false));//学历(最高学历)
				userinfoBean.setNew_zg_xw(DirectoryConstant.parseDegree(new_zg_xw, false));//学位(最高学历)
				userinfoBean.setNew_zg_xingshi(new_zg_xingshi);//学习形式(最高学历)
				userinfoBean.setNew_zg_zy(new_zg_zy);//专业(最高学历)
				userinfoBean.setNew_zg_bydate(new_zg_bydate);//毕业时间(最高学历)
				
				userinfoBean.setNew_jszc(DirectoryConstant.parseNewjszc(new_jszc, false));//技术职称
				userinfoBean.setNew_zc_getdate(new_zc_getdate);//职称获取时间
				userinfoBean.setNew_zc_pydate(new_zc_pydate);//职称聘任时间
				
				//data[40]合同编号不存
				heTongBean.setHetong_type(DirectoryConstant.parseHetongtype(hetong_type, false));//合同类别
				heTongBean.setHetong_number(hetong_number);//08年后劳动合同签订次数
				heTongBean.setHetong_first_date(hetong_first_date);//首次合同签订日期
				heTongBean.setHetong_nowstart_date(hetong_nowstart_date);//现合同起始期
				heTongBean.setHetong_nowsend_date(hetong_nowsend_date);//现合同终止期
				heTongBean.setHetong_trystart_date(hetong_trystart_date);//合同试用起始期
				heTongBean.setHetong_tryend_date(hetong_tryend_date);//合同试用终止期
				heTongBean.setHetong_busiid(hetong_busiid);
				
				directoryDao.updateUserinfo(userinfoBean, heTongBean, conn);
				cggxNumber ++;
			}
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			LOG.error(e.getMessage());
			DbManager.closeTransactionConnection(conn, false);
		}
		outStr = outStr + "成功更新" + cggxNumber + "条记录<br>";
		return outStr;
	}
	
}
