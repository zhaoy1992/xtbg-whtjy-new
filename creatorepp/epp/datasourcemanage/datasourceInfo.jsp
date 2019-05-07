<%@page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@page import="com.chinacreator.epp.datasourcemanage.DatasourceManage"%>
<%@page import="com.chinacreator.epp.datasourcemanage.Poolman"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="com.chinacreator.config.ConfigManager"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() + path + "/";
	String datasourceName = request.getParameter("dbname") != null ? 
			request.getParameter("dbname") : "";
	String isEdit = request.getParameter("isEdit") != null ? request.getParameter("isEdit") : "false";
	
	DatasourceManage dm = new DatasourceManage();
	Poolman poolman = datasourceName.equals("") ? (new Poolman()) : dm.getDatasource(datasourceName);
	
	//add by wen.zhu 20100803
	String filePath = ConfigManager.getInstance().getConfigValue("approot")
	+ File.separatorChar+"WEB-INF"+File.separatorChar+"classes"+File.separatorChar+"poolman.xml";
	File file = new File(filePath);
	BufferedReader bufferReader = null;
	StringBuffer xmlBuffer = new StringBuffer(); 
	String xmlLineStr = "";
	try{
		if(file.exists()){
			bufferReader = new BufferedReader(new FileReader(file));
			while((xmlLineStr=bufferReader.readLine())!=null){
				xmlBuffer.append(xmlLineStr);
				//System.out.println(xmlLineStr);
			}
		}
	}catch(Exception e){
		System.out.print("�ļ�poolman.xml��ȡ����!!");
	}finally{
		bufferReader.close();
	}
	String xmlDoc = xmlBuffer.toString(); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>����Դ����</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script type="text/javascript">
		
		//add by wen.zhu ��֤�Ƿ�������Դ����
		var flag=false;
		
		function validDBName(dbName){
			var xmlDoc = createXMLDom();
			xmlDoc.async=false;
			xmlDoc.loadXML('<%=xmlDoc%>')
			var dbSource = xmlDoc.getElementsByTagName("datasource");
			for(i=0;i<dbSource.length;i++){
				if(dbSource[i].getElementsByTagName("dbname")[0].text==dbName){
					alert("����Դ["+dbName+"]�Ѵ���!!");
					flag=true;
					return;
				}
			}
			flag=false;
		}
		
		function createXMLDom(){
 			var arrSingatures=["Microsoft.XMLDOM","MSXML2.DOMDocument","MSXML2.DOMDocument.5.0","MSXML2.DOMDocument.4.0","MSXML2.DOMDocument.3.0"];
			for(var i=0;i<arrSingatures.length;i++){
 				try {
  					var xmlDoc=new ActiveXObject(arrSingatures[i]);
  					return xmlDoc;
 				}catch(e) {}
			}
		}
		
		function fillDB()
		{
			prepareDbDriverConf();
			var form = document.forms[0];
			form.Dbname.value = "<%=poolman.getDbname()%>";
			jsSelectItemByValue(form.Loadmetadata,"<%=poolman.getLoadmetadata()%>");
			form.JndiName.value = "<%=poolman.getJndiName()%>";
			jsSelectItemByValue(form.Driver,"<%=poolman.getDriver()%>");
			onChangeDriver();
			form.Url.value = "<%=poolman.getUrl()%>";
			onChangeUrl();
			form.databaseType.value = "<%=poolman.getDatabasetype()%>";
			//modify by wen.zhu ������Դ���ݿ�֧��
			//jsSelectItemByValue(form.sqlTransition, "//<%//=poolman.getIssqltransition()%>");	
			jsSelectItemByValue(form.Interceptor,"<%=poolman.getInterceptor()%>");			
			form.Username.value = "<%=poolman.getUsername()%>";
			form.Password.value = "<%=poolman.getPassword()%>";
			jsSelectItemByValue(form.TxIsolationLevel,"<%=poolman.getTxIsolationLevel()%>");
			jsSelectItemByValue(form.NativeResults,"<%=poolman.getNativeResults()%>");
			jsSelectItemByValue(form.PoolPreparedStatements,"<%=poolman.getPoolPreparedStatements()%>");
			form.InitialConnections.value = "<%=poolman.getInitialConnections()%>";
			form.MinimumSize.value = "<%=poolman.getMinimumSize()%>";
			form.MaximumSize.value = "<%=poolman.getMaximumSize()%>";
			form.MaximumSoft.value = "<%=poolman.getMaximumSoft()%>";
			form.MaxWait.value = "<%=poolman.getMaxWait()%>";
			jsSelectItemByValue(form.RemoveAbandoned,"<%=poolman.getRemoveAbandoned()%>");
			form.UserTimeout.value = "<%=poolman.getUserTimeout()%>";
			form.ConnectionTimeout.value = "<%=poolman.getConnectionTimeout()%>";
			form.ShrinkBy.value = "<%=poolman.getShrinkBy()%>";
			jsSelectItemByValue(form.Keygenerate,"<%=poolman.getKeygenerate()%>");				
		}
		
		function prepareDbDriverConf()
		{
			var strConfArr = [];
			try
			{
				strConfArr = eval("<%=DatasourceManage.getDbDriverConf()%>");
			}
			catch(e)
			{
				alert("���棺��ȡϵͳ���õ����ݿ�������Ϣʧ�ܣ�");
				strConfArr = [];
			}
						
			var form = document.forms[0];
			form.Driver.options.length = 0;
			for(var i = 0; i < strConfArr.length; i ++)
			{
				if(!strConfArr[i].name || !strConfArr[i].type) continue;
				var iCount = form.Driver.options.length;
				form.Driver.options.length ++;
				
				form.Driver.options[iCount].value = strConfArr[i].name;
				form.Driver.options[iCount].text = "[" + strConfArr[i].type + "] " + strConfArr[i].name;
				form.Driver.options[iCount].type = strConfArr[i].type;
				form.Driver.options[iCount].urlpat = strConfArr[i].urlpat;					
			}			
		}
		
		function onChangeDriver()
		{
			var selObj = document.forms[0].Driver;
			var urlObj = document.forms[0].Url;
			var databaseTypeObj = document.forms[0].databaseType;
			var iSelectIndex = selObj.selectedIndex;			
			if(iSelectIndex < 0) return;
			
			var strUrledt = selObj.options[iSelectIndex].urledt;
			var strUrlpat = selObj.options[iSelectIndex].urlpat;	
			urlObj.value = strUrledt ? strUrledt : strUrlpat;
			urlObj.title = strUrlpat;
			databaseTypeObj.value = selObj.options[iSelectIndex].type;
		}
		
		function onChangeUrl()
		{
			var selObj = document.forms[0].Driver;
			var urlObj = document.forms[0].Url;
			var iSelectIndex = selObj.selectedIndex;
			if(iSelectIndex < 0) return;
			selObj.options[iSelectIndex].urledt = urlObj.value;
		}
		
		function jsSelectItemByValue(objSelect, objItemText) 
		{            
	    	for (var i = 0; i < objSelect.options.length; i++) 
	    	{        
		        if (objSelect.options[i].value == objItemText) 
		        {        
		            objSelect.options[i].selected = true;        
		            break;        
		        }        
	    	}
    	}           
		
		function modifyDb(obj){
			if(flag){
				alert("���޸�����Դ����");
				return;
			}
			var form = document.forms[0];
			var Dbname = form.Dbname.value;
			var Loadmetadata = form.Loadmetadata.value;
			var JndiName = form.JndiName.value;
			var Driver = form.Driver.value;
			var Url = form.Url.value;
			//modify by wen.zhu 20100802 ������Դ���ݿ�֧��
			//var sqlTransition = form.sqlTransition.value;
			var Interceptor=form.Interceptor.value;
			var Username = form.Username.value;
			var Password = form.Password.value;
			var TxIsolationLevel = form.TxIsolationLevel.value;
			var NativeResults = form.NativeResults.value;
			var PoolPreparedStatements = form.PoolPreparedStatements.value;
			var InitialConnections = form.InitialConnections.value;
			var MinimumSize = form.MinimumSize.value ;
			var MaximumSize = form.MaximumSize.value ;
			var MaximumSoft = form.MaximumSoft.value;
			var MaxWait = form.MaxWait.value ;
			var RemoveAbandoned = form.RemoveAbandoned.value;
			var UserTimeout = form.UserTimeout.value;
			var ConnectionTimeout = form.ConnectionTimeout.value;
			var ShrinkBy = form.ShrinkBy.value;
			var Keygenerate = form.Keygenerate.value;
		
			if (trim(Dbname).length == 0 ){
				alert("����Դ���ֲ���Ϊ�գ�");
				return;
			}
			
			if(Dbname.search(/[^\w]/) !=-1){	
				alert("����Դ����ֻ�������֡���ĸ���»�����ɣ�");
				return;
			}
			
			if (trim(Loadmetadata).length == 0 ){
				alert("�Ƿ�������ݿ�Դ���ݲ���Ϊ�գ�");
				return;
			}
			
			if (trim(JndiName).length == 0 ){
				alert("JNDI���ֲ���Ϊ�գ�");
				return;
			}
			
			if (trim(Driver).length == 0 ){
				alert("���ݿ���������Ϊ�գ�");
				return;
			}
			
			if (trim(Url).length == 0 ){
				alert("���ݿ����ӵ�ַ����Ϊ�գ�");
				return;
			}
			
			if(trim(Interceptor).length == 0){
				alert("������Դ���ݿ�֧�ֲ���Ϊ�գ�");
				return;
			}
			
			if (trim(Username).length == 0 ){
				alert("�û�������Ϊ�գ�");
				return;
			}
			
			if(Username.search(/[^\w]/) !=-1){	
				alert("�û���ֻ�������֡���ĸ���»�����ɣ�");
				return;
			}
			
			if (trim(Password).length == 0 ){
				alert("���벻��Ϊ�գ�");
				return;
			}
			
			if(Password.search(/[^\w]/) !=-1){	
				alert("����ֻ�������֡���ĸ���»�����ɣ�");
				return;
			}
			
			if (trim(TxIsolationLevel).length == 0 ){
				alert("������뼶����Ϊ�գ�");
				return;
			}
			
			if (trim(NativeResults).length == 0 ){
				alert("nativeResults����Ϊ�գ�");
				return;
			}
			
			if (trim(PoolPreparedStatements).length == 0 ){
				alert("Ԥ����statement�ػ���ǲ���Ϊ�գ�");
				return;
			}
			
			if (trim(InitialConnections).length == 0 ){
				alert("��ʼ����������Ϊ�գ�");
				return;
			}
			
			if (trim(MinimumSize).length == 0 ){
				alert("��С��������������Ϊ�գ�");
				return;
			}
			
			if (trim(MaximumSize).length == 0 ){
				alert("�������������Ϊ�գ�");
				return;
			}
			
			if (trim(MaximumSoft).length == 0 ){
				alert("�ﵽmaximumSize�Ƿ������ٴ����µ�connection����Ϊ�գ�");
				return;
			}
			
			if (trim(MaxWait).length == 0 ){
				alert("��ȡ���ӵȴ���ʱʱ�䲻��Ϊ�գ�");
				return;
			}
			
			if (trim(RemoveAbandoned).length == 0 ){
				alert("��ⳬʱ���Ӳ���Ϊ�գ�");
				return;
			}
			
			if (trim(UserTimeout).length == 0 ){
				alert("����ʹ�ó�ʱʱ�䲻��Ϊ�գ�");
				return;
			}
			
			if (trim(ConnectionTimeout).length == 0 ){
				alert("�������ӻ���ʱ�䲻��Ϊ�գ�");
				return;
			}
			
			if (trim(ShrinkBy).length == 0 ){
				alert("ÿ�λ��յ�����������Ϊ�գ�");
				return;
			}
			
			if (trim(Keygenerate).length == 0 ){
				alert("���ݿ��������ɻ��Ʋ���Ϊ�գ�");
				return;
			}	
			
			if(obj=="test"){
				form.isEdit.value = "test";
			}else{
				form.isEdit.value = "<%=isEdit%>";
			}
		
			form.testDatasource.disabled="true";
			form.saveDatasource.disabled="true";
			form.resetDatasource.disabled="true";
			form.action="./epp/datasourcemanage/datasourceInfo_do.jsp";
			form.target = "hiddenFrame";
			form.submit();
		}
		
		function cancelDb(){
			window.top.returnValue='true';
			window.close();
			
		}
		
		function returnDB(){
			var form = document.forms[0];
			form.testDatasource.disabled="";
			form.saveDatasource.disabled="";
			form.resetDatasource.disabled="";
		}
				
		function keyfill(){
			var form = document.forms[0];
			form.JndiName.value = form.Dbname.value+"_datasource_jndiname";	
		}
		
		//ȥ���ַ����ո�
		function trim(string){
			var temp="";
			string = ''+string;
			splitstring = string.split(" ");
			for(i=0;i<splitstring.length;i++){
				temp += splitstring[i];
			} 
			return temp;
		}
		
		//���¹رհ�ťʱˢ�¸�����
		function window.onbeforeunload()
		{
		    if(event.clientX>360&&event.clientY<0||event.altKey)
		    {
		       window.top.returnValue='true';
		    }
		}
		
	</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body onload="fillDB();">
		<form name="DatasourceInfoForm" action="./epp/datasourcemanage/datasourceInfo_do.jsp"
			method="post">
			<div align="center">
				<table align="right" width="100%">
					<tr>
						<td width="95%">
							<fieldset>
								<LEGEND align="center">
									<%if(isEdit.equals("modify")){ %>
									<FONT size="2">�޸�����Դ</FONT>
									<%}else{ %>
									<FONT size="2">��������Դ</FONT>
									<%} %>
									<input name="isEdit" type="hidden" value="<%=isEdit %>">
								</LEGEND>
								<br>
								<table width="100%" border="0" cellpadding="0" cellspacing="0" class="thin">									
									<tr>
										<td width="49%">
											����Դ����
										</td>
										<td width="51%">
										<%if(isEdit.equals("modify")){ %>
											<input name="Dbname" type="text"
												value="" size="70" maxlength="44" readonly="readonly" >
										<%}else{ %>
											<input name="Dbname" type="text"
												value="" size="70" maxlength="44" onkeyup="keyfill();" onchange="validDBName(this.value);">
										<%} %>
										</td>
									</tr>
									<tr>
										<td>
											�Ƿ�������ݿ�Դ����
										</td>
										<td>
											<SELECT ID="Loadmetadata" NAME="Loadmetadata"
												style="width: 375px;">			
												<OPTION VALUE="true" selected>true</OPTION>
												<OPTION VALUE="false">false</OPTION>													
											</select>
										</td>
									</tr>
									<tr>
										<td>
											JNDI����
										</td>
										<td>
											<input name="JndiName" type="text"
												value="" size="70" maxlength="44"
												readonly="readonly">
										</td>
									</tr>
									<tr>
										<td>
											���ݿ�����
										</td>
										<td>
											<select id="Driver" name="Driver" onchange="onChangeDriver();" style="width: 375px;">
											</select>
										</td>
									</tr>
									<tr>
										<td>
											���ݿ����ӵ�ַ
										</td>
										<td>
											<input id="Url" name="Url" type="text" onchange="onChangeUrl();" value="" size="70" maxlength="70" />
											<input id="databaseType" name="databaseType" type="hidden" value=""/>
										</td>
									</tr>
									<tr>
										<td>
											<!-- modify by wen.zhu 
											�Ƿ���Ҫִ��SQLת������ -->
											������Դ�������ݿ⴦��ʽ
										</td>
										<td>
											<SELECT ID="Interceptor" NAME="Interceptor"	style="width: 375px;">	
												<OPTION VALUE="com.chinacreator.epp.util.SQLTransitionInterceptor" selected>SQLTransitionInterceptor(�ֱ�֧�ֶ�����Դ,֧�ֶ����ݿ�)</OPTION>	
												<OPTION VALUE="com.frameworkset.orm.adaptors.MyInterceptor" >MyInterceptor(�޴���,��֧�ֶ�����Դ,��֧�ֶ����ݿ�)</OPTION>
												<OPTION VALUE="com.chinacreator.epp.util.DataSourceInterceptor">DataSourceInterceptor(֧�ֶ�����Դ,��֧�ֶ����ݿ�)</OPTION>	
											</select>
										</td>
									</tr>
									<tr>
										<td>
											�û���
										</td>
										<td>
											<input name="Username" type="text"
												value="" size="70" maxlength="44">
										</td>
									</tr>
									<tr>
										<td>
											����
										</td>
										<td>
											<input name="Password" type="text"
												value="" size="70" maxlength="44">
										</td>
									</tr>
									<tr>
										<td>
											������뼶��
										</td>
										<td>
											<SELECT ID="TxIsolationLevel" NAME="TxIsolationLevel"
												style="width: 375px;">
												<option value="READ_COMMITTED">
													READ_COMMITTED
											</SELECT>
										</td>
									</tr>
									<tr>
										<td>
											nativeResults
										</td>
										<td>
											<SELECT ID="NativeResults" NAME="NativeResults"
												style="width: 375px;">
												<OPTION VALUE="true" selected>true</OPTION>
												<OPTION VALUE="false">false</OPTION>
											</select>
										</td>
									</tr>
									<tr>
										<td>
											Ԥ����statement�ػ����
										</td>
										<td>
											<SELECT ID="PoolPreparedStatements"
												NAME="PoolPreparedStatements" style="width: 375px;">
												<OPTION VALUE="true">true</OPTION>
												<OPTION VALUE="false" SELECTED>false</OPTION>
											</select>
										</td>
									</tr>
									<tr>
										<td>
											��ʼ������������
										</td>
										<td>
											<input name="InitialConnections" type="text"
												value="" size="70"
												maxlength="44" style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
										</td>
									</tr>
									<tr>
										<td>
											��С����������������
										</td>
										<td>
											<input name="MinimumSize" type="text"
												value="" size="70"
												maxlength="44" style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
										</td>
									</tr>
									<tr>
										<td>
											���������������
										</td>
										<td>
											<input name="MaximumSize" type="text"
												value="" size="70"
												maxlength="44" style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
										</td>
									</tr>
									<tr>
										<td>
											�ﵽmaximumSize�Ƿ������ٴ����µ�connection
										</td>
										<td>
											<SELECT ID="MaximumSoft" NAME="MaximumSoft"
												style="width: 375px;">
												<OPTION VALUE="true">true</OPTION>
												<OPTION VALUE="false" SELECTED>false</OPTION>
											</select>
										</td>
									</tr>
									<tr>
										<td>
											��ȡ���ӵȴ���ʱʱ�䣨�룩
										</td>
										<td>
											<input name="MaxWait" type="text"
												value="" size="70" maxlength="44"
												style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
										</td>
									</tr>
									<tr>
										<td>
											��ⳬʱ����
										</td>
										<td>
											<SELECT ID="RemoveAbandoned" NAME="RemoveAbandoned"
												style="width: 375px;">
												<OPTION VALUE="true">true</OPTION>
												<OPTION VALUE="false" SELECTED>false</OPTION>
											</select>
										</td>
									</tr>
									<tr>
										<td>
											����ʹ�ó�ʱʱ�䣨�룩
										</td>
										<td>
											<input name="UserTimeout" type="text"
												value="" size="70"
												maxlength="44" style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
										</td>
									</tr>
									<tr>
										<td>
											�������ӻ���ʱ�䣨�룩
										</td>
										<td>
											<input name="ConnectionTimeout" type="text"
												value="" size="70"
												maxlength="44" style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
										</td>
									</tr>
									<tr>
										<td>
											ÿ�λ��յ�������������
										</td>
										<td>
											<input name="ShrinkBy" type="text"
												value="" size="70" maxlength="44"
												style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
										</td>
									</tr>
									<tr>
										<td>
											���ݿ��������ɻ���
										</td>
										<td>
											<SELECT ID="Keygenerate" NAME="Keygenerate"
												style="width: 375px;">
												<option value="composite">
													composite
											</SELECT>
										</td>
									</tr>
								</table>
							</fieldset>
						</td>
					</tr>
					<tr>
						<td width="95%" align="right">
							<input name="testDatasource" type="button" value="����"
								class="input" onClick="modifyDb('test')">
							<input name="saveDatasource" type="button" value="ȷ��"
								class="input" onClick="modifyDb('1')">
							<input name="resetDatasource" type="button" value="����"
								class="input" onClick="fillDB();">
							<input name="cancelDatasource" type="button" value="ȡ��"
								class="input" onClick="cancelDb()">
						</td>
					</tr>
				</table>
		</div>
		</form>
	</body>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>
