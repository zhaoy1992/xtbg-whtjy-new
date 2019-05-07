<%@page import="com.chinacreator.xtbg.yimingju.mail.dao.impl.MailDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.dao.impl.MailConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.constant.EmailConstants"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.service.impl.MailServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.service.MailServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.entity.MailBean"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html; charset=GBK"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.pub.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FileCopy"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FileCopyToDocumentFile"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request,response);
String userId = accesscontroler.getUserID();
String userName = accesscontroler.getUserName();
String user_Name = accesscontroler.getUserAccount();
String orgId=accesscontroler.getChargeOrgId();
String orgName=accesscontroler.getChargeOrgName();
String path = request.getContextPath();
String mid = request.getParameter("mid");
String attachment_id = new Date().getTime()+"";
String iszf=request.getParameter("iszf");//是否是转发--发件箱、已发送页面详细信息的转发为yes.草稿箱进入发件箱不算转发
String replyMail = request.getParameter("replyMail");//是否回复
String title = request.getParameter("title");//获取从外面传过来的title
title = DataControlUtil.pageUnEscape(title);


String recordid = request.getParameter("recordid");
String filename = DataControlUtil.pageUnEscape(request.getParameter("filename"));
String windowId = StringUtil.deNull(request.getParameter("windowId"));

/***************可以从外部传入要发送的人员信息************************/
String beSendUserIds = request.getParameter("beSendUserIds");
String beSendUserNames = DataControlUtil.pageUnEscape(request.getParameter("beSendUserNames"));



FileCopy fileCopy = new FileCopyToDocumentFile();
/*收文发文归档发送邮件，并把正文转化成附件*/
if(null != fileCopy){
	Map<String,String> params = new HashMap<String,String>();
	String  mFilePath = request.getSession().getServletContext().getRealPath("") ;  //取得服务器路径
	params.put("djbh",attachment_id);
	params.put("recordid",recordid);
	params.put("filename",filename);
	params.put("mFilePath",mFilePath);
	fileCopy.copyOtherToFileBean(params);
}


//修改1375bug问题
String backPage = request.getParameter("backPage")+"";
String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE")+"";//获取所属的地区编号


MailBean mb = new MailBean () ;
if (mid !=null&&!"".equals(mid)) {
	MailServiceIfc ms=new MailServiceImpl();
	mb = ms.findMailInfo(mid);
	//回复和转发时，把原来的附件复制一份  特检院oa 20150304 start 
	if("yes".equals(iszf)||"yes".equals(replyMail)){
		if (!StringUtil.isBlank(mb.getAttachment_id())) {
			attachment_id = mb.getAttachment_id();
		}
		//System.out.println("=========="+attachment_id);
		String attachment_newId = StringUtil.getUUID();
		MailServiceIfc mailserviceifc = new MailServiceImpl();
		mailserviceifc.copyAttach(attachment_newId,attachment_id,userId);
		attachment_id = attachment_newId;
		System.out.println("=========="+attachment_id);
	} else {
		if (!StringUtil.isBlank(mb.getAttachment_id())) {
			attachment_id=mb.getAttachment_id();
		}
	}
	//回复和转发时，把原来的附件复制一份  特检院oa 20150304 start 
	
	if("yes".equals(iszf)&&mb!=null){
		mb.setReceivepid("");
		mb.setReceivepname("");
		mid="";
	}
	if("yes".equals(replyMail)){
		mid="";
	}
}else{
	mb.setTitle(title);
	mb.setReceivepid(beSendUserIds);
	mb.setReceivepname(beSendUserNames);
}

/* List<FileInfoBean> fileList = null;
if (!StringUtil.isBlank(mb.getAttachment_id())) {
	attachment_id=mb.getAttachment_id();
	FiletransfersSysDao filesysDao = new FiletransfersSysDaoImpl();
 	fileList = filesysDao.getFileInfoBeanlist(mb.getAttachment_id());
} */

MailDaoImpl mailDaoImpl = new MailDaoImpl();
int maxAttachSize = mailDaoImpl.getMaxAttachSize("'1'");
int attachSize = mailDaoImpl.attachSize();


