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
		System.out.print("文件poolman.xml读取出错!!");
	}finally{
		bufferReader.close();
	}
	String xmlDoc = xmlBuffer.toString(); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>数据源操作</title>

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
		
		//add by wen.zhu 验证是否有数据源重名
		var flag=false;
		
		function validDBName(dbName){
			var xmlDoc = createXMLDom();
			xmlDoc.async=false;
			xmlDoc.loadXML('<%=xmlDoc%>')
			var dbSource = xmlDoc.getElementsByTagName("datasource");
			for(i=0;i<dbSource.length;i++){
				if(dbSource[i].getElementsByTagName("dbname")[0].text==dbName){
					alert("数据源["+dbName+"]已存在!!");
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
			//modify by wen.zhu 多数据源数据库支持
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
				alert("警告：读取系统可用的数据库驱动信息失败！");
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
				alert("请修改数据源名称");
				return;
			}
			var form = document.forms[0];
			var Dbname = form.Dbname.value;
			var Loadmetadata = form.Loadmetadata.value;
			var JndiName = form.JndiName.value;
			var Driver = form.Driver.value;
			var Url = form.Url.value;
			//modify by wen.zhu 20100802 多数据源数据库支持
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
				alert("数据源名字不能为空！");
				return;
			}
			
			if(Dbname.search(/[^\w]/) !=-1){	
				alert("数据源名字只能由数字、字母或下划线组成！");
				return;
			}
			
			if (trim(Loadmetadata).length == 0 ){
				alert("是否加载数据库源数据不能为空！");
				return;
			}
			
			if (trim(JndiName).length == 0 ){
				alert("JNDI名字不能为空！");
				return;
			}
			
			if (trim(Driver).length == 0 ){
				alert("数据库驱动不能为空！");
				return;
			}
			
			if (trim(Url).length == 0 ){
				alert("数据库链接地址不能为空！");
				return;
			}
			
			if(trim(Interceptor).length == 0){
				alert("所数据源数据库支持不能为空！");
				return;
			}
			
			if (trim(Username).length == 0 ){
				alert("用户名不能为空！");
				return;
			}
			
			if(Username.search(/[^\w]/) !=-1){	
				alert("用户名只能由数字、字母或下划线组成！");
				return;
			}
			
			if (trim(Password).length == 0 ){
				alert("密码不能为空！");
				return;
			}
			
			if(Password.search(/[^\w]/) !=-1){	
				alert("密码只能由数字、字母或下划线组成！");
				return;
			}
			
			if (trim(TxIsolationLevel).length == 0 ){
				alert("事务分离级别不能为空！");
				return;
			}
			
			if (trim(NativeResults).length == 0 ){
				alert("nativeResults不能为空！");
				return;
			}
			
			if (trim(PoolPreparedStatements).length == 0 ){
				alert("预编译statement池化标记不能为空！");
				return;
			}
			
			if (trim(InitialConnections).length == 0 ){
				alert("初始链接数不能为空！");
				return;
			}
			
			if (trim(MinimumSize).length == 0 ){
				alert("最小空闲链接数不能为空！");
				return;
			}
			
			if (trim(MaximumSize).length == 0 ){
				alert("最大链接数不能为空！");
				return;
			}
			
			if (trim(MaximumSoft).length == 0 ){
				alert("达到maximumSize是否允许再创建新的connection不能为空！");
				return;
			}
			
			if (trim(MaxWait).length == 0 ){
				alert("获取链接等待超时时间不能为空！");
				return;
			}
			
			if (trim(RemoveAbandoned).length == 0 ){
				alert("检测超时链接不能为空！");
				return;
			}
			
			if (trim(UserTimeout).length == 0 ){
				alert("链接使用超时时间不能为空！");
				return;
			}
			
			if (trim(ConnectionTimeout).length == 0 ){
				alert("空闲链接回收时间不能为空！");
				return;
			}
			
			if (trim(ShrinkBy).length == 0 ){
				alert("每次回收的链接数不能为空！");
				return;
			}
			
			if (trim(Keygenerate).length == 0 ){
				alert("数据库主键生成机制不能为空！");
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
		
		//去除字符串空格
		function trim(string){
			var temp="";
			string = ''+string;
			splitstring = string.split(" ");
			for(i=0;i<splitstring.length;i++){
				temp += splitstring[i];
			} 
			return temp;
		}
		
		//按下关闭按钮时刷新父窗口
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
									<FONT size="2">修改数据源</FONT>
									<%}else{ %>
									<FONT size="2">新增数据源</FONT>
									<%} %>
									<input name="isEdit" type="hidden" value="<%=isEdit %>">
								</LEGEND>
								<br>
								<table width="100%" border="0" cellpadding="0" cellspacing="0" class="thin">									
									<tr>
										<td width="49%">
											数据源名字
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
											是否加载数据库源数据
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
											JNDI名字
										</td>
										<td>
											<input name="JndiName" type="text"
												value="" size="70" maxlength="44"
												readonly="readonly">
										</td>
									</tr>
									<tr>
										<td>
											数据库驱动
										</td>
										<td>
											<select id="Driver" name="Driver" onchange="onChangeDriver();" style="width: 375px;">
											</select>
										</td>
									</tr>
									<tr>
										<td>
											数据库链接地址
										</td>
										<td>
											<input id="Url" name="Url" type="text" onchange="onChangeUrl();" value="" size="70" maxlength="70" />
											<input id="databaseType" name="databaseType" type="hidden" value=""/>
										</td>
									</tr>
									<tr>
										<td>
											<!-- modify by wen.zhu 
											是否需要执行SQL转换功能 -->
											多数据源、多数据库处理方式
										</td>
										<td>
											<SELECT ID="Interceptor" NAME="Interceptor"	style="width: 375px;">	
												<OPTION VALUE="com.chinacreator.epp.util.SQLTransitionInterceptor" selected>SQLTransitionInterceptor(分别支持多数据源,支持多数据库)</OPTION>	
												<OPTION VALUE="com.frameworkset.orm.adaptors.MyInterceptor" >MyInterceptor(无处理,不支持多数据源,不支持多数据库)</OPTION>
												<OPTION VALUE="com.chinacreator.epp.util.DataSourceInterceptor">DataSourceInterceptor(支持多数据源,不支持多数据库)</OPTION>	
											</select>
										</td>
									</tr>
									<tr>
										<td>
											用户名
										</td>
										<td>
											<input name="Username" type="text"
												value="" size="70" maxlength="44">
										</td>
									</tr>
									<tr>
										<td>
											密码
										</td>
										<td>
											<input name="Password" type="text"
												value="" size="70" maxlength="44">
										</td>
									</tr>
									<tr>
										<td>
											事务分离级别
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
											预编译statement池化标记
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
											初始链接数（个）
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
											最小空闲链接数（个）
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
											最大链接数（个）
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
											达到maximumSize是否允许再创建新的connection
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
											获取链接等待超时时间（秒）
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
											检测超时链接
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
											链接使用超时时间（秒）
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
											空闲链接回收时间（秒）
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
											每次回收的链接数（个）
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
											数据库主键生成机制
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
							<input name="testDatasource" type="button" value="测试"
								class="input" onClick="modifyDb('test')">
							<input name="saveDatasource" type="button" value="确定"
								class="input" onClick="modifyDb('1')">
							<input name="resetDatasource" type="button" value="重置"
								class="input" onClick="fillDB();">
							<input name="cancelDatasource" type="button" value="取消"
								class="input" onClick="cancelDb()">
						</td>
					</tr>
				</table>
		</div>
		</form>
	</body>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>
