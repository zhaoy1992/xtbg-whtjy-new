<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="UTF-8"%>

<%@ page import="com.chinacreator.cms.votemanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
		<META HTTP-EQUIV="pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
		<META HTTP-EQUIV="expires" CONTENT="Mon, 23 Jan 1978 20:52:30 GMT">
 <%
   	
    	AccessControl accessControl = AccessControl.getInstance();
		accessControl.checkAccess(request,response);
		
    	VoteManagerImpl voteMgr  = new VoteManagerImpl();
		if (!("search".equals((String)request.getParameter("actionType")))){
    	if ("delete".equals((String)request.getParameter("actionType"))){
    		if(voteMgr.deleteSurveyBy((String)request.getParameter("titleID"),request.getParameter("channel"),accessControl.getUserAccount(),accessControl.getUserName(),request.getRemoteAddr())==1){
    			%><SCRIPT language="javascript">alert("删除成功！");
    			 
    			
  var str = parent.document.location.href;
	var end = str.indexOf("?");
	var strArray;
	if(end != -1)
	 	strArray= str.slice(0,end);
	else
		strArray = str;
	parent.document.location.href = strArray+"?" + parent.document.all.queryString.value;
    			</script><%
    		}else{%>
    		<SCRIPT language="javascript">alert("删除失败！");
    			</script>
    		<%}
    	}
    	if ("settop".equals((String)request.getParameter("actionType"))){
    	    int flag = voteMgr.setSurveyTop((String)request.getParameter("titleID"),request.getParameter("channel"),accessControl.getUserAccount(),accessControl.getUserName(),request.getRemoteAddr());
    	    
    		if(flag==1){
    			%><SCRIPT language="javascript">alert("置顶成功！");
    		   var str = parent.document.location.href;
	var end = str.indexOf("?");
	var strArray;
	if(end != -1)
	 	strArray= str.slice(0,end);
	else
		strArray = str;
	parent.document.location.href = strArray+"?" + parent.document.all.queryString.value;</script><%
    		}else{
    		if(flag==2){%>
    		<SCRIPT language="javascript">alert("只能置顶已审核且未过期的调查！");
    			</script>
    		<%}else
    		{%>
    		  <SCRIPT language="javascript">alert("置顶失败！");
    			</script>
    		<%}
    		}
    	}
    	if ("canceltop".equals((String)request.getParameter("actionType"))){
    	  int flag = voteMgr.cancelSurveyTop((String)request.getParameter("titleID"),request.getParameter("channel"),accessControl.getUserAccount(),accessControl.getUserName(),request.getRemoteAddr());
    	   if(flag!=1){
    	     if(flag==2){
    			%><SCRIPT language="javascript">alert("只有已置顶的征集意见才能取消置顶！");
    			</script><%
    			}else{%>
    			<SCRIPT language="javascript">alert("取消置顶失败！");
    			</script>
    			<%}
    		}else{%>
    		<SCRIPT language="javascript">alert("取消置顶成功！");
    		    var str = parent.document.location.href;
	var end = str.indexOf("?");
	var strArray;
	if(end != -1)
	 	strArray= str.slice(0,end);
	else
		strArray = str;
	parent.document.location.href = strArray+"?" + parent.document.all.queryString.value;</script>
    		<%}
    	}
  		if ("unactive".equals(request.getParameter("actionType"))){
  		  int flag = voteMgr.unactivateSurveys(request.getParameter("sids"),request.getParameter("channel"),accessControl.getUserAccount(),accessControl.getUserName(),request.getRemoteAddr());
  			if(flag==1){
  				%><script language="javascript">alert("取消审核成功!");
  				
  				var str = parent.document.location.href;
	var end = str.indexOf("?");
	var strArray;
	if(end != -1)
	 	strArray= str.slice(0,end);
	else
		strArray = str;
	parent.document.location.href = strArray+"?" + parent.document.voteList.queryString.value;</script><%
  			}else{if(flag==2){%>
    		<SCRIPT language="javascript">alert("该问卷已取消审核，请不要重复取消审核！");
    			</script>
    		<%}else{%>
    		<SCRIPT language="javascript">alert("取消审核失败！");
    			</script>
    		<%}
    		}
  		}
    	if ("active".equals((String)request.getParameter("actionType"))){
    	int flag = voteMgr.activateSurveys((String)request.getParameter("sids"),request.getParameter("channel"),accessControl.getUserAccount(),accessControl.getUserName(),request.getRemoteAddr());
    		if(flag==1){
    			%><SCRIPT language="javascript">alert("审核成功！");
    			var str = parent.document.location.href;
    			
	var end = str.indexOf("?");
	var strArray;
	if(end != -1)
	 	strArray= str.slice(0,end);
	else
		strArray = str;
	parent.document.location.href = strArray+"?" + parent.document.voteList.queryString.value;</script><%
    		}else{
    		if(flag==2){%>
    		<SCRIPT language="javascript">alert("该问卷已通过审核，请不要重复审核！");
    			</script>
    		<%}else{%>
    		<SCRIPT language="javascript">alert("审核失败！");
    			</script>
    		<%}
    		}
    	}
    	if ("cancellook".equals((String)request.getParameter("actionType"))){
    	int flag = voteMgr.cancelSurveysLook((String)request.getParameter("sids"),request.getParameter("channel"),accessControl.getUserAccount(),accessControl.getUserName(),request.getRemoteAddr());
    		if(flag==1){
    			%><SCRIPT language="javascript">alert("取消查看成功！");
    			var str = parent.document.location.href;
	var end = str.indexOf("?");
	var strArray;
	if(end != -1)
	 	strArray= str.slice(0,end);
	else
		strArray = str;
	parent.document.location.href = strArray+"?" + parent.document.all.queryString.value;</script><%
    		}else{
    		if(flag==2){%>
    		<SCRIPT language="javascript">alert("该问卷已经取消查看，请不要重复取消！");
    			</script>
    		<%}else{%>
    		<SCRIPT language="javascript">alert("取消查看失败！");
    			</script>
    		<%}
    		}
    	}
    	if ("look".equals((String)request.getParameter("actionType"))){
    	int flag = voteMgr.setSurveysLook((String)request.getParameter("sids"),request.getParameter("channel"),accessControl.getUserAccount(),accessControl.getUserName(),request.getRemoteAddr());
    		if(flag==1){
    			%><SCRIPT language="javascript">alert("恢复查看成功！");
    			var str = parent.document.location.href;
	var end = str.indexOf("?");
	var strArray;
	if(end != -1)
	 	strArray= str.slice(0,end);
	else
		strArray = str;
	parent.document.location.href = strArray+"?" + parent.document.all.queryString.value;</script><%
    		}else{
    		if(flag==2){%>
    		<SCRIPT language="javascript">alert("该问卷已经恢复查看，请不要重复恢复！");
    			</script>
    		<%}else{%>
    		<SCRIPT language="javascript">alert("恢复查看失败！");
    			</script>
    		<%}
    		}
    	}
    	if ("clearvote".equals((String)request.getParameter("actionType"))){
    		if(voteMgr.clearVote((String)request.getParameter("titleID"),request.getParameter("channel"),accessControl.getUserAccount(),accessControl.getUserName(),request.getRemoteAddr())==1){
    			%><SCRIPT language="javascript">alert("投票结果清零成功！");
    			var str = parent.document.location.href;
	var end = str.indexOf("?");
	var strArray;
	if(end != -1)
	 	strArray= str.slice(0,end);
	else
		strArray = str;
	parent.document.location.href = strArray+"?" + parent.document.all.queryString.value;</script><%
    		}else{%>
    		<SCRIPT language="javascript">alert("投票结果清零失败！");
    			</script>
    		<%}
    	}
    	}

   %>
