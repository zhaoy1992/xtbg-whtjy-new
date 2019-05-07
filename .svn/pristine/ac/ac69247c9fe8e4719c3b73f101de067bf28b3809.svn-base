<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String inputuser_id = accesscontroler.getUserID();
	String inputuser_name = accesscontroler.getUserName();
	String submittedinfoId = request.getParameter("submittedinfoId");
	String state = request.getParameter("state");
	InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
	InfoReportBaseInfoBean infoReportBaseInfoBean = infoReportdao.findInfoReportBaseInfo(submittedinfoId);
	List<InfoReportAuditIdeaBean> auditlist = infoReportdao.findInfoReportAuditListByUser(submittedinfoId,"",inputuser_id);
	
	InfoReportServiceIfc infoReportServiceIfc = new InfoReportServiceImpl();
	
	if(InfoType.NOT_BE_VIEW.equals(state)){//如果是未查看状态，则
		InfoReportBaseInfoBean infoReportBaseInfoBean1 = new InfoReportBaseInfoBean();
		InfoReportAuditIdeaBean infoReportAuditIdeaBean = new InfoReportAuditIdeaBean();
		BeanUtils.copyProperties(infoReportBaseInfoBean1,infoReportBaseInfoBean);
		infoReportBaseInfoBean1.setSubmittedinfo_typecode(InfoType.HAS_BE_VIEW);
		infoReportBaseInfoBean1.setSubmittedinfo_typecode4getinfouser(InfoType.HAS_BE_VIEW);
		infoReportBaseInfoBean1.setSubmittedinfo_typecode2delete(InfoType.NOT_BE_VIEW);
		
		infoReportAuditIdeaBean.setAndit_person(inputuser_name);
		infoReportAuditIdeaBean.setAndit_person_id(inputuser_id);
		
		infoReportServiceIfc.InfoViewSave(infoReportBaseInfoBean1,infoReportAuditIdeaBean);
	}
	String operwindowid ="";
	if(request.getParameter("windowId")!=null){
		operwindowid=request.getParameter("windowId");
	}else{
		operwindowid=request.getParameter("operwindowid");
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.InfoReportServiceIfc"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.InfoReportServiceImpl"%>
 <%@page import =" com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="org.apache.commons.beanutils.BeanUtils"%>
<%@page import="java.util.List"%><html>
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
	$(function (){
		jQuery("#form1").validationEngine();
		eWebEditor2.setMode('VIEW');
		if("<%=InfoType.HAS_BE_PISHI%>" == "<%=state%>"){
			
			$("#t2").hide();
			$("#Pishi").hide();
			$("#t1").hide();
			$("#t3").hide();
		}
		else{
			
			$("#t2").show();
			$("#t1").show();
			$("#Pishi").show();
			$("#printView").hide();
			
		}
	})

	function backTo(){
		 window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
		 removeWindows('<%=operwindowid%>',true);
		}	

	function toJasonParam(state){
		var str = "{'submittedinfo_id':'<%=submittedinfoId%>',"+
				"'submittedinfo_code':'"+state+"',"+
				"'audit_idea':'"+$('#t1').val()+"'}";
		return descape(escape(str));
	}

	function refreshWin4pishi(){
		location.href = "inforeportdetailview.jsp?submittedinfoId=<%=submittedinfoId%>&state=<%=InfoType.HAS_BE_PISHI%>&operwindowid=<%= operwindowid%>";
	}
	function pishi(){
		
		if(jQuery("#form1").validationEngine("validateform")){
			var url = "infoonlyauditideasaveform.jsp";
			params = {
					submittedinfo_id : '<%=submittedinfoId%>',
					submittedinfo_code : '<%=InfoType.HAS_BE_PISHI%>',
					submittedinfo_code2delete : '<%=InfoType.HAS_BE_VIEW%>',
					audit_idea : escape($('#t1').val())
					 };
			$.ajax({
				url: url,
				type: 'POST',
				dataType: 'json',
				data: params,
				//async : false,
				success: function(data){
						alert("操作成功！");
						refreshWin4pishi();
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert("操作失败！");
				}
			});	
		}
		
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息上报详细浏览页面</title>

<!-- 打印需要导入的内容、方法 -->
<script language="javascript" src="../../../resources/plug/Lodop/LodopFuncs.js"></script> 
<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
       <!-- 是专为 FireFox 浏览器设计的代码  -->
       <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path %>/resources/plug/Lodop/Lodopinstall_lodop.exe"></embed>
</object>
<script language="javascript" type="text/javascript">   
        var LODOP; //声明为全局变量 
      /*   打印预览 */
	function prn1_preview() {	
		CreateOneFormPage();	
		LODOP.PREVIEW();	
	};
	/* 直接打印 */
	function prn1_print() {		
		CreateOneFormPage();
		LODOP.PRINT();	
	};
	/* 
	(扩展型)直接打印A
	格式：PRINTA ()
	功能：同函数PRINT。打印前提示选择打印机。
	参数：同函数PRINT。
	结果：同函数PRINT。返回逻辑结果，当真实打印时返回真，放弃打印或打印出错时返回假。
	建议或要求：
	同函数PRINTA 
	*/
	function prn1_printA() {		
		CreateOneFormPage();
		LODOP.PRINTA(); 	
	};
	/*创建部分打印内容  */
	function CreateOneFormPage(){
		/*判断浏览器的类型并决定采用哪个对象实例，并检测控件是否安装、是否最新版本、并引导安装或升级。  */
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));
		/*初始化运行环境，清理异常打印遗留的系统资源，设定打印任务名。  */
		LODOP.PRINT_INIT("打印通知公告部分内容-正文");
		/*
		SET_PRINT_STYLE(strStyleName,varStyleValue)
		功能：设置打印项的输出风格，成功执行该函数，此后再增加的打印项按此风格输出。
		参数：	
		strStyleName：打印风格名，风格名称及其含义如下：
		“FontName”： 设定纯文本打印项的字体名称。
		“FontSize”： 设定纯文本打印项的字体大小。
		“FontColor”： 设定纯文本打印项的字体颜色。
		“Bold”： 设定纯文本打印项是否粗体。
		“Italic”： 设定纯文本打印项是否斜体。
		“Underline”： 设定纯文本打印项是否下滑线。
		“Alignment”： 设定纯文本打印项的内容左右靠齐方式。
		“Angle”： 设定纯文本打印项的旋转角度。
		“ItemType”：设定打印项的基本属性。
		“HOrient”：设定打印项在纸张内的水平位置锁定方式。
		“VOrient”：设定打印项在纸张内的垂直位置锁定方式。
		“PenWidth”：线条宽度。
		“PenStyle”：线条风格。
		“Stretch”：图片截取缩放模式。
		“PreviewOnly”:内容仅仅用来预览。
		“ReadOnly”:纯文本内容在打印维护时，是否禁止修改。
		  */
		/*设置打印字体的大小 */
		LODOP.SET_PRINT_STYLE("Horient",3);
		LODOP.SET_PRINT_STYLE("Vorient",3);
		LODOP.SET_PRINT_STYLE("FontSize",9);
		//LODOP.SET_PRINT_STYLE("Bold",1);
		/*增加纯文本打印项，
		设定该打印项在纸张内的位置和区域大小，
		文本内容在该区域内自动折行，当内容超出区域高度时，
		如果对象被设为“多页文档”则会自动分页继续打印，否则内容被截取。  */
		//LODOP.ADD_PRINT_TEXT(0,0,'99%','99%',"打印通知公告正文内容");
		/*增加超文本打印项，设定该打印项在纸张内的位置和区域大小，实现超文本控制打印。  */
		//LODOP.ADD_PRINT_HTM('1.25CM','1.85CM','82%','80%',document.getElementById("edit_content").value);
		$("#_print_html").html(eWebEditor2.getHTML());
		/*增加超文本打印项，设定该打印项在纸张内的位置和区域大小，实现超文本控制打印。  */
		LODOP.ADD_PRINT_HTM('1.25CM','1.25CM','82%','80%',$("#_print").html());
	};	  

	function parseToWordFun(){
		window.open('../../../public/parseHtmlToWord/parseHtmlToWord.jsp?content_type=inforeportdetailview&business_id=<%=submittedinfoId%>','_blank');
	}                   
