
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import=" com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageWxByServiceImpl"%>
<%@page import=" com.chinacreator.xtbg.yimingju.carmanage.service.CarManageWxByServiceIfc"%>
<%@page import=" com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageWxbyBean"%>



<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String car_id = request.getParameter("car_id");
	String subid= request.getParameter("subid");
	String isSp=request.getParameter("isSp");
	String passCheck=request.getParameter("passCheck");
	boolean flag = false;
	CarManageWxByServiceIfc service = new CarManageWxByServiceImpl();
	CarManageWxbyBean carManageWxbyBean=service.findCarWxInfo(car_id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>

<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>

<!-- 引入提示 -->
   <script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js" charset="utf-8"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<link rel="stylesheet" href="../../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<style type="text/css">
.content_02_box_div_table_02_list{
width:100%}
</style>
<script type="text/javascript">
	</script>
<title>会议通知单</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" /></head>

<script type="text/javascript">
jQuery(function() {
	$("#form1").validationEngine();
	//审批页面不能修改实际费用       tl   2013-4-17
	//if(<%=passCheck%>=="2"){
	//	$("#sjfy").attr("readonly","readonly");
	//}
});
window.onload = function () {
	setDataTimeClickShowOrHide('accesory_time',window);
    adaptationWH("content_02_top","vcenter");
}

//关闭
function closed(){
	removeWindows('<%=subid%>',true);
}
var spPass = function(){
	$("#passCheck").val("2");
	$("#passCase").val("同意");
	
	var okF = function(){
		 document.all.form1.target = "hiddenFrame";
		 $('#form1').attr("action","carWxSpSave.jsp");
		 $('#form1').submit();
	}
	var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	if($("#spyj_nr").val()==""){
		alert("没有填写意见！是否确定通过",p)
	}else{
		alert("是否确定通过",p)
	}
}
//提示方法
var doPoint = function(title,okF){
	var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert(title,p)
}

var updatesjfy = function(){
	$("#passCheck").val("4");
	//$("#sjfy").removeAttr("readonly");
	$("#sjfy").focus();
	var sjfy = $("#sjfy").val().replace(/\s/gi,'');
	if(sjfy.length==0){
		return false;
	}else{
		var okF = function(){
			 document.all.form1.target = "hiddenFrame";
			 $('#form1').attr("action","carWxSpSave.jsp");
			 $('#form1').submit();
		}
		var p={
				headerText:'提示',
				okName:'确认',
			    okFunction:okF,
			    cancelName:'取消'
			};
		alert("是否确定修改",p)
	}
}
var spNoPass = function(){
	$("#passCase").val("不同意");
	$("#passCheck").val("3");
	var okF = function(){
		 document.all.form1.target = "hiddenFrame";
		 $('#form1').attr("action","carWxSpSave.jsp");
		 $('#form1').submit();
	}
	var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	if($("#spyj_nr").val()==""){
		alert("没有填写意见！是否确定不通过",p)
	}else{
		alert("是否确定不通过",p)
	}
}
function saveBack(){
	if('<%=passCheck%>'=="2"){
		var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carWxWaitSp.jsp";
	}else if('<%=passCheck%>'=="3"){
		var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carWxYjSp.jsp";
	}else{
		var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carWxbyList.jsp";
	}
	location.href = url;
}
</script>
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
		LODOP.PRINT_INIT("打印展会管理报表信息");
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
		jQuery("#_print_html").html(jQuery("#prints").html());
		/*增加超文本打印项，设定该打印项在纸张内的位置和区域大小，实现超文本控制打印。  */
		LODOP.ADD_PRINT_HTM('1.25CM','2.3CM','85%','85%',jQuery("#_print").html());
		
	};
	//形成维修送修单
	function creatorsxd(){
		var url = "getAjaxCreatorSXD.jsp";
		var params={"carnumber":"<%=carManageWxbyBean.getCar_num()%>",
				"wxc":"<%=carManageWxbyBean.getWxc()%>",
				"yjfy":"<%=carManageWxbyBean.getYjfy()%>",	
				"year":"<%=carManageWxbyBean.getWxbyrq().substring(0, 4)%>",	
				"month":"<%=carManageWxbyBean.getWxbyrq().substring(6, 7)%>",	
				"day":"<%=carManageWxbyBean.getWxbyrq().substring(9, 10)%>",
				"fileid":"<%=car_id%>",
				"remark":"<%=carManageWxbyBean.getBz()%>"
			};
		$.ajax({
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			url: url,
			type: 'POST',
			dataType:'text',
			data: params,
			success: function(data){
				if(null!==data){
					docwin(data);
				}
				
			},
			error: function(jqXHR, textStatus, errorThrown){
				
			}
		})
	}
	function docwin(doc){
		window.open(doc,"_top");
	}
