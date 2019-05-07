<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.garbagemanager.GarbageManager"%>
<%@ page import="com.chinacreator.cms.garbagemanager.GarbageManagerImp"%>


<%
	AccessControl accesscontroler = AccessControl.getInstance();
    if(!accesscontroler.checkAccess(request, response))
    	return;
    	
    String delFileNames = request.getParameter("delFileNames") ;
    String path = request.getParameter("path");
     
    if(delFileNames != null && path != null 
    		&& !delFileNames.equals("") && !path.equals(""))
    {
    	GarbageManager garbageManager = new GarbageManagerImp();
    	String[] fileNames = delFileNames.split(";") ;
    	garbageManager.deleteFilesOfGarbage(path,fileNames) ;
    }
%>
