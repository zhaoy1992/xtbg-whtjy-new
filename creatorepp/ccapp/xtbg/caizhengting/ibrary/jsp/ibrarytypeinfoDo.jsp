<%@page import="com.chinacreator.xtbg.pub.util.BeanUtil"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryTreeBean"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryTreeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryTreeService"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 <title>
 </title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	BeanUtil<IbraryTreeBean> beanUtil = new BeanUtil<IbraryTreeBean>();
	String type = request.getParameter("type"); //删除类型  treetype 是删除中间层 booktype 是删除最低层
	IbraryTreeBean bean = beanUtil.requestToBean(request,IbraryTreeBean.class);
	String action = request.getParameter("actiontype");
	IbraryTreeService service = new IbraryTreeServiceImpl();
	String flag = "";
	if("insert".equals(action)) {
		flag = service.addIbraryTree(bean);
	} else if("update".equals(action)){
		flag = service.updatebean(bean);
	} else if("del".equals(action)) {
		flag = service.delIbraryTree(bean.getTree_id(),type);
	}
%>
<script type="text/javascript">
var mes = "<%=flag%>";
var bool = true;
if(mes=="操作失败"){
   bool = false;
}
if(mes!="操作成功"){
   bool = false;
}
var ok=function(){
	window.parent.parent.location.href="<%=path%>/ccapp/xtbg/caizhengting/ibrary/jsp/ibrarytypeindex.jsp";
}
if(window.top.removeAlertWindows('',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	}
}
</script>
<body>
</body> 
</html>
