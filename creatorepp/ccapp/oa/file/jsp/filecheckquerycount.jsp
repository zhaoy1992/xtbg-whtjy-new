<%--
　　描述：档案管理--档案查询次数统计
　　作者：邹拓
　　版本：1.0
　　日期：2013-10-22
	checktype：检查方式1:查询的时候,(有附件&&有权限)||(无附件)算一次,检查方式2:打开页面就算1次
	f_doc_id：档案id
	isview:是否是查询
	hasRole:是否有权限
	描述:将该页面include到 filedocdetail(4[.]+)?.jsp 的最后面,检测页面被查询次数
	目前:只检查文件的不检查案卷,照片文件打开一次算查询一次，其他文件，如果有权限打开一次算一次，没权限则不计算
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileReadRecodeInfoService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileReadRecodeInfoServiceImpl"%>
<%
	AccessControl ac = AccessControl.getInstance();
    ac.checkAccess(request, response);
    FileReadRecodeInfoService service = new FileReadRecodeInfoServiceImpl();
    service.insertBean(request,ac);
%>
