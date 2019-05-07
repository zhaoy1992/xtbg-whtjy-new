<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.util.*"%>
<%@ page import="com.chinacreator.cms.util.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl control = AccessControl.getInstance();
    control.checkAccess(pageContext);
    DocumentManagerImpl doc = new DocumentManagerImpl();
    //频道模板修改前,是否有文档存在
    boolean hasOldDocument = true;
    String tmpleteId = request.getParameter("tmpleteId");
    String chnlId = request.getParameter("chnlId");
    tmpleteId = tmpleteId==null?"":tmpleteId;
    chnlId = chnlId==null?"":chnlId;
    if("".equals(chnlId) && "".equals(tmpleteId)){        
    }else{
        hasOldDocument = doc.channelHasDoc(chnlId);
        if(hasOldDocument) doc.updatePreviousDocInChannel(chnlId,tmpleteId);
    }
%>
<script language="javascript">
    
    <%
    if(hasOldDocument){
        out.println("alert(\"更新完毕!\");");
        
    }
    %>
    //window.close();
</script>