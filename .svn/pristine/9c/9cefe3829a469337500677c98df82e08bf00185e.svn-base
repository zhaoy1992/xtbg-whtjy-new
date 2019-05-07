
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ElectServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-1   Administrator    最初版本
   */
package com.chinacreator.xtbg.suxian.electroniccheck.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao;
import com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl;
import com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectDao;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectDaoImpl;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean;
import com.chinacreator.xtbg.suxian.electroniccheck.service.ElectServiceIfc;

/**
 *<p>Title:ElectServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-1
 */
public class ElectServiceImpl implements ElectServiceIfc {
	
	
	private static final Logger LOG = Logger.getLogger(ElectServiceImpl.class);
	/**
	 * 
	*<b>Summary: </b>
	* judgeState(判断是否迟到早退)
	* @return
	* @throws Exception
	 */
	public String judgeState(String user_id,String date,String strtime,String betweenDate)throws Exception{
		
		String[] time=strtime.split(" ");
		String state="正常";
		try {
			SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
			ElectDao dao =  new ElectDaoImpl();
			ElectResetBean electresetbean = dao.querySetRecord(user_id);
			int isState[]=new int[3]; //分别计算3段时间存在的时间个数(<=早上上班时间) [1] (早上上班<=time<=下午下班) isState[2]  表示上午下班卡     
			if(!StringUtil.isBlank(betweenDate)){
				isState[0]=1;
				isState[1]=1;
				isState[2]=1;
			}

			if(!StringUtil.isBlank(strtime) || !StringUtil.isBlank(betweenDate) ){
				if(StringUtil.isBlank(strtime)){
					if((isState[0]<1) || (isState[2]< 1)){
						state = "正常";
					}else{
						state = "请假";
					}
				}else{
					String startTime = time[0];
					String endTime = time[1];
					if(!StringUtil.isBlank(startTime)){
						 if(sdf.parse(startTime).getTime()<=sdf.parse(electresetbean.getStart_time()).getTime()&&sdf.parse(endTime).getTime()>=sdf.parse(electresetbean.getEnd_time()).getTime()){//如果上班开始时间小于规定的上班时间
							state = "正常";//修改上班状态
					     }
					     if(sdf.parse(startTime).getTime()>sdf.parse(electresetbean.getStart_time()).getTime()){//如果上班开始时间大于规定的上班时间
					    	 state = "迟到";//修改上班状态
					     }
					     if(!StringUtil.isBlank(endTime)){
					    	 if(sdf.parse(endTime).getTime()<sdf.parse(electresetbean.getEnd_time()).getTime()){
									state = "早退";
							 }	
					    	 if(sdf.parse(startTime).getTime()>sdf.parse(electresetbean.getStart_time()).getTime()&&sdf.parse(endTime).getTime()<sdf.parse(electresetbean.getEnd_time()).getTime()){
									state = "迟到且早退";
							 }
						 }
					}else{
						if(!StringUtil.isBlank(endTime)){
							if(sdf.parse(endTime).getTime()<sdf.parse(electresetbean.getEnd_time()).getTime()){
								state = "迟到且早退";
							}
						}
					}
				}
		}else{
			state="旷工";
		}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			throw e;
		}
		return state;
	}

