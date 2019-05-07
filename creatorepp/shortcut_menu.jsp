
<%
	 /**
	 * 
	 * <p>Title: 用户快捷菜单设置页面</p>
	 *
	 * <p>Description: 用户快捷菜单设置页面</p>
	 *
	 * <p>Copyright: Copyright (c) 2009</p>
	 *
	 * <p>Company: chinacreator</p>
	 * @Date 2009-1-12
	 * @author 彭盛
	 * @version 1.0
	 */
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ include file="sysmanager/include/global1.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl,java.util.*"%>
<%@ page
	import="com.chinacreator.epp.shortcutmenu.vo.ResShortcut_menuVo"%>
<%@ page
	import="com.chinacreator.epp.shortcutmenu.dbmanager.Shorcut_menuManager"%>
<%@ page
	import="com.chinacreator.epp.xml.ParseXml,com.chinacreator.config.ConfigManager"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userID = accesscontroler.getUserAttribute("userID");
	String app_id = session.getAttribute(Framework.SUBSYSTEM)
			.toString();
	String menu_id = request.getParameter("menu_id");
	String isSave = request.getParameter("isSave");
	String isShowmenu = request.getParameter("isShowmenu");
	String isCheckmenu = request.getParameter("isCheckmenu");
	String saveMess = "";
	String db_menu = "";

	Shorcut_menuManager shorcut_menuManager = new Shorcut_menuManager();

	if ("true".equals(isSave)) {
		saveMess = shorcut_menuManager.addMenuByisUser(userID, menu_id) ? "true"
		: "false";
	} else if ("del".equals(isSave)) {
		shorcut_menuManager.delMenuByUser(userID);
	}

	if("true".equals(isShowmenu)){
		db_menu = menu_id;
	}else{
		db_menu = shorcut_menuManager.getMenuByisUser(userID);
	}
	List list = new ArrayList();
	if (db_menu != null && !db_menu.trim().equals("")) {
		String[] temp = db_menu.split(",");
		if (temp.length > 0) {
			for (int i = 0; i < temp.length; i++) {
		if (!temp[i].trim().equals("")) {
			ResShortcut_menuVo resShortcut_menuVo = new ResShortcut_menuVo();
			resShortcut_menuVo.setMenu_id(temp[i]);
			resShortcut_menuVo
			.setMenu_name(temp[i].split("#")[1]);
			list.add(resShortcut_menuVo);
		}
			}
		}
	}
	request.setAttribute("sel_menu", list);

	ParseXml px = null;

	String moduleXmlName = ConfigManager.getInstance().getConfigValue(
			"approot")
			+ "/WEB-INF/menuconfig/module.xml";
	if (app_id != null && !app_id.trim().equals("")
			&& !app_id.trim().equals("module")) {
		moduleXmlName = ConfigManager.getInstance().getConfigValue(
		"approot")
		+ "/WEB-INF/menuconfig/module-" + app_id + ".xml";
	}
	px = new ParseXml(moduleXmlName);
	request.setAttribute("px", px);
