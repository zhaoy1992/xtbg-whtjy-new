<%-- 
描述：公告栏
作者：黄海
版本：1.0
日期：2014-06-13
 --%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.notice.entity.NoticeReportAuditBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.impl.NoticeHandleServiceImpl"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String n_attach_id = "";
	String n_notice_id = request.getParameter("n_notice_id");
	String isview = request.getParameter("isview");
	String n_receiverid = request.getParameter("n_receiverid");
	String subid = StringUtil.deNull(request.getParameter("subid"));

	NoticeHandleServiceIfc noticeHandleServiceIfc = new NoticeHandleServiceImpl();
	Map<String, String> viewMap = new HashMap<String, String>();

	if (!StringUtil.isBlank(n_notice_id)) {
		viewMap = noticeHandleServiceIfc.getNoticeBaseInfoBean(n_notice_id);
		n_attach_id = StringUtil.deNull(viewMap.get("n_attach_id"));
	}

	if (!StringUtil.isBlank(isview)) {
		noticeHandleServiceIfc.updateNoticeReceiverUserState(n_receiverid);
	}
	String n_type_name = "";
	if (viewMap.get("n_type").equalsIgnoreCase("1")) {
		n_type_name = "院内资讯";
	} else if (viewMap.get("n_type").equalsIgnoreCase("2")) {
		n_type_name = "员工天地";
	} else if(viewMap.get("n_type").equalsIgnoreCase("3")) {
		n_type_name = "院内简报";
	}
%>
<title>公告查看页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
jQuery(function() {

    changerContetDiv2('dworry','imgIDSS1');
    //初始化附
    MyFancyupload.createUpload('_fileshow', '#_filebut1', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=n_attach_id%>', false, '<%=n_attach_id%>','','','011');
    //加载与会部门和人员
    var dep = new Object();
    var ps = new Object();

    dep.id=jQuery("#n_receiver_orgid").val();
    dep.name=jQuery("#n_receiver_orgname").val();
    
    ps.id=jQuery("#n_receiver_userid").val();
    ps.name=jQuery("#n_receiver_username").val();
    createrDeptAndPosn(dep,"deptTd",'n_receiver_orgid','n_receiver_orgname',false,false,false,true);
    createrDeptAndPosn(ps,"userTd",'n_receiver_userid','n_receiver_username',false,false,false,true);
    eWebEditor1.setMode('VIEW');
});



function changerContetDiv2(id,imgId){
    var none = jQuery("#"+id).css('display');
    if(none == "none"){
        jQuery("#"+id).show();
        jQuery("#" + imgId).attr("src","../../resources/images/hide.gif"); 
         jQuery("#"+imgId).removeClass("up_d");
    	 jQuery("#"+imgId).addClass("up_s");
        jQuery("#"+id).focus();
    } else{
        jQuery("#"+id).hide();
        jQuery("#" + imgId).attr("src","../../resources/images/show.gif"); 
         jQuery("#"+imgId).removeClass("up_s");
         jQuery("#"+imgId).addClass("up_d");
     }
}

function closed(){
     removeWindows('<%=subid%>',true);
}

window.onload = function () {
    if("<%=subid%>"!="ggl"&&"<%=subid%>"!="hostNotic"){
       adaptationWH("_top","vcenter",45);
     }else{
      adaptationWH("_top","vcenter",5);
    } 
}

</script>

<!-- 打印需要导入的内容、方法 -->
<script language="javascript" src="../../resources/plug/Lodop/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0"> <!-- 是专为 FireFox 浏览器设计的代码  --> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="../../resources/plug/Lodop/install_lodop.exe"></embed> 
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
        LODOP.SET_PRINT_STYLEA(0,"FontSize",20);
        LODOP.SET_PRINT_STYLEA(0,"Horient",3);
        LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
        //LODOP.SET_PRINT_STYLE("Bold",1);
        /*增加纯文本打印项，
        设定该打印项在纸张内的位置和区域大小，
        文本内容在该区域内自动折行，当内容超出区域高度时，
        如果对象被设为“多页文档”则会自动分页继续打印，否则内容被截取。  */
        //LODOP.ADD_PRINT_TEXT(0,0,'99%','99%',"打印通知公告正文内容");
        /*增加超文本打印项，设定该打印项在纸张内的位置和区域大小，实现超文本控制打印。  */
        //LODOP.ADD_PRINT_HTM('1.25CM','2.3CM','80%','80%',document.getElementById("edit_content").value);
        jQuery("#_print_html").html(jQuery("#n_content").val());
        /*增加超文本打印项，设定该打印项在纸张内的位置和区域大小，实现超文本控制打印。  */
        LODOP.ADD_PRINT_HTM('1.25CM','2.3CM','80%','80%',jQuery("#_print").html());
        
    };  
