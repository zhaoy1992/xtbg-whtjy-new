<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.AreaBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%><html>
<%
	AccessControl accesscontrol = AccessControl.getAccessControl();
	accesscontrol.checkAccess(request,response);
	String path = request.getContextPath();
	String orgname = accesscontrol.getChargeOrgName();
	String orgid = accesscontrol.getChargeOrgId();
	String username = accesscontrol.getUserName();
	String userid = accesscontrol.getUserID();
	ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
	ResourceRoleUserBean rruBean = resourceRoleConfigDao.queryUserMatchOrg(userid);
	String department =  "";
	String departmentid = "";
	if(!StringUtil.isBlank(rruBean.getOrgname())){
		 department = rruBean.getOrgname();
	}
	if(!StringUtil.isBlank(rruBean.getOrgid())){
		departmentid = rruBean.getOrgid();
	}
	String operwindowid = request.getParameter("operwindowid");
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String sql = "select i.infotype_id, i.infotype_name from ta_oa_infre_info_type i where i.infotype_source = '"+InfoSource.INFORMATION_COLLECTION+"'";
	String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id","","",false,"","width:188px");//��Ϣ����������
	String currentDbTime =new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
	//��ѯʹ�õĵ����������Ƿ���eweb��ʹ�ú�ͷ
	String CURSYSTEMCODE= CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	System.out.print(CURSYSTEMCODE);
	
%>
<head>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- ����formvValidatetion -->

