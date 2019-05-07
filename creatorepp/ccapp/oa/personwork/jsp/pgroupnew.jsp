<%--  
描述：新建分组
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@page import="com.chinacreator.xtbg.core.personwork.service.*"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.personwork.entity.PGroupBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String loginUserID = accesscontroler.getUserID();
	String personids = request.getParameter("personids");
    String groupshowids = request.getParameter("groupshowids");
    String is_public = request.getParameter("is_public");//是否公共通讯录(即外部通讯录)
    
	//个人通讯录操作的service对象
    PersonInfoServiceIfc service = new PersonInfoServiceImpl();
  //获得当前用户的所有分组信息
    List<PGroupBean> pgBeanList = service.queryGroup(loginUserID, is_public);
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人通讯录分组管理</title>
<link href="../../resources/style/blue/css/tjz.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>


<script type="text/javascript">

$(function(){
	
	$(document).keydown(function(){
	    
	    if(event.keyCode == 13){
		    jQuery("#formAdd").bind("submit",function(){
	            event.preventDefault();
	            
	        })
	         createNewGroup();
	    }
	});
	jQuery("#formAdd").validationEngine();
	
	
})
var loginUserID=<%=loginUserID%>
/**
 * 编辑分组信息
 */
function editGroupInfo(groupId){
	openAlertWindows('windowId_1',getCurrentFilePath()+'pgroupedit.jsp?groupId='+groupId,'重命名',300,150,'35%','40%');
}

/**
 * 删除分组信息
 */
function deleteGroupInfo(groupId){
	openAlertWindows('windowId_1',getCurrentFilePath()+'pgroupdelete.jsp?groupId='+groupId,'提示',220,110,'35%','40%');

}

/** 
 * 创建新分组-取消
 */ 
function showCreateNewGroup(){
	$("#groupName").val("");
	if($("#createNewGroupArea").is(":hidden")){
		$("#createNewGroupArea").show();
		$("#cancelNewGroupArea").hide();
	}else{
		$("#createNewGroupArea").hide();
		$("#cancelNewGroupArea").show();
		
	}
}
/** 
  *创建分组 
  */
function createNewGroup(){
	var paramjosn = "";
	paramjosn = "{'loginUserID':'" +  loginUserID + 
	"','groupName':'" + $("#groupName").val()+"','is_public_group':'<%=is_public%>'}";
	$("#paramjosn").val(paramjosn);
	$("#formAdd").attr("target","hiddenFrame");
	$("#formAdd").attr("action","pgroupadddo4mybook.jsp");
	
	$('#formAdd').submit();
}

/**  
  * 关闭按钮
  */
 function back(){
	var mes = "操作成功";
	var bool = true;
	var ok=function(){
		window.parent.location.reload();
	}
	if(window.top.removeAlertWindows('',false,bool,mes,true,false,true)){
		if(bool){
			window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
		}
		else{
			window.top.alert(mes)
		}
	}
}

</script>
</head>

<body style="overflow: hidden;">
	<div class="vcenter" id="vcenter" style="overflow:auto;height:222px;" >   
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tj2">
	
	    <%int colnum = 2;//每行显示的列数
	    for(int i = 0 ; i < pgBeanList.size() ; i ++){//循环分组集合
	    	PGroupBean pgBean = pgBeanList.get(i);
	    	if(i%colnum == 0){//每两个元素放一行，故下标除以2余0，则增加tr%>
	    	<tr>	
	    <%	}
	    %>
	   		<td valign="top">
	   		<div class="tjdiv"><%=pgBean.getGroupName() %>
	   		<a href="javascript:void(0)" onClick="editGroupInfo('<%=pgBean.getGroupID() %>')"><img src="../../resources/style/blue/images/pencil_small.gif" width="11" height="10" /></a>
	   		<a href="javascript:void(0)" onClick="deleteGroupInfo('<%=pgBean.getGroupID() %>')"><img src="../../resources/style/blue/images/cross.gif" width="9" height="8" /></a></div>
	   	 	</td>
	   	 <%if(i == pgBeanList.size()-1 && i%colnum == 0 ){//如果已到最后一行，但下标为单数，则补充一个td和一个tr %>
	   	 	<td valign="top">
	   		<div class="tjdiv"></div>
	   	 	</td>
	   	 	<td valign="top">
	   		<div class="tjdiv"></div>
	   	 	</td>
	   	 	</tr>
	   	 <%} %>
	   	 <%if(i%colnum == 1  ){ %>
	   	 <tr>
	   	 	<td valign="top">
	   		<div class="tjdiv"></div>
	   	 	</td>
	   	 </tr>
	   	 <%} %>
	    <%} %>
	</table>
	    
	 <!--创建新分组  -->
	 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style=" margin-top:4px;">
	  <tr id="createNewGroupArea">
	    <td width="2%" align="center">
		    <a href="javascript:void(0)" onclick="showCreateNewGroup()">
		    <img src="../../resources/style/blue/images/s2.gif" width="10" height="10" /></a>
	    </td>
	    <td width="98%" align="left" class="tj3">
	        <a href="javascript:void(0)" onclick="showCreateNewGroup()">创建新分组</a>
	    </td>
	  </tr>
	  <tr id="cancelNewGroupArea" style="display:none">	  	
	  	<td colspan="2" class="input_cx_title_th" width="400px">
		  	<form id="formAdd" method="post">
			  	<table>
			  	<tr>
			     
				     <td>
				         <input type="text" id="groupName" name="groupName" class="validate[required],maxSize[20] cue_input_190" />
				         <input type="hidden" id="loginUserID" name="loginUserID" value="<%=loginUserID %>" />
                         <input type="hidden" id="is_public_group" name="is_public_group" value="<%=is_public%>" />
                    
				     </td>
				     <td>
				         <input type="button" class="but_y_01" onClick="createNewGroup()" value="创建" style="margin:0 2px;" id="butclick"/>
				     </td>
				     <td>
					     <input type="hidden" id="paramjosn" name="paramjosn" > 
				  		 <input type="button" value='取消' onclick="showCreateNewGroup()" class="but_y_01" />
			  		 </td>
			    </tr>
			  	</table>
		  	</form>
	  	</td>
	  </tr>
	</table>	 
	<form id="form1" name="form1" method="post" onsubmit="">
		<input id="flowids" name="flowids" type="hidden"/>
		<input id="personids" name="personids" value="<%=personids %>" type="hidden"/>
		<input id="groupshowids" name="groupshowids" type="hidden" value="<%=groupshowids %>"/>
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
	</div>
	
	<div id="bottom" class="cue_box_foot" style="position: absolute;bottom: 0px;width:100%;margin:0px;padding:0px;" >
        <input type="button" value='关闭' onClick="back();" class="but_y_01"/>
    </div>
     
</body>
</html>