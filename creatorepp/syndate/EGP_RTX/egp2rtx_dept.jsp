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
		<title>��֯��������</title>
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
    
    //ƽ̨����ȫѡ��ť������ָ��
    String ptallid = "";
    List ptidlist = pt.getAllorgID();
    if(ptidlist!=null){
    for(int i=0;i<ptidlist.size();i++){
      String id = (String)ptidlist.get(i);
      ptallid +=id+",";
     }
    }
    
    //RTX����ȫѡ��ť������ָ��    
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
	<title>��������</title>
	
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
   
   //ƽ̨����ͬ����RTX��������ȫѡ��ť
    function egp_rtx_add(type){
     var temp = "";
     var tempname = "";
     var tempid = "";
          
     temp+=getcheckid();
     
     if(temp == ""){
       alert("���ƽ̨������ѡ��Ҫͬ����ƽ̨����");  
       
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
    
    
    //ƽ̨����ͬ����RTX������ȫѡ��ť����
    function egp_rtx_addall(type){
      
      var temp = "";
      
      temp = document.getElementById("ptorgId").value = '<%=ptallid%>';
     
      document.getElementById("ptorgId").value = temp;
	  document.getElementById("selptorgid").value = temp;
	  document.getElementById("type").value = type;
      document.getElementById("selectegp2rtx").submit();
      
      document.body.disabled = true;
   
    }
    
    //RTX����ͬ����ƽ̨��������ȫѡ��ť
    function rtx_egp_add(type){
     var temp = "";
     var tempname = "";
     var tempid = "";
          
     temp+=getRtxcheckid();
     
     if(temp == ""){
       alert("���RTX������ѡ��Ҫͬ����RTX����");  
       
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
    
    //RTX����ͬ����ƽ̨������ȫѡ��ť
    function rtx_egp_addall(type){
      var temp = "";
      
      temp = document.getElementById("rtxdeptId").value = '<%=rtxallid%>';
     
      document.getElementById("rtxdeptId").value = temp;
	  document.getElementById("selrtxdeptid").value = temp;
	  document.getElementById("type").value = type;
      document.getElementById("selectegp2rtx").submit();
      
      document.body.disabled = true;
      
    }
    
    //��ȫѡ��ť������ƽ̨����IDѡ�񣬵���˸�ѡ����ܱ�ѡ�в�ִ��
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
   
   //��ȫѡ��ť������RTX����IDѡ�񣬵���˸�ѡ����ܱ�ѡ�в�ִ��
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
							<FONT size="2">����ͬ��</FONT>
						</LEGEND>
						<br />
				<table class="">
					<tr align="center"><td>ƽ̨</td><td></td><td>RTX</td></tr>
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
														scope="request" rootid="pttree" rootName="ƽ̨������" expandLevel="1"
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
														scope="request" rootid="rtxtree" rootName="RTX������" expandLevel="1"
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