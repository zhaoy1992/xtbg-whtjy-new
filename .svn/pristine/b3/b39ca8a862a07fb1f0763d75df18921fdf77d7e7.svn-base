<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.eppissue.menuissue.expmenu.menu.ExpFileManager"%>
<%@ page import="com.chinacreator.config.ConfigManager" %>
<%@page import="com.chinacreator.eppissue.menuissue.interfaces.IComponentsExpManage"%>
<%@page import="com.chinacreator.eppissue.menuissue.factorys.ComponentsFactory"%>
<%@page import="java.util.*"%>
<%@include file="expmenuconfigvo.jsp"%>
<%
String fileRoot = ConfigManager.getInstance().getConfigValue("approot");
fileRoot = fileRoot.replace("\\","/");
while(fileRoot.lastIndexOf("/")==fileRoot.length()-1){
	fileRoot = fileRoot.substring(0,fileRoot.endsWith("/")?fileRoot.length()-1:fileRoot.length());
}
String rootName = fileRoot.substring(fileRoot.lastIndexOf("/")+1,fileRoot.length());
//得到流程绑定的其他文件路径 
String eformpath = "";
IComponentsExpManage jaweExpManage = ComponentsFactory.getIComponentsExpManage(com.chinacreator.eppissue.menuissue.configutil.ConfigManage.sfs_JAWE);
if(null!=jaweExpManage){
		Map map = jaweExpManage.getEformIDsByJaweID(moduleID,default_jawe_id+sel_jawe_id);
		if(null!=map){
			eformpath = (String)map.get("eformpath");
			if(null==eformpath||eformpath.trim().equals("")){
				eformpath = "";
			}
		}
	}
String [] filePaths = (default_filepath+sel_filepath+","+eformpath).split(",");
String [] defaultPaths = (default_filepath+","+eformpath).split(",");
StringBuffer selbuffer = new StringBuffer().append(""); 
StringBuffer defbuffer = new StringBuffer().append("");
for(int i=0; i<filePaths.length;i++){
	if(null!=filePaths[i] && !filePaths[i].trim().equals("")){
		selbuffer.append(fileRoot+"/"+filePaths[i]).append(",");
	}
}
for(int i=0; i<defaultPaths.length;i++){
	if(null!=defaultPaths[i] && !defaultPaths[i].trim().equals("")){
		defbuffer.append(fileRoot+"/"+defaultPaths[i]).append(",");
	}
}
%>

