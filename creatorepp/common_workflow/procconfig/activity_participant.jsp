<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.workflow.shark.procconfig.XMLManager"%>
<%@ page import="com.chinacreator.workflow.shark.procconfig.Option"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.workflow.shark.procconfig.Panel"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgCacheManager"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(request,response);       
//String app_id = (String)session.getAttribute("subsystem_id_nouse").toString();
String app_id=accessControl.getCurrentSystemID();
String org_ids = StringUtils.defaultString(request.getParameter("org_ids"));
//String showmode = StringUtils.defaultString(request.getParameter("showmode"));
String showmode = "static";

//刷新机构缓冲
OrgCacheManager orgCacheManager = OrgCacheManager.getInstance();
try{
	orgCacheManager.reset();
}catch(Exception e){
	
}
%> 
<html> 
<head>
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>组织机构</title>
	
	    <%
			boolean isShowOrg = false;
			boolean isShowUser = false;
			boolean isShowRole = false;
			boolean isShowDynamic = false;	
			String data = "";
			if(request.getParameter("data")!=null){
				data = request.getParameter("data");
			}
	    %>
	    <%
	   		XMLManager xMLManager = new XMLManager();
	    	List list = xMLManager.getAllPanel();
			List option_list = xMLManager.getOption();
	    	for(int i=0;i<list.size();i++){
	    		Panel p = (Panel)list.get(i);
	    		if("Institute".equals(p.getPanel_name())){
	    			isShowOrg = true;
	    		}else if("User".equals(p.getPanel_name())){
	    			isShowUser = true;
	    		}else if("Role".equals(p.getPanel_name())){
	    			isShowRole = true;
	    		}else if("DynamicSpecify".equals(p.getPanel_name())){
	    			isShowDynamic = true;
	    		}
	    	}
	    %>
	
	<link href="style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/common_workflow/procconfig/tree/css/ext-all.css" />
	
	<!-- ext begin -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/common_workflow/procconfig/tree/ext-base.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/common_workflow/procconfig/tree/ext-all.js"></script>
	<!-- ext end -->
	<!-- dwr begin -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/dwr/util.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/dwr/interface/orgJobUserExtTree.js"></script>
	<!-- dwr end -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/common_workflow/procconfig/tree/DWRTreeLoader.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/common_workflow/procconfig/tree/TreeCheckNodeUI.js"></script>
	
	<script language="javascript">
		
		var notYetLoadNodeIds = new Array();//全局变量DWRTreeLoader.js中使用，没有被加载的已选节点id
		function getOrgUserJobSelected(){
			var values = getCheckValues();
			var orgNames=[], userNames=[], jobNames=[], resultArray = [];
			for(var i=0;i<values.length;i++){
				var arr1 = values[i].split(":");
				if(arr1[0]=='org'){
					orgNames.push(arr1[1]);
				}else if(arr1[0]=='user'){
					userNames.push(arr1[1]);
				}else if(arr1[0]=='job'){
					jobNames.push(arr1[1]);
				}
			}
			//获取没有被加载的节点id
			for(var i=0;i<notYetLoadNodeIds.length;i++){
				if(notYetLoadNodeIds[i] != ""){
					dwr.engine.setAsync(false); 
					var arr1 = notYetLoadNodeIds[i].split(":");
					if(arr1[0]=='org'){
						//add by minghua.guo[2011-01-07] 判断机构是否存在
						orgJobUserExtTree.isOrgExitsInDB(arr1[1],function(ret){
							if(ret)
								orgNames.push(arr1[1]);
						});
					}else if(arr1[0]=='user'){
						//add by minghua.guo[2011-01-07] 判断用户是否存在
						orgJobUserExtTree.isUserExitsInDB(arr1[1],function(ret){
							if(ret)
								userNames.push(arr1[1]);
						});
					}else if(arr1[0]=='job'){
						//add by minghua.guo[2011-01-07] 判断岗位是否存在
						orgJobUserExtTree.isJobExitsInDB(arr1[1],function(ret){
							if(ret)
								jobNames.push(arr1[1]);
						});
					}
					dwr.engine.setAsync(true); 
				}
			}
			
			//var orgs = document.getElementsByName("orgid");
			//var orgNames=[], userNames=[], jobNames=[], resultArray = [];
			//for(var i=0;i<orgs.length;i++){
			//	if(orgs[i].checked){
			//		var arr = new Array();
			//		arr = orgs[i].value.split(",");
			//		if(arr[0]=='org'){
			//			orgNames.push(arr[1]);
			//		}else if(arr[0]=='user'){
			//			userNames.push(arr[1]);
			//		}else if(arr[0]=='job'){
			//			jobNames.push(arr[1]);
			//		}
			//	}
			//}
			if(orgNames.length>0) resultArray.push("<ExtendedAttribute Name=\"Institute\" Value=\"",orgNames.join(","),"\"/>");
			if(userNames.length>0) resultArray.push("<ExtendedAttribute Name=\"User\" Value=\"",userNames.join(","),"\"/>");
			if(jobNames.length>0) resultArray.push("<ExtendedAttribute Name=\"Position\" Value=\"",jobNames.join(","),"\"/>");
			return resultArray.join("");
		}
		
		function getGroupUserSelected(){
			var groups = document.getElementsByName("groupid");	
			var userNames = [], groupNames = [], resultArray = [];
			for(var i=0;i<groups.length;i++){
				if(groups[i].checked){			
					var arr = new Array();
					arr = groups[i].value.split(",");
					if(arr[0]=='group'){
						groupNames.push(arr[1]);
					}else if(arr[0]=='user'){
						userNames.push(arr[1]);
					}
				}
			}
			if(groupNames.length>0){
				resultArray.push("<ExtendedAttribute Name=\"Group\" Value=\"",groupNames.join(","),"\"/>");
			}
			if(userNames.length>0){
				resultArray.push("<ExtendedAttribute Name=\"User\" Value=\"",userNames.join(","),"\"/>");
			}
			return resultArray.join("");
		}
		
		function getRoleSelected(){
			var roleObjects = document.getElementsByName("roleid");
			var roleNames = [];
			for(var i=0;i<roleObjects.length;i++){
				if(roleObjects[i].checked){			
					var arr = roleObjects[i].value.split(",");
					roleNames.push(arr[1]);	
				}
			}
			if(roleNames.length>0){
				return "<ExtendedAttribute Name=\"Role\" Value=\""+roleNames.join(",")+"\"/>";
			}
			return "";
		}
		
		function getDynamicSpecifySelected(){
			var dynamicObjects = document.getElementsByName("dynamicID");
			var dynamicArray = [];
			for(var i=0;i<dynamicObjects.length;i++){
				if(dynamicObjects[i].checked){
					var arr = new Array();
					arr = dynamicObjects[i].value.split(",");
					dynamicArray.push('<ExtendedAttribute Name="AssignmentPlugin" Value="',arr[1],'">',dynamicObjects[i].nextSibling.innerText,"</ExtendedAttribute>");
				}
			}
			return dynamicArray.join("");
		}
		
		//设置树结点的样式
		function setTreeNodeClass(){
			var allTd = document.getElementsByTagName("td");
			for(var i = 0;i < allTd.length;i++){	    
				allTd[i].className = "tdclass_act";
			}
		}
		
		function uf_ok(){
			var participantArray = [];
			participantArray.push("<ExtendedAttributes>");
			participantArray.push(getOrgUserJobSelected());
			participantArray.push(getGroupUserSelected());
			participantArray.push(getRoleSelected());
			participantArray.push(getDynamicSpecifySelected());
			participantArray.push("</ExtendedAttributes>");
		
			window.returnValue=participantArray.join("");
			window.close();
		}
		function uf_clear(){
			var participantArray = [];
			window.returnValue=participantArray.join("");
			window.close();
		}
	</script>
	
  <script type='text/javascript'>
   
    loadXML = function(xmlString){
        var xmlDoc=null;
        //判断浏览器的类型
        //支持IE浏览器 
        if(!window.DOMParser && window.ActiveXObject){//window.DOMParser 判断是否是非ie浏览器
            var xmlDomVersions = ['MSXML.2.DOMDocument.6.0','MSXML.2.DOMDocument.3.0','Microsoft.XMLDOM'];
            for(var i=0;i<xmlDomVersions.length;i++){
                try{
                    xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                    xmlDoc.async = false;
                    xmlDoc.loadXML(xmlString);//loadXML方法载入xml字符串
                    break;
                }catch(e){
                }
            }
        }
        //支持Mozilla浏览器
        else if(window.DOMParser && document.implementation && document.implementation.createDocument){
            try{
                domParser = new  DOMParser();
                xmlDoc = domParser.parseFromString(xmlString, 'text/xml');
            }catch(e){
            }
        }
        else{
            return null;
        }

        return xmlDoc;
    }

    //对xml对象进行判断
    checkXMLDocObj = function(xmlString){
        var xmlDoc = loadXML(xmlString);
        if(xmlDoc==null){
            alert('您的浏览器不支持xml文件读取,于是本页面禁止您的操作,推荐使用IE5.0以上可以解决此问题!');
            //window.location.href='某某地址(比如首页)';
        }
        return xmlDoc;
    }
    
    //参数1:控件id号,参数2:理解为定位节点
    initializeSelect = function(){
		if(<%=isShowOrg%>==false&&<%=isShowUser%>==false&&<%=isShowRole%>==false&&<%=isShowDynamic%>==false){
			alert('没数据显示!');
			return false;
		}
        var xmlstr='<%=data%>';
        var xmlDoc = checkXMLDocObj(xmlstr);
        var e = xmlDoc.getElementsByTagName("ExtendedAttribute");
        for(var j=0;j<e.length;j++){
            if(e[j].getAttribute('Name')=='Group'){
            	initData('groupid',e[j].getAttribute('Value'));
            }else if(e[j].getAttribute('Name')=='Role'){
            	initData('roleid',e[j].getAttribute('Value'));
            //}else if(e[j].getAttribute('Name')=='Institute'){
            //	initData('orgid',e[j].getAttribute('Value'),'org');//modify by minghua.guo 2010-7-29 'org' 
            }else if(e[j].getAttribute('Name')=='AssignmentPlugin'){
            	initData('dynamicID',e[j].getAttribute('Value'));
            //}else if(e[j].getAttribute('Name')=='User'){
            //	initData('orgid',e[j].getAttribute('Value'),'user');//modify by minghua.guo 2010-7-29 'user' 
            //}else if(e[j].getAttribute('Name')=='Position'){
            //	initData('orgid',e[j].getAttribute('Value'),'job');//modify by minghua.guo 2010-7-29 'user'
            }
		}
    }
    
    //modify by minghua.guo 2010-7-29 param 
	function initData(checkbox_name,str_arr){
		var groups = document.getElementsByName(checkbox_name);
		var count = 0;
		//传过来的值，将他转化为组数
		var allarr = new Array();
		allarr = str_arr.split(",");
		
		for(var i=0;i<groups.length;i++){
			var arr = new Array();
			arr = groups[i].value.split(",");
			for(var j=0;j<allarr.length;j++){
				if(allarr[j]==arr[1]){//modify by minghua.guo 2010-7-29  && type == arr[0]
					groups[i].checked = 'checked';
					//add by minghua.guo 添加已选用户父机构颜色记录
					treeNodeCheckboxChangeColor(groups[i]);
				}
			}	
		}
	}
	//add by minghua.guo 添加已选用户父机构颜色记录
	function treeNodeCheckboxChangeColor(checkNode){
	      if(!checkNode)
	           checkNode = event.srcElement;
	      var fatherids = checkNode.fatherids;
	      if(fatherids == "" || !fatherids){
	      		return;
	      }else{
		      var fathers = fatherids.split("\#\#");
		      for(var i = fathers.length - 1; i >= 0; i --){
		          var father_ = $("checkbox_" + fathers[i]);
		          if(father_){
		              if(father_.checked) return;
		              father_.nextSibling.style.color = "red";
		          }
		              
		     }
	     }
    }
	
	function selectCheckBox(name,val){
		var groups = document.getElementsByName(name);
		for(var i=0;i<groups.length;i++){
			if(groups[i].value==val&&groups[i].checked==false){
				groups[i].checked = 'checked';
			}else if(groups[i].value==val&&groups[i].checked==true){
				groups[i].checked = '';
			}
		}
	}
	
	function changeColor(id){
		if(<%=isShowOrg%>==true)document.getElementById('org_font_color').color='';
		if(<%=isShowUser%>==true)document.getElementById('group_font_color').color='';
		if(<%=isShowRole%>==true)document.getElementById('role_font_color').color='';
		if(<%=isShowDynamic%>==true)document.getElementById('dynamic_font_color').color='';
		document.getElementById(id).color='#000000';
	}
	function changePage(id){
		document.getElementById('org_tree_div_id').style.display='none';
		document.getElementById('group_tree_div_id').style.display='none';
		document.getElementById('role_tree_div_id').style.display='none';
		document.getElementById('dynamic_div_id').style.display='none';
		document.getElementById(id).style.display='';
	}	
	
	//add by minghua.guo 机构用户树传后台参数
        var checkedStr='<%=data%>';
        var xmlDoc1 = checkXMLDocObj(checkedStr);
        var e1 = xmlDoc1.getElementsByTagName("ExtendedAttribute");
        var checkOrgUserJob = "";
        var checkOrg = "";
        var checkUser = "";
        var checkJob = "";
        for(var k=0;k<e1.length;k++){
        	var value = e1[k].getAttribute('Value');
        	if(value != ""){
	            if(e1[k].getAttribute('Name')=='Institute'){
	            	checkOrg += checkOrg==""? value : ","+value;
	            }else if(e1[k].getAttribute('Name')=='User'){
	            	checkUser += checkUser==""? value : ","+value;
	            }else if(e1[k].getAttribute('Name')=='Position'){
	            	checkJob += checkJob==""? value : ","+value;
	            }
            }
		}
		//传后台dwr类参数：已选项
		checkOrgUserJob = checkOrg + "#" + checkUser + "#" + checkJob;
		
  </script>
