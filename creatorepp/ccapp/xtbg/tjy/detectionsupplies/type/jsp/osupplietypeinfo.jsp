<%--
�������칫��Ʒ����ά������
���ߣ�����
�汾��1.0
���ڣ�2014-02-17
--%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.OsupplieTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OsupplieTypeServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	 //��õ�ǰ��¼���û���Ϣ
    String userId = accesscontroler.getUserID();
    String userName = accesscontroler.getUserName();
    //��õ�ǰ��¼�û�������λ��Ϣ
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    String unit_id = usercachebean.getUnit_id();
    String unit_name = usercachebean.getUnit_name();
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//״̬ 1:��ʾ�豸 2.��ʾ�׺�Ʒ
	String oftype_flag = request.getParameter("oftype_flag");
	//����ID
	String oftype_id = request.getParameter("oftype_id");
	
	//����ҵ��
	OsupplieTypeService serviceType = new OsupplieTypeServiceImpl();
	if("insert".equals(actionName)){
		//��������ID
		bean.put("oftype_id","");
		//������������
		bean.put("oftype_name","");
		//��������˵��
		bean.put("oftype_remark","");
		//���������
		bean.put("oftype_no", "");
		//״̬ 1:��ʾ�豸 2.��ʾ�׺�Ʒ
		bean.put("oftype_flag", oftype_flag);
		//������λ 
		bean.put("unit_id", unit_id);
		bean.put("unit_name", unit_name);
	} else {
		bean = serviceType.getOsupplieTypeBean(oftype_id,oftype_flag);
		//��������ID
		bean.put("oftype_id",bean.get("oftype_id"));
		//������������
		bean.put("oftype_name", bean.get("oftype_name"));
		//��������˵��
		bean.put("oftype_remark", bean.get("oftype_remark"));
		//���������
		bean.put("oftype_no", bean.get("oftype_no"));
		//״̬ 1:��ʾ�豸 2.��ʾ�׺�Ʒ
		bean.put("oftype_flag", oftype_flag);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�����̶�ά��</title>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- ����jQuery UI -->
<!-- �������� -->
<script src="../../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- ����jQuery_dialog -->
<script src="../../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- ���빫��JS -->
<!-- ����formvValidatetion -->
<script src="../../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#oftype_name").focus();
	});
/*
����:  Ok
˵��:  �ύ������޸����ĵ�λ
����:   ��
����ֵ: ��
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //�Ƿ�ȫ����֤ͨ��
	if (isFlag){
		jQuery("#hidden_action").val("addOsupplieTypeInfo");
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
					getParentWindow("windowId").userSearch();
					removeAlertWindows("windowId",true);
			} else {
				alert(result);
				getParentWindow("windowId").userSearch();
				removeAlertWindows("windowId",true);
			}
			
		}
	}catch(e){alert(e.description);}
};
function closed(){
	removeWindows('',true);
}

/*
*����˵��:У�������
*��������
*����ֵ��true ���� false  true��У��ͨ��,false: У��ʧ��
*/
function myValidateNums(){
	var pattern = "^[0-9]*$"; //ֻ��������
	var value = $("#oetype_no").val(); //�����ֵ
	if(value.search(pattern)!=0 ){
		 alert("�����ֻ��������");
		return false;
		}   
	if (document.getElementById('oetype_no').value != ""
			&& document.getElementById('oetype_no').value <= 0) {
		alert("����ű������0��");
		return false;
	}
	return true;
}
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="osupplietypeinfodo.jsp" method="post"  >
		<input type="hidden" name="oftype_id" id="oftype_id" value="<%=StringUtil.deNull(bean.get("oftype_id"))%>">
		<input type="hidden" name="oftype_flag" id="oftype_flag" value='<%=StringUtil.deNull(bean.get("oftype_flag"))%>'/>
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>������ƣ�</th>
						<td class="content_02_box_div_table_td"><input type="text" name="oftype_name" id="oftype_name" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("oftype_name"))%>">
						</td>
						
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">������λ���ƣ�</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="unit_name" id="unit_name" readonly="readonly"
						  		class="input_188" style="width:90%;height=23px"	value="<%=StringUtil.deNull(bean.get("unit_name"))%>">
							<input type="hidden" id="unit_id" name="unit_id" value="<%=StringUtil.deNull(bean.get("unit_id"))%>"/> 
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>����ţ�</td>
						<td class="content_02_box_div_table_td"><input type="text" name="oftype_no" id="oftype_no" 
						 class="validate[required,maxSize[10],custom[positiveinteger]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("oftype_no"))%>">
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">��ע��</td>
						<td class="content_02_box_div_table_td"><input style="width:90%;height=23px" type="text" name="oftype_remark" class="validate[maxSize[200]] input_188"
							id="oftype_remark"
							value="<%=StringUtil.deNull(bean.get("oftype_remark"))%>">
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="�ر�" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="����" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>