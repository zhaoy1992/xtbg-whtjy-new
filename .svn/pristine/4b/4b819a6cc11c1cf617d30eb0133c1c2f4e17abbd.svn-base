<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userName = accesscontroler.getUserAccount();
String busitype_type_code = request.getParameter("busitype_type_code");//获取公文类型分类
FlowInfoConfigServiceIfc flowInfoConfigServiceIfc = new FlowInfoConfigServiceImpl();
FlowInfoBean bean=new FlowInfoBean();
bean.setBusitype_type_code(busitype_type_code);
bean.setFlow_name(accesscontroler.getUserName());
//判断是否要通过单位过滤
String flag=OASystemCache.getContextProperty("unit_filter");
if("true".equals(flag)){//要过滤
	UserCacheBean userbean=UserCache.getUserCacheBean(accesscontroler.getUserID());
	String orgid="";
	if(userbean!=null){
		orgid=userbean.getUnit_ids();
	}
	bean.setOrg_id(orgid);
}

List<FlowInfoBean>  flowInfoBeanList  = flowInfoConfigServiceIfc.getFlowBaseInfoList(bean);;
//TODO 此处应该做成配置
String upload_To_SeverPath = File.separator+"ccapp"+File.separator+"oa"+File.separator+"archive"+File.separator+"resources"+File.separator+"images"+File.separator;
upload_To_SeverPath = upload_To_SeverPath.trim();
String imgPath = path+upload_To_SeverPath;
//PresentDAOIfc  presentDaoIfc = new PresentDAOImpl();
//subCode = presentDaoIfc.getSubcodeByUserNmae(userName);
//String userArea = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<link rel="stylesheet" href="css.css" type="text/css" />
<title>新建流程页面</title>
<script type="text/javascript">
function openForm(url, flowname){
	parent.openForms(url, flowname);
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
    <td>
    <%if(true){//财政厅
    	StringBuffer htmlStr = new StringBuffer();
    	htmlStr.append("<br>");
    	if(flowInfoBeanList!=null&&flowInfoBeanList.size()>0){
    		htmlStr.append("<select size='15' style='border:1px solid #CCC;height:250px;width:500px;font-size:18px;font-family:微软雅黑' onclick='fetchSelect(this)'>");
    		for(FlowInfoBean flowInfoBean : flowInfoBeanList){
    			String url = path+flowInfoBean.getFrom_path()+"?busiTypeCode="+flowInfoBean.getBusitype_code();
    			if("2".equals(flowInfoBean.getFlow_tyle())){
      				url = url+"&template_id="+flowInfoBean.getTemplate_id()+"&Template=word"+ flowInfoBean.getTemplate_id();
      			}
    			String busitypeName = flowInfoBean.getBusitype_name();
    			String flowName = flowInfoBean.getFlow_name();
    			htmlStr.append("<option url='"+url+"' busitypeName='"+busitypeName+"' title='"+flowName+"'>"+flowName+"</option>");
    		}
    		htmlStr.append("</select>");
    		htmlStr.append("<script type='text/javascript'>")
    				.append("function fetchSelect(obj){")
    				.append(" obj = jQuery(obj).find('option[selected=\"selected\"]')[0];if(obj&&obj.url)openForm(obj.url,obj.busitypeName);")
    				.append("}")
    				.append("</script>");
    	}else{
    		htmlStr.append("<div style='border:1px solid #CCC;height:400px;width:800px;font-size:18px;font-family:微软雅黑'>未找到该公文类型内的流程</div>");
    	}
    	out.print(htmlStr);
    } %><%--else{%>
    	 <table border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;">
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
		      			<img src="<%=!StringUtil.isBlank(flowInfoBean.getForm_image_id())?imgPath+flowInfoBean.getForm_image_id():"resources/images/pic5.gif" %>" alt="<%=flowInfoBean.getFlow_name() %>" width="100" height="50" /></a>
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
	      <tr style="height: 28px"></tr>
	    	  <%} %>
	    </table>
   	<%}%> --%>
    
    
    </td>
  </tr>
</table>
</div>
</body>
</html>