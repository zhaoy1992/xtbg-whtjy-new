<%@ page language="java" import="org.apache.commons.lang.StringUtils" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%
// rootId-���ڵ�id, rootName-���ڵ�����, expandLevel-չ������
String rootId = StringUtils.defaultString(request.getParameter("rootId"));
String rootName = StringUtils.defaultString(request.getParameter("rootName"));
String expandLevel = StringUtils.defaultString(request.getParameter("expandLevel")); 
%>


<head>
	<title>ѡ�����</title>
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
				// �����û��ϴ�ѡ�񣬵���û�м��صĽڵ�ֵ--�û�ѡ��ۼ�����	

				
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
							<input name="Submit" type="button" class="input" value="ȷ��" onClick="uf_ok()">
						</div>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						<div align="left">
							<input name="cancel" type="button" class="input" value="ȡ��" onClick="window.close()">
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
