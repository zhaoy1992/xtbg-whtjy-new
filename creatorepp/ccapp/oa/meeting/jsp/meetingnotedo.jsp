<%--
describe:短信模板操作do页面
date: 2013-7-10 hai.huang
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.xtbg.core.common.commonlist.Constant" %>
<%@ page import="com.chinacreator.xtbg.core.meeting.service.*" %>
<%@ page import="com.chinacreator.xtbg.core.meeting.service.impl.*" %>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%
	try {
		//操作类型
		String action = request.getParameter("action");
		String json = StringUtil.deNull(request.getParameter("paramJson"));
        
        //会议类型管理服务类
        MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
		//删除
		if(Constant.ACTION_DELETE.equals(action)){
			//要删除的数据列表
			String ids = request.getParameter("ids");
			String flag = service.deleteListMeetingNoteTemplate(ids);
			out.print(flag);			
		}	
		//添加
		if(Constant.ACTION_ADD.equals(action)){			
			boolean flag = service.updateMeetingNoteTemplateBean(json);
			if(flag){
				out.print("{\"flag\":\"true\",\"msg\":\"操作成功!\"}");
			}else{
				out.print("{\"flag\":\"false\",\"msg\":\"操作失败!\"}");
			}
		}
	
		//更新
		if(Constant.ACTION_UPDATE.equals(action)){
			boolean flag = service.updateMeetingNoteTemplateBean(json);
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