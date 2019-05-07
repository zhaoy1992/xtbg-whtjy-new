<%@ page language="java" import="java.text.*, java.util.*,com.chinacreator.epp.delegate.*,com.chinacreator.security.AccessControl,com.frameworkset.util.StringUtil" pageEncoding="GBK"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String uname=control.getUserID();//.getUserAccount();
%>

<html>
  <head>
    <title>新增委派</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/delegate/prototype-1.4.0.js"></script>
	<script src="<%=request.getContextPath()%>/eformsys/fceform/js/fcpub.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
  
  	<script type="text/javascript">
  //验证开始日期和结束日期
  	function subf(p){
  		if(p==2){
	  		if($F('weipairenid').replace(/\s+/g,"")==''){
	  			alert("委派人必须填写");
	  			return;
	  		}
	  		if($F('weipairenid')==$F('beiweipairenid')){
	  			alert("不能委派给自己");
	  			return;
	  		}
  		}
  	
  		if($F('beiweipairenid').replace(/\s+/g,"")==''){
  			alert("被委派人必须填写");
  			return;
  		}
  		
  		if(document.getElementById('class').checked==true){
  			if($F('weipaifanweiid').replace(/\s+/g,"")==''){
	  			alert("委派范围必须填写");
	  			return;
	  		}
  		}
  		
  		if($F('beiweipairenid')=="<%=uname %>"){
  			alert("不能委派给自己");
	  		return;
  		}
  		
  		if(valTime()){
  			$('myf').submit()
  		}
  	
  	}
  	function valTime()
  	{
  	    //开始时间
  	    var beginTime = document.all.kaishishijian.value;
  	    //结束时间
  	    var endTime = document.all.jiesushijian.value;
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
  	    if(d2>d1)
  	    {
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
    	 var myReturn = window.showModalDialog("module_tree.jsp?selectModuleIds="+selectModuleIds,window);
    	 if(typeof(myReturn) != "undefined"){
    	 	var rets = myReturn.split("|");
    	 	document.getElementById("weipaifanweiid").value = rets[0];
    	 	document.getElementById("weipaifanwei").value = rets[1];
    	 }
  	}
  	</script>
  </head>
  <%
  SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
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
  
  	String sub=request.getParameter("sub");
  	if(sub!=null && !"".equals(sub.trim())){
  	//提交表单操作
  	Delegate d=new Delegate();
  
  	d.setDesigneeName(beiweipairen);
  	
  	d.setDesigneeId(beiweipairenid);
  	
  	d.setOpId(control.getUserAccount());
  	d.setOp(control.getUserName());
  	
  	if(weipairenid!=null&&!"".equals(weipairenid.trim())){
  		d.setDelegateType("1");//上级委派
  		d.setDesignatorId(weipairenid);
  		d.setDesignator(weipairen);
  	}else{
  		d.setDelegateType("2");//亲自委派
  		d.setDesignatorId(control.getUserAccount());
  		d.setDesignator(control.getUserName());
  	}
  	
  	d.setDelegateTime(sf.parse(kaishishijian));
  	d.setDelegateEndTime(sf.parse(jiesushijian));	
  	
  	d.setDelegateStat("1");//等待确认
  	
  	d.setAwokeType(tixingleixing);
  	d.setEcId(weipaifanweiid);
  	d.setEcType(ec_type);
  	//d.setEcType("class");
  	d.setEcName(weipaifanwei);
  	d.setAppId((String)session.getAttribute("subsystem_id"));
  
  	String s=DelegateService.getInstance().addDelegate(d);
  	
  	if("success".equals(s)){
  	  	out.print("<script language='JavaScript'>");
  	  	out.print("alert('添加委派成功！');");
	  	out.print("window.location.href='"+request.getContextPath()+"/delegate/showdelegate.jsp';");
  	  	out.print("</script>");
  		//response.sendRedirect(request.getContextPath()+"/delegate/showdelegate.jsp");
  	}else if("noauthor".equals(s)){%>
	  	<script language='JavaScript'>
	  	alert('你没有达到对你列出的委派或被委派人的委派权限！');
	  	//out.print("window.location.href='"+request.getContextPath()+"/delegate/showdelegate.jsp';");
	  	</script>
  	<%}else if("errmsg".equals(s)){
	  	out.print("<script language='JavaScript'>");
	  	out.print("alert('添加委派成功，但是通知消息发送失败！！');");
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
  <table width="50%" cellpadding="0" cellspacing="1" class="thin" align="center">
  <tr class="labeltable_middle_td"><td colspan="3" height='20' class="headercolor">新增委派</td></tr>
  <%
  if("2".equals(flag)){//上级委派下级
  %>
  <tr class="labeltable_middle_td">
  <td>委派人</td>
  <td>
  <input type="text" readonly="readonly" id="weipairen" name="weipairen" value="<%=weipairen %>"/>
  <input type="hidden" readonly="readonly" id="weipairenid" name="weipairenid"  value="<%=weipairenid %>"/>
  </td>
  <td><input type="button" onclick="openTree('user',document.getElementById('weipairenid'),document.getElementById('weipairen'),true);" value="选择委派人" class="input" style="cursor:hand"/></td>
  </tr>
  <%
  }
  %>
  <tr class="labeltable_middle_td">
  <td>被委派人</td>
  <td><input type="text" readonly="readonly" id="beiweipairen" name="beiweipairen" value="<%=beiweipairen %>"/>
  <input type="hidden"  id="beiweipairenid" name="beiweipairenid" value="<%=beiweipairenid %>"/></td>
  <td><input type="button" onclick="openTree('user',document.getElementById('beiweipairenid'),document.getElementById('beiweipairen'),true);" value="选择被委派人" class="input" style="cursor:hand"/></td>
  </tr>

  <tr>
  	<td>委派范围类型</td>
  	<td colspan="2"><input type="radio" id="app" name="ec_type" value="app" <%if("app".equals(ec_type)){ %>checked<%} %> onclick="changed_ectype(this)"/>应用级&nbsp;&nbsp;
  	<input type="radio" id="class" name="ec_type" value="class" <%if("class".equals(ec_type)){ %>checked<%} %> onclick="changed_ectype(this)"/>模块(事项)级</td>
  </tr>
  <tr id="weipaifanwei_tr" class="labeltable_middle_td" style="display:'<%=display %>'">
  <td>委派范围</td>
   <td><input type="text" readonly="readonly" id="weipaifanwei" name="weipaifanwei" value="<%=weipaifanwei %>"/>
   <input type="hidden"  id="weipaifanweiid" name="weipaifanweiid" value="<%=weipaifanweiid %>"/>
   </td>
   <td><input type="button" onclick="getModules();" value="选择委派范围" class="input" style="cursor:hand"/></td>
  </tr>
  <tr class="labeltable_middle_td">
  <td>委派开始时间</td>
  <td colspan="1"><input type="text" name="kaishishijian" value="<%=kaishishijian %>" readonly="readonly" id="kssj"/></td>
   <td colspan="1"><input type="button"  value="开始时间" onclick="showdate(document.getElementById('kssj'))" class="input"/></td>
  </tr>

  <tr class="labeltable_middle_td">
  <td>委派结束时间</td>
  <td colspan="1"><input type="text" name="jiesushijian" value="<%=jiesushijian %>" readonly="readonly" id="jssj"/></td>
 	 <td colspan="1"><input type="button"  value="结束时间" onclick="showdate(document.getElementById('jssj'))" class="input"/></td>
  </tr>
  
  <tr class="labeltable_middle_td">
  <td>提醒类型</td>
  <td colspan="2">
  <select name="tixingleixing">
  	<%
  	if(DelegateUtils.checkMessageStatus("rtx",(String)session.getAttribute("subsystem_id"))){
  	
  	 %>
  	 <option value="1">RTX信息提醒</option>
  	 <%
  	 }
  	 %>
  	 
  	  	<%
  	if(DelegateUtils.checkMessageStatus("sms",(String)session.getAttribute("subsystem_id"))){
  	
  	 %>
  	 <option value="2">短信提醒</option>
  	 <%
  	 }
  	 %>
  	 
  	 
  	 <%
  	if(DelegateUtils.checkMessageStatus("sys",(String)session.getAttribute("subsystem_id"))){
  	
  	 %>
  	 <option value="3">站内邮件</option>
  	 <%
  	 }
  	 %>
  	
  	
  	
  </select>
  </td>
  </tr>
  <tr class="labeltable_middle_td">
  <td></td>
  <td>
  
  <input type="button" value="&nbsp;&nbsp;&nbsp;提&nbsp;&nbsp;&nbsp;交&nbsp;&nbsp;&nbsp;" class="input"  style="cursor:hand" onclick="subf(<%=flag %>);"/>
  
  </td>
   <td><input type="button" value="&nbsp;&nbsp;&nbsp;返&nbsp;&nbsp;&nbsp;回&nbsp;&nbsp;&nbsp;" class="input"  style="cursor:hand" onclick="javascript:window.location.href='showdelegate.jsp'"/></td>
  </tr>
  </table>
  </form>
  
  <%//} %>
  </body>
</html>