</script>

</head>
<!--startprint-->
<body style="overflow-y: hidden;">


<form id="form1" action="" method="post">

<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<input type="button" class="but_y_01" id="printView" value="打印" onclick="prn1_preview()" /> 
		<input name="" value="返回" style="" onclick="closed();" type="button" class="but_y_01" />
	</div>
</div>

<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
			<div style="float: left; width: 775px;">

				<div class="content_02_box">
					<div class="content_02_box_title_bg">
						<span>基本信息</span>
					</div>
					<div class="content_02_box_div" id="jbxx">
						<table border="0" cellspacing="0" cellpadding="0"
							class="content_02_box_div_table">
							<tr>
								<th width="212" class="content_02_box_div_table_th">公告类型：</th>
								<td class="content_02_box_div_table_td" colspan="3"><%=n_type_name%></td>
							</tr>
							<tr>
								<th width="212" class="content_02_box_div_table_th">公告标题：</th>
								<td class="content_02_box_div_table_td" colspan="3"><%=StringUtil.deNull(viewMap.get("n_title"))%></td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th">起草人：</th>
								<td class="content_02_box_div_table_td" width="100px"><%=StringUtil.deNull(viewMap.get("n_release_username"))%></td>
								<th class="content_02_box_div_table_th">起草者单位：</th>
								<td class="content_02_box_div_table_td" width="100px"><%=StringUtil.deNull(viewMap.get("n_unit_name"))%></td>
							</tr>

							<tr>
								<th class="content_02_box_div_table_th">发布时间：</th>
								<td class="content_02_box_div_table_td"><%=StringUtil.deNull(viewMap.get("n_release_time"))%></td>
								<th class="content_02_box_div_table_th" colspan="2"></th>
							</tr>
						</table>
					</div>
				</div>

				<div class="content_02_box">
					<div class="content_02_box_title_bg">
						<span>正文</span> <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<div class="content_02_box_add" id="t2">
							<span id="selAreaImg" class="tabs_search_text_but"></span>
						</div>
					</div>

					<div class="content_02_box_div">
						<table border="0" cellspacing="0" cellpadding="0"
							class="content_02_box_div_table">
							<tr>
								<td colspan="4"><textarea style="display: none"
										name="n_content" id="n_content"><%=StringUtil.deNull(viewMap.get("n_content"))%></textarea>
									<iframe id="eWebEditor1"
										src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=n_content&style=gray"
										frameborder="0" scrolling="no" width="100%" height="400"></iframe>
								</td>
							</tr>
						</table>
					</div>
				</div>

				<div class="content_02_box" id="otherinfo">
					<div class="content_02_box_title_bg">
						<div class="content_02_box_add show_content" style="cursor: hand">
							<span onclick="changerContetDiv2('qtxx','imgdiv1')">更多</span> <em
								id="imgdiv1" onclick="changerContetDiv2('qtxx','imgdiv1')"
								class="up_d">&nbsp;</em>
						</div>
						<span>其他信息</span>
					</div>
					<div class="content_02_box_div" id="qtxx">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="content_02_box_div_table_02">
							<tr id="fj" style="display: none">
								<th width="212" valign="top">附件：</th>
								<td width="560"><a href="#" id="_filebut">请选择文件</a>
								</td>
							</tr>
							<tr>
								<th valign="top" class="content_02_box_div_table_th">附件列表：</th>
								<td class="content_02_box_div_table_td" colspan="3">
									<ul id="_fileshow"></ul> &nbsp;</td>
							</tr>
						</table>
					</div>
				</div>

				<!-- 设置打印文字的字体  -->
				<div style="display: none; font-size: 12px;" id="_print">
					<div style="font-size: 12px;" id="_print_html"></div>
				</div>
				<!-- 评论 -->
				 <iframe src="noticesreportviewlist.jsp?n_notice_id=<%=n_notice_id %>"  id="reply"  width="789px;" height="300px" style="border: 0;margin-top: 10px;margin-left: 0px" frameborder="0" />
			</div>
		</div>

</form>

</body>
</html>