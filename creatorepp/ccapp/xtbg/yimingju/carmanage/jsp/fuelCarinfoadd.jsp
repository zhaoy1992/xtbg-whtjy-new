<%--
�������ؼ�Ժ�Ϳ��Ǽǽ���
���ߣ�����
�汾��1.0
���ڣ�2014-03-26
--%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.FuelCardmangeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.FuelCardmangeService"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	Map<String,String> beanCarInfo = new HashMap<String,String>();
	Map<String,String> bean = new HashMap<String,String>();
	String actionName = request.getParameter("actionName");
	//����ID
	String car_id = request.getParameter("car_id");
	//����ID
	String fuelcard_id = request.getParameter("fuelcard_id");
	//��¼����
	String fuelcard_type = StringUtil.deNull(request.getParameter("fuelcard_type"));
	
	//����ҵ��
	FuelCardmangeService service = new FuelCardmangeServiceImpl();
	String fuelcard_sum = "";//�Ϳ����
	if("insert".equals(actionName)){
		beanCarInfo = service.getFuelcardInfo(car_id);
		fuelcard_sum = beanCarInfo.get("fuelcard_sum");
	} else {
		
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ӧ���Ϳ��Ǽǽ���</title>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- ����jQuery UI -->
<!-- �������� -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- ����jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- ���빫��JS -->
<!-- ����formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
var fuelcard_type = "<%=fuelcard_type%>";//��¼����
var fuelcard_sum = "<%=fuelcard_sum%>";
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#fuelcard_money").focus();
		//�Ǽ�����
		if(fuelcard_type=="0"){
			jQuery("#moneyName").html("���ͽ��");
		} else if(fuelcard_type=="1"){
			jQuery("#moneyName").html("��ֵ��� ");
		} else {
			jQuery("#moneyName").html("��� ");
		}
		
	});
/*
����:  Ok
˵��:  �ύ������޸����ĵ�λ
����:   ��
����ֵ: ��
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //�Ƿ�ȫ����֤ͨ��
	var fuelcard_type = jQuery("#fuelcard_type").val();//��¼����
	var fuelcard_money = jQuery("#fuelcard_money").val();//���
	//����
	if(fuelcard_type == "0"){
		var result = parseFloat(fuelcard_sum).toFixed(2) - parseFloat(fuelcard_money).toFixed(2);
		if(result<0){
			alert("�Ϳ������޷��ǼǼ��ͣ�����");
			return false;
		}
	}
	if (isFlag){
		jQuery("#hidden_action").val("addfuelCarinfo");
		jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
	}
}
afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					getParentWindow("windowId").parent.location.reload();
					removeAlertWindows("windowId",true);
			} else {
				alert(result);
				getParentWindow("windowId").parent.location.reload();
				removeAlertWindows("windowId",true);
			}
			
		}
	}catch(e){alert(e.description);}
};
function closed(){
	removeWindows('',true);
}
	
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="fuelCarinfodo.jsp" method="post"  >
		<input type="hidden" name="fuelcard_id" id="fuelcard_id" value="<%=StringUtil.deNull(bean.get("fuelcard_id"))%>">
		<input type="hidden" name="card_id" id="card_id" value="<%=StringUtil.deNull(car_id)%>">
		<input type="hidden" name="fuelcard_type" id="fuelcard_type" value="<%=StringUtil.deNull(fuelcard_type)%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font><span id="moneyName"></span>��</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="fuelcard_money" id="fuelcard_money"  class="validate[required,maxSize[100],custom[number]] input_cx_title_188" 
								value="<%=StringUtil.deNull(bean.get("fuelcard_money"))%>" >
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>�Ǽ�ʱ�䣺</td>
						<td class="content_02_box_div_table_td">
							<input  type="text" name="fuelcard_time" class="validate[required] date_120 Wdate" 
							id="fuelcard_time" value="<%=StringUtil.deNull(bean.get("fuelcard_time"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">��ע��</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:90%;" rows="6" cols="5" name="fuelcard_remark" class="validate[required,maxSize[250]]"
								id="fuelcard_remark" ><%=StringUtil.deNull(bean.get("fuelcard_remark"))%></textarea>
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="����" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="���" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>