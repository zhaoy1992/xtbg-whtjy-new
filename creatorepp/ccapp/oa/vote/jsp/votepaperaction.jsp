<%-- 
描述：添加问卷Action
作者：戴连春
版本：1.0
日期：2013-05-14
 --%>
<%@page
    import="com.chinacreator.xtbg.core.vote.service.VotePaperService"%>
<%@page
    import="com.chinacreator.xtbg.core.vote.service.impl.VotePaperServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.*"%>

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
    try {

        AccessControl accesscontroler = AccessControl
                .getAccessControl();
        accesscontroler.checkAccess(request, response);

        String subid = request.getParameter("subid");
        String action = request.getParameter("action");
        String paramJson = String.valueOf(request
                .getParameter("paramJson"));
        //业务处理类
        VotePaperService service = new VotePaperServiceImpl();
        boolean flag = true;
        if ("add".equals(action)) {//添加
            flag = service.insertOAVotePaper(paramJson);
            if (flag) {
                out.print(
                        "{\"flag\":\"true\",\"msg\":\"操作成功\"}");
            } else {
                out.print(
                        "{\"flag\":\"false\",\"msg\":\"操作失败\"}");
            }
        } else if ("deleteList".equals(action)) {//批量删除
            String ids = request.getParameter("ids");
            flag = service.deleteListPaper(ids);
            if (flag) {
                out.print(
                        "{\"flag\":\"true\",\"msg\":\"删除成功\"}");
            } else {
                out.print(
                        "{\"flag\":\"false\",\"msg\":\"删除失败\"}");
            }
        } else if ("update".equals(action)) {//更新
            flag = service.updateOAVotePaper(paramJson);
            if (flag) {
                out.print(
                        "{\"flag\":\"true\",\"msg\":\"操作成功\"}");
            } else {
                out.print(
                        "{\"flag\":\"false\",\"msg\":\"操作失败\"}");
            }
        } else if ("copy".equals(action)) {//复制操作
            //问卷id 
            String id = request.getParameter("id");
            //执行复制操作的用户id
            String userId = StringUtil.deNull(request.getParameter("userId"));
            String userName = StringUtil.deNull(request.getParameter("userName"));
            String orgId = StringUtil.deNull(request.getParameter("orgId"));
            String orgName = StringUtil.deNull(request.getParameter("orgName"));
            
            //保存以后返回的id
            String newId = service.copyPaper(id,userId,userName,orgId,orgName);
            if (!StringUtil.nullOrBlank(newId)) {
                //输出到前台的json串
                out.print( 
                        "{\"flag\":\"true\",\"msg\":\"复制成功\",\"id\":\""
                                + newId + "\"}");
            } else {
                out.print(
                        "{\"flag\":\"false\",\"msg\":\"复制失败\"}");
            }
        }

    } catch (Exception e) {
        out.print(
                "{\"flag\":\"false\",\"msg\":\"操作失败!\"}");
    }
%>