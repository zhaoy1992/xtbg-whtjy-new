<%--
�����������¼�������
���ߣ�����
�汾��1.0
���ڣ�2014-02-17
--%>
<%@page import="com.chinacreator.xtbg.tjy.review.service.ReviewInfoService"%>
<%@page import="com.chinacreator.xtbg.tjy.review.service.impl.ReviewInfoServiceImpl"%>
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
	
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//����ID
	String r_id = request.getParameter("r_id");
	
	//����ҵ��
	ReviewInfoService service = new ReviewInfoServiceImpl();
	if("insert".equals(actionName)){
		//ID
		bean.put("r_id","");
		//����λ
		bean.put("r_orgname","");
		//��������
		bean.put("r_content","");
		//����ר��
		bean.put("r_username", "");
		//��ǰϵͳʱ��
		bean.put("r_creatortime", DateUtil.getCurrentDateTime());
		//����ʱ��
		bean.put("r_reviewtime", "");
	
	} else {
		bean = service.getReviewInfoBean(r_id);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�����¼����</title>
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
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#r_reviewtime").focus();
		
		var ps = new Object();
		ps.name=jQuery("#r_username").val();
		ps.id=jQuery("#r_userid").val();
		createrDeptAndPosn(ps,"userTd", 'r_userid','r_username',false,false,false,true);
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
		jQuery("#hidden_action").val("addInfo");
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
����:  chooseReportUnits
˵��:  ѡ��ר�ҿ�������
����:   ��
����ֵ: ��
*/
var chooseReportUnits = function(){
	  var s = new $.z_tree_leftRigth();
	  s.treeID='button_envelop_username';
	  s.isShowSeacher="aa";
	  s.treeName="ѡȡ��Ա";
	  s.headerName="ѡȡ��Ա";
	  s.titelText = "ѡ����Ա";
	  s.rightHeaderText="����ӻ�������Ա";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
		  	{
			  	  $('#r_userid').val('');
			  	  $('#r_username').val('');
			 }else
			 {
				 $('#r_userid').val(orgObj.ps.id);
				  $('#r_username').val(orgObj.ps.name);
			}
		 
		  createrDeptAndPosn(orgObj.ps,"userTd",'r_userid','r_username',false,false,false,true);
	  }
	  s.treeList=
			  [{
				  leftHeaderText:'����Աѡ��',
				  valueKey:'ps',
				  selectedIds:$('#r_userid').val(),
				  type:'{"type":"tree_tjy_reviewinfo"}'
		}];
	  s.init();
	  

}
	
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="reviewRecodeInfodo.jsp" method="post"  >
		<input type="hidden" name="r_id" id="r_id" value="<%=StringUtil.deNull(bean.get("r_id"))%>">
		<input type="hidden" name="r_userid" id="r_userid" value="<%=StringUtil.deNull(bean.get("r_userid"))%>">
		<input type="hidden" name="r_creatortime" id="r_creatortime" value="<%=StringUtil.deNull(bean.get("r_creatortime"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div class="content_02_box_title_bg" style="width: 100%;">
				<span>�Ǽǻ�����Ϣ</span>
		</div>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th">���ʱ�䣺</th>
						<td class="content_02_box_div_table_td"><input type="text" name="r_creatortime" id="r_creatortime" class="validate[required,maxSize[50]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("r_creatortime"))%>" readonly="readonly">
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>����ʱ�䣺</td>
						<td class="content_02_box_div_table_td"><input type="text" name="r_reviewtime" id="r_reviewtime" 
						 class="validate[required,maxSize[100]] date_120 Wdate" style="height=23px" 
							value="<%=StringUtil.deNull(bean.get("r_reviewtime"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>����λ��</td>
						<td class="content_02_box_div_table_td"><input style="width:90%;height=23px" type="text" name="r_orgname" class="validate[required,maxSize[50]] input_188"
							id="r_orgname"
							value="<%=StringUtil.deNull(bean.get("r_orgname"))%>">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>�������ݣ�</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:85%;" rows="4" cols="7" name="r_content" class="validate[required,maxSize[500]]"
							id="r_content" ><%=StringUtil.deNull(bean.get("r_content"))%></textarea>
						</td>
					</tr>
				</table>
		</div>
		<!-- ��ᵥλ����Ա begin -->
		<div class="content_02_box_title_bg" style="width: 100%;margin-top: 8px;">
			<span>����ר����Ա</span>
			<div class="content_02_box_add show_content" style="cursor: hand">
				<input type="button" value="ѡ��" class="but_y_01" style="margin-right: 50px;" onclick="chooseReportUnits()" />
			</div>
		</div>
		<div class="content_02_box_div" style="width: 100%;">
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
				<tr>
					<td class="content_02_box_div_table_th"><font color="red">*</font>����ר����Ա�б�</td>
					<td class="content_02_box_div_table_td">
						<input type="hidden" id="r_username" name="r_username" value="<%=StringUtil.deNull(bean.get("r_username")) %>" />
						<textarea id="userTd" name= "userTd" style="width:85%;"  onclick='chooseReportUnits()' class="validate[required,maxSize[500]] textarea_575" cols="7" rows="4" readonly="readonly"></textarea>
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