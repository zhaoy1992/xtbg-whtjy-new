<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectDaoImpl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.BriefsTypeBean"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectResetDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean"%>
<%@page import ="java.text.SimpleDateFormat"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);

String userid = accesscontroler.getUserID();
String username = accesscontroler.getUserName();
String currenttimeTemp= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
ElectInfoBean electInfoBean = new ElectInfoBean();
electInfoBean.setDatetime(currenttimeTemp);
electInfoBean.setUserid(userid);
ElectInfoBean electInfoBean1 = new ElectInfoBean();
boolean sucess = false;//�Ƿ��Ѿ�����
boolean flowFlag = false;//��ѯ��������� �Ƿ������ڡ��������롿��ٽ������� ���ڻ���ڵ�ǰϵͳ����
ElectInfoDao electInfoDao = (ElectInfoDao)DaoImplClassUtil.getDaoImplClass("electInfoDaoImpls");
//�����ݼ�����δ���٣��뽫������ٵ����뵥�����ٵǼǡ�
flowFlag = electInfoDao.queryflowleave(username);
if(flowFlag==false){
	boolean flag = electInfoDao.findButtonState(currenttimeTemp,userid);//�жϵ��ӿ��ڿ��ư�ť���Ƿ�������,���Ϊtrue,˵���Ѳ�������
	if(flag){
		electInfoBean1 = electInfoDao.isAddOrUpdate(electInfoBean);//��ѯ��ǰ���ڵĿ��ڻ�����Ϣ
		if(!StringUtil.nullOrBlank(electInfoBean1.getStart_time())){//��������ϰ�ʱ�䲻Ϊ��
			electInfoDao.updateButtonState(userid, "1", "0");//�û��ϰఴť
		}
		if(!StringUtil.nullOrBlank(electInfoBean1.getEnd_time())){//����°�ʱ�䲻Ϊ��	
			electInfoDao.updateButtonState(userid,"1","1");
			sucess = true;//�Ѿ��������
		}
	} else {
		electInfoDao.addButtonState(currenttimeTemp, userid);//�����ӿ��ڿ��ư�ť���������
	}
}


String ip = request.getHeader("x-forwarded-for");
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
   ip = request.getHeader("Proxy-Client-IP");
}
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
   ip = request.getHeader("WL-Proxy-Client-IP");
}
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
   ip = request.getRemoteAddr();
} 

String rest_time="";
String currenttime= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
ElectResetDao poeManagerDao = (ElectResetDao)DaoImplClassUtil.getDaoImplClass("electResetDaoImpls");
ElectDaoImpl dao = new ElectDaoImpl();
ElectResetBean electresetBean = dao.querySetRecord(userid);//�����Ϣʱ��ֵ
if("1".equals(electresetBean.getReset_time())){
	rest_time="1";
}
else{
	rest_time="2";
}
String worktime=  new SimpleDateFormat("HH:mm").format(new Date());
%>
<title>����ά��</title>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- ����formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js"type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js"type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet"href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"type="text/css" />


<!-- ��������  -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"charset="utf-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- �������ֽ��� -->
<script type="text/javascript">
var sucess ="<%=sucess%>";
var flowFlag ="<%=flowFlag%>";
/*
����:  Ok
˵��:  �ύ������޸ļ�����
����:   ��
����ֵ: ��
*/
function Ok() {
	if(flowFlag=="true"){
		alert("�����ݼ�����δ���٣��뽫������ٵ����뵥�����ٵǼǡ�");
		return;
	}
	if(sucess=="true"){
		alert("����,�������Ѵ��°࿨��");
		return;
	}
	if(IsSpace('<%=electresetBean.getEnd_time()%>')){
		alert("�������ú��ϰ�ʱ��");
	}
	else{
	document.all.form1.target = "hiddenFrame";
	$("#form1").submit();
	}
}
function closed(){
	parent.JqueryDialog.Close();
}
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="addloadendtimedo.jsp" method="post">
		<input type="hidden" name="end_ip" id="end_ip"
			value="<%=StringUtil.deNull(ip)%>">
			<input type="hidden" name="end_time" id="end_time"
			value="<%=StringUtil.deNull(worktime)%>">
		<input type="hidden" name="datetime" id="datetime"
			value="<%=StringUtil.deNull(currenttime)%>">
			<input type="hidden" name="rest_time" id="rest_time"
			value="<%=StringUtil.deNull(rest_time)%>">
		<div id="users-contain">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_box_text">
			<tr>
				<th>���ã��°�ʱ����</th>
				<td><%=StringUtil.deNull(worktime) %>&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
				<th>�°�IPΪ</th>
				<td width="30%">
					<%=StringUtil.deNull(ip)%>
				</td>
			</tr>
		
		</table>
		
		
		
		<%-- <table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_box_text">			
		<tr>
				<td width="20%">���ã��°�ʱ����</td>
				<td width="30%"><%=StringUtil.deNull(electresetBean.getEnd_time()) %>
				</td>
				<td width="20%">�ϰ�IPΪ</td>
				<td width="30%">
					<%=StringUtil.deNull(ip)%>
				</td>
			</tr>
			</table> --%>
		</div>
			<div class="cue_box_foot">
		<input type="button" value='�ر�' onclick="removeAlertWindows('',true)" class="but_y_01"/>
		<input type="button" class="but_y_01" onClick="Ok()" value="�ύ" id="s1"/>
  	</div>
	
	</form>
		<iframe name="hiddenFrame" width=0 height=0></iframe>
		
	
</body>
</html>