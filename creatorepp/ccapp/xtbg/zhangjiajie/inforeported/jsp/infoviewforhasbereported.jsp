<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String submittedinfoId = request.getParameter("submittedinfoId");
	InfoReportManagerDao infoReportdao = (InfoReportManagerDao) DaoImplClassUtil
			.getDaoImplClass("infoReportManagerDaoImpl");
	InfoReportBaseInfoBean infoReportBaseInfoBean = infoReportdao
			.findInfoReportBaseInfo(submittedinfoId);
	List<InfoReportAuditIdeaBean> auditlist = infoReportdao
			.findInfoReportAuditListByUser(submittedinfoId, "", "");
	String operwindowid = request.getParameter("operwindowid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean"%>
<%@page import="java.util.List"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息浏览上报展示(已上报)</title>
</head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<script src="../resources/js/persondetailinfo.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
$(function() {
	eWebEditor2.setMode('VIEW');
	$('#infotype_id').attr("disabled","disabled");
});

	function backTo(){
		removeWindows('<%=operwindowid%>',true);
		<%-- var okF = function(){
			removeWindows('<%=operwindowid%>',true);
			}
			 var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			
		alert('关闭该页,未保存的信息将会丢失 '+'<br>'+'确定关闭？',p); --%>
		
		}	
</script>
<body style=" overflow-y:hidden;" onload="adaptationWH('_top','vcenter',53)">

<div  class="content_02" style="overflow:hidden;">
<form action="" id="form1" name="form1" method="post">
<div  class="content_02" style="overflow:hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom:10px;"  >
   <input name="operation" value="返回" type="button" class="but_y_01" id="backto"
   onclick="backTo()" 
   onmouseover="this.className='but_y_01'"  
   onmouseout="this.className='but_h_01'"/>
	</div>
</div> 
<div id="vcenter" style="float:left; width:100%; overflow:scroll;overflow-x:hidden" scrolling="yes">
<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>基本信息</span></div>
	 <div class="content_02_box_div">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
		           <th width="191" class="content_02_box_div_table_th">标题:</th>
		           <td class="content_02_box_div_table_td" colspan="3">
				  <%=infoReportBaseInfoBean.getSubmittedinfo_title()%></td>
         	</tr>
				
		<tr>
           <th class="content_02_box_div_table_th">录入部门:</th>
           <td class="content_02_box_div_table_td">
          <%=infoReportBaseInfoBean.getOrg_name()%>
								<input type="hidden" name="orgid" id="orgid"
									value="<%=infoReportBaseInfoBean.getOrg_id()%>">
           </td>
           <th class="content_02_box_div_table_th">录入者:</th>
           <td class="content_02_box_div_table_td">
           <%=infoReportBaseInfoBean.getInputuser_name()%>
								<input type="hidden" name="inputuser_id" id="inputuser_id"
									value="<%=infoReportBaseInfoBean.getInputuser_id()%>">
            </td>
         </tr>
				
		<tr>
           <th class="content_02_box_div_table_th">信息类型:</th>
           <td class="content_02_box_div_table_td">
           <%=infoReportBaseInfoBean.getInfotype_name()%></td>
           <th class="content_02_box_div_table_th">关键字:</th>
           <td class="content_02_box_div_table_td">
          <%=infoReportBaseInfoBean.getKeyword()%> </td>
         </tr>
				
				
		</table>
		</div>
		</div>
		
		

     <div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>正文</span></div>
	 <div class="text_show_main_box">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
				 <tr>
					<td>
		<textarea id=edit_content name="edit_content" rows="1" cols="1" style="DISPLAY: none;"><%=infoReportBaseInfoBean.getSubmit_content()%></textarea>
	<iframe id="eWebEditor2" src="../../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=edit_content&style=gray" frameborder="0" scrolling="no" width="100%" height="350"></iframe> 
					
		
					</td>
				 </tr>
			</table>

	 </div>
	</div>
	 
	 <div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>评论</span>
	 <div class="content_02_box_add" id="t2">
	 </div>
	 </div>
	 <div  class="text_show_main_box">
	   <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
				 <td align="center">
	
					<table border="0" cellspacing="0" cellpadding="0"  class="text_show_box">
						
							 <%
							if ("plk" == "bkn") {
						%>
						<tr>
							<td align="center">
								<table style="background: none;" width="100%" border="0" cellspacing="0" cellpadding="0"  >
									<tr>
										<td align="center">
											<input type="text" name="textfield" class="input_text" />
										</td>
									</tr>
									<tr>
										<td align="center">&nbsp;</td>
									</tr>
								</table>

							</td>
						</tr>
						<%
							}
						%>
						<%
							if (null != auditlist) {
								for (InfoReportAuditIdeaBean auditBean : auditlist) {
						%>
							 <tr>
							<td>
								<span class="list_main_pl_neir"><%=auditBean.getAndit_opinion()%></span>
								&nbsp;&nbsp;&nbsp;
								<span class="list_main_name"><%=auditBean.getAndit_person()%></span>
								<span class="list_main_pl_time"><%=auditBean.getAndit_time()%></span>
							</td>
						</tr>
						<%
							}
							}
						%>
							
				          <% if(auditlist.size()<=0){%>		
						<td><span class="list_main_pl_neir">暂无批示内容</span></td>
						<%} %>
                    </table>

	
	   </td>
    </tr>
</table>

</div>
			
</div>
</div>
</div>
	</form>
	</div>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
	
</body>
</html>