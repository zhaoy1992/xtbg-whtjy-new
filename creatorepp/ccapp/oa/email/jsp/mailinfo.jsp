
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.email.entity.EmailBaseBean"%>
<%@page import="com.chinacreator.xtbg.core.email.service.impl.EmailServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.email.service.EmailService"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html; charset=utf-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request,response);
String userId = accesscontroler.getUserID();
String userName = accesscontroler.getUserName();
String orgId=accesscontroler.getChargeOrgId();
String orgName=accesscontroler.getChargeOrgName();
String path = request.getContextPath();
String mid = request.getParameter("mid");
String subid ="";
if(request.getParameter("windowId")!=null){
	subid=request.getParameter("windowId"); //首页
}else{
	subid=request.getParameter("subid");
}
String attachment_id = new Date().getTime()+"";
String isread=request.getParameter("isread");
String back=request.getParameter("back");
//附件加载
String listfirst = "";
EmailService ms=new EmailServiceImpl();
if(isread!=null&&!"".equals(isread)){
	ms.changeReadState(userId,mid);
}
EmailBaseBean mb = new EmailBaseBean () ;
//查询未查看的人员
HashMap<String,String> replevyUserMap = null;
if (mid !=null&&!"".equals(mid)) {
	mb=ms.findMailInfo(mid);
	//查询未查看的人员
	replevyUserMap = ms.findreplevyUserMail(mid);
}
 List<FileInfoBean> fileList = null;
if (!StringUtil.isBlank(mb.getAttachment_id())) {
	attachment_id=mb.getAttachment_id();
	FiletransfersSysDao filesysDao = new FiletransfersSysDaoImpl();
 	fileList = filesysDao.getFileInfoBeanlist(mb.getAttachment_id());
}
//String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE"); //区域编码
%>
<title></title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">jQuery.noConflict();</script>

<!-- 引入上传控件 -->
<link rel="stylesheet" href="../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- 引入其它 -->
<!-- 公共部分引用结束 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf_8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf_8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>