%>
<html>
	<head>
		<title>属性容器</title>
		<script language="JavaScript" src="changeView.js"
			type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<script language="Javascript">	
	function refresh(){	
		document.Form1.isSave.value="false";	
		document.Form1.action = "shortcut_menu.jsp";
		document.Form1.submit();
	}
	
	function add(){
		var temp = "";
		for(var i=0;i<document.all("select").options.length;i++){												
			temp += document.all("select").options[i].value + ",";
		}
	
		temp += getcheckid();
		
		var obj = new Array();
			obj = temp.split(",");
			for(var j=0;j<obj.length-1;j++){
				for(var k=j+1;k<obj.length;k++){
					if(obj[k]!=""){
						if(obj[j]==obj[k]){							
							obj[k]="";
						}
					}
				}
			}
			var selid = "";
			for(var z=0;z<obj.length;z++){
				if(obj[z]!=""){
					selid += obj[z] + ",";
				}
			}
	
	
		document.Form1.isShowmenu.value="true";
		document.Form1.isSave.value="false";
		document.Form1.menu_id.value=selid;
		document.Form1.action = "shortcut_menu.jsp";
		document.Form1.submit();
	}	
	
	function del(){
		if(document.all("select").selectedIndex < 0){
			    	alert("没有要删除的菜单！");
			    	return;
			}
		var temp = "<%=db_menu%>";
		for(var i=0;i<document.all("select").options.length;i++){
				if(document.all("select").options[i].selected){								
						temp += document.all("select").options[i].value + ",";
					}
			}		
		var obj = new Array();
			obj = temp.split(",");
			for(var j=0;j<obj.length-1;j++){
				for(var k=j+1;k<obj.length;k++){
					if(obj[k]!=""){
						if(obj[j]==obj[k]){							
							obj[j]=obj[k]="";
						}
					}
				}
			}
			var selid = "";
			for(var z=0;z<obj.length;z++){
				if(obj[z]!=""){
					selid += obj[z] + ",";
				}
			}
			
		document.Form1.isShowmenu.value="true";
		document.Form1.isSave.value="false";
		document.Form1.menu_id.value=selid;
		document.Form1.action = "shortcut_menu.jsp";
		document.Form1.submit();
			
	}
	
	function getcheckid(){
			var selid = "<%=db_menu%>";	
				var obj = document.getElementsByName("checkboxValue");
				for (var i=0;i<obj.length;i++) {								
					if (obj[i].checked){
			       		selid += obj[i].value + ",";			       					       		
				   } 
				}				
				return selid;
		}
	
	function getoptions(){
		var temp = "";
		for(var i=0;i<document.all("select").options.length;i++){											
				temp += document.all("select").options[i].value + ",";					
			}	
		return temp;
	}
		
	function fnUp()
        {   
            var sel = document.getElementById("select");
            for(var i=1; i < sel.length; i++)
            {//最上面的一个不需要移动，所以直接从i=1开始
                if(sel.options[i].selected)
                {
                    if(!sel.options.item(i-1).selected)
                    {//上面的一项没选中，上下交换
                          var selText = sel.options[i].text;
                          var selValue = sel.options[i].value;
                          
                          sel.options[i].text = sel.options[i-1].text;
                          sel.options[i].value = sel.options[i-1].value;
                          sel.options[i].selected = false;
                          
                          sel.options[i-1].text = selText;
                          sel.options[i-1].value = selValue;
                          sel.options[i-1].selected=true;
                    }
                }
            }              
        }
        
     function fnDown()
        {
            var sel = document.getElementById("select");
            for(var i=sel.length -2; i >= 0; i--)
            {//向下移动，最后一个不需要处理，所以直接从倒数第二个开始
                if(sel.options.item(i).selected)
                {
                    if(!sel.options.item(i+1).selected)
                    {//下面的Option没选中，上下互换
                          var selText = sel.options.item(i).text;
                          var selValue = sel.options.item(i).value;
                          
                          sel.options.item(i).text = sel.options.item(i+1).text;
                          sel.options.item(i).value = sel.options.item(i+1).value;
                          sel.options.item(i).selected = false;
                          
                          sel.options.item(i+1).text = selText;
                          sel.options.item(i+1).value = selValue;
                          sel.options.item(i+1).selected=true;
                    }
                }
            }       
        }
      
      function menusort(){
	    document.Form1.isShowmenu.value="false";
      	document.Form1.isSave.value="true";
		document.Form1.menu_id.value=getoptions();
		document.Form1.action = "shortcut_menu.jsp";
		document.Form1.submit();
      }
      
      function delusermenu(){
      	if(!confirm("确认恢复默认设置吗？恢复默认设置后将删除原来所有设置项！")){
      		return false;
      	}
      	document.Form1.isCheckmenu.value="false";      	
      	document.Form1.isShowmenu.value="false";      	
      	document.Form1.isSave.value="del";		
		document.Form1.action = "shortcut_menu.jsp";
		document.Form1.submit();
      }
      
    document.oncontextmenu=new Function("event.returnValue=false");
	document.onselectstart=new Function("event.returnValue=false");
      
</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no" >
	<br /><br />
		<form name="Form1" method="post">
			<input type="hidden" name="menu_id" value="<%=menu_id%>">
			<input type="hidden" name="isSave" value="">
			<input name="checkValues" value="" type="hidden" />
			<input type="hidden" name="isShowmenu" value="<%=isShowmenu%>">
			<input type="hidden" name="isCheckmenu" value="true">
					
			<div id="contentborderss" style="width:100%;height:530;overflow:auto"
				align="center">
				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2">快捷菜单设置</FONT>
					</LEGEND>
					<br />
				<table class="">
					<tr align="center"><td>拥有菜单</td><td></td><td>快捷菜单</td></tr>
					<tr align="center">
						<td valign="top">
							<div style="width: 300;height: 300;border:inset;">
								<table class="table" width="50%" border="0" cellpadding="0"
									cellspacing="1">
									
									<tr class="tr">
										<td class="td">
											<div
												style="width: 290;height: 290;overflow:scroll;border:inset;">
												<tree:tree tree="shortcut_menu_tree"
													node="shortcut_menu_tree.node"
													imageFolder="/sysmanager/images/tree_images/"
													collapse="true" includeRootNode="true" href="" target=""
													mode="static">
													<tree:param name="isShowmenu"></tree:param>
													<tree:param name="menu_id"></tree:param>
			

													<tree:checkbox recursive="true" partuprecursive="true"
														name="checkboxValue" />

													<tree:treedata
														treetype="com.chinacreator.epp.shortcutmenu.menu.Shortcut_menu"
														scope="request" rootid="0" rootName="栏目树" expandLevel="1"
														showRootHref="false" needObserver="false"
														refreshNode="true" />
												</tree:tree>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</td>
						<td valign="middle">
							<input type="button" value=" > " class="input" onclick="add();">
							<br />
							<input type="button" value=" < " class=" input" onclick="del();">
						</td>
						<td>
							<div style="width: 300;height: 300;border:inset;">
								<select name="select" multiple style="width:300" size="19">
									<pg:list requestKey="sel_menu" needClear="false">
										<option value="<pg:cell colName="menu_id"/>">
											<pg:cell colName="menu_name" />
										</option>
									</pg:list>
								</select>
							</div>
						</td>
						<td>
							<input type="button" value=" ↑ " class="input" onclick="fnUp();">
							<br />
							<input type="button" value=" ↓ " class="input" onclick="fnDown();">
							<br />
						</td>
					</tr>
				</table>
				<input type="button" value="恢复默认设置" class="input"
					onclick="delusermenu();">
				<input type="button" value="保存" class="input"
					onclick="menusort();">
					</fieldset>
			</div>
		</form>
		
		
	</body><iframe name="saveres" width="0" height="0"></iframe>
</html>
<script language="Javascript">
	if("true"=="<%=saveMess%>"){
		alert("保存成功！");
		top.location.reload();     
	}else if("false"=="<%=saveMess%>"){
		alser("保存失败！");
	}
</script>
