<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="java.util.Map"%>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);

    String actionid = request.getParameter("actionid");
    FlowInfoDao flowInfodao = (FlowInfoDao) LoadSpringContext .getApplicationContext().getBean("flowInfoDaoImpl");
    Map<String, String> viewMap = flowInfodao.findFlowWfactionExtInfoById(actionid);

    String autoassignmentSelect = flowInfodao.getWfactionExtAutoassignmentDictDropDownList(actionid);
    
    boolean isLatestAction = false;//是否是办结环节
    if("03".equals(viewMap.get("actiontype_code"))){
    	isLatestAction = true;
    }
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script  src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
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
        setSelectValue("autoassignment","<%=viewMap.get("autoassignment")%>");
        setSelectValue("issignjoinbyorder","<%=viewMap.get("issignjoinbyorder")%>");
        setSelectValue("isdispense","<%=viewMap.get("isdispense")%>");
        setSelectValue("is_auto_complete","<%=viewMap.get("is_auto_complete")%>");
    }
}

function saveActionExtInfo(){
	var is_auto_complete = $('#is_auto_complete').val();
	if(!is_auto_complete){
		is_auto_complete ='N';
	}
    var jsonparam = "{'actionext_id':'"+actionext_id
    	+"','action_id':'"+action_id
    	+"',"+"'isshowuser':'"+$('#ISSHOWUSER').val()
    	+"','isshowreject':'"+$('#ISSHOWREJECT').val()
    	+"',"+"'isshowback':'"+$('#ISSHOWBACK').val()
    	+"','autoassignment':'"+$('#autoassignment').val()
    	+"',"+"'isdispense':'"+$('#isdispense').val()
    	+"','issignjoinbyorder':'"+$('#issignjoinbyorder').val()
    	+"','is_auto_complete':'"+is_auto_complete
    	+"'}";
    var url = "saveactionextform.jsp";
    $("#jsonparam").val(descape(escape(jsonparam)));
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    document.all.form1.submit();
}
</script>
</head>
<body onload="init()">
<form id=form1 name=form1 method="post"><input type=hidden
    value="" id="action_id" name="action_id" /> <input id="jsonparam"
    name="jsonparam" type="hidden" />
<div class="content_02_box">
<div class="content_02_box_title_bg"><span>配置信息</span>
<div class="content_02_box_add"><span id="selAreaImg"
    class="tabs_search_text_but"> <input type="button" id="choose"
    name="choose" value="保存" class="but_y_01"
    onMouseOver="$(this).attr('class','but_y_02');" 
    onMouseOut="$(this).attr('class','but_y_01');"  
    style="display: inline"
    onclick="saveActionExtInfo();" /> </span></div>
</div>
<div class="content_02_box_div">

<TD>
<TABLE id=actexttab class="content_box_text">
    <TR>
        <TH class="content_02_box_div_table_th">选择执行人</TH>
        <TD class="content_02_box_div_table_td"><SELECT
            style="width: 130px; margin-left: 5px;" id="ISSHOWUSER"
            name="ISSHOWUSER">
            <OPTION value=Y>是</OPTION>
            <OPTION selected value=N>否</OPTION>
        </SELECT></TD>
        <TH class="content_02_box_div_table_th">是否退窗</TH>
        <TD><SELECT style="width: 130px; margin-left: 5px;"
            id="ISSHOWREJECT" name="ISSHOWREJECT">
            <OPTION value=Y>是</OPTION>
            <OPTION selected value=N>否</OPTION>
        </SELECT></TD>
    </TR>
    <TR>
        <TH>是否使用前置活动执行人</TH>
        <TD class="content_02_box_div_table_td">      
        <%=autoassignmentSelect%>   
        <!-- 
          <select id="autoassignment" name="autoassignment" style="width: 130px; margin-left: 5px;">
          <option value="">否</option>
          </select> --> 
        </TD>
        <TH>是否回退</TH>
        <TD>
          <SELECT style="width: 130px; margin-left: 5px;"
            id="ISSHOWBACK" name="ISSHOWBACK">
            <OPTION value=Y>是</OPTION>
            <OPTION selected value=N>否</OPTION>
          </SELECT>
        </TD>

    </TR>
    <TR>
        <TH>是否按顺序会签</TH>
        <TD class="content_02_box_div_table_td"><SELECT
            style="width: 130px; margin-left: 5px;" id="issignjoinbyorder"
            name="issignjoinbyorder">
            <OPTION selected value="">---请选择---</OPTION>
            <OPTION value="isJoinSign">无顺序会签</OPTION>
            <OPTION value="userLevelHighToLow">按级别从高到低</OPTION>
            <OPTION value="userLevelLowToHigh">按级别从低到高</OPTION>
        </SELECT></TD>
        <TH>是否分发</TH>
        <TD>
          <SELECT style="width: 130px; margin-left: 5px;"
            id="isdispense" name="isdispense">
            <OPTION value=Y>是</OPTION>
            <OPTION selected value=N>否</OPTION>
          </SELECT>
        </TD>
    </TR>
	<%if(isLatestAction){%>
	<TR>
        <TH>是否自动办结</TH>
        <TD class="content_02_box_div_table_td">
        	<SELECT style="width: 130px; margin-left: 5px;"
            id="is_auto_complete" name="is_auto_complete">
            <OPTION value=Y>是</OPTION>
            <OPTION selected value=N>否</OPTION>
          </SELECT>	
        </TD>
        <TH>&nbsp;</TH>
        <TD>&nbsp;</TD>
    </TR>
	<%}%>
</TABLE>
</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>