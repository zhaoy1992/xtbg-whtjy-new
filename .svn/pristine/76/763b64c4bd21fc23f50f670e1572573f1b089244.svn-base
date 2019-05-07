<%--
describe:会议模板管理操作页面
author:dailianchun
date: 2013-6-29
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.xtbg.core.common.commonlist.Constant" %>
<%@ page import="com.chinacreator.xtbg.core.meeting.service.*" %>
<%@ page import="com.chinacreator.xtbg.core.meeting.service.impl.*" %>
<%@ page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page import="com.chinacreator.xtbg.core.meeting.entity.MeetingTemplateBean"%>
<%
    try {
        //操作类型
        String action = request.getParameter("action");

        MeetingTemplateBean bean = new MeetingTemplateBean();
        bean = (MeetingTemplateBean) RequestBeanUtils
                .getValuesByRequest(request, bean);//获取表单提交过来的数据
        //服务类
        MeetingTemplateService service = new MeetingTemplateServiceImpl();
        //删除
        if (Constant.ACTION_DELETE.equals(action)) {
            //要删除的数据列表
            String ids = request.getParameter("ids");
            boolean flag = service.deleteListMeetingTemplate(ids);
            if (flag) {
                out.print(
                        "{\"flag\":\"true\",\"msg\":\"删除成功\"}");
            } else {
                out.print(
                        "{\"flag\":\"false\",\"msg\":\"删除失败\"}");
            }
        }
        //添加
        if (Constant.ACTION_ADD.equals(action)) {
            boolean flag = service.insertMeetingTemplate(bean);
            if (flag) {
                out.print(
                        "{\"flag\":\"true\",\"msg\":\"操作成功\"}");
            } else {
                out.print(
                        "{\"flag\":\"false\",\"msg\":\"操作失败\"}");
            }
        }

        //更新
        if (Constant.ACTION_UPDATE.equals(action)) {
            boolean flag = service.updateMeetingTemplate(bean);
            if (flag) {
                out.print(
                        "{\"flag\":\"true\",\"msg\":\"操作成功\"}");
            } else {
                out.print(
                        "{\"flag\":\"false\",\"msg\":\"操作失败\"}");
            }
        }
        
        //查询
        if(Constant.ACTION_QUERY.equals(action)){
        	String id = StringUtil.deNull(request.getParameter("id"));
        	String json = service.queryToMeetingTemplateJSON(id);
        	out.print(json);
        }

    } catch (Exception e) {
        /**忽略界面异常**/
        out.print(
                "{\"flag\":\"false\",\"msg\":\"操作失败\"}");
    }
%>