<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.xtbg.core.dssave.service.DsCRUDService"%>
<%@ page import="com.chinacreator.xtbg.core.dssave.service.impl.DsCRUDServiceImpl"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.file.dao.FileTypeDao"%>
<%@page import="com.chinacreator.xtbg.core.file.dao.imploracle.FileTypeDaoImpl"%>
<%
AccessControl control = AccessControl.getInstance();
control.checkAccess(request, response);
String msg = "";
String otp_type = request.getParameter("opt_type");
String windowId = request.getParameter("windowId");
String action = request.getParameter("action");
boolean flag = false;
Connection conn = null;
try{
	conn = DbManager.getInstance().getTransactionConnection();
	DsCRUDService  dsCRUDService = new DsCRUDServiceImpl();
	if("save".equals(otp_type)){//新增操作
		flag=dsCRUDService.dsSave(request, conn);
	    String busi_id = request.getParameter("busi_id");
	    String f_files_id = request.getParameter("f_files_id");
	    if(!StringUtil.nullOrBlank(f_files_id) && !StringUtil.nullOrBlank(busi_id)){
	    	
	    	FileDocFilesBean bean = new FileDocFilesBean();
            bean.setF_docfiles_id(StringUtil.getUUID());
            bean.setF_files_id(f_files_id);
            bean.setF_doc_id(busi_id);
            FileFilesDao dao = (FileFilesDao) LoadSpringContext.getApplicationContext()
               .getBean("fileFilesDaoImpl");
            ((BaseDao)dao).insert(bean,conn);
            FileFilesServiceImpl service = new FileFilesServiceImpl();
            service.keepRightData(conn,f_files_id);
            //同时更新刚刚插入的文件的状态为已归档
            FileDocBean doc = new FileDocBean();
            doc.setF_doc_id(busi_id);
            doc.setF_doc_state("2");
            doc.setF_doc_state_name("已归档");
            doc.setF_destroy_state("0"); //默认为0 
            ((BaseDao)dao).update(doc,conn);            
	    }
		FileTypeDao daoType = new FileTypeDaoImpl();
		daoType.updateLevelThreeType(request.getParameter("OA_FILE_DOC__F_TYPE_ID"),conn);
	}else if("update".equals(otp_type)){//新增操作
		flag=dsCRUDService.dsUpdate(request, conn);
	}else if("delete".equals(action)){//新增操作
		String businessType = request.getParameter("businessType");
		String ids = request.getParameter("ids");
		String[] arr = ids.split(",");
		for(int i=0;i<arr.length;i++){
			flag=dsCRUDService.dsDel(businessType,arr[i],conn);	
		}
	}else if("deleteFilephotoinfo".equals(otp_type)){//删除照片信息
		String businessType = request.getParameter("businessType");
		String ids = request.getParameter("delete");
		String[] arr = ids.split(",");
		for(int i=0;i<arr.length;i++){
			if(arr[i].length()>0)
			flag=dsCRUDService.dsDel(businessType,arr[i],conn);	
		}
	}else if("jieshou".equals(otp_type)){
		String businessType = request.getParameter("businessType");
		String ids = request.getParameter("ids");
		String[] arr = ids.split(",");
		FileTypeDao daoType = new FileTypeDaoImpl();
		flag=daoType.jieshou(arr,conn);
	}else if("tuihui".equals(otp_type)){
		String businessType = request.getParameter("businessType");
		String ids = request.getParameter("ids");
		String[] arr = ids.split(",");
		FileTypeDao daoType = new FileTypeDaoImpl();
		flag=daoType.tuihui(arr,conn,request.getParameter("mess"));
	}
	conn.commit();
}catch(Exception e){
	DbManager.rollBackNoThrow(conn);
	e.printStackTrace();
	msg = e.getMessage();
}finally{
	DbManager.closeConnection(conn);
}
if("delete".equals(action)
		||"jieshou".equals(otp_type)){
	out.print(flag);
}else{
%>
	<%@page import="java.sql.Connection"%>
	<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
	<%@page import="com.chinacreator.xtbg.core.file.entity.FileDocFilesBean"%>
	<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
	
	<%@page import="com.chinacreator.xtbg.core.file.dao.FileFilesDao"%>
	<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
	
	
	<%@page import="com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao"%>
	<%@page import="com.chinacreator.xtbg.core.file.entity.FileDocBean"%><html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title></title>
	</head>
	<body>
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript">
	if(typeof(parent.afterSubmitFn)=="function"){
		parent.afterSubmitFn('<%=otp_type%>','<%=flag%>');
	}else{
		var msg = "<%=msg.replaceAll("\n","’").replaceAll("\"","’")%>";
		var bool = true;
		<%if (flag){%>
			bool = true;
			msg = "操作成功";
		<%}else{%>
			bool = false;
			msg = "操作失败   >>"+msg;
		<%}%>
		var ok=function(){
			if(parent&&parent.afterSubmitFn){
				eval("parent.afterSubmitFn('<%=otp_type%>','<%=flag%>');");
				return;
			}else{
				//closeAlertWindows('<%=windowId%>', false, true);
				getParentWindow('<%=windowId%>').search();
				removeAlertWindowByWindowID('<%=windowId%>');
			}
		}
		if(bool){
			window.top.alert(msg,{headerText:'处理结果',okName:'确认',okFunction:ok});
		}
		else{
			window.top.alert(msg);
			closeAlertWindows('<%=windowId%>', false, true);
		}
	}
	</script>
	</body>
	</html>
<%
}
%>