<html>
	<head>
		<title>属性容器</title>

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" 
			href="<%=request.getContextPath()%>/sysmanager/applymanager/xyTree/xtree.css">
			
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>

		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
	  
	
	    <!-- 为了使用带复选框树，无顺序 -->
	    <script src="<%=request.getContextPath()%>/sysmanager/applymanager/xyTree/DivTree.js"></script>
	    <script src="<%=request.getContextPath()%>/sysmanager/applymanager/xyTree/Tree.js"></script>
	    <script src="<%=request.getContextPath()%>/sysmanager/applymanager/xyTree/Node.js"></script>
	    <script src="<%=request.getContextPath()%>/sysmanager/applymanager/xyTree/map.js"></script>
		<!-- dwr begin-->
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/sysmanager/applymanager/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/expfilemanager.js'></script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/menuissueChange.js'></script>
		<!-- dwr end -->

		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript"
			src="../pageGrey.js">
		</script>

		<script language="JavaScript">
	
	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	function getApplyInfo(e,app_id){
	jsAccessControl.setBackColor(e);
	document.all("selectId").value = app_id;	
	}	
	
	//页面跳转
	function jumpPage(obj){
		document.getElementById("sel_filepath").value = getAllSelected();
		if(obj=="eformlist"){
			document.filelistform.action="eformlist.jsp";
		}else if(obj=="jawelist"){
			document.filelistform.action="jawelist.jsp";
		}else if(obj=="reportlist"){
			document.filelistform.action="reportlist.jsp";		
		}else if(obj=="back"){	
			document.filelistform.action="businessclassselect.jsp";
		}else if(obj=="next"){
			document.filelistform.action="showeformselect.jsp";
		}else{
			return;
		}
		
		//提交后页面变灰
		popSignFlow(1);
		
		document.filelistform.submit();
	}	

		function getcheckid(){
			var selid = "<%=sel_eform_id%>";	
				var obj = document.getElementsByName("checkBoxOne");
				for (var i=0;i<obj.length;i++) {								
					if (obj[i].checked){
			       		selid += obj[i].value + ",";			       					       		
				   } 
				}				
				return selid;				
		}
				
		function addeform(){
			if(getcheckid()==""){
				alert("请选择表单！");
				return;
			}else{
				//提交后页面变灰
				popSignFlow(1);
				document.filelistform.sel_eform_id.value=getcheckid();
				document.filelistform.submit();
			}
		}
		
		function addalleformresult(obj){
			document.filelistform.sel_eform_id.value=obj;
			document.filelistform.submit();
		}
		
		function deleform(){
			if(document.all("select").selectedIndex < 0){
			    	alert("没有要删除的表单！");
			    	return;
			}							
			//提交后页面变灰
			popSignFlow(1);
			var temp = "<%=sel_eform_id%>";
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
			document.filelistform.sel_eform_id.value=selid;
			document.filelistform.submit();
		}
		
		function delalleform(){
			//提交后页面变灰
			popSignFlow(1);
			document.filelistform.sel_eform_id.value='';
			document.filelistform.submit();			
		}
		
		//选择用户
		function operuserlist(){
			var ww = openWin('userlist.jsp?app_id=<%=control.getCurrentSystemID()%>&&creator_person='+document.filelistform.creator_person.value,screen.availWidth-520,screen.availHeight-400);
			if(ww)
			{
				document.filelistform.creator_person.value=ww;				
			}
		}
		
		//展示table的模板
		var tableArr =  new Array();
		tableArr.push("<table id=mytable width='100%' border='0' cellpadding='0' cellspacing='1'class='thin'>");
		tableArr.push("<tr>");
		tableArr.push("<td height='20' class='tablecells' align=center colspan=3>");
		tableArr.push("<b>已选文件</b>");
		tableArr.push("</td>");
		tableArr.push("</tr>");
		tableArr.push("<tr>");
		tableArr.push("<td width='70%' height='20' class='headercolor' align=center >");
		tableArr.push("<b>文件列表</b>");
		tableArr.push("</td>");
		tableArr.push("<td width='30%' height='20' class='headercolor' align=center >");
		tableArr.push("<b>文件类型</b>");
		tableArr.push("</td>");
		tableArr.push("<td width='30%' height='20' class='headercolor' align=center >");
		tableArr.push("<b>操作</b>");
		tableArr.push("</td>");
		tableArr.push("</tr>");
		var tableStr = tableArr.join("");
		
		var tr = "<tr ";
		//var dblclick=" ondblclick=delSelected('";
		var delonclick = "onclick = delSelected('"
		var dblclick_back ="')";
		var tr_back=">"
		var b = "<b >";
		var tr_over="</tr>";
		var td_over = "</td>";
		var b_over="</b>";
		var td_fileList ="<td width='70%' height='20' class='tablecells' align=left >";
		var td_fileType ="<td width='20%' height='20' class='tablecells' align=center >";
		var td_button   ="<td width='10%' height='20' class='tablecells' align=center >";
		var del_button = "<input type='button' value='删除' class='input' ";
		//生成table的元素
		function createTableElement(node){
			//return tr+dblclick+encodeURI(node.id)+dblclick_back+tr_back+td_fileList+b+node.id.replace(fileRoot+"/","")+b_over+td_over+td_fileType+b+node.type+b_over+td_over+td_button+del_button+delonclick+encodeURI(node.id)+dblclick_back+tr_back+td_over+tr_over;
			return tr+tr_back+td_fileList+b+node.id.replace(fileRoot+"/","")+b_over+td_over+td_fileType+b+node.type+b_over+td_over+td_button+del_button+delonclick+encodeURI(node.id)+dblclick_back+tr_back+td_over+tr_over;
		}
		
		//生成默认table的元素 对类型的生成用名称是否带 "." 来判断 不严谨  
		//如有必要通过ajax调用后台来读取文件类型
		function defaultcreateTableElement(str){
			//return tr+dblclick+encodeURI(str)+dblclick_back+tr_back+td_fileList+b+str.replace(fileRoot+"/","")+b_over+td_over+td_fileType+b+(str.indexOf(".")!=-1?"file":"directory")+b_over+td_over+td_button+del_button+delonclick+encodeURI(str)+dblclick_back+tr_back+td_over+tr_over;
			return tr+tr_back+td_fileList+b+str.replace(fileRoot+"/","")+b_over+td_over+td_fileType+b+(str.indexOf(".")!=-1?"file":"directory")+b_over+td_over+td_button+td_over+tr_over;
		}
		
		function createTableElementByDel(str){
			return tr+tr_back+td_fileList+b+str.replace(fileRoot+"/","")+b_over+td_over+td_fileType+b+(str.indexOf(".")!=-1?"file":"directory")+b_over+td_over+td_button+del_button+delonclick+encodeURI(str)+dblclick_back+tr_back+td_over+tr_over;
		}
		
		//双击table行去除树上选择的节点 map中删除节点 如果子节点为空 在树未展开的情况下 父节点选择为2 的去除选择
		function delSelected(nodeId){
			tempMap.remove(nodeId);
			var flag  = false;
		
			map.remove(decodeURI(nodeId));
			var node = MyContent.findOneNodeById(decodeURI(nodeId));
			if(node!=null&&node!="undifined"&&node.checked==1){
				node.getHtmlElementfuxuanimg().onclick();
			}else{
				show();
			}
		}

		
		
		//树开始 
		/**
		*ajax树
		*在点击后动态加载数据
		*/
		var openflag = false;//是否点击过树,一旦点击过则使用选择后的文件 否则不改变选择
		var defaultFiles= "<%=defbuffer.toString()%>";
		var selFiles= "<%=selbuffer.toString()%>";
		var fileRoot ="<%= fileRoot%>";
		var fileArr = selFiles.split(",");
		var defArr = defaultFiles.split(",");
		var map = new Map();//存放所有文件,用来判断是否有文件夹被全选或文件被选
		var defMap = new Map();//存放没默认文件所有路径
		var tableMap = new Map(); //存放table html 键值对 
		var se_arr = new Array(); //存放初始化后的table
		
		for(i=0;i<fileArr.length;i++){
			if(fileArr[i]==""||fileArr[i]==undefined) continue;
			map.put(fileArr[i],"true");
		}
		for(i=0;i<defArr.length;i++){
			if(defArr[i]==""||defArr[i]==undefined) continue;
			defMap.put(defArr[i],"true");
		}
		var tempMap = new Map();//存放所有路径,用来判断是否有子文件夹或子文件被选 -new
		for(i=0;i<map.keys.length;i++){
			if(map.keys[i]==""||map.keys[i]==undefined) continue;
		  	getAllHasSelectedPath(map.keys[i]);
		}
		function getAllHasSelectedPath(fileName){//递归获得所有文件及文件夹的所有父目录
			if(fileName ==fileRoot)return; 
			fileName = fileName.substring(0,fileName.lastIndexOf("/"));
			tempMap.put(fileName,"true");
			getAllHasSelectedPath(fileName);
		}
		var defTempMap = new Map();
		for(i=0;i<defMap.keys.length;i++){
			if(defMap.keys[i]==""||defMap.keys[i]==undefined) continue;
		  	getDefHasSelectedPath(defMap.keys[i]);
		}
		function getDefHasSelectedPath(fileName){//递归获得所有文件及文件夹的所有父目录
			if(fileName ==fileRoot)return; 
			fileName = fileName.substring(0,fileName.lastIndexOf("/"));
			defTempMap.put(fileName,"true");
			getDefHasSelectedPath(fileName);
		}
		
		var MyContent = new xyTree.DivTree('<%=rootName%>...');
		//全局变量 
		var loadinggifnode;
		function initTree(){
			 document.getElementById('fileTree').appendChild(MyContent.div);
			 //初始化 是否有节点被选中 
			 if(selFiles!=""||fileArr!="undifine"){
				 MyContent.tree.root.getHtmlElementfuxuanimg().src=xyTree.TreeConfig.jubuzhongIcon;
			 }
	  		 MyContent.init(getNodeStr,getRootStr);
	  		 MyContent.div.firstChild.firstChild.nextSibling.onclick=function(){};
  		 }
  		 
  		function getRootStr(node){
  		  	loadinggifnode = node; //节点全局变量
  		  	var id   = "<%=fileRoot%>";//获取路径 
  		  	loadinggifnode.id = id;
  		  	loadinggifnode.type= "directory";
		  	if (node.child.length>0)return; //如果已经添加了子节点则返回
		  	if(node.nochild)return;         //如果节点有这个属性也返回，这个属性是给节点赋值时加的
		  	node.loadingGif();
		  	expfilemanager.getNodeStr(id,"<%=rootName%>",treeData);
  		 }
  		 
  		function getNodeStr(node){
  			if(node.type == "file"){
  				node.getHtmlElementfuxuanimg().onclick();
  			}
		  	loadinggifnode = node;
		 	if (node.child.length>0)return; //如果已经添加了子节点则返回
		 	if(node.type!= "file"){
		  	node.loadingGif();
		  	expfilemanager.getNodeStr(node.id,node.id,treeData); 
		  	}
		  	
		}
		var first=1;
		function treeData(nodeStr){   //服务器的回调
			var str ="{"+ nodeStr+"}";
		 	var arr = { };
  			arr=eval( '('+ str+')' ); //字符串转为对象
		  	var nodearr = [];
		  	var str = loadinggifnode.id+"...";
		  	if(first==1){
		  		 str =loadinggifnode.name;
		  	}
		  	var strarr = arr[str]; //使用对象的关联数组特性
		  	first+=1;
		  	for(var i=0;i < strarr.length;i++){    //    获得节点的下一级子节点
			    var newnode = new xyTree.Node(strarr[i]);
			    newnode.toString = function (){return this.name;};//为了显示结果
			    if(!((/\.\.\./).test(strarr[i])))  {//如果是...结尾的，加个属性
			     	newnode.nochild = true; //这句话是重要的，免得没子节点还ajax，自定义属性
			      	newnode.id = loadinggifnode.id+"/"+strarr[i]; //添加文件id
			      	newnode.type = "file";//文件节点类型
			    }else{
			    	newnode.id = strarr[i].substring(0,strarr[i].length-3); //添加文件夹id
			    	newnode.type = "directory";//文件夹节点类型
			    	newnode.name = newnode.name.replace(loadinggifnode.id+"/","");
			    	newnode.img = xyTree.TreeConfig.folderIcon;
			    }
			    nodearr.push(newnode);
		  } 
		  
		  loadinggifnode.addDynamic(nodearr); //动态添加
		  loadinggifnode.loadingGifRenew(); //其实这句话完全可以不加
		  var nodes  = loadinggifnode.child;
		  if(map.size() != 0){//&&MyContent.getNodes().length!=0){//只有在有数据的情况下才做
			  for(i=0;i<nodes.length;i++){
			  	if(map.get(nodes[i].id)=="true"){
				  	if(nodes[i].checked!=1){
				  		nodes[i].getHtmlElementfuxuanimg().onclick();
				  	}
			  	}
			  	if(map.get(nodes[i].id)!="true"&&tempMap.get(nodes[i].id)=="true")
			  		//if(nodes[i].type== "file")
			  		nodes[i].getHtmlElementfuxuanimg().src = xyTree.TreeConfig.jubuzhongIcon;
			  		//else
			  		//nodes[i].getHtmlElementfuxuanimg().src = xyTree.TreeConfig.quanzhongIcon;
			  }
		  }
		}
  		 
  		 /**
  		 *得到所有选中叶子的ID 在table中展示
  		 */
  		 function show(){
  		 	if(map.size() == 0&&MyContent.getNodes().length==0){
	  		 	 MyContent.tree.root.getHtmlElementfuxuanimg().src=xyTree.TreeConfig.buzhongIcon;
	  		 	 MyContent.initClearAllCheckBox();
  		 	 }
  			var obj = document.getElementById("show");
  			var str= tableStr;
  		  	var allFilesStr;
  		 	var selectNodes =  MyContent.getNodes();
  		 	
  		 	var arr = new Array();
  		 	for(i=0;i<map.size();i++){
  		 		var isDef = false;
  		 		for(var j=0;j<defMap.keys.length;j++){
					if(map.keys[i]==defMap.keys[j]){
						isDef = true;
					}
				}
				if(isDef){
			    	arr.push(defaultcreateTableElement(map.keys[i]));
			    }else{
			    	arr.push(createTableElementByDel(map.keys[i]));
			    }
		    }
  		 	for(i=0;i<selectNodes.length;i++){
  		 	   if(map.get(selectNodes[i].id)!="true")
  		 		arr.push(createTableElement(selectNodes[i]));
  			 }
  			obj.innerHTML=tableStr+arr.join("");
  		 }
  		
  		 //复位树
		function clear4(){
		  MyContent.initReset();
		}
		//处理路径字符串
		function stringHandle(regStr,processStr){
  		    var reg=new RegExp(regStr,"g");
  		 	return processStr.replace(reg,"");
  		}
		
		function getAllSelected(){
			var selectNodes =  MyContent.getNodes();
			var selArray=new Array();
			for(i=0;i<selectNodes.length;i++){
  		 		selArray.push(selectNodes[i].id);
  		 		selArray.push(",");
  			 }
  			
			var eformpathArr = "<%=eformpath%>".split(",");		
  			for(j=0;j<map.keys.length;j++){
  				var bl = true;
  				for(k=0;k<eformpathArr.length;k++){
  					if(map.keys[j]==(fileRoot+"/"+eformpathArr[k])){
  						bl = false;
						break;
					}
  				}
  				if(bl){
  					selArray.push(map.keys[j]);
  					selArray.push(",");
  				}
  			 }
  			var sel_fileStr;
  			//if(openflag){//一旦选择过树 则使用树选择的文件 即使选择为空
  				sel_fileStr="<%=default_filepath%>"+stringHandle(fileRoot+"/",selArray.join(""));
  			//}else{
  			//	sel_fileStr = "<%=default_filepath+sel_filepath%>";
  			//}	
  			return sel_fileStr;
		}
		
			//保存配置
		function saveconfig(){
			var sel_fileStr = getAllSelected();
			//提交后页面变灰
			popSignFlow(1);
			menuissueChange.saveConfig("<%=moduleID%>","<%=control.getCurrentSystemID()%>","<%=default_eform_id+sel_eform_id%>","<%=default_jawe_id+sel_jawe_id%>","<%=default_report_id+sel_report_id%>",sel_fileStr,saveconfigresult);
		}
		function saveconfigresult(obj){
			DWREngine.setPreHook(function() {});				
			DWREngine.setPostHook(function() {});
			
			//页面变灰恢复正常
			cancelSign();
			if(obj[0]=="false"){
				alert(obj[1]);
			}else{
				alert("保存成功！");
				window.close();
			}
		}
  		
