<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumeTypeBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.impl.OfficeConsumeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.OfficeConsumeServiceIfc"%>
<%@page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String ocname_id = request.getParameter("ocname_id");
	OfficeConsumeServiceIfc receivesetServiceIfc = new OfficeConsumeServiceImpl();
	OfficeConsumeTypeBean oetBean = new OfficeConsumeTypeBean();
	if (!StringUtil.isBlank(ocname_id)) {
		oetBean = receivesetServiceIfc
				.getOeBeanById(ocname_id);
	}
	
%>
<title>�����̶�ά��</title>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- ����jQuery UI -->
<!-- �������� -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- ����jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- ����formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
	});
/*
����:  Ok
˵��:  �ύ������޸����ĵ�λ
����:   ��
����ֵ: ��
*/
function Ok() {
	var paramjosn = "";
	if (IsSpace($("#ocname_id").val())) { //�޸�
		$("#action").val("add");
	} else {
		$("#action").val("update");
	}
	paramjosn = "{'ocname_id':'" + $("#ocname_id").val() + "','ocname_name':'" + $("#ocname_name").val() + "','ocname_remark':'" + $("#ocname_remark").val() + "','ocname_no':'"+$("#ocname_no").val()+"'}";
	$("#paramjosn").val(paramjosn);
	//if(myValidateNums()){
		$("#form1").submit();
	//}
}
function closed(){
	parent.JqueryDialog.Close();
}

/*
*����˵��:У�������
*��������
*����ֵ��true ���� false  true��У��ͨ��,false: У��ʧ��
*/
function myValidateNums(){
	var pattern = "^[0-9]*$"; //ֻ��������
	var value = $("#ocname_no").val(); //�����ֵ
	if(value.search(pattern)!=0 ){
		 alert("�����ֻ��������");
		return false;
		}   
	if (document.getElementById('ocname_no').value != ""
			&& document.getElementById('ocname_no').value <= 0) {
		alert("����ű������0��");
		return false;
	}
	return true;
}
</script>
</head>
<body style="overflow-y:hidden;">
	<form id="form1" action="addorupdateconsumablenamedo.jsp" method="post">
		<input type="hidden" name="ocname_id" id="ocname_id"
			value="<%=StringUtil.deNull(oetBean.getOcname_id())%>">
		<input type="hidden" name="paramjosn" id="paramjosn"> <input
			type="hidden" name="action" id="action">
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr>
					<td class="content_02_box_div_table_th"><font color="red">*</font>������ƣ�</td>
					<td class="content_02_box_div_table_td"><input type="text" name="ocname_name" id="ocname_name" class="validate[required,maxSize[20]] input_188" style="width:90%;height=23px" 
						value="<%=StringUtil.deNull(oetBean.getOcname_name())%>">
					</td>
					
				</tr>
				<tr>
					<td class="content_02_box_div_table_th"><font color="red">*</font>����ţ�</td>
					<td class="content_02_box_div_table_td">
					<input  style="width:90%;height=23px" type="text" id="ocname_no" name="ocname_no"  
					class="validate[required,maxSize[10],custom[positiveinteger]] input_188"
						value="<%=StringUtil.deNull(oetBean.getOcname_no()+"")%>">
					</td>
				</tr>
				<tr>
					<td class="content_02_box_div_table_th">��ע��</td>
					<td class="content_02_box_div_table_td"><input  style="width:90%;height=23px" type="text" name="ocname_remark" class="validate[maxSize[100]] input_188"
						id="ocname_remark"
						value="<%=StringUtil.deNull(oetBean.getOcname_remark())%>">
					</td>
				</tr>
			</table>
		</div>
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="�ر�" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="����" onclick="Ok()"/>
		</div>
	</form>
</body>
</html>