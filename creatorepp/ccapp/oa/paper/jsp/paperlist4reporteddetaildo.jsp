<%--
描述：信息--保存
作者：黄海
版本：1.0
日期：2013-09-13
--%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.impl.DictServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.DictServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.paper.entity.PaperBean"%>
<%@page import="com.chinacreator.xtbg.core.paper.util.*"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.PaperService"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.impl.PaperServiceImpl"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>


<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String responseCode="";//1:回调js
	Object responseObj=null;
	String responseObj_SUCCESS="操作成功";
	String responseObj_FIAL="操作失败";
	JSONObject json = new JSONObject();

	boolean flag = false;
	//1:分类处理请求
	String action = request.getParameter("action");
	String loadurl = request.getParameter("loadurl");
	PaperService service=new PaperServiceImpl();
	//1.1:增 改PsdataBaseInfo
	if("addpaperlist4reporteddetail".equals(action) || "addpaperlist4managedetail".equals(action)){
		responseCode = "1";
		PaperBean bean = new PaperBean();
		DictServiceIfc dictServiceIfc = new DictServiceImpl();
		bean = (PaperBean)RequestBeanUtils.getValuesByRequest(request,bean);
	    //保存或者修改
		String beanId = service.insertOrUpdateBean(bean);
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId+","+loadurl;
		}else{
			responseObj = responseObj_FIAL;
		}
	}else if("copydoc2pdf".equals(action)){//doc另存为一份名字一样pdf
		responseCode = "2";
		String p_manage_id = StringUtil.deNull(request.getParameter("p_manage_id"));
		flag=service.copydoc2pdf(p_manage_id,request.getSession().getServletContext().getRealPath(""));
		if(flag){
			responseObj=responseObj_SUCCESS;
		}else{
			responseObj = responseObj_FIAL;
		}
	}else if("updateLeaderRemark".equals(action)){//领导批示
		responseCode = "2";
		String p_manage_id = request.getParameter("p_manage_id");
		String p_leader_remark = request.getParameter("p_leader_remark");
		flag=service.updateLeaderRemark(p_manage_id,p_leader_remark);
		if(flag){
			responseObj=responseObj_SUCCESS;
		}else{
			responseObj = responseObj_FIAL;
		}
	}else if("accpaper4pending".equals(action)){//信息采编
		responseCode = "2";
		String ids = request.getParameter("ids");
		String[] idsArr = ids.split(",");
		flag = service.updatePaper2AccByIds(idsArr,PaperConstants.STATUS_ACCEPT,accesscontroler.getUserID());
		if(flag){
			responseObj=responseObj_SUCCESS;
		}else{
			responseObj = responseObj_FIAL;
		}
	}else if("unaccpaper".equals(action)){//退稿
		responseCode = "2";
		String p_manage_id = request.getParameter("p_manage_id");
		String p_unacc_user_id = request.getParameter("p_unacc_user_id");
		String p_unacc_user_name = request.getParameter("p_unacc_user_name");
		String p_unacc_remark = request.getParameter("p_unacc_remark");

		flag = service.updateUnAccInfo(p_manage_id,p_unacc_user_id,p_unacc_user_name,p_unacc_remark);
		if(flag){
			responseObj=responseObj_SUCCESS;
		}else{
			responseObj = responseObj_FIAL;
		}
	}else if("deletepaperlist4draftdetail".equals(action)){//1.2:删
		responseCode = "1";
		String deleteStr = request.getParameter("delete");
		String[] deleteArr = deleteStr.split(",");
		String flagStr = "false";
		if(deleteArr.length>0){
			flagStr = service.deletePaperByIds(deleteArr);
		}
		if("true".equals(flagStr)){
			flag=true;
			responseObj=responseObj_SUCCESS;
		}
		
		if(!flag){
			responseObj = responseObj_FIAL;
		}
	}
	
	//2:响应页面
	if("1".equals(responseCode)){
		if(responseObj!=null){
			String result = "";
			result = responseObj.toString();
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
	}else if ("2".equals(responseCode)){
		json.put("flag",flag);
		json.put("info",responseObj.toString());
		out.print(json);
	}
	%>