</script> 

</head>

<body style=" overflow-y:hidden;" onload="adaptationWH('_top','vcenter',8)">
<form id="form1" name="form1" class="formular" method="post">
<div  class="content_02" style="overflow:hidden;">
	<div class="content_02_top"  id="_top">
  	<input  type="button" class="but_y_01"  name="operation" id="Pishi" value="批示" onclick="pishi();"/>
   	<input name="operation" class="but_y_01" value="返回" type="button"  id="backto" onclick="backTo()" />
   	<input type="button" class="but_y_01" id="printView" value="打印" onclick="prn1_preview()" />
	</div> 
<!-- 表格-->
	<div id="vcenter" style="float:left; width:100%; overflow:scroll;overflow-x	:hidden" scrolling="yes">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>基本信息</span></div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
		 <tr>
           <th width="191" class="content_02_box_div_table_th">
		            标题：
           <td class="content_02_box_div_table_td" colspan="3">
           <input type="hidden" id="submittedinfo_id" name="submittedinfo_id" value="<%=submittedinfoId %>" />
			<%=infoReportBaseInfoBean.getSubmittedinfo_title() %>
		   
         </tr>
         
           <tr>
	           <th class="content_02_box_div_table_th">录入部门：</th>
	           <td class="content_02_box_div_table_td">
	           <%=infoReportBaseInfoBean.getOrg_name() %>
				<input type="hidden"  name="orgid" id="orgid" value="<%=infoReportBaseInfoBean.getOrg_id()%>">
	           </td>
	           <th class="content_02_box_div_table_th">录入者：</th>
	           <td class="content_02_box_div_table_td">
	          <%=infoReportBaseInfoBean.getInputuser_name() %>
				<input type="hidden"  name="inputuser_id" id="inputuser_id" value="<%=infoReportBaseInfoBean.getInputuser_id() %>">
	           </td>
         </tr>
		
           <tr>
           <th class="content_02_box_div_table_th">信息类型：</th>
           <td class="content_02_box_div_table_td">
           <%=infoReportBaseInfoBean.getInfotype_name() %>
			
           </td>
           <th class="content_02_box_div_table_th">关键字：</th>
           <td class="content_02_box_div_table_td">
           <%=infoReportBaseInfoBean.getKeyword() %></td>
           
         </tr>
     </table>
     </div>
     </div>
   
   
   
     <div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>正文</span>
	 <div class="content_02_box_add" >
	  <span id="selAreaImg" class="tabs_search_text_but">
	 	</span>
	 	</div>
	 <div class="content_02_box_add" id="t2">
		 <span id="selAreaImg" class="tabs_search_text_but">
	   				<input type="button" id="parseToWord" name="parseToWord" value="正文下载" class="but_y_01" 
	   				style="display: inline" onclick="parseToWordFun();" />
	   	</span>
	 </div>
	 </div>
	 <div class="text_show_main_box" id="printZW">
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
	
	<!-- 设置打印文字的字体  -->
	<div style="display:none;" id="_print">
	<div style="font-size:12px;bold:1;" id="_print_html"></div>
	</div>
	
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>评论</span>
	 <div class="content_02_box_add" id="t3">
	 <span id="selAreaImg" class="all_search_condition">
	 <a onclick="hiddenOrShowSelArea('t1','selAreaImg')">
	 <img src="../../../resources/images/add.gif" />我要批示</a></span></div>
	 </div>
	 <div  class="text_show_main_box" >
	   <table width="100%" border="0" cellspacing="0" cellpadding="0">
	   <tr>
	   <td>
	    <textarea type="text" id="t1" name="t1"  class="pinglun_textarea"></textarea>
	   </td>
	   </tr>
  <tr>
    <td align="center">
	<table border="0" cellspacing="0" cellpadding="0"  class="text_show_box">
					<tr>
						<td>
					 	<%if(null != auditlist){
						for(InfoReportAuditIdeaBean auditBean : auditlist){ %>
					 <span class="list_main_pl_neir"><%=auditBean.getAndit_opinion() %>
					 </span>&nbsp;&nbsp;&nbsp;<span class="list_main_name">
					 <%=auditBean.getAndit_person() %></span>  
					 <span class="list_main_pl_time"><%=auditBean.getAndit_time() %>
					 </span>
					<br>
				<%}} %>
				</td>
				</tr>
   </table>
	   </td>
    </tr>
</table>
	 </div>
</div>


</div>
</div>
</div>
</form>
</body>
</html>