</script> 
<body style="overflow-y: hidden;">
	<form id="form1" name="form1" action="carWxSpSave.jsp" class="formular" method="post">
		<input type="hidden" name="passCheck" id="passCheck" value="<%=passCheck%>"/>
		<input type="hidden" name="passCase"  id="passCase" value=""/>
		<input type="hidden" name="id"  id="id" value="<%=carManageWxbyBean.getCar_id()%>"/>
		
		<div class="content_02" style="overflow: hidden;">
			<!-- 操作-->
			<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'>
				<% if(isSp!=null&&!"".equals(isSp)&&"2".equals(passCheck)){%>
				<input value="通过" type="button" class="but_y_01" onclick="spPass()" /> 
				<input value="不通过" type="button" class="but_y_01" onclick="spNoPass()" /> 
				<input value="形成维修单" type="button" class="but_y_01"  onclick="creatorsxd()" /> 
				<% }else if(isSp!=null&&!"".equals(isSp)){%>
				<input value="打印" type="button" class="but_y_01" onclick="prn1_preview()" />
				<%} %>
				<% if(carManageWxbyBean.getSjfy()!=null&&"".equals(carManageWxbyBean.getSjfy())){ %>
				<input value="修改" type="button" class="but_y_01" onclick="updatesjfy()" /> 
				<%} %>
				<input value="返回" type="button" class="but_y_01" onclick="closed()" /> 
			</div>
		</div>
		<!-- 表格-->
		<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
			<% if(!"等待审批".equals(StringUtil.deNull(carManageWxbyBean.getSp_state()))){%>
			<div class="content_02_box">
				<div class="content_02_box_title_bg">
					<span> 审批信息</span>
				</div>
				<div class="content_02_box_div">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table">
						<tr>
							<th width="191" class="content_02_box_div_table_th">状态：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<%="".equals(StringUtil.deNull(carManageWxbyBean.getSp_state()))?"":carManageWxbyBean.getSp_state()%>
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th">审批意见：</th>
							<td class="content_02_box_div_table_td">
								<%="".equals(StringUtil.deNull(carManageWxbyBean.getSp_yj()))?"":carManageWxbyBean.getSp_yj()%>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<% }%>
			<!-- 议题 -->
			<div class="content_02_box" id="parentdiv" >
				<div class="content_02_box_title_bg">
					<span>维修保养信息</span>
					<div class="content_02_box_add">
					
					</div>
				</div>
					<div class="content_02_box_div" id="trdiv" name="trdiv" style=" border-bottom:2px  solid  #ede7cd">
						  <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
								<tr>
									<th width="191" class="content_02_box_div_table_th">类&nbsp;&nbsp;&nbsp;&nbsp;型：</th>
									<td class="content_02_box_div_table_td" colspan="3">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getType()))?"":carManageWxbyBean.getType()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">车&nbsp;牌&nbsp;号：</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getCar_num()))?"":carManageWxbyBean.getCar_num()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">经&nbsp;办&nbsp;人：</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getJbr()))?"":carManageWxbyBean.getJbr()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">修&nbsp;配&nbsp;厂：</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getWxc()))?"":carManageWxbyBean.getWxc()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">联系电话：</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getMobile()))?"":carManageWxbyBean.getMobile()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">预计费用：</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getYjfy()))?"":carManageWxbyBean.getYjfy()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">实际费用：</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getSjfy()))?"0":carManageWxbyBean.getSjfy()%>
									</td>
								</tr>
								
								<tr>
									<th class="content_02_box_div_table_th">维修保养日期：</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getWxbyrq()))?"":carManageWxbyBean.getWxbyrq()%>
									</td>
								</tr>
								<tr>
									<% if(isSp!=null&&!"".equals(isSp)&&"2".equals(passCheck)){%>
									<th width="191" class="content_02_box_div_table_th">审批意见：</th>
									<td class="content_02_box_div_table_td">
										<textarea id="spyj_nr" name="spyj_nr"></textarea>
									</td>
									<%} %>
								</tr>
								<tr style="height:70px">
									<th class="content_02_box_div_table_th">备&nbsp;&nbsp;&nbsp;&nbsp;注：</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getBz()))?"":carManageWxbyBean.getBz()%>
									</td>
								</tr>
							</table>
					</div>
					<a id="downloaddoc" style="display: none" href=""></a>
			</div>

			<!-- 议题结束s -->
			</div>
			<div id="prints" style="display: none;">
			<table width="100%" border="1" class="content_02_box_div_table">
			  <tr>
			    <td colspan="4"><div align="center"><strong>车辆维修保养审批单</strong></div></td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型:</th>
			    <td width="20%"><%="".equals(StringUtil.deNull(carManageWxbyBean.getType()))?"":carManageWxbyBean.getType()%></td>
			    <th class="content_02_box_div_table_th">维修保养日期:</th>
			    <td width="20%">
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getWxbyrq()))?"":carManageWxbyBean.getWxbyrq()%>
			    </td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">车&nbsp;&nbsp;牌&nbsp;&nbsp;号:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getCar_num()))?"":carManageWxbyBean.getCar_num()%>
			    </td>
			    <th class="content_02_box_div_table_th">经&nbsp;&nbsp;办&nbsp;&nbsp;人:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getJbr()))?"":carManageWxbyBean.getJbr()%>
			    </td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">修&nbsp;&nbsp;配&nbsp;&nbsp;厂:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getWxc()))?"":carManageWxbyBean.getWxc()%>
			    </td>
			    <th class="content_02_box_div_table_th">联系电话:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getMobile()))?"":carManageWxbyBean.getMobile()%>
			    </td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">预计费用:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getYjfy()))?"":carManageWxbyBean.getYjfy()%>
			    </td>
			    <th class="content_02_box_div_table_th">实际费用:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getSjfy()))?"":carManageWxbyBean.getSjfy()%>
			    </td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">审批意见:</th>
			    <td colspan="3">
			    	<textarea rows="5" style="width: 100%" ><%="".equals(StringUtil.deNull(carManageWxbyBean.getSp_yj()))?"":carManageWxbyBean.getSp_yj()%></textarea></td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</th>
			    <td colspan="3">
			    	<textarea rows="5" style="width: 100%"><%="".equals(StringUtil.deNull(carManageWxbyBean.getBz()))?"":carManageWxbyBean.getBz()%></textarea>
			    </td>
			  </tr>
			</table>
			
			</div>
	</form>

	<iframe name="hiddenFrame" id="hiddenFrame" width=0 height=0></iframe>
	 <!-- 设置打印文字的字体  -->
	<div style="display:none;font-size:12px;" id="_print">
	<div style="font-size:12px;" id="_print_html"></div>
	</div>

</body>
</html>