
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ElectDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-1   Administrator    最初版本
   */
package com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectDao;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:ElectDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-1
 */
public class ElectDaoImpl  extends XtDbBaseDao implements ElectDao{
	/**
	*<b>Summary: </b>
	* selElecSetforList(查询考勤设置管理列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selElecSetforList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception{
		
		Connection conn = null;
		ElectResetBean electresetbean= new ElectResetBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				electresetbean = (ElectResetBean) JSONObject.parseObject(parmjson, ElectResetBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select elect_id,");
			sql.append("       start_time,");
			sql.append("       end_time,");
			sql.append("       rest_time,");
			sql.append("       auto_check,");
			sql.append("       username,");
			sql.append("       userid,");
			sql.append("       orgid,");
			sql.append("       orgname,");
			sql.append("       depart_name,");
			sql.append("       depart_id,");
			sql.append("       isuse");
			sql.append("  from sx_ta_oa_electcheck ");
			sql.append("  where 1=1");
			if(electresetbean!=null){
				//机构ID
				if (!StringUtil.nullOrBlank(electresetbean.getOrgid())) {
					sql.append(" and r_username = ? ");
					condition.add(electresetbean.getOrgid());
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
	  *     复写方法 getResElecSet
	  * @param elect_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.review.dao.ReviewInfoDao#getReviewInfo(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getResElecSet(String elect_id, Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select  r_id,");
		sql.append("        r_creatortime, ");
		sql.append("        to_char(r_reviewtime,'yyyy-mm-dd') as r_reviewtime ,");
		sql.append("        r_orgname, ");
		sql.append("        r_content, ");
		sql.append("        r_userid, ");
		sql.append("        r_username ");
		sql.append("  from ta_oa_reviewinfo ");
		sql.append(" where r_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), elect_id);
		
		return viewMap;
	}
	

	/**
	*<b>Summary: </b>
	* querySetRecord(查询sx_ta_oa_electcheck表是否有记录)
	* @return
	* @throws Exception
	 */
	public ElectResetBean querySetRecord(String user_id) throws Exception{
		
		StringBuffer sqlExit = new StringBuffer();
		sqlExit.append("select count(*) from sx_ta_oa_electcheck t ");
		sqlExit.append(" where t.orgid=(select users.org_id from td_sm_orguser users where users.user_id='"+user_id+"') ");
		String count = DaoUtil.sqlToField(sqlExit.toString());
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select * from sx_ta_oa_electcheck where 1=1 ");
		ElectResetBean electresetbean = new ElectResetBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		if(Integer.parseInt(count)==0){
			sql.append(" and orgid is null ");
		} else {
			sql.append(" and orgid=(select users.org_id from td_sm_orguser users where users.user_id='"+user_id+"')  ");
		}
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			electresetbean.setDept_id(pdb.getString(i, "dept_id"));
			electresetbean.setDept_name(pdb.getString(i, "dept_name"));
			electresetbean.setEnd_time(pdb.getString(i, "end_time"));
			electresetbean.setIsauto(pdb.getString(i, "isauto"));
			electresetbean.setIsuse(pdb.getString(i, "isuse"));
			electresetbean.setOrgid(pdb.getString(i, "orgid"));
			electresetbean.setOrgname(pdb.getString(i, "orgname"));
			electresetbean.setReset_time(pdb.getString(i, "reset_time"));
			electresetbean.setStart_time(pdb.getString(i, "start_time"));
			electresetbean.setUserid(pdb.getString(i, "userid"));
			electresetbean.setUsername(pdb.getString(i, "username"));
			electresetbean.setElect_id(pdb.getString(i, "elect_id"));
			electresetbean.setAm_end_time(pdb.getString(i, "am_end_time"));
			electresetbean.setPm_start_time(pdb.getString(i, "pm_start_time"));
			
		}
		return electresetbean;
	}
	
	/**   modify tieshan.he
	*<b>Summary: </b>
	* setEclService(定时任务设置矿工天数)
	 */
	public void setEclService() throws Exception{
		String errorUser_id = "";//异常用户ID
		try{
			PreparedDBUtil pdb = new PreparedDBUtil();
			ElectInfoDao poeManagerDao = new ElectInfoDaoImpl();
			SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
 			SimpleDateFormat sdfHour=new SimpleDateFormat("HH");
			String time = new SimpleDateFormat("HH:mm").format(new Date());
			String Hourtime = new SimpleDateFormat("HH").format(new Date());
			String currenttime = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			List<String> list = null;              //请假半天假的人             
			if(sdfHour.parse("12").getTime() >= sdfHour.parse(Hourtime).getTime()){
				list = getHaLf(currenttime,"1","1");          //上午请假的人
			}else{
				list = getHaLf(currenttime,"1","2");           //下午请假的人
			}
			StringBuffer sql = new StringBuffer();
			sql.append("select t.user_id,org.org_id,org.org_name,t.user_realname ");
			sql.append("  from td_sm_user t, td_sm_organization org, td_sm_orguser orguser ");
			sql.append("  where t.user_id = orguser.user_id and orguser.org_id = org.org_id ");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				String user_id = pdb.getString(i, "user_id");
				errorUser_id = user_id;
				String dept_id = pdb.getString(i,"org_id");
				String dept_name = pdb.getString(i, "org_name");
				String username = pdb.getString(i, "user_realname");
				ElectResetBean electresetbean = querySetRecord(user_id);
				String start_time ="";
				if(sdfHour.parse("12").getTime()>= sdfHour.parse(Hourtime).getTime()){
					start_time = electresetbean.getStart_time();
					if(StringUtil.nullOrBlank(start_time)){
						continue;
					}
				}else{
					if(!list.contains(user_id)){
						continue;          //如果为下午，则不是请下午假的人  不再往下执行
					}
					start_time = electresetbean.getPm_start_time();
					if(StringUtil.nullOrBlank(start_time)){
						continue;
					}
				}
				//考勤时间后一个小时都是矿工
				start_time = sdf.parse(start_time).getHours()+1+":"+sdf.parse(start_time).getMinutes();
				if(sdf.parse(start_time).getTime()<sdf.parse(time).getTime()){
					//查询节假日和请假数据
					boolean flag = findExitEclRecode(user_id,currenttime,start_time,list);
					if(flag==false){
						ElectInfoBean electinfobean = findExitEcl(user_id,currenttime,start_time);
						ElectInfoDaoImpl electinfodaoimpl = new ElectInfoDaoImpl();
						if(list.contains(user_id)){
							electinfobean = new ElectInfoBean();
							electinfobean.setUserid(user_id);
							electinfobean.setDatetime(currenttime);
							electinfobean = electinfodaoimpl.isAddOrUpdate(electinfobean);
							if(!StringUtil.nullOrBlank(electinfobean.getElect_id())){
								if(electinfobean.getState() != null && electinfobean.getState().indexOf("/") != -1){
									electinfobean.setState(electinfobean.getState().substring(0, electinfobean.getState().indexOf("/"))+"/旷工");
								}else{
									electinfobean.setState(electinfobean.getState()+"/旷工");
								}
								electinfobean.setUserid(user_id);
								electinfodaoimpl.updateEndTime(electinfobean);
							}
						}else{
							if(electinfobean==null){
								ElectInfoBean electInfoBean = new ElectInfoBean();
								electInfoBean.setDept_id(dept_id);
								electInfoBean.setDept_name(dept_name);
								electInfoBean.setReset_time("");
								electInfoBean.setDatetime(currenttime);
								electInfoBean.setEnd_time("");
								electInfoBean.setOrgid(dept_id);
								electInfoBean.setOrgname(dept_name);
								electInfoBean.setUserid(user_id);
								electInfoBean.setUsername(username);
								electInfoBean.setReset_time("");
								electInfoBean.setEnd_ip("");
								electInfoBean.setState("旷工");
								poeManagerDao.addInfos(electInfoBean);
							}else {
								//打完卡，过了规定时间1个小时的状态改为 【旷工】
								electinfobean.setState("旷工");
								electinfodaoimpl.updateElectInfoBean(electinfobean);
							}
						}
					}

				}
			}
		}catch(Exception e){
			System.out.println("errorUser_id====异常打卡矿工的用户ID==" + errorUser_id);
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* findExitEcl(查询当前用户当天矿工)
	* @return
	 */
	public ElectInfoBean findExitEcl(String user_id,String currenttime,String start_time) throws Exception{
		ElectInfoBean electinfobean=null;
		//查询是否打卡
		PreparedDBUtil pdb1 = new PreparedDBUtil();
		StringBuffer sqlinfo = new StringBuffer();
		//有打卡记录
		sqlinfo.append("select to_char(datetime,'yyyy-mm-dd') as datetime,state,userid from sx_ta_oa_electcheck_info t where t.userid='"+user_id+"' and to_char(t.datetime,'yyyy-mm-dd')='"+currenttime+"' and to_date(t.start_time,'hh24:mi')>to_date('"+start_time +"','hh24:mi') ");
		pdb1.preparedSelect(sqlinfo.toString());
		pdb1.executePrepared();
		if(pdb1.size()>0){
			for (int i = 0; i < pdb1.size(); i++) {  
				electinfobean = new ElectInfoBean();
				electinfobean.setDatetime(pdb1.getString(i,"datetime"));
				electinfobean.setState(pdb1.getString(i,"state"));
				electinfobean.setUserid(pdb1.getString(i,"userid"));
			}
		}
		return electinfobean;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* findExitEcl(查询当前用户当请假和节假日的数据和已打卡的正常数据)
	* @return
	 */
	public boolean findExitEclRecode(String user_id,String currenttime,String start_time,List<String> userList)throws Exception{      //新增userList参数
		boolean result = false;
		//查询是否是节假日
		String countExit = DaoUtil.sqlToField("select count(*) from td_sp_holiday t where t.holiday='"+currenttime+"'");
		if(Integer.parseInt(countExit)!=0){
			result = true;
		}
		
		//查询是否矿工
		String countExit1 = DaoUtil.sqlToField("select count(*) from sx_ta_oa_electcheck_info t where t.userid='"+user_id+"' and to_char(t.datetime,'yyyy-mm-dd')='"+currenttime+"' and t.state like '%旷工%' ");
		if(Integer.parseInt(countExit1)!=0){
			return true;
		}
		
		
		//查询是否请假记录
		String countExit0 = DaoUtil.sqlToField("select count(*) from sx_ta_oa_electcheck_info t where t.userid='"+user_id+"' and to_char(t.datetime,'yyyy-mm-dd')='"+currenttime+"' and (t.state like '%事假%' or t.state like '%年休假%' or t.state like '%学习培训假%' or t.state like '%公差假%' or t.state like '%丧假%' or t.state like '%病(伤)假%' or t.state like '%产假%' or t.state like '%工伤假%' or t.state like '%婚假%' or t.state like '%计划生育假%' ) ");
		if(Integer.parseInt(countExit0)!=0){
			if(!userList.contains(user_id)){  //如果是半天假则继续判断
				return true;
			}
		}
		//查询是否是正常 迟到打卡
		String countExit2 = DaoUtil.sqlToField("select count(*) from sx_ta_oa_electcheck_info t where t.userid='"+user_id+"' and to_char(t.datetime,'yyyy-mm-dd')='"+currenttime+"' and to_date(t.start_time,'hh24:mi')<=to_date('"+start_time +"','hh24:mi') ");
		if(Integer.parseInt(countExit2)!=0){
			return true;
		}
		//查询是否是正常
		String countExit3 = DaoUtil.sqlToField("select count(*) from sx_ta_oa_electcheck_info t where t.userid='"+user_id+"' and to_char(t.datetime,'yyyy-mm-dd')='"+currenttime+"' and t.state like '%正常%'  ");
		if(Integer.parseInt(countExit3)!=0){
			return true;
		}
		return result;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 findElecStatExist(查询该用户考勤状态 是否已经有记录)
	  * @param user_id
	  * @param date
	  * @param state
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectDao#findElecStatExist(java.lang.String, java.lang.String, java.lang.String)
	 */
	public boolean findElecStatExist(String user_id,String date,String state,Connection conn) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select *  from  sx_ta_oa_electcheck_info t");
		sql.append(" where  t.userid = '"+user_id+"' ");
		sql.append(" and to_char(t.datetime, 'yyyy-mm-dd') = '"+date+"' ");
		if("旷工".equals(state)){
			sql.append(" and t.state  like '%旷工%' ");
		}else{
			sql.append(" and t.state  in ("+StringUtil.splitString(state, ",", "'")+")");
		}
		
		try{
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			if(pdb.size()>0){
				return true;
			} else {
				return false;
			}
			
		}catch(Exception e){
			throw e;
		}
	}
	
	public static void main(String[]args){
		ElectDaoImpl electdaoimpl = new ElectDaoImpl();
		try {
			electdaoimpl.setEclService();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	public List<String>  getHaLf (String currentDate,String t_data_type,String t_data_value) throws Exception{
		List<String> list = new ArrayList<String> ();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select t_user_id  from  ta_oa_attendanceleave t ");
		sql.append("  where to_char(t.t_starttime, 'yyyy-mm-dd') =? ");
		sql.append("  and t_data_type=? and t_data_value=? ");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, currentDate);
		pdb.setString(2, t_data_type);
		pdb.setString(3, t_data_value);
		pdb.executePrepared();
		for(int i=0 ; i<pdb.size() ; i++){
			list.add(pdb.getString(i,"t_user_id"));
		}
		return list;
	}
	
}
