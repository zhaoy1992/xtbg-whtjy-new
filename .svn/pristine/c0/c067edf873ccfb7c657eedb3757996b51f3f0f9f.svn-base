package com.chinacreator.xtbg.core.personwork.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.sysmgrcore.orgmanager.OrgManAction;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ParseExcelUtil;
import com.chinacreator.xtbg.core.common.util.PinyinUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.entity.UserAndSn;
import com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao;
import com.chinacreator.xtbg.core.personwork.entity.PersonExtraInfoBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonInfoBean;
import com.chinacreator.xtbg.core.personwork.service.AbookInServiceIfc;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserBean;
import com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc;
import com.chinacreator.xtbg.core.purviewmanager.service.impl.UserManagerServiceImpl;

/**
 * 
 *<p>
 * Title:AbookInServiceImpl.java
 * </p>
 *<p>
 * Description:通讯录service处理类
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-8
 */
public class AbookInServiceImpl extends XtDbBaseDao implements
		AbookInServiceIfc {
	private static final Logger LOG = Logger
			.getLogger(AbookInServiceImpl.class);
	private String outStr = "";
	private int cgdrNumber = 0;
	private int cggxNumber = 0;
	private int drsbNumber = 0;

	/**
	 * 
	 * <b>Summary: </b> 复写方法 importSalaryExcel2DB
	 * 
	 * @param path
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.service.AbookInServiceIfc#importSalaryExcel2DB(java.lang.String)
	 */
	public String importSalaryExcel2DB(String path,String is_public,String user_id) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();			
			PersonInfoDao dao = (PersonInfoDao) LoadSpringContext.getApplicationContext().getBean("personInfoDaoImpl");
			
			ParseExcelUtil parseExcelUtil = new ParseExcelUtil(path);
			Map<String, String> infomap;
			List<Map<String, String>> list = new ArrayList<Map<String, String>>();
			for (int i = 1; i < parseExcelUtil.sheet.getRows(); i++) {
				String[] ssTemp = parseExcelUtil.readLine(i);
				int j = 1;
				infomap = new HashMap<String, String>();
				// 获取表格数据j表示列号
				if(is_public.equals("0")){	//获取个人通讯录
					if(!StringUtil.nullOrBlank(ssTemp[2])){	//用户名为空
						if(!StringUtil.nullOrBlank(ssTemp[1])){	//开发商单位为空
							if(!StringUtil.nullOrBlank(ssTemp[4])){	//电话号码为空
								infomap.put("is_public", is_public);
								infomap.put("user_id", user_id);
								infomap.put("company", ssTemp[j++]);
								infomap.put("username", ssTemp[j++]);
								infomap.put("position", ssTemp[j++]);
								infomap.put("user_mobiletel1", ssTemp[j++]);
								infomap.put("user_worktel", ssTemp[j++]);
								infomap.put("user_email", ssTemp[j++]);
								infomap.put("user_address", ssTemp[j++]);
								infomap.put("remark", ssTemp[j++]);
								list.add(infomap);
								String person_id = DaoUtil.sqlToField("select PERSON_ID from OA_PERSONWORK_PERSONINFO where name = '"+infomap.get("username")+"' and user_id = '"+user_id+"'");
								if (person_id != null && !"".equals(person_id)) {
									outStr = outStr + "<font color=red>名为["+ infomap.get("username")+ "]的用户已经存在,导入/更新失败</font></br>";
									drsbNumber = drsbNumber + 1;
								} else {
									savePersonInfo(infomap,conn);
									outStr = outStr + "<font >["+ infomap.get("username")+ "]的通讯录信息已导入</font></br>";
									cgdrNumber = cgdrNumber + 1;
								}
							} else {
								outStr = outStr + "<font color=red>名为["+ ssTemp[2]+ "]的用户的手机号码为空,导入/更新失败</font></br>";
								drsbNumber = drsbNumber + 1;
							}
						} else {
							outStr = outStr + "<font color=red>名为["+ ssTemp[2]+ "]的用户的开发商名称为空,导入/更新失败</font></br>";
							drsbNumber = drsbNumber + 1;
						}
					} else {
						//outStr = outStr + "<font color=red>名为["+ infomap.get("username")+ "]的用户已经存在,导入/更新失败</font></br>";
						drsbNumber = drsbNumber + 1;
					}
				} else {
					if (!StringUtil.nullOrBlank(ssTemp[0])
							&& StringUtil.isValidNumber(ssTemp[0])
							&& !StringUtil.nullOrBlank(ssTemp[1])) {
						infomap.put("username", ssTemp[j++]);
						infomap.put("usersex", ssTemp[j++]);
						infomap.put("duties", ssTemp[j++]);
						infomap.put("user_mobiletel1", ssTemp[j++]);
						infomap.put("user_worktel", ssTemp[j++]);
						String orgid = dao.queryOrgId(ssTemp[j]);
						infomap.put("org", ssTemp[j]);
						infomap.put("orgid", orgid);
						list.add(infomap);
						int usercount = dao.queryUser(infomap.get("username"),conn);
						if (usercount == 0) {
							if (!"".equals(orgid)) {
								saveuser(infomap,conn);
								outStr = outStr + "<font >["
										+ infomap.get("username")
										+ "]的通讯录信息已导入</font></br>";
								cgdrNumber = cgdrNumber + 1;
							} else {
								outStr = outStr + "<font color=red>["
										+ infomap.get("username") + "]的单位:"
										+ infomap.get("org")
										+ ",不存在,导入/更新失败</font></br>";
								drsbNumber = drsbNumber + 1;
							}
						} else {
							outStr = outStr + "<font color=red>名为["
									+ infomap.get("username")
									+ "]的用户已经存在,导入/更新失败</font></br>";
							drsbNumber = drsbNumber + 1;
						}
					}
				}
			}
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			outStr = "解析文件失败,请检查文件</br>";
			outStr = outStr + "成功导入" + cgdrNumber + "条记录<br>";
			outStr = outStr + "成功更新" + cggxNumber + "条记录<br>";
			outStr = outStr + "导入/更新失败" + drsbNumber + "条记录<br>";
			// outStr=outStr+"更新失败"+gxsbNumber+"条记录<br>";
			DbManager.closeTransactionConnection(conn, false);
			return outStr;
		}
		outStr = outStr + "成功导入" + cgdrNumber + "条记录<br>";
		outStr = outStr + "成功更新" + cggxNumber + "条记录<br>";
		outStr = outStr + "导入/更新失败" + drsbNumber + "条记录<br>";
		// outStr=outStr+"更新失败"+gxsbNumber+"条记录<br>";
		return outStr;
	}

	/**
	 * 
	 * <b>Summary:单独录入 </b> 复写方法 singleInput
	 * 
	 * @param map
	 * @see com.chinacreator.xtbg.core.personwork.service.AbookInServiceIfc#singleInput(java.util.Map)
	 */
	public void singleInput(Map<String, String> map) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PersonInfoDao dao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");
			String orgid = dao.queryOrgId(map.get("org"),conn);
			map.put("orgid", orgid);
			saveuser(map,conn);			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);			
		}finally{
			DbManager.closeConnection(conn);
		}

	}

	/**
	 * 
	 *<b>Summary: </b> saveuser(请用一句话描述这个方法的作用)
	 * 
	 * @param map
	 * @throws Exception
	 */
	public void saveuser(Map<String, String> map,Connection conn) throws Exception {
		String usersex = "";
		// UserManagerImpl userManagerImpl = new UserManagerImpl();
		UserBean user = new UserBean();
		String pinyinUsername = PinyinUtil.hanziToPinyin(map.get("username"));
		// 已经存在的username的数量
		String isexsitUsernameCnt = DaoUtil.sqlToField("select count(user_id) cnt from td_sm_user u where u.user_name like '"
						+ pinyinUsername + "%'");
		// 如果不存在当前username的类似值，即isexsitUsernameCnt为0，则直接使用pinyinUsername
		user.setUser_name((Integer.parseInt(isexsitUsernameCnt) > 0) ? pinyinUsername + isexsitUsernameCnt : pinyinUsername);
		user.setUser_password("123456");
		if ("男".equals(map.get("usersex"))) {
			usersex = "M";
		} else {
			usersex = "F";
		}
		user.setUser_sex(usersex);
		user.setUser_type("0");
		user.setUser_isvalid("3");
		user.setUser_sn(String.valueOf(OrgManAction.getMaxOrgUserSn(map.get("orgid"))));
		user.setUser_logincount("0");
		user.setOrg_id(map.get("orgid"));
		user.setOrg_Name(map.get("org"));
		user.setUser_realname(map.get("username"));
		user.setUser_mobiletel1(map.get("user_mobiletel1"));
		user.setUser_worktel(map.get("user_worktel"));

		/**
		 * 保存用户的操作，修改为调用黄的新方法
		 * 
		 * @alter by 戴连春
		 * @alter date 2013-6-14
		 */
		UserManagerServiceIfc service = new UserManagerServiceImpl();
		// 保存用户
		service.addorUpdateUser(user);

		UserAndSn userAndSn = new UserAndSn();
		userAndSn.setDuties(map.get("duties"));
		userAndSn.setId(StringUtil.getUUID());
		super.insert(userAndSn,conn);
	}
	
	private void savePersonInfo(Map<String, String> map,Connection conn) throws Exception {
		PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext.getApplicationContext().getBean("personInfoDaoImpl");
		String person_id = DaoUtil.getUUID();
		PersonInfoBean personInfoBean = new PersonInfoBean();
		personInfoBean.setPerson_id(person_id);
		personInfoBean.setName(map.get("username"));
		personInfoBean.setNick_name("无昵称");
		personInfoBean.setRemark(map.get("remark"));
		personInfoBean.setIs_public(map.get("is_public"));
		personInfoBean.setUser_id(map.get("user_id"));
		personInfoBean.setInfo_type("personal");
		String pinyinUsername = PinyinUtil.hanziToPinyin(map.get("username"));
		personInfoBean.setEng_name(pinyinUsername);
		
		person_id = personInfodao.savePersonBaseInfo(personInfoBean,conn);
		
		PersonExtraInfoBean bean1 = new PersonExtraInfoBean();
		bean1.setPerson_id(person_id);
		bean1.setType("6");
		bean1.setField_name("company");
		bean1.setField_value(map.get("company"));
		bean1.setShowindex("0");
		if(!StringUtil.isBlank(map.get("company"))){
			personInfodao.savePersonExtraInfo(bean1, conn); 	//公司名称
		}
		
		bean1 = new PersonExtraInfoBean();
		bean1.setPerson_id(person_id);
		bean1.setType("7");
		bean1.setField_name("position");
		bean1.setField_value(map.get("position"));
		bean1.setShowindex("0");
		if(!StringUtil.isBlank(map.get("company"))){
			personInfodao.savePersonExtraInfo(bean1, conn); 	//职务
		}
		
		bean1 = new PersonExtraInfoBean();
		bean1.setPerson_id(person_id);
		bean1.setType("1");
		bean1.setField_name("办公手机");
		bean1.setField_value(map.get("user_mobiletel1"));
		bean1.setShowindex("1");
		if(!StringUtil.isBlank(map.get("user_mobiletel1"))){
			personInfodao.savePersonExtraInfo(bean1, conn); 	//办公手机
		}
		
		bean1 = new PersonExtraInfoBean();
		bean1.setPerson_id(person_id);
		bean1.setType("1");
		bean1.setField_name("办公电话");
		bean1.setField_value(map.get("user_worktel"));
		bean1.setShowindex("0");
		if(!StringUtil.isBlank(map.get("user_worktel"))){
			personInfodao.savePersonExtraInfo(bean1, conn); 	//办公电话
		}
		
		bean1 = new PersonExtraInfoBean();
		bean1.setPerson_id(person_id);
		bean1.setType("3");
		bean1.setField_name("电子邮箱");
		bean1.setField_value(map.get("user_email"));
		bean1.setShowindex("0");
		if(!StringUtil.isBlank(map.get("user_email"))){
			personInfodao.savePersonExtraInfo(bean1, conn); 	//邮箱
		}
		
		bean1 = new PersonExtraInfoBean();
		bean1.setPerson_id(person_id);
		bean1.setType("8");
		bean1.setField_name("地址");
		bean1.setField_value(map.get("user_address"));
		bean1.setShowindex("0");
		if(!StringUtil.isBlank(map.get("user_address"))){
			personInfodao.savePersonExtraInfo(bean1, conn); 	//联系地址
		}
	}
}
