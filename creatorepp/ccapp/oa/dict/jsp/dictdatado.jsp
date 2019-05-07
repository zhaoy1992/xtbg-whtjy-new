<%-- 
描述：字典数据处理页面
作者：肖杰
版本：1.0
日期：2013-07-23
 --%>
<%@page import="com.chinacreator.xtbg.core.dict.service.impl.DictServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.DictServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.dict.entity.DictDataBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<head>
<title>字典数据处理页面</title>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
boolean flag1=true;
String flag2="";
String subid=request.getParameter("subid");
String action = request.getParameter("action");
Object treeNode = request.getParameter("treeNode");
String dict_type = request.getParameter("dict_type");
String org_id = request.getParameter("org_id");
String orgid = request.getParameter("orgid");

DictDataBean dictDataBean=new DictDataBean();
DictServiceIfc dictServiceIfc = new DictServiceImpl();
dictDataBean = (DictDataBean)RequestBeanUtils.getValuesByRequest(request,dictDataBean);
Map<String, String> viewMap = new HashMap<String, String>();
viewMap=dictServiceIfc.getDictDataBydvalue(dictDataBean.getDictdata_value(),dictDataBean.getDict_id());
if("addDictData".equals(action)) {
	if("".equals(StringUtil.deNull(viewMap.get("dictdata_id")))){
		flag=dictServiceIfc.addDictData(dictDataBean);
	}else{
		flag=true;
		flag1=false;
	}
} else if("deleteDictdata".equals(action)) {
	String dictdata_id=request.getParameter("dictdata_id");
	flag2=dictServiceIfc.deleteDictData(dictdata_id);
	flag=true;
} else if("updateDictData".equals(action)){
	if("".equals(StringUtil.deNull(viewMap.get("dictdata_id")))||(viewMap.get("dictdata_id").equals(dictDataBean.getDictdata_id()))){
		flag=dictServiceIfc.updateDictData(dictDataBean);
	}else{
		flag=true;
		flag1=false;
	}
}


%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
var subid="<%=subid%>";
if(<%=flag%>){
	bool = false;
	if("parent"=="<%=flag2%>"){
		alert("删除的数据中存在有子数据！");
		window.parent.parent.location.reload();
	}else{
	if(<%=flag1%>){
		mes = "操作成功"; 
		var submitAlertOK = function(){
			//window.parent.removeWindows('<%=subid %>',true);
			if(action == "deleteDictdata"){
				window.parent.parent.location.href="<%=path%>/ccapp/oa/dict/jsp/dictdataviewmain.jsp?orgid=<%=orgid%>&dict_type=<%=dict_type%>&dictdata_id=<%=org_id%>";
			}else{
				window.parent.parent.location.href="<%=path%>/ccapp/oa/dict/jsp/dictdataviewmain.jsp?orgid=<%=dictDataBean.getDict_id()%>&dict_type=<%=dict_type%>&dictdata_id=<%=org_id%>";
			}
		}
		var p={
			headerText:'操作信息',
			okName:'确认',
			okFunction:submitAlertOK
		};  
		alert("操作成功！",p);
	}else{
		alert('该字典数据编号在该类型下已经被引用，请更换另外一个编号！');
	}
	}
}else{
	mes = "操作失败"	;
	bool = false;
}
</script>
</head>
<body>
</body> 
</html>