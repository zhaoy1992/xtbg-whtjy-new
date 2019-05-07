<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.syndatemanager.rtxmanager"%>

<%@ page import="com.chinacreator.syndatemanager.RTXUser"%>
<%@ page import="com.chinacreator.syndatemanager.RTXDept"%>
<%@ page import="com.chinacreator.syndatemanager.Rtxsyn"%>
<%@ page import="com.chinacreator.syndatemanager.syndata_record"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.syndatemanager.EGP_Tree" %>
<%@ page import="com.chinacreator.syndatemanager.RTX_Tree"%>
<%@page import="com.chinacreator.syndatemanager.ptmanager"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<title>组织机构管理</title>
		<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.syndatemanager.rtxmanager"%>
<%@ page import="com.chinacreator.syndatemanager.ptmanager" %>

<%@ page import="com.chinacreator.syndatemanager.RTXUser"%>
<%@ page import="com.chinacreator.syndatemanager.RTXDept"%>
<%@ page import="com.chinacreator.syndatemanager.Rtxsyn"%>
<%@ page import="com.chinacreator.syndatemanager.syndata_record"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>

<% AccessControl accesscontroler = AccessControl.getInstance();
   accesscontroler.checkAccess(request, response);
    rtxmanager rtx = new rtxmanager();
    RTXDept rtxdept = new RTXDept();
    ptmanager pt = new ptmanager();
    
    //平台机构全选按钮参数的指定
    String ptallid = "";
    List ptidlist = pt.getAllorgID();
    if(ptidlist!=null){
    for(int i=0;i<ptidlist.size();i++){
      String id = (String)ptidlist.get(i);
      ptallid +=id+",";
     }
    }
    
    //RTX机构全选按钮参数的指定    
    String rtxallid = "";
    List  rtxidlist = rtx.getAllRtxDept();
    if(rtxidlist!=null){
      for(int i=0;i<rtxidlist.size();i++){
       rtxdept = (RTXDept)rtxidlist.get(i);
       String id = rtxdept.getDeptId();
       rtxallid+=id+",";
      }
    }
%>



