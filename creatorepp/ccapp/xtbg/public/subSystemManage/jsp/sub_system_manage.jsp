<%--
�������ⲿ��ϵͳ������ҳ��
���ߣ�����
�汾��1.0
���ڣ�2013-4-28
--%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.util.*"%>
<%@page import="java.util.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@page import="com.chinacreator.xtbg.pub.subSystemManage.dao.SubSystemManageDao"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();
	String orgid="";
	String orgname="";
	String creatorid=accesscontroler.getUserID();
	String creator=accesscontroler.getUserName();
	String username="";
	String paramjosns = "";

	String sys_id = request.getParameter("sys_id");//�ⲿ��ϵͳ��������id
	String status=request.getParameter("status");//��ø���ϵͳ������״̬
	String listtype = request.getParameter("listtype");//�б����
	String currentDateTime1 = new Date().getTime()+"";

	String subid=request.getParameter("subid");
	
	SubSystemManageDao subSystemManageDao = (SubSystemManageDao)DaoImplClassUtil.getDaoImplClass("subSystemManageDao");
	Map<String,String> viewMap = subSystemManageDao.findSubSystemInfo(sys_id);
	
%>
<title>JGRID</title>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script> 
<!-- ����jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- ����formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- �������� -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- �����������ý��� -->
<script type="text/javascript">
var sys_id = "<%=sys_id%>";
var listtype = "<%=listtype%>";

jQuery(document).ready(function() {

	
});


/*
����:  Ok
˵��:  �ύ������޸�(��������)
����:   ��
����ֵ: ��
*/
var Ok = function() {
	saveForm();
}


var saveForm = function(){
	var isFlag = jQuery('#form1').validationEngine('validate'); //�Ƿ�ȫ����֤ͨ��
	jQuery("#action_now").val("save");

	if(isFlag){
		var okF = function(){ 
			var url= "subsys_addorupdatedo.jsp?subid=<%=subid%>";
	 
		  	document.all.form1.action=url;
			document.all.form1.target = "hiddenFrame";
			jQuery("#form1").submit();
		}
		var p={
				headerText:'��ʾ',
				okName:'ȷ��',
		        okFunction:okF,
		        cancelName:'ȡ��'
		};
	alert('ȷ���������Ϣ�� ',p)
	}
}

/*
����:  sucessBackFun
˵��:  ���̨������ĳɹ��ص�����
����:   ��
����ֵ: ��
*/
var sucessBackFun = function(obj){
	var action = obj.action;
	closed("");
}


//����
function closed(state){
	if(state == ""){
		removeWindows('<%=subid%>',true);
	}else{
		var okF = function(){
			removeWindows('<%=subid%>',true);
			}
			 var p={
					headerText:'��ʾ',
					okName:'ȷ��',
			        okFunction:okF,
			        cancelName:'ȡ��'
			};
			 alert('���ظ�ҳ,δ�������Ϣ���ᶪʧ '+'<br>'+'ȷ�����أ�',p);
	}
}	


//�Ƿ��Ի������巢��
function doorg(obj){
	jQuery("input[name='checkorg']").attr('checked',false);
    jQuery(obj).attr('checked',true);
}
</script>
</head>
<body style="overflow-y:hidden;" onload="adaptationWH('_top','vcenter',85)">
	<form id="form1" action="" method="post" onkeydown="if(event.keyCode == 13){return false;}">
		<input type="hidden" name="sys_id" id="sys_id" value="<%=viewMap.get("sys_id") %>"/> 
		<input type="hidden" name="action_now" id="action_now" /> 
		<!-- tableҳ����ת -->
		<input type ="hidden" id ="tablepage" name ="tablepage"/>
<div  class="content_02" style="overflow:hidden;" id="_top">
   <!-- ����-->
  <div class="content_02_top" style="margin-bottom:10px;" >
   <input name="cgbt" id="cgbt" value="����" style="display: inline;" onclick="Ok();" type="button" class="but_y_01" />
   <input name="" value="����" onclick="closed('')" type="button" class="but_y_01" />
	</div>  
	 </div>
	<!-- ���-->
	<div id="vcenter" style="float:left; width:100%; overflow:scroll" scrolling="yes">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>������Ϣ</span></div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
         <tr>
           <th width="191" class="content_02_box_div_table_th"><span class="color_red">*</span>��ϵͳ���ƣ�</th>
           <td class="content_02_box_div_table_td" colspan="3"><input type="text"  class="validate[required,maxSize[100]] input_title_text" name="sys_name" id="sys_name" value="<%=viewMap.get("sys_name")%>"/></td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th">��ϵͳ������</th>
           <td class="content_02_box_div_table_td" colspan="3"><input type="text"  class="validate[maxSize[500]] input_title_text" name="sys_desc" id="sys_desc" value="<%=viewMap.get("sys_desc")%>"/></td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th"><span class="color_red">*</span>��ϵͳ����·����</th>
           <td class="content_02_box_div_table_td" colspan="3"><input type="text"  class="validate[required,maxSize[1000]] input_title_text" name="sys_url" id="sys_url" value="<%=viewMap.get("sys_url")%>"/></td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th">��ϵͳͼƬ·����</th>
           <td class="content_02_box_div_table_td" colspan="3"><input type="text"  class="validate[maxSize[1000]] input_title_text" name="sys_img_url" id="sys_img_url" value="<%=viewMap.get("sys_img_url")%>"/></td>
         </tr> 
</table>
	 </div>
	</div>

	</div></div>
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>