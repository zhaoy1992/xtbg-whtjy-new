<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String loginUserID = accesscontroler.getUserID();
	
	PriManageDao priManageDao = (PriManageDao)DaoImplClassUtil.getDaoImplClass("priManageDaoImpl");
	
	PGroupBean pbGroupBean = new PGroupBean();
	pbGroupBean.setLoginUserID(loginUserID);
	List<PGroupBean> pgBeanList = priManageDao.queryGroup4List(pbGroupBean);
	String personids = request.getParameter("personids");
	String groupshowids = request.getParameter("groupshowids");
%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="com.chinacreator.xtbg.pub.personwork.dao.PriManageDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.PGroupBean"%>
<%@page import="java.util.List"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>����ͨѶ¼�������</title>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- ����formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- �������� -->
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<link href="../../../resources/css/tjz.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).keydown(function(){
	
	if(event.keyCode == 13){ 
		jQuery("#formAdd").bind("submit",function(){
			event.preventDefault();
			
		})
		 createNewGroup();
	}
});
$(function(){
	jQuery("#formAdd").validationEngine();
})
var loginUserID=<%=loginUserID%>
/**
 * �༭������Ϣ
 */
function editGroupInfo(groupId){
	openAlertWindows('windowId_1','../../personwork/jsp/pGroupEdit.jsp?groupId='+groupId,'������',300,150,'35%','40%');
}

/**
 * ɾ��������Ϣ
 */
function deleteGroupInfo(groupId){
	openAlertWindows('windowId_1','../../personwork/jsp/pGroupDelete.jsp?groupId='+groupId,'��ʾ',220,110,'35%','40%');

}

/* 
 * �����·���-ȡ��
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
/* �������� 
 * 
 */
function createNewGroup(){debugger;
	var paramjosn = "";
	paramjosn = "{'loginUserID':'" +  loginUserID + 
	"','groupName':'" + $("#groupName").val()+"'}";
	$("#paramjosn").val(paramjosn);
	$("#formAdd").attr("target","hiddenFrame");
	$("#formAdd").attr("action","pGroupAdddo.jsp");
	
	$('#formAdd').submit();
}

/* �رհ�ť 
 * 
 */
 function back(){
	var mes = "�����ɹ�";
	var bool = true;
	var ok=function(){
		window.parent.location.reload();
	}
	if(window.top.removeAlertWindows('',false,bool,mes,true,false,true)){
		if(bool){
			window.top.alert(mes,{headerText:'������',okName:'ȷ��',okFunction:ok})
		}
		else{
			window.top.alert(mes)
		}
	}
}

</script>
</head>
<body style="overflow-x:auto;" class="vcenter">

<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" class="tj2">

    <%int colnum = 2;//ÿ����ʾ������
    for(int i = 0 ; i < pgBeanList.size() ; i ++){//ѭ�����鼯��
    	PGroupBean pgBean = pgBeanList.get(i);
    	if(i%colnum == 0){//ÿ����Ԫ�ط�һ�У����±����2��0��������tr%>
    	<tr>	
    <%	}
    %>
   		<td valign="top">
   		<div class="tjdiv"><%=pgBean.getGroupName() %>
   		<a href="javascript:void(0)" onClick="editGroupInfo('<%=pgBean.getGroupID() %>')"><img src="../../../resources/images/pencil_small.gif" width="11" height="10" /></a>
   		<a href="javascript:void(0)" onClick="deleteGroupInfo('<%=pgBean.getGroupID() %>')"><img src="../../../resources/images/cross.gif" width="9" height="8" /></a></div>
   	 	</td>
   	 <%if(i == pgBeanList.size()-1 && i%colnum == 0 ){//����ѵ����һ�У����±�Ϊ�������򲹳�һ��td��һ��tr %>
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
    
 <!--�����·���  -->
 <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" style=" margin-top:4px;">
  <tr id="createNewGroupArea">
    <td width="2%" align="center"><a href="javascript:void(0)" onclick="showCreateNewGroup()"><img src="../../../resources/images/s2.gif" width="10" height="10" /></a></td>
    <td width="98%" align="left" class="tj3"><a href="javascript:void(0)" onclick="showCreateNewGroup()">�����·���</a></td>
  </tr>
  <tr id="cancelNewGroupArea" style="display:none">
  	
  	<td colspan="2" class="input_cx_title_th" width="400px">
  	<form id="formAdd" method="post">
  	<table>
  	<tr>
     
     <td><input type="text" id="groupName" class="validate[required],maxSize[20] cue_input_190" ></td>
     <td><input type="button" class="but_y_01" onClick="createNewGroup()" value="����" style="margin:0 2px;" id="butclick"/></td>
     <td><input type="hidden" id="paramjosn" name="paramjosn" > 
  		 <input type="button" value='ȡ��' onclick="showCreateNewGroup()" class="but_y_01" /></td>
    </tr>
  	</table>
  	</form>
  	</td>
  </tr>
</table>

	<div class="cue_box_foot" >
		<input type="button" value='�ر�' onClick="back();" class="but_y_01"/>
  	</div>
	<!-- ��ѯ�б��� -->
<form id="form1" name="form1" method="post" onsubmit="">
<input id="flowids" name="flowids" type="hidden"></input>
<input id="personids" name="personids" value="<%=personids %>" type="hidden"></input>
<input id="groupshowids" name="groupshowids" type="hidden" value="<%=groupshowids %>"></input>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>