<html>
  <head>
   <meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>属性容器</title>
	
	<script language="JavaScript" type="text/javascript">
   
    
    function link(orgId,orgName){
     
     document.getElementById("ptorgId").value = orgId;
     document.getElementById("ptresName").value = orgName;
     // document.Form1.submit();
     
   }
    
    function rtxlink(rtxdeptId,rtxtreeName){
    
    document.getElementById("rtxdeptId").value = rtxdeptId;
    document.getElementById("rtxresName").value = rtxtreeName;
   }
   
   //平台机构同步到RTX机构，非全选按钮
    function egp_rtx_add(type){
     var temp = "";
     var tempname = "";
     var tempid = "";
          
     temp+=getcheckid();
     
     if(temp == ""){
       alert("请从平台机构树选择要同步的平台机构");  
       
       return false;
     }
       
     var obj = new Array();
			obj = temp.split(",");
			for(var j=0;j<obj.length-1;j++){
				for(var k=j+1;k<obj.length;k++){
					if(obj[k]!=""){
						if(obj[j]==obj[k]){							
							obj[k]="";
						}
				 }
				}
			}
		
	    document.getElementById("ptorgId").value = temp;
		document.getElementById("selptorgid").value = temp;
		document.getElementById("type").value = type;
        document.getElementById("selectegp2rtx").submit();
       
        document.body.disabled = true;
	  
    }
    
    
    //平台机构同步到RTX机构，全选按钮操作
    function egp_rtx_addall(type){
      
      var temp = "";
      
      temp = document.getElementById("ptorgId").value = '<%=ptallid%>';
     
      document.getElementById("ptorgId").value = temp;
	  document.getElementById("selptorgid").value = temp;
	  document.getElementById("type").value = type;
      document.getElementById("selectegp2rtx").submit();
      
      document.body.disabled = true;
   
    }
    
    //RTX机构同步到平台机构，非全选按钮
    function rtx_egp_add(type){
     var temp = "";
     var tempname = "";
     var tempid = "";
          
     temp+=getRtxcheckid();
     
     if(temp == ""){
       alert("请从RTX机构树选择要同步的RTX机构");  
       
       return false;
     }
       
     var obj = new Array();
			obj = temp.split(",");
			for(var j=0;j<obj.length-1;j++){
				for(var k=j+1;k<obj.length;k++){
					if(obj[k]!=""){
						if(obj[j]==obj[k]){							
							obj[k]="";
						}
				 }
				}
			}
		
	    document.getElementById("rtxdeptId").value = temp;
		document.getElementById("selrtxdeptid").value = temp;
		document.getElementById("type").value = type;
        document.getElementById("selectegp2rtx").submit();
        
        document.body.disabled = true;
    }
    
    //RTX机构同步到平台机构，全选按钮
    function rtx_egp_addall(type){
      var temp = "";
      
      temp = document.getElementById("rtxdeptId").value = '<%=rtxallid%>';
     
      document.getElementById("rtxdeptId").value = temp;
	  document.getElementById("selrtxdeptid").value = temp;
	  document.getElementById("type").value = type;
      document.getElementById("selectegp2rtx").submit();
      
      document.body.disabled = true;
      
    }
    
    //非全选按钮操作，平台机构ID选择，点击了复选框才能被选中并执行
    function getcheckid(){
       var selid="";
       var obj = document.getElementsByName("ptlist");
       for(var i=0;i<obj.length;i++){
         if(obj[i].checked){
           selid+=obj[i].value + ",";
         }
       }
       return selid;
    }
   
   //非全选按钮操作，RTX机构ID选择，点击了复选框才能被选中并执行
    function getRtxcheckid(){
       var selid = "";
       var obj = document.getElementsByName("rtxlist");
       for(var i=0;i<obj.length;i++){
         if(obj[i].checked){
          selid+=obj[i].value + ",";
        }
      }
       return selid; 
    }

 
  	</script>
	<link rel="stylesheet" type="text/css" href="../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../css/treeview.css">
  </head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
	
	<form name="selectegp2rtx" method="post" action="do_egp2rtx_add.jsp" target="rtxhiddenform1">
	 <input name="selptorgid" value="" type="hidden">
	 <input name="selrtxdeptid" value="" type="hidden">
	 <input name="type" value="" type="hidden">
	</form>
	
	<br><br>
		<form name="Form1" method="post">
	
		  <div id="contentborder" style="width:100%;height:530;overflow:auto"
				align="center">
				<fieldset style="width: 85%;">
						<LEGEND align=center>
							<FONT size="2">数据同步</FONT>
						</LEGEND>
						<br />
				<table class="">
					<tr align="center"><td>平台</td><td></td><td>RTX</td></tr>
					<tr align="center">
						<td valign="top">
							<div style="width: 300;height: 300;border:inset;">
								<table class="table" width="50%" border="0" cellpadding="0"
									cellspacing="1">

									<tr class="tr">
										<td class="td">
											<div
												style="width: 290;height: 290;overflow:scroll;border:inset;">
											
												<tree:tree tree="egp2rtx_org"
													node="egp2rtx_org.node"
													imageFolder="../../sysmanager/images/tree_images/"
													collapse="true" 
													includeRootNode="true"
													target="ptorg_list" mode="static-dynamic">
													
													<tree:checkbox name="ptlist"/>
													<tree:treedata
														treetype="com.chinacreator.syndatemanager.EGP_Tree"
														scope="request" rootid="pttree" rootName="平台机构树" expandLevel="1"
														showRootHref="true" needObserver="false"
														enablecontextmenu="true" />
												</tree:tree>
												
											</div>
										</td>
									</tr>
								</table>
							</div>
							<input name="Egp_Org_obj" value="" type="hidden">
						</td> 
						<td valign="middle">
						
							<input type="button" value=">" class="input" onclick="egp_rtx_add('egp2rtx');">
							<br />
							<input type="button" value=">>" class=" input" onclick="egp_rtx_addall('egp2rtxall');">
							<br />
							<input type="button" value="<<" class="input" onclick="rtx_egp_addall('rtx2egpall');">
							<br />
							<input type="button" value="<" class="input" onclick="rtx_egp_add('rtx2egp');">
					 	</td>
						<td>
						<div style="width: 300;height: 300;border:inset;">
							<table class="table" width="50%" border="0" cellpadding="0"
									cellspacing="1">

									<tr class="tr">
										<td class="td">
											<div
												style="width: 290;height: 290;overflow:scroll;border:inset;">
												
												<tree:tree tree="egp2rtx_dept"
													node="egp2rtx_dept.node"
													imageFolder="../../sysmanager/images/tree_images/"
													collapse="true" 
													includeRootNode="true"
													target="rtxdept_list" mode="static-dynamic">
													<tree:checkbox name="rtxlist"/>
													
													<tree:treedata
														treetype="com.chinacreator.syndatemanager.RTX_Tree"
														scope="request" rootid="rtxtree" rootName="RTX机构树" expandLevel="1"
														showRootHref="true" needObserver="false"
														enablecontextmenu="false" />
												</tree:tree>
												
												 
											</div>
										</td>
									</tr>
								</table>
							</div>
							<input name="Rtx_Dept_obj" value="" type="hidden">
						</td>
					</tr>
				</table>
				
				<input name="ptorgId" value="" type="hidden">
				<input name="ptresName" value="" type="hidden">
				<input name="rtxdeptId" value="" type="hidden">
				<input name="rtxresName" value="" type="hidden">
				
				</fieldset>
				
			</div>
			 
		</form>
		<iframe name="saveres" width="0" height="0"></iframe>
		<iframe name="rtxhiddenform1" width="0" height="0"></iframe>
	</body>

</html>