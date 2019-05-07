<%--
描述：档案管理-档案分类请求处理
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
if("addFileTypeInfo".equals(action)){
	responseCode = "1";
	FileTypeBean bean = new FileTypeBean();
	bean = (FileTypeBean)RequestBeanUtils.getValuesByRequest(request,bean);
	FileTypeServiceIfc service = new FileTypeServiceImpl();
	String beanId = service.insertOrUpdateFileTypeBean(bean);
	if(beanId!=null&&beanId.length()>0){
		responseObj = responseObj_SUCCESS+","+beanId;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.2:删FileTypeInfo
if("deleteFileTypeInfo".equals(action)){
	responseCode = "1";
	String deleteStr = request.getParameter("delete");
	String[] deleteArr = deleteStr.split(",");
	boolean flag = false;
	if(deleteArr.length>0){
		FileTypeServiceIfc service = new FileTypeServiceImpl();
		if(!service.checkChildrenNode(deleteArr)){
			if(!service.checkUsedData(deleteArr)){
				flag = service.deleteFileTypeInfoByIds(deleteArr);
				if(flag){
					responseObj = responseObj_SUCCESS;
				}else{
					responseObj = responseObj_FIAL;
				}
			}else{
				responseObj = "无法删除:分类已经被使用";
			}
		}else{
			responseObj = "无法删除:存在子分类";
		}
	}
}


//1.3:添加档案分类密级
if("addFilePurviewInfo".equals(action)){
	responseCode = "1";
	FilePurviewBean bean = (FilePurviewBean)RequestBeanUtils.getValuesByRequest(request,new FilePurviewBean());
	FileTypeServiceIfc service = new FileTypeServiceImpl();
	boolean flag = service.insertOrUpdateFilePurviewBean(bean);
	if(flag){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.4:删除档案分类密级
if("deleteFilePurviewInfo".equals(action)){
	responseCode = "1";
	String deleteStr = request.getParameter("delete");
	String[] deleteArr = deleteStr.split(",");
	boolean flag = false;
	if(deleteArr.length>0){
		FileTypeServiceIfc service = new FileTypeServiceImpl();
		flag = service.deleteFilePurviewInfoByIds(deleteArr);
	}
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
//1.7:拖拽式 排序
if("order".equals(action)){
	responseCode = "2";
	FileTypeServiceIfc service = new FileTypeServiceImpl();
	String nodes = request.getParameter("nodes");
	boolean flag = false;
	if(!StringUtil.nullOrBlank(nodes)){
		flag = service.sortOrg(nodes);
	}
	responseObj="{'msg':'','flag':'"+flag+"'}";
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