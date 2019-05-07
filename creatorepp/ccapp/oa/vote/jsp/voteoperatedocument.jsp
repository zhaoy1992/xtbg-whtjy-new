<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VotePaperBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteQuestionBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteOptionBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.VoteViewService"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.impl.VoteViewServiceImpl"%>
<%-- 
描述：在线投票页面
作者：shuqi.liu
版本：1.0
日期：2013-05-13
 --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
	String user_id = request.getParameter("user_id");
	String oper_type = request.getParameter("oper_type");
	String windowId=request.getParameter("windowId");
	String status=request.getParameter("status");
	String paperId = request.getParameter("paperId");//问卷ID
	//paperId= "DC2CCF24812769CDE0430100007F1329";
	VotePaperBean votePaperBean = new VotePaperBean();
	VoteViewService voteViewService = new VoteViewServiceImpl();
	votePaperBean = voteViewService.getPaperInfo(paperId,user_id);
	List<VoteQuestionBean> voteQuestionBeanList = votePaperBean.getVoteQuestionBeanList();
%>	
<title><%=votePaperBean.getTitle()%></title>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/juan.css" />

<!-- 打印需要导入的内容、方法 -->
<script language="javascript" src="../../resources/plug/Lodop/LodopFuncs.js"></script> 
<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
<!-- 是专为 FireFox 浏览器设计的代码  -->
<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path %>/oa/resources/plug/Lodop/install_lodop.exe"></embed>
</object>
<!-- 引入formvValidatetion[结束] -->
<script type="text/javascript">

//返回
function closed(){
//  location.href ="announcementlist.jsp";
    var state = '<%=status%>';
    //新增的数据，提示是否保存
    if(state == "0"){
        var okF = function(){
            removeWindows('<%=windowId%>',true);
            }
        var p={
            headerText:'提示',
            okName:'确认',
            okFunction:okF,
            cancelName:'取消'
        };
        alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
      
    }else{//如果是已发布的，则直接返回上一个界面
          removeWindows('<%=windowId%>',true);
    }
}  

//判断是否为空
function IsSpace(strMain) {
	var strComp = strMain;
	try {
		if (strComp == "  " || strComp == "" || strComp == " "
				|| strComp == null || strComp == "null" || strComp.length == 0
				|| typeof strMain == "undefined" || strMain == "undefined") {
			return true;
		} else {
			return false;
		}
	} catch (e) {
		return false;
	}
}
</script>

<body>
<form id="voteForm" name="voteForm" action="voteoperatedo.jsp" method="post">
<input type="hidden" name="paper_id" id="paper_id" value="<%=StringUtil.deNull(paperId )%>">
<input type="hidden" name="user_id" id="user_id" value="<%=StringUtil.deNull(user_id )%>">
<input type="hidden" name="windowId" id="windowId" value="<%=StringUtil.deNull(windowId )%>">
<input type="hidden" name="status" id="status" value="<%=StringUtil.deNull(status )%>">
<input type="hidden" name="action" id="action" value="voteSave">
<div id="printpart">
<table width="60%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px; margin-bottom:20px;">
      <tr>
        <td height="32" style="background:#f7f7f7; border:solid 1px #c6c6c6; text-align:center; font-size:18px; font-family:'microsoft yahei'; color:#000;"><%=votePaperBean.getTitle()%></td>
      </tr>
      <tr>
        <td height="40" class="juan_biao" style="font-size:14px; color:#666666;">发起部门：<%= votePaperBean.getOrg_name()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发起人：<%=votePaperBean.getUser_name()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;被考核对象：<%=votePaperBean.getDirection()%></td>
      </tr>
      <tr>
        <td class="juan_kuang" style="border:solid 1px #c6c6c6;">
        <%int i=1;
		  for(VoteQuestionBean voteQuestionBean:voteQuestionBeanList){%>
			<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;">
			 <tr>
			 <td height="30" id="title_<%=voteQuestionBean.getId()%>" class="tou_biao" style="background:#f4f4f4; font-weight:bold; font-size:14px; color:#000; padding-left:20px;"><%= i++%>：<%= voteQuestionBean.getTitle() %> <span style="color: red;"><%= "1".equals(voteQuestionBean.getAnswer())?"(必选题)":"" %></span></td>
			 </tr>
			 <%if(Constant.DANXUANTI.equals(voteQuestionBean.getType_id())){//如果是单选%>
				 <%for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ %>
				 <tr>
				 <td height="31" class="tou_xuan" style="font-size:14px; padding-left:40px;">
				 <input type="radio" disabled="disabled" <% if(voteQuestionBean.getAnswerList()!=null){if(StringUtil.isHave(voteQuestionBean.getAnswerList(),voteOptionBean.getId())){%> checked="checked" <%}}%> name="<%=voteQuestionBean.getId()%>" value = "<%= voteOptionBean.getId()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%><br>
				 </td>
				 </tr>
				 <%}%>
			 <% }else if(Constant.DUOXUANTI.equals(voteQuestionBean.getType_id())){//如果是多选%>
				 <%for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ %>
				 <tr>
				 <td height="31" style="font-size:14px; padding-left:40px;">
				 <input type="checkbox" disabled="disabled" style="background-color: " <% if(voteQuestionBean.getAnswerList()!=null){if(StringUtil.isHave(voteQuestionBean.getAnswerList(),voteOptionBean.getId())){%> checked="checked" <%}}%> name="<%=voteQuestionBean.getId()%>" value = "<%= voteOptionBean.getId()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%><br>
				 </td>
				 </tr>
				 <%}%>
			 <% }else{%>
				 <tr>
				 <td height="31" style="font-size:14px; padding-left:40px;">
				 	<textarea class="tou_wen" disabled="disabled"  style="width:80%; height:120px; border:solid 1px #7f9db9; float:left; vertical-align:middle; background:#f7f7f7; line-height:24px;"  name="<%=voteQuestionBean.getId()%>"><% if(voteQuestionBean.getAnswerList()!=null){ out.print(voteQuestionBean.getAnswerList().get(0)); }%></textarea>
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
        <input type="button" class="biaoan1" value="返回" onclick="closed()"/>&nbsp;&nbsp;&nbsp;
        <input type="button" class="biaoan1" value="打印" onclick="prn1_preview()"/>&nbsp;&nbsp;&nbsp;
        </td>
     </tr>
</table>
</form>
<iframe name="hiddenFrame" height="0" width="0"></iframe>
<script language="javascript" type="text/javascript">
     var LODOP; //声明为全局变量 
	
	function prn1_preview() {
    	// alert("123");
		//jQuery("#_fileshow_print").html(jQuery("#_fileshow").html().replaceAll('删除',''))
		
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
</body> 
</html>