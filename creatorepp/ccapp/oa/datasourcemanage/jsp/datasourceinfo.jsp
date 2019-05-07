<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page language="java" import="java.util.*"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.epp.datasourcemanage.DatasourceManage"%>
<%@page import="com.chinacreator.epp.datasourcemanage.Poolman"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="com.chinacreator.config.ConfigManager"%>

<%
	String path = request.getContextPath();
	String subid=StringUtil.deNull(request.getParameter("subid"));
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort() + path + "/";
	String datasourceName = StringUtil.deNull(request.getParameter("dbname"));
	String isEdit = StringUtil.deNull(request.getParameter("isEdit"));
	
	DatasourceManage dm = new DatasourceManage();
	Poolman poolman =new Poolman();
	if(!StringUtil.isBlank(datasourceName)){
		poolman=dm.getDatasource(datasourceName);
	}
	
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
		<title>数据源操作</title>
		
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="utf-8"></script>

<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" ></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
		<script type="text/javascript">
		var subid='<%=subid%>'
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
		jQuery(function init() {
			prepareDbDriverConf();
			
			jQuery("#Dbname").val("<%=poolman.getDbname() %>");
			jQuery("#Loadmetadata").val("<%=poolman.getLoadmetadata() %>");
			jQuery("#JndiName").val("<%=poolman.getJndiName() %>");
			jQuery("#Driver").val("<%=poolman.getDriver() %>");
			onChangeDriver();
			jQuery("#Url").val("<%=poolman.getUrl() %>");
			onChangeUrl();
			jQuery("#databaseType").val("<%=poolman.getDatabasetype()%>");
			jQuery("#Interceptor").val("<%=poolman.getInterceptor() %>");
			jQuery("#Username").val("<%=poolman.getUsername() %>");
			jQuery("#Password").val("<%=poolman.getPassword() %>");
			jQuery("#TxIsolationLevel").val("<%=poolman.getTxIsolationLevel() %>");
			jQuery("#NativeResults").val("<%=poolman.getDbname() %>");
			jQuery("#PoolPreparedStatements").val("<%=poolman.getPoolPreparedStatements() %>");
			jQuery("#InitialConnections").val("<%=poolman.getInitialConnections() %>");
			jQuery("#MinimumSize").val("<%=poolman.getMinimumSize() %>");
			jQuery("#MaximumSize").val("<%=poolman.getMaximumSize() %>");
			jQuery("#MaximumSoft").val("<%=poolman.getMaximumSoft() %>");
			jQuery("#MaxWait").val("<%=poolman.getMaxWait() %>");
			jQuery("#RemoveAbandoned").val("<%=poolman.getRemoveAbandoned() %>");
			jQuery("#UserTimeout").val("<%=poolman.getUserTimeout() %>");
			jQuery("#ConnectionTimeout").val("<%=poolman.getConnectionTimeout() %>");
			jQuery("#ShrinkBy").val("<%=poolman.getShrinkBy() %>");
			jQuery("#Keygenerate").val("<%=poolman.getKeygenerate() %>");
			
		});
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
		
			if(obj=="test"){
				form.isEdit.value = "test";
			}else{
				form.isEdit.value = "<%=isEdit%>";
			}
		
			
			if(!jQuery('#form1').validationEngine('validate')){
				return;
			}
			if(Dbname.search(/[^\w]/) !=-1){	
				alert("数据源名字只能由数字、字母或下划线组成！");
				return;
			}
			if(Username.search(/[^\w]/) !=-1){	
				alert("用户名只能由数字、字母或下划线组成！");
				return;
			}
			if(Password.search(/[^\w]/) !=-1){	
				alert("密码只能由数字、字母或下划线组成！");
				return;
			}
			document.all.form1.target = "hiddenFrame";
			jQuery("#form1").attr("action","datasourceinfo_do.jsp?subid=<%=subid%>");
			jQuery("#form1").submit();
			
		}
		
		function cancelDb(id){
			if("aa"==id){
			var okF = function(){
				closeAlertWindows(subid,false,true);
			}
			 var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'};
			 alert('取消该页,未保存的信息将会丢失 '+'<br>'+'确定取消？',p);
			}else{
				closeAlertWindows('<%=subid%>',false,true);
			}
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
		
		/* //按下关闭按钮时刷新父窗口
		function window.onbeforeunload()
		{
		    if(event.clientX>360&&event.clientY<0||event.altKey)
		    {
		       window.top.returnValue='true';
		    }
		} */
		
	</script>
</head>
<body style="overflow-y:hidden;" onload="adaptationWH('_top','vcenter',1)">
    <form id="form1" name="form1"  method="post" >
    	<input name="isEdit" type="hidden" value="<%=isEdit %>">
    
        <div class="content_02" style="overflow: hidden;">
            <div class="content_02" style="overflow: hidden;" id="_top">
                <div class="content_02_top" style="margin-bottom: 10px;">
                <input name="testDatasource" type="button" value="测试"
								class="but_y_01" onClick="modifyDb('test')"/>
							<input name="saveDatasource" type="button" value="确定"
								class="but_y_01" onClick="modifyDb('1')"/>
							<input name="resetDatasource" type="button" value="重置"
								class="but_y_01" onClick="init();"/>
							<input name="cancelDatasource" type="button" value="取消"
								class="but_y_01" onClick="cancelDb('aa')"/>
                </div>
            </div>
        </div>

        <div id="vcenter" style="float:left; width:100%; overflow-y:auto;overflow-x:hidden">
        <div style="float: left;width: 800px"> 
        <div class="content_02_box" >
         <div class="content_02_box_title_bg"><span>基本信息</span></div>
         <div class="content_02_box_div">
            <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02">
                <tr>
                    <th style="width: 40%" class="content_02_box_div_table_th" >数据源名字：</th>
	                <td class="content_02_box_div_table_td" colspan="3">
		                <input type="text" class="validate[required] input_title_text"  type="text" name="Dbname" 
		                    id="Dbname" maxlength="150" value="" onkeyup="keyfill();" onchange="validDBName(this.value);"/>
	                </td>
	            </tr>
	            <tr>
	            
	                  <th style="width: 40%" class="content_02_box_div_table_th">是否加载数据库源数据：</th>
	                   <td class="content_02_box_div_table_td" >
	                  	   <SELECT ID="Loadmetadata" NAME="Loadmetadata" style="width: 375px;">			
								<OPTION VALUE="true" selected>true</OPTION>
								<OPTION VALUE="false">false</OPTION>													
						  </select>
	                   </td>
	            </tr>
	            <tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">JNDI名字：</th>
	                   <td class="content_02_box_div_table_td">
	                   <input  class="validate[required] input_title_text" type="text" id="JndiName" name="JndiName"  readonly="readonly"
	                  		value=""  />
	                   </td>
	             
	            </tr>
	            <tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">数据库驱动：</th>
	                   <td class="content_02_box_div_table_td">
	                       <%--     <%=infotypeHtml%>--%>
	                       <select id="Driver" name="Driver" onchange="onChangeDriver();" style="width: 375px;">
						   </select>
	                  </td>
	             </tr>
	            <tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">数据库链接地址：</th>
	                   <td class="content_02_box_div_table_td">
	                     <input class="validate[required] input_title_text" id="Url" name="Url" type="text" onchange="onChangeUrl();" value="" size="70" maxlength="70" />
						 <input id="databaseType" name="databaseType" type="hidden" value=""/>
	                  </td>
		         </tr>
		         <tr>
	                   <th  style="width: 40%" class="content_02_box_div_table_th">多数据源、多数据库处理方式：</th>
	                   <td class="content_02_box_div_table_td">
	                   <SELECT ID="Interceptor" NAME="Interceptor"	style="width: 375px;">	
							<OPTION VALUE="com.chinacreator.epp.util.SQLTransitionInterceptor" selected>SQLTransitionInterceptor(分别支持多数据源,支持多数据库)</OPTION>	
							<OPTION VALUE="com.frameworkset.orm.adaptors.MyInterceptor" >MyInterceptor(无处理,不支持多数据源,不支持多数据库)</OPTION>
							<OPTION VALUE="com.chinacreator.epp.util.DataSourceInterceptor">DataSourceInterceptor(支持多数据源,不支持多数据库)</OPTION>	
						</select>
	                   </td>
	              </tr>
		         <tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">用户名：</th>
	                   <td class="content_02_box_div_table_td">
	                       <input class="validate[required] input_title_text" id="Username" name="Username" type="text" value="" size="70" maxlength="44">
	                  </td>
	         	</tr>
	         <tr>
	                <th  style="width: 40%" width="212" valign="top" class="content_02_box_div_table_th">密码：</th>
	                <td colspan="3" valign="top" class="content_02_box_div_table_td" >
	                	<input class="validate[required] input_title_text" id="Password" name="Password" type="text" value="" size="70" maxlength="44">
	                </td>               
	            </tr>
	          <tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">事务分离级别：</th>
	                   <td class="content_02_box_div_table_td">
							<SELECT ID="TxIsolationLevel" NAME="TxIsolationLevel" style="width: 375px;">
								<option value="READ_COMMITTED"> READ_COMMITTED
							</SELECT>	                  
						</td>
	         	</tr>
	         	<tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">nativeResults：</th>
	                   <td class="content_02_box_div_table_td">
	                       <SELECT ID="NativeResults" NAME="NativeResults"
												style="width: 375px;">
												<OPTION VALUE="true" selected>true</OPTION>
												<OPTION VALUE="false">false</OPTION>
											</select>
	                  </td>
	         	</tr>
	         	<tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">预编译statement池化标记：</th>
	                   <td class="content_02_box_div_table_td">
	                       <SELECT ID="PoolPreparedStatements"
												NAME="PoolPreparedStatements" style="width: 375px;">
												<OPTION VALUE="true">true</OPTION>
												<OPTION VALUE="false" SELECTED>false</OPTION>
											</select>
	                  </td>
	         	</tr>
	         	 <tr>
	                   <th  style="width: 40%" class="content_02_box_div_table_th">初始链接数（个）：</th>
	                   <td class="content_02_box_div_table_td">
	                       <input class="validate[required] input_title_text" id="InitialConnections" name="InitialConnections" type="text"
												value="" size="70"
												maxlength="44" style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
	                  </td>
	         	</tr>
	         	 <tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">最小空闲链接数（个）：</th>
	                   <td class="content_02_box_div_table_td">
	                       <input class="validate[required] input_title_text" id="MinimumSize" name="MinimumSize" type="text"
												value="" size="70"
												maxlength="44" style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
	                  </td>
	         	</tr>
	         	 <tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">最大链接数（个）：</th>
	                   <td class="content_02_box_div_table_td">
	                       <input class="validate[required] input_title_text" id="MaximumSize" name="MaximumSize" type="text"
												value="" size="70"
												maxlength="44" style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
	                  </td>
	         	</tr>
	         	 <tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">达到maximumSize是否允许再创建新的connection：</th>
	                   <td class="content_02_box_div_table_td">
	                       <SELECT ID="MaximumSoft" NAME="MaximumSoft"
												style="width: 375px;">
												<OPTION VALUE="true">true</OPTION>
												<OPTION VALUE="false" SELECTED>false</OPTION>
											</select>
	                  </td>
	         	</tr>
	         	 <tr>
	                   <th  style="width: 40%" class="content_02_box_div_table_th">获取链接等待超时时间（秒）：</th>
	                   <td class="content_02_box_div_table_td">
	                       <input class="validate[required] input_title_text" id="MaxWait" name="MaxWait" type="text"
												value="" size="70" maxlength="44"
												style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
	                  </td>
	         	</tr>
	         	 <tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">检测超时链接：</th>
	                   <td class="content_02_box_div_table_td">
	                       <SELECT ID="RemoveAbandoned" NAME="RemoveAbandoned"
												style="width: 375px;">
												<OPTION VALUE="true">true</OPTION>
												<OPTION VALUE="false" SELECTED>false</OPTION>
											</select>
	                  </td>
	         	</tr>
	         	 <tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">链接使用超时时间（秒）：</th>
	                   <td class="content_02_box_div_table_td">
	                       <input class="validate[required] input_title_text" id="UserTimeout" name="UserTimeout" type="text"
												value="" size="70"
												maxlength="44" style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
	                  </td>
	         	</tr>
	         	<tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">空闲链接回收时间（秒）：</th>
	                   <td class="content_02_box_div_table_td">
	                       <input class="validate[required] input_title_text" id="ConnectionTimeout" name="ConnectionTimeout" type="text"
												value="" size="70"
												maxlength="44" style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
	                  </td>
	         	</tr>
	         	<tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">每次回收的链接数（个）：</th>
	                   <td class="content_02_box_div_table_td">
	                       <input class="validate[required] input_title_text" id="ShrinkBy" name="ShrinkBy" type="text"
												value="" size="70" maxlength="44"
												style="ime-mode:disabled"
												onkeydown="if(event.keyCode==13)event.keyCode=9"
												onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
	                  </td>
	         	</tr>
	         	<tr>
	                   <th style="width: 40%"  class="content_02_box_div_table_th">数据库主键生成机制：</th>
	                   <td class="content_02_box_div_table_td">
	                       <SELECT ID="Keygenerate" NAME="Keygenerate"
												style="width: 375px;">
												<option value="composite">
													composite
											</SELECT>
	                  </td>
	         	</tr>
            </table>
         </div>
      </div>
	</div>
    </div>
     </form>
     <iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
