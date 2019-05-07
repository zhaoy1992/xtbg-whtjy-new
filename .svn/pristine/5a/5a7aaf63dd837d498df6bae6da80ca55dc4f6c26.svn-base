<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<html>
 <head>
  <tab:tabConfig />
  <title></title>
 </head>
 <%@ include file="/epp/css/cssControl.jsp"%><body bgcolor="#F7F8FC">
  <table width="100%" border="0" cellpadding="0" cellspacing="0"
   align="center">
   <tr>
    <td colspan="2">
     <tab:tabContainer id="user-manage-update"
      selectedTabPaneId="org-manage">
      <tab:tabPane id="worklist" tabTitle="待办列表" lazeload="true">
       <tab:iframe id="tb_ifr_worklist" src="work_list.jsp"
        frameborder="0" scrolling="no" width="100%" height="600">
       </tab:iframe>
      </tab:tabPane>
      <tab:tabPane id="tobe_work" tabTitle="草稿列表" lazeload="true">
       <tab:iframe id="tab_tobe_work" src="tobe_work_list.jsp"
        frameborder="0" scrolling="no" width="100%" height="600">
       </tab:iframe>      
      </tab:tabPane>
      <tab:tabPane id="suspend_work" tabTitle="挂起列表" lazeload="true">
       <tab:iframe id="tab_suspend_work" src="suspend_work_list.jsp"
        frameborder="0" scrolling="no" width="100%" height="600">
       </tab:iframe>      
      </tab:tabPane>
      <tab:tabPane id="done_work" tabTitle="办结列表" lazeload="true">
       <tab:iframe id="tab_done_work" src="done_work_list.jsp"
        frameborder="0" scrolling="no" width="100%" height="600">
       </tab:iframe>
      </tab:tabPane>
      <tab:tabPane id="overtime_work" tabTitle="过期列表" lazeload="true">
       <tab:iframe id="tab_overtime_work" src="overtime_work_list.jsp"
        frameborder="0" scrolling="no" width="100%" height="600">
       </tab:iframe>
      </tab:tabPane>
      <tab:tabPane id="wftransactin_log" tabTitle="流程操作日志" lazeload="true">
       <tab:iframe id="tab_wftransactin_log" src="monitor_wftransaction_log_list.jsp"
        frameborder="0" scrolling="no" width="100%" height="600">
       </tab:iframe>
      </tab:tabPane>
     </tab:tabContainer>
    </td>
   </tr>
  </table>
 </body>
</html>
