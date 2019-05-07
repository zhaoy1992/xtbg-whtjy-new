<%--
描述：人员持证录导入
姓名：戴连春
日期：2014-03-13
 --%>
 
<%@page import="com.chinacreator.xtbg.core.personholder.data.PersonTrainExcelToData"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.AbookInServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.AbookInServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.chinacreator.eppissue.menuissue.vo.MenuIssueVo"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<base href="<%=basePath%>"> 
<title>JGRID</title>

<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String user_id = accesscontroler.getUserID();
    String wdo = request.getParameter("wdo");
    String is_public = request.getParameter("is_public");
    boolean flag = true;
    //输出到导入页面的提示信息
    String outStr = "";
    PersonTrainExcelToData persontrainexceltodata = new PersonTrainExcelToData();

    //通过excel导入人员到通讯录
    if ("batch".equals(wdo)) {
        final String UpFileType = "xls";//上传文件类型
        final int MaxFileSize = 2 * 1024;//上传文件大小限制（文件大小2G）
        String err = "false";//错误标识
        String file_url = persontrainexceltodata.getTempExportFilePath();//应用更新临时文件路径
        file_url += System.currentTimeMillis()+".xls";
        SmartUpload su = new SmartUpload();//新建一个SmartUpload对象
        su.initialize(pageContext);//上传初始化
        su.upload();
        String filename = "";//上传文件
        try {
            File file = su.getFiles().getFile(0);//取文件
            //文件效验//判断用户是否选择了文件// 取得文件并保存
            if (!file.isMissing()) {
                String FileType = file.getFileExt();//得到文件扩展名
                FileType = FileType.toLowerCase();//将扩展名转换成小写
                if (UpFileType.indexOf(FileType) == -1) { 
                	outStr = "文件格式不对！只支持后缀为xls的文件";//文件格式不对
                    err = "true";
                }
                int FileSize = file.getSize() / (1024 * 1024);//得到文件大小（换算为M）
                if (err.equals("false") && FileSize > MaxFileSize) {
                	outStr = "文件太大！";//文件太大
                    err = "true";
                }
            } else {
            	outStr = "未选择文件！";//文件错误
                err = "true";
            }
            if (err.equals("false") && !file.isMissing()) {//如果文件正确则上传
                //java.io.File fileurl = new java.io.File(file_url);
                file.saveAs(file_url);
                outStr = "导入成功！";
            }
        } catch (Exception e) {
            flag = false;
            outStr = "导入失败！";//上传有误
            err = "true";
        }
        if ("false".equals(err)) {
            outStr = persontrainexceltodata.importExcelToData(file_url);
            java.io.File fileurl = new java.io.File(file_url);
        	fileurl.delete();
        }
    }
%>

<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"  charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"  charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
    mes = "操作成功"; 
}else{
    mes = "操作失败"    ;
    bool = false;
}
//保存单个的person
if("single"=="<%=wdo%>"){
    if(window.top.removeAlertWindows('',false,bool,mes,true)){
        if(bool){
            window.top.alert(mes);
        } else{
            window.top.alert(mes);
        }
    }
}   
//上传文件，则调用父页面的输出函数
<%if ("batch".equals(wdo)) {%>
    window.parent.setOutStr("<%=outStr%>"); 
<%}%>
</script>
</head>
<body>
</body> 
</html>