//短信默认值
String msginitBegin = "望城城投办公自动化系统提醒您：您有";
String msginitEnd = "的待阅电子邮件，请查阅! ";
String msginit = msginitBegin+StringUtil.deNull(mb.getTitle())+msginitEnd;
%>
<title></title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>


<script type="text/javascript">jQuery.noConflict();</script>

<!-- 引入其它 -->
<!-- 公共部分引用结束 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>

<script type="text/javascript">
var backtype;
var userName = '<%=user_Name%>';
var b_checkEmailBoxMemory = window.top.windowTopUtil.getSystemParam("mail.checkEmailBoxMemory");
jQuery(function(){
	  MyFancyupload.createUpload('file_list', '#file_attach', '<%=path%>', '<%=path%>/servlet/pubFileUpload?buessid=<%=attachment_id%>', true, "<%=attachment_id%>");
	  if("admin" == userName){
		  jQuery("#but_hid").hide();
	  }
	  if(b_checkEmailBoxMemory){
		  jQuery("#email_memory_info").show();
	  }
  });
  
//页面收缩
  function changerContetDiv(id,imgId){
  	var none = jQuery("#"+id).css('display');
  	if(none == "none"){
  		jQuery("#"+id).show();
  		jQuery("#" + imgId).attr("src","../../../resources/images/hide.gif");

  	} else{
  		jQuery("#"+id).hide();
  		jQuery("#" + imgId).attr("src","../../../resources/images/show.gif");
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
  		  if(IsSpace(orgObj.ps.id)  && IsSpace(orgObj.ps1.id))
  		  	{
			   jQuery('#participants_id').val('');
			   jQuery('#participants_name').val('');
			 }else{
				//特检院 OA 去掉最近选择人
			 	//var id= orgObj.ps.id+","+orgObj.ps1.id;
			 	//var name=orgObj.ps.name+","+orgObj.ps1.name;
			 	var id= orgObj.ps.id;
			 	var name=orgObj.ps.name;
			 	var idArr=id.split(",");
			 	var nameArr=name.split(",");
			 	//id=idArr.unique().join(","); 去掉 人员去重，应该有重复人员名称
			 	id=idArr.join(",");
			 	if(","==id.substr(0,1)){
			 		id=id.substr(1);
			 	}
			 	if(","==id.substr(id.length-1,1)){
			 		id=id.substr(0,id.length-1);
			 	}
			 	//name=nameArr.unique().join(",");去掉 人员去重，应该有重复人员名称
			 	name=nameArr.join(",");
			 	if(","==name.substr(0,1)){
			 		name=name.substr(1);
			 	}
			 	if(","==name.substr(name.length-1,1)){
			 		name=name.substr(0,name.length-1);
			 	}
				jQuery('#participants_id').val(id);
				jQuery('#participants_name').val(name);
			 }
  	  }
  	  s.isNewCommonUse=true;
  	  s.treeList=
  			  [{
  				  leftHeaderText:'按人员选择',
  				  valueKey:'ps',
  				  selectedIds:jQuery('#participants_id').val(),
  				  type:'APERSON'
		  		}
  			  	/* ,
		  		{
					  leftHeaderText:'最近联系人',
					  valueKey:'ps1',
					  selectedIds:jQuery('#participants_id').val(),
					  type:"EMAILTOP10"
				} */
		  		,
		  		{
					  leftHeaderText:'常用分组',
					  item_id :'org_id',
					  isType:'dept', 
					  valueKey:'dept',
					  selectedIds:'',
					  isGroup:true,
					  type:"A3"
				}];
  	  s.init();

  }
  /*检查邮箱内存是否溢出*/
  function checkEmailBoxMemory(){
	  var isEmailBoxMemoryOverflow = false;
	  
	  jQuery.ajax({
		  url: "checkEmailBoxMemory.jsp",
	      type: "POST",
	      data: {userids : ""},
	      dataType: "json",
	      async:false,
	      success: function(obj){
	    	  isEmailBoxMemoryOverflow = obj.memoryIsOverflow; 
	      }

	  })
	  if(isEmailBoxMemoryOverflow){
		  alert("邮箱内存已满，请联系管理员进行清理或扩充容量！");
		  return false;
	  }else{
		  return true;
	  }
  }
  
    var saveMail = function (obj){
    	//是否检查邮箱内存溢出
    	
    	if(b_checkEmailBoxMemory){
    		if(!checkEmailBoxMemory()){
        		return;
        	}
    	}
    	
       	backtype=obj;
		if(jQuery("#dxtzjsr").attr("checked")=="checked"){
			dxtzjsr="1";
		}
		  jQuery("#nr").val(jQuery("#content").val());
		  jQuery("#state").val(obj);
		  if('<%=StringUtil.deNull(mid)%>'!=""){
			  jQuery("#action").val("update");
		  }else{
			  jQuery("#action").val("save");
		  }
		  if(window.parent.location.href.indexOf("index")>0){
		  	jQuery("#isFromHome").val("1");		//如果从首页进来的，保存时需要存一个特殊的标志过去
		  }
		  var titile = jQuery("#title").val();
		  if(titile.length>=150)
		  {
			  alert("主题最多输入150个字符");
			  return;
		  }
		  // var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		  var isFlag = validateForm(); //是否全部验证通过
		  
		  
		  
		  if (isFlag) {
			  var okF = function(){
				//附件上传提交
					 //uplodFiles('_fileshow',"<%=path%>/servlet/FileUpload?buessid="+attachment_id);
					 document.all.form1.target = "hiddenFrame";
					 jQuery('#form1').attr("action","mailSave.jsp?state="+obj);
					
					 //var f=document.all.form1;
					 // f.action="mailSave.jsp?paramjosn="+$("#paramjosn").val()+"&action="+$("#action").val();
					 jQuery('#form1').submit()
				}
				var p={
					headerText:'提示',okName:'确认', okFunction:okF,cancelName:'取消'
				};
				//发送
				if("1"==obj){
					alert("是否确定发送？",p);
				//存草稿箱
				} else if("0"==obj){
					alert("是否确定存草稿箱？",p);
				}
		  }else{
				return;
			}
		}
    /* 
	 * 返回 
	 */
	function saveBack(){
		var backPage = '<%=backPage%>';
		var windowId = '<%=windowId%>';
		if(window.parent.location.href.indexOf("index")>0){
			removeWindows('sub_main_view',true);	//从首页进来的这个，固定写死的这个subid，不要更改，否则会报错
		} else {
			var okF = function(){
	    	if('' !== windowId){
	    		removeAlertWindows(windowId,true);
	        }else if(window.parent.location.href.indexOf("index")>0){
	    			removeWindows('sub_main_view',true);	//从首页进来的这个，固定写死的这个subid，不要更改，否则会报错
	    	}else{
	    		if(backtype=="0"){
	    			window.parent.jQuery("#tabs").tabs({ selected: 1 });
	    		}else if(backtype=="1"){
	    			window.parent.jQuery("#tabs").tabs({ selected: 2 });
	    		}
	    		else{
	    			window.parent.jQuery("#tabs").tabs({ selected: 0 });
	    		}
	    	}
			}
	    	 var p={
						headerText:'提示',
						okName:'确认',
				        okFunction:okF,
				        cancelName:'取消'
				};
				alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
			}
	}
	function init(){
		window.parent.jQuery("#frame4").attr("src","sendMail.jsp");
	}
	function checktype()
	{
		if(jQuery("#isTypebox").attr("checked"))
		{
			jQuery('#isType').val('y');
		}else
		{
			jQuery('#isType').val('n');
		}
	}//add by shixing.he begin 贸促会短信内容由用户自定义
	function checktypewc(){
		if(jQuery('#remind_mode').attr("checked")){
			//贸促会短信内容由用户自定义,勾选短信提醒，则显示短信内容框
			<%if("421005".equals(StringUtil.deNull(userArea))){ %>
				jQuery('#messageInfo').show();
				jQuery('#isType').val('y');
				jQuery("#message_info").addClass("validate[required]")
			<%}%>
		} else {
			//贸促会短信内容由用户自定义,不勾选短信提醒，则隐藏短信内容框
			<%if("421005".equals(StringUtil.deNull(userArea))){ %>
				jQuery('#messageInfo').hide();
				jQuery('#isType').val('n');
			<%}%>
		}
	}
	
	/*
		作者:  邱炼
		时间:  2015-03-12
		函数:  validateForm
		说明:  验证页面
		参数:   无
		返回值: 无
	*/
	var validateForm = function(){
		if(jQuery('#form1').validationEngine('validate')){
			var str = iframe_ewebeditor.getHTML();
			jQuery('#nr').val(str);
			if(IsSpace(jQuery('#nr').val())){
				alert("邮件正文不能为空！");
				return false;
			}
				return true;
		}
	}