</head>
<base target="_self"/>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" onload="initializeSelect();">
	<div id="tabs2">
		<ul>
			<%if(isShowOrg){%>
			<li><a href="#" onClick="changePage('org_tree_div_id');changeColor('org_font_color');"><span><font id="org_font_color" color="#000000" size="2">机构</font></span></a></li>
			<%}%>
			<%if(isShowUser){%>
			<li><a href="#" id="a1" onClick="changePage('group_tree_div_id');changeColor('group_font_color');" disabled><span><font id="group_font_color" color="" size="2">用户组</font></span></a></li>
			<%}%>
			<%if(isShowRole){%>
			<li><a href="#" id="a2" onClick="changePage('role_tree_div_id');changeColor('role_font_color');" disabled><span><font id="role_font_color" color="" size="2">角色</font></span></a></li>
			<%}%>
			<%if(isShowDynamic){%>
			<li><a href="#" id="a3" onClick="changePage('dynamic_div_id');changeColor('dynamic_font_color');" disabled><span><font id="dynamic_font_color" color="" size="2">动态指定</font></span></a></li>
			<%}%>
		</ul>
	</div>
	<div id="org_tree_div_id" align="center" style="display:<%if(!isShowOrg){%>none<%}%>">
		<br />
			<fieldset style="width: 95%;">
				<LEGEND align=center>
					<FONT size="2"></FONT>
				</LEGEND>
				<table width="100%" height="35" border="0" align="left"	cellpadding="0" cellspacing="1" class="table">								
					<tr>
						<td width="" class="detailcontent">
						<DIV id=tree-div></DIV>
						<SCRIPT type=text/javascript>
						//屏蔽节点双击事件
						Ext.override(Ext.tree.TreeNodeUI, { 
							onDblClick : function(e) { 
								e.preventDefault(); 
								if (this.disabled) { 
									return; 
								} 
								if (this.checkbox) { 
									return; //this.toggleCheck(); 
								} 
								if (!this.animating && this.node.hasChildNodes()) { 
									var isExpand = this.node.ownerTree.doubleClickExpand; 
									if (isExpand) { 
										this.node.toggle(); 
									}
								} 
								this.fireEvent("dblclick", this.node, e); 
							} 
						}); 
						
						var rightClickNode = null;
						var tree = null;
						var getCheckValues = Ext.emptyFn;
						Ext.BLANK_IMAGE_URL = 'images/s.gif';
						Ext.onReady(function() {
						tree = new Ext.tree.TreePanel({
								el 					:'tree-div',
								title 				: '<p align=center>组织机构</p>',
							  	rootVisible 		: true,
								checkModel 			:'multiple',
								onlyLeafCheckable 	: false,
							  	autoHeight 			: true,
							  	animate 			: false,
								autoScroll 			: true,
								selModel 			: new Ext.tree.MultiSelectionModel(),
								collapsible:true,titleCollapse:true,
								root 				: new Ext.tree.AsyncTreeNode({
								text 		: '组织机构', 
						 		hasChildren	:true,
						 		expanded	:true,
								id 			: '0'
						  	}),
							  	loader 				: new Ext.ux.DWRTreeLoader({
							     	dwrCall 	: orgJobUserExtTree.getOrgUserById,
							   		baseAttrs	: { uiProvider: Ext.tree.TreeCheckNodeUI }
							  	})
						});
						tree.on("check",function(node,checked){});
						tree.render();
						getCheckValues = function(){
						   	return tree.getChecked('id');
						}
						});
						
						</SCRIPT>
						</td>
					</tr>
				</table>
				<br />
			</fieldset>
		<br />
		<br />
		<div align="center">
			<table width="25%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<div align="left">
							 <input name="Submit" type="button" class="input" value="确定" onClick="uf_ok()">
						</div>
					</td>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<div align="left">
							<input name="clear" type="button" class="input" value="清空" onClick="uf_clear()">
						</div>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						<div align="left">
							  <input name="cancel" type="button" class="input" value="取消"	onClick="window.close()">
						</div>
					</td>
				</tr>
			</table>
		</div>
		<script language="javascript">
			setTreeNodeClass();
		</script>
	</div>

	<div id="group_tree_div_id" align="center" style="display:<%if(isShowOrg||!isShowUser){%>none<%}%>">
			<br />
					<fieldset style="width: 95%;">
						<LEGEND align=center>
							<FONT size="2">用户组选择</FONT>
						</LEGEND>
						<table width="100%" height="35" border="0" align="left"	cellpadding="0" cellspacing="1" class="table">								
							<tr>
								<td class="td"><!-- mode="static" -->
									<tree:tree tree="group_role_tree_zzy"
											   node="group_role_tree_zzy.node"
											   imageFolder="/sysmanager/images/tree_images/"
										       collapse="true"
										       includeRootNode="true"
										       mode="static">
		   			                    <tree:checkbox name="groupid" recursive="false"></tree:checkbox>
										<tree:treedata treetype="com.chinacreator.workflow.shark.procconfig.GroupUserTree" 
													   scope="request" 
													   rootid="0" 
											           rootName="用户组树" 
											           expandLevel="1" 
											           showRootHref="false" 
											           needObserver="false"/>
									</tree:tree>
								</td>
							</tr>
						</table>
					    <br />
					</fieldset>
			<br />
			<br />
			<div align="center">
				<table width="25%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<div align="left">
					     		<input name="Submit" type="button" class="input" value="确定" onClick="uf_ok()">
						    </div>
					    </td>
						<td>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						<td>
							<div align="left">
								<input name="clear" type="button" class="input" value="清空" onClick="uf_clear()">
							</div>
						</td>
					    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					    <td>
							<div align="left">
						  		<input name="cancel" type="button" class="input" value="取消" onClick="window.close()">
						    </div>
					    </td>
					</tr>
				</table>
			</div>
