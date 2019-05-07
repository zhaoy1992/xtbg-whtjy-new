<%@ page language="java" import="java.text.*, java.util.*,com.chinacreator.epp.delegate.*,com.chinacreator.security.AccessControl,com.frameworkset.util.StringUtil" pageEncoding="GBK"%>
<%@page import="org.enhydra.shark.SharkEngineManager"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String uname=control.getUserID();//.getUserAccount();
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);

boolean isSys_user_enablemutiorg = SharkEngineManager.getInstance().isSys_user_enablemutiorg();
%>

<html>
  <head>
    <title>新增委托</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/delegate/prototype-1.4.0.js"></script>
	<script src="<%=request.getContextPath()%>/eformsys/fceform/js/fcpub.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/ccapp/common/js/divWin.js"></script>
  
  	<script type="text/javascript">
  //验证开始日期和结束日期
  	function subf(p){
  		if(p==2){
	  		if($F('weipairenid').replace(/\s+/g,"")==''){
	  			alert("委托人必须填写");
	  			return;
	  		}
	  		if($F('weipairenid')==$F('beiweipairenid')){
	  			alert("不能委托给自己");
	  			return;
	  		}
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
  			$('tijiao').disabled = true;	
  			$('myf').submit();
  			$('tijiao').disabled = false;
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
  	
  	function changed_ectype(obj){
  		if(obj.value=="app"){
  			document.getElementById("weipaifanwei_tr").style.display="none";
  		}else if(obj.value=="class"){
  			document.getElementById("weipaifanwei_tr").style.display="";
  		}
  	}
  	
  	function getModules(){
  		 var selectModuleIds = document.getElementById("weipaifanweiid").value;
  		 var weipairenidObj = document.getElementById("weipairenid");
  		 var weipairenid = "";
  		 if(weipairenidObj == null){
  		 	weipairenid = "<%=uname %>";
  		 }else{
  		 	weipairenid = weipairenidObj.value;
  		 	if(weipairenid == ""){
  		 		alert("请先选择委托人");
  		 		return false;
  		 	}
  		 }
    	 var myReturn = window.showModalDialog("module_tree.jsp?selectModuleIds="+selectModuleIds+"&weipairenid="+weipairenid,window);
    	 if(typeof(myReturn) != "undefined"){
    	 	var rets = myReturn.split("|");
    	 	document.getElementById("weipaifanweiid").value = rets[0];
    	 	document.getElementById("weipaifanwei").value = rets[1];
    	 }
  	}
  	
  	function selectUser(){
  		var url = "<%=request.getContextPath()%>ccapp/common/userSelect/user_frame.jsp?divwin=dispatch&callback=handle_roundToUser";
		var options = {
			layer:"div_dispatch",
			wTitle:'公文传阅人员选择',
			content:'<iframe id="frame_dispatch" src="'+ url +'" frameborder="0" height="100%" width="100%" scrolling="no"></iframe>',
			pos:{x:20,y:20},
			wWidth:600,
			wHeight:400,
			openType : "force"
		}
		show(options);
	 }
	 
	 function handle_roundToUser(){
	 	
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
	function getOrgIds(){
		if(isSys_user_enablemutiorg == "true"){
			var userId = document.getElementById("beiweipairenid").value;
			var userId1 = "<%=uname %>";
			if(userId != ""){
				document.getElementById('orgsTd1').innerHTML = "";
				document.getElementById('orgsTd').innerHTML = "";
				document.getElementById("OrgsFrom").action="getorgs.jsp?userId1="+userId1+"&userId="+userId;
				document.getElementById("OrgsFrom").submit();
			}
		}
	}
  	</script>
  </head>
  <%
  SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH");
  String beiweipairen = StringUtil.replaceNull(request.getParameter("beiweipairen"));
  String beiweipairenid = StringUtil.replaceNull(request.getParameter("beiweipairenid"));
  String weipairenid = StringUtil.replaceNull(request.getParameter("weipairenid"));
  String weipairen = StringUtil.replaceNull(request.getParameter("weipairen"));
  String kaishishijian = StringUtil.replaceNull(request.getParameter("kaishishijian"));
  String jiesushijian = StringUtil.replaceNull(request.getParameter("jiesushijian"));
  String tixingleixing = StringUtil.replaceNull(request.getParameter("tixingleixing"));
  String weipaifanweiid = StringUtil.replaceNull(request.getParameter("weipaifanweiid"));
  String ec_type = StringUtil.replaceNull(request.getParameter("ec_type"));
  String flag=request.getParameter("flag");
  if("".equals(ec_type)){
	  ec_type = "app";
  }
  String display = "none";
  if("class".equals(ec_type)){
	  display = "";
  }else if("app".equals(ec_type)){
	  display = "none";
  }
  String weipaifanwei = StringUtil.replaceNull(request.getParameter("weipaifanwei"));
  
  String startHH = StringUtil.replaceNull(request.getParameter("startHH"),"00");
  String startTime = kaishishijian + " " + startHH;
  String endHH = StringUtil.replaceNull(request.getParameter("endHH"),"23");
  String endTime = jiesushijian + " " + endHH;
  
  	String sub=request.getParameter("sub");
  	if(sub!=null && !"".equals(sub.trim())){
  	//提交表单操作
  	Delegate d=new Delegate();
  
  	d.setDesigneeName(beiweipairen);
  	
  	d.setDesigneeId(beiweipairenid);
  	
  	d.setOpId(control.getUserAccount());
  	d.setOp(control.getUserName());
  	
  	if(weipairenid!=null&&!"".equals(weipairenid.trim())){
  		d.setDelegateType("1");//上级委托
  		d.setDesignatorId(weipairenid);
  		d.setDesignator(weipairen);
  	}else{
  		d.setDelegateType("2");//亲自委托
  		d.setDesignatorId(control.getUserAccount());
  		d.setDesignator(control.getUserName());
  	}
  	
  	//d.setDelegateTime(sf.parse(kaishishijian));
  	//d.setDelegateEndTime(sf.parse(jiesushijian));
  	d.setDelegateTime(sf.parse(startTime));
  	d.setDelegateEndTime(sf.parse(endTime));		
  	
  	d.setDelegateStat("1");//等待确认
  	
  	d.setAwokeType(tixingleixing);
  	d.setEcId(weipaifanweiid);
  	d.setEcType(ec_type);
  	//d.setEcType("class");
  	d.setEcName(weipaifanwei);
  	//d.setAppId((String)session.getAttribute("subsystem_id"));
  	d.setAppId(control.getCurrentSystemID());
  	//兼职借调，设置机构id
  	if(isSys_user_enablemutiorg){
  		String orgId1 = StringUtil.replaceNull(request.getParameter("orgs1"));
  		String orgId = StringUtil.replaceNull(request.getParameter("orgs"));
  		d.setDesignatorOrgId(orgId1);//委派人机构
  		d.setDesigneeOrgId(orgId);//被委派人机构
  	}
  
  	String s=DelegateService.getInstance().addDelegate(d);
  	
  	if("success".equals(s)){
  	  	out.print("<script language='JavaScript'>");
  	  	out.print("alert('添加委托成功！');");
	  	out.print("window.location.href='"+request.getContextPath()+"/delegate/showdelegate.jsp';");
  	  	out.print("</script>");
  		//response.sendRedirect(request.getContextPath()+"/delegate/showdelegate.jsp");
  	}else if("noauthor".equals(s)){%>
	  	<script language='JavaScript'>
	  	alert('你没有达到对你列出的委托或被委托人的委托权限！');
	  	//out.print("window.location.href='"+request.getContextPath()+"/delegate/showdelegate.jsp';");
	  	</script>
  	<%}else if("errmsg".equals(s)){
	  	out.print("<script language='JavaScript'>");
	  	out.print("alert('添加委托成功，但是通知消息发送失败！！');");
	  	out.print("window.location.href='"+request.getContextPath()+"/delegate/showdelegate.jsp';");
	  	out.print("</script>");
  	}else{
	  	out.print("<script language='JavaScript'>");
	  	out.print("alert('"+s+"');");
	  	out.print("</script>");
  	}
  }//else{
  //非表单提交
  %>
		<%@ include file="/epp/css/cssControl.jsp"%>
  <body>
  <br>
   <br>
  <form action="add.jsp" method="post" id="myf">
  <input value="sub" type="hidden" name="sub">
  <input type="hidden" name="flag" value="<%=flag %>"/>
<table cellpadding="0" cellspacing="0" border="0" width="800px" align="center">
	<tr><td>
  <fieldset class="x-fieldset">
  <legend class="legend">新增委托</legend>
  <table cellpadding="1" cellspacing="1" width="99%" class="thin" border="0" style="margin-top:10px">
  <%
  if("2".equals(flag)){//上级委托下级
  %>
  <tr class="labeltable_middle_td" height="30px">
  <td>委托人</td>
  <td>
  <input type="text" readonly="readonly" id="weipairen" name="weipairen" value="<%=weipairen %>" style="width:200px"/>
  <input type="hidden" readonly="readonly" id="weipairenid" name="weipairenid"  value="<%=weipairenid %>"/>
  </td>
  <td><input type="button" onclick="openTree('user',document.getElementById('weipairenid'),document.getElementById('weipairen'),true);" value="选择委托人" class="input" style="cursor:hand"/></td>
  </tr>
  <%
  }
  %>
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
  <td><input type="text" readonly="readonly" id="beiweipairen" name="beiweipairen" value="<%=beiweipairen %>" style="width:200px"/>
  <input type="hidden"  id="beiweipairenid" name="beiweipairenid" value="<%=beiweipairenid %>"/></td>
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
  	<td colspan="2"><input type="radio" id="app" name="ec_type" value="app" <%if("app".equals(ec_type)){ %>checked<%} %> onclick="changed_ectype(this)"/>所有流程业务&nbsp;&nbsp;
  	<input type="radio" id="class" name="ec_type" value="class" <%if("class".equals(ec_type)){ %>checked<%} %> onclick="changed_ectype(this)"/>可选流程业务</td>
  </tr>
  <tr id="weipaifanwei_tr" class="labeltable_middle_td" style="display:'<%=display %>'" height="30px">
  <td>委托范围</td>
   <td><input type="text" readonly="readonly" id="weipaifanwei" name="weipaifanwei" value="<%=weipaifanwei %>" style="width:200px"/>
   <input type="hidden"  id="weipaifanweiid" name="weipaifanweiid" value="<%=weipaifanweiid %>"/>
   </td>
   <td><input type="button" onclick="getModules();" value="选择委托范围" class="input" style="cursor:hand"/></td>
  </tr>
  <tr class="labeltable_middle_td" height="30px">
  <td>委托开始时间</td>
  <td colspan="2"><input type="text" name="kaishishijian" value="<%=kaishishijian %>" readonly="readonly" id="kssj" onclick="showdate(this);" style="width:200px"/>
   <input type="hidden" name = "startHH" value="<%=startHH %>">
   <select id="sHH" value="<%=startHH %>" onchange="document.getElementById('startHH').value = this.value">
	<% 
	for(int i = 0; i < 24; i++){
		String value = "";
		String selected = "";
		if(i<10){
			value = "0" + i;
		}else{
			value = i + "";
		}
		if(i == 0) selected = "selected";
	%>
		<option value="<%=value %>" <%=selected %>><%=value %></option>
	<%
	}
	%>
	</select>
	点</td>
	<%--<td colspan="1"><input type="button"  value="开始时间" onclick="showdate(document.getElementById('kssj'))" class="input"/></td>
  --%></tr>

  <tr class="labeltable_middle_td" height="30px">
  <td>委托结束时间</td>
  <td colspan="2"><input type="text" name="jiesushijian" value="<%=jiesushijian %>" readonly="readonly" id="jssj" onclick="showdate(this);" style="width:200px"/>
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
		if(i == 23) selected = "selected";
	%>
		<option value="<%=value %>" <%=selected %>><%=value %></option>
	<%
	}
	%>
	</select>
	点
 	 </td>
  	<%--<td colspan="1"><input type="button"  value="结束时间" onclick="showdate(document.getElementById('jssj'))" class="input"/></td>
  --%></tr>
  
  <tr class="labeltable_middle_td" height="30px">
  <td>提醒类型</td>
  <td colspan="2">
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
  <td colspan=3 align=right>
  <input type="button" value="&nbsp;&nbsp;&nbsp;提&nbsp;&nbsp;&nbsp;交&nbsp;&nbsp;&nbsp;" id="tijiao" class="input"  style="cursor:hand" onclick="subf(<%=flag %>);"/>
  <input type="button" value="&nbsp;&nbsp;&nbsp;返&nbsp;&nbsp;&nbsp;回&nbsp;&nbsp;&nbsp;" class="input"  style="cursor:hand" onclick="javascript:window.location.href='showdelegate.jsp'"/></td>
  </tr>
  </table>
  </fieldset>
  </td></tr>
  </table>
  </form>
  
  <%//} %>
  <form name="OrgsFrom" action="" target="getOrgsIframe" method="post"></form>
  <iframe width="0" height="0" id="getOrgsIframe" name="getOrgsIframe"></iframe>
  </body>
</html>
<script type="text/javascript">
<!--
document.getElementById("sHH").value="<%=startHH %>";
document.getElementById("eHH").value="<%=endHH %>";
//-->
</script>

