<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao"%>

<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowActionTreeConfigBean"%><html>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String actionid = request.getParameter("actionid");
	FlowActionTreeConfigBean flowActionTreeConfigBean = new FlowActionTreeConfigBean();
	FlowInfoDao flowInfodao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
	if(!StringUtil.nullOrBlank(actionid)){
		flowActionTreeConfigBean = flowInfodao.findFlowWfactionTreeConfigById(actionid);
	}
%>

<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>

<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- �������� -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>������������Ϣ</title>
<script type="text/javascript">
var config_id = '<%=flowActionTreeConfigBean.getConfig_id()%>';//������������Ϣ
var action_id = '<%=actionid%>';

var init = function() {
	if('<%=flowActionTreeConfigBean.getConfig_id()%>' != null){
		$("input[name=tree_role][value=<%=flowActionTreeConfigBean.getTree_role()%>]").attr("checked",'checked');
		$("input[name=tree_nodetype][value=<%=flowActionTreeConfigBean.getTree_nodetype()%>]").attr("checked",'checked');
	}
}

function saveActionTreeConfigInfo(){
    var url = "saveactionTreeConfigform.jsp";
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    document.all.form1.submit();
}

</script>
</head>
<body onload="init()">
<form id=form1 name=form1 method="post">
<input type=hidden value="<%=flowActionTreeConfigBean.getConfig_id() %>" id="config_id" name="config_id"/>
<input type=hidden value="<%=actionid %>" id="action_id" name="action_id"/>
<input id="jsonparam" name="jsonparam" type="hidden"/>
 <div class="content_02_box" >
		 <div class="content_02_box_title_bg"><span>������Ϣ</span>
		  <div class="content_02_box_add" >
		         <span id="selAreaImg" class="tabs_search_text_but">
	   				<input type="button" id="choose" name="choose" value="����" class="but_y_01" 
	   				onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');
	   				style="display: inline" onclick="saveActionTreeConfigInfo();"/>
	   				</span>
				 </div>
		 </div>
		 <div class="content_02_box_div">
        <TABLE id=actexttab   class="content_box_text myTable" >
              <TR>
                 <TH title="��̬ѡ����Ա����Ȩ��">��Ա����Ȩ��</TH>
                 <TD class="content_02_box_div_table_td">
                 	������Ա:<input type="radio" name="tree_role" value="allPeople" checked="checked">
                 	������Ա:<input type="radio" name="tree_role" value="configPeople">
                 </TD>
                <TH title="��̬ѡ����Ա���Ľڵ㹴ѡ����">��Ա���Ľڵ㹴ѡ����</TH>
                 <TD>
              		 ��ѡ��:<input type="radio" name="tree_nodetype" value="checkbox" checked="checked">
                 	 ��ѡ��:<input type="radio" name="tree_nodetype" value="radio">
                 </TD>
              </TR>
              
        </TABLE>
</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>