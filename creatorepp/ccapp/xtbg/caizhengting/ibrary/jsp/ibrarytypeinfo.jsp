<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryTreeBean"%>
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryTreeService"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryTreeServiceImpl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.UUID"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.net.URLDecoder"%>
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
	
	String actiontype = ""; //��������
	String subid= request.getParameter("subid");
	String parentId = StringUtil.deNull(request.getParameter("parentId")); //���ڵ�ID
	String id = StringUtil.deNull(request.getParameter("id")); //����ID
	String tree_type_no = StringUtil.deNull(request.getParameter("tree_type_no")); //������
	String parentname =  URLDecoder.decode(StringUtil.deNull(request.getParameter("parentname")),"UTF-8"); //�ϼ�����
	String btnhidden = StringUtil.deNull(request.getParameter("btnhidden")); //�����м�������Ͳ� =true ���ذ�ť
	IbraryTreeService service = new IbraryTreeServiceImpl();
	
	IbraryTreeBean bean = new IbraryTreeBean();
	String type_no=""; //���ڴ���
	if(!StringUtil.nullOrBlank(id)){
		bean = service.getbeanbyid(id);
		bean.setUnit_id(unit_id);
		bean.setUnit_name(unit_name);
		if("2".equals(bean.getTree_type_no()))
		{
			bean.setTree_type_no("��ײ�");
		}else if("1".equals(bean.getTree_type_no())){
			bean.setTree_type_no("�м��");
		}
		actiontype="update";
	}else{
		//ȡ����������
		String codeno = service.getCodeNo(parentId,tree_type_no);
		bean.setTree_parent_id(parentname); //��ʼ���ϼ�����
		bean.setOrder_no(codeno);
		bean.setUnit_id(unit_id);
		bean.setUnit_name(unit_name);
		if("2".equals(tree_type_no))
		{
			bean.setTree_type_no("��ײ�");
			type_no="2";
		}else if("1".equals(tree_type_no)){
			bean.setTree_type_no("�м��");
			type_no="1";
		}
		id = UUID.randomUUID().toString();
		actiontype="insert";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- ����jQuery -->
	<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">jQuery.noConflict();</script>
	<!-- ����jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- ����formvValidatetion -->
	<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- �������� -->
	<script type="text/javascript" src="../../../resources/js/util/public.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/js/util/jsonutil.js" ></script>
	<script src="../resources/agreementtypevo.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
var actiontype = '<%=actiontype%>';
var  deltype = function(id){
	var okF = function(){
		var fm = document.getElementById("onlyFrom");
		fm.target = "hiddenFrame";
		fm.submit();
	}
	var p={
			headerText:'��ʾ',
			okName:'ȷ��',
		    okFunction:okF,
		    cancelName:'ȡ��'
		};
	alert('ȷ��Ҫɾ����',p)
}

var savebean = function(){
	if(jQuery("#form1").validationEngine("validateform")){
		jQuery("#form1").submit();
	}
}

function btnClickFn(btnObj){
	flag = btnObj.name;
	var tree_type;
	var parentname = '<%=parentname%>';
	var parentId = '<%=parentId%>';
	var tree_type_no ='<%=tree_type_no%>'; 
	if(flag=="AddTwo"){
		tree_type = "1"; 
	}else if(flag=="AddThree"){
		tree_type = "2"; 
	}
	openWindows('treetypeadd','������Ϣ����','../../../caizhengting/ibrary/jsp/ibrarytypeinfo.jsp?subid=treetypeadd&tree_type_no='+tree_type+'&btnhidden=true&parentname='+encodeURI(encodeURI(parentname))+'&parentId=<%=id%>','treetypeadd',false,window);
}


/* ���� */
function backTo(){
	
	var okF = function(){
		removeWindows('<%=subid%>',true);
		//window.parent.parent.location.href="ibrarytypeindex.jsp";
		}
		 var p={
			headerText:'��ʾ',
			okName:'ȷ��',
		    okFunction:okF,
		    cancelName:'ȡ��'
		};
	alert('���ظ�ҳ,δ�������Ϣ���ᶪʧ '+'<br>'+'ȷ�����أ�',p);
}
</script>
</head>
<body style="overflow-x:hidden;overflow-y:hidden;">
<div id="tabs1" style="width:98%">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;" id="divA">
		<input type="button" class="but_y_01" value="����" onclick="savebean();" id="btn_insert"/>
		
		<%if(!"true".equals(btnhidden)){ %>
		<%if("1".equals(type_no) ||"�м��".equals(bean.getTree_type_no())){ %>
		<input name="AddTwo" value="�����м�����" type="button" onclick="btnClickFn(this)" class="but_y_06" style="width:100px;border:1px solid  #dfc07f ;" onmouseover="javascript:jQuery(this).attr('class','but_y_07')" onmouseout="javascript:jQuery(this).attr('class','but_y_06')"/><span style="width:5px;display:block;float:left;">&nbsp;</span>
		<input name="AddThree" value="������Ͳ����" type="button" onclick="btnClickFn(this)" class="but_y_06" style="width:100px;border:1px solid  #dfc07f ;" onmouseover="javascript:jQuery(this).attr('class','but_y_07')" onmouseout="javascript:jQuery(this).attr('class','but_y_06')"/><span style="width:5px;display:block;float:left;">&nbsp;</span>
		<%}else{%>
		<input type="button" class="but_y_01" value="ɾ��" onclick="deltype('<%=id%>');" id="btn_update"/>
		<%}}%>
		<input type="button" class="but_y_01" value="����" onclick="backTo();"/>
</div>
<%--button list--%>
<table>
	<tr>
		<td width="100%" align="left" valign="top">
<%--main table begin--%>
<form id="form1" name="form1" method="post" target="hiddenFrame" action="ibrarytypeinfoDo.jsp?actiontype=<%=actiontype%>">
<input type='hidden' name='tree_id' id="tree_id" value="<%=id%>"/>
<input type="hidden" name="unit_name" id="unit_name" value='<%=StringUtil.deNull(bean.getUnit_name())%>'/>
<input type="hidden" name="unit_id" id="unit_id" value='<%=StringUtil.deNull(bean.getUnit_id())%>'/>
<div id="vcenter" style="float:left;width:100%; overflow:hidden">
	<div class="content_02_box" >
		<div class="content_02_box_title_bg"><span>ͼ�������Ϣ</span></div>
		<div class="content_02_box_div">
			<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th">ͼ�����:<span style="color: red;">*</span>��</th>
					<td class="content_02_box_div_table_td"  colspan="3">
						<input type="text" class="validate[required,maxSize[100]] input_188" name="tree_name" id="tree_name" value="<%=StringUtil.deNull(bean.getTree_name())%>">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">�����ϼ�����:</th>
					<td class="content_02_box_div_table_td">
						<input type="text" class="input_188" name="tree_parent_name" readonly="readonly" id="tree_parent_name" value="<%=StringUtil.deNull(bean.getTree_parent_id())%>">
						<input type="hidden" class="input_188" name="tree_parent_id" readonly="readonly" id="tree_parent_id" value="<%=parentId%>">
					</td>
					<th class="content_02_box_div_table_th">�������:<span style="color: red;">*</span>��</th>
					<td class="content_02_box_div_table_td" >
						<input type="text" class="validate[required,maxSize[20]] input_188" name="tree_type_code" id="tree_type_code" value="<%=StringUtil.deNull(bean.getTree_type_code())%>">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">�����:<span style="color: red;">*</span>��</th>
					<td class="content_02_box_div_table_td">
						<input type="text" class="validate[required,maxSize[20],custom[integer]] input_188" name="order_no" id="order_no" value="<%=StringUtil.deNull(bean.getOrder_no())%>">
					</td>
					<th class="content_02_box_div_table_th">���༶��:<span style="color: red;">*</span>��</th>
					<td class="content_02_box_div_table_td">
						<input type="text" readonly="readonly" class="validate[required,maxSize[20]] input_188" id="tree_type_name" name="tree_type_name" value="<%=StringUtil.deNull(bean.getTree_type_no())%>">
						<input type="hidden" readonly="readonly" name=tree_type_no id="tree_type_no" class="input_188" value="<%=type_no%>">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">��ע��</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea style="height: 80px; overflow: auto;" class="input_title_text" name="remark" id="remark"><%=StringUtil.deNull(bean.getRemark())%></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</form>
<%--main table end--%>
<script>
<%--1024*�ֱ�������Ч--%>
if(jQuery("#vcenter").width()>jQuery("#divA").width()){
	jQuery("#divA").width(jQuery("#vcenter").width()+10);
}
</script>
		</td>
	</tr>
</table>
</div>
<form id="onlyFrom" name="onlyFrom" method="post" action="ibrarytypeinfoDo.jsp" target="hiddenFrame">
	<input type='hidden' name='tree_id' id="tree_id" value="<%=id%>"/>
	<input type='hidden' name='actiontype' id='actiontype' value="del"/>
	<input type='hidden' name='type' id='type' value="booktype"/>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
<script type="text/javascript">
jQuery(function(){
	jQuery("#formTable").validationEngine();
});
</script>