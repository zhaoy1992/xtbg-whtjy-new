<%--
describe:档案管理首页
author:dailianchun
date: 2013-10-22
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="java.util.List"%>

<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    if(!accesscontroler.checkAccess(request, response)){
        return;
    }    
    String userid = accesscontroler.getUserID();//获得当前登录用户id
    String userRealName = accesscontroler.getUserName();//获得当前登录用户name
    String path1 = request.getContextPath();
    List<ShowItemBean> showItemList = FileCache.getShowItemList();
    String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.xtbg.core.file.entity.ShowItemBean"%>
<%@page import="com.chinacreator.xtbg.core.file.cache.FileCache"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/js/filefirstpage.js"></script>
<script type="text/javascript">
var path = "<%=path%>";
var userId = "<%=userid %>"; 
    $(document).ready(function(){
        //首次加载数据
    	init();

    	//每分钟刷新一次首页数据
        //setTimeout("init()",60000);
        
    });   

    function init(){
    	loadShowItem(path+"/ajaxServlet?className=com.chinacreator"+
    	        ".xtbg.core.file.action.FileFirstPageAction&method=queryListData",userId);
    } 
   
</script>
</head>
<body style="width: 100%;overflow:auto;overflow-y:auto;overflow-x:hidden;" class="vcenter">
    <table width="90%" border="0" align="center" cellpadding="0"
        cellspacing="0" style="float: left; margin-left: 20px;">
        <tr>
            <td>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="itemList">
                    <tr>
                    <%
                        int count = 1;//一行两个计数器
                        for(ShowItemBean bean : showItemList){
                            int rowNum = bean.getMaxRownum();
                    %>
                        <td valign="top" name="showItem" id="<%=bean.getId() %>" title="<%=bean.getName() %>">
                            <table border="0" cellpadding="0" cellspacing="0" class="main_table100">
                                <tr>
                                    <td height="29" class="main_table_hong">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td height="28" align="left" class="main_table_hong_zi">
                                                    <a>&nbsp;<%=bean.getName() %></a>
                                                </td>
                                                <td class="main_table_hong_pic">&nbsp;</td>
                                                <td class="main_table_hong_more" id="more">
                                                    <a href="javascript:void(0)" onclick="newwin('<%=request.getContextPath()+bean.getMoreUrl() %>','<%=bean.getName() %>','<%=bean.getId() %>')">更多>></a>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="main_hui" id="itemList_<%=bean.getId() %>">
                                            
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                            <%if(count % 2 == 0) {//偶数模块%>
                        </tr>
                                <%if(count < showItemList.size()) {%>
                        <tr>
                                <%}%>
                            <%}else{ %>
                        <td name="piningtd1">&nbsp;</td>
                            <%}count ++;} %>
                        <%if(count % 2 ==0) {%>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <%} %>  
                    </table>
                </td>
            </tr>
        </table>
</body>
</html>

