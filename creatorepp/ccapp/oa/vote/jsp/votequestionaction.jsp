<%-- 
描述：添加问题Action
作者：戴连春
版本：1.0
日期：2013-05-16
 --%>
<%@page import="com.chinacreator.xtbg.core.vote.service.VotePaperService"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.impl.VotePaperServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.*"%>

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	try {

	AccessControl accesscontroler = AccessControl
				.getAccessControl();
		accesscontroler.checkAccess(request, response);
		
		String action = request.getParameter("action");
        String paramJson = String.valueOf(request.getParameter("paramJson"));
		//业务处理类
        VotePaperService service = new VotePaperServiceImpl();
        boolean flag = true;
        if("add".equals(action)){//添加
        	flag = service.insertQuestion(paramJson);
        	if(flag){
                out.print("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
            }else{
                out.print("{\"flag\":\"false\",\"msg\":\"操作失败\"}");  
            }
        }else if ("deleteList".equals(action)) {//批量删除
			String ids = request.getParameter("ids");
            flag =  service.deleteListQuestion(ids);
            if(flag){
                out.print("{\"flag\":\"true\",\"msg\":\"删除成功\"}");
            }else{
                out.print("{\"flag\":\"false\",\"msg\":\"删除失败\"}");  
            }
		}else if("update".equals(action)){//更新
			flag = service.updateQuestion(paramJson);
			if(flag){
                out.print("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
            }else{
                out.print("{\"flag\":\"false\",\"msg\":\"操作失败\"}");  
            }
		}
       
	} catch (Exception e) {
		out.print("{\"flag\":\"false\",\"msg\":\"操作失败!\"}");		
	} 
%>