</script>
<script type="text/javascript">
            var height ="<%=request.getParameter("height")%>";
            window.onload = function () {
      				 adaptationWH("content_02_top","vcenter",50);	
      				//window.parent.jQuery("#frame4").attr("src","sendMail.jsp");
            }
 </script> 
</head>
<body style="overflow-y: hidden;" >
	<form id="form1" name="form1" method="post" action="">
	<input type="hidden" name="paramjosn" id="paramjosn"/>
	<input type="hidden" name="action" id="action" />
	<input type="hidden" id="isType"  name="isType"/> 
	<input type="hidden" id="isFromHome"  name="isFromHome"/> 
	<div class="content_02" style="overflow: hidden;">
			<!-- 操作-->
			<div class="content_02_top" style="margin-bottom: 1px;" id='content_02_top'>
			<div id="but_hid">
				<input value="发送" type="button" class="but_y_01" onclick="saveMail('1')" /> 
				<input value="存草稿箱" type="button" class="but_y_01" onclick="saveMail('0')" /> 
				<input value="返回" type="button" class="but_y_01" onclick="saveBack()" /> 
				<span id="email_memory_info" style="display:none;color:red;float:left;margin-top:7px;margin-left:5px;height:100%;">当前邮箱容量：<%=attachSize %>/<%=maxAttachSize%><%=EmailConstants.CHECKEMAIL_MEMORY_UNIT %></span>
				</div>
				<input type="hidden" name="nr" id="nr" /> 
				<input type="hidden" name="attachment_id" value="<%=attachment_id%>" /> 
				<input type="hidden" name="sendpid" value="<%=userId%>" /> 
				<input type="hidden" name="deptid" value="<%=orgId%>" /> 
				<input type="hidden" name="sendpname" value="<%=userName%>" /> 
				<input type="hidden" name="mid" value="<%=mid%>" /> 
				<input type="hidden" name="dxtzjsr" value="0" /> 
				<input type="hidden" name="deptname" value="<%=orgName%>" /> 
			
				
			</div>
		</div>
