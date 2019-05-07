<%--
描述：档案管理-档案移交请求处理
作者：邹拓
版本：1.0
日期：2013-7-16
UTF-8
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileTypeBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileTypeServiceImpl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FilePurviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileDocService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileDocServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean"%>
<%@page import="com.chinacreator.xtbg.core.file.dao.imploracle.FileFilesDevolveDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesDevolveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesDevolveService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileLendingServiceImpl"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String responseCode="";//1:回调js,2:ajax
Object responseObj=null;
String responseObj_SUCCESS="操作成功";
String responseObj_FIAL="操作失败";

//1:分类处理请求
String action = request.getParameter("action");
//1.1:增 改FileTypeInfo
if("addFileFilesDevolveBean".equals(action)){
	responseCode = "1";
	FileFilesDevolveBean bean = new FileFilesDevolveBean();
	bean = (FileFilesDevolveBean)RequestBeanUtils.getValuesByRequest(request,bean);
	FileFilesDevolveService service = new FileFilesDevolveServiceImpl();
	String beanId = service.addOrUpdate(bean);
	if(beanId!=null&&beanId.length()>0){
		responseObj = responseObj_SUCCESS+","+beanId;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.2:删bean
if("deleteFilesdevolve".equals(action)){
	responseCode = "1";
	String deleteStr = request.getParameter("delete");
	String[] deleteArr = deleteStr.split(",");
	boolean flag = false;
	if(deleteArr.length>0){
		FileFilesDevolveService service = new FileFilesDevolveServiceImpl();
		flag = service.delBeanByIds(deleteStr);
		if(flag){
			responseObj = responseObj_SUCCESS;
		}else{
			responseObj = responseObj_FIAL;
		}
	}
}


//1.3:添加档案分类密级
if("addfiles".equals(action)){
	responseCode = "1";
	String deleteStr = request.getParameter("delete");
	String beanId = request.getParameter("beanId");
	String[] deleteArr = deleteStr.split(",");
	boolean flag = false;
	if(deleteArr.length>0){
		FileFilesDevolveService service = new FileFilesDevolveServiceImpl();
		flag = service.addDetailBeanByIds(deleteStr,beanId);
	}
	
	if(flag){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.4:删除
if("deleteFilesdevolveDetail".equals(action)){
	responseCode = "1";
	String deleteStr = request.getParameter("delete");
	boolean flag = false;
	FileFilesDevolveService service = new FileFilesDevolveServiceImpl();
	flag = service.delDetailBeanByIds(deleteStr);
	if(flag){
		responseObj = "delete,"+responseObj_SUCCESS;
	}else{
		responseObj = "delete,"+responseObj_FIAL;
	}
}

//1.5:导出照片详情
if("exportPicDetail".equals(action)){
	responseCode = "2";
	FileDocService service = new FileDocServiceImpl();
	String id = request.getParameter("id");
	String type = request.getParameter("type");
	if(!StringUtil.nullOrBlank(id)&&!StringUtil.nullOrBlank(type)){
		responseObj = service.getPhotoMess(id,type);
	}else{
		responseObj = new ArrayList<Map<String,String>>();
	}
}

//1.5:导出照片组详情
if("exportPicFile".equals(action)){
	responseCode = "2";
	FileDocService service = new FileDocServiceImpl();
	String id = request.getParameter("id");
	if(!StringUtil.nullOrBlank(id)){
		responseObj = service.getPhotoFileMess(id);
	}else{
		responseObj = new ArrayList<Map<String,String>>();
	}
}

//1.6:导出照片详情
if("exportPic".equals(action)){
	responseCode = "2";
	FileDocService service = new FileDocServiceImpl();
	String id = request.getParameter("id");
	if(!StringUtil.nullOrBlank(id)){
		responseObj = service.getPhoto(id);
	}else{
		responseObj = new ArrayList<Map<String,String>>();
	}
}
//1.7:删除
if("deleteFlow".equals(action)){
	responseCode = "1";
	String deleteStr = request.getParameter("delete");
	boolean flag = false;
	FileLendingServiceIfc service = new FileLendingServiceImpl();
	flag = service.deleteFlow(deleteStr);
	if(flag){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}
//2:响应页面
if("1".equals(responseCode)){
	if(responseObj!=null){
		String result = "";
		if(responseObj instanceof String){
			result = responseObj.toString();
		}else{
			result = JSON.toJSONString(responseObj,true);
			Pattern p = Pattern.compile("\\s*|\t|\r|\n");
			Matcher m = p.matcher(result);
			result= m.replaceAll("");
		}
		%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<head></head>
	<body>
	<script>
		try{
			var result='<%=result%>';
			eval("parent.afterSubmitFn('"+result+"');");
		}catch(e){alert(e.description);}
	</script>
	</body>
</html>
		<%
	}
}else if("2".equals(responseCode)){
	if(responseObj!=null){
		if(responseObj instanceof String){
			out.print(responseObj.toString());
		}else{
			out.write(JSON.toJSONString(responseObj,true));//输出list或者对象
		}
	}
}
%>