	/**   
	 * 
	 *<b>Summary: </b>
	 * judgeState(用作半天假判断是否为早退与迟到)
	 * @param user_id
	 * @param date
	 * @param strtime   当前时间  用户设置的下班时间
	 * @param betweenDate
	 * @param reason
	 * @return
	 * @throws Exception
	 */
	public String judgeHalfState(String user_id,String date,String strtime,String betweenDate,String reason,String type)throws Exception{
		
		String[] time=strtime.split(" ");
		String state=reason+"/正常";
		try {
			SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
			ElectDao dao =  new ElectDaoImpl();
			ElectResetBean electresetbean = dao.querySetRecord(user_id);
			int isState[]=new int[3]; //分别计算3段时间存在的时间个数(<=早上上班时间) [1] (早上上班<=time<=下午下班) isState[2]  表示上午下班卡     
			if(!StringUtil.isBlank(betweenDate)){
				isState[0]=1;
				isState[1]=1;
				isState[2]=1;
			}

			if(!StringUtil.isBlank(strtime) || !StringUtil.isBlank(betweenDate) ){
				if(StringUtil.isBlank(strtime)){
					if((isState[0]<1) || (isState[2]< 1)){
						state = reason+"/正常";
					}else{
						state = reason+"/请假";
					}
				}else{
					String startTime = time[0];
					String endTime = time[1];
					if(!StringUtil.isBlank(startTime)){
						if("1".equals(type)){
							 if(sdf.parse(startTime).getTime()<=sdf.parse(electresetbean.getStart_time()).getTime() && sdf.parse(endTime).getTime()>=sdf.parse(electresetbean.getAm_end_time()).getTime()){//如果上班开始时间小于规定的上班时间
									state = reason+"/正常";       
							  }
							  if(sdf.parse(startTime).getTime()>sdf.parse(electresetbean.getStart_time()).getTime()){//如果上班开始时间大于规定的上班时间
							    	state = reason+"/迟到";     
							  }
							  if(!StringUtil.isBlank(endTime)){
							    if(sdf.parse(endTime).getTime()<sdf.parse(electresetbean.getAm_end_time()).getTime()){
									state = reason+"/早退";
								}	
							    if(sdf.parse(startTime).getTime()>sdf.parse(electresetbean.getStart_time()).getTime()&&sdf.parse(endTime).getTime()<sdf.parse(electresetbean.getAm_end_time()).getTime()){
									state = reason+"/迟到且早退";
								}
							}
						}else{
							if(sdf.parse(startTime).getTime()<=sdf.parse(electresetbean.getPm_start_time()).getTime() && sdf.parse(endTime).getTime()>=sdf.parse(electresetbean.getEnd_time()).getTime()){//如果上班开始时间小于规定的上班时间
								state = reason+"/正常";       
							}
							if(sdf.parse(startTime).getTime()>sdf.parse(electresetbean.getPm_start_time()).getTime()){//如果上班开始时间大于规定的上班时间
								 state = reason+"/迟到";      
							}
							if(!StringUtil.isBlank(endTime)){
								if(sdf.parse(endTime).getTime()<sdf.parse(electresetbean.getEnd_time()).getTime()){
									state = reason+"/早退";
								}	
								    if(sdf.parse(startTime).getTime()>sdf.parse(electresetbean.getPm_start_time()).getTime()&&sdf.parse(endTime).getTime()<sdf.parse(electresetbean.getEnd_time()).getTime()){
										state = reason+"/迟到且早退";
									}
								}
						}
					}else{
						if(!StringUtil.isBlank(endTime)){
							if("1".equals(type)){
								if(sdf.parse(endTime).getTime()<sdf.parse(electresetbean.getAm_end_time()).getTime()){
									state = reason+"/迟到且早退";
								}
							}else{
								if(sdf.parse(endTime).getTime()<sdf.parse(electresetbean.getEnd_time()).getTime()){
									state = reason+"/迟到且早退";
								}
							}
						}
					}
				}
		}else{
			state=reason+"/旷工";
		}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			throw e;
		}
		return state;
	}
	
	
	/**
	 * 
	*<b>Summary: </b>
	* cftime(时间数据格式化)
	* @param date
	* @return
	 */
	public Map<String, Timestamp> cftime(String date){
		Map<String, Timestamp> map=new HashMap<String, Timestamp>();
		String[] dates = date.split(",");
		String[] startTime=dates[0].split(" ");
		String[] endTime=dates[1].split(" ");
		map.put("startdate", DateUtil.parseTimeStringWithFormatStr(startTime[0], "yyyy-MM-dd"));
		map.put("starttime",DateUtil.parseTimeStringWithFormatStr(startTime[1],"HH:mm"));
		map.put("enddate", DateUtil.parseTimeStringWithFormatStr(endTime[0],"yyyy-MM-dd"));
		map.put("endtime",DateUtil.parseTimeStringWithFormatStr(endTime[1],"HH:mm"));
		return map;
	}

