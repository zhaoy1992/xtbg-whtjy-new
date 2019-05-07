<%--
describe:任务添加，更新，保存操作的页面
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
<%@ page contentType="text/html; charset=GBK"%>
<%
    try {
        //操作类型
        String action = request.getParameter("action");
        TaskBaseInfoBean bean = new TaskBaseInfoBean();
        bean = (TaskBaseInfoBean) RequestBeanUtils.getValuesByRequest(request, bean);//获取表单提交过来的数据
        String task_needinfo = request.getParameter("task_needinfo");
        bean.setTask_needinfo(task_needinfo);
        //服务类
        TasksAssignedServiceIfc service = new TasksAssignedServiceImpl();
        //删除
        if(Constant.ACTION_DELETE.equals(action)){
            //要删除的数据列表
            String ids = request.getParameter("ids");
            boolean flag = service.deleteListTaskBaseInfo(ids);
            if(flag){
                out.print("{\"flag\":\"true\",\"msg\":\"操作成功!\"}");
            }else{
                out.print("{\"flag\":\"false\",\"msg\":\"操作失败!\"}");
            }       
        }   
        //添加
        if(Constant.ACTION_ADD.equals(action)){         
            boolean flag = service.insertTaskBaseInfo(bean);
            if(flag){
                out.print("{\"flag\":\"true\",\"msg\":\"操作成功!\"}");
            }else{
                out.print("{\"flag\":\"false\",\"msg\":\"操作失败!\"}");
            }
        }
        
        //更新
        if(Constant.ACTION_UPDATE.equals(action)){
            boolean flag = service.updateTaskBaseInfo(bean);
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