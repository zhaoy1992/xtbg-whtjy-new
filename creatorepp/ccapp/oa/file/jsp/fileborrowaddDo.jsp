<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileLendingServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FilelendingBean"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<title>借阅处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String F_USER_ID = accesscontroler.getUserID();
String F_USER_NAME = accesscontroler.getUserName();
boolean flag = false;
String flagStr = "操作失败";
String subid=request.getParameter("subid");
String action = request.getParameter("action");

FileLendingServiceIfc fileFondsnoServiceIfc = new FileLendingServiceImpl();
Date dt=new Date();
SimpleDateFormat matter1=new SimpleDateFormat("yyyy-MM-dd");

if(action.equals("add")){
	String[] f_doc_id = request.getParameterValues("f_doc_id");
	String[] f_lending_type = request.getParameterValues("f_lending_type");
	String[] ydqx = request.getParameterValues("ydqxHidden");
	String[] F_lending_day = request.getParameterValues("OA_FILE_LENDING_DETAIL__F_LENDING_DAY");
	
	String f_lending_id = request.getParameter("f_lending_id");
	FilelendingBean filelendingBean = new FilelendingBean();
	filelendingBean = (FilelendingBean)RequestBeanUtils.getValuesByRequest(request,filelendingBean);
	filelendingBean.setF_lending_id(f_lending_id);

	List<FileLendingDetailBean> list = new ArrayList<FileLendingDetailBean>();
	for(int i=0;i<f_doc_id.length;i++){
		FileLendingDetailBean detailBean = new FileLendingDetailBean();
		detailBean.setF_lending_id(f_lending_id);
		detailBean.setF_lending_type(f_lending_type[i]);
		detailBean.setF_doc_id(f_doc_id[i]);
		detailBean.setF_lending_time(matter1.format(dt));
		detailBean.setF_lending_day(F_lending_day[i]);
		detailBean.setF_lending_userid(accesscontroler.getUserID());
		detailBean.setF_isagree("1");//统一借出
		detailBean.setF_islending("1");   //是否以借阅  1 表示true 否则false
		detailBean.setF_isback("0");   //是否以归还  0 表示true 否则false
		detailBean.setF_user_name(F_USER_NAME);   //借出经手人 用当前登录的用户来填充
		detailBean.setF_user_id(F_USER_ID);
		detailBean.setF_read_approve(ydqx[i]);   //阅读权限
		list.add(detailBean); //保存借阅详细信息
	}
	flagStr = fileFondsnoServiceIfc.saveFileFondsno(filelendingBean,list);//保存借阅信息
	if(flagStr.length()==0){
		flag = true;
	}else{
		flag = false;
	}
}else if(action.equals("giveback")){
	String f_detail_id = request.getParameter("f_detail_id");
	String f_lending_types = request.getParameter("f_lending_types");
	String f_doc_ids = request.getParameter("f_doc_ids");
	if(f_detail_id!=null&&f_lending_types!=null&&f_doc_ids!=null){
		f_detail_id = f_detail_id.replace("'","");
		String[] ids=f_detail_id.split(",");
		
		f_lending_types = f_lending_types.replace("'","");
		String[] f_lending_typesArr=f_lending_types.split(",");
		
		f_doc_ids = f_doc_ids.replace("'","");
		String[] f_doc_idsArr=f_doc_ids.split(",");
		if(f_lending_typesArr.length==ids.length&&f_doc_idsArr.length==ids.length){
			List<FileLendingDetailBean> list = new ArrayList<FileLendingDetailBean>();
			for(int j=0;j<ids.length;j++){
				FileLendingDetailBean detailBean = new FileLendingDetailBean();
				detailBean.setF_detail_id(ids[j]);
				detailBean.setF_back_time(matter1.format(dt));
				detailBean.setF_back_userid(F_USER_ID);
				detailBean.setF_back_username(F_USER_NAME);
				detailBean.setF_lending_type(f_lending_typesArr[j]);
				detailBean.setF_doc_id(f_doc_idsArr[j]);
				detailBean.setF_isback("1");
				list.add(detailBean);
			}
			flag = fileFondsnoServiceIfc.givebackDetail(list);
		}
	}
}
%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
if(<%=flag%>){
	bool = false;
		mes = '操作成功!'; 
		var submitAlertOK = function(){
	
			if(action == "giveback"){
				window.parent.location.reload();
			}else{
				window.parent.location.href="fileborrowtabs.jsp?index=2";
			}
		}
		var p={
				headerText:'操作信息',
				okName:'确认',
		        okFunction:submitAlertOK
		};
		alert('操作成功!',p);
}else{
	bool = false;
	alert("<%=flagStr%>!");
}
</script>
</head>
</body> 
</html>