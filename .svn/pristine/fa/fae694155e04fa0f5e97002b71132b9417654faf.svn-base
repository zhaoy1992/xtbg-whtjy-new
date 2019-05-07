<%@ page language="java" import="java.text.*, java.util.*,com.chinacreator.epp.delegate.*,com.chinacreator.security.AccessControl,com.frameworkset.util.StringUtil" pageEncoding="GBK"%>
<%@page import="org.enhydra.shark.SharkEngineManager"%>
<%
String basePath = request.getContextPath()+"/";
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
String uname = control.getUserID();
String startHH = "00";
String endHH = "23";
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);

//modify by minghua.guo[2011-4-26] 兼职借调处理，当前应用id获取处理
boolean isSys_user_enablemutiorg = SharkEngineManager.getInstance().isSys_user_enablemutiorg();
String designatorOrgId = "";
String designeeOrgId = "";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>修改委托</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/tab.winclassic.css">
	
	<script type="text/javascript" src="<%=basePath%>delegate/prototype-1.4.0.js"></script>
	<script src="<%=request.getContextPath()%>/eformsys/fceform/js/fcpub.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
	<script type="text/javascript">
  //验证开始日期和结束日期
  	function subf(){
  	
  		if($F('weipairenid').replace(/\s+/g,"")==''){
  			alert("委托人必须填写");
  			return;
  		}
  		
  		if($F('beiweipairenid').replace(/\s+/g,"")==''){
  			alert("被委托人必须填写");
  			return;
  		}
  		
  		if(document.getElementById('class').checked==true){
  			if($F('weipaifanweiid').replace(/\s+/g,"")==''){
	  			alert("委托范围必须填写");
	  			return;
	  		}
  		}
  		
  		if($F('beiweipairenid')=="<%=uname %>"){
  			alert("不能委托给自己");
	  		return;
  		}
  		
  		if(valTime()){
  			$('myf').submit();
  		}
  	
  	}
  	function valTime()
  	{
  	    //开始时间
  	    var beginTime = document.all.kaishishijian.value;
  	    //结束时间
  	    var endTime = document.all.jiesushijian.value;
  	    var startHH = document.all.startHH.value;
  	    var endHH = document.all.endHH.value;
  	    var d1,d2;
  	    var t1 = beginTime.split("-");
  	    var t2 = endTime.split("-");
  	    d1 = new Date(t1[0],parseInt(t1[1]-1),t1[2]);
  	    d2 = new Date(t2[0],parseInt(t2[1]-1),t2[2]);

  	    //当前日期
  	    <%
  	         java.util.Calendar calendar = java.util.Calendar.getInstance();
  	         int year = calendar.get(java.util.Calendar.YEAR);
  	         int month = calendar.get(java.util.Calendar.MONTH);
  	         int day = calendar.get(java.util.Calendar.DAY_OF_MONTH);
  	    %>
  	    var curDate = new Date('<%=year%>','<%=month%>','<%=day%>');   
  	    if(d1<curDate)
  	    {
  	        alert("开始时间不能小于当前日期！");
  	        return false;
  	    }
  	    if(d2>=d1)
  	    {
  	    	if(t1[0]==t1[0] && parseInt(t1[1]-1)==parseInt(t2[1]-1) && t1[2]==t2[2] && endHH<startHH){
	  	        alert("结束时间必须大于开始时间！");
	  	        return false;
  	    	}
  	        return true;
  	     }
  	    else
  	    {
	  	    alert("结束时间必须大于开始时间！");
  	        return false;
  	    }
  	}
  	</script>
	<script>
	function docancel(p)
	{
	var url = '<%=basePath%>delegate/docancel.jsp';
	var pars = 'id=' + p + '&nowtime=' + new Date().getTime();
	var myAjax = new Ajax.Request(
	url,
	{
	method: 'get',
	parameters: pars,    //Loading, Loaded, Interactive
	onComplete: showResponse
	});
	}
	function showResponse(originalRequest)
	{
	//put returned XML in the textarea
	var restr=originalRequest.responseText;
	if(restr.replace(/\s+/g,"")=="success"){
		alert("取消委托成功！！");
		window.location.href='showdelegate.jsp';
	}else if(restr.replace(/\s+/g,"")=="errstat"){
		//alert("只要在委托任务为等待确认状态才能修改！");
	}else{
		alert(restr);;
		window.location.href='showdelegate.jsp';
	}
	}

  	function changed_ectype(obj){
  		if(obj.value=="app"){
  			document.getElementById("weipaifanwei_tr").style.display="none";
  		}else if(obj.value=="class"){
  			document.getElementById("weipaifanwei_tr").style.display="";
  		}
  	}
  	function getModules(){
  		 var selectModuleIds = document.getElementById("weipaifanweiid").value;
  		 var weipairenid = document.getElementById("weipairenid").value;
    	 var myReturn = window.showModalDialog("module_tree.jsp?selectModuleIds="+selectModuleIds+"&weipairenid="+weipairenid,window);
    	 alert("myReturn : "+myReturn);
    	 if(typeof(myReturn) != "undefined"){
    	 	var rets = myReturn.split("|");
    	 	document.getElementById("weipaifanweiid").value = rets[0];
    	 	document.getElementById("weipaifanwei").value = rets[1];
    	 }
  	}
  	
	 function checkThis(){
	 	var arr = document.getElementsByName("tixingleixing1");
		var ids = "";
		for(var i=0;i<arr.length;i++){
			if(arr[i].checked){
				if(ids == ""){
					ids = arr[i].value;
				}else{
					ids += ","+arr[i].value;
				}
			}
		}
		document.getElementById("tixingleixing").value = ids;
	 }
	 
	 //获取用户的有效所属机构
	 var isSys_user_enablemutiorg = "<%=isSys_user_enablemutiorg %>";
	function getOrgIds(designeeOrgId){
		if(isSys_user_enablemutiorg == "true"){
			var userId = document.getElementById("beiweipairenid").value;
			var userId1 = document.getElementById("weipairenid").value;
			if(userId != ""){
				var designatorOrgId = document.getElementById('designatorOrgId').value;
				if(document.getElementById('orgs1')){
					designatorOrgId = document.getElementById('orgs1').value;
				}
				document.getElementById('orgsTd1').innerHTML = "";
				document.getElementById('orgsTd').innerHTML = "";
				document.getElementById("OrgsFrom").action="getorgs.jsp?userId1="+userId1+"&userId="+userId+"&designatorOrgId="+designatorOrgId + "&designeeOrgId="+designeeOrgId;
				document.getElementById("OrgsFrom").submit();
				document.getElementById("orgsTr").style.display="";
			}
		}
	}
