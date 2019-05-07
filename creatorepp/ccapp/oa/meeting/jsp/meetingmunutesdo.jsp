<%--
describe:会议纪要，处理页面
author:dailianchun
date: 2013-6-26
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.xtbg.core.common.commonlist.Constant" %>
<%@ page import="com.chinacreator.xtbg.core.meeting.service.*" %>
<%@ page import="com.chinacreator.xtbg.core.meeting.service.impl.*" %>
<%@ page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page import="com.chinacreator.xtbg.core.meeting.entity.MeetingMinutesBean"%>
<%
    try {
        //操作类型
        String action = request.getParameter("action");
        String json = StringUtil.deNull(request.getParameter("paramJson"));
        String m_title = request.getParameter("m_title");
        MeetingMinutesBean bean = new MeetingMinutesBean();
        bean = (MeetingMinutesBean)RequestBeanUtils.getValuesByRequest(request,bean);//获取表单提交过来的数据
        //服务类
        MeetingMinutesService service = new MeetingMinutesServiceImpl();
        //删除
        if(Constant.ACTION_DELETE.equals(action)){
            //要删除的数据列表
            String ids = request.getParameter("ids");
            boolean flag = service.deleteListMeetingMinutes(ids);
            if(flag){
                out.print("{\"flag\":\"true\",\"msg\":\"删除成功\"}");
            }else{
                out.print("{\"flag\":\"false\",\"msg\":\"删除失败\"}");
            }        
        }   
        //添加
        if(Constant.ACTION_ADD.equals(action)){         
            boolean flag = service.insertMeetingMinutesBean(bean);
            if(flag){
                out.print("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
            }else{
                out.print("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
            }
        }
        
        //更新
        if(Constant.ACTION_UPDATE.equals(action)){
            boolean flag = service.updateMeetingMinutesBean(bean);
            if(flag){
               out.print("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
            }else{
                out.print("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
            }
        }        
    } catch (Exception e) {
        /**忽略界面异常**/        
        out.print("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
    }
%>