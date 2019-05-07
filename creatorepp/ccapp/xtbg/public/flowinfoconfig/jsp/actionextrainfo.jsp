<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactionExtBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.Map"%><html>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String actionid = request.getParameter("actionid");
	
	FlowInfoDao flowInfodao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
	Map<String,String> viewMap = flowInfodao.findFlowWfactionExtInfoById(actionid);
	
	String autoassignmentSelect = flowInfodao.getWfactionExtAutoassignmentDictDropDownList(actionid,viewMap.get("autoassignment"));

%>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>

<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>环节扩展信息</title>
<script type="text/javascript">
var actionext_id = '<%=viewMap.get("actionext_id")%>';//环节扩展主键
var action_id = '<%=actionid%>';

var init = function() {
	if(!IsSpace('<%=viewMap.get("actionext_id")%>')){
		setSelectValue("ISSHOWUSER","<%=viewMap.get("isshowuser")%>");
		setSelectValue("ISSHOWREJECT","<%=viewMap.get("isshowreject")%>");
		setSelectValue("ISSHOWBACK","<%=viewMap.get("isshowback")%>");
		setSelectValue("AUTOASSIGNMENT","<%=viewMap.get("autoassignment")%>");
		setSelectValue("issignjoinbyorder","<%=viewMap.get("issignjoinbyorder")%>");
	}
}

function saveActionExtInfo(){
	
	var jsonparam = "{'actionext_id':'"+actionext_id+"','action_id':'"+action_id+"',"+
	"'isshowuser':'"+$('#ISSHOWUSER').val()+"','isshowreject':'"+$('#ISSHOWREJECT').val()+"',"+
	"'isshowback':'"+$('#ISSHOWBACK').val()+"','autoassignment':'"+$('#AUTOASSIGNMENT').val()+"',"+
	"'issignjoinbyorder':'"+$('#issignjoinbyorder').val()+"'}";
   // alert(jsonparam);
    var url = "saveactionextform.jsp";
    $("#jsonparam").val(descape(escape(jsonparam)));
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    document.all.form1.submit();
}
</script>
</head>
<body onload="init()">
<form id=form1 name=form1 method="post">
<input type=hidden value="" id="action_id" name="action_id"/>
<input id="jsonparam" name="jsonparam" type="hidden"/>
 <div class="content_02_box" >
		 <div class="content_02_box_title_bg"><span>配置信息</span>
		  <div class="content_02_box_add" >
		         <span id="selAreaImg" class="tabs_search_text_but">
	   				<input type="button" id="choose" name="choose" value="保存" class="but_y_01" 
	   				onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');
	   				style="display: inline" onclick="saveActionExtInfo();"/>
	   				</span>
				 </div>
		 </div>
		 <div class="content_02_box_div">

        <TABLE id=actexttab   class="content_box_text myTable" >
              <TR>
                 <TH title="动态执行人的选择是当环节分支选择到该环节时，是否弹出执行人选择框">是否动态选择执行人</TH>
                 <TD class="content_02_box_div_table_td">
                 <SELECT style="width:130px;margin-left:5px;" id="ISSHOWUSER"  name="ISSHOWUSER">
	                 <OPTION  value=Y>是</OPTION>
	                 <OPTION selected value=N>否</OPTION>
                 </SELECT>
                 </TD>
                <TH >是否退窗</TH>
                 <TD>
                 <SELECT style="width:130px;margin-left:5px;" id="ISSHOWREJECT"  name="ISSHOWREJECT">
	                 <OPTION  value=Y>是</OPTION>
	                 <OPTION selected value=N>否</OPTION>
                 </SELECT></TD>
              </TR>
              <TR>
                 <TH  >是否使用前置活动执行人</TH>
                 <TD class="content_02_box_div_table_td">
                 <%=autoassignmentSelect %>
                 </TD>
               <TH >是否回退</TH>
                 <TD>
                 <SELECT style="width:130px;margin-left:5px;" id="ISSHOWBACK"  name="ISSHOWBACK">
	                 <OPTION  value=Y>是</OPTION>
	                 <OPTION selected value=N>否</OPTION>
                 </SELECT></TD>
                 
              </TR>
       		  <TR>
                 <TH>是否按顺序会签</TH>
                 <TD class="content_02_box_div_table_td">
                 <SELECT style="width:130px;margin-left:5px;" id="issignjoinbyorder"  name="issignjoinbyorder">
	                 <OPTION selected value="">---请选择---</OPTION>
	                 <OPTION  value="isJoinSign">无顺序会签</OPTION>
	                 <OPTION  value="userLevelHighToLow">按级别从高到低</OPTION>
	                 <OPTION  value="userLevelLowToHigh">按级别从低到高</OPTION>
                 </SELECT>
                 </TD>
               <TH ></TH>
                 <TD>
                </TD>
              </TR>
        </TABLE>

</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>