</script>
	
 
  </head>
  <%
  SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
  SimpleDateFormat sff=new SimpleDateFormat("yyyy-MM-dd HH");
  SimpleDateFormat sf1=new SimpleDateFormat("HH");
  
  String sub=request.getParameter("sub");

  if(sub!=null && !"".equals(sub.trim())){
  
  	//提交表单操作
  	Delegate d=new Delegate();
  
  	d.setDesigneeName(StringUtil.replaceNull(request.getParameter("beiweipairen")));
  	d.setDesigneeId(StringUtil.replaceNull(request.getParameter("beiweipairenid")));
  	
  	d.setOpId(control.getUserAccount());
  	d.setOp(control.getUserName());
  
  	d.setDelegateType(StringUtil.replaceNull(request.getParameter("dtype")));//委托类别
  	
  	d.setDesignatorId(StringUtil.replaceNull(request.getParameter("weipairenid")));
  	d.setDesignator(StringUtil.replaceNull(request.getParameter("weipairen")));
  	
  	String kaishishijian = StringUtil.replaceNull(request.getParameter("kaishishijian"));
  	String jiesushijian = StringUtil.replaceNull(request.getParameter("jiesushijian"));
    String startHH1 = StringUtil.replaceNull(request.getParameter("startHH"),"00");
    String startTime = kaishishijian + " " + startHH1;
    String endHH1 = StringUtil.replaceNull(request.getParameter("endHH"),"23");
    String endTime = jiesushijian + " " + endHH1;
  	
  	d.setDelegateTime(sff.parse(startTime));
  	d.setDelegateEndTime(sff.parse(endTime));	
  	
  	d.setDelegateStat(StringUtil.replaceNull(request.getParameter("dstatu")));
  	
  	d.setAwokeType(StringUtil.replaceNull(request.getParameter("tixingleixing")));
  	
  	d.setEcId(StringUtil.replaceNull(request.getParameter("weipaifanweiid")));
  	d.setEcType(StringUtil.replaceNull(request.getParameter("ec_type")));
  	d.setEcName(StringUtil.replaceNull(request.getParameter("weipaifanwei")));
  	d.setAppId(control.getCurrentSystemID());
  	d.setDelegateId(Integer.parseInt(StringUtil.replaceNull(request.getParameter("did"))));
  	//兼职借调，设置机构id
  	if(isSys_user_enablemutiorg){
  		String orgId1 = StringUtil.replaceNull(request.getParameter("orgs1"));
  		d.setDesignatorOrgId(orgId1);
  		String orgId = StringUtil.replaceNull(request.getParameter("orgs"));
  		d.setDesigneeOrgId(orgId);
  	}
  	String s=DelegateService.getInstance().updateDelegate(d);
  	if("success".equals(s)){
  	out.print("<script language='JavaScript'>");
  	out.print("alert('修改成功');");
  	out.print("window.location.href='"+request.getContextPath()+"/delegate/showdelegate.jsp';");
  	out.print("</script>");
  	//response.sendRedirect(basePath+"delegate/showdelegate.jsp");
  	}else if("noauthor".equals(s)){
  	out.print("<script language='JavaScript'>");
  	out.print("alert('你没有达到对你列出的委托或被委托人的委托权限！');");
  	out.print("window.location.href='"+request.getContextPath()+"/delegate/showdelegate.jsp';");
  	out.print("</script>");
  	}else{
  	out.print("<script language='JavaScript'>");
  	out.print("alert('"+s+"');");
  	out.print("window.location.href='"+request.getContextPath()+"/delegate/showdelegate.jsp';");
  	out.print("</script>");
  	}
  }else{
   String id=request.getParameter("id");
   Delegate delegate=null;
   if(id!=null && !"".equals(id.trim())){
  	delegate=DelegateService.getInstance().getDelegateById(id.trim());
   	delegate.setDesignatorId(new DelegateUtils().getIdByUname(delegate.getDesignatorId()));
   	delegate.setDesigneeId(new DelegateUtils().getIdByUname(delegate.getDesigneeId()));
   	designatorOrgId = delegate.getDesignatorOrgId();
   	designeeOrgId = delegate.getDesigneeOrgId();
   }
   startHH = sf1.format(delegate.getDelegateTime());
   endHH = sf1.format(delegate.getDelegateEndTime());
  %>
		<%@ include file="/epp/css/cssControl.jsp"%>
  <body class="contentbodymargin" scroll="no">
  <br>
   <br>
  <form action="editor.jsp" method="post" id="myf">
  <input value="sub" type="hidden" name="sub">
  <input value="<%=delegate.getDelegateType() %>" type="hidden" name="dtype">
  <input value="<%=delegate.getAwokeType() %>" type="hidden" name="tixingleixing">
   <input value="<%=delegate.getDelegateStat() %>" type="hidden" name="dstatu">
  <input value="<%=id %>" type="hidden" name="did">
  <input value="<%=designatorOrgId %>" type="hidden" name="designatorOrgId">
<table cellpadding="1" cellspacing="1" border="0" width="800px" align="center">
	<tr><td>
  <fieldset class="x-fieldset">
  <legend class="legend">修改委托</legend>
  <table cellpadding="1" cellspacing="1" width="99%" class="thin" border="0" style="margin-top:10px">

  <tr class="labeltable_middle_td" height="30px">
  <td>委托人</td>
  <td>
  <input type="text" readonly="readonly" id="weipairen" name="weipairen" value="<%=delegate.getDesignator() %>" style="width:200px"/>
  <input type="hidden" readonly="readonly" id="weipairenid" name="weipairenid" value="<%=delegate.getDesignatorId() %>"/>
  </td>
  <td>
  <%
  if("1".equals(delegate.getDelegateType())){
   %>
  <input type="button" onclick="openTree('user',document.getElementById('weipairenid'),document.getElementById('weipairen'),true);" value="选择委托人" class="input" style="cursor:hand"/>
  <%} %>
  </td>
  </tr>
  <%
  //判断是否启用兼职借调
  if(isSys_user_enablemutiorg){
  %>
  <tr class="labeltable_middle_td" height="30px" id="orgsTr1" style="display:none">
  <td>委托人机构</td>
  <td colspan=2 id="orgsTd1"></td>
  </tr>
  <%} %>
 
  <tr class="labeltable_middle_td" height="30px">
  <td>被委托人</td>
  <td><input type="text" readonly="readonly" id="beiweipairen" name="beiweipairen" value="<%=delegate.getDesigneeName() %>" style="width:200px"/>
  <input type="hidden" readonly="readonly" id="beiweipairenid" name="beiweipairenid" value="<%=delegate.getDesigneeId()%>"/></td>
  <td><input type="button" onclick="openTree('user',document.getElementById('beiweipairenid'),document.getElementById('beiweipairen'),true);getOrgIds();" value="选择被委托人" class="input" style="cursor:hand"/></td>
  </tr>
  <%
  //判断是否启用兼职借调
  if(isSys_user_enablemutiorg){
  %>
  <tr class="labeltable_middle_td" height="30px" id="orgsTr" style="display:none">
  <td>被委托人机构</td>
  <td colspan=2 id="orgsTd"></td>
  </tr>
  <%} %>

  <tr height="30px">
  	<td>委托范围类型</td>
  	<td colspan="2"><input type="radio" id="app" name="ec_type" value="app" <%if("app".equals(delegate.getEcType())){ %>checked<%} %> onclick="changed_ectype(this)"/>所有流程业务&nbsp;&nbsp;
  	<input type="radio" id="class" name="ec_type" value="class" <%if("class".equals(delegate.getEcType())){ %>checked<%} %> onclick="changed_ectype(this)"/>可选流程业务</td>
  </tr>
  <% 
  	String display = "none";
  	if("app".equals(delegate.getEcType())){
  		display = "none";
  	}else{
  		display = "";
  	}
  %>
  <tr id="weipaifanwei_tr" class="labeltable_middle_td" style="display:'<%=display %>'" height="30px">
  <td>委托范围</td>
   <td><input type="text" readonly="readonly" id="weipaifanwei" name="weipaifanwei" value="<%=delegate.getEcName() %>" style="width:200px"/>
   <input type="hidden"  id="weipaifanweiid" name="weipaifanweiid" value="<%=delegate.getEcId()%>"/>
   </td>
   <td><input type="button" onclick="getModules();" value="选择委托范围" class="input" style="cursor:hand"/></td>
  </tr> 
  <tr class="labeltable_middle_td" height="30px">
  <td>委托开始时间</td>
  <td colspan="2" nowrap><input type="text" name="kaishishijian" value="<%=sf.format(delegate.getDelegateTime())%>" readOnly onclick="showdate(this);" style="width:200px"/>
   <input type="hidden" name = "startHH" value="<%=startHH %>">
   <select id="sHH" value="<%=startHH %>" onchange="document.getElementById('startHH').value = this.value">
	<% 
	for(int i = 0; i < 24; i++){
		String value = "";
		if(i<10){
			value = "0" + i;
		}else{
			value = i + "";
		}
	%>
		<option value="<%=value %>"><%=value %></option>
	<%
	}
	%>
	</select>
	点</td>
 	 <%--<td colspan="1"><input type="button"  value="开始时间" onclick="showdate(document.getElementById('kaishishijian'))" class="input"/></td>
  --%></tr>

  <tr class="labeltable_middle_td" height="30px">
  <td>委托结束时间</td>
  <td colspan="2" nowrap><input type="text" name="jiesushijian" value="<%=sf.format(delegate.getDelegateEndTime())%>" readOnly onclick="showdate(this);" style="width:200px"/>
 	 <input type="hidden" name = "endHH" value="<%=endHH %>">
	 <select id="eHH" value="<%=endHH %>" onchange="document.getElementById('endHH').value = this.value">
	 <% 
	 for(int i = 23; i >= 0; i--){
			String value = "";
			String selected = "";
			if(i<10){
				value = "0" + i;
			}else{
				value = i + "";
			}
	%>
		<option value="<%=value %>"><%=value %></option>
	<%
	}
	%>
	</select>
	点</td>
 	 <%--<td colspan="1"><input type="button"  value="结束时间" onclick="showdate(document.getElementById('jiesushijian'))" class="input"/></td>
  --%></tr>
  
  <tr class="labeltable_middle_td" height="30px">
  <td>提醒类型</td>
  <td colspan="2">
  	<%String tixingleixing = delegate.getAwokeType(); %>
     <input type="hidden"  id="tixingleixing" name="tixingleixing" value="<%=tixingleixing %>"/>
	  <%
	  if(new DelegateUtils().checkMessageStatus("rtx",control.getCurrentSystemID())){
	  %>
	  		<input type="checkbox" name="tixingleixing1" onclick="checkThis()" value="1" <%if(tixingleixing.indexOf("1") > -1){ %>checked<%} %>/>RTX信息提醒&nbsp;&nbsp;
  	  <%
  	  }
	  if(new DelegateUtils().checkMessageStatus("sms",control.getCurrentSystemID())){
  	  %>
	  		<input type="checkbox" name="tixingleixing1" onclick="checkThis()" value="2" <%if(tixingleixing.indexOf("2") > -1){ %>checked<%} %>/>短信提醒&nbsp;&nbsp;
  	  <%
  	  }
	  if(new DelegateUtils().checkMessageStatus("sys",control.getCurrentSystemID())){
  	  %>
	 	 	<input type="checkbox" name="tixingleixing1" onclick="checkThis()" value="3" <%if(tixingleixing.indexOf("3") > -1){ %>checked<%} %>/>站内邮件
  	  <%
  	  }
  	  %>
  </td>
  </tr>
  <tr class="labeltable_middle_td" height="30px">
  <td colspan=3 align=center><input type="button" value="&nbsp;&nbsp;&nbsp;提&nbsp;&nbsp;&nbsp;交&nbsp;&nbsp;&nbsp;" class="input"  style="cursor:hand" onclick="subf();"/>
   <input type="button" value="&nbsp;&nbsp;&nbsp;返&nbsp;&nbsp;&nbsp;回&nbsp;&nbsp;&nbsp;" class="input"  style="cursor:hand" onclick="javascript:window.location.href='showdelegate.jsp'"/>
  <%
	if("1".equals(delegate.getDelegateStat())){
	//只有是确认状态的委托才能被取消
   %>
  <input type="button" value="&nbsp;&nbsp;&nbsp;取消委托&nbsp;&nbsp;&nbsp;" class="input"  style="cursor:hand" onclick="docancel(<%=id %>);"/>
 <%} %>
  </td>
  </tr>
  </table>
  </fieldset>
  </td></tr>
  </table>
  </form>
  
  <%} %>
  <form name="OrgsFrom" action="" target="getOrgsIframe" method="post">
   </form>
  <iframe width="0" height="0" id="getOrgsIframe" name="getOrgsIframe"></iframe>
  </body>
</html>
<script type="text/javascript">
var sub = "<%=sub %>";
document.getElementById("sHH").value="<%=startHH %>";
document.getElementById("eHH").value="<%=endHH %>";
if(sub == "null" || sub == ""){
	getOrgIds("<%=designeeOrgId %>");
}
</script>
