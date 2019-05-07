<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page
	import="com.chinacreator.framework.MenuHelper,com.chinacreator.framework.*,java.util.*"%>
<%@page import="com.chinacreator.framework.Framework"%>
<%!public static String buildItem(HttpServletRequest request, Item item) {
		if (item == null) {
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("$f:'l',");//leaf
		buffer.append("$type:'item',");
		if (item.getAncestor() != null)
			buffer.append("$a:'" + item.getAncestor() + "',");
		if (item.getBottom() != null)
			buffer.append("$b:'" + item.getBottom() + "',");
		if (item.getHeadimg() != null)
			buffer.append("$hi:'" + item.getHeadimg() + "',");
		if (item.getId() != null)
			buffer.append("$i:'" + item.getId() + "',");
		if (item.getLeft() != null)
			buffer.append("$l:'" + item.getLeft() + "',");
		if (item.getLeft_cols() != null)
			buffer.append("$lc:'" + item.getLeft_cols() + "',");
		if (item.getMain() != null)
			buffer.append("$m:'" + item.getMain() + "',");
		if (item.getMenu() != null)
			buffer.append("$me:'" + item.getMenu() + "',");
		if (item.getMouseclickimg() != null)
			buffer.append("$mci:'" + item.getMouseclickimg() + "',");
		if (item.getMouseoutimg() != null)
			buffer.append("$moi:'" + item.getMouseoutimg() + "',");
		if (item.getMouseoverimg() != null)
			buffer.append("$movi:'" + item.getMouseoverimg() + "',");
		if (item.getMouseupimg() != null)
			buffer.append("$mui:'" + item.getMouseupimg() + "',");
		if (item.getName() != null)
			buffer.append("$n:'" + item.getName() + "',");
		if (item.getNavigator_width() != null)
			buffer.append("$nw:'" + item.getNavigator_width() + "',");
		if (item.getNavigatorContent() != null)
			buffer.append("$nc:'" + item.getNavigatorContent() + "',");
		if (item.getNavigatorToolbar() != null)
			buffer.append("$nt:'" + item.getNavigatorToolbar() + "',");
		if (item.getParentPath() != null)
			buffer.append("$pp:'" + item.getParentPath() + "',");
		if (item.getPath() != null) {
			String url = MenuHelper.getPerspectiveContentUrl(request
					.getContextPath(), item.getPath(), (Map) null);
			//String url = MenuHelper.getRootUrl(request.getContextPath(),item.getPath(),(Map)null);
			buffer.append("$p:'" + url + "',");
		}
		if (item.getShowhidden() != null)
			buffer.append("$sh:'" + item.getShowhidden() + "',");
		if (item.getStatusContent() != null)
			buffer.append("$sc:'" + item.getStatusContent() + "',");
		if (item.getStatusToolbar() != null)
			buffer.append("$st:'" + item.getStatusToolbar() + "',");
		if (item.getTarget() != null)
			buffer.append("$t:'" + item.getTarget() + "',");
		if (item.getTitle() != null)
			buffer.append("$ti:'" + item.getTitle() + "',");
		if (item.getTop() != null)
			buffer.append("$to:'" + item.getTop() + "',");
		if (item.getTop_height() != null)
			buffer.append("$th:'" + item.getTop_height() + "',");
		if (item.getWorkspace_height() != null)
			buffer.append("$wh:'" + item.getWorkspace_height() + "',");
		if (item.getWorkspaceContent() != null)
			buffer.append("$wc:'" + item.getWorkspaceContent() + "',");
		if (item.getWorkspaceToolbar() != null)
			buffer.append("$wt:'" + item.getWorkspaceToolbar() + "',");
		buffer.append("$use:'" + item.isUsed() + "',");
		String result = buffer.toString();
		return result.substring(0, result.length() - 1);
	}

	public static String buildModule(Module module) {
		if (module == null) {
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("$f:'b',");//branch
		buffer.append("$type:'module',");
		if (module.getHeadimg() != null)
			buffer.append("$hi:'" + module.getHeadimg() + "',");
		if (module.getId() != null)
			buffer.append("$i:'" + module.getId() + "',");
		if (module.getMouseclickimg() != null)
			buffer.append("$mci:'" + module.getMouseclickimg() + "',");
		if (module.getMouseoutimg() != null)
			buffer.append("$moi:'" + module.getMouseoutimg() + "',");
		if (module.getMouseoverimg() != null)
			buffer.append("$movi:'" + module.getMouseoverimg() + "',");
		if (module.getMouseupimg() != null)
			buffer.append("$mui:'" + module.getMouseupimg() + "',");
		if (module.getName() != null)
			buffer.append("$n:'" + module.getName() + "',");
		if (module.getParentPath() != null)
			buffer.append("$pp:'" + module.getParentPath() + "',");
		if (module.getPath() != null)
			buffer.append("$p:'" + module.getPath() + "',");
		if (module.getTarget() != null)
			buffer.append("$t:'" + module.getTarget() + "',");
		if (module.getTitle() != null)
			buffer.append("$ti:'" + module.getTitle() + "',");
		buffer.append("$use:'" + module.isUsed() + "',");
		String result = buffer.toString();
		return result.substring(0, result.length() - 1);
	}

	public static String recursiveModule(HttpServletRequest request,
			Module module) {
		StringBuffer result = new StringBuffer();
		Map map = new HashMap();
		List list = new ArrayList();
		int count = 0;
		int len = 0;
		ItemQueue items = module.getItems();
		count = items.size();
		if (count > 0) {
			for (int i = 0; i < count; i++) {
				Item _item = items.getItem(i);
				String index = _item.getId();
				map.put(len + "", _item);
				list.add(index);
				len++;
			}
		}
		ModuleQueue modules = module.getSubModules();
		count = modules.size();
		if (count > 0) {
			for (int i = 0; i < count; i++) {
				Module _module = modules.getModule(i);
				String index = _module.getId();
				map.put(len + "", _module);
				list.add(index);
				len++;
			}
		}
		//	Collections.sort(list);
		count = list.size();
		if (count > 0) {
			for (int i = 0; i < count; i++) {
				Object object = map.get(i + "");
				if (object instanceof Item) {
					result
							.append("{" + buildItem(request, (Item) object)
									+ "}");
				} else if (object instanceof Module) {
					result.append("{" + buildModule((Module) object) + ",$is:["
							+ recursiveModule(request, (Module) object) + "]}");
				}
				if (i != count - 1)
					result.append(",");
			}
		}
		return result.toString();
	}%>
<%
	//获取权限控制对象
	AccessControl control = AccessControl.getInstance();
	//权限控制
	control.checkAccess(request, response);
	//子系统id
	String systemId = control.getCurrentSystemID();
	//获取当前子系统可用菜单项
	MenuHelper menuHelper = new MenuHelper(systemId, control);
	//获取publicitem
	Item publicItem = menuHelper.getPublicItem();
	String jsObject = "{publicItem:{" + buildItem(request, publicItem)
			+ "}";
	Module root = new Module();
	//获取一级菜单模块
	ModuleQueue moduleQueue = menuHelper.getModules();
	int count = 0;
	count = moduleQueue.size();
	if (count > 0) {
		for (int i = 0; i < count; i++) {
			root.addSubModule(moduleQueue.getModule(i));
		}
	}
	//获取一级菜单项
	ItemQueue itemQueue = menuHelper.getItems();
	count = itemQueue.size();
	if (count > 0) {
		for (int i = 0; i < count; i++) {
			root.addItem(itemQueue.getItem(i));
		}
	}
	jsObject = jsObject + ",items:[" + recursiveModule(request, root)
			+ "]}";
	//System.out.println(jsObject);
	String menuurl = request.getParameter("menu_path");
	String moduleid = "";
	String itemid = "";
	if(null!=menuurl){
		String[] temp = menuurl.split("menu://");
		if(null!=temp && temp.length>1){
			temp = temp[1].split("/");
			for (int i = 0; i < temp.length; i++) {
				String[] tep = temp[i].split("\\$");
				if(null!=tep && tep.length>1){
					if(tep[1].equals("module")){
						if(moduleid.trim().equals("")){
							moduleid = tep[0];
						}
					}else if(tep[1].equals("item")){
						itemid = tep[0];
					}
				}
			}
		}
	}		
%>
<script>
function getMenuProperty(obj,property) {
	if (obj == null || property == null) {
		return "";
	}
	var result = null;
	switch (property) {
	case "flag" :
		result = obj.$f;
	case "ancestor" :
		result = obj.$a;
	case "bottom" :
		result = obj.$b;
	case "id" :
		result = obj.$i;
	case "left" :
		result = obj.$l;
	case "leftCols" :
		result = obj.$lc;
	case "main" :
		result = obj.$m;
	case "menu" :
		result = obj.$me;
	case "mouseclickImg" :
		result = obj.$mci;
	case "mouseoutImg" :
		result = obj.$moi;
	case "mouseoverImg" :
		result = obj.$movi;
	case "mouseupImg" :
		result = obj.$mui;
	case "navigatorWidth" :
		result = obj.$nw;
	case "navigatorContent" :
		result = obj.$nc;
	case "navigatorToolbar" :
		result = obj.$nt;
	case "path" :
		result = obj.$p;
	case "statusContent" :
		result = obj.$sc;
	case "statusToolbar" :
		result = obj.$st;
	case "target" :
		result = obj.$t;
	case "workspaceHeight" :
		result = obj.wh;
	case "workspaceContent" :
		result = obj.$wc;
	case "workspaceToolbar" :
		result = obj.$wt;
	case "topHeight" :
		result = obj.$th;
	case "headImg" :
		result = obj.$hi;
	case "parentPath" :
		result = obj.$pp;
	case "showHidden" :
		result = obj.$sh;
	case "title" :
		result = obj.$ti;
	case "top" :
		result = obj.$to;
	case "items" :
		result = obj.$is;
	case "name" :
		result = obj.$n;
	}
	return result;
}
var menuObject = <%=jsObject%>;
</script>
<style type="text/css">
<!--
#contentborder1 {
body{
	font-family:Arial, Helvetica, sans-serif;
	color:#226DC7;
	margin: 0;
	padding-top: 0px;
	padding-right: 0px;
	padding-bottom: 0px;
	padding-left: 0px;
	font-size: 12px;
	background-color:#236FC7
}


DIV {
	BORDER-TOP-WIDTH: 0px;
	PADDING-RIGHT: 0px;
	PADDING-LEFT: 0px;
	BORDER-LEFT-WIDTH: 0px;
	BORDER-BOTTOM-WIDTH: 0px;
	PADDING-BOTTOM: 0px;
	MARGIN: 0px;
	PADDING-TOP: 0px;
	BORDER-RIGHT-WIDTH: 0px;

	FLOAT: left
	OVERFLOW: hidden
;
	
	
}
IMG {
	BORDER-TOP-WIDTH: 0px; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BORDER-RIGHT-WIDTH: 0px;FLOAT: left
}
UL {
	BORDER-TOP-WIDTH: 0px; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BORDER-RIGHT-WIDTH: 0px;FLOAT: left;LIST-STYLE-TYPE: none
}


LI {
	BORDER-TOP-WIDTH: 0px; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BORDER-RIGHT-WIDTH: 0px; text-align: center 
}
DT {
	BORDER-TOP-WIDTH: 0px; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BORDER-RIGHT-WIDTH: 0px;FLOAT: left
}
DD {
	BORDER-TOP-WIDTH: 0px; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BORDER-RIGHT-WIDTH: 0px;FLOAT: left
}
H1 {
	BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; PADDING-BOTTOM: 5px; MARGIN: 0px; PADDING-TOP: 5px; BORDER-RIGHT-WIDTH: 0px
}
OL {
	BORDER-TOP-WIDTH: 0px; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BORDER-RIGHT-WIDTH: 0px
}
TEXTAREA {
	FLOAT: left
}
DL {
	BORDER-TOP-WIDTH: 0px; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BORDER-RIGHT-WIDTH: 0px;FLOAT: left
}
#menuContainer {
	background-image: url(epp/eppTemplate/images/left_bj.jpg);
	width: 190px;
	border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 0px;
	border-left-width: 0px;
	overflow: hidden;
	background-repeat: repeat-y;
	padding-top: 0px;
	padding-right: 0px;
	padding-bottom: 5px;
	padding-left: 0px;
	float: left;
	height: 100%;
}

#menuContent {
	text-align: center;
	float: left;
	margin-top: 1px;
	background-color: #CADFF8;
	height: 100%;
	margin-bottom: 6px;
	margin-right: 4px;
	margin-left: -1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-right-style: solid;
	border-bottom-style: solid;
	border-right-color: #053E81;
	border-bottom-color: #053E81;
	width: 100%;
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #053E81;
	padding: 0px;
	overflow: hidden;
}
#menuContent ul{
	padding: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	margin-left: 0px;
}
.menucontent02 ul {
	margin: 0px;
	padding: 0px;
}
.menucontent02 {
	background-image: url(epp/eppTemplate/images/left_06.jpg);
	background-repeat: no-repeat;
	text-align: center;
	margin-top: 3px;
	margin-bottom: 2px;
	padding-left: 0px;
	color: #000;
	font-size: 12px;
	font-weight: bold;
	margin-right: 0px;
	padding-top: 0px;
	line-height: 22px;
	margin-left: 5px;
	padding-right: 2px;
	width: 142px;
	padding-bottom: 0px;
	display: block;
}
.menucontent02 a {
	font-size: 12px;
	color: #000;
	text-decoration: none;
	display: block;
}
.menucontent02 a:link {
	font-size: 12px;
	color: #000;
	text-decoration: none;
	display: block;
}
.menucontent02 a:visited {
	font-size: 12px;
	color: #000;
	text-decoration: none;
	display: block;
}
.menucontent02 a:hover {
	font-size: 12px;
	color: #000;
	text-decoration: none;
	display: block;
}
.menucontent03 {
	background-image: url(epp/eppTemplate/images/left_05.jpg);
	background-repeat: no-repeat;
	text-align: center;
	width: 142px;
	margin-top: 3px;
	margin-bottom: 2px;
	margin-left: 5px;
	padding-left: 0px;
	color: #04649F;
	font-size: 12px;
	font-weight: bold;
	padding-right: 2px;
	margin-right: 0px;
	padding-top: 0px;
	padding-bottom: 0px;
	line-height: 22px;
	display: block;
}
.menucontent03 a:link {
	font-size: 12px;
	font-weight: bold;
	color: #04649F;
	text-decoration: none;
	display: block;
}
.menucontent03 a:visited {
	font-size: 12px;
	font-weight: bold;
	color: #04649F;
	text-decoration: none;
	display: block;
}
.menucontent03 a:hover {
	font-size: 12px;
	font-weight: bold;
	color: #04649F;
	text-decoration: none;
	display: block;
}
.menucontent04 {
	background-color: #CADFF8;
	font-size: 12px;
	color: #000000;
	line-height: 25px;
	font-weight: normal;
	text-align: left;
	width: 142px;
	height:25px;
	
  
}
.menucontent04 a {
	font-size: 12px;
	color: #000000;
	text-decoration: none;
	font-weight: normal;
	line-height: 25px;
	padding-left:25px;
	background-image: url(epp/eppTemplate/images/menucontentico1.gif) ;
	height:25px;
}
.menucontent04 a:visited {
	font-size: 12px;
	color: #000000;
	text-decoration: none;
	font-weight: normal;
	line-height: 25px;
	padding-left:25px;
	height:25px;
	background-image: url(epp/eppTemplate/images/menucontentico.gif) ;
}
.menucontent04 a:hover {
	font-size: 12px;
	color: #2778DA;
	text-decoration: none;
	font-weight: normal;
	background-image: url(epp/eppTemplate/images/menucontentico.gif) ;
	padding-left:25px;
	height:25px;
}
#menuHeader {
	padding-top: 1px;
	padding-right: 0px;
	padding-bottom: 0px;
	padding-left: 2px;
	float: left;
	width: 29px;
	height:94%;
	overflow: hidden;
}
.menuHeader01 {
	font-size: 12px;
	line-height: 14px;
	font-weight: bold;
	color: #000000;
	background-image: url(epp/eppTemplate/images/left_01.jpg);
	background-repeat: no-repeat;
	text-align: center;
	display: block;
	padding-bottom: 3px;
	height: 77px;
	float: left;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 2px;
	margin-left: 0px;
	width: 27px;
	padding-right: 1px;
	line-height: 14px;
	padding-left: 1px;
}
.menuHeader01 a:link {
padding-top: 10px;
	font-size: 12px;
	font-weight: bold;
	color: #000000;
	text-decoration: none;
	display: block;
}
.menuHeader01 a:visited {
padding-top: 10px;
	font-size: 12px;
	font-weight: bold;
	color: #000000;
	text-decoration: none;
	display: block;
}
.menuHeader01 a:hover {
padding-top: 10px;
	font-size: 12px;
	font-weight: bold;
	color: #000000;
	text-decoration: none;
	display: block;
}
.menuHeader02 {
	font-size: 12px;
	font-weight: bold;
	color: #FFFFFF;
	background-image: url(epp/eppTemplate/images/left_02.jpg);
	background-repeat: no-repeat;
	text-align: center;
	display: block;
	height: 77px;
	width: 27px;
	
	padding-bottom: 3px;

	line-height: 14px;
	margin-bottom: 2px;
	padding-right: 1px;
	padding-left: 1px;
}
.menuHeader02 a:link {
padding-top: 10px;
    line-height:16px;
	font-size: 12px;
	font-weight: bold;
	color: #FFFFFF;
	text-decoration: none;
	display: block;
}
.menuHeader02 a:visited {
padding-top: 10px;
	font-size: 12px;
	font-weight: bold;
	color: #FFFFFF;
	text-decoration: none;
	display: block;
}
.menuHeader02 a:hover {
padding-top: 10px;
	font-size: 12px;
	font-weight: bold;
	color: #FFFFFF;
	text-decoration: none;
	display: block;
}
}
-->
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	id="menuContainer">
	<tr>
		<td valign="top" width="29px">
		<img src="epp/eppTemplate/images/up.gif" onmouseover="scrollw(-1)" onmouseout="scrollw(0)"
							onmousedown="scrollw(-3)" title="向上滚动" style="cursor: hand;" vspace="5">
			<div id="menuHeader">
				<ul id="menuHeaderList">
					<li class="menuHeader01">
						个人平台
					</li>
				</ul>
			</div>
		<img src="epp/eppTemplate/images/down.gif" onmouseover="scrollw(1)" onmouseout="scrollw(0)"
							onmousedown="scrollw(3)" title="向下滚动" style="cursor: hand;" vspace="5"hspace="6">
		</td>
		<td valign="top">
			<div id="menuContent">
				<ul>
					<li class="menucontent021">
						待办工作
						<ul>
							<li class="menucontent04">
								<a href="11">三级栏目</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</td>
	</tr>
