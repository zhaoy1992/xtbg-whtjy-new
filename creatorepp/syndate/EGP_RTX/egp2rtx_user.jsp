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
		<title>��������</title>

		<%@ include file="/epp/css/cssControl.jsp"%>
		
<%@ page import="com.chinacreator.syndatemanager.rtxmanager"%>
<%@ page import="com.chinacreator.syndatemanager.ptmanager" %>

<%@ page import="com.chinacreator.syndatemanager.RTXUser"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.UserManagerImpl" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl" %>
<%@ page import="com.chinacreator.syndatemanager.RTXDept"%>
<%@ page import="com.chinacreator.syndatemanager.Rtxsyn"%>
<%@ page import="com.chinacreator.syndatemanager.syndata_record"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>

<%

AccessControl accesscontroler = AccessControl.getInstance();
   accesscontroler.checkAccess(request, response);
   
    rtxmanager rtx = new rtxmanager();
    RTXDept rtxdept = new RTXDept();
    ptmanager pt = new ptmanager();
    
    RTXUser rtxuser = new RTXUser();
    
    
    //ƽ̨�����û�ȫѡ��ť������ָ��
    String ptallusername = "";
    UserManagerImpl usermanager = new UserManagerImpl();
    List ptuserlist = usermanager.getUserList();
    if(ptuserlist!=null){
    for(int i=0;i<ptuserlist.size();i++){
      User user = (User)ptuserlist.get(i);
      String username = user.getUserName();
      ptallusername +=username+",";
     }
    }
    
    //RTX�����û�ȫѡ��ť������ָ��    
    String rtxallusername = "";
    List  rtxuserlist = rtx.getUserNameCollection();
    if(rtxuserlist!=null){
      for(int i=0;i<rtxuserlist.size();i++){
       String username = (String)rtxuserlist.get(i);
       rtxallusername+=username+",";
      }
    }

%>
<script language="JavaScript"  type="text/javascript">
		
	 //ƽ̨�����û�ͬ����RTX��������ȫѡ��ť
    function egp2rtxuser(type){
     var temp = "";
     var tempname = "";
     var tempid = "";
          
     temp+=getcheckid();
     
     if(temp == ""){
       alert("���ƽ̨�����û���ѡ��Ҫͬ����ƽ̨�û�");  
       
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
		
	    document.getElementById("ptusername").value = temp;
		document.getElementById("selptusername").value = temp;
		document.getElementById("type").value = type;
        document.getElementById("select").submit();
        
        document.body.disabled = true;
         
	    
    }
    
    
    //ƽ̨�����û�ͬ����RTX������ȫѡ��ť����
    function egp2rtxuserall(type){
      
      var temp = "";
      
      temp = document.getElementById("ptusername").value = '<%=ptallusername%>';
     
      document.getElementById("ptusername").value = temp;
	  document.getElementById("selptusername").value = temp;
	  document.getElementById("type").value = type;
      document.getElementById("select").submit();
      
      document.body.disabled = true;
      
    }
    
    //RTX�����û�ͬ����ƽ̨��������ȫѡ��ť
    function rtx2egpuser(type){
     var temp = "";
     var tempname = "";
     var tempid = "";
          
     temp+=getRtxcheckid();
     
     if(temp == ""){
       alert("���RTX�����û���ѡ��Ҫͬ����RTX�û�");  
       
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
		
	    document.getElementById("rtxusername").value = temp;
		document.getElementById("selrtxusername").value = temp;
		document.getElementById("type").value = type;
        document.getElementById("select").submit();
        
        document.body.disabled = true;
    }
    
    //RTX�����û�ͬ����ƽ̨������ȫѡ��ť
    function rtx2egpuserall(type){
      var temp = "";
      
      temp = document.getElementById("rtxusername").value = '<%=rtxallusername%>';
     
      document.getElementById("rtxusername").value = temp;
	  document.getElementById("selrtxusername").value = temp;
	  document.getElementById("type").value = type;
      document.getElementById("select").submit();
      
      document.body.disabled = true;
      
    }
    
    //��ȫѡ��ť������ƽ̨����IDѡ�񣬵���˸�ѡ����ܱ�ѡ�в�ִ��
    function getcheckid(){
       var selid="";
       var obj = document.getElementsByName("ptuserlist");
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
       var obj = document.getElementsByName("rtxuserlist");
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
	
	<form name="select" method="post" action="do_user.jsp" target="submituser">
	 <input name="selptusername" value="" type="hidden">
	 <input name="selrtxusername" value="" type="hidden">
	 <input name="type" value="" type="hidden">
	</form>
	<br><br>
		<form name="synuser" method="post">
				
			
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
												<tree:tree tree="egp2rtx_orguser"
													node="egp2rtx_orguser.node"
													imageFolder="../../sysmanager/images/tree_images/"
													collapse="true" 
													includeRootNode="true"
													target="orguser_list" mode="static-dynamic">
													<tree:checkbox name="ptuserlist"/>
													<tree:treedata
														treetype="com.chinacreator.syndatemanager.OrgUserTree1"
														scope="request" rootid="orgusertree" rootName="ƽ̨�����û���" expandLevel="1"
														showRootHref="true" needObserver="false"
														enablecontextmenu="false" />
												</tree:tree>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</td>
						<td valign="middle">
							<input type="button" value=">" class="input" onclick="egp2rtxuser('egp2rtx');">
							<br />
							<input type="button" value=">>" class="input" onclick="egp2rtxuserall('egp2rtxall');">
							<br />
							<input type="button" value="<<" class="input" onclick="rtx2egpuserall('rtx2egpall');">
							<br />
							<input type="button" value="<" class="input" onclick="rtx2egpuser('rtx2egp');">
						</td>
						<td>
						<div style="width: 300;height: 300;border:inset;">
							<table class="table" width="50%" border="0" cellpadding="0"
					 				cellspacing="1">

									<tr class="tr">
										<td class="td">
											<div
												style="width: 290;height: 290;overflow:scroll;border:inset;">
												<tree:tree tree="egp2rtx_deptuser"
													node="egp2rtx_deptuser.node"
													imageFolder="../../sysmanager/images/tree_images/"
													collapse="true" 
													includeRootNode="true"
													target="rtxuser_list" mode="static-dynamic">
													<tree:checkbox name="rtxuserlist"/>
													<tree:treedata
														treetype="com.chinacreator.syndatemanager.RtxDeptUserTree"
														scope="request" rootid="rtxusertree" rootName="RTX�����û���" expandLevel="1"
														showRootHref="true" needObserver="false"
														enablecontextmenu="false" />
												 </tree:tree>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
				<input name="ptusername" value="" type="hidden">
				<input name="rtxusername" value="" type="hidden">
				
				
				
            </fieldset>
			</div>
			
		</form>
		<iframe name="submituser" width="0" height="0"></iframe>
	</body>
</html>