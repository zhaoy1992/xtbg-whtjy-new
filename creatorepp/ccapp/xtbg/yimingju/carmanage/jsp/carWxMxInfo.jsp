
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


<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>

<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- ����formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- �������� -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>

<!-- ������ʾ -->
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
<title>����֪ͨ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" /></head>

<script type="text/javascript">
jQuery(function() {
	$("#form1").validationEngine();
	//����ҳ�治���޸�ʵ�ʷ���       tl   2013-4-17
	//if(<%=passCheck%>=="2"){
	//	$("#sjfy").attr("readonly","readonly");
	//}
});
window.onload = function () {
	setDataTimeClickShowOrHide('accesory_time',window);
    adaptationWH("content_02_top","vcenter");
}

//�ر�
function closed(){
	removeWindows('<%=subid%>',true);
}
var spPass = function(){
	$("#passCheck").val("2");
	$("#passCase").val("ͬ��");
	
	var okF = function(){
		 document.all.form1.target = "hiddenFrame";
		 $('#form1').attr("action","carWxSpSave.jsp");
		 $('#form1').submit();
	}
	var p={
			headerText:'��ʾ',
			okName:'ȷ��',
		    okFunction:okF,
		    cancelName:'ȡ��'
		};
	if($("#spyj_nr").val()==""){
		alert("û����д������Ƿ�ȷ��ͨ��",p)
	}else{
		alert("�Ƿ�ȷ��ͨ��",p)
	}
}
//��ʾ����
var doPoint = function(title,okF){
	var p={
			headerText:'��ʾ',
			okName:'ȷ��',
		    okFunction:okF,
		    cancelName:'ȡ��'
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
				headerText:'��ʾ',
				okName:'ȷ��',
			    okFunction:okF,
			    cancelName:'ȡ��'
			};
		alert("�Ƿ�ȷ���޸�",p)
	}
}
var spNoPass = function(){
	$("#passCase").val("��ͬ��");
	$("#passCheck").val("3");
	var okF = function(){
		 document.all.form1.target = "hiddenFrame";
		 $('#form1').attr("action","carWxSpSave.jsp");
		 $('#form1').submit();
	}
	var p={
			headerText:'��ʾ',
			okName:'ȷ��',
		    okFunction:okF,
		    cancelName:'ȡ��'
		};
	if($("#spyj_nr").val()==""){
		alert("û����д������Ƿ�ȷ����ͨ��",p)
	}else{
		alert("�Ƿ�ȷ����ͨ��",p)
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
<!-- ��ӡ��Ҫ��������ݡ����� -->
<script language="javascript" src="../../../resources/plug/Lodop/LodopFuncs.js"></script> 
<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
        <!-- ��רΪ FireFox �������ƵĴ���  -->
       <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path %>/resources/plug/Lodop/Lodopinstall_lodop.exe"></embed>
</object>
<script language="javascript" type="text/javascript">   
        var LODOP; //����Ϊȫ�ֱ��� 
      /*   ��ӡԤ�� */
	function prn1_preview() {	
		CreateOneFormPage();	
		LODOP.PREVIEW();	
	};
	/* ֱ�Ӵ�ӡ */
	function prn1_print() {		
		CreateOneFormPage();
		LODOP.PRINT();	
	};
	/* 
	(��չ��)ֱ�Ӵ�ӡA
	��ʽ��PRINTA ()
	���ܣ�ͬ����PRINT����ӡǰ��ʾѡ���ӡ����
	������ͬ����PRINT��
	�����ͬ����PRINT�������߼����������ʵ��ӡʱ�����棬������ӡ���ӡ����ʱ���ؼ١�
	�����Ҫ��
	ͬ����PRINTA 
	*/
	function prn1_printA() {		
		CreateOneFormPage();
		LODOP.PRINTA(); 	
	};
	/*�������ִ�ӡ����  */
	function CreateOneFormPage(){
		/*�ж�����������Ͳ����������ĸ�����ʵ���������ؼ��Ƿ�װ���Ƿ����°汾����������װ��������  */
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));
		/*��ʼ�����л����������쳣��ӡ������ϵͳ��Դ���趨��ӡ��������  */
		LODOP.PRINT_INIT("��ӡչ���������Ϣ");
		/*
		SET_PRINT_STYLE(strStyleName,varStyleValue)
		���ܣ����ô�ӡ��������񣬳ɹ�ִ�иú������˺������ӵĴ�ӡ��˷�������
		������	
		strStyleName����ӡ�������������Ƽ��京�����£�
		��FontName���� �趨���ı���ӡ����������ơ�
		��FontSize���� �趨���ı���ӡ��������С��
		��FontColor���� �趨���ı���ӡ���������ɫ��
		��Bold���� �趨���ı���ӡ���Ƿ���塣
		��Italic���� �趨���ı���ӡ���Ƿ�б�塣
		��Underline���� �趨���ı���ӡ���Ƿ��»��ߡ�
		��Alignment���� �趨���ı���ӡ����������ҿ��뷽ʽ��
		��Angle���� �趨���ı���ӡ�����ת�Ƕȡ�
		��ItemType�����趨��ӡ��Ļ������ԡ�
		��HOrient�����趨��ӡ����ֽ���ڵ�ˮƽλ��������ʽ��
		��VOrient�����趨��ӡ����ֽ���ڵĴ�ֱλ��������ʽ��
		��PenWidth����������ȡ�
		��PenStyle�����������
		��Stretch����ͼƬ��ȡ����ģʽ��
		��PreviewOnly��:���ݽ�������Ԥ����
		��ReadOnly��:���ı������ڴ�ӡά��ʱ���Ƿ��ֹ�޸ġ�
		  */
		  /*���ô�ӡ����Ĵ�С */
		LODOP.SET_PRINT_STYLEA(0,"FontSize",20);
		LODOP.SET_PRINT_STYLEA(0,"Horient",3);
		LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
		//LODOP.SET_PRINT_STYLE("Bold",1);
		/*���Ӵ��ı���ӡ�
		�趨�ô�ӡ����ֽ���ڵ�λ�ú������С��
		�ı������ڸ��������Զ����У������ݳ�������߶�ʱ��
		���������Ϊ����ҳ�ĵ�������Զ���ҳ������ӡ���������ݱ���ȡ��  */
		//LODOP.ADD_PRINT_TEXT(0,0,'99%','99%',"��ӡ֪ͨ������������");
		/*���ӳ��ı���ӡ��趨�ô�ӡ����ֽ���ڵ�λ�ú������С��ʵ�ֳ��ı����ƴ�ӡ��  */
		//LODOP.ADD_PRINT_HTM('1.25CM','2.3CM','80%','80%',document.getElementById("edit_content").value);
		jQuery("#_print_html").html(jQuery("#prints").html());
		/*���ӳ��ı���ӡ��趨�ô�ӡ����ֽ���ڵ�λ�ú������С��ʵ�ֳ��ı����ƴ�ӡ��  */
		LODOP.ADD_PRINT_HTM('1.25CM','2.3CM','85%','85%',jQuery("#_print").html());
		
	};
	//�γ�ά�����޵�
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
			<!-- ����-->
			<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'>
				<% if(isSp!=null&&!"".equals(isSp)&&"2".equals(passCheck)){%>
				<input value="ͨ��" type="button" class="but_y_01" onclick="spPass()" /> 
				<input value="��ͨ��" type="button" class="but_y_01" onclick="spNoPass()" /> 
				<input value="�γ�ά�޵�" type="button" class="but_y_01"  onclick="creatorsxd()" /> 
				<% }else if(isSp!=null&&!"".equals(isSp)){%>
				<input value="��ӡ" type="button" class="but_y_01" onclick="prn1_preview()" />
				<%} %>
				<% if(carManageWxbyBean.getSjfy()!=null&&"".equals(carManageWxbyBean.getSjfy())){ %>
				<input value="�޸�" type="button" class="but_y_01" onclick="updatesjfy()" /> 
				<%} %>
				<input value="����" type="button" class="but_y_01" onclick="closed()" /> 
			</div>
		</div>
		<!-- ���-->
		<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
			<% if(!"�ȴ�����".equals(StringUtil.deNull(carManageWxbyBean.getSp_state()))){%>
			<div class="content_02_box">
				<div class="content_02_box_title_bg">
					<span> ������Ϣ</span>
				</div>
				<div class="content_02_box_div">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table">
						<tr>
							<th width="191" class="content_02_box_div_table_th">״̬��</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<%="".equals(StringUtil.deNull(carManageWxbyBean.getSp_state()))?"":carManageWxbyBean.getSp_state()%>
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th">���������</th>
							<td class="content_02_box_div_table_td">
								<%="".equals(StringUtil.deNull(carManageWxbyBean.getSp_yj()))?"":carManageWxbyBean.getSp_yj()%>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<% }%>
			<!-- ���� -->
			<div class="content_02_box" id="parentdiv" >
				<div class="content_02_box_title_bg">
					<span>ά�ޱ�����Ϣ</span>
					<div class="content_02_box_add">
					
					</div>
				</div>
					<div class="content_02_box_div" id="trdiv" name="trdiv" style=" border-bottom:2px  solid  #ede7cd">
						  <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
								<tr>
									<th width="191" class="content_02_box_div_table_th">��&nbsp;&nbsp;&nbsp;&nbsp;�ͣ�</th>
									<td class="content_02_box_div_table_td" colspan="3">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getType()))?"":carManageWxbyBean.getType()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">��&nbsp;��&nbsp;�ţ�</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getCar_num()))?"":carManageWxbyBean.getCar_num()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">��&nbsp;��&nbsp;�ˣ�</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getJbr()))?"":carManageWxbyBean.getJbr()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">��&nbsp;��&nbsp;����</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getWxc()))?"":carManageWxbyBean.getWxc()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">��ϵ�绰��</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getMobile()))?"":carManageWxbyBean.getMobile()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">Ԥ�Ʒ��ã�</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getYjfy()))?"":carManageWxbyBean.getYjfy()%>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">ʵ�ʷ��ã�</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getSjfy()))?"0":carManageWxbyBean.getSjfy()%>
									</td>
								</tr>
								
								<tr>
									<th class="content_02_box_div_table_th">ά�ޱ������ڣ�</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getWxbyrq()))?"":carManageWxbyBean.getWxbyrq()%>
									</td>
								</tr>
								<tr>
									<% if(isSp!=null&&!"".equals(isSp)&&"2".equals(passCheck)){%>
									<th width="191" class="content_02_box_div_table_th">���������</th>
									<td class="content_02_box_div_table_td">
										<textarea id="spyj_nr" name="spyj_nr"></textarea>
									</td>
									<%} %>
								</tr>
								<tr style="height:70px">
									<th class="content_02_box_div_table_th">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</th>
									<td class="content_02_box_div_table_td">
										<%="".equals(StringUtil.deNull(carManageWxbyBean.getBz()))?"":carManageWxbyBean.getBz()%>
									</td>
								</tr>
							</table>
					</div>
					<a id="downloaddoc" style="display: none" href=""></a>
			</div>

			<!-- �������s -->
			</div>
			<div id="prints" style="display: none;">
			<table width="100%" border="1" class="content_02_box_div_table">
			  <tr>
			    <td colspan="4"><div align="center"><strong>����ά�ޱ���������</strong></div></td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��:</th>
			    <td width="20%"><%="".equals(StringUtil.deNull(carManageWxbyBean.getType()))?"":carManageWxbyBean.getType()%></td>
			    <th class="content_02_box_div_table_th">ά�ޱ�������:</th>
			    <td width="20%">
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getWxbyrq()))?"":carManageWxbyBean.getWxbyrq()%>
			    </td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">��&nbsp;&nbsp;��&nbsp;&nbsp;��:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getCar_num()))?"":carManageWxbyBean.getCar_num()%>
			    </td>
			    <th class="content_02_box_div_table_th">��&nbsp;&nbsp;��&nbsp;&nbsp;��:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getJbr()))?"":carManageWxbyBean.getJbr()%>
			    </td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">��&nbsp;&nbsp;��&nbsp;&nbsp;��:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getWxc()))?"":carManageWxbyBean.getWxc()%>
			    </td>
			    <th class="content_02_box_div_table_th">��ϵ�绰:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getMobile()))?"":carManageWxbyBean.getMobile()%>
			    </td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">Ԥ�Ʒ���:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getYjfy()))?"":carManageWxbyBean.getYjfy()%>
			    </td>
			    <th class="content_02_box_div_table_th">ʵ�ʷ���:</th>
			    <td>
			    <%="".equals(StringUtil.deNull(carManageWxbyBean.getSjfy()))?"":carManageWxbyBean.getSjfy()%>
			    </td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">�������:</th>
			    <td colspan="3">
			    	<textarea rows="5" style="width: 100%" ><%="".equals(StringUtil.deNull(carManageWxbyBean.getSp_yj()))?"":carManageWxbyBean.getSp_yj()%></textarea></td>
			  </tr>
			  <tr>
			    <th class="content_02_box_div_table_th">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע:</th>
			    <td colspan="3">
			    	<textarea rows="5" style="width: 100%"><%="".equals(StringUtil.deNull(carManageWxbyBean.getBz()))?"":carManageWxbyBean.getBz()%></textarea>
			    </td>
			  </tr>
			</table>
			
			</div>
	</form>

	<iframe name="hiddenFrame" id="hiddenFrame" width=0 height=0></iframe>
	 <!-- ���ô�ӡ���ֵ�����  -->
	<div style="display:none;font-size:12px;" id="_print">
	<div style="font-size:12px;" id="_print_html"></div>
	</div>

</body>
</html>