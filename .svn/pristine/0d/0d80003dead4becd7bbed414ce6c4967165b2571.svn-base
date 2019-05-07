<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page language="java" contentType="text/html; charset=GBK" 
			import="com.chinacreator.security.AccessControl,
			com.chinacreator.spi.api.WorkflowManager,
			com.chinacreator.spi.impl.local.WorkflowManagerImpl,
			java.util.List,java.util.Map,java.util.HashMap"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	WorkflowManager wfm = new WorkflowManagerImpl();
	String proid = request.getParameter("unprocess");	
	if(!"".equals(proid)&& proid!=null){		
		wfm.deleteDODSLocksProcess(proid);		
	}		
%>

<html>
	<head>
		<title></title>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
		<script language="JavaScript">
	var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
	function validateOnlyCheck(checkName)
	{
		 var o = document.all.item(checkName);
		 for (var i=0,j=0; o && o.length && i<o.length; i++){
	   	  	if(o[i].checked)
	   	  	{
	   	  		j++;
	   	   	}
	   	   	if(j == 2)
	   	   	{
	   	   		return false;
	   	   	}
	   	   }
		 return true;
	}
	function validatecheck(checkName)
	{
			 var o = document.all.item(checkName);
		for (var i=0; o && o.length && i<o.length; i++){
	   	  	  if(o[i].checked)
	   	  	  	return true;
	   	   }
	   	   if(o && !o.length )
			{
				if(o.checked)
					return true;
			}
			return false;
	}	
	function checkAll(totalCheck,checkName){	//复选框全部选中
	   var selectAll = document.all.item(totalCheck);
	   
	   var o = document.all.item(checkName);
	   
	   if(selectAll.checked==true){
		   for (var i=0; o && o.length && i<o.length; i++){
	      	  if(!o[i].disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
		   if(o && !o.length && !o.checked)
			{
				o.checked=true;
			}
		   
	   }else{
		   for (var i=0; o && o.length && i<o.length; i++){
	   	  	  o[i].checked=false;
	   	   }
	   	   if(o && !o.length && !o.checked)
			{
				o.checked=false;
			}
	   	   
	   }
	}
	//单个选中复选框
	function checkOne(totalCheck,checkName){		
	   var selectAll = document.all.item(totalCheck);
	   var o = document.all.item(checkName);
		var cbs = true;		
		for (var i=0;o && o.length && i < o.length;i++){								
			if(!o[i].disabled){			
				if (o[i].checked==false){
					cbs=false;
				}				
			}
		}
		if(o && !o.length && !o.checked){
			cbs = false;
		}
		if(cbs){
			selectAll.checked=true;
		}
		else{
			selectAll.checked=false;
		}
	}
	
	function UNlock(checkName){			
		if(!validatecheck(checkName)){
			alert('请选择需要解锁的流程。');
			return;
		}
		var processId="";
		var unproceid="";
		var o = document.all.item(checkName);	
		for (var i=0;o && o.length && i < o.length;i++){
				if(!o[i].disabled){
					if (o[i].checked==true){															
						processId+=o[i].value+",";									
					}
				}
			}
		unproceid=processId.substring(0,processId.length-1);
		if(""==unproceid){
		unproceid=o.value;
		}		
      document.location = "lockmaster_list.jsp?unprocess="+unproceid;
	}	
</script>
<style>
body{margin:0; font-family:Arial, Helvetica, sans-serif; font-size:12px;}
td,div{line-height:170%}

.tab{border-collapse:collapse;font-size:12px;}
.tab th{background:url(<%=request.getContextPath()%>/epp/css/imagers/tab_bg.gif) repeat-x left; color:#666666;font-size:12px; font-weight:normal; height:25px;border:1px solid #ffffff; white-space:nowrap}
.tab td{border:1px solid #D1D5D8;white-space:nowrap; text-align:center; color:#666666}
.tab td a{color:#666666}
div{
 width:100%;
 height:100%;
 overflow-x:scroll;
 SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
 SCROLLBAR-SHADOW-COLOR: #D6E4F0;
 SCROLLBAR-3DLIGHT-COLOR: #D6E4F0;
 SCROLLBAR-ARROW-COLOR: #C1DAED;
 SCROLLBAR-TRACK-COLOR: #ffffff;
 SCROLLBAR-DARKSHADOW-COLOR: #ffffff;
 SCROLLBAR-BASE-COLOR: #ffffff;}
.inut_f{
	background:url(<%=request.getContextPath()%>/epp/css/imagers/input_bg.gif) 
	repeat-x left; 
	color:#ffffff; 
	border:1px solid #1A3BB7;
	padding-top:3px;
	padding-left:4px;
	padding-right:4px;}
</style>
</head>
	<body>
		<div>
			<FORM name="lockmaster" action="" method="post">
				<TABLE width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE" class="tab">					
						<tr>
						<td nowrap class="headercolor"><INPUT type="checkbox" style="cursor:hand" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">选择</td>							
						 <td nowrap class="headercolor">引擎名称</td>						
                         <td nowrap class="headercolor">流程实例</td>						 				
                         <td nowrap class="headercolor">数据表</td>
						 <td nowrap class="headercolor">缓  存</td>
						 <td nowrap class="headercolor"><input type="button" style="cursor:hand" name="tijiao" value="解 锁" onClick="UNlock('checkBoxOne')"/></td>
                        </tr>
                        <%
                        List locklist = wfm.getDODSLocksProcess();
							if(locklist.size()>0){
								for(int i=0;i<locklist.size();i++){
									Map mp=(Map)locklist.get(i);%>
						<tr>
						<td><INPUT type="checkbox" style="cursor:hand" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value="<%=(String.valueOf(mp.get("ID"))==null)?"":String.valueOf(mp.get("ID")) %>" ></td>						
						 <td><%=(String.valueOf(mp.get("ENGINENAME"))==null)?"":String.valueOf(mp.get("ENGINENAME")) %></td>						
                         <td><%=(String.valueOf(mp.get("ID"))==null)?"":String.valueOf(mp.get("ID")) %></td>						 						
                         <td><%=(String.valueOf(mp.get("locktableID"))==null)?"":String.valueOf(mp.get("locktableID")) %></td>
						 <td><%=(String.valueOf(mp.get("lockMasterID"))==null)?"":String.valueOf(mp.get("lockMasterID")) %></td>
						 <td></td>
                        </tr>
								<%}
							}
						%>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有信息
								</td>
							</tr>						
				</TABLE>				
			</FORM>
		</div>		
		
	</body>
</html>
