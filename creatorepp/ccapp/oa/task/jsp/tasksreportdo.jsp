<%--
describe:添加任务回复的页面
author:dailianchun
date: 2013-7-11
--%>

<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant" %>
<%@page import="com.chinacreator.xtbg.core.common.util.*" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.task.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.task.service.*"%>
<%@page import="com.chinacreator.xtbg.core.task.service.impl.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    try {
        //操作类型
        String action = request.getParameter("action");
        TaskReportBean bean = new TaskReportBean();
        bean = (TaskReportBean) RequestBeanUtils.getValuesByRequest(request, bean);//获取表单提交过来的数据
        //服务类
        TasksReportServiceIfc service = new TasksReportServiceImpl();
           
        //添加
        if(Constant.ACTION_ADD.equals(action)){         
            boolean flag = service.insertTaskReport(bean);
            if(flag){
                out.print("{\"flag\":\"true\",\"msg\":\"操作成功!\"}");
            }else{
                out.print("{\"flag\":\"false\",\"msg\":\"操作失败!\"}");
            }
        }
        
        //更新
        if(Constant.ACTION_UPDATE.equals(action)){
            boolean flag = true;
            if(flag){
                out.print("{\"flag\":\"true\",\"msg\":\"操作成功!\"}");
            }else{
                out.print("{\"flag\":\"false\",\"msg\":\"操作失败!\"}");
            }
        }
        
    } catch (Exception e) {
        /**忽略界面异常**/        
        out.print("{\"flag\":\"false\",\"msg\":\"操作失败!\"}");
    }
%>