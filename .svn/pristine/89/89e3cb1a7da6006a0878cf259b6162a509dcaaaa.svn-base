<%@ page language="java" import="org.apache.commons.lang.StringUtils" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%
// rootId-根节点id, rootName-根节点名称, expandLevel-展开级数
String rootId = StringUtils.defaultString(request.getParameter("rootId"));
String rootName = StringUtils.defaultString(request.getParameter("rootName"));
String expandLevel = StringUtils.defaultString(request.getParameter("expandLevel")); 
%>


<head>
	<title>选择机构</title>
</head>
	<SCRIPT LANGUAGE="JavaScript"> 		
	    var names=parent.dialogArguments.openTree_names;
	    var orgids=window.dialogArguments.openTree_userids;
	    var pre_ids=orgids.split(",");
	    var pre_orgids=orgids.split(",");
        var pre_names=names.split(",");
		function uf_ok(){
		        var orgusers =orgTreeFrame.tree.getChecked();
		      
				var orgids ="";
				var orgnames = "";			
				for(var i=0;i<orgusers.length;i++){					
							orgids = orgids + orgusers[i].id + ",";
							orgnames = orgnames + orgusers[i].text + ",";
				}		
				// 保存用户上次选择，但并没有加载的节点值--用户选择痕迹保留	

				
				for(i=0;i<pre_orgids.length;i++){
				   
				   var node=orgTreeFrame.tree.getNodeById(pre_orgids[i]);
				   if(typeof(node)!="object" &&pre_orgids[i].length>0){
				      orgids+=pre_orgids[i]+",";
				      orgnames+=pre_names[i]+",";
				   }
				   
				}
				orgids = orgids.substring(0,orgids.length-1);	
				orgnames = orgnames.substring(0,orgnames.length-1);	
				window.returnValue=orgids + ";"+orgnames;
				window.close();
		}
		
    </SCRIPT>
	<body class="contentbodymargin">		
		<div align="center">
		 <br />
		 <iframe name=orgTreeFrame height=85% width="100%"	src="tree/orgTree.jsp?checkModel=childCascade&rootId=<%=rootId %>&rootName=<%=rootName %>&expandLevel=<%=expandLevel %>" frameborder="0"></iframe>
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

	if(orgTreeFrame.document.getElementsByName("orguser")){
        var orgusers = orgTreeFrame.document.getElementsByName("orguser");
        for(var i=0; i<orgusers.length; i++){
        	if(orgusers[i].disabled == true){
            	orgusers[i].style.display = "none";
        	}
   		}
	}
	</script>
</html>
