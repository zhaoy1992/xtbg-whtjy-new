<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.chinacreator.workflow.shark.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	String expkgids = (String)request.getParameter("expkgids");
	//tb_process表的主键
	String pid = "";
	//操作
	String op = (String)request.getParameter("op");
	String ec_id = (String)request.getParameter("ec_id");
	String xpdlContent = null;
	String mgrName = (String)request.getParameter("mgrName");
	mgrName=mgrName.replaceAll("~","#");
	//	add by minghua.guo 090616
	String remark = request.getParameter("remark");
	if(remark==null)remark = "";
	
	String closeUrl="http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/jawe/close.jsp?mgrName="+mgrName.replaceAll("#","~")+"&userName="+control.getUserName()+"&userId="+control.getUserID()+"&userAccount="+control.getUserAccount();
	if(op!=null&&(op.equals("modify")||op.equals("read")))
	{
		//修改或者查看的时候才有PID
		pid = (String)request.getParameter("pid");
		SharkEngine se=SharkEngine.getInstance();
		xpdlContent = se.getXPDLByMgrName(mgrName);
	}
	//是否保存流程活动数据
	String isSaveActData = (request.getParameter("isSaveActData")!=null)?"1":"0";

	String targetJsp = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/servicesearch/main.jsp";
	//System.out.println("jawe xpdl_open targetJsp:"+targetJsp);
	
	String zipFileName = request.getParameter("zipName");

	if(zipFileName!=null&&zipFileName.length()>0)
	{
		closeUrl += "&zipFileName="+zipFileName;
	}
	//System.out.println(closeUrl);
%>
<html>
	<head>
	<base target="_self">
		<script>			
			function onload()
			{
				<%
				if(op!=null&&(op.equals("modify")||op.equals("read"))){
				%>
					openXpdl("<%=ec_id%>");
				<%}else{%>
					newXpdl("<%=ec_id%>");
				<%}%>
			}
			
			function openXpdl(ec_id)
			{
				//window.showModalDialog("xpdl_open.jsp?ec_id='"+ec_id+"'");
				var ap=document.applets.jawe;
				ap.setCloseUrl("<%=closeUrl%>");
				ap.setSaveUrl("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/xpdl_save.jsp?userName=<%=control.getUserName()%>&userId=<%=control.getUserID()%>&userAccount=<%=control.getUserAccount()%>&pid=<%=pid%>");
				ap.setOpenUrl("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/open.jsp?userName=<%=control.getUserName()%>&userId=<%=control.getUserID()%>&userAccount=<%=control.getUserAccount()%>");
				ap.setEcId(ec_id);
				<%
					if(op.equals("read")){
				%>
					ap.setIsNew('read');
				<%
					}else{				
				%>
					ap.setIsNew('false');
				<%}%>
				ap.setPath("c:\\xpdls");
				ap.setFileName("<%=mgrName.replaceAll("#","~")%>");
				ap.setProtocol("http:");
				ap.setHost("<%=request.getServerName()%>");
				ap.setPort("<%=request.getServerPort()%>");
				ap.setContent("<%=request.getContextPath()%>");
				ap.setFormUrl("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/eformsys/fceform/design/design1.jsp?tbtype=1");
				
				//设置注册中心的URL
				//ap.setOpenRegisterCenterUrl("http://172.16.17.58:8080/soaepp/servicesearch/main.jsp");
				ap.setOpenRegisterCenterUrl("<%=targetJsp%>");
				
				
			}
			
			function newXpdl(ec_id)
			{
				var ap=document.applets.jawe;
				ap.setZipFileName("<%=request.getParameter("zipName")%>");
				//20090616 modify by minghua.guo add &isSaveActData
				ap.setSaveUrl("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/xpdl_save.jsp?userName=<%=control.getUserName()%>&userId=<%=control.getUserID()%>&userAccount=<%=control.getUserAccount()%>&remark=<%=remark%>&isSaveActData=<%=isSaveActData%>");
				ap.setOpenUrl("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/open.jsp?userName=<%=control.getUserName()%>&userId=<%=control.getUserID()%>&userAccount=<%=control.getUserAccount()%>");
				ap.setCloseUrl("<%=closeUrl%>");
				ap.setEcId(ec_id);
				ap.setIsNew('true');
				ap.setPath("c:\\xpdls");
				ap.setFileName("<%=mgrName.replaceAll("#","~")%>");
				<%
					if(expkgids!=null){
				%>
					ap.setEPkgids("<%=expkgids%>");
				<%}%>
				//alert("<%=expkgids%>");
				ap.setProtocol("http:");
				ap.setHost("<%=request.getServerName()%>");
				ap.setPort("<%=request.getServerPort()%>");
				ap.setContent("<%=request.getContextPath()%>");
				ap.setFormUrl("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/eformsys/fceform/design/design1.jsp?tbtype=1");
				//是否保存流程活动数据
				ap.setIsSaveActData("<%=isSaveActData%>");
				//设置注册中心的URL
				//ap.setOpenRegisterCenterUrl("http://172.16.17.58:8080/soaepp/servicesearch/main.jsp");
				ap.setOpenRegisterCenterUrl("<%=targetJsp%>");
				
			}
						
			function hideDiv()
			{
				//隐藏正在处理的进度条
				var processDiv = parent.document.all.divProcessing;
				if(processDiv)
				{
					processDiv.style.display = "none";
				}
				else
				{
					processDiv = document.all.divProcessing;
					if(processDiv)
					{
						processDiv.style.display = "none";
					}
				}
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body onload="onload()">
		<div id="obj_con" sytle="visibility : hidden ">
			<object classid="clsid:CAFEEFAC-0015-0000-0006-ABCDEFFEDCBA" name="jawe" width="1px" height="1px" codebase="http://java.sun.com/update/1.5.0/jinstall-1_5_0_06-windows-i586.cab#Version=5,0,60,5">
				<param name="java_code" value="com.chinacreator.jawe.JaweApplet">
				<param name="java_codebase" value=".">
				<param name="java_archive" value="graph.jar">
				<param name="type" value="application/x-java-applet;">
				<comment>
				<embed type="application/x-java-applet;" name="jawe" width="1px" height="1px" pluginspage="http://java.sun.com/products/plugin/index.html#download" java_code="com.chinacreator.jawe.JaweApplet" java_codebase="." java_archive="graph.jar" APP_ID="1"/>
				<noembed>
				
				</noembed>
				</comment>
			</object>
		</div>
	</body>
</html>

