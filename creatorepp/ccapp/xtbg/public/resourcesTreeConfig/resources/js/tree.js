var getSetting=function(key,p){
	var setting = "";
	switch (key) {
	case "checkbox":
		 setting = {
				view : {
					selectedMulti : false,
					expandSpeed:''
				},
				data : {
					simpleData : { // 简单json类型
						enable : true,
						idKey : "id",
						pIdKey : "parent_id",
						rootPId : 0
					}
				},
				check : {
					enable : true,
					chkStyle : "checkbox",
					chkboxType : {
						"Y" : "s",
						"N" : "s"},
					radioType : "all"
				},
				callback: {
					onClick: p.onClick
					//onDblClick: dbclickF
				},
				async:{
					enable:true
				}
			};
		break;

	default:
		setting = {
			view : {
				selectedMulti : false,
				expandSpeed:''
			},
			data : {
				simpleData : { // 简单json类型
					enable : true,
					idKey : "id",
					pIdKey : 'parent_id',
					rootPId : 0
				}
			},
			callback: {
				onClick: p.onClick
				//onDblClick: dbclickF
			},
			async:{
				enable:true
			}
		};
	}
	return setting;
}

var initTree=function(p){
	//var setting = getSetting(p.treetype);
	var span = {
			url : getContextPath()+'/tree',
			success : function(ss) {
				var nodes=null;
				if(json.returnValue !='none')
			    {
					nodes = json.returnValue;
			    }
				else{
					nodes =[];
				}
				window[p.treename] = nodes;
				loadPager();
			},
			data : p.type,
			classID : 'config',
			method : p.method
		}
		ajaxTools(span);
}

var initTreeList=function(){
	$("#save").attr("disabled","true");
	var purview ={
			type:'{"user":""}',
			method:'inqueryTreePurview',
			treename:'purview'
	};
	initTree(purview);
	var organization ={
			type:'{"user":"","isManager":"'+isManager+'"}',
			method:'inqueryTreeOrganization',
			treename:'organization'
	};
	initTree(organization);
	
	var person ={
			type:'{"user":"","AllOpen":"true","isManager":"'+isManager+'"}',
			method:'inqueryTreePerson',
			treename:'person'
	};
    initTree(person);
    
    var personNotUserVaild ={
			type:'{"user":"","isNotUserVaild":"true","AllOpen":"true","isManager":"'+isManager+'"}',
			method:'inqueryTreePerson',
			treename:'personNotUserVaild'
	};
    initTree(personNotUserVaild);
   /* var reportPerson ={
    		type:'{"user":""}',
			method:'inqueryTreeReportPerson',
			treename:'reportPerson'	
    }
    initTree(reportPerson);*/
    
    var yueWenfileType ={
			type:'{"type":"filetype"}',
			method:'inqueryTreeOtherResources',
			treename:'yueWenfileType'
	};
    initTree(yueWenfileType);
    
    var reportOrganization ={
    		type:'{"user":"","isManager":"'+isManager+'"}',
			method:'inqueryTreeReportOrganization',
			treename:'reportOrganization'	
    }
    initTree(reportOrganization);
    $("#batch").click(function(){
    	$("#save").attr("disabled","true");
		changeBatch();
		saveOk();
	});
	bulidClick();
	saveOk();
}

var loadPager=function(){
	var p = {"onClick":purviewTreeClick}
	var setting = getSetting("",p);
	if(window.purview !=null){
		try{delete window.purviewTree;}catch(error){}
		window.purviewTree = $.fn.zTree.init($("#treeDemo_purview"), setting,window.purview);
	}
	if(window.person !=null){
		setting = getSetting("",p);
		try{delete window.personTree;}catch(error){}
		window.personTree = $.fn.zTree.init($("#treeDemo_person"), setting,window.person);
	}
	if(window.person !=null){
		p.onClick = onclick;
		setting = getSetting("checkbox",p);
		try{delete window.configTree;}catch(error){}
		window.configTree = $.fn.zTree.init($("#treeDemo_config"), setting,window.person);
		window.configTreeType = "person";
	}
	
}
var onclick = function(event, treeId, treeNode){
	zTreeOnClick(event, treeId, treeNode);
}

function zTreeOnClick(event, treeId, treeNode)  {
	var tree = $.fn.zTree.getZTreeObj(treeId);
	tree.checkNode(treeNode,!treeNode.checked,true);
};