</script>
		<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no" onload="initTree()">
		<div id="contentborder" align="left">
			<form name="filelistform" action="filelist.jsp" method="post">
				<input type="hidden" name="isFill" value="true">
				<input type="hidden" name="moduleID" value="<%=moduleID%>">
				<input type="hidden" name="workclass" value="<%=workclass%>">
				<input type="hidden" name="sel_eform_id" value="<%=sel_eform_id%>">
				<input type="hidden" name="sel_jawe_id" value="<%=sel_jawe_id%>">
				<input type="hidden" name="sel_filepath" value="<%=sel_filepath%>">
				<input type="hidden" name="default_businessclass_id" value="<%=default_businessclass_id%>">
				<input type="hidden" name="default_eform_id" value="<%=default_eform_id%>">
				<input type="hidden" name="default_jawe_id" value="<%=default_jawe_id%>">				
				<input type="hidden" name="default_report_id" value="<%=default_report_id%>">
				<input type="hidden" name="default_filepath" value="<%=default_filepath%>">	
				<input type="hidden" name="sel_report_id" value="<%=sel_report_id%>">
				<input type="hidden" name="init_sel_eform_id" value="<%=init_sel_eform_id%>">
				<input type="hidden" name="init_sel_jawe_id" value="<%=init_sel_jawe_id%>">
				<input type="hidden" name="init_sel_report_id" value="<%=init_sel_report_id%>">
				<input type="hidden" name="init_sel_filepath" value="<%=init_sel_filepath%>">
				<input type="hidden" name="selectId">
				<fieldset style="width: 100%;">
					<LEGEND align="left">
						<table width="200" class="thin">
							<tr>
								<td height='20' class="headercolor">
									文件
								</td>
								<td height='20' align="center" style="cursor: hand;"
									onclick="jumpPage('eformlist')">
									表单
								</td>
								<td height='20' align="center" style="cursor: hand;"
									onclick="jumpPage('jawelist')">
									流程
								</td>
								<td height='20' align="center" style="cursor: hand;"
									onclick="jumpPage('reportlist')">
									报表
								</td>
							</tr>
						</table>
					</LEGEND>
					<hr width="100%">
					<table width="100%" border="0" cellpadding="1" cellspacing="1"
						class="">
						<tr>
							<td>
								<div id="fileTree"></div>
							</td>
						</tr>
					</table>
					<div id = show>
					
					</div>
				</fieldset>
				<div align="left">
					<table width="45%" border="0" align="right" cellpadding="0"
						cellspacing="0">
						<tr>
							<td>
								<div align="center">
									<input name="Submit" type="button" class="input" value="上一步"
										onClick="jumpPage('back')">
									<input name="Submit" type="button" class="input" value="保存配置"
										onClick="saveconfig()">
									<input name="Submit" type="button" class="input" value="重置" onClick="resetclick()">
									<input name="Submit" type="button" class="input" value="返回" onClick="window.close();">									
								</div>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
		<script type="text/javascript">
		function resetclick(){
			document.filelistform.action="filelist.jsp";
			document.filelistform.sel_filepath.value="<%=init_sel_filepath%>";
		
			//提交后页面变灰
			popSignFlow(1);
			
			document.filelistform.submit();
		}

		var tableHead = ("<table width='100%' border='0' cellpadding='0' cellspacing='1'class='thin'>");
		for(i=0;i<map.keys.length;i++){
			var isDef = false;
			for(var j=0;j<defMap.keys.length;j++){
				if(map.keys[i]==defMap.keys[j]){
					isDef = true;
				}
			}
			if(isDef){
				se_arr.push(defaultcreateTableElement(map.keys[i]));
			}else{
				se_arr.push(createTableElementByDel(map.keys[i]));	
			}
		}
		se_arr.push("</table>");
		document.getElementById("show").innerHTML=tableStr+se_arr.join("");
		</script>
	</body>
</html>