<script type="text/javascript">
jQuery(function(){
	//初始化附件
	 MyFancyupload.createUpload('file_list', '#file_attach', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=attachment_id%>', false, "<%=attachment_id%>");
		//加载人员  发送人员
	    var ps = new Object();
		ps.name=jQuery("#sendUserName").val();
		ps.id=jQuery("#sendUserId").val();
		createrDeptAndPosn(ps,"userTd",'sendUserId','sendUserName',false,false,false,true);
		
		//未查看人员列表
		var ps1 = new Object();
		ps1.name=jQuery("#receiverUserName").val();
		ps1.id=jQuery("#receiverUserId").val();
		createrDeptAndPosn(ps1,"userTd1",'receiverUserId','receiverUserName',false,false,false,true);

});

//页面收缩
function changerContetDiv(id,imgId){
	var none = jQuery("#"+id).css('display');
	if(none == "none"){
		jQuery("#"+id).show();
		jQuery("#" + imgId).attr("src","../resources/images/slideup_button.gif");

	} else{
		jQuery("#"+id).hide();
		jQuery("#" + imgId).attr("src","../resources/images/slidedown_button.gif");
	 }
} 




//接收人
function chooseReportUnits (){
	  var s = new jQuery.z_tree_leftRigth();
	  s.treeID='button_envelop_username';
	  s.isShowSeacher="aa";
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.titelText = "选择人员";
	  s.rightHeaderText="已添加机构和人员";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
		  	{
			   jQuery('#participants_id').val('');
			   jQuery('#participants_name').val('');
			 }else{
			 
				jQuery('#participants_id').val(orgObj.ps.id);
				jQuery('#participants_name').val(orgObj.ps.name);
			 }
	  }
	  s.treeList=
			  [{
				  leftHeaderText:'按人员选择',
				  valueKey:'ps',
				  selectedIds:jQuery('#participants_id').val(),
				  type:'APERSON'
		}];
	  s.init();

}


    var saveMail = function (obj){
		 //会议基本信息
		var title =	jQuery("#title").val(); //会议标题
		var participants_name =	jQuery("#participants_name").val(); //与会人员
		var participants_id =	jQuery("#participants_id").val(); //与会人员id
		var attachment_id="<%=attachment_id%>";
		var userId="<%=userId%>";
		var userName="<%=userName%>";
		var orgId="<%=orgId%>";
		var orgName="<%=orgName%>";
		var mid="<%=mid%>";
		//var dxtzsjr=jQuery("#dxtzsjr")
		//会议正文
		alert();
		var content = iframe_ewebeditor.getHTML(); //会议正文
		var paramjosn = "{'title':'" + title+ "','receivepname':'"+ participants_name
		  + "','receivepid':'" + participants_id  
		  + "','attachment_id':'" + attachment_id
		  + "','content':'" + content
		  + "','sendpid':'" + userId
		  + "','sendpname':'" + userName
		  + "','deptid':'" + orgId
		  + "','deptname':'" + orgName
		  + "','state':'" + obj
		  + "','mid':'" + mid
		  + "'}"; 
		  jQuery("#paramjosn").val(descape(escape(paramjosn)));
		  if('<%=StringUtil.deNull(mid)%>'!=""){
			  jQuery("#action").val("update");
		  }else{
			  jQuery("#action").val("save");
		  }
		  
		  
		  var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		  if (isFlag) {
			  var okF = function(){
				//附件上传提交
					 //uplodFiles('_fileshow',"<%=path%>/servlet/FileUpload?buessid="+attachment_id);
					 document.all.form1.target = "hiddenFrame";
					 jQuery('#form1').attr("action","mailSave.jsp");
					 jQuery('#form1').submit()
				}
				var p={
					headerText:'提示',okName:'确认', okFunction:okF,cancelName:'取消'
				};
				alert("是否确定提交？",p);
		  }else{
				return;
			}
		}
	function tosend(){
		openWindows('sub_main_view','转发邮件','<%=path%>/ccapp/oa/email/jsp/sendmail.jsp?mid=<%=StringUtil.deNull(mb.getMid())%>&iszf=yes&subid=sub_main_view','sub_main_view',false,window);

		<%-- if(parent.location.href.indexOf("index")>0){
			openWindows('sub_main_view','转发邮件','../../../yimingju/mail/jsp/sendMail.jsp?mid=<%=StringUtil.deNull(mb.getMid())%>&iszf=yes','sub_main_view',false,window);
			//window.location.href="<%=path%>/ccapp/xtbg/yimingju/mail/jsp/sendMail.jsp?mid=<%=StringUtil.deNull(mb.getMid())%>&iszf=yes"
		}else{
			window.parent.jQuery("#frame4").attr("src","sendMail.jsp?mid=<%=StringUtil.deNull(mb.getMid())%>&iszf=yes");
			window.parent.jQuery("#tabs").tabs({ selected: 3 });
		} --%>
	}

	/* 
	 * 返回 
	 */
	function saveBack(){
		removeWindows('<%=subid%>',true);
		<%-- if(parent.location.href.indexOf("index")>0){
			window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
			removeWindows('<%=subid%>',true);
		}else{
			if('<%=back%>'=="yj"){
				var url = "<%=path%>/ccapp/xtbg/yimingju/mail/jsp/yjSendMail.jsp";
			}else if('<%=back%>'=="re"){
				var url = "<%=path%>/ccapp/xtbg/yimingju/mail/jsp/receiveMail.jsp";
			}
			location.href = url;
		} --%>
	}
	/*
	函数:  replyMail
	说明:  回复收件箱邮件
	参数:   无
	返回值: 无
	*/
	var replyMail = function() {
		openWindows('sub_main_view','回复邮件','<%=path%>/ccapp/oa/email/jsp/sendmail.jsp?mid=<%=StringUtil.deNull(mb.getMid())%>&replyMail=yes&subid=sub_main_view','sub_main_view',false,window);

		<%-- if(parent.location.href.indexOf("index")>0){
			//window.location.href="<%=path%>/ccapp/xtbg/yimingju/mail/jsp/sendMail.jsp?mid=<%=StringUtil.deNull(mb.getMid())%>&replyMail=yes"
			openWindows('sub_main_view','回复邮件','../../../yimingju/mail/jsp/sendMail.jsp?mid=<%=StringUtil.deNull(mb.getMid())%>&replyMail=yes','sub_main_view',false,window);
		}else{
			window.parent.jQuery("#frame4").attr("src","sendMail.jsp?mid="+"<%=StringUtil.deNull(mb.getMid())%>"+"&replyMail=yes");
			window.parent.jQuery("#tabs").tabs({ selected: 3 });
		} --%>
	}
