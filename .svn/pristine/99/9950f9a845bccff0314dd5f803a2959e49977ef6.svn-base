<%@ page language="java" import="org.apache.commons.lang.StringUtils" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%
String userid = StringUtils.defaultString(request.getParameter("userid"));
String userName = StringUtils.defaultString(request.getParameter("userName"));
// rootId-根节点id, rootName-根节点名称, expandLevel-展开级数
String rootId = StringUtils.defaultString(request.getParameter("rootId"));
String rootName = StringUtils.defaultString(request.getParameter("rootName"));
String expandLevel = StringUtils.defaultString(request.getParameter("expandLevel"));
%>
<head>
	<title>选择机构用户</title>
</head>
<html>
	<SCRIPT LANGUAGE="JavaScript"> 		
	    var userid="<%=userid%>";
	    userid = "user-"+userid;
        var userRealName="<%=userName%>";
        var pre_ids=new Array();
            pre_ids[0]=userid;
		function uf_ok(){
		        var userNode =orgUserTreeFrame.tree.getChecked();				
		       
				if(userNode.length>0 && userNode[0].isLeaf())
				{   						
					userid =userNode[i].id.split("-")[1] ;
					userRealName= userNode[i].text;												
				}else{
					userRealName = "";
				}
				window.returnValue=userid + ";"+userRealName;
				window.close();
				
		}
    </SCRIPT>
	<body class="contentbodymargin">		
		<div align="center">
		 <br />
		 <iframe name="orgUserTreeFrame" height=85% width="100%"	src="tree/orgUserTree.jsp?userid=<%= userid%>&checkModel=single&rootId=<%=rootId %>&rootName=<%=rootName %>&expandLevel=<%=expandLevel %>" frameborder="0"></iframe>
		 <br />
		 <br />
		 <div align="center">
			<table width="25%" border="0" align="center" cellpadding="0"	cellspacing="0">
				<tr>
					<td>
						<div align="left">
							<input name="Submit" type="button" class="input" value="确定" onClick="uf_ok()">
						</div>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						<div align="left">
							<input name="cancel" type="button" class="input" value="取消" onClick="window.close()">
						</div>
					</td>
				</tr>
			</table>
		</div>
	   </div>
	</body>
	<script language="JavaScript">

	if(orgUserTreeFrame.document.getElementsByName("orguser")){
        var orgusers = orgUserTreeFrame.document.getElementsByName("orguser");
        for(var i=0; i<orgusers.length; i++){
        	if(orgusers[i].disabled == true){
            	orgusers[i].style.display = "none";
        	}
   		}
	}
	</script>
</html>
