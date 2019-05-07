
Ext.BLANK_IMAGE_URL = 'images/s.gif';
var grid = null;
var grid_extend = null;//��չ  add by minghua.guo 100708
var PariticpantMapping = {
	"User" : "�û�",
	"Institute" : "����",
	"Role" : "��ɫ",
	"Group" : "�û���",
	"Position" : "��λ",
	"AssignmentPlugin" : "��չ" 
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
    //��processConfigManager��getActivityProperty�����й���
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
           header: "�����",
           dataIndex: 'activityName',
           width: 80
        },
        {
           header: "����",
           dataIndex: 'ACTIVITY_SEQUENCE',
           width: 50//,
           //editor: new fm.NumberField({
           //    allowBlank: false
           //})
        },
		{
           header: "�����",
           dataIndex: 'ACTIVITY_ALIAS',
           width: 80,
           editor: new fm.TextField({
               allowBlank: true
           }),
           renderer:decodeHTML
        },
		{
           header: "������",
           dataIndex: 'ACTIVITY_PARTICIPANT',
           width: 260,
           allowBlank: true,
//           editor: new fm.TextField({
//              allowBlank: true
//           })
		   renderer:function(value){
           		var xmlDoc = checkXMLDocObj(value);//����XML
           		var nodes = xmlDoc.getElementsByTagName("ExtendedAttribute");//����
           		var dict = new Dictionary();
           		var newValueArray = [];
           		for(var i=0,l=nodes.length;i<l;i++){
           			var nType = nodes[i].getAttribute("Name");
           			var nValue = "";
           			if(nType=="AssignmentPlugin"){
           				dict.put(nType, nodes[i].text);//������ΪAssignmentPluginʱ�����������⴦��
           			}else{
           				//���������λ�ķָ�����$$���滻Ϊ���ġ�
           				dict.put(nType, nodes[i].getAttribute("Value").replace(/\$\$/g,'��'));
           			}
           		}
        		
				for(var k in dict.values){
					if(typeof dict.values[k]!='function'){
						var userName = dict.get(k);
						var userRealName = '';
						//modify by minghua.guo 2010-02-08 ������ʾ�û�ʵ��
						if(k=='User'){
		   					DWREngine.setAsync(false);//��Ϊͬ��
							processConfigManager.getUserRealNameByUserName(userName,function(backdata){
								userRealName = backdata;
							});
							if(userRealName==''){
								userRealName = userName;
							}
		   					DWREngine.setAsync(true);//��Ϊ�첽
						}else{//�����û�
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
           header: "����",
           dataIndex: 'ACTIVITY_LIMIT',
           width: 40,
           editor: new fm.TextField({
               allowBlank: true
           })
        },
		{
           header: "��",
           dataIndex: 'ACTIVITY_FORM',
           width: 170,
		   allowBlank: true,
		   //modify by minghua.guo 2010-02-08��ʾ������
		   //renderer:decodeHTML
		   renderer:function(value){
		   		DWREngine.setAsync(false);//��Ϊͬ��
		   		var efom_name = '';
		   		processConfigManager.getEformNameByID(value,function(backdata){
		   			efom_name = backdata;
		   		});
		   		if(efom_name==''){
		   			efom_name = value;
		   		}
		   		DWREngine.setAsync(true);//��Ϊ�첽
		   		return efom_name;
		   }
//           editor: new fm.TextField({
//               allowBlank: true
//           })
        }
    ]);

    cm.defaultSortable = true;
//��չ   add by minghua.guo 100708  begin========
    var cm1 = new Ext.grid.ColumnModel([
		{
           id:'common',
           header: "�����",
           dataIndex: 'activityName',
           width: 80
        },
        {
           header: "����",
           dataIndex: 'ACTIVITY_SEQUENCE',
           width: 50
        },
		{
           header: "�����",
           dataIndex: 'ACTIVITY_ALIAS',
           width: 80,
           renderer:decodeHTML
        },
		{
           header: "������",
           dataIndex: 'ACTIVITY_PARTICIPANT',
           width: 260,
           allowBlank: true,
		   renderer:function(value){
           		var xmlDoc = checkXMLDocObj(value);//����XML
           		var nodes = xmlDoc.getElementsByTagName("ExtendedAttribute");//����
           		var dict = new Dictionary();
           		var newValueArray = [];
           		for(var i=0,l=nodes.length;i<l;i++){
           			var nType = nodes[i].getAttribute("Name");
           			var nValue = "";
           			if(nType=="AssignmentPlugin"){
           				dict.put(nType, nodes[i].text);//������ΪAssignmentPluginʱ�����������⴦��
           			}else{
           				//���������λ�ķָ�����$$���滻Ϊ���ġ�
           				dict.put(nType, nodes[i].getAttribute("Value").replace(/\$\$/g,'��'));
           			}
           		}
        		
				for(var k in dict.values){
					if(typeof dict.values[k]!='function'){
						var userName = dict.get(k);
						var userRealName = '';
						//modify by minghua.guo 2010-02-08 ������ʾ�û�ʵ��
						if(k=='User'){
		   					DWREngine.setAsync(false);//��Ϊͬ��
							processConfigManager.getUserRealNameByUserName(userName,function(backdata){
								userRealName = backdata;
							});
							//if(userRealName==''){
							//	userRealName = userName;
							//}
		   					DWREngine.setAsync(true);//��Ϊ�첽
						}else{//�����û�
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
           header: "����",
           dataIndex: 'ACTIVITY_LIMIT',
           width: 40
        },
		{
           header: "��",
           dataIndex: 'ACTIVITY_FORM',
           width: 170,
		   allowBlank: true,
		   //modify by minghua.guo 2010-02-08��ʾ������
		   //renderer:decodeHTML
		   renderer:function(value){
		   		DWREngine.setAsync(false);//��Ϊͬ��
		   		var efom_name = '';
		   		processConfigManager.getEformNameByID(value,function(backdata){
		   			efom_name = backdata;
		   		});
		   		if(efom_name==''){
		   			efom_name = value;
		   		}
		   		DWREngine.setAsync(true);//��Ϊ�첽
		   		return efom_name;
		   }
        }
    ]);
    cm1.defaultSortable = true;
//��չ   add by minghua.guo 100708  end========

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
        title:'���̻����',
        frame:true,
        //plugins:checkColumn,  //zzy
        clicksToEdit:1,
        tbar: ''
    });
//��չ   add by minghua.guo 100708  begin========
    grid_extend = new Ext.grid.GridPanel({
        store: store,
        cm: cm1,
        renderTo: 'editgrid-extend',
        width:680,
        height:200,
        autoExpandColumn:'common',
        title:'���̻',
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
//��չ   add by minghua.guo 100708  end========
    
	grid.addListener('cellclick', cellclick);
	function cellclick(grid, rowIndex, columnIndex, e) {
	    var record = grid.getStore().getAt(rowIndex);
	    var fieldName = grid.getColumnModel().getDataIndex(columnIndex);
	    //modify by minghua.guo[2011-6-1]�����̻�����¼�����
	    var activityId = record.get("activityId");
	    processConfigManager.isSubFlowAct(process_all_name,activityId,function(data){
	    	if(!data){//�������̻
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
	    	}else{//�����̻�����µĶԻ��򣬽�������������ҳ��
	    		//��ȡ����������
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
//		e.row;//�޸��^���Џ�0�_ʼ
//		e.column;//�޸��Џ�0�_ʼ
//		e.originalValue;//ԭʼֵ
		var newValue = e.value;//��ֵ 
	    var record = grid.getStore().getAt(e.row);
	    var fieldName = grid.getColumnModel().getDataIndex(e.column);
	    if(fieldName=='ACTIVITY_LIMIT'){
		    var data = record.get(fieldName);
		    if(data!="" && !isLimitFormat(data)){
		    	//alert("��������޸�ʽ���ԣ���������¸�ʽ��\n   2h 2.5h 2d  ��h��Сʱ d�����ա�");
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
		e.row;//�޸��^���Џ�0�_ʼ
		e.column;//�޸���
		var oldValue = e.value;//ԭʼֵ
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


//�ж��Ƿ�Ϊ���޸�ʽ���磺2h  2.5h  2d  
function isLimitFormat(s){
	var hourPatrn=/^\d{1,3}(\.[0|5]{1})?[h|H]$/i;//11.2h
	var dayPatrn=/^\d{1,3}?([d|D]{0,1})$/i;//11d
	
	var unit = (s.substring(s.length-1));
	
	if(unit=='h'||unit=='H'){
		if(!hourPatrn.exec(s)){
			alert("���޸�ʽ����Сʱ��ʽ����Ϊ��1h��1.5h��ͬʱ����ֵ���ô���999��\n\nע����λ�����ִ�Сд������ΪhҲ��д��H");
			return false;
		}
		return true;
	}
	if(!dayPatrn.exec(s)){
		alert("���޸�ʽ���󣬹����ո�ʽֻ��Ϊ��22D��22d��ͬʱ����ֵ���ô���999 \n\n ע�������д��λ��ʹ���������޵�λ��");
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
		alert("���Ȱ���ѡ���̣��ٱ������ݣ�");
		return;
	}
	//add by minghua.guo [��ֹ�ظ��������][2011-03-18]
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
		alert('����ɹ���');
		processConfigManager.getProcessConfig4JSON(module_id,process_all_name
					,function(data4JSON){
						processConfig4JSON = Ext.util.JSON.decode(data4JSON);
						loadProcessProperties(processConfig4JSON);
						grid.getStore().loadData(processConfig4JSON);		
					}
		);		
	}else{
		alert("����ʧ��!"+bSuccess);
	}
	//add by minghua.guo [��ֹ�ظ�������� ��ָ�][2011-03-18]
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
        //�ж������������
        //֧��IE����� 
        if(!window.DOMParser && window.ActiveXObject){   //window.DOMParser �ж��Ƿ��Ƿ�ie�����
            var xmlDomVersions = ['MSXML.2.DOMDocument.6.0','MSXML.2.DOMDocument.3.0','Microsoft.XMLDOM'];
            for(var i=0;i<xmlDomVersions.length;i++){
                try{
                    xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                    xmlDoc.async = false;
                    xmlDoc.loadXML(xmlString); //loadXML��������xml�ַ���
                    break;
                }catch(e){
                }
            }
        }
        //֧��Mozilla�����
        else if(window.DOMParser && document.implementation && document.implementation.createDocument){
            try{
                /* DOMParser ������� XML �ı�������һ�� XML Document ����
                 * Ҫʹ�� DOMParser��ʹ�ò��������Ĺ��캯����ʵ��������Ȼ������� parseFromString() ����
                 * parseFromString(text, contentType) ����text:Ҫ������ XML ��� ����contentType�ı�����������
                 * ������ "text/xml" ��"application/xml" �� "application/xhtml+xml" �е�һ����ע�⣬��֧�� "text/html"��
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

 //��xml��������ж�
 function checkXMLDocObj(xmlString){
        var xmlDoc = loadXML(xmlString);
        if(xmlDoc==null){
            alert('�����������֧��xml�ļ���ȡ,���Ǳ�ҳ���ֹ���Ĳ���,�Ƽ�ʹ��IE5.0���Ͽ��Խ��������!');
            //window.location.href='ĳĳ��ַ(������ҳ)';
        }
        return xmlDoc;
    }
 
 /**
  * ���²�ѯ����grid
  * module_id����id
  * mgrName��������
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
		//add by minghua.guo [��ֹ�ظ�������� ��ָ�][2011-03-18]
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
   		DWREngine.setAsync(false);//��Ϊͬ��
		spProcessConfigManager.bindProcessConfig(jsonArray.join(""), saveDataCallBack);
   		DWREngine.setAsync(true);//��Ϊ�첽
	}