</script>
<script type="text/javascript">
var height ="<%=request.getParameter("height")%>";
window.onload = function () {
			 adaptationWH("content_02","vcenter",50);	
}
 </script> 
</head>
<body style="overflow-y: hidden;">
	<form id="form1" name="form1" method="post" >
	<input type="hidden" name="paramjosn" id="paramjosn"/>
	<input type="hidden" name="action" id="action" />
	<div class="content_02" style="overflow: hidden;">
			<!-- 操作-->
			<div class="content_02_top" style="margin-bottom: 1px;" id='content_02_top'>
				<%-- <%if("421000".equals(userArea) || "431003".equals(userArea) || "421005".equals(userArea)||"410003".equals(userArea)){ %> --%>
					<input value="回复" type="button" class="but_y_01" onclick="replyMail()"  /> 
				<%-- <%} %> --%>
				<!-- 首页进来  转发按钮屏蔽-->
				<%if(!"1111".equals(subid)&&!"sub_main_viewreadinfos".equals(subid)){ %>
					<input value="转发" type="button" class="but_y_01" onclick="tosend()" /> 
				<%} %>
				<input value="返回" type="button" class="but_y_01" onclick="saveBack()" /> 
			</div>
		</div>
<!-- 表格-->
	<!-- <div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes" >
 		<div class="content_02_box">
				<div class="content_02_box_div" id="info">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="content_02_box_div_table_02">
						<tr>
							<th width="212" valign="top"><font color="red">*</font>收件人：</th>
							<td width="580" id="">
							 <input type="text" id="participants_name" name="participants_name" value="<%=StringUtil.deNull(mb.getReceivepname())%>"  class="validate[required] input_140" onclick="chooseReportUnits()"/>
           					 <input type="hidden" id="participants_id" name="participants_id" value="<%=StringUtil.deNull(mb.getReceivepid())%>" />
							<input name="" type="button" value="" class="but_x" onclick="chooseReportUnits()"/></td>
						</tr>
						<tr>
							<td width="560" id="" colspan="2" style="padding-left:190px">
							<input type="checkbox" name="dxtzjsr" id="dxtzjsr" value="" <%if("1".equals(mb.getDxtzjsr())){%>checked="checked"<% }%>/>短信通知收件人</td>
						</tr>
						<tr>
							<th width="212" valign="top"><font color="red">*</font>主题：</th>
							<td width="560" id="">
								<input type="text" id="title" name="title" value="<%=StringUtil.deNull(mb.getTitle())%>"  class="validate[required] input_140"/>
							</td>
						</tr>
						<tr>
							<th width="212" valign="top">会议附件：</th>
							<td width="560" id="_filebut"></td>
						</tr>
						<tr>
							<th valign="top">附件列表：</th>
							<td id="_fileshow"></td>
						</tr>
						
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_02_box_div_table_02"
						>
						<tr>
							<th width="30" valign="top">主题：</th>
							<td width="560" id="" colspan="2" ><h2><%=StringUtil.deNull(mb.getTitle())%></h2></td>
						</tr>
						<tr>
							
							<td width="560" id="" colspan="2" >时间：<%=StringUtil.deNull(mb.getCreatetime())%></td>
						</tr>
						<tr>
							<td width="560" id="" colspan="2" >收件人：<%=StringUtil.deNull(mb.getReceivepname())%></td>
						</tr>
						<tr>
							<td width="560" id="" colspan="2" >附件：</td>
						</tr>
						<tr id="trattach" style="display:none">
								<td class="tableLable" >附件：</td>
								<td id="_filebut" ></td>
						</tr>
						<tr>
							<td  style="vertical-align:middle;" width="50">附件列表：</td>
							<td id="_fileshow"  style="color: black" width="523"></td>
						</tr>
					</table>
					<hr></hr>
					<font><%=StringUtil.deNull(mb.getContent())%></font>
		
			</div>
			
			</div> -->
			
			<!-- 表格-->
	<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes" >
 		<div class="content_02_box">
				<div class="content_02_box_title_bg">
				<div class="content_02_box_add show_content" >
				<img src="../resources/images/slideup_button.gif" id="imgIDSS2" onclick="changerContetDiv('info','imgIDSS2')"/>
				</div>
					<span>基本信息</span>
				</div>
				<div class="content_02_box_div" id="info">
				<%-- <%if(userArea.equals("421005")){ %>	<!-- 望城邮件列表功能 --> --%>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_02_box_div_table_02">
						<tr>
							<th width="212" valign="top">发件人：</th>
							<td width="580" id=""><%=StringUtil.deNull(mb.getSendpname())%>
							</td>
						</tr>
						<tr>
							<th width="212" valign="top">收件人：</th>
							<td width="580" id=""><%=StringUtil.deNull(mb.getReceivepname())%>
							</td>
						</tr>
						<tr>
							<th width="212" valign="top">时间：</th>
							<td width="560" id=""><%=StringUtil.deNull(mb.getCreatetime())%>
							</td>
						</tr>
						<tr>
							<th width="212" valign="top">主题：</th>
							<td width="560" id=""><%=StringUtil.deNull(mb.getTitle())%>
							</td>
						</tr>
						<!--  <tr style="display:none">
							<th width="212" valign="top">会议附件：</th>
							<td width="560" id="_filebut"></td>
						</tr>-->
						<tr>
							<th valign="top">附件列表：</th>
							<td >
							<ul id="file_list"></ul>&nbsp;
							</td>
						</tr>
					</table>
				<%-- <%} else { %>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="content_02_box_div_table_02">
						<tr>
							<th width="212" valign="top">主题：</th>
							<td width="560" id=""><%=StringUtil.deNull(mb.getTitle())%>
							</td>
						</tr>
						<tr>
							<th width="212" valign="top">时间：</th>
							<td width="560" id=""><%=StringUtil.deNull(mb.getCreatetime())%>
							</td>
							
						</tr>
						<tr>
							<th width="212" valign="top">收件人：</th>
							<td width="580" id=""><%=StringUtil.deNull(mb.getReceivepname())%>
							</td>
						</tr>
						<!--  <tr style="display:none">
							<th width="212" valign="top">会议附件：</th>
							<td width="560" id="_filebut"></td>
						</tr>-->
						<tr>
							<th valign="top">附件列表：</th>
							<td >
							<ul id="file_list"></ul>&nbsp;
							</td>
						</tr>
					</table>				
				<%} %> --%>
				</div>
			</div>	
			
			<div class="content_02_box">
				<div class="content_02_box_title_bg">
				<%-- <%if(CacheCommonManageProxy.getBooleanSystemParam("mailName")){%>
					<span> 文件正文</span>
				<%}else{ %> --%>
					<span> 邮件正文</span>
				<%-- <%} %> --%>
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 				&nbsp;&nbsp;&nbsp;&nbsp;
	 			</span>
				</div>
				<div class="content_02_box_div" id="info">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="content_02_box_div_table_02">
						<tr>
							<td width="580" id="">
							<div ><%=StringUtil.deNull(mb.getContent())%></div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		<%--  <%if("yj".equals(back)&&CacheCommonManageProxy.getBooleanSystemParam("mail.mailInfo.receive")){ //已发送列表 %>
		 <div class="content_02_box">
		 <div class="content_02_box_title_bg"><span>接收情况</span></div>
		 <div class="content_02_box_div">
		 	<input type="hidden" id="sendUserId"  name="sendUserId" value="<%=StringUtil.deNull(mb.getReceivepid())%>"/>
		    <input type="hidden" id="sendUserName" name="sendUserName"  value="<%=StringUtil.deNull(mb.getReceivepname()) %>" />
		    <input type="hidden" id="receiverUserId"  name="receiverUserId" value="<%=StringUtil.deNull(replevyUserMap.get("receivepid"))%>"/>
		    <input type="hidden" id="receiverUserName" name="receiverUserName"  value="<%=StringUtil.deNull(replevyUserMap.get("receivepname")) %>" />
		    
		   <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02">
	       	<!-- 与会部门id -->
			<tr>
				<th class="content_02_box_div_table_02_th">发送人员：</th>
				<td class="content_02_box_div_table_02_td" ><textarea id="userTd" class="textarea_575" rows="5" readonly></textarea>
	            </td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_02_th">未查看人员：</th>
				<td class="content_02_box_div_table_02_td" ><textarea id="userTd1" class="textarea_575" rows="5" readonly></textarea>
	            </td>
			</tr>
	       </table>
		 </div>
	  </div>
	  <%} %> --%>
			</div>
</form>			
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>