</table>
<script language="JavaScript">
function scrollw(n)      
{b=n;      
document.getElementById("menuHeader").scrollTop=document.getElementById("menuHeader").scrollTop+b;      
if (b==0) return;      
setTimeout("scrollw(b)",1);      
}
function checka(id){
	if(clicka!=null && clicka!=""){
		$(clicka).style.backgroundImage="url(epp/eppTemplate/images/menucontentico1.gif)";
	}
	if(id!=null && id!=""){
		clicka=id;
		$(id).style.backgroundImage="url(epp/eppTemplate/images/menucontentico.gif)";
	}
}
function tabChange(stairMenuId) {
	if (stairMenuId == hot) {
		return;
	}
	var newId = stairMenuId + "_items";
	var oldId = hot + "_items";
	$(newId).style.display = "";
	$(oldId).style.display = "none";
	$(stairMenuId).className = "menuHeader01";
	$(hot).className = "menuHeader02";
	hot = stairMenuId;
}
function showChange(menuId) {
	var obj = $(menuId + "_items");
	if (obj == null)
		return;
	var display = obj.style.display;
	if (display == "none" || display == null) {
		obj.style.display = "block";
		$(menuId).className = "menucontent02";
	} else {
		obj.style.display = "none";
		$(menuId).className = "menucontent03";
	}
}
//根据id获取对象
function $(o) {return document.getElementById(o);}
//构造一级菜单
function buildStairMenu(stairMenuItem) {
	//一级菜单必须是module
	if (stairMenuItem.$f == 'b') {
		var id = stairMenuItem.$i;
		var mouseClickImg = stairMenuItem.$mci;
		var mouseOutImg = stairMenuItem.$moi;
		var mouseOverImg = stairMenuItem.$movi;
		var mouseUpImg = stairMenuItem.$mui;
		var name = stairMenuItem.$n;
		var parentPath = stairMenuItem.$pp;
		var path = stairMenuItem.$p;
		var target = stairMenuItem.$t;
		var title = stairMenuItem.$ti;
		var li = document.createElement("li");
		//一级菜单是否显示
		if(stairMenuItem.$use=="false"){
			li.style.display="none";
		}
		li.id = id;
		li.className = "menuHeader02";
		li.title = name;//title;
		//li.appendChild(document.createTextNode(name));
		//li.attachEvent("onclick",function(e) {tabChange(id);});
		//"javascript:tabChange('" + id + "')";
		var a = document.createElement("a");
		a.href = "javascript:tabChange('" + id + "');";
		a.onfocus=function(){this.blur();};
		a.appendChild(document.createTextNode(name.length>4?name.substring(0,4):name));
		li.appendChild(a);
		return li;
	}
	return null;
}
function buildMenuItem(stairMenuItem) {
	var pid = stairMenuItem.$i + "_items";
	var ul = document.createElement("ul");
	ul.style.display = "none";
	ul.id = pid;
	reBuildMenuItem(stairMenuItem,ul,null,null);
	return ul;
}
var clicka="";

