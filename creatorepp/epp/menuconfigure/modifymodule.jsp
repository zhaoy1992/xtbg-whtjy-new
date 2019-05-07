<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu,
			com.frameworkset.util.StringUtil,
			com.chinacreator.epp.xml.ParseXml,
			com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.epp.menuconfigure.ParseXmlAddDS"%>			
<%@ page import="com.chinacreator.framework.Framework"%>
<%@ page import="com.chinacreator.epp.datasourcemanage.DatasourceManage" %>
<%@ page import="com.chinacreator.epp.datasourcemanage.Poolman" %>
<%@ page import="java.util.*" %>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	//Ӧ���ɵ�ǰ��Ӧ��id��ö�Ӧ�Ĳ˵��ļ���Ϣ
	//�˵��ļ�����ʽ��module-{currentSystemID}.xml
	String currentSystemID = control.getCurrentSystemID();

	String moduleId = StringUtil.replaceNull(request
			.getParameter("moduleId"));

	String moduleXmlName = Framework.menu_folder + "module.xml";
	if (currentSystemID != null && !currentSystemID.trim().equals("")
			&& !currentSystemID.trim().equals("module")) {
		moduleXmlName = Framework.menu_folder + "module-" + currentSystemID + ".xml";
	}

	//Ӧ���ɵ�ǰ��Ӧ��id��ö�Ӧ�Ĳ˵��ļ���Ϣ
	ParseXml px = new ParseXmlAddDS(moduleXmlName);
	String id = StringUtil.replaceNull(px.getNodePropById(moduleId,
			"module", "id"));
	String name = StringUtil.replaceNull(px.getNodePropById(moduleId,
			"module", "name"));
	String used = StringUtil.replaceNull(px.getNodePropById(moduleId,
			"module", "used"));
	//added by С�� 20100823
	//�� "false "��Ϊ����״̬
	if(!"false".equals(used)){
		used="true";
	}
	// add end
	String isedit = StringUtil.replaceNull(((ParseXmlAddDS)px).getIsEditById(moduleId));
	String isdelete = StringUtil.replaceNull(((ParseXmlAddDS)px).getIsDeleteById(moduleId));
	String description = StringUtil.replaceNull(px
			.getModuleDescription(moduleId));
	String datasourceName=StringUtil.replaceNull(((ParseXmlAddDS)px).getDatasourceById(id));
	//add by wen.zhu 20100804
	//����ͼ�� 
	String menudisicon = StringUtil.replaceNull(px.getNodeTextByMenuIdAndTagName(id,"mouseoutimg"));
	String menuenicon = StringUtil.replaceNull(px.getNodeTextByMenuIdAndTagName(id,"mouseupimg"));
	String menudisiconPath = request.getContextPath()+"/"+menudisicon;
	String menueniconPath = request.getContextPath()+"/"+menuenicon;
	
	DatasourceManage dm = new DatasourceManage();
	List dsList = dm.getDatasources();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/treeview.css">
		<tab:tabConfig />
		<title>����ģ��</title>
		<!-- add by wen.zhu ����ͼ�갴ť -->
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>
		<!-- �ύ��ҳ���� -->
		<script language="javascript" type="text/javascript" src="pageGrey.js"></script>

		<script language="javascript">
			
			function modifymodule()
			{
				
				var form = document.forms[0];
				var id=form.id.value;
				var name=form.name.value;
				
				if (trim(id).length == 0 ){
			    	document.getElementById("id_message").innerHTML = "��¼��ģ��ID��"; 
			    	return false;
			    }else{
			    	document.getElementById("id_message").innerHTML = "";
			    }
				
				 if(id.search(/[^\w]/) !=-1){	
			    	var blank = "";
			    	for(var i=0;i<52;i++)
			    		blank += "&nbsp;";    	
			    	document.getElementById("id_message").innerHTML = "ģ��IDֻ�������֡���ĸ"+"<br/>"+blank+ "���»�����ɣ�"; 			    	
			    	return false;
			    }else{
			    	document.getElementById("id_message").innerHTML = "";
			    }
			    
			    if (trim(name).length == 0 ){
			    	document.getElementById("name_message").innerHTML = "��¼��ģ�����ƣ�"; 
			    	return false;
			    }else{
			    	document.getElementById("name_message").innerHTML = "";
			    }
				
				 if(name.search(/[^\w\u4e00-\u9fa5]/) !=-1){	
			    	var blank = "";
			    	for(var i=0;i<52;i++)
			    		blank += "&nbsp;";    	
			    	document.getElementById("name_message").innerHTML = "ģ������ֻ�������֡���ĸ��"+"<br/>"+blank+ "���ֻ��»�����ɣ�"; 			    	
			    	return false;
			    }else{
			    	document.getElementById("name_message").innerHTML = "";
			    }
							
				//�ύ��ҳ����
			    //popSignFlow(1);
		        moduleform.action = "modifymodule_do.jsp";
			    moduleform.target = "hiddenFrame";
			    moduleform.submit();
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
		
			function initDatasource(ds){
				if(ds!=null){
					document.getElementById("ds_name").value=ds;
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
    		
    		function resetpage() {
				document.forms[0].reset();
				fullimg();
			} 
		
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" onLoad="initDatasource('<%=datasourceName %>')" scroll="no">
		<div id="contentborder" align="center">
			<form method="post" name="moduleform" >

				<br />
				<br />
				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2"> ��������</FONT>
					</LEGEND>
					<br />
					<br />
					<table width="85%" height="35" border="0" cellpadding="0"
						cellspacing="1" class="thin">
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right">
								<span style="color: #CC0000;">*</span>ģ��ID��
							</td>
							<td height="35">
								<input type=text name="id" style="width=50%" maxlength="100"
									readOnly value="<%=id%>" />
								<span id="id_message" style="color: #CC0000;" />
							</td>
						</tr>

						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right">
								<span style="color: #CC0000;">*</span>ģ�����ƣ�
							</td>
							<td height="35">
								<input type=text name="name" style="width=50%" maxlength="100"
									value="<%=name%>" />
								<span id="name_message" style="color: #CC0000;" />
							</td>
						</tr>
						
						<!-- add by  wen.zhu ����ͼ�� 20100804 -->
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								nowrap>
								<span style="color: #CC0000;">*</span>ģ��δ����ͼ�꣺
							</td>
							<td height="35">
								<input type=text name="menudisicon" id="menudisicon"
									style="width=50%" maxlength="100"
									value="<%=menudisicon %>"
									readonly />
								<input type="button" class="input" value="����..."
									onclick='configicon("dis",menudisicon.value)' />
								<img id="menudisimg" width="32" height="32" src="<%=menudisiconPath %>">
								<span id="menudisicon_message" style="color: #CC0000;" />
							</td>
						</tr>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								nowrap>
								<span style="color: #CC0000;">*</span>ģ�鼤��ͼ�꣺
							</td>
							<td height="35">
								<input type=text name="menuenicon" id="menuenicon"
									style="width=50%" maxlength="100"
									value="<%=menuenicon %>"
									readonly />
								<input type="button" class="input" value="����..."
									onclick='configicon("en",menuenicon.value)' />
								<img id="menuenimg" width="32" height="32" src="<%=menueniconPath %>"/>
								<span id="menuenicon_message" style="color: #CC0000;" />
							</td>
						</tr>

						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right">
								�Ƿ�ʹ�ã�
							</td>
							<td height="35">
								<SELECT ID="used" NAME="used">
									<%
									if (used.equals("true")) {
									%>
									<OPTION VALUE="true" SELECTED>
										�
									<OPTION VALUE="false">
										������
										<%
									} else {
									%>									
									<OPTION VALUE="true">
										�
									<OPTION VALUE="false" SELECTED>
										������
										<%}%>
								</SELECT>
							</td>
						</tr>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right">
								�Ƿ�����޸ģ�
							</td>
							<td height="35">
								<SELECT ID="isedit" NAME="isedit">
									<%
									if (isedit.equals("false")) {
									%>
									<OPTION VALUE="true" >
										����
									<OPTION VALUE="false" SELECTED>
										������
										<%
									} else {
									%>									
									<OPTION VALUE="true" SELECTED>
										����
									<OPTION VALUE="false">
										������
										<%}%>
								</SELECT>
							</td>
						</tr>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right">
								�Ƿ����ɾ����
							</td>
							<td height="35">
								<SELECT ID="isdelete" NAME="isdelete">
									<%
									if (isdelete.equals("false")) {
									%>
									<OPTION VALUE="true">
										����
									<OPTION VALUE="false" SELECTED>
										������
										<%
									} else {
									%>									
									<OPTION VALUE="true" SELECTED>
										����
									<OPTION VALUE="false">
										������
										<%}%>
								</SELECT>
							</td>
						</tr>
					<tr>
						<td width="20%" height="35" class="detailtitle" align="right"
							nowrap>
							����Դѡ��
						</td>
						<td height="35">
							<SELECT ID="ds_name" NAME="ds_name" >							
								<%
								for(int i=0;i<dsList.size();i++) {
								%>
								<OPTION id="ds_"+<%=i %> value="<%=((Poolman)dsList.get(i)).getDbname()%>" ><%=((Poolman)dsList.get(i)).getDbname() %>								
								<%
								}
								%>								
							</SELECT>
						</td>
					</tr>
						<tr class="tr">
							<td height="35" width="20%" class="detailtitle" align="right">
								������
							</td>
							<td height="35">
								<textarea name="description" rows="4" cols="40" rows="5"><%=description%></textarea>
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
								<%if("false".equals(isedit.trim())){ %>
								<input name="update" type="button" class="input" value="����" disabled="disabled">
								<%}else{ %>
								<input name="update" type="button" onClick="modifymodule()"
									class="input" value="����">
								<%} %>
								<input name="calc" type="button" class="input" onclick="resetpage();" value="����">
								<input name="calc" type="button" class="input" value="����"
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
