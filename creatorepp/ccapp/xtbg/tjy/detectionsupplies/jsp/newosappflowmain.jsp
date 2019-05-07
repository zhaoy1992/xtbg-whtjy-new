<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userName = accesscontroler.getUserAccount();

String busitype_type_code=StringUtil.deNull(request.getParameter("busitype_type_code"));//获取仪器设备类型分类
FlowInfoConfigServiceIfc flowInfoConfigServiceIfc = new FlowInfoConfigServiceImpl();
FlowInfoBean flowinfobean = new FlowInfoBean();
String busitypeCode = "'uuid_5201','uuid_6201'";
flowinfobean.setBusitype_code(busitypeCode);
List<FlowInfoBean>  flowInfoBeanList  = flowInfoConfigServiceIfc.getFlowBaseInfoList(flowinfobean);
// 此处应该做成配置
String upload_To_SeverPath = File.separator+"ccapp"+File.separator+"oa"+File.separator+"archive"+File.separator+"resources"+File.separator+"images"+File.separator;
upload_To_SeverPath = upload_To_SeverPath.trim();
String imgPath = path+upload_To_SeverPath;
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<link rel="stylesheet" href="css.css" type="text/css" />
<title>新建流程页面</title>
<script type="text/javascript">
function openForm(url, flowname){
	//var height = window.screen.availHeight;
	//var width = window.screen.availWidth;
	var width = jQuery(window.top).width();//界面宽度
	var height = jQuery(window.top).height();//界面高度
	url= url+"&height="+height;
	url= url+"&width="+width;
	url= url+"&windowsId=newwindows";
	//openAlertWindows('newwindows',url,flowname,width,height,'0%','0%');
	//弹出款TOP下移，空出标签页及以上位置，165为TOP图片高度，暂时写死，应该是根据TOP的页面高度去动态获取
	openAlertWindows('newwindows',url,flowname,width,height-86,86,'0%','','',true);
}

jQuery(function(){ //DOM Ready
	adaptationWH('','vcenter',120);
});

</script>
</head>

<body>
<div id="vcenter">
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="gongwen">
  <tr>
    <td height="30" class="gwlink"></td>
  </tr>
  <tr>
    <td><table border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;">
    	<%	int num =0;
    		while(flowInfoBeanList.size()>num){ %>
      <tr>	
      		<%for(int i=num; i < flowInfoBeanList.size();i++){
      			FlowInfoBean flowInfoBean = flowInfoBeanList.get(i);
      			String url = path+flowInfoBean.getFrom_path()+"?busiTypeCode="+flowInfoBean.getBusitype_code();
      			if("2".equals(flowInfoBean.getFlow_tyle())){
      				url = url+"&template_id="+flowInfoBean.getTemplate_id()+"&Template=word"+ flowInfoBean.getTemplate_id();
      			}
      		%>
      			<td width="169" align="center">
	      			<a href="#" onclick="openForm('<%=url%>','<%=flowInfoBean.getBusitype_name()%>')">
	      			<img src="<%=!StringUtil.isBlank(flowInfoBean.getForm_image_id())?imgPath+flowInfoBean.getForm_image_id():imgPath+"/pic5.gif" %>" alt="<%=flowInfoBean.getFlow_name() %>" width="129" height="79" /></a>
      			</td>
      		<%
			 if(i%5==4){//换行处理
				 break;
			 }      		
      		} %>
      </tr>
      <tr>
      		<%for(int i=num; i < flowInfoBeanList.size();i++){%>
 				<td height="40" align="center" class="font2"><%=flowInfoBeanList.get(i).getFlow_name() %></td>      		
 			<%
 				num++;
	 			if(i%5==4){//换行处理
	 				 break;
	 			}
      		} %>
      </tr>
    	  <%} %>
    </table></td>
  </tr>
</table>
</div>
</body>
</html>