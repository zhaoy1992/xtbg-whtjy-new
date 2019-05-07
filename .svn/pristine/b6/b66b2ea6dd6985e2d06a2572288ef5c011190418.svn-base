<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.chinacreator.cms.votemanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.*"%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>My JSP 'questionnaire_do.jsp' starting page</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
  </head>
  
  <base target="_self">
  <body>
  <script language="javascript">
    <%
    	AccessControl accessControl = AccessControl.getInstance();
		accessControl.checkAccess(request,response);
		CMSManager cmsM = new CMSManager();
		cmsM.init(request,session,response,accessControl);
		int siteID = Integer.parseInt(cmsM.getSiteID());
		
		String channelName = request.getParameter("channelName") ;
		
    	VoteManager voteMgr  = new VoteManagerImpl();
    	if ("delete".equals((String)request.getParameter("actionType")))
    	{
    		if(voteMgr.deleteSurveyBy(
    						(String)request.getParameter("titleID"),
    						channelName,
    						accessControl.getUserAccount(),
    						accessControl.getUserName(),
    						request.getRemoteAddr())  ==1 )
    		{
    %>
    				alert("删除成功！");
    			  window.close();
    			  parent.window.dialogArguments.document.forms[0].submit();
    <%
    		}
    		else
    		{
    %>
    			alert("删除失败！");
    <%		}
    	}
    	else
    	{
    		Title oneTitle = new Title();
    	
    		List ipCtrls = VoteMngrProtocol.getIpCtrlFromString((String)request.getParameter("ipStartString"),
    														(String)request.getParameter("ipEndString"));
    		List timeCtrls = VoteMngrProtocol.getTimeCtrlFromString((String)request.getParameter("timeStartString"),
    														(String)request.getParameter("timeEndString"));
    														
    		oneTitle.setName((String)request.getParameter("titleName"));
    		oneTitle.setContent(request.getParameter("content"));
    		String picpath = request.getParameter("picpath");
    		String depart_id = request.getParameter("depart_id");
    		if(depart_id==null)
    		{
    		  depart_id="";
    		}
    		String ctime = request.getParameter("ctime");
    		 if(picpath!=null&&picpath.startsWith("uploadfiles")){
		    	picpath = "site"+siteID+"/_webprj/"+picpath ;
		    }		
    		oneTitle.setPicpath(picpath);
    		oneTitle.setDepart_id(depart_id);
    		oneTitle.setFoundDate(ctime);
    		if (request.getParameter("channelName")!=null)
    			oneTitle.setChannelName(request.getParameter("channelName"));
    		oneTitle.setTimeCtrls(timeCtrls);
    		oneTitle.setIpCtrls(ipCtrls);
    		oneTitle.setSiteid(siteID);
    		oneTitle.setQuestions(VoteMngrProtocol.getQuestionFromString((String)request.getParameter("questionString")));
    		if (request.getParameter("can_repeat")==null){
    			oneTitle.setIpRepeat(1);
    			oneTitle.setTimeGap(-1);
    		}
    		else{
    			oneTitle.setIpRepeat(0);
    			oneTitle.setTimeGap(Integer.parseInt((String)request.getParameter("selectGap")));
    		}
    		if ("".equals((String)request.getParameter("titleID"))){
    			oneTitle.setFounderID(Integer.parseInt(accessControl.getUserID()));
    			if(voteMgr.insertSurvey(oneTitle,accessControl.getUserAccount(),accessControl.getUserName(),request.getRemoteAddr())==1){
    				%>alert("增添问卷成功！");
    				  window.close();
    				  parent.window.dialogArguments.document.forms[0].submit();<%
    			}else{
    				%>alert("增添问卷失败！");<%
    			}
    		}else{
    			oneTitle.setId(Integer.parseInt((String)request.getParameter("titleID")));
    			if(voteMgr.modifySurvey(oneTitle,accessControl.getUserAccount(),accessControl.getUserName(),request.getRemoteAddr())==1){
    				%>alert("问卷更改成功！");
    				window.close();
    			    parent.window.dialogArguments.document.forms[0].submit();<%
    			}else{
    				%>alert("问卷更改失败！");<%
    			}
    		}
    	}
    %>
    </script>
    </base>
  </body>
</html>