function reBuildMenuItem(stairMenuItem,ul,sub_li,sub_ul){
	var father_ul;
	if(sub_ul!=null){
		father_ul = sub_ul;
	}else{
		father_ul=ul;
	}
	for (var i = 0, count = stairMenuItem.$is.length; i < count; i++) {
		var name = stairMenuItem.$is[i].$n;
		var path = stairMenuItem.$is[i].$p;
		var title = stairMenuItem.$is[i].$n;
		var id = stairMenuItem.$is[i].$i;
		var type = stairMenuItem.$is[i].$type;
		var li = document.createElement("li");
		if(stairMenuItem.$is[i].$use=="false"){
			li.style.display="none";
		}
		li.id = id;
		li.title =  title;
		var a = document.createElement("a");
		a.appendChild(document.createTextNode(name));
		a.onfocus=function(){this.blur();};
		if("item"==type){
			li.className = "menucontent04";
			a.id = id+"_a";
			a.target = "perspective_content";
			a.href = path;
			a.onclick=function(){checka(this.id);};
		}else if("module"==type){
			li.className = "menucontent02";
			a.href = "javascript:showChange('" + id + "')";
		}  
		li.appendChild(a);
		if(sub_li!=null && sub_ul!=null){
			father_ul.appendChild(li);
			sub_li.appendChild(father_ul);		
			ul.appendChild(sub_li);
		}else{
			ul.appendChild(li);
		}
		if (stairMenuItem.$is[i].$f == "b") {
			var sub_ul = document.createElement("ul");
			sub_ul.id = id + "_items";
			reBuildMenuItem(stairMenuItem.$is[i],father_ul,li,sub_ul);
		}

	}
	//alert(stairMenuItem.$is.length);
}
function buildDefaultMenuItem(stairMenu,headerList,contentList) {
	var isdefaultmenu = false;
	for (var i = 0, count = stairMenu.length; i < count; i++) {
		if(!isdefaultmenu){
			if (stairMenu[i].$f == 'l') {
				var li = document.createElement("li");
				li.id = "glx";
				li.className = "menuHeader02";
				li.title = "功能项";
				var a = document.createElement("a");
				a.href = "javascript:tabChange('glx')";
				a.appendChild(document.createTextNode("功能项"));  
				a.onfocus=function(){this.blur();};
				li.appendChild(a);
				isdefaultmenu = true;
				headerList.appendChild(li);
				break;
			}
		}
	}
	if(isdefaultmenu){
		var pid = "glx_items";
		var ul = document.createElement("ul");
		ul.style.display = "none";
		ul.id = pid;
		for (var i = 0, count = stairMenu.length; i < count; i++) {
			if (stairMenu[i].$f == 'l') {
				var id = stairMenu[i].$i;
				var mouseClickImg = stairMenu[i].$mci;
				var mouseOutImg = stairMenu[i].$moi;
				var mouseOverImg = stairMenu[i].$movi;
				var mouseUpImg = stairMenu[i].$mui;
				var name = stairMenu[i].$n;
				var parentPath = stairMenu[i].$pp;
				var path = stairMenu[i].$p;
				var target = stairMenu[i].$t;
				var title = stairMenu[i].$ti;
				var li = document.createElement("li");
				li.id = id;
				li.title =  name;
				var a = document.createElement("a");
				a.id = id+"_a";
				a.target = "perspective_content";
				a.href = path;
				a.appendChild(document.createTextNode(name));
				a.onfocus=function(){this.blur();};
				a.onclick=function(){checka(this.id);};
				li.className = "menucontent04";
		//		var img = document.createElement("img");
		//		img.src = "epp/eppTemplate/images/lam_d03.jpg";
		//		img.vspace = "2";
		//		li.appendChild(img);
				li.appendChild(a);
				ul.appendChild(li);
			}
		}
		contentList.appendChild(ul);
	}
}
var headerList = $("menuHeaderList");
for (var i = headerList.childNodes.length - 1; i >= 0; i--) {
	headerList.removeChild(headerList.childNodes[i]);
}
var contentList = $("menuContent");
for (var i = contentList.childNodes.length - 1; i >= 0; i--) {
	contentList.removeChild(contentList.childNodes[i]);
}
var stairMenu = menuObject.items;
var hot = null;
var moduleid = "<%=moduleid%>";
var itemid = "<%=itemid%>";
var modulenum = 0;
var tempnum = -1;
for (var i = 0, count = stairMenu.length; i < count; i++) {
	var stairMenuItem = buildStairMenu(stairMenu[i]);
	if (stairMenuItem != null) {
		if(tempnum==-1)
		tempnum = i;
		headerList.appendChild(stairMenuItem);
		contentList.appendChild(buildMenuItem(stairMenu[i]));
		if (hot == null) {
			hot = stairMenu[i].$i;
		}
		if(moduleid==stairMenu[i].$i){
			modulenum=tempnum!=-1?i-tempnum:i;
		}
	}
}
buildDefaultMenuItem(stairMenu,headerList,contentList);
if(moduleid!=""){
	hot = moduleid;
}else{
	if(itemid!=""){
		hot = "glx";
	}
}
if (hot != null) {
	$(hot + "_items").style.display='';
	$(hot).className = "menuHeader01";
}
if(hot!="glx"){
	document.getElementById("menuHeader").scrollTop=modulenum*79;
}else{
	document.getElementById("menuHeader").scrollTop=document.getElementById("menuHeader").scrollHeight;
}
if(itemid!=null && itemid!="" && $(itemid+"_a")!=null){
	clicka=itemid+"_a";
	$(itemid+"_a").style.backgroundImage="url(epp/eppTemplate/images/menucontentico.gif)";
}
</script>
