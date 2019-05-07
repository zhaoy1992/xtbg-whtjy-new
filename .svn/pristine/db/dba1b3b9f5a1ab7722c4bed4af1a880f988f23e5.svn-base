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
	String user_id = accesscontroler.getUserID();
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
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/juan.css" />
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script
    src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<script
    src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine-cn.js"
    type="text/javascript" charset="utf-8"></script>
<script
    src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine.js"
    type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/util/public.js"
    type="text/javascript"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
<script
    src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>    
<script type="text/javascript">
jQuery(document).ready(function() {
    jQuery("#voteForm").validationEngine();
});

var checkMaxArray = new Array();   
var n = 0;
//将JAVA中的数组转换成JS 的数组
<%if(voteQuestionBeanList!=null){
  for(int i=0;i<voteQuestionBeanList.size();i++){
	  VoteQuestionBean voteQuestionBean = voteQuestionBeanList.get(i);
	  for(int j=0; j<voteQuestionBean.getVoteOptionBeanList().size(); j++){
		  VoteOptionBean voteOptionBean = voteQuestionBean.getVoteOptionBeanList().get(j);
		  if(!StringUtil.isBlank(voteOptionBean.getCheck_max())){
%>	
			checkMaxArray[n]='<%=voteOptionBean.getOption_code()%>'+'#'+'<%=voteOptionBean.getId()%>'+'#'+'<%=voteOptionBean.getCheck_max()%>'+'#'+'<%=voteQuestionBeanList.get(i).getTitle()%>';
			n++;
<%	 }}  
 }
 }%>

//提交
function submits(){
	if(!jQuery('#voteForm').validationEngine('validate') ){
        return ;
      }
      
	//验证最多输入个数
	var optid;//选项ID
	var check_max;//最多输入数
	var title;//题目名称
	var code;
	for(var i=0; i<checkMaxArray.length; i++){
		code = checkMaxArray[i].split("#")[0];
		optid = checkMaxArray[i].split("#")[1];
		check_max = checkMaxArray[i].split("#")[2];
		title = checkMaxArray[i].split("#")[3];
		var count =0;
		//alert(optid+"选定了"+jQuery("option[value="+optid+"]").find("[selected=selected]").size()+"")
		jQuery("option[value="+optid+"]").each(function (){
			if(jQuery(this).attr("selected")){
				count++;
			}
		});
		if(check_max < count){
			alert("问题  【"+title+"】  的选项【"+code+"】，已经选中"+count+"次，超过了最大限制次数的"+check_max+"次，请重新选择！");
			return;
		}
		//alert(jQuery("input[type=radio]").val());
	}
    var okF = function(){
    	jQuery("#action").val("voteSubmit");//保存并更新填写状态
    	document.all.voteForm.target = "hiddenFrame";
    	jQuery("#voteForm").submit();
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
	jQuery("select").removeClass('validate[required]');//如果是暂存，移除必填验证
	jQuery("#action").val("voteSave");//暂存
    document.all.voteForm.target = "hiddenFrame";
    jQuery("#voteForm").submit();
}
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

<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px;">
      <tr>
        <td>
    	 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="kaoping">
        	 <tr>
                <td height="36" colspan="10" class="kao_ti"><%=votePaperBean.getTitle() %></td>
             </tr>
			 <tr>
			 <td height="30" align="center" class="ce_shou"><%=Constant.COLUMNNAME%></td>
	         <%for(VoteQuestionBean voteQuestionBean:voteQuestionBeanList){%>
				 <td align="center" class="ce_shou"><%= voteQuestionBean.getTitle() %> </td>
			 <%}%>
			</tr>
			<%for(VoteEvalUserBean voteEvalUserBean:voteEvalUserList.keySet()){
				List<VoteQuestionAnswerBean> voteQuestionAnswerList = voteEvalUserList.get(voteEvalUserBean);
				%>
			<tr>
				<td height="30" align="center"><%=voteEvalUserBean.getUser_name() %></td>
				<%for(VoteQuestionBean voteQuestionBean:voteQuestionBeanList){
					String select_id = "";
					String isreq = voteQuestionBean.getAnswer();
					String classstr ="";
					if("1".equals(isreq)){//如果是必填
						classstr = "biao_kuang validate[required]";
					}else{
						classstr = "biao_kuang";
					}
					if(voteQuestionAnswerList!=null && voteQuestionAnswerList.size()>0){
						for(VoteQuestionAnswerBean voteQuestionAnswerBean:voteQuestionAnswerList){
							if(voteQuestionAnswerBean.getQuestion_id().equals(voteQuestionBean.getId())){
								select_id = voteQuestionAnswerBean.getSelectid();
							}
						}
					}
				%>
				<td align="center">
					<%if("1".equals(isreq)){%><span class="color_red">*</span><%} %>
					<select class="<%=classstr %>" id="<%=voteEvalUserBean.getUser_id()%><%=voteQuestionBean.getId()%>" name="<%=voteEvalUserBean.getUser_id()%>#<%=voteQuestionBean.getId()%>">
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
                <td height="30" colspan="10" class="biao_zhuyi">&nbsp;&nbsp;备注：<%=votePaperBean.getDirection() %></td>
            </tr>
		</table>
	  </td>
	 </tr>
     <tr>
        <td height="60" align="center">
        <input type="button" class="biaoan1" <%if("1".equals(status)){%> style="display:none"<%} %> value="完成" onclick="submits()"/>&nbsp;&nbsp;&nbsp;
        <input type="button" class="biaoan1" value="返回" onclick="closed()"/>&nbsp;&nbsp;&nbsp;
        <input type="button" class="biaoan1" <%if("1".equals(status)){%> style="display:none"<%} %> value="暂存" onclick="save()" />&nbsp;&nbsp;&nbsp;
        <input type="button" class="biaoan1" <%if("1".equals(status)){%> style="display:none"<%} %> value="重置" onclick="resets()" /></td>
     </tr>
</table>
</form>
<iframe name="hiddenFrame" height="0" width="0"></iframe>
</body> 
