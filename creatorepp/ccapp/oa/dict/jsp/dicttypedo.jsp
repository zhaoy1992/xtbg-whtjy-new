<%-- 
描述：字典类型处理页面
作者：肖杰
版本：1.0
日期：2013-07-23
 --%>
<%@page import="com.chinacreator.xtbg.core.dict.entity.DictTypeBean"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.impl.DictServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.DictServiceIfc"%>
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

DictTypeBean dictTypeBean=new DictTypeBean();
DictServiceIfc dictServiceIfc = new DictServiceImpl();
dictTypeBean = (DictTypeBean)RequestBeanUtils.getValuesByRequest(request,dictTypeBean);
Map<String, String> viewMap = new HashMap<String, String>();
viewMap=dictServiceIfc.getDictTypeBydcode(dictTypeBean.getDict_code());
if("addDictType".equals(action)) {
	if("".equals(StringUtil.deNull(viewMap.get("dict_id")))){
		flag=dictServiceIfc.addDictType(dictTypeBean);
	}else{
		flag=true;
		flag1=false;
	}
} else if("deleteDicttype".equals(action)) {
	String dict_id=request.getParameter("dict_id");
	flag2=dictServiceIfc.deleteDictType(dict_id);
	flag=true;
} else if("updateDictType".equals(action)){
	if("".equals(StringUtil.deNull(viewMap.get("dict_id")))||(viewMap.get("dict_id").equals(dictTypeBean.getDict_id()))){
		flag=dictServiceIfc.updateDictType(dictTypeBean);
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
		alert("该类型下存在子类，请先删除子类！");
	}else if("data"=="<%=flag2%>"){
		alert("该类型下有数据，请先删除数据！");
	}else{
	if(<%=flag1%>){
		mes = "操作成功"; 
		var submitAlertOK = function(){
			//window.parent.removeWindows('<%=subid %>',true);
			if(action == "deleteDicttype"){
				window.parent.parent.parent.location.reload();
			}else if(action ="addDictType"){
				if("0"!="<%=dictTypeBean.getDict_parent_id()%>"){
					removeAlertWindows(subid, false, "111", "123", true, "<%=path%>/ccapp/oa/dict/jsp/dicttypetree.jsp?dict_id='<%=dictTypeBean.getDict_parent_id()%>'","1234");
				}else{
					removeAlertWindows(subid, false, "111", "123", true, "<%=path%>/ccapp/oa/dict/jsp/dicttypetree.jsp?dict_id='<%=dictTypeBean.getDict_id()%>'","1234");
				}
			}else{
				removeAlertWindows(subid, false, "111", "123", true, "<%=path%>/ccapp/oa/dict/jsp/dicttypetree.jsp?dict_id='<%=dictTypeBean.getDict_id()%>'","1234");
			}
		}
		var p={
			headerText:'操作信息',
			okName:'确认',
			okFunction:submitAlertOK
		};  
		alert("操作成功！",p);
	}else{
		alert('该编号已经被引用，请更换另外一个编号！');
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