	/**
	*<b>Summary: </b>
	* getResElecSet(得到考勤设置的数据 根据ID)
	* @param elect_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getResElecSet(String elect_id) {
		
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			ElectDao dao = (ElectDao)DaoImplClassUtil.getDaoImplClass("electDaoImpl");
			viewMap = dao.getResElecSet(elect_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
		
	}
	
	/**
	*<b>Summary: </b>
	* findElecStatExist(查询该用户考勤状态 是否已经有记录)
	* @param user_id
	* @param date
	* @param state
	* @return
	 */
	public boolean findElecStatExist(String user_id,String date,String state){
		Connection conn = null;
		boolean falg = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			ElectDao dao = (ElectDao)DaoImplClassUtil.getDaoImplClass("electDaoImpl");
			falg = dao.findElecStatExist(user_id,date,state, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return falg;
	}
	
		/**
		*<b>Summary: </b>
		* punchStartClock(首页调用上班打卡方法)
		* @param user_id
		* @param userName
		* @param userAccout
		* @param ip
		* @return
		 */
	public String[] punchStartClock(String user_id,String userName,String userAccout,String ip){
		String [] arrResult = new String[2];
		boolean resultFlag = false;
		String result = ""; //消息信息
		boolean sucess = false;//是否已经打卡了
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			boolean isHalf = false;       //是否是半天假
			String currenttimeTemp= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			ElectInfoBean electInfoBeantemp = new ElectInfoBean();
			electInfoBeantemp.setDatetime(currenttimeTemp);
			electInfoBeantemp.setUserid(user_id);
			ElectInfoBean electInfoBeantemp1 = new ElectInfoBean();
			boolean flowFlag = false;//查询请假流程中 是否正处于【销假申请】请假结束日期 早于或等于当前系统日期
			ElectInfoDao electInfoDao = (ElectInfoDao)DaoImplClassUtil.getDaoImplClass("electInfoDaoImpls");
			//您有休假申请未销假，请将已休完假的申请单送销假登记。
			flowFlag = electInfoDao.queryflowleave(userAccout);
			
			//如请假,则判断是否为半天假  ;如果是，则进行考勤      add by tieshan.he
			Map<String,String> map = null;
			if(flowFlag){
				map = electInfoDao.ishalfDay(userAccout);
				if(map.size()>0 && "1".equals(map.get("date_type"))){
					isHalf = true;
					flowFlag = false;
				}
			}
			
			if(flowFlag==false){
				boolean flag = electInfoDao.findButtonState(currenttimeTemp,user_id);//判断电子考勤控制按钮表是否有数据,如果为true,说明已插入数据
				if(flag){
					electInfoBeantemp1 = electInfoDao.isAddOrUpdate(electInfoBeantemp);//查询当前日期的考勤基本信息
					if(!StringUtil.nullOrBlank(electInfoBeantemp1.getStart_time())){//如果考勤上班时间不为空
						electInfoDao.updateButtonState(user_id, "1", "0");//置灰上班按钮
						result ="您好,今天您已打上班卡。";
						sucess = true;//已经打过卡了
						resultFlag = true;
					}
					if(!StringUtil.nullOrBlank(electInfoBeantemp1.getEnd_time())){//如果下班时间不为空	
						electInfoDao.updateButtonState(user_id,"1","1");
					}
				} else {
					electInfoDao.addButtonState(currenttimeTemp, user_id);//给电子考勤控制按钮表添加数据
				}
				
				//获得作息时间值
				ElectDaoImpl dao = new ElectDaoImpl();
				ElectResetBean electresetBean=dao.querySetRecord(user_id);
				SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
				String start_time = new SimpleDateFormat("HH:mm").format(new Date());
				String date_time= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				String current_data = sdf.parse(start_time).getHours()+1+":"+sdf.parse(start_time).getMinutes();
				
				//当天是否已矿工
				ElectServiceIfc electserv = new ElectServiceImpl();
				boolean readyPushElc = electserv.findElecStatExist(user_id,currenttimeTemp,"旷工");
				if(readyPushElc==true){
					result ="您好,今天您已打卡。";
					sucess = true;//已经打过卡了
					resultFlag = true;
				}

				//不是重复打卡
				if(sucess==false){
					
						ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
						ResourceRoleUserBean rruBean = resourceRoleConfigDao.queryUserMatchOrg(user_id);
						String orgname = rruBean.getOrgname();
						String orgid = rruBean.getOrgid();
						String dept_id = rruBean.getOrgid();
						String dept_name = rruBean.getOrgname();
					
						String start_ip = ip;
						String rest_time="";
						if("1".equals(electresetBean.getReset_time())){
							rest_time="1";
						}
						else{
							rest_time="2";
						}
						ElectInfoBean electInfoBean = new ElectInfoBean();
						ElectResetBean electResetBean = new ElectResetBean();
						electInfoBean.setDept_id(dept_id);
						electInfoBean.setDept_name(dept_name);
						electInfoBean.setReset_time(rest_time);
						electInfoBean.setDatetime(date_time);
						electInfoBean.setStart_time(start_time);
						
						electInfoBean.setOrgid(orgid);
						electInfoBean.setOrgname(orgname);
						electInfoBean.setUserid(user_id);
						electInfoBean.setUsername(userName);
						electInfoBean.setReset_time(rest_time);
						electInfoBean.setStart_ip(start_ip);
						
						String infoState ="";//打卡状态
						
						electResetBean = dao.querySetRecord(user_id);//获得设置时间的上下班时间
						//获知打卡状态
						ElectServiceImpl electdaoimpl= new ElectServiceImpl();
						String strtime ="";
						if(isHalf){
							if(StringUtil.nullOrBlank(electResetBean.getAm_end_time()) || StringUtil.nullOrBlank(electResetBean.getPm_start_time())){
								result ="请设置上午下班时间和下午上班时间。";
								resultFlag = true;
								sucess = true;
							}else{
								 if("1".equals(map.get("type"))){
									 strtime = start_time + " " +electResetBean.getAm_end_time() ;
								 }else{
									 strtime = start_time + " " +electResetBean.getEnd_time() ;
									 if(sdf.parse(start_time).getTime()>sdf.parse(electResetBean.getPm_start_time()).getTime()){
										 electInfoBean.setStart_time(start_time);
									 }else{
										 electInfoBean.setStart_time(electResetBean.getPm_start_time());
									 }
								 }
								electInfoBean.setState(electdaoimpl.judgeHalfState(user_id,date_time+"",strtime,"",map.get("title"),map.get("type")));
								electInfoDao.updateHalfTime(electInfoBean);//添加考勤基本信息
							}							
						}else{
							strtime = start_time + " " +electResetBean.getEnd_time() ;
							electInfoBean.setState(electdaoimpl.judgeState(user_id,date_time+"",strtime,""));
							electInfoDao.addInfos(electInfoBean);
						}								
					    try{
					    	if(sucess == false){
								resultFlag = true;
								infoState = electInfoBean.getState();//打卡状态
								result = "您好，本次考勤状态为【"+infoState+"】，上班IP为：" + start_ip;
					    	}
					    }catch(Exception e){
					    	result ="您好,今天您已打上班卡。";
							resultFlag = true;
					    }
				}
			} else {
				result ="您有休假申请未销假，请将已休完假的申请单送销假登记。";
				resultFlag = true;
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		arrResult[0] =resultFlag+"";
		arrResult[1] =result;
		return arrResult;
	}
	
	/**
	*<b>Summary: </b>
	* punchEndClock(首页调用下班打卡方法)
	* @param user_id
	* @param ip
	* @return
	 */
	public String[] punchEndClock(String user_id,String userAccout,String username,String ip){
		String [] arrResult = new String[2];
		Connection conn = null;
		String result = ""; //消息信息
		boolean resultFlag = false;
		boolean sucess = false;//是否已经打卡了
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			
			boolean flowFlag = false;//查询请假流程中 是否正处于【销假申请】请假结束日期 早于或等于当前系统日期
			String currenttimeTemp= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			boolean isHalf = false;       //是否是半天假
			ElectInfoBean electInfoBeanTemp = new ElectInfoBean();
			electInfoBeanTemp.setDatetime(currenttimeTemp);
			electInfoBeanTemp.setUserid(user_id);
			ElectInfoBean electInfoBeanTemp1 = new ElectInfoBean();
			ElectInfoDao electInfoDao = (ElectInfoDao)DaoImplClassUtil.getDaoImplClass("electInfoDaoImpls");
			//您有休假申请未销假，请将已休完假的申请单送销假登记。
			flowFlag = electInfoDao.queryflowleave(userAccout);
			
			//如请假,则判断是否为半天假  ;如果是，则进行考勤      add by tieshan.he
			Map<String,String> map = null;
			if(flowFlag){
				map = electInfoDao.ishalfDay(userAccout);
				if(map.size()>0 && "1".equals(map.get("date_type"))){
					isHalf = true;
					flowFlag = false;
				}
			}
			
			if(flowFlag==false){
				boolean flag = electInfoDao.findButtonState(currenttimeTemp,user_id);//判断电子考勤控制按钮表是否有数据,如果为true,说明已插入数据
				if(flag){
					electInfoBeanTemp1 = electInfoDao.isAddOrUpdate(electInfoBeanTemp);//查询当前日期的考勤基本信息
					if(!StringUtil.nullOrBlank(electInfoBeanTemp1.getStart_time())){//如果考勤上班时间不为空
						electInfoDao.updateButtonState(user_id, "1", "0");//置灰上班按钮
					}
					if(!StringUtil.nullOrBlank(electInfoBeanTemp1.getEnd_time())){//如果下班时间不为空	
						electInfoDao.updateButtonState(user_id,"1","1");
						result ="您好,今天您已打下班卡。";
						sucess = true;//已经打过卡了
						resultFlag = true;
					}
				} else {
					electInfoDao.addButtonState(currenttimeTemp, user_id);//给电子考勤控制按钮表添加数据
				}
				
				//当天是否已矿工
				ElectServiceIfc electserv =new ElectServiceImpl();
				boolean readyPushElc = electserv.findElecStatExist(user_id,currenttimeTemp,"旷工");  //modify tieshan.he
				if(readyPushElc==true){
					result ="您好,今天您已打卡。";
					sucess = true;//已经打过卡了
					resultFlag = true;
				}
				
				//不是重复打卡
				if(sucess==false){
					
						ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
						ResourceRoleUserBean rruBean = resourceRoleConfigDao.queryUserMatchOrg(user_id);
						String orgname=rruBean.getOrgname();
						String orgid=rruBean.getOrgid();
					
						String dept_id = rruBean.getOrgid();
						String dept_name = rruBean.getOrgname();
						String end_ip = ip;
						String end_time =  new SimpleDateFormat("HH:mm").format(new Date());
						String date_time=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
						String rest_time="";
						ElectDaoImpl dao = new ElectDaoImpl();
						ElectResetBean electresetBean=dao.querySetRecord(user_id);//获得作息时间值
						if("1".equals(electresetBean.getReset_time())){
							rest_time="1";
						}
						else{
							rest_time="2";
						}
						ElectInfoBean electInfoBean = new ElectInfoBean();
						ElectInfoBean electInfoBean1 = new ElectInfoBean();
						ElectResetBean electResetBean = new ElectResetBean();
						electInfoBean.setDept_id(dept_id);
						electInfoBean.setDept_name(dept_name);
						electInfoBean.setReset_time(rest_time);
						electInfoBean.setDatetime(date_time);
						electInfoBean.setEnd_time(end_time);
						
						electInfoBean.setOrgid(orgid);
						electInfoBean.setOrgname(orgname);
						electInfoBean.setUserid(user_id);
						electInfoBean.setUsername(username);
						electInfoBean.setReset_time(rest_time);
						electInfoBean.setEnd_ip(end_ip);
						String infoState ="";//打卡状态
						electInfoBean1= electInfoDao.isAddOrUpdate(electInfoBean);//获得基本信息上班时间
						electResetBean = dao.querySetRecord(user_id);//获得设置时间的上下班时间
						//考勤状态
						String strtime = StringUtil.deNull(electInfoBean1.getStart_time())+ " "+ end_time;
						ElectServiceImpl electdaoimpl= new ElectServiceImpl();
						if(isHalf){
							electInfoBean.setState(electdaoimpl.judgeHalfState(user_id,date_time+"",strtime,"",map.get("title"),map.get("type")));
						}else{
							electInfoBean.setState(electdaoimpl.judgeState(user_id,date_time+"",strtime,""));
						}								
						if(StringUtil.isBlank(electInfoBean1.getElect_id())){
							electInfoDao.addInfos(electInfoBean);
						} else {
							electInfoDao.updateEndTime(electInfoBean);	
						}
						resultFlag=true;
						//打卡状态
						infoState = electInfoBean.getState();
						result = "您好，本次考勤状态为【"+infoState+"】，下班IP为：" + end_ip;
				}
			} else {
				result ="您有休假申请未销假，请将已休完假的申请单送销假登记。";
				resultFlag = true;
			}
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		arrResult[0] =resultFlag+"";
		arrResult[1] =result;
		return arrResult;
	}
	
	public static void main(String[]args){
		ElectServiceImpl electserviceimpl = new ElectServiceImpl();
		try {
			String result = electserviceimpl.judgeState("5278", "2014-09-03", "20:10 21:15", "");
			System.out.println(result+"=========");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public boolean isAbsenteeism(String user_id, String date, String state) {
		Connection conn = null;
		boolean falg = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			ElectDao dao = (ElectDao)DaoImplClassUtil.getDaoImplClass("electDaoImpl");
			falg = dao.findElecStatExist(user_id,date,state, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return falg;
	}

}
