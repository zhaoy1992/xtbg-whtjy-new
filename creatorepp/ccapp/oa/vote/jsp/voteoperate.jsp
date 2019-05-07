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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
	String user_id = accesscontroler.getUserID();
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
<!-- 引入formvValidatetion -->
<script
    src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine-cn.js"
    type="text/javascript" charset="utf-8"></script>
<script
    src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine.js"
    type="text/javascript" charset="utf-8"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/juan.css" />
<script type="text/javascript">
var questionArray = new Array();   
//将JAVA中的数组转换成JS 的数组
<%if(voteQuestionBeanList!=null){
  for(int i=0;i<voteQuestionBeanList.size();i++){
%>
	questionArray[<%=i%>]='<%=voteQuestionBeanList.get(i).getId()%>'+'#'+'<%=voteQuestionBeanList.get(i).getType_id()%>'+'#'+'<%=voteQuestionBeanList.get(i).getAnswer()%>';
<% } 
 }%>


//提交
function submits(){
	var isFlag = jQuery('#voteForm').validationEngine('validate'); //是否全部验证通过
	if(!isFlag){
		return;
	}
	//验证必填项
	var paramjosn = "";
	var name;//题目ID
	var type;//题目类型
	var isreq;//是否必填
	var value="";
	var bixuan= false;
	for(var i=0; i<questionArray.length; i++){
		name = questionArray[i].split("#")[0];
		type = questionArray[i].split("#")[1];
		isreq = questionArray[i].split("#")[2];
		if(isreq == "1"){
			$("#title_"+name).css("background-color","#f4f4f4");
			if(type=='<%= Constant.DANXUANTI%>'){//如果是单选
				value = $('input:radio[name='+name+']:checked').val();
			}else if(type=='<%= Constant.DUOXUANTI%>'){//如果是多选
				$('input[name='+name+'][type=checkbox]:checked').each(function(){  
					value = value+ $(this).val();
				}) ; 
			}else{//如果是填空题，或者其他
				value = $('textarea[name='+name+']').val();
			}
			if(IsSpace(value)){//将title的颜色改变.
				bixuan = true;
				$("#title_"+name).css("background-color","#ffffc2");
			}
			value = "";
		}
	}
	if(bixuan){
		alert("对不起，请选择必选题后再提交试卷！");
		return;
	}
	
    var okF = function(){
    	$("#action").val("voteSubmit");//保存并更新填写状态
    	document.all.voteForm.target = "hiddenFrame";
    	$("#voteForm").submit();
        }
    var p1={
        headerText:'提示',
        okName:'确认',
        okFunction:okF,
        cancelName:'取消'
    };
    alert('点击完成后，所填写的内容将无法修改！'+'<br>'+'确定完成？',p1);

}

//暂存
function save(){
	
   	$("#action").val("voteSave");//暂存
    document.all.voteForm.target = "hiddenFrame";
   	$("#voteForm").submit();
}

//重置
function resets(){
	jQuery("input[type=radio]").removeAttr("checked");
	jQuery("input[type=checkbox]").removeAttr("checked");
	jQuery("textarea").val("");
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
<form id="voteForm" name="voteForm" action="voteoperatedo.jsp" method="post">
<input type="hidden" name="paper_id" id="paper_id" value="<%=StringUtil.deNull(paperId )%>">
<input type="hidden" name="user_id" id="user_id" value="<%=StringUtil.deNull(user_id )%>">
<input type="hidden" name="windowId" id="windowId" value="<%=StringUtil.deNull(windowId )%>">
<input type="hidden" name="status" id="status" value="<%=StringUtil.deNull(status )%>">
<input type="hidden" name="action" id="action" value="voteSave">

<table width="60%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px; margin-bottom:20px;">
      <tr>
        <td height="32" class="juan_top"><%=votePaperBean.getTitle()%></td>
      </tr>
      <tr>
        <td height="40" class="juan_biao">发起部门：<%= votePaperBean.getOrg_name()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发起人：<%=votePaperBean.getUser_name()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;被考核人员：<%=votePaperBean.getDirection()%></td>
      </tr>
      <tr>
        <td class="juan_kuang">
        <%int i=1;
		  for(VoteQuestionBean voteQuestionBean:voteQuestionBeanList){%>
			<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;">
			 <tr>
			 <td height="30" id="title_<%=voteQuestionBean.getId()%>" class="tou_biao"><%= i++%>：<%= voteQuestionBean.getTitle() %> <span style="color: red;"><%= "1".equals(voteQuestionBean.getAnswer())?"(必选题)":"" %></span></td>
			 </tr>
			 <%if(Constant.DANXUANTI.equals(voteQuestionBean.getType_id())){//如果是单选%>
				 <%for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ %>
				 <tr>
				 <td height="31" class="tou_xuan">
				 <input type="radio" <% if(voteQuestionBean.getAnswerList()!=null){if(StringUtil.isHave(voteQuestionBean.getAnswerList(),voteOptionBean.getId())){%> checked="checked" <%}}%> name="<%=voteQuestionBean.getId()%>" value = "<%= voteOptionBean.getId()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%><br>
				 </td>
				 </tr>
				 <%}%>
			 <% }else if(Constant.DUOXUANTI.equals(voteQuestionBean.getType_id())){//如果是多选%>
				 <%for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ %>
				 <tr>
				 <td height="31" class="tou_xuan">
				 <input type="checkbox"  <% if(voteQuestionBean.getAnswerList()!=null){if(StringUtil.isHave(voteQuestionBean.getAnswerList(),voteOptionBean.getId())){%> checked="checked" <%}}%> name="<%=voteQuestionBean.getId()%>" value = "<%= voteOptionBean.getId()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%><br>
				 </td>
				 </tr>
				 <%}%>
			 <% }else{%>
				 <tr>
				 <td height="31" class="tou_xuan">
				 	<textarea id="WENDAN"  class="tou_wen validate[required,maxSize[<%=voteQuestionBean.getQuestion_number() %>]]"  name="<%=voteQuestionBean.getId()%>"><% if(voteQuestionBean.getAnswerList()!=null){ out.print(voteQuestionBean.getAnswerList().get(0)); }%></textarea>
				 </td>
				 </tr>
			 <% } %>
			 </table>
		<%} %>
	  </td>
	 </tr>
     <tr>
        <td height="60" align="center">
        <input type="button" class="biaoan1" <%if("1".equals(status)){%> style="display: none"<%} %> value="完成" onclick="submits()"/>&nbsp;&nbsp;&nbsp;
        <input type="button" class="biaoan1" value="返回" onclick="closed()"/>&nbsp;&nbsp;&nbsp;
        <input type="button" class="biaoan1" style="display:none" value="暂存" onclick="save()" />
        <input type="button" class="biaoan1" <%if("1".equals(status)){%> style="display: none"<%} %> value="重置" onclick="resets()" /></td>
     </tr>
</table>
</form>
<iframe name="hiddenFrame" height="0" width="0"></iframe>
</body> 
</html>