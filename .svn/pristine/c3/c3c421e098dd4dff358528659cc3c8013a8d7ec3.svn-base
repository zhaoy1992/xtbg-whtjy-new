<%@page import="com.chinacreator.xtbg.core.guestreception.service.impl.GuestreceptionServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.service.GuestreceptionServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.GuestReceiveBean"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.GuestBeanNew"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.GuestTravelBean"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>人员信息保存form</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	boolean flag = true;
	String windowsId=request.getParameter("widowsid");
	String action=request.getParameter("action");

	//获得要做的操作
	String whatDo=request.getParameter("whatDo");
	//获得来宾接待表单id
	String grinfoId=request.getParameter("grinfo_id");
	//基本非动态信息
	String baseinfo = request.getParameter("baseinfo");
	//基本信息
	GuestreceptionBean guestreceptionBean=new GuestreceptionBean();
	guestreceptionBean.setGrinfo_id(grinfoId);
	guestreceptionBean.setGrinfo_titile(request.getParameter("grinfo_titile"));
	guestreceptionBean.setGrinfo_receptionorg(request.getParameter("grinfo_receptionorg"));
	guestreceptionBean.setGrinfo_startime(request.getParameter("grinfo_startime"));
	guestreceptionBean.setGrinfo_endtime(request.getParameter("grinfo_endtime"));
	guestreceptionBean.setGrinfo_dutyofficer(request.getParameter("grinfo_dutyofficer"));
	guestreceptionBean.setGrinfo_dutyofficerid(request.getParameter("grinfo_dutyofficerid"));
	guestreceptionBean.setGrinfo_tel(request.getParameter("grinfo_tel"));
	guestreceptionBean.setGrinfo_guestcontact(request.getParameter("grinfo_guestcontact"));
	guestreceptionBean.setGrinfo_guestphone(request.getParameter("grinfo_guestphone"));
	guestreceptionBean.setGrinfo_sendpersonid(request.getParameter("grinfo_sendpersonid"));
	guestreceptionBean.setGrstatus_id(request.getParameter("grstatus_id"));
	guestreceptionBean.setGrinfo_content(request.getParameter("content"));
	guestreceptionBean.setGrinfo_orgid(request.getParameter("grinfo_orgid"));
	guestreceptionBean.setGrinfo_org(request.getParameter("grinfo_org"));
	//行程安排
 	String tstarttimeArray[] = request.getParameterValues("tstarttime");
	String ttstarttimeArray[] = request.getParameterValues("ttstarttime");
	String fromContentArray[] = request.getParameterValues("fromcontent");
	String accompanyArray[] = request.getParameterValues("accompany");
	String accompanyidArray[] = request.getParameterValues("accompanyid");
	String placeArray[] = request.getParameterValues("place");
	List<GuestTravelBean> travelList=new ArrayList<GuestTravelBean>();
	if(tstarttimeArray!=null){
		for(int i=0;i<tstarttimeArray.length;i++){
			GuestTravelBean guestTravelBean=new GuestTravelBean();
			guestTravelBean.setTstarttime(tstarttimeArray[i]);
			guestTravelBean.setTtstarttime(ttstarttimeArray[i]);
			guestTravelBean.setFromcontent(fromContentArray[i]);
			guestTravelBean.setAccompany(accompanyArray[i]);
			guestTravelBean.setAccompanyid(accompanyidArray[i]);
			guestTravelBean.setPlace(placeArray[i]);
			travelList.add(guestTravelBean);
		}
	}
	//宾客名单
	String guestnameArray[] = request.getParameterValues("guestname");
	String guestsexArray[] = request.getParameterValues("guestsex");
	String guestpostArray[] = request.getParameterValues("guestpost");
	List<GuestBeanNew> guestList=new ArrayList<GuestBeanNew>();
	if(guestnameArray!=null){
		for(int i=0;i<guestnameArray.length;i++){
			GuestBeanNew guestBeanNew=new GuestBeanNew();
			guestBeanNew.setGuestname(guestnameArray[i]);
			guestBeanNew.setGuestsex(guestsexArray[i]);
			guestBeanNew.setGuestpost(guestpostArray[i]);
			guestList.add(guestBeanNew);
		}
	}
	//陪同人员
	String ptusernameArray[] = request.getParameterValues("ptusername");
	String ptuseridArray[] = request.getParameterValues("ptuserid");
	String ptsexArray[] = request.getParameterValues("ptsex");
	String ptPostArray[] = request.getParameterValues("ptPost");
	List<GuestReceiveBean> guestReceiveList=new ArrayList<GuestReceiveBean>();
	if(ptusernameArray!=null){
		for(int i=0;i<ptusernameArray.length;i++){
			GuestReceiveBean guestReceiveBean=new GuestReceiveBean();
			guestReceiveBean.setPtusername(ptusernameArray[i]);
			guestReceiveBean.setPtuserid(ptuseridArray[i]);
			guestReceiveBean.setPtsex(ptsexArray[i]);
			guestReceiveBean.setPtpost(ptPostArray[i]);
			guestReceiveList.add(guestReceiveBean);
		}
	}
	//service对象
 	GuestreceptionServiceIfc guestreceptionServiceIfc = new GuestreceptionServiceImpl();
	try{
		if("1".equals(whatDo)){
				 guestreceptionServiceIfc.saveGuestInfo(guestreceptionBean, travelList, guestList, guestReceiveList);
		}else if("2".equals(whatDo)){
				//保存来宾接待信息，并返回id
				/* String grinfoid = guestreceptionServiceIfc.quickRelease(
						baseinfo, tstarttimelist, ttstarttimelist,
						fromContentlist, accompanylist, accompanyidlist,
						placelist, guestnamelist, guestsexlist, guestpostlist,
						guestUnitlist, ptusernamelist, ptuseridlist, ptsexlist,
						ptPostlist, ptUnitlist); */
			
		}else if("3".equals(whatDo)){
				//保存来宾接待信息，并返回id
		}else if("4".equals(whatDo)){
			guestreceptionServiceIfc.deleteGuestInfo(grinfoId);
		}else if("5".equals(whatDo)){
			guestreceptionServiceIfc.updatestatus(grinfoId, "2");
		}
	}catch(Exception e){
		flag=false;
	}
%>
<script type="text/javascript"	src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
</head>
<body>
	<script type="text/javascript">
		var bool = true;
		var submitAlertOK = function(){
			if("4"==<%=whatDo%> || "5"==<%=whatDo%>){
				window.parent.location.reload();
			}else{
				window.parent.removeWindows('<%=windowsId%>',true,false);
			}
			
	    }
		var p={
    			headerText:'操作信息',
    			okName:'确认',
    	        okFunction:submitAlertOK
    	};
		if (<%=flag%>) {
		    	alert('操作成功！！',p);
		} else {
			    alert('操作失败！！',p);
		}
	</script>
</body>
</html>