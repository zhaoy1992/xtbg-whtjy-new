
Ext.BLANK_IMAGE_URL = 'images/s.gif';
var grid = null;
var grid_extend = null;//扩展  add by minghua.guo 100708
var PariticpantMapping = {
	"User" : "用户",
	"Institute" : "机构",
	"Role" : "角色",
	"Group" : "用户组",
	"Position" : "岗位",
	"AssignmentPlugin" : "扩展" 
};
var Dictionary = function(){
	this.values =[];
	this.put = function(name, value){
		if(this.values.hasOwnProperty(name)){
			this.values[name].push(value);
		}else{
			this.values[name] = [];
			this.values[name].push(value);
		}
	};
	this.get = function(name){
		//alert(name +" is function :"+(typeof this.values[name]=='function'));
		if(this.values.hasOwnProperty(name)&&typeof this.values[name]!='function'){
			return this.values[name].join(",");
		}
		return "";
	};
	this.toString = function(){
		var s = [];
		for(var k in this.values){
			if(typeof this.values[k]!='function'){
				s.push(this.get(k));
			}
		}
		return s.join(",");
	};
};

Ext.onReady(function(){

    Ext.QuickTips.init();	//zzy

    var fm = Ext.form;
    //在processConfigManager的getActivityProperty方法中构造
	ActivityProperties = Ext.data.Record.create([
		{name: 'activityId', mapping:'id'},
	    {name: 'activityName', mapping: 'name'},
	    {name: 'ACTIVITY_SEQUENCE', mapping: 'properties.ACTIVITY_SEQUENCE'},
	    {name: 'ACTIVITY_ALIAS', mapping: 'properties.ACTIVITY_ALIAS'},
	    {name: 'ACTIVITY_PARTICIPANT', mapping: 'properties.ACTIVITY_PARTICIPANT'},
	    {name: 'ACTIVITY_LIMIT', mapping: 'properties.ACTIVITY_LIMIT'},
	    {name: 'ACTIVITY_FORM', mapping: 'properties.ACTIVITY_FORM'}
	]);
	var store = new Ext.data.Store({
	    proxy: new Ext.data.MemoryProxy(processConfig4JSON),
	    reader: new Ext.data.JsonReader({
	    	root: "activities", 
    		id: "id"  }, ActivityProperties)
    		});
	var decodeHTML = function(value){
		   	 return value.replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g,'&quot;');
	};
    var cm = new Ext.grid.ColumnModel([
		{
           id:'common',
           header: "活动名称",
           dataIndex: 'activityName',
           width: 80
        },
        {
           header: "活动序号",
           dataIndex: 'ACTIVITY_SEQUENCE',
           width: 50//,
           //editor: new fm.NumberField({
           //    allowBlank: false
           //})
        },
		{
           header: "活动别名",
           dataIndex: 'ACTIVITY_ALIAS',
           width: 80,
           editor: new fm.TextField({
               allowBlank: true
           }),
           renderer:decodeHTML
        },
		{
           header: "参与者",
           dataIndex: 'ACTIVITY_PARTICIPANT',
           width: 260,
           allowBlank: true,
//           editor: new fm.TextField({
//              allowBlank: true
//           })
		   renderer:function(value){
           		var xmlDoc = checkXMLDocObj(value);//解析XML
           		var nodes = xmlDoc.getElementsByTagName("ExtendedAttribute");//遍历
           		var dict = new Dictionary();
           		var newValueArray = [];
           		for(var i=0,l=nodes.length;i<l;i++){
           			var nType = nodes[i].getAttribute("Name");
           			var nValue = "";
           			if(nType=="AssignmentPlugin"){
           				dict.put(nType, nodes[i].text);//当类型为AssignmentPlugin时，名称做特殊处理
           			}else{
           				//将机构与岗位的分隔符“$$”替换为“的”
           				dict.put(nType, nodes[i].getAttribute("Value").replace(/\$\$/g,'的'));
           			}
           		}
        		
				for(var k in dict.values){
					if(typeof dict.values[k]!='function'){
						var userName = dict.get(k);
						var userRealName = '';
						//modify by minghua.guo 2010-02-08 用于显示用户实名
						if(k=='User'){
		   					DWREngine.setAsync(false);//设为同步
							processConfigManager.getUserRealNameByUserName(userName,function(backdata){
								userRealName = backdata;
							});
							if(userRealName==''){
								userRealName = userName;
							}
		   					DWREngine.setAsync(true);//设为异步
						}else{//不是用户
							userRealName = userName;
						}
						//newValueArray.push((newValueArray.length>0?";":""),PariticpantMapping[k], "(", dict.get(k),")");
						newValueArray.push((newValueArray.length>0?";":""),PariticpantMapping[k], "(", userRealName,")");
						//modify by minghua.guo 2010-02-08 end 
					}
				}
           		return newValueArray.join("");
           }
        },
		{
           header: "期限",
           dataIndex: 'ACTIVITY_LIMIT',
           width: 40,
           editor: new fm.TextField({
               allowBlank: true
           })
        },
		{
           header: "表单",
           dataIndex: 'ACTIVITY_FORM',
           width: 170,
		   allowBlank: true,
		   //modify by minghua.guo 2010-02-08显示表单名称
		   //renderer:decodeHTML
		   renderer:function(value){
		   		DWREngine.setAsync(false);//设为同步
		   		var efom_name = '';
		   		processConfigManager.getEformNameByID(value,function(backdata){
		   			efom_name = backdata;
		   		});
		   		if(efom_name==''){
		   			efom_name = value;
		   		}
		   		DWREngine.setAsync(true);//设为异步
		   		return efom_name;
		   }
//           editor: new fm.TextField({
//               allowBlank: true
//           })
        }
    ]);

    cm.defaultSortable = true;
//扩展   add by minghua.guo 100708  begin========
    var cm1 = new Ext.grid.ColumnModel([
		{
           id:'common',
           header: "活动名称",
           dataIndex: 'activityName',
           width: 80
        },
        {
           header: "活动序号",
           dataIndex: 'ACTIVITY_SEQUENCE',
           width: 50
        },
		{
           header: "活动别名",
           dataIndex: 'ACTIVITY_ALIAS',
           width: 80,
           renderer:decodeHTML
        },
		{
           header: "参与者",
           dataIndex: 'ACTIVITY_PARTICIPANT',
           width: 260,
           allowBlank: true,
		   renderer:function(value){
           		var xmlDoc = checkXMLDocObj(value);//解析XML
           		var nodes = xmlDoc.getElementsByTagName("ExtendedAttribute");//遍历
           		var dict = new Dictionary();
           		var newValueArray = [];
           		for(var i=0,l=nodes.length;i<l;i++){
           			var nType = nodes[i].getAttribute("Name");
           			var nValue = "";
           			if(nType=="AssignmentPlugin"){
           				dict.put(nType, nodes[i].text);//当类型为AssignmentPlugin时，名称做特殊处理
           			}else{
           				//将机构与岗位的分隔符“$$”替换为“的”
           				dict.put(nType, nodes[i].getAttribute("Value").replace(/\$\$/g,'的'));
           			}
           		}
        		
				for(var k in dict.values){
					if(typeof dict.values[k]!='function'){
						var userName = dict.get(k);
						var userRealName = '';
						//modify by minghua.guo 2010-02-08 用于显示用户实名
						if(k=='User'){
		   					DWREngine.setAsync(false);//设为同步
							processConfigManager.getUserRealNameByUserName(userName,function(backdata){
								userRealName = backdata;
							});
							//if(userRealName==''){
							//	userRealName = userName;
							//}
		   					DWREngine.setAsync(true);//设为异步
						}else{//不是用户
							userRealName = userName;
						}
						//newValueArray.push((newValueArray.length>0?";":""),PariticpantMapping[k], "(", dict.get(k),")");
						newValueArray.push((newValueArray.length>0?";":""),PariticpantMapping[k], "(", userRealName,")");
						//modify by minghua.guo 2010-02-08 end 
					}
				}
           		return newValueArray.join("");
           }
        },
		{
           header: "期限",
           dataIndex: 'ACTIVITY_LIMIT',
           width: 40
        },
		{
           header: "表单",
           dataIndex: 'ACTIVITY_FORM',
           width: 170,
		   allowBlank: true,
		   //modify by minghua.guo 2010-02-08显示表单名称
		   //renderer:decodeHTML
		   renderer:function(value){
		   		DWREngine.setAsync(false);//设为同步
		   		var efom_name = '';
		   		processConfigManager.getEformNameByID(value,function(backdata){
		   			efom_name = backdata;
		   		});
		   		if(efom_name==''){
		   			efom_name = value;
		   		}
		   		DWREngine.setAsync(true);//设为异步
		   		return efom_name;
		   }
        }
    ]);
    cm1.defaultSortable = true;
//扩展   add by minghua.guo 100708  end========

	var gridHeight = document.body.style.pixelHeight - Ext.get("processPropertyDiv").getHeight() - Ext.get("buttomDiv").getHeight() - 120;
	
	if(gridHeight>500){
		gridHeight = 450;
	}else if(gridHeight<200){
		gridHeight = 200;
	}
    grid = new Ext.grid.EditorGridPanelZZY({
        store: store,
        cm: cm,
        renderTo: 'editgrid',
        width:660,
        height:gridHeight,
        autoExpandColumn:'common',
        title:'流程活动配置',
        frame:true,
        //plugins:checkColumn,  //zzy
        clicksToEdit:1,
        tbar: ''
    });
//扩展   add by minghua.guo 100708  begin========
    grid_extend = new Ext.grid.GridPanel({
        store: store,
        cm: cm1,
        renderTo: 'editgrid-extend',
        width:680,
        height:200,
        autoExpandColumn:'common',
        title:'流程活动',
        frame:true,
        //plugins:checkColumn,  //zzy
        clicksToEdit:1,
        tbar: ''
    });
	grid_extend.on("rowclick", function(grid,rowIndex){
	    var record = grid.getStore().getAt(rowIndex);
		var actId = record.get("activityId");
	    loadFormData(actId);
	});
//扩展   add by minghua.guo 100708  end========
    
	grid.addListener('cellclick', cellclick);
	function cellclick(grid, rowIndex, columnIndex, e) {
	    var record = grid.getStore().getAt(rowIndex);
	    var fieldName = grid.getColumnModel().getDataIndex(columnIndex);
	    //modify by minghua.guo[2011-6-1]子流程活动单击事件处理
	    var activityId = record.get("activityId");
	    processConfigManager.isSubFlowAct(process_all_name,activityId,function(data){
	    	if(!data){//非子流程活动
			    if(fieldName == 'ACTIVITY_FORM'){
			    	var data = record.get(fieldName);
					var returnVal = window.showModalDialog("selEform.jsp?activity_form="+data,"", "font-family:Verdana; font-size:12; status:no; unadorned:no; scroll:no; resizable:yes;dialogWidth:420px; dialogHeight:350px");
					if(returnVal!=undefined){
					    record.set("ACTIVITY_FORM",returnVal);
					}
			    }else if(fieldName == 'ACTIVITY_PARTICIPANT'){
			    	var data = record.get(fieldName);
					var returnVal = window.showModalDialog("activity_participant.jsp?data="+data,"", "font-family:Verdana; font-size:12; status:no; unadorned:no; scroll:yes; resizable:yes;dialogWidth:450px; dialogHeight:360px");
					if(returnVal!=undefined){
					    record.set("ACTIVITY_PARTICIPANT",returnVal);
					}
			    }
	    	}else{//子流程活动，打开新的对话框，进入子流程配置页面
	    		//获取子流程名称
	    	    processConfigManager.getSubFlowMgrName(process_all_name,activityId,function(data){
	    	    	if(data != ""){
	    	    		window.showModalDialog("../procconfig/shark_content.jsp?id="+module_id+"&name="+module_name+"&processMgrName="+data+"&type=subflow",window,"dialogWidth:700px");
	    	    	}
	    	    });
	    	}
	    });
	    //if(fieldName == 'ACTIVITY_FORM'){
	    //	var data = record.get(fieldName);
		//	var returnVal = window.showModalDialog("selEform.jsp?activity_form="+data,"", "font-family:Verdana; font-size:12; status:no; unadorned:no; scroll:no; resizable:yes;dialogWidth:420px; dialogHeight:350px");
		//	if(returnVal!=undefined){
		//	    record.set("ACTIVITY_FORM",returnVal);
		//	}
	    //}else if(fieldName == 'ACTIVITY_PARTICIPANT'){
	    //	var data = record.get(fieldName);
		//	var returnVal = window.showModalDialog("activity_participant.jsp?data="+data,"", "font-family:Verdana; font-size:12; status:no; unadorned:no; scroll:yes; resizable:yes;dialogWidth:450px; dialogHeight:360px");
		//	if(returnVal!=undefined){
		//	    record.set("ACTIVITY_PARTICIPANT",returnVal);
		//	}
	    //}
	}

	grid.on('afteredit',function(e){
//		e.row;//修改過的行從0開始
//		e.column;//修改列從0開始
//		e.originalValue;//原始值
		var newValue = e.value;//新值 
	    var record = grid.getStore().getAt(e.row);
	    var fieldName = grid.getColumnModel().getDataIndex(e.column);
	    if(fieldName=='ACTIVITY_LIMIT'){
		    var data = record.get(fieldName);
		    if(data!="" && !isLimitFormat(data)){
		    	//alert("输入的期限格式不对，请参照以下格式：\n   2h 2.5h 2d  【h表小时 d表工作日】");
		    	record.set(fieldName,"");
		    	
		    }
	    }else{
	    	var data = record.get(fieldName);
	    	if(typeof data=='string' && isNaN(data)){
				newValue = newValue.replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\"/g,'&quot;');
			}
		    record.set(fieldName,newValue);
	    }
    });
    grid.on('beforeedit',function(e){
		e.row;//修改過的行從0開始
		e.column;//修改列
		var oldValue = e.value;//原始值
	    var record = grid.getStore().getAt(e.row);
	    var fieldName = grid.getColumnModel().getDataIndex(e.column);
	    var data = record.get(fieldName);
	    if(typeof data=='string'){
			oldValue = oldValue.replace(/&lt;/g, '<').replace(/&gt;/g,'>').replace(/&quot;/g,'"');
		    record.set(fieldName,oldValue);
	    }
    });
    store.load();
    for(var i=0;i<store.getCount();i++){
    	store.getAt(i).set("ACTIVITY_SEQUENCE", i+1);
    }
});


//判断是否为期限格式，如：2h  2.5h  2d  
function isLimitFormat(s){
	var hourPatrn=/^\d{1,3}(\.[0|5]{1})?[h|H]$/i;//11.2h
	var dayPatrn=/^\d{1,3}?([d|D]{0,1})$/i;//11d
	
	var unit = (s.substring(s.length-1));
	
	if(unit=='h'||unit=='H'){
		if(!hourPatrn.exec(s)){
			alert("期限格式错误，小时格式必须为：1h或1.5h，同时期限值不得大于999；\n\n注：单位不区分大小写，可以为h也可写成H");
			return false;
		}
		return true;
	}
	if(!dayPatrn.exec(s)){
		alert("期限格式错误，工作日格式只能为：22D或22d，同时期限值不得大于999 \n\n 注：如果不写单位则使用流程期限单位；");
		return false;
	}
	return true;	
}
function $F(id){
	return document.getElementById(id).value;
}
//
function savaProcessData(){
	var selectMgrName = $F("process_package") +"#"+ $F("process_version")  +"#"+ $F("process_name");
	if(process_all_name != selectMgrName){
		alert("请先绑定所选流程，再保存活动数据！");
		return;
	}
	//add by minghua.guo [防止重复点击保存][2011-03-18]
	document.getElementById("saveButton").disabled = true;
	var jsonArray = [];
	jsonArray.push("{id:'",process_config_id,
				"',moduleId:'",module_id,
				"',moduleName:'",module_name,
				"',processName:'",process_all_name,
				"',durationUnit:'",$F("duration_unit"),
				"',processLimit:'",$F("process_limit"),
				"',activityProperties:[");
	var modifiedRecords = grid.getStore().getModifiedRecords();
	var isPropertiesJsonEmpty = true;
	for(var i=0,len=modifiedRecords.length;i<len;++i){
		var record  = modifiedRecords[i];
		var activityId = record.get('activityId');
		var modifiedFields = record.getChanges();
		for(var fieldName in modifiedFields){
			var fieldValue = record.get(fieldName);
			
			if(typeof filedValue=='string' && isNaN(data)){
				fieldValue = fieldValue.replace(/&lt;/g, '<').replace(/&gt;/g,'>').replace(/&quot;/g,'\\"');
			}
			jsonArray.push(((isPropertiesJsonEmpty)?"":",")
						  ,"{'activityId':'",activityId
						  ,"','activityName':'",record.get('activityName')
						  ,"','propertyName':'",fieldName
						  ,"','propertyValue':'",fieldValue
						  ,"'}");
		    isPropertiesJsonEmpty = false;
		}
	}
	jsonArray.push("]}");
	processConfigManager.saveProcessConfig(jsonArray.join(""), saveDataCallBack);
}

function saveDataCallBack(bSuccess){
	if(bSuccess){
		alert('保存成功！');
		processConfigManager.getProcessConfig4JSON(module_id,process_all_name
					,function(data4JSON){
						processConfig4JSON = Ext.util.JSON.decode(data4JSON);
						loadProcessProperties(processConfig4JSON);
						grid.getStore().loadData(processConfig4JSON);		
					}
		);		
	}else{
		alert("保存失败!"+bSuccess);
	}
	//add by minghua.guo [防止重复点击保存 后恢复][2011-03-18]
	document.getElementById("saveButton").disabled = false;
	document.getElementById("bindButton").disabled = false;
}

function newXMLHttpRequest(){
	var xmlreq = false;
	if (window.XMLHttpRequest){
		xmlreq = new XMLHttpRequest();
	}else{
		if (window.ActiveXObject){
			try{
				xmlreq = new ActiveXObject("Msxml2.XMLHTTP");
			}catch (e1){
				try {
					xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
				}catch (e2){
					xmlreq = false;
				}
			}
		}
	}
	return xmlreq;
}


function loadXML(xmlString){
        var xmlDoc=null;
        //判断浏览器的类型
        //支持IE浏览器 
        if(!window.DOMParser && window.ActiveXObject){   //window.DOMParser 判断是否是非ie浏览器
            var xmlDomVersions = ['MSXML.2.DOMDocument.6.0','MSXML.2.DOMDocument.3.0','Microsoft.XMLDOM'];
            for(var i=0;i<xmlDomVersions.length;i++){
                try{
                    xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                    xmlDoc.async = false;
                    xmlDoc.loadXML(xmlString); //loadXML方法载入xml字符串
                    break;
                }catch(e){
                }
            }
        }
        //支持Mozilla浏览器
        else if(window.DOMParser && document.implementation && document.implementation.createDocument){
            try{
                /* DOMParser 对象解析 XML 文本并返回一个 XML Document 对象。
                 * 要使用 DOMParser，使用不带参数的构造函数来实例化它，然后调用其 parseFromString() 方法
                 * parseFromString(text, contentType) 参数text:要解析的 XML 标记 参数contentType文本的内容类型
                 * 可能是 "text/xml" 、"application/xml" 或 "application/xhtml+xml" 中的一个。注意，不支持 "text/html"。
                 */
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
 function checkXMLDocObj(xmlString){
        var xmlDoc = loadXML(xmlString);
        if(xmlDoc==null){
            alert('您的浏览器不支持xml文件读取,于是本页面禁止您的操作,推荐使用IE5.0以上可以解决此问题!');
            //window.location.href='某某地址(比如首页)';
        }
        return xmlDoc;
    }
 
 /**
  * 重新查询加载grid
  * module_id事项id
  * mgrName流程名称
  */
 function reloadGrid(module_id,mgrName){
 	spProcessConfigManager.getProcessConfig4JSON(module_id,mgrName,function(data){
 		processConfig4JSON = Ext.util.JSON.decode(data);
 		var obj = eval("("+data+")");
 		var activities = obj.activities;
 		var i = 0,len = activities.length;
 		grid.getStore().removeAll();
 		for(i=0;i<len;i++){
 			var activitive = activities[i];
 			var properties = activitive.properties;
 			var activity_alias = "";
 			if(typeof(properties.ACTIVITY_ALIAS)=="undefined"){
 				activity_alias = "";
 			}else{
 				activity_alias = properties.ACTIVITY_ALIAS;
 			}
 			var myNewRecord = new ActivityProperties({
 				activityId: activitive.id,
 				activityName: activitive.name,
 				ACTIVITY_ALIAS: activity_alias,
 				ACTIVITY_PARTICIPANT: properties.ACTIVITY_PARTICIPANT,
 				ACTIVITY_LIMIT: properties.ACTIVITY_LIMIT,
 				ACTIVITY_FORM: typeof(properties.ACTIVITY_FORM)=="undefined"?"":properties.ACTIVITY_FORM
 			});
 			grid.getStore().add(myNewRecord);
 		}	
 	});
 }
 function savaProcessConfig(){
		//add by minghua.guo [防止重复点击保存 后恢复][2011-03-18]
		document.getElementById("bindButton").disabled = true;
		process_config_id = $F("process_id");
		process_all_name = $F("process_package")+"#"+$F("process_version")+"#"+$F("process_name");
		var jsonArray = [];
		jsonArray.push("{id:'",process_config_id,
					"',moduleId:'",module_id,
					"',moduleName:'",module_name,
					"',processName:'",process_all_name,
					"',durationUnit:'",$F("duration_unit"),
					"',processLimit:'",$F("process_limit"),
					"'");
		jsonArray.push("}");
   		DWREngine.setAsync(false);//设为同步
		spProcessConfigManager.bindProcessConfig(jsonArray.join(""), saveDataCallBack);
   		DWREngine.setAsync(true);//设为异步
	}