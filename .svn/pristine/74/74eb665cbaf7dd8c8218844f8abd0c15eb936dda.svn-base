<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil,com.chinacreator.soa.uddi.UDDIv3SOAPService"%>
<%	
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	
	String pName = (String)request.getParameter("pName");
	String typeid = (String)request.getParameter("typeid");
	String class_name = (String)request.getParameter("class_name");
	String serviceKey="";
	String registerport="";
	String registerip="";
	try{
		DBUtil db=new DBUtil();
		String sql2="update tb_process set publishstate=2 where p_name like '%"+pName+"%'";
		db.executeUpdate(sql2);					
		UDDIv3SOAPService uss=new UDDIv3SOAPService();	
		String sql="select servicekey,registerip,registerport from td_soa_service_flow_map where service_name='"+pName+"'";
		db.executeSelect(sql);
		for(int i=0;i<db.size();i++){
		serviceKey=db.getString(i,"servicekey");
		registerip=db.getString(i,"registerip");
		registerport=db.getString(i,"registerport");		
		}
		String sql3="update td_soa_service_flow_map set SERVICEKEY='',REGISTERIP='',REGISTERPORT='' where SERVICE_NAME ='"+pName+"'";
		db.executeUpdate(sql3);	
		uss.delService(serviceKey,registerip,registerport);
	}catch(Exception e){
	e.printStackTrace();
	}	
%>
<html>
<head> 
  <title></title>  	  
  <script type="text/javascript">
    	window.location.href="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/properties_content.jsp?ec_id=<%=typeid%>&class_name=<%=class_name%>";	
  </script>
</head>
<body>
</body>
</html>