<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- �������� -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- �����������ý��� -->
<script type="text/javascript">
jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
	if("430800"=="<%=CURSYSTEMCODE%>"){
	document.getElementById("eWebEditor1").contentWindow.setHTML(
			"<DIV style='WIDTH: 100%; '></DIV>"
			+"<P"
				+" style='TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: center; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: 'Times New Roman'; FONT-SIZE: 10.5pt "
				+" align=center>"
				+" <SPAN style='FONT-FAMILY: ����С����_GBK; COLOR: red; FONT-SIZE: 36pt'>"
					+"�żҽ���Ϣ"
					+" <SPAN>(</SPAN>"
					+"</SPAN>"
					+"<SPAN style='FONT-FAMILY: ����С����_GBK; COLOR: black; FONT-SIZE: 26pt'>ҵ����</SPAN>"
					+"<SPAN style='FONT-FAMILY: ����С����_GBK; COLOR: red; FONT-SIZE: 36pt'>)</SPAN>"
					+"<br/><br/><SPAN style='FONT-FAMILY: ����; COLOR: black; FONT-SIZE: 16pt'>��</SPAN>"
					+"	<SPAN style='COLOR: black; FONT-SIZE: 16pt'>10</SPAN>"
					+"	<SPAN style='FONT-FAMILY: ����; COLOR: black; FONT-SIZE: 16pt'>��</SPAN>"
					+"</P>"
					+"<P"
					+"	style='TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: center; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: 'Times New Roman'; FONT-SIZE: 10.5pt"
					+"	align=center>"
					+"	<SPAN style='FONT-FAMILY: ����; COLOR: black; FONT-SIZE: 16pt'></SPAN>"
					+"	<SPAN style='COLOR: black; FONT-SIZE: 16pt'>&nbsp;</SPAN>"
					+"</P>"
					+"<P "
					+"style='white-space: nowrap;TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: justify; LINE-HEIGHT: 25pt; MARGIN: 0cm 3.55pt 0pt 0cm; FONT-FAMILY: 'Times New Roman'; FONT-SIZE: '10.5pt';>"
					+"	<SPAN style='FONT-FAMILY: ����_GB2312; COLOR: black; FONT-SIZE: 16pt;margin-left: 1%'>�й��żҽ���ί�칫��</SPAN>"
					+"<SPAN style='COLOR: black; FONT-SIZE: 15pt'> </SPAN>"
				+"<SPAN style='COLOR: black; FONT-SIZE: 16pt'>"
				+"<SPAN>&nbsp;</SPAN>"
				+"</SPAN>"
				+"<SPAN style='COLOR: black; FONT-SIZE: 15pt'>"
				+"<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN>"
				+"</SPAN>"
				+"<SPAN style='FONT-FAMILY: ����_GB2312; COLOR: black; FONT-SIZE: 16pt;margin-left: 28% ;' >2012 �� 7 �� 13 ��</SPAN>"
				+"</P>"
				+"<P "
				+"style='TEXT-JUSTIFY: inter-ideograph; text-align: center; LINE-HEIGHT: 25pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: 'Times New Roman'; FONT-SIZE: '10.5pt' "
				+">"
				+"<SPAN style='COLOR: black; FONT-SIZE: 14pt'>"
				+"<div style='border-bottom:solid 2px #F00;'></div>"
				+"</SPAN>"
				+"</P><br/><p></p>" );
	}
});

	var saveInfo = function (){
// 		if(IsSpace($('#submittedinfo_title').val())){
// 			alert("���ⲻ��Ϊ��");
// 			return false;
// 		}
// 		if(IsSpace($('#reportuser_name').val())){
// 			alert("�ϱ������˲���Ϊ��");
// 			return false;
// 		}
		if(validateForm()){
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_TEMPORARY%>");
			$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.HAS_BE_TEMPORARY%>");
			$("#submittedinfo_typecode2delete").val("<%=InfoType.HAS_BE_TEMPORARY%>");
			var url = "infoinputdetailsaveform.jsp?tablepage=1";
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();
		}
		
	}

	function validateForm(){
		var str = eWebEditor1.getHTML();
		if(jQuery("#form1").validationEngine("validateform")){
		
		$('#submit_content').val(str);
		if(IsSpace($('#submit_content').val())){
			alert("���ݲ���Ϊ��");
			return false;
		}
		
		return true;
	}
	}
	
	function reportInfo(){
		$('#reportuser_name').addClass("validate[required]");
		if(validateForm()){
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_REPORTED%>");
			$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH%>");
			$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH%>");
			 var okF = function(){
					var url = "infoinputdetailsaveform.jsp?tablepage=2";
					document.all.form1.action = url;
					document.all.form1.target = "hiddenFrame";
					$('#form1').submit();
					}
					 var p={
						headerText:'��ʾ',
						okName:'ȷ��',
					    okFunction:okF,
					    cancelName:'ȡ��'
					};
				alert('ȷ��Ҫ�ϱ���',p);
		}
	}

	var chooseReportUnits = function(){
		//�ؼ�Ժ  ѡ����Ա�޸�Ϊ��ѡ start
		var s = new $.z_tree();
		  s.treeID='mian';
		  s.treetypestr="radio";
		  s.ischekc="false";
		  s.isShowSeacher=true;
		  s.treeName="ѡȡ��Ա";
		  s.headerName="ѡȡ��Ա";
		  s.type="{'type':'1'}";
		  s.selectedIds=$('#reportunits').val();
		  s.returnFunction=function(orgObj){
			 $('#reportunits').val(orgObj.id);
		  	 $('#reportuser_name').val(orgObj.name);
		  }
	  	 s.init();
		  /* var s = new $.z_tree();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="ѡȡ��Ա";
		  s.headerName="ѡȡ��Ա";
		  s.titelText = "ѡ����Ա";
		  s.rightHeaderText="����ӻ�������Ա";
		  s.returnFunction=function(orgObj){
			  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
			  	{
				  	  $('#reportunits').val('');
				  	  $('#reportuser_name').val('');
				 }else
				 {
					 $('#reportunits').val(orgObj.ps.id);
					  $('#reportuser_name').val(orgObj.ps.name);
					}
			 
		  }
		  s.treeList=
				  [{
					  leftHeaderText:'����Աѡ��',
					  valueKey:'ps',
					  selectedIds:$('#reportunits').val(),
					  type:'{"type":"1"}'
			}];
		  s.init(); */
		  
		  //�ؼ�Ժ ѡ����Ա��Ϊ��ѡ end
	  
	}
	
	function backTo(){
		var okF = function(){
			removeWindows('<%=operwindowid%>',true);
			}
			 var p={
					headerText:'��ʾ',
					okName:'ȷ��',
			        okFunction:okF,
			        cancelName:'ȡ��'
			};
			
		alert('���ظ�ҳ,δ�������Ϣ���ᶪʧ '+'<br>'+'ȷ�����أ�',p);
		
		}	
	/* ����ɹ��󷵻ط���-��ҳ����� */
	function saveBack(){
		removeWindows('<%=operwindowid%>',true);
	}
	function chooseManage(){
		var eWebEditValue=eWebEditor1.getHTML();
		openAlertWindows('windowId','../../publicjsp/jsp/publicPhoneLook.jsp','�ֻ�Ԥ��','402','500','20%');
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>��Ϣ¼����ϸҳ��</title>

</head>
<body onload="adaptationWH('_top','vcenter',50)" style="overflow-y:hidden;">
<form action="" id="form1" name="form1" method="post">
<div  class="content_02" style="overflow:hidden;">
	
			<div class="content_02_top" id="_top">
				<input class="but_y_01" type="button" name="operation" value="��ݸ�" onclick="saveInfo()" id="saveinfo"/>
				<input class="but_y_01" type="button" name="operation" value="�ϱ�" onclick="reportInfo()" id="reportinfo"/>
				<input class="but_y_01" type="button" name="operation" value="����" onclick="backTo()" id="backto"/>
				<input type="hidden" name="submittedinfo_typecode" id ="submittedinfo_typecode"/>
				<input type="hidden" name="submittedinfo_typecode4getinfouser" id="submittedinfo_typecode4getinfouser"/>
				<input type="hidden" name="submittedinfo_typecode2delete" id="submittedinfo_typecode2delete"/>
				<input type="hidden" name="relese_time" id="relese_time" value="<%=currentDbTime%>"/>
			</div>
	<div  id="vcenter" style="float:left; width:100%; overflow:scroll;overflow-x:hidden;" scrolling="yes">
	<div style="float: left; width: 775px; ">
		 <div class="content_02_box" >
		 <div class="content_02_box_title_bg"><span>������Ϣ</span></div>
		 <div class="content_02_box_div">
				<table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" >
				 <tr>
		           	   <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>���⣺</th>
			           <td class="content_02_box_div_table_td">
			           <input type="text" name="submittedinfo_title" id="submittedinfo_title" class="validate[required,maxSize[100]] input_185"/>
			           </td>
			           <th class="content_02_box_div_table_th">��Ϣ���ͣ�</th>
			           <td class="content_02_box_div_table_td">
			                <%=infotypeHtml%>
			          </td>
		         </tr>
				   <tr>
			           <th class="content_02_box_div_table_th">¼�벿�ţ�</th>
			           <td class="content_02_box_div_table_td">
			           <input class="input_185" readonly="readonly" type="text" value="<%=department %>" id="department" name="department"></input>
			           <input type="hidden"  name="departmentid" id="departmentid" value="<%=departmentid %>">
					   <input type="hidden"  name="orgid" id="orgid" value="<%=orgid %>">
			           </td>
			           <th class="content_02_box_div_table_th">¼���ߣ�</th>
			           <td class="content_02_box_div_table_td">
			           <input class="input_185" readonly="readonly" type="text" value="<%=username %>" id="inputuser_name" name="inputuser_name"></input>
							<input type="hidden"  name="inputuser_id" id="inputuser_id" value="<%=userid %>">
			           </td>
		         </tr>
				 <tr>
				           <th class="content_02_box_div_table_th">�ؼ��֣�</th>
				           <td class="content_02_box_div_table_td">
				           <input class="validate[maxSize[50]] input_185"  type="text" id="keyword" name="keyword"></input>
				           
				           </td>
				           <th class="content_02_box_div_table_th">¼��ʱ�䣺</th>
				           <td class="content_02_box_div_table_td">
				           <input class="input_185" readonly="readonly" type="text" id="input_date" value="<%=currentDbTime %>">
				           </td>
		        </tr>
				
				 <tr>
				           <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>�ϱ������ˣ�</th>
				           <td class="content_02_box_div_table_td">
				           <INPUT class="validate[required] input_160" onmouseover="this.title=this.value"
							 id="reportuser_name" name="reportuser_name" 
							value=""
							readOnly  onclick='chooseReportUnits()'>
							 <input name="" type="button" value="" class="but_x" onclick="chooseReportUnits()"/>
					  		<input type="hidden" id=reportunits name="reportunits"/>
				           </td>
				          
		         </tr>
		         
				
				</table>
			</div>
			</div>
			 <div class="content_02_box" >
			 <div class="content_02_box_title_bg"><span>����</span>
			 <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 			</span>
	 		 <!-- <span class="color_red">��ע��Ϊ�淶���������������ĸ�ʽ����ʹ�����������ʽ���б༭��</span>  -->
	 		 <span class="color_red">��ʾ������ֱ��ճ��word��excel���</span>
			 </div>
			 
			 <div class="content_02_box_div">	
					<table border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
									<tr>
										<td>
										<textarea id=edit_content_phone name="edit_content_phone" rows="1" cols="1" style="DISPLAY: none;" ></textarea>
										<textarea  id=submit_content name="submit_content" rows="1" cols="1" style="DISPLAY: none;"></textarea>
										<iframe id="eWebEditor1" src="../../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=submit_content&style=gray" frameborder="0" scrolling="no" width="100%" height="350"></iframe> 
										</td>
									</tr>
									
					</table>
			</div>
			</div>
	</div>
</div>
</form>
</div>
<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>

</html>