</div>
		
	<div id="role_tree_div_id" align="center" style="display:<%if(isShowOrg||isShowUser||!isShowRole){%>none<%}%>">
		<br />
			<fieldset style="width: 95%;">
				<LEGEND align=center>
					<FONT size="2">角色选择</FONT>
				</LEGEND>
				<table width="100%" height="35" border="0" align="left" cellpadding="0" cellspacing="1" class="table">
					<tr>
						<td width="" class="detailcontent">
							<tree:tree tree="eform_sysmanager_role_tree_zzy"
										node="eform_sysmanager_role_tree_zzy.node"
										imageFolder="/sysmanager/images/tree_images/"
										collapse="true"
										includeRootNode="true"
										mode="static">
								<tree:checkbox name="roleid"></tree:checkbox>
								<tree:treedata treetype="com.chinacreator.workflow.shark.procconfig.RoleTree"
									scope="request"
									rootid="01"
									rootName="角色"
									expandLevel="1"
									showRootHref="false" 
									needObserver="false" />
							</tree:tree>
						</td>
					</tr>
				</table>
				<br />
			</fieldset>
		<br /><br />
		<div align="center">
			<table width="25%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<div align="left">
							<input name="Submit" type="button" class="input" value="确定" onClick="uf_ok()">
						</div>
					</td>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<div align="left">
							<input name="clear" type="button" class="input" value="清空" onClick="uf_clear()">
						</div>
					</td>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<div align="left">
							<input name="cancel" type="button" class="input" value="取消" onClick="window.close()">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div id="dynamic_div_id" align="center" style="display:<%if(isShowOrg||isShowUser||isShowRole||!isShowDynamic){%>none<%}%>"><br/>
		<fieldset style="width: 95%;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<%for(int i=0;i<option_list.size();i++){
					Option o = (Option)option_list.get(i);%>
				<tr>
					<td>
						<input type="checkbox" name="dynamicID" value="dynamic,<%=o.getOption_class()%>"/><span onClick="selectCheckBox('dynamicID','dynamic,<%=o.getOption_class()%>');"><%=o.getOption_value()%></span><br/>
					</td>
				</tr>
				<%}%>
			</table>
		</fieldset>
		<br/><br/>
		<div align="center">
			<table width="25%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<div align="left">
							<input name="Submit" type="button" class="input" value="确定" onClick="uf_ok()">
						</div>
					</td>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<div align="left">
							<input name="clear" type="button" class="input" value="清空" onClick="uf_clear()">
						</div>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						<div align="left">
							<input name="cancel" type="button" class="input" value="取消" onClick="window.close()">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>	
</body>
</html>
<script>
	document.getElementById("a1").disabled=false;
	document.getElementById("a2").disabled=false;
	document.getElementById("a3").disabled=false;
</script>