String.prototype.checkContainStr = function(tempStr,splitMark){
	if((splitMark + this + splitMark).indexOf(splitMark + tempStr + splitMark) != -1)
		return true;
	else
		return false;
}

var purviewTreeClick = function(){
	var allshowPersonTypeStr = "69";//69公共通讯录
	var  nodes= window.purviewTree.getSelectedNodes(true);
	var p = {"onClick":onclick}
	var setting = getSetting("checkbox",p);
	if(null != nodes && nodes.length > 0 && nodes[0].treeType != null){
		if(nodes[0].treeType == 2 && "organization" != window.configTreeType){
			$("#treeDemo_config").html("");
			try{delete window.configTree;}catch(error){}
			window.configTree = $.fn.zTree.init($("#treeDemo_config"), setting,window.organization);
			window.configTreeType = "organization";
			$("#configText").html("机构树");
		}
		else if( nodes[0].treeType == 1){
			$("#treeDemo_config").html("");
			try{delete window.configTree;}catch(error){}
			window.configTree = $.fn.zTree.init($("#treeDemo_config"), setting,window.person);
			$("#configText").html("人员树");
			window.configTreeType = "person";
			if(allshowPersonTypeStr.checkContainStr(nodes[0].id,",")){//69公共通讯录 其他类型只需展示所有启用的人员
				window.configTree = $.fn.zTree.init($("#treeDemo_config"), setting,window.personNotUserVaild);
				window.configTreeType = "personNotUserVaild";
			}
		}else if("yueWenfileType" != window.configTreeType && nodes[0].treeType == 3){
			$("#treeDemo_config").html("");
			try{delete window.configTree;}catch(error){}
			window.configTree = $.fn.zTree.init($("#treeDemo_config"), setting,window.yueWenfileType);
			$("#configText").html("阅文平台类别树");
			window.configTreeType = "yueWenfileType";
		}
	}
	if($("#batch")[0].checked == false && null != nodes && nodes.length > 0 && nodes[0].treeType != null){
		if(null != nodes && nodes.length > 0){
			var personTreeNodes = window.personTree.getSelectedNodes(true);
			if(null != personTreeNodes && personTreeNodes.length > 0 && personTreeNodes[0].user_id != null){
				var type = nodes[0].id;
			    var selectUserId = personTreeNodes[0].id;
			    
			    var span = {
						url : getContextPath()+'/tree',
						success : function(ss) {
							   $("#save").attr("disabled","true");
								var ids = ','+json.returnValue+',';
								var nodeArray = window.configTree.transformToArray(window.configTree.getNodes());
								for (i = 0; i < nodeArray.length; i++) {
									if(ids.indexOf(","+nodeArray[i].id+",") > -1){
										window.configTree.checkNode(nodeArray[i],true);
									}
									else{
										window.configTree.checkNode(nodeArray[i],false);
									}
								}
								saveOk()
						},
						data : '{"type":"'+type+'","selectUserId":"'+selectUserId+'"}',
						classID : 'config',
						method : "inqueryPersonSelectValue"
					}
					ajaxTools(span);
			}
		}
	}
}


var changeBatch = function(){
	
	if($("#batch")[0].checked){
		var p = {"onClick":onclick}
		var setting = getSetting("checkbox",p);
		if(window.person !=null){
			$("#treeDemo_person").html("");
			window.searchTree=true;
			try{delete window.personTree;}catch(error){}
			window.personTree = $.fn.zTree.init($("#treeDemo_person"), setting,window.person);
		}
	}
	else{
		var p = {"onClick":purviewTreeClick}
		var setting = getSetting("",p);
		if(window.person !=null){
			$("#treeDemo_person").html("");
			window.searchTree=true;
			try{delete window.personTree;}catch(error){}
			window.personTree = $.fn.zTree.init($("#treeDemo_person"), setting,window.person);
			
		}
	}
}

var bulidClick = function(){
	$("#seachInput").addClass("tree_box_mid_in");
	$("#seachInput").hover(function(){
		if(""==$("#seachInput").val()){
			$("#seachInput").removeClass();
			$("#seachInput").addClass("tree_box_mid_in");
		}
		else{
			$("#seachInput").removeClass();
		}
		$("#seachInput").addClass("_z_tree_seachter_input");
	});
	$("#seachInput").click(function(){
		if(""==$("#seachInput").val()){
			$("#seachInput").removeClass();
			$("#seachInput").addClass("tree_box_mid_over");
		}
		else{
			$("#seachInput").removeClass();
		}
		$("#seachInput").addClass("_z_tree_seachter_input");
	});
	$("#seachInput").keyup(function(event){
		if(""==$("#seachInput").val()){
			$("#seachInput").removeClass();
			$("#seachInput").addClass("tree_box_mid_over");
		}
		else{
			$("#seachInput").removeClass();
		}
		$("#seachInput").addClass("_z_tree_seachter_input");
		   if (event.keyCode=="13"){
			   $("#butseacht").click()
		   }
	});
	window.searchTree = true;
	$("#butseacht").click(function(){
		if(window.searchTree){
			window.personTree.expandAll(true);
		}
		window.searchTree=false;
		z_tree_searchTree(window.personTree,$("#seachInput").val());
	});
	
	$("#save").click(function(){
		save();
	});
}

function z_tree_searchTree(treeObj, lastName) {
	var nodes = treeObj.transformToArray(treeObj.getNodes());
	for (i = 0; i < nodes.length; i++) {
		// 首先隐藏
		if (nodes[i].name.indexOf(lastName) >= 0) {
			$("#" + nodes[i].tId).parents().show();
			$("#" + nodes[i].tId).show();
		} else {
			$("#" + nodes[i].tId).hide();
		}
	}
}

var save = function(){
	var  nodes= window.purviewTree.getSelectedNodes(true);
	if(nodes == null || nodes.length < 1 || nodes[0].treeType == null){
		alert("请选择配置模块！");
		return false;
	}
	var type = nodes[0].id;
	var treeType =  nodes[0].treeType;
	var userIDs = "";
	if (!$("#batch")[0].checked) {
		var personTreeNodes = window.personTree.getSelectedNodes(true);
		if (personTreeNodes == null || personTreeNodes.length < 1) {
			alert("请选择要配置的人员 ！");
			return false;
		}
		if (personTreeNodes[0].user_id == null) {
			alert("请选择要配置的人员 ！");
			return false;
		}
		userIDs = personTreeNodes[0].user_id;
	}
	if ($("#batch")[0].checked) {
		var personTreeNodes = window.personTree.getCheckedNodes(true);
		var flag = true;
		for(var i = 0;i< personTreeNodes.length;i++){
			if(personTreeNodes[i].user_id != null){
				if(flag){
					userIDs=personTreeNodes[i].user_id;
					flag =false;
				}else{
					userIDs+=","+personTreeNodes[i].user_id;
				}
				
			}
		}
	}
	
	if(userIDs == ""){
		alert("请选择要配置的人员 ！");
		return false;
	}
	var selectIDs = "";
	var configNodes =  window.configTree.getCheckedNodes(true);
	var cFlag = true;
	for(var i = 0; i<configNodes.length;i++){
		if((treeType == 1 ) && configNodes[i].user_id != null){
			if(cFlag){
				cFlag = false;
				selectIDs = configNodes[i].id ;
			}
			else{
				selectIDs +="," +configNodes[i].id ;
			}
		}else if(treeType == 2 || treeType == 3){//treeType3为阅文平台类别树
			if(cFlag){
				cFlag = false;
				selectIDs = configNodes[i].id ;
			}
			else{
				selectIDs += ","+configNodes[i].id ;
			}
		}
	}
	$("#save").attr("disabled","true");
	var nodesJson = clickTreeNodeToJson(configNodes,treeType,selectIDs);
	//保存
	var span = {
			url : window.top.getContextPath()+'/tree',
			success : function(ss) {
				var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:saveOk
			      };
				 alert("保存成功!",p);
			},
			dataType:"text",
			data : "{'type':'"+type+"','json':'"+nodesJson+"','treeType':'"+treeType+"','selectUserIds':'"+selectIDs+"','userIds':'"+userIDs+"'}",
			classID : 'config',
			method : 'batchSave'
		}
		ajaxTools(span);
}
function saveOk(){
	$("#save").removeAttr("disabled");
}
var isManager = false;
$successful.initsucessful = function(response){
	isManager = response.result.isManager;
	if("false" == isManager){
		$("#content_02_top").hide();
	}
	initTreeList();
}