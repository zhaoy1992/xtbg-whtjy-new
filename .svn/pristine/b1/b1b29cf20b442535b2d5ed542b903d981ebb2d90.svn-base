<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VotePaperBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteQuestionBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteOptionBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteQuestionAnswerBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteEvalUserBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.VoteViewService"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.impl.VoteViewServiceImpl"%>
<%-- 
描述：人员测评页面
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
	String user_id = request.getParameter("user_id");
	String paperId = request.getParameter("paperId");//问卷ID
    String path = request.getContextPath();
	String windowId=request.getParameter("windowId");
	String status=request.getParameter("status");
	VotePaperBean votePaperBean = new VotePaperBean();
	VoteViewService voteViewService = new VoteViewServiceImpl();
	votePaperBean = voteViewService.getPaperInfo(paperId,user_id);
	Map<VoteEvalUserBean,List<VoteQuestionAnswerBean>> voteEvalUserList= voteViewService.getVoteUserList(paperId,user_id);
	
	List<VoteQuestionBean> voteQuestionBeanList = votePaperBean.getVoteQuestionBeanList();
%>	
<title><%=votePaperBean.getTitle()%></title>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/juan.css" />

<script language="javascript"
	src="../../resources/plug/lodop/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA"
	width=0 height=0> <embed id="LODOP_EM"
		type="application/x-print-lodop" width=0 height=0
		pluginspage="install_lodop.exe"></embed> </object>
<!-- 引入formvValidatetion[结束] -->
<script type="text/javascript">

//重置
function resets(){
	jQuery("select").val("");
}
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
<form id="voteForm" action="voteevaloperatedo.jsp" method="post">
<input type="hidden" name="paper_id" id="paper_id" value="<%=StringUtil.deNull(paperId )%>">
<input type="hidden" name="user_id" id="user_id" value="<%=StringUtil.deNull(user_id )%>">
<input type="hidden" name="windowId" id="windowId" value="<%=StringUtil.deNull(windowId )%>">
<input type="hidden" name="action" id="action" value="voteSave">
<div id="printpart">
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px;">
      <tr>
        <td>
    	 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="kaoping" style="background:#d6d5d5;">
        	 <tr>
                <td height="36" colspan="10" class="kao_ti" style="text-align:center; font-size:18px; font-family:'microsoft yahei'; color:#000; background:#fbfbfb;"><%=votePaperBean.getTitle() %></td>
             </tr>
			 <tr>
			 <td height="30" align="center"  style="background:#fff; padding:0px 5px;" align="center" height="30" align="center"><%=Constant.COLUMNNAME%></td>
	         <%for(VoteQuestionBean voteQuestionBean:voteQuestionBeanList){%>
				 <td align="center" style="background:#fff; padding:0px 5px;" align="center" height="30" align="center"><%= voteQuestionBean.getTitle() %> </td>
			 <%}%>
			</tr>
			<%for(VoteEvalUserBean voteEvalUserBean:voteEvalUserList.keySet()){
				List<VoteQuestionAnswerBean> voteQuestionAnswerList = voteEvalUserList.get(voteEvalUserBean);
				%>
			<tr>
				<td style="background:#fff; padding:0px 5px;" align="center" height="30" align="center"><%=voteEvalUserBean.getUser_name() %></td>
				<%for(VoteQuestionBean voteQuestionBean:voteQuestionBeanList){
					String select_id = "";
					if(voteQuestionAnswerList!=null && voteQuestionAnswerList.size()>0){
						for(VoteQuestionAnswerBean voteQuestionAnswerBean:voteQuestionAnswerList){
							if(voteQuestionAnswerBean.getQuestion_id().equals(voteQuestionBean.getId())){
								select_id = voteQuestionAnswerBean.getSelectid();
							}
						}
					}
				%>
				<td style="background:#fff; padding:0px 5px;" align="center">
					<select disabled="disabled" class="biao_kuang" style="width:90%; border:solid 1px #7f9db9; height:20px; line-height:20px; vertical-align:middle;" id="<%=voteEvalUserBean.getUser_id()%><%=voteQuestionBean.getId()%>" name="<%=voteEvalUserBean.getUser_id()%>#<%=voteQuestionBean.getId()%>">
					<option value="">请选择</option>
					<%for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){%>
						<option value="<%=voteOptionBean.getId() %>" <%if(select_id.equals(voteOptionBean.getId())){%>selected="selected" <%} %> ><%=voteOptionBean.getOption_code()%></option>
					<%} %>
					</select>
				</td>
				<%} %>
			</tr>
			<%} %>
			<tr>
                <td height="30" colspan="10" class="biao_zhuyi" style="background:#fbfbfb; color:#f30000;">&nbsp;&nbsp;备注：<%=votePaperBean.getDirection() %></td>
            </tr>
		</table>
	  </td>
	 </tr>
</table>
</div>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px;">
    <tr>
        <td height="60" align="center">
        <input type="button" class="biaoan1" value="返回" onclick="closed()"/>&nbsp;&nbsp;&nbsp;
        <input type="button" class="biaoan1" value="打印" onclick="prn1_preview()"/>&nbsp;&nbsp;&nbsp;
        </td>
     </tr>
</table>
</div>
</form>
<iframe name="hiddenFrame" height="0" width="0"></iframe>
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
</body> 
