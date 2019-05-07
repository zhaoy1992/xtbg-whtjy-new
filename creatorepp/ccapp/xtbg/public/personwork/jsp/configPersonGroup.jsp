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
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>个人通讯录分组配置</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"charset="utf-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<link href="../../../resources/css/tjz.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
var personidsArry = "<%=personids%>".split(",");//选择的人员id集合
var groupshowidsArry = "<%=groupshowids%>".split(",");//配置的分组id集合
var loginUserID=<%=loginUserID%>;

$(function(){
	jQuery("#formAdd").validationEngine();
	for(var i = 0 ; i < groupshowidsArry.length ; i ++){
		$("#"+groupshowidsArry[i]).prop("checked",true);
	}
})

function saveGroupConfig(){
	var tempArrs = [];
	$("input[name=groupName]:checked").each(function(i,e){
		tempArrs.push($(e).attr("id"));
	})
	$('#groupshowids').val(tempArrs.join());


	if(IsSpace($('#personids').val())){
		alert("请选择要添加到分组的名片！");	
	}
	
	var url = "savepersongroupinfoform.jsp";
	
	document.all.form1.action = url;
	document.all.form1.target = "hiddenFrame";
	$('#form1').submit();
}

function showCreateNewGroup(){
	if($("#createNewGroupArea").is(":hidden")){
		$("#createNewGroupArea").show();
		$("#cancelNewGroupArea").hide();
	}else{
		$("#createNewGroupArea").hide();
		$("#cancelNewGroupArea").show();
		
	}
}
/* 创建分组 
 * 
 */
function createNewGroup(){
	var paramjosn = "";
	paramjosn = "{'loginUserID':'" +  loginUserID + 
	"','groupName':'" + $("#groupName").val()+"'}";
	$("#paramjosn").val(paramjosn);
	$("#formAdd").attr("target","hiddenFrame");
	$('#formAdd').submit();
}
/* 关闭按钮 
 * 
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
	//window.top.removeAlertWindows('',true,'','',true)
}

</script>
</head>
<body style="overflow-y: hidden;">

<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tj1">为联系人选择分组</td>
  </tr>
</table>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" class="tj2">

  
  <%int colnum = 2;//每行显示的列数
    for(int i = 0 ; i < pgBeanList.size() ; i ++){//循环分组集合
    	PGroupBean pgBean = pgBeanList.get(i);
    	if(i%colnum == 0){//每两个元素放一行，故下标除以2余0，则增加tr%>
    	<tr>	
    <%	}
    %>
   		<td valign="top">
   		<div class="tjdiv"><input id="<%=pgBean.getGroupID() %>" name="groupName" type="checkbox" value="" /> <%=pgBean.getGroupName() %>
   		</div>
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
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" style=" margin-top:4px;">
  <tr id="createNewGroupArea">
    <td width="2%" align="center"><a href="javascript:void(0)" onclick="showCreateNewGroup()"><img src="../../../resources/images/s2.gif" width="10" height="10" /></a></td>
    <td width="98%" align="left" class="tj3"><a href="javascript:void(0)" onclick="showCreateNewGroup()">创建新分组</a></td>
  </tr>
  <tr id="cancelNewGroupArea" style="display:none">
  	
  	<td colspan="2" class="input_cx_title_th" width="400px">
  	<form id="formAdd" method="post" action="pGroupAdddo.jsp">
  	<table>
  	<tr>
     
     <td><input type="text" id="groupName" class="validate[required] cue_input_190" ></td>
     <td><input type="button" class="but_y_01" onClick="createNewGroup()" value="创建" style="margin:0 2px;"/></td>
     <td><input type="hidden" id="paramjosn" name="paramjosn" > 
  		 <input type="button" value='取消' onclick="showCreateNewGroup()" class="but_y_01" /></td>
    </tr>
  	</table>
  	</form>
  	</td>
  	
  </tr>
</table>

	<div class="cue_box_foot" >
		<input type="button" value='关闭' onclick="back()" class="but_y_01"/>
		<input type="button" class="but_y_01" onClick="saveGroupConfig()" value="保存"/>
  	</div>
  	
	<!-- 查询列表区 -->
<form id="form1" name="form1" method="post" >
<input id="personids" name="personids" value="<%=personids %>" type="hidden"></input>
<input id="groupshowids" name="groupshowids" type="hidden" value="<%=groupshowids %>"></input>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>