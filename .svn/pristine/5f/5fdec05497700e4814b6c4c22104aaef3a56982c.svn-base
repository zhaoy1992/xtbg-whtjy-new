<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="java.util.List"%>
<%@page import=" com.chinacreator.xtbg.core.vote.entity.VotePaperBean"%>
<%@page import=" com.chinacreator.xtbg.core.vote.entity.VoteQuestionBean"%>
<%@page import=" com.chinacreator.xtbg.core.vote.entity.VoteOptionBean"%>
<%@page import=" com.chinacreator.xtbg.core.vote.service.VoteViewService"%>
<%@page import=" com.chinacreator.xtbg.core.vote.service.impl.VoteViewServiceImpl"%>
<%-- 
描述：在线投票预览页面
作者：shuqi.liu
版本：1.0
日期：2013-05-13
 --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String paperId = request.getParameter("paperId");//问卷ID
	String uesr_id = accesscontroler.getUserID();
	String windowId=request.getParameter("windowId");
	VotePaperBean votePaperBean = new VotePaperBean();
	VoteViewService voteViewService = new VoteViewServiceImpl();
	votePaperBean = voteViewService.getPaperInfo(paperId,uesr_id);
	List<VoteQuestionBean> voteQuestionBeanList = votePaperBean.getVoteQuestionBeanList();
%>	
<title><%=votePaperBean.getTitle()%></title>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/juan.css" />
<!-- 引入jQuery -->
<script type="text/javascript"
    src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script
    src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script
    src="<%=path %>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>
<!-- 引入jGrid -->
<script
    src="<%=path %>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
    type="text/javascript"></script>
<script
    src="<%=path %>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
    type="text/javascript"></script>
<!-- 引入其它 -->
<script src="<%=path %>/ccapp/oa/resources/util/public.js"
    type="text/javascript"></script>
<script type="text/javascript"
    src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
    src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 打印需要导入的内容、方法 -->
<script language="javascript"
    src="../../resources/plug/Lodop/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA"
    width=0 height=0> <!-- 是专为 FireFox 浏览器设计的代码  --> <embed
        id="LODOP_EM" type="application/x-print-lodop" width=0 height=0
        ></embed>
</object>
<!-- 引入formvValidatetion[结束] -->    
<script type="text/javascript">
//返回
function closed(){
   removeWindows('<%=windowId%>',true);
}  
</script>

<body style="overflow: auto;" class="vcenter">
<div id="printpart">
<table width="60%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px; margin-bottom:20px;">
      <tr>
        <td height="32" class="juan_top" style="background:#f7f7f7; border:solid 1px #c6c6c6; text-align:center; font-size:18px; font-family:"microsoft yahei"; color:#000;"><%=votePaperBean.getTitle()%></td>
      </tr>
      <tr>
        <td height="40" class="juan_biao" style="font-size:14px; color:#666666;">发起部门：<%= votePaperBean.getOrg_name()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发起人：<%=votePaperBean.getUser_name()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;被考核人员：<%=votePaperBean.getDirection()%></td>
      </tr>
      <tr>
        <td class="juan_kuang" style="border:solid 1px #c6c6c6;">
        <%int i=1;
		  for(VoteQuestionBean voteQuestionBean:voteQuestionBeanList){%>
			<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;">
			 <tr>
			 <td height="30" class="tou_biao" style="background:#f4f4f4; font-weight:bold; font-size:14px; color:#000; padding-left:20px;"><%= i++%>：<%= voteQuestionBean.getTitle() %> </td>
			 </tr>
			 <%if(Constant.DANXUANTI.equals(voteQuestionBean.getType_id())){//如果是单选%>
				 <%for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ %>
				 <tr>
				 <td height="31" class="tou_xuan" style="font-size:14px; padding-left:40px;">
				 <input type="radio" name="<%=voteQuestionBean.getId()%>" value = "<%= voteOptionBean.getId()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%><br>
				 </td>
				 </tr>
				 <%}%>
			 <% }else if(Constant.DUOXUANTI.equals(voteQuestionBean.getType_id())){//如果是多选%>
				 <%for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ %>
				 <tr>
				 <td height="31" class="tou_xuan" style="font-size:14px; padding-left:40px;">
				 <input type="checkbox" name="<%=voteQuestionBean.getId()%>" value = "<%= voteOptionBean.getId()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%><br>
				 </td>
				 </tr>
				 <%}%>
			 <% }else{%>
				 <tr>
				 <td height="31" class="tou_xuan" style="font-size:14px; padding-left:40px;">
				 	<textarea class="tou_wen" style="width:80%; height:120px; border:solid 1px #7f9db9; float:left; vertical-align:middle; background:#f7f7f7; line-height:24px;"  name="<%=voteQuestionBean.getId()%>"></textarea>
				 </td>
				 </tr>
			 <% } %>
				 
			 </table>
		<%} %>
	  </td>
	 </tr>
</table>
</div>
<table width="60%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px; margin-bottom:20px;">
     <tr>
        <td height="60" align="center">
           <tr>
        <td height="60" align="center">
        <input type="button" class="biaoan1" value="返回" onclick="closed()"/>&nbsp;&nbsp;&nbsp;
        <input type="button" class="biaoan1" value="打印" onclick="prn1_preview()"/>&nbsp;&nbsp;&nbsp;
       </td>
     </tr>
</table>
</body> 
<script language="javascript" type="text/javascript">
     var LODOP; //声明为全局变量 
	
	function prn1_preview() {
    	// alert("123");
		//jQuery("#_fileshow_print").html(jQuery("#_fileshow").html().replaceAll('删除',''))
		debugger;
		jQuery("#print_table").show();		
		CreateOneFormPage();	
		LODOP.PREVIEW();	
		jQuery("#print_table").hide();
	};

	function CreateOneFormPage(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");
		//LODOP.SET_PRINT_STYLE("FontSize",12);
		//LODOP.SET_PRINT_STYLE("FontName","宋体");

		LODOP.SET_PRINT_STYLE("Bold",1);
		LODOP.ADD_PRINT_TEXT(50,231,260,39,"");
		LODOP.ADD_PRINT_HTM(80,0,800,980,document.getElementById("printpart").innerHTML);
	};	                   
	
</script>
</html>