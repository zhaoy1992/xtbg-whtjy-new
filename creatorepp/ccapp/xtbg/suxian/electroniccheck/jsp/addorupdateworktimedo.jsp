
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectDaoImpl"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.service.impl.ElectServiceImpl"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean"%>

<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>JGRID</title>

<%
		AccessControl accesscontroler = AccessControl.getAccessControl();
		accesscontroler.checkAccess(request, response);
		String userid=accesscontroler.getUserID();
		String username = accesscontroler.getUserName();
		String userAccout = accesscontroler.getUserAccount();
		ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
		ResourceRoleUserBean rruBean = resourceRoleConfigDao.queryUserMatchOrg(userid);
		String orgname=rruBean.getOrgname();
		String orgid=rruBean.getOrgid();
		String dept_id=accesscontroler.getChargeOrgId();
		String dept_name=accesscontroler.getChargeOrgName();

		String action = request.getParameter("action");
		String start_ip = request.getParameter("start_ip");
		String start_time = request.getParameter("start_time");
		String date_time=request.getParameter("datetime");
		String rest_time=request.getParameter("rest_time");
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		ElectInfoBean electInfoBean = new ElectInfoBean();
		ElectInfoBean electInfoBean1 = new ElectInfoBean();
		ElectResetBean electResetBean = new ElectResetBean();
		electInfoBean.setDept_id(dept_id);
		electInfoBean.setDept_name(dept_name);
		electInfoBean.setReset_time(rest_time);
		electInfoBean.setDatetime(date_time);
		electInfoBean.setStart_time(start_time);
		
		electInfoBean.setOrgid(orgid);
		electInfoBean.setOrgname(orgname);
		electInfoBean.setUserid(userid);
		electInfoBean.setUsername(username);
		electInfoBean.setReset_time(rest_time);
		electInfoBean.setStart_ip(start_ip);
		ElectInfoDao poeManagerDao = (ElectInfoDao)DaoImplClassUtil.getDaoImplClass("electInfoDaoImpls");
		ElectDaoImpl dao = new ElectDaoImpl();
		boolean flag = false;
      if("leave".equals(action)){
    	  String areThere = request.getParameter("areThere");
    	  String currenttime = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    	  electInfoBean.setState("请假");
    	  electInfoBean.setDatetime(currenttime);
    	  if("Y".equals(areThere)){
    		  poeManagerDao.updateEndTime(electInfoBean);	//更新考勤
    	  }else{
    		  poeManagerDao.addInfos(electInfoBean);//添加考勤基本信息  
    		  
    	  }
    	 poeManagerDao.updateButtonState(userid,"2","2"); //修改上下班按钮状态
    	 flag = true;
		}else if("addoutsideInfo".equals(action)){
			 //外勤人员选择
			 String outside_userid = StringUtil.deNull(request.getParameter("outside_userid"));
			 String outside_username = StringUtil.deNull(request.getParameter("outside_name"));
			 String outsideIP = StringUtil.deNull(request.getParameter("outsideIP"));//考勤打卡IP
			 String details = StringUtil.deNull(request.getParameter("details"));//出勤详细信息
			 electResetBean = dao.querySetRecord(userid);//获得设置时间的上下班时间
			 ResouceConfigDaoImpl rrd = new ResouceConfigDaoImpl();
			 if(!StringUtil.isBlank(outside_userid)){
				 String [] outsideArray = outside_userid.split(",");
				 String [] outside_usernameArray = outside_username.split(",");
				 for(int i= 0 ;i< outsideArray.length; i++) {
					
					String otuser_id = outsideArray[i];//人员ID
					ResourceRoleUserBean resourceroleuserbean = rrd.queryUserMatchOrg(otuser_id);//人员信息
					ElectInfoBean electOutsideInfoBean = new ElectInfoBean();
					electOutsideInfoBean.setUserid(otuser_id);
					electOutsideInfoBean.setUsername(resourceroleuserbean.getUsername());
					electOutsideInfoBean.setOrgid(resourceroleuserbean.getOrgid());
					electOutsideInfoBean.setOrgname(resourceroleuserbean.getOrgname());
					electOutsideInfoBean.setDept_id(resourceroleuserbean.getOrgid());
					electOutsideInfoBean.setDept_name(resourceroleuserbean.getOrgname());
					electOutsideInfoBean.setDatetime(date_time);
					electOutsideInfoBean.setEnd_time(electResetBean.getEnd_time());
					electOutsideInfoBean.setStart_ip(outsideIP);
					electOutsideInfoBean.setEnd_ip(outsideIP);
					electOutsideInfoBean.setState("外勤");
					electOutsideInfoBean.setDetails(details);//出勤详细信息
					ElectInfoBean electOutInfoBean = poeManagerDao.isAddOrUpdate(electOutsideInfoBean);
					
					if(!StringUtil.isBlank(electOutInfoBean.getElect_id())){
						if(!StringUtil.isBlank(electOutInfoBean.getStart_time())&&StringUtil.deNull(electOutInfoBean.getState()).equals("正常")){
							poeManagerDao.updateElectInfoBean(electOutsideInfoBean);
						}
						//如果状态是迟到，还是迟到
						if(!StringUtil.isBlank(electOutInfoBean.getStart_time())&&StringUtil.deNull(electOutInfoBean.getState()).equals("迟到")){
							electOutsideInfoBean.setState("迟到");
							poeManagerDao.updateElectInfoBean(electOutsideInfoBean);
						}
						
					} else {
						electOutsideInfoBean.setStart_time(electResetBean.getStart_time());
						poeManagerDao.addInfos(electOutsideInfoBean);//添加考勤基本信息	 
					}
				 }
			
			 }
			flag = true;
		} else {
			electInfoBean1= poeManagerDao.isAddOrUpdate(electInfoBean);//获得基本信息上班时间
			electResetBean = dao.querySetRecord(userid);//获得设置时间的上下班时间
			ElectServiceImpl electdaoimpl= new ElectServiceImpl();
			//add by tieshan.he 半天假
			boolean isHalf = false;
			Map<String,String> map = map = poeManagerDao.ishalfDay(userAccout);
			if(map.size()>0 && "1".equals(map.get("date_type"))){
				isHalf = true;
			}
			String strtime = "";
			if(isHalf){
				 if("1".equals(map.get("type"))){
					 strtime = StringUtil.deNull(start_time) + " " +electResetBean.getAm_end_time() ;
				 }else{
					 if(sdf.parse(start_time).getTime()>sdf.parse(electResetBean.getPm_start_time()).getTime()){
						 electInfoBean.setStart_time(start_time);
					 }else{
						 electInfoBean.setStart_time(electResetBean.getPm_start_time());
					 }
					 strtime = StringUtil.deNull(start_time) + " " +electResetBean.getEnd_time() ;
				 }
				 electInfoBean.setState(electdaoimpl.judgeHalfState(electInfoBean.getUserid(),date_time+"",strtime,"",map.get("title"),map.get("type")));
				 poeManagerDao.updateHalfTime(electInfoBean);//添加考勤基本信息
			}else{
				strtime = StringUtil.deNull(start_time) + " " + electResetBean.getEnd_time() ;
				electInfoBean.setState(electdaoimpl.judgeState(electInfoBean.getUserid(),electInfoBean.getDatetime()+"",strtime,""));	
				poeManagerDao.addInfos(electInfoBean);//添加考勤基本信息
			}
			/* long date1 = sdf.parse(start_time).getTime();
			long date2 = sdf.parse(electResetBean.getStart_time()).getTime(); */
			
			
		    /*  if(date1<=date2){//如果上班开始时间小于规定的上班时间
		    	 electInfoBean.setState("正常");//修改上班状态
		     }
		     if(date1>date2){//如果上班开始时间大于规定的上班时间
		    	 electInfoBean.setState("迟到");//修改上班状态
		     } */
		     
				
			flag = true;
		}
		
	
%>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"
			src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功"; 
}else{
	mes = "操作失败"	;
	bool = false;
}
var ok=function(){
	window.parent.location.reload();
}
if(removeAlertWindows('',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	}
}
</script>
<body>
</body> 
</html>