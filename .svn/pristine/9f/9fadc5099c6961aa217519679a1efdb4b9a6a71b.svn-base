/*
	时间:  2013-7-16
	函数:  getSetting
	说明:  树参数
	参数:   无
	返回值: 无
*/
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
			},
			async:{
				enable:true
			}
		};
	}
	return setting;
}

/*
	时间:  2013-7-16
	函数:  initTree
	说明:  初始化树后台方法
	参数:   无
	返回值: 无
*/
var initTree=function(p){
	var span = {
			url : getContextPath()+'/pubtree',
			success : function(ss) {
				var nodes=null;
				if(json.returnValue !='none') {
					nodes = json.returnValue;
			    } else{
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

/*
	时间:  2013-7-16
	函数:  initTreeList
	说明:  初始化资源配置树
	参数:   无
	返回值: 无
*/
var initTreeList=function(){
	
	if(one_user_id != '') {
		$("#batch").attr("disabled","true");
		$("#configtrees").hide();
	}
	$("#save").attr("disabled","true");
	
	//查询数据资源
	var purview ={
			type:'{"user":""}',
			method:'selDataResources',
			treename:'purview'
	};
	initTree(purview);
	
	//查询所有的人员
	var person ={
			type:'{"user":""}',
			method:'selAllUserrTree',
			treename:'person'
	};
	initTree(person);
	
	//查询所有的单位
	var unit ={
			type:'{"user":""}',
			method:'selAllUnit',
			treename:'unit'
	};
	initTree(unit);
	
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
	var selectUserId = one_user_id;//单个人配置赋值
	var  nodes= window.purviewTree.getSelectedNodes(true);
	var p = {"onClick":onclick}
	var setting = getSetting("checkbox",p);
	if(null != nodes && nodes.length > 0 && nodes[0].treeType != null) {
		if(nodes[0].treeType == 2 && "unit" != window.configTreeType) {
			$("#treeDemo_config").html("");
			try{delete window.configTree;}catch(error){}
			window.configTree = $.fn.zTree.init($("#treeDemo_config"), setting,window.unit);
			window.configTreeType = "unit";
			$("#configText").html("机构树");
		} else if( nodes[0].treeType == 1) {
			$("#treeDemo_config").html("");
			try{delete window.configTree;}catch(error){}
			window.configTree = $.fn.zTree.init($("#treeDemo_config"), setting,window.person);
			$("#configText").html("人员树");
			window.configTreeType = "person";
		}
	}
	
	if($("#batch")[0].checked == false && null != nodes && nodes.length > 0 && nodes[0].treeType != null){
		if(null != nodes && nodes.length > 0){
			var personTreeNodes = window.personTree.getSelectedNodes(true);
			if(null != personTreeNodes && personTreeNodes.length > 0 && personTreeNodes[0].user_id != null || selectUserId != ''){
				var type = nodes[0].id;
				if(selectUserId == '') {
					selectUserId = personTreeNodes[0].id;
				}
			    var span = {
						url : getContextPath()+'/pubtree',
						success : function(ss) {
							   $("#save").attr("disabled","true");
								var ids = ','+json.returnValue+',';
								var nodeArray = window.configTree.transformToArray(window.configTree.getNodes());
								for (i = 0; i < nodeArray.length; i++) {
									if(ids.indexOf(","+nodeArray[i].id+",") > -1){
										window.configTree.checkNode(nodeArray[i],true);
									} else{
										window.configTree.checkNode(nodeArray[i],false);
									}
								}
								saveOk()
						},
						data : '{"type":"'+type+'","selectUserId":"'+selectUserId+'"}',
						classID : 'config',
						method : "selUserSelectValue"
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
	} else{
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

var count=0; 
function searchTree(key){
	key = $.trim($("#key").val());
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	var keyType = "name";
	if(key != ""){
		if (oldSearchValue != key) {
			var nodesd =zTree.getNodesByParamFuzzy(keyType,key,null); 
		    for(i = count; i < nodesd.length; i++) { 
				count++; 
				if(count>=nodesd.length){ 
					count=0;
				}
				if(nodesd[i].name.indexOf(key)!=-1){ 
					zTree.selectNode(nodesd[i]);
					zTree.expandNode(nodesd[i],false,false,false); 
					oldSearchValue = key;
					return; 
			     } 
	        }
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
	var userIDs = one_user_id;//单人个配置的赋值
	if (!$("#batch")[0].checked && userIDs == '') {
	
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
			url : window.top.getContextPath()+'/pubtree',
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
			method : 'batchSaveDateResources'
		}
		ajaxTools(span);
}

function saveOk(){
	$("#save").removeAttr("disabled");
}

