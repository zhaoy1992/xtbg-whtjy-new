package com.chinacreator.xtbg.pub.personwork.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.apache.log4j.Logger;

import com.chinacreator.sysmgrcore.entity.User;
import com.chinacreator.sysmgrcore.entity.UserAndSn;
import com.chinacreator.sysmgrcore.exception.ManagerException;
import com.chinacreator.sysmgrcore.manager.db.UserManagerImpl;
import com.chinacreator.sysmgrcore.orgmanager.OrgManAction;
import com.chinacreator.xtbg.pub.personwork.dao.PersonInfoDao;
import com.chinacreator.xtbg.pub.personwork.service.AbookInServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.ParseExcelUtil;
import com.chinacreator.xtbg.pub.util.PinyinUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.orm.transaction.TransactionManager;

public class AbookInServiceImpl implements AbookInServiceIfc {
	private static final Logger LOG = Logger.getLogger(AbookInServiceImpl.class);
	private String outStr="";
	private int cgdrNumber=0;
	private int cggxNumber=0;
	private int drsbNumber=0;
	private int gxsbNumber=0;


	public String importSalaryExcel2DB(String path) throws Exception{
		TransactionManager tm = new TransactionManager();
		try {
			PersonInfoDao dao = (PersonInfoDao) DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");
			tm.begin();
				ParseExcelUtil parseExcelUtil = new ParseExcelUtil(path);
				Map<String,String> infomap;
				List<Map<String, String>> list=new ArrayList<Map<String,String>>();
				for(int i = 0 ; i < parseExcelUtil.sheet.getRows() ;i ++){
					  String[] ssTemp = parseExcelUtil.readLine(i);
					  int j = 1;
					  infomap =new HashMap<String, String>();
					  //获取表格数据j表示列号
			    	  if(!StringUtil.nullOrBlank(ssTemp[0]) && StringUtil.isValidNumber(ssTemp[0]) && !StringUtil.nullOrBlank(ssTemp[1])){
			    		  infomap.put("username", ssTemp[j++]);
			    		  infomap.put("usersex", ssTemp[j++]);
			    		  infomap.put("duties", ssTemp[j++]);
			    		  infomap.put("user_mobiletel1", ssTemp[j++]);
			    		  infomap.put("user_worktel", ssTemp[j++]);
			    		  String orgid=dao.queryOrgId(ssTemp[j]);
			    		  infomap.put("org", ssTemp[j]);
			    		  infomap.put("orgid", orgid);
				    	  list.add(infomap);
				    	  int usercount=dao.queryUser(infomap.get("username"));
				    	  if(usercount==0){
				    		  if(!"".equals(orgid)){
					    		  saveuser(infomap);
					    		  outStr=outStr+"<font >["+infomap.get("username")+"]的通讯录信息已导入</font></br>";
					    		  cgdrNumber=cgdrNumber+1;
				    		  }else{
				    			  outStr=outStr+"<font color=red>["+infomap.get("username")+"]的单位:"+infomap.get("org")+",不存在,导入/更新失败</font></br>";
				    			  drsbNumber=drsbNumber+1;
				    		  }
				    	  }else{
				    		  outStr=outStr+"<font color=red>名为["+infomap.get("username")+"]的用户已经存在,导入/更新失败</font></br>";
				    		  drsbNumber=drsbNumber+1;
				    	  }
				    	  
			    	  }
				}
			tm.commit();
		} catch (Exception e) {
			e.printStackTrace();
			LOG.info(e.getMessage());
			outStr="解析文件失败,请检查文件</br>";
			outStr=outStr+"成功导入"+cgdrNumber+"条记录<br>";
			outStr=outStr+"成功更新"+cggxNumber+"条记录<br>";
			outStr=outStr+"导入/更新失败"+drsbNumber+"条记录<br>";
			//outStr=outStr+"更新失败"+gxsbNumber+"条记录<br>";
			tm.rollback();
			return outStr;
		}
		outStr=outStr+"成功导入"+cgdrNumber+"条记录<br>";
		outStr=outStr+"成功更新"+cggxNumber+"条记录<br>";
		outStr=outStr+"导入/更新失败"+drsbNumber+"条记录<br>";
		//outStr=outStr+"更新失败"+gxsbNumber+"条记录<br>";
		return outStr;
	}

	/**
	 * 单独录入
	 */
	public void singleInput(Map<String, String> map) {
		try {
			PersonInfoDao dao = (PersonInfoDao) DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");
			String orgid=dao.queryOrgId(map.get("org"));
			map.put("orgid", orgid);
			saveuser(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
	
	//public static void print(JspWriter out) throws IOException{
	//	out.print("在JavaBean中直接打印信息到JSP页面中");
	//}
	public void saveuser(Map<String, String> map){
			  String username="";
			  String usersex="";
			  UserManagerImpl userManagerImpl =new UserManagerImpl();
			  Date date=new Date();
			  username= String.valueOf(date.getTime());
			  User user =new User();
			  try {
				String pinyinUsername = PinyinUtil.hanziToPinyin(map.get("username"));
				  //已经存在的username的数量
				String isexsitUsernameCnt = DaoUtil.SqlToField("select count(user_id) cnt from td_sm_user u where u.user_name like '"+pinyinUsername+"%'"); 
				//如果不存在当前username的类似值，即isexsitUsernameCnt为0，则直接使用pinyinUsername
				user.setUserName((Integer.parseInt(isexsitUsernameCnt) > 0)?pinyinUsername+isexsitUsernameCnt:pinyinUsername);
			} catch (BadHanyuPinyinOutputFormatCombination e1) {
				e1.printStackTrace();
			} catch(SQLException e2){
				
			}
			  user.setUserPassword("123456");
			  if("男".equals(map.get("usersex"))){
				  usersex="M";
			  }else{
				  usersex="F";
			  }
			  user.setUserSex(usersex);
			  user.setUserType("0");
			  user.setUserIsvalid(3);
			  user.setUserSn(new Integer(String.valueOf(OrgManAction.getMaxOrgUserSn(map.get("orgid")))));
			  user.setUserLogincount(0);
			  user.setUserRealname(map.get("username"));
			  user.setUserMobiletel1(map.get("user_mobiletel1"));
			  user.setUserWorktel(map.get("user_worktel"));
			  UserAndSn userAndSn= new UserAndSn();
			  userAndSn.setDuties(map.get("duties"));
			  user.setUserAndSn(userAndSn);
			  try {
				userManagerImpl.creatorUser(user, map.get("orgid"), "1");
			  } catch (ManagerException e) {
				e.printStackTrace();
			  }
		}
}
