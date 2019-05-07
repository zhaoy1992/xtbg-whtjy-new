<%@ page language="java" import="org.apache.commons.lang.StringUtils" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%
String orgid = StringUtils.defaultString(request.getParameter("orgid"));
// rootId-根节点id, rootName-根节点名称, expandLevel-展开级数
String rootId = StringUtils.defaultString(request.getParameter("rootId"));
String rootName = StringUtils.defaultString(request.getParameter("rootName"));
String expandLevel = StringUtils.defaultString(request.getParameter("expandLevel"));
%>
<head>
	<title>选择机构用户</title>
</head>
	<SCRIPT LANGUAGE="JavaScript"> 		
	    var ORG_ID_PRE="org-";
	    var USER_ID_PRE="user-";
	    var pre_ids="";
	    var pre_userid=window.dialogArguments.openTree_userids;
	    var pre_orgid="<%=orgid%>";
	    var names=parent.dialogArguments.openTree_names;
	    if(pre_userid!=""){
	       pre_ids=addUserPrefix(pre_userid)+addPrefix(pre_orgid);
	    }
	  
	    var pre_userids=pre_userid.split(",");
	    var pre_orgids=pre_orgid.split(",");
	    pre_ids=pre_ids.split(",");
        var pre_names=names.split(",");
		function uf_ok(){
		        var orgusers =orgUserTreeFrame.tree.getChecked();
		      
				var userids ="";
				var userRealNames = "";	
				var orgids = "";					
				for(var i=0;i<orgusers.length;i++){					
						if(orgusers[i].isLeaf())
						{   						
							userids = userids+orgusers[i].id.split("-")[1] + ",";
							userRealNames = userRealNames + orgusers[i].text + ",";													
						}
						else{
						  
							orgids = orgids + orgusers[i].id.split("-")[1] + ",";
							
						}

				}		
				// 保存用户上次选择，但并没有加载的节点值--用户选择痕迹保留	
	
				for(i=0;pre_userids!="" && i<pre_userids.length;i++){
				 
				   var node=orgUserTreeFrame.tree.getNodeById(USER_ID_PRE+pre_userids[i]);
				   if(typeof(node)!="object" &&pre_userids[i].length>0){
				      userids+=pre_userids[i]+",";
				      userRealNames+=pre_names[i]+",";
				   }
				   
				}
				// 机构痕迹
				
				for(i=0;i<pre_orgids.length;i++){
				   
				   var node=orgUserTreeFrame.tree.getNodeById(ORG_ID_PRE+pre_orgids[i]);
				   if(typeof(node)!="object" &&pre_orgids[i].length>0){
				      orgids+=pre_orgids[i]+",";

				   }
				   
				}
				userids = userids.substring(0,userids.length-1);	
				userRealNames = userRealNames.substring(0,userRealNames.length-1);
				orgids = orgids.substring(0,orgids.length-1);	
				window.returnValue=userids + ";"+userRealNames+";"+orgids;
				window.close();
				
		}
		
		function addPrefix(orgids){
		   if(orgids!="" && orgids.length>0){
		     var tempStr=orgids.split(",").join(","+ORG_ID_PRE);

		     return ","+ORG_ID_PRE+tempStr;
		     }
		   else
		     return "";
		}
		
		function addUserPrefix(userids){
		   if(userids!="" && userids.length>0){
		     var tempStr=userids.split(",").join(","+USER_ID_PRE);

		     return ","+USER_ID_PRE+tempStr;
		     }
		   else
		     return "";
		}
    </SCRIPT>
	<body class="contentbodymargin">		
		<div align="center">
		 <br />
		 <iframe name="orgUserTreeFrame" height=85% width="100%"	src="tree/orgUserTree.jsp?checkModel=cascade&rootId=<%=rootId %>&rootName=<%=rootName %>&expandLevel=<%=expandLevel %>" frameborder="0"></iframe>
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