<!-- 表格-->
	<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes" >
	<div style="float: left; width: 775px; ">
 		<div class="content_02_box">
				<div class="content_02_box_title_bg">
				<div class="content_02_box_add show_content" >
				<img src="../../../resources/images/hide.gif" id="imgIDSS2" onclick="changerContetDiv('info','imgIDSS2')"/>
				</div>
					<span>基本信息</span>
				</div>
				<div class="content_02_box_div" id="info">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="content_02_box_div_table_02">
						<tr>
							<th width="212" valign="top"><font color="red">*</font>收&nbsp;件&nbsp;人：</th>
							<td width="580" id="">
							<%if("yes".equals(StringUtil.deNull(replyMail))){%>
								<input type="text" id="participants_name" name="participants_name" onmouseover="this.title=this.value" value="<%=StringUtil.deNull(mb.getSendpname())%>"  class="validate[required] input_140" onclick="chooseReportUnits()"/>
           					 	<input type="hidden" id="participants_id" name="participants_id" value="<%=StringUtil.deNull(mb.getSendpid())%>" />
							<%} else{ %>
								<input type="text" id="participants_name" name="participants_name" onmouseover="this.title=this.value" value="<%=StringUtil.deNull(mb.getReceivepname())%>"  class="validate[required] input_140" onclick="chooseReportUnits()"/>
           					 	<input type="hidden" id="participants_id" name="participants_id" value="<%=StringUtil.deNull(mb.getReceivepid())%>" />
							<%} %>
							<input name="" type="button" value="" class="but_x" onclick="chooseReportUnits()"/></td>
						</tr>
						<tr style="display:none">
							<td width="560" id="" colspan="2" style="padding-left:190px;" >
							<input type="checkbox" name="dxtzjsr" id="dxtzjsr" value="" <%if("1".equals(mb.getDxtzjsr())){%>checked="checked"<% }%> />短信通知收件人</td>
						</tr>
						<tr>
							<th width="212" valign="top"><font color="red">*</font>主&nbsp;&nbsp;&nbsp;&nbsp;题：</th>
							<td width="560" id="">
								<input type="text" id="title" name="title" value="<%=StringUtil.deNull(mb.getTitle())%>"  class="validate[required] input_140"/>
							</td>
						</tr>
						<tr>
							<th width="212" valign="top">附&nbsp;&nbsp;&nbsp;&nbsp;件：</th>
							<td width="560" >
								<a href="#" id="file_attach">请选择附件</a>
							</td>
						</tr>
						<tr>
							<th valign="top">附件列表：</th>
							<td >
								<ul id="file_list"></ul>&nbsp;
							</td>
						</tr>
						<%if(userArea.equals("421000")){%>
						<tr>
					         <th width="212" valign="top">短信提醒：</th>
					         <td  width="560">
					           <input type=checkbox name="isTypebox" id="isTypebox" onclick="checktype()"/>&nbsp;&nbsp;短信提醒接收人
					         </td>
       					</tr>
						<%}%>
						<%if(userArea.equals("421005")){%>
				        <tr>
					           <th width="191" class="content_02_box_div_table_th">短信提醒：</th>
					           <td class="content_02_box_div_table_td">
								<input name="remind_mode" id="remind_mode" type="checkbox" onclick="checktypewc()"/>&nbsp;&nbsp;短信提醒接收人
					           </td>
				         </tr>
						 <tr id="messageInfo" style="display : none;">
					         <th class="content_02_box_div_table_th">短信内容：</th>
					         <td class="content_02_box_div_table_td">
					        <textarea  class="textarea_575"  rows="8" cols=""  name="message_info" id="message_info"><%=msginit%></textarea>
					         </td>
					     </tr>         	         
						<%} %>

					</table>
				</div>
			</div>	
			
			<div class="content_02_box">
				<div class="content_02_box_title_bg">
					<%if(CacheCommonManageProxy.getBooleanSystemParam("mailName")){%>
						<span> 文件正文</span>
					<%}else{ %>
						<span> 邮件正文</span>
					<%} %>
					
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 				&nbsp;&nbsp;&nbsp;&nbsp;
	 			</span>
	 			
	 		 	<!--  <span class="color_red">备注：为规范邮件行文格式，请使用正常字体格式进行编辑！</span> -->
				</div>
				<div class="content_02_box_div">
					<%if("yes".equals(StringUtil.deNull(replyMail))|| "yes".equals(StringUtil.deNull(iszf))){%>
					<textarea style="DISPLAY: none;" name="content" id="content"><br/><br/><br/><span style="font: bold;">发件人：</span><%=StringUtil.deNull(mb.getSendpname())%><br/><span style="font: bold;">发送时间：</span><%=StringUtil.deNull(mb.getCreatetime())%><br/><span style="font: bold;">主题：</span><%=StringUtil.deNull(mb.getTitle())%><br/><br/><%=StringUtil.deNull(mb.getContent())%></textarea>
					<% } else {%>
					<textarea style="DISPLAY: none;" name="content" id="content"><%=StringUtil.deNull(mb.getContent())%></textarea>
					<%} %>
					<iframe id="iframe_ewebeditor"
						src="../../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=content&style=gray"
						frameborder="0" scrolling="no" width="100%" height="460"></iframe>
				</div>
			</div>
			</div>
			</div>
</form>	
<script type="text/javascript">
jQuery('#title').keyup(function(){
	var title = jQuery('#title').val();
	var msginitBegin ="<%=msginitBegin%>";
	var msginitEnd =title+"<%=msginitEnd%>";
	jQuery('#message_info').val(msginitBegin+msginitEnd);
});
</script>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>