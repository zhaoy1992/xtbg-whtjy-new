<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page
	import="com.chinacreator.security.AccessControl,com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.epp.datasourcemanage.DatasourceManage"%>
<%@ page import="com.chinacreator.epp.datasourcemanage.Poolman"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.epp.menuconfigure.ParseXmlAddDS"%>
<%@ page import="com.chinacreator.framework.Framework"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	DatasourceManage dm = new DatasourceManage();
	List dsList = dm.getDatasources();
	//应该由当前的应用id获得对应的菜单文件信息
	//菜单文件名格式：module-{currentSystemID}.xml
	String currentSystemID = control.getCurrentSystemID();

	String moduleId = StringUtil.replaceNull(request
			.getParameter("moduleId"));

	String moduleXmlName = Framework.menu_folder + "module.xml";
	if (currentSystemID != null && !currentSystemID.trim().equals("")
			&& !currentSystemID.trim().equals("module")) {
		moduleXmlName = Framework.menu_folder + "module-"
		+ currentSystemID + ".xml";
	}
	ParseXmlAddDS pxad = new ParseXmlAddDS(moduleXmlName);
	String datasourceName = StringUtil.replaceNull((pxad)
			.getDatasourceById(moduleId));
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/treeview.css">
		<tab:tabConfig />
		<title>模块操作</title>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>
		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript" src="pageGrey.js"></script>

		<script language="javascript">
			
			function addmodule()
			{
			   
				var form = document.forms[0];
				var id=form.id.value;
				var name=form.name.value;
				
				if (trim(id).length == 0 ){
			    	document.getElementById("id_message").innerHTML = "请录入模块ID！"; 
			    	return false;
			    }else{
			    	document.getElementById("id_message").innerHTML = "";
			    }
				
				 if(id.search(/[^\w]/) !=-1){	
			    	var blank = "";
			    	for(var i=0;i<52;i++)
			    		blank += "&nbsp;";    	
			    	document.getElementById("id_message").innerHTML = "模块ID只能由数字、字母"+"<br/>"+blank+ "或下划线组成！"; 			    	
			    	return false;
			    }else{
			    	document.getElementById("id_message").innerHTML = "";
			    }
			    
			    if (trim(name).length == 0 ){
			    	document.getElementById("name_message").innerHTML = "请录入模块名称！"; 
			    	return false;
			    }else{
			    	document.getElementById("name_message").innerHTML = "";
			    }
				
				 if(name.search(/[^\w\u4e00-\u9fa5]/) !=-1){	
			    	var blank = "";
			    	for(var i=0;i<52;i++)
			    		blank += "&nbsp;";    	
			    	document.getElementById("name_message").innerHTML = "模块名称只能由数字、字母、"+"<br/>"+blank+ "汉字或下划线组成！"; 			    	
			    	return false;
			    }else{
			    	document.getElementById("name_message").innerHTML = "";
			    }
							
				//提交后页面变灰
			    popSignFlow(1);
		        moduleform.action = "addmodule_do.jsp";
			    moduleform.target = "hiddenFrame";
			    moduleform.submit();
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
			
			//把数据源设置为已有的值
			function initDatasource(ds){
				if(ds!=null){
					jsSelectItemByValue(document.getElementById("ds_name"),ds);
				}
				fullimg();
			}
			
			function jsSelectItemByValue(objSelect, objItemText) {            
		    	for (var i = 0; i < objSelect.options.length; i++) {        
			        if (objSelect.options[i].text == objItemText) {        
			            objSelect.options[i].selected = true;        
			            break;        
			        }        
		    	}
		    }
		    
		    function configicon(type,iconpath){
    			ww = openWin('showitemconfigicon.jsp?iconpath='+iconpath,screen.availWidth-320,screen.availHeight-140);
					
					if(ww){
						var form = document.forms[0];					
						if("dis"==type){
							form.menudisicon.value = ww;
						}else if("en"==type){
							form.menuenicon.value = ww;
						}
					}
				fullimg();
    		}
    		
    		function fullimg(){
    			document.forms[0].menudisimg.src = "<%=request.getContextPath()%>/"+document.forms[0].menudisicon.value;
				document.forms[0].menuenimg.src = "<%=request.getContextPath()%>/"+document.forms[0].menuenicon.value;
    		} 
    		
    		function res(){
    			document.forms[0].reset();
    			fullimg();
    		}
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin"
		onload="initDatasource('<%=datasourceName%>')" scroll="no">
		<div id="contentborder" align="center">
			<form method="post" name="moduleform">
				<input type="hidden" name="moduleId" value="<%=moduleId%>">
				<br />
				<br />
				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2">基本属性</FONT>
					</LEGEND>
					<br />
					<br />
					<table width="85%" height="35" border="0" cellpadding="0"
						cellspacing="1" class="thin">
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right">
								<span style="color: #CC0000;">*</span>模块ID：
							</td>
							<td height="35">
								<input type=text name="id" style="width=50%" maxlength="100" />
								<span id="id_message" style="color: #CC0000;" />
							</td>
						</tr>

						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right">
								<span style="color: #CC0000;">*</span>模块名称：
							</td>
							<td height="35">
								<input type=text name="name" style="width=50%" maxlength="100" />
								<span id="name_message" style="color: #CC0000;" />
							</td>
						</tr>

						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								nowrap>
								<span style="color: #CC0000;">*</span>模块未激活图标：
							</td>
							<td height="35">
								<input type=text name="menudisicon" id="menudisicon"
									style="width=50%" maxlength="100"
									value="epp/eppTemplate/itemicon/tb_applymanager_disabled.gif"
									readonly />
								<input type="button" class="input" value="配置..."
									onclick='configicon("dis",menudisicon.value)' />
								<img id="menudisimg" width="32" height="32">
								<span id="menudisicon_message" style="color: #CC0000;" />
							</td>
						</tr>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								nowrap>
								<span style="color: #CC0000;">*</span>模块激活图标：
							</td>
							<td height="35">
								<input type=text name="menuenicon" id="menuenicon"
									style="width=50%" maxlength="100"
									value="epp/eppTemplate/itemicon/tb_applymanager_enabled.gif"
									readonly />
								<input type="button" class="input" value="配置..."
									onclick='configicon("en",menuenicon.value)' />
								<img id="menuenimg" width="32" height="32">
								<span id="menuenicon_message" style="color: #CC0000;" />
							</td>
						</tr>

						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right">
								是否使用：
							</td>
							<td height="35">
								<SELECT ID="used" NAME="used">
									<OPTION VALUE="true" SELECTED>
										活动
									<OPTION VALUE="false">
										不启用
								</SELECT>
							</td>
						</tr>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right">
								是否可以修改：
							</td>
							<td height="35">
								<SELECT ID="isedit" NAME="isedit">
									<OPTION VALUE="true" SELECTED>
										可以
									<OPTION VALUE="false">
										不可以
								</SELECT>
							</td>
						</tr>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right">
								是否可以删除：
							</td>
							<td height="35">
								<SELECT ID="isdelete" NAME="isdelete">
									<OPTION VALUE="true" SELECTED>
										可以
									<OPTION VALUE="false">
										不可以
								</SELECT>
							</td>
						</tr>
						<tr>
							<td width="20%" height="35" class="detailtitle" align="right"
								nowrap>
								数据源选择：
							</td>
							<td height="35">
								<SELECT ID="ds_name" NAME="ds_name">
									<%
									for (int i = 0; i < dsList.size(); i++) {
									%>
									<OPTION id="ds_" +<%=i%>
										value="<%=((Poolman) dsList.get(i)).getDbname()%>">
										<%=((Poolman) dsList.get(i)).getDbname()%>
										<%
										}
										%>
									
								</SELECT>
							</td>
						</tr>						
						<tr class="tr">
							<td height="35" width="20%" class="detailtitle" align="right">
								模块描述：
							</td>
							<td height="35">
								<textarea name="description" rows="4" cols="40" rows="5"></textarea>
							</td>
						</tr>
					</table>
					<br />
					<br />
				</fieldset>

				<table width="85%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="right">
								<br />
								<input name="update" type="button" onClick="addmodule()"
									class="input" value="保存">
								<input name="calc" type="button" class="input" value="重置"
									onclick="res();">
								<input name="calc" type="button" class="input" value="返回"
									onClick="window.close();window.returnValue=true;">
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>
