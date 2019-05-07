<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%@ page import="com.chinacreator.epp.datasourcemanage.DatasourceManage" %>
<%@ page import="com.chinacreator.epp.datasourcemanage.Poolman" %>
<%@ page import="com.chinacreator.epp.menuconfigure.ParseXmlAddDS"%>
<%@ page import="com.chinacreator.framework.Framework"%>
<%@ page import="java.util.*"%>
<%@include file="item.jsp"%>
<html>
	<head>
		<%
			DatasourceManage dm = new DatasourceManage();
			List dsList = dm.getDatasources();
			
			String moduleXmlName = Framework.menu_folder + "module.xml";
			if (currentSystemID != null && !currentSystemID.trim().equals("")
					&& !currentSystemID.trim().equals("module")) {
				moduleXmlName = Framework.menu_folder + "module-" + currentSystemID + ".xml";
			}
			ParseXmlAddDS pxad = new ParseXmlAddDS(moduleXmlName);
			String isedit_item = StringUtil.replaceNull((pxad).getIsEditById(id),"true");
			String isdelete = StringUtil.replaceNull((pxad).getIsDeleteById(id),"true");
			String datasourceName = StringUtil.replaceNull((pxad).getDatasourceById(id),"");
			String fatherdbname = StringUtil.replaceNull((pxad).getDatasourceById(moduleId),"");
		 %>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/treeview.css">
		<tab:tabConfig />
		<base target="_self">
		<title>����ģ��</title>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>

		<!-- �ύ��ҳ���� -->
		<script language="javascript" type="text/javascript" src="pageGrey.js"></script>

		<script language="javascript">
			
			//ͨ��ģ̬���ڷ���ֵ,�����Ӧ��
			function pathConfig(inputID){
				var configtype = "<%=configtype%>";
				var ww = "";
				if(configtype=="1"){
					ww = openWin('<%=request.getContextPath()%>/eformsys/fceform/eformTree/eformTree.jsp',screen.availWidth-320,screen.availHeight-140)
					
					if(ww){
					var form = document.forms[0];
					if(inputID==1){										
						form.navigatortoolbar.value = ww;
					}else if(inputID==2){
						form.navigatorcontent.value = ww;
					}else if(inputID==3){
						form.workspacetoolbar.value = ww;
					}else if(inputID==4){
						form.workspacecontent.value = ww;
					}
				}
				}else if(configtype=="2"){
					ww = openWin('<%=request.getContextPath()%>/jawe/jawe_tree/jaweTree.jsp?ec_id=0',screen.availWidth-320,screen.availHeight-140);
					
					if(ww){
					var form = document.forms[0];
					var path = 'common_workflow/start_form.jsp?mgrName=';
					if(inputID==1){										
						form.navigatortoolbar.value = path + ww;
					}else if(inputID==2){
						form.navigatorcontent.value = path + ww;
					}else if(inputID==3){
						form.workspacetoolbar.value = path + ww;
					}else if(inputID==4){
						form.workspacecontent.value = path + ww;
					}
				}
				}else if(configtype=="3"){
					ww = openWin('<%=request.getContextPath()%>/epp/fileconfigure/fileTree.jsp?app_id=<%=currentSystemID%>',screen.availWidth-320,screen.availHeight-140);
					
					if(ww){
					var form = document.forms[0];					
					if(inputID==1){										
						form.navigatortoolbar.value = ww;
					}else if(inputID==2){
						form.navigatorcontent.value = ww;
					}else if(inputID==3){
						form.workspacetoolbar.value = ww;
					}else if(inputID==4){
						form.workspacecontent.value = ww;
					}
				}
				}else if(configtype=="4"){
					ww = openWin('<%=request.getContextPath()%>/report/report_tree/reportTree.jsp?ec_id=0',screen.availWidth-320,screen.availHeight-140);
					
					if(ww){
					var form = document.forms[0];					
					if(inputID==1){										
						form.navigatortoolbar.value = ww;
					}else if(inputID==2){
						form.navigatorcontent.value = ww;
					}else if(inputID==3){
						form.workspacetoolbar.value = ww;
					}else if(inputID==4){
						form.workspacecontent.value = ww;
					}
					}
				}
			}
					
			//��Ӳ˵���			
			function additem()
			{			
				var form = document.forms[0];
				var id=form.id.value;
				var name=form.name.value;
				var workspacecontent=form.workspacecontent.value;
				var itemdisicon = form.itemdisicon.value;
				var itemenicon = form.itemenicon.value;
			
				if (trim(id).length == 0 ){
			    	document.getElementById("id_message").innerHTML = "��¼��˵���ID��"; 
			    	return false;
			    }else{
			    	document.getElementById("id_message").innerHTML = "";
			    }
				
				 if(id.search(/[^\w]/) !=-1){	
			    	var blank = "";
			    	for(var i=0;i<69;i++)
			    		blank += "&nbsp;";    	
			    	document.getElementById("id_message").innerHTML = "�˵���IDֻ�������֡���ĸ"+"<br/>"+blank+ "���»�����ɣ�"; 			    	
			    	return false;
			    }else{
			    	document.getElementById("id_message").innerHTML = "";
			    }
			    
			    if (trim(name).length == 0 ){
			    	document.getElementById("name_message").innerHTML = "��¼��˵������ƣ�"; 
			    	return false;
			    }else{
			    	document.getElementById("name_message").innerHTML = "";
			    }
				
				 if(name.search(/[^\w\u4e00-\u9fa5]/) !=-1){	
			    	var blank = "";
			    	for(var i=0;i<69;i++)
			    		blank += "&nbsp;";    	
			    	document.getElementById("name_message").innerHTML = "�˵�������ֻ�������֡���ĸ��"+"<br/>"+blank+ "���ֻ��»�����ɣ�"; 			    	
			    	return false;
			    }else{
			    	document.getElementById("name_message").innerHTML = "";
			    }
			    
			    if (trim(itemdisicon).length == 0 ){
			    	document.getElementById("itemdisicon_message").innerHTML = "�����ò˵���δ����ͼ�꣡"; 
			    	return false;
			    }else{
			    	document.getElementById("itemdisicon_message").innerHTML = "";
			    }
			    
			    if (trim(itemenicon).length == 0 ){
			    	document.getElementById("itemenicon_message").innerHTML = "�����ò˵����ͼ�꣡"; 
			    	return false;
			    }else{
			    	document.getElementById("itemenicon_message").innerHTML = "";
			    }
						
				if (trim(workspacecontent).length == 0 ){
			    	document.getElementById("workspacecontent_message").innerHTML = "��¼�빤������������"; 
			    	return false;
			    }else{
			    	document.getElementById("workspacecontent_message").innerHTML = "";
			    }
			
			
				//�ύ��ҳ����
			    popSignFlow(1);
				
		        itemform.action = "additem_do.jsp";
			    itemform.target = "item";
			    //itemform.submit();	  
			   return true;
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
			
			//�ж��û�����
			var isPath = "";
			function evaluate(value){
				isPath = value;
			}
			
			//���ύʱ��ת
			function sub(){
				//������һҳ��
				if(isPath=="backadditem"){					
					itemform.action="additemtab3.jsp";
					document.location.assign("additemtab3.jsp");					
				}//������һҳ�汣��	
				else if(isPath=="nextadditem"){
					return additem();					
				}				
			}
			
			//����һ����������
			var oPopup = window.createPopup();
			//��������ʾͼƬ
			function showImg(showId){
				var moduletype = "<%=moduletype%>";
				var path = "";
				var height_id = 0;
				var height_type = 0;
				if(showId == "1"){
					path = "<%=request.getContextPath()%>/epp/menuconfigure/images/showmodel-1.bmp";
					height_id = 70;					
				}else if(showId == "2"){
					path = "<%=request.getContextPath()%>/epp/menuconfigure/images/showmodel-2.bmp";
					height_id = 105;
				}else if(showId == "3"){
					path = "<%=request.getContextPath()%>/epp/menuconfigure/images/showmodel-3.bmp";
					height_id = 140;
				}else if(showId == "4"){
					path = "<%=request.getContextPath()%>/epp/menuconfigure/images/showmodel-4.bmp";
					height_id = 175;
				}
				
				if(moduletype == "2"){
					height_type = 20;
				}else if(moduletype == "3"){
					height_type = 55;
				}else if(moduletype == "4"){
					height_type = 90;
				}
									
				with (oPopup.document.body) {
					style.backgroundColor="lightyellow";
					style.border="solid black 1px";					
					innerHTML='<img src='+path+' width="300" height="130" />';
				}
				oPopup.show(200, height_id-height_type, 300, 130, document.body);
			}
				
				//����˳��ر�ͼƬ
			function closeImg(){
				oPopup.hide();
			}
			//����ԴĬ��չʾ�ϼ���
			function initDatasource(ds){
				if (trim(ds).length == 0 ){
					jsSelectItemByValue(document.getElementById("ds_name"),"<%=fatherdbname%>");
				}else{
					jsSelectItemByValue(document.getElementById("ds_name"),ds);
				}
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
							form.itemdisicon.value = ww;
						}else if("en"==type){
							form.itemenicon.value = ww;
						}
					}
				fullimg();
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
		
		function fullimg(){
   			document.forms[0].itemdisimg.src = "<%=request.getContextPath()%>/"+document.forms[0].itemdisicon.value;
			document.forms[0].itemenimg.src = "<%=request.getContextPath()%>/"+document.forms[0].itemenicon.value;
    	}
    	
    	function resetpage() {
			document.forms[0].reset();
			fullimg();
		}  
			
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" onload="initDatasource('<%=datasourceName %>');fullimg();" scroll="no">
		<div id="contentborder" align="center">
			<form method="post" name="itemform" onsubmit="return sub();">&nbsp;  
				<input type="hidden" name="configtype" value="<%=configtype%>" />
				<input type="hidden" name="moduletype" value="<%=moduletype%>">
				<input type="hidden" name="currentSystemID"
					value="<%=currentSystemID%>" />
				<input type="hidden" name="moduleId" value="<%=moduleId%>" />
				<input type="hidden" name="isEdit" value="<%=isEdit%>" />
				<input type="hidden" name="isFill" value="true" />

				<br />
				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2"> ģ������</FONT>
					</LEGEND>
					<br />
					<table width="85%" height="35" border="0" cellpadding="0"
						cellspacing="1" class="thin">
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								nowrap>
								<span style="color: #CC0000;">*</span>�˵���ID��
							</td>
							<td height="35">
								<input type=text name="id" style="width=50%" maxlength="100"
									value="<%=id%>" readonly />
								<span id="id_message" style="color: #CC0000;" />
							</td>
						</tr>

						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								nowrap>
								<span style="color: #CC0000;">*</span>�˵������ƣ�
							</td>
							<td height="35">
								<input type=text name="name" style="width=50%" maxlength="100"
									value="<%=name%>" />
								<span id="name_message" style="color: #CC0000;" />
							</td>
						</tr>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right" nowrap>
								<span style="color: #CC0000;">*</span>�˵���δ����ͼ�꣺
							</td>
							<td height="35">
								<input type=text name="itemdisicon" id="itemdisicon"
									style="width=50%" maxlength="100" value="<%=itemdisicon %>"
									 readonly/>
								<input type="button" class="input" value="����..."
									onclick='configicon("dis",itemdisicon.value)' />
								<!-- <input type="button" class="input" value="���"
									onclick='itemdisicon.value="";' /> -->
								<img id="itemdisimg" width="32" height="32">
								<span id="itemdisicon_message" style="color: #CC0000;" />
							</td>
						</tr>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right" nowrap>
								<span style="color: #CC0000;">*</span>�˵����ͼ�꣺
							</td>
							<td height="35">
								<input type=text name="itemenicon" id="itemenicon"
									style="width=50%" maxlength="100" value="<%=itemenicon %>"
									 readonly/>
								<input type="button" class="input" value="����..."
									onclick='configicon("en",itemenicon.value)' />
								<!-- <input type="button" class="input" value="���"
									onclick='itemenicon.value="";' /> -->
								<img id="itemenimg" width="32" height="32">
								<span id="itemenicon_message" style="color: #CC0000;" />
							</td>
						</tr>
						<%
							switch (Integer.parseInt(moduletype)) {
							case 1:
						%>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								onmouseover="showImg('1');" onmouseout="closeImg();"
								bgcolor="#F6FFEF" nowrap>
								��������������
							</td>
							<td height="35">
								<input type=text name="workspacetoolbar" id="workspacetoolbar"
									style="width=50%" maxlength="100" value="<%=workspacetoolbar.trim()%>"
									readonly />
								<input type="button" class="input" value="����..."
									onclick='pathConfig("3")' />
								<input type="button" class="input" value="���"
									onclick='workspacetoolbar.value="";' />
							</td>
						</tr>
						<%
						case 2:
						%>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								onmouseover="showImg('2');" onmouseout="closeImg();"
								bgcolor="#F6FFEF" nowrap>
								��������������
							</td>
							<td height="35">
								<input type="text" name="navigatortoolbar" id="navigatortoolbar"
									style="width=50%" maxlength="100" value="<%=navigatortoolbar.trim()%>"
									readonly />
								<input type="button" class="input" value="����..."
									onclick='pathConfig("1")' />
								<input type="button" class="input" value="���"
									onclick='navigatortoolbar.value="";' />
							</td>
						</tr>


						<%
						case 3:
						%>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								onmouseover="showImg('3');" onmouseout="closeImg();"
								bgcolor="#F6FFEF" nowrap>
								��������������
							</td>
							<td height="35">
								<input type="text" name="navigatorcontent" id="navigatorcontent"
									style="width=50%" maxlength="100" value="<%=navigatorcontent.trim()%>"
									readonly />
								<input type="button" class="input" value="����..."
									onclick='pathConfig("2")' />
								<input type="button" class="input" value="���"
									onclick='navigatorcontent.value="";' />
							</td>
						</tr>


						<%
						case 4:
						%>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								onmouseover="showImg('4');" onmouseout="closeImg();"
								bgcolor="#F6FFEF" nowrap>
								<span style="color: #CC0000;">*</span>��������������
							</td>
							<td height="35">
								<input type=text name="workspacecontent" id="workspacecontent"
									style="width=50%" maxlength="100" value="<%=workspacecontent.trim()%>"
									/>
								<input type="button" class="input" value="����..."
									onclick='pathConfig("4")' />
								<input type="button" class="input" value="���"
									onclick='workspacecontent.value="";' />
								<span id="workspacecontent_message" style="color: #CC0000;" />
							</td>
						</tr>
						<%
						}
						%>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								nowrap>
								�Ƿ�ʹ�ã�
							</td>
							<td height="35">
								<SELECT ID="isUsed" NAME="isUsed">
									<%
									if (isUsed.equals("false")) {
									%>
									<OPTION VALUE="true">
										�
									<OPTION VALUE="false" SELECTED>
										������
										<%
									} else {
									%>
									
									<OPTION VALUE="true" SELECTED>
										�
									<OPTION VALUE="false">
										������
										<%}%>
								</SELECT>
							</td>
						</tr>
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								nowrap>
								�Ƿ�����޸ģ�
							</td>
							<td height="35">
								<SELECT ID="isedit_item" NAME="isedit_item">
									<%
									if (isedit_item.equals("false")) {
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
						<tr class="tr">
							<td width="20%" height="35" class="detailtitle" align="right"
								nowrap>
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
					</table>
					<br />
				</fieldset>
				<table width="85%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="right">
								<br />
								<input name="update" type="submit"
									onclick="evaluate('backadditem')" class="input" value="��һ��">
								<%if("false".equals(isedit_item.trim())){ %>
								<input name="update" type="submit" class="input" value="����" disabled="disabled">
								<%}else{ %>
								<input name="update" type="submit"
									onclick="evaluate('nextadditem')" class="input" value="����">
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
	<iframe name="item" width="0" height="0" style="display: none;"></iframe>
</html>
