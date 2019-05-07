/**
* 流程活动扩展属性配置表单
* author: 郭明华
* date: 2010-7-8
* version: 3.0
*/
var panel = new Ext.FormPanel({   
	title:"活动扩展配置",   
	frame: true,  
	width:680,   
	layout:'form',  
	items:[{
		layout:"column", 
		items:[
			{xtype: 'label', html: '选前置活动执行人：'},
			{xtype: 'label', html: '<input type="text" id="AUTOASSIGNMENT"  name="AUTOASSIGNMENT" width="100%"/>'},
			{xtype: 'textfield',id:'activityId', name: 'activityId',cls: 'x-hidden'}
		]
	},{
		layout:"column", 
		items:[
			{xtype: 'checkbox',boxLabel: '动态选择执行人', id:'DYNAMICPERFORMER', name: 'DYNAMICPERFORMER',width:'33%'},
            {xtype: 'checkbox',boxLabel: '<span ext:qtip="只能在与分支环节使用">指定后续与活动参与者</span>', id:'ANDSPLITUSERS', name: 'ANDSPLITUSERS',width:'33%',disabled: false},
			{xtype: 'checkbox',boxLabel: '<span ext:qtip="影响动态选择执行人">动态选人只显示本机构用户</span>', id:'CURRENTORGUSER', name: 'CURRENTORGUSER',width:'33%'},
			{xtype: 'checkbox',boxLabel: '<span ext:qtip="不能在与分支环节使用">手动指定下一步活动</span>', id:'NEXT_ACT', name: 'NEXT_ACT',width:'33%'},
			{xtype: 'checkbox',boxLabel: '活动自动完成', id:'AUTO_COMPLETE', name: 'AUTO_COMPLETE',width:'33%'}
		]
	}],   
	buttons: [{
            text: '保存',
            handler: function(){
               if(panel.getForm().isValid()){
                    //Ext.Msg.alert('提交', '下列信息将被保存: <br />'+ panel.getForm().getValues(true).replace(/&/g,', '));
                    var values = panel.getForm().getValues(true);//.replace(/&/g,', ');
                    saveFormData();
                }
            }
        },{
            text: '清空',
            handler: function(){
            	var actId = document.getElementById("activityId").value;
                panel.getForm().reset();
                combo.setValue("");
				document.getElementById("activityId").value = actId;
            }
   }] 
});
panel.render('editform');

//new Ext.ToolTip({   
//    target: 'AUTOASSIGNMENT',   
//    html: '输入当前活动之前的活动ID'  
//}); 
    
Ext.QuickTips.init();

//属性名数组
var extendAtrNames = ['AUTOASSIGNMENT','ANDSPLITUSERS','CURRENTORGUSER','DYNAMICPERFORMER','NEXT_ACT','AUTO_COMPLETE'];
//var extendAtrNames = ['AUTOASSIGNMENT','CURRENTORGUSER','DYNAMICPERFORMER','AUTO_COMPLETE'];
//var extendAtrNames = ['AUTOASSIGNMENT','CURRENTORGUSER','DYNAMICPERFORMER','NEXT_ACT','AUTO_COMPLETE'];
/**
* 表单数据加载
*/
var loadFormData = function(actId) {
	//processConfigManager.getBeforeActs(actId,process_all_name,function(data1){
		//alert(data1);
		var options = {params:{"pro_version" : pro_version,"pro_name" : pro_name,"pro_id" : pro_id, "actId" :actId},scope:"request",add:true};
		//combo.store.proxy = new Ext.data.HttpProxy({url:"comboJson.jsp?pro_version="+pro_version+"&pro_name="+pro_name+"&pro_id="+pro_id+"&actId="+actId});
		combo.store.removeAll();
		combo.store.load(options);
	//});
	document.getElementById("activityId").value = actId;
    processConfigManager.getExtendAttributes(module_id,process_all_name,actId,extendAtrNames,function(attrs){
		panel.getForm().setValues(attrs);
		combo.setValue(attrs["AUTOASSIGNMENT"]);
    });
    processConfigManager.isAndTypeSplit(actId, process_all_name, function(ret){
    	if(!ret){
    		document.getElementById("ANDSPLITUSERS").parentNode.style.display = "none";
    		document.getElementById("NEXT_ACT").parentNode.style.display = "";
    	}else{
    		document.getElementById("ANDSPLITUSERS").parentNode.style.display = "";
    		document.getElementById("NEXT_ACT").parentNode.style.display = "none";
    	}
    });
};
 

/**
* 表单数据保存
*/
var saveFormData = function(){
	var activityId = $F("activityId");
	if(activityId == ''){
		alert("请先选择一条活动记录");
		return;
	}
	var jsonArray = [];
	jsonArray.push("{id:'",process_config_id,
				"',moduleId:'",module_id,
				"',moduleName:'",module_name,
				"',processName:'",process_all_name,
				"',durationUnit:'",$F("duration_unit"),
				"',processLimit:'",$F("process_limit"),
				"',activityProperties:[");
	for(var i=0; i < extendAtrNames.length; i++){
		var extendAtrValue = "";
		var extendAtrName = extendAtrNames[i];
		if(extendAtrName == "AUTOASSIGNMENT"){
			extendAtrValue = combo.getValue();
		}else{
			extendAtrValue = $(extendAtrName).checked;
		}
		jsonArray.push("{'activityId':'",activityId);
		jsonArray.push("','activityName':'",activityId);
		jsonArray.push("','propertyName':'",extendAtrName);
		jsonArray.push("','propertyValue':'",extendAtrValue);
		if(i < extendAtrNames.length - 1){
			jsonArray.push("'},");
		}else{
			jsonArray.push("'}");
		}
	}
	jsonArray.push("]}");
	processConfigManager.saveProcessConfig(jsonArray.join(""), saveFormDataCallBack);
}

/**
* 表单数据保存回调
*/
var saveFormDataCallBack = function(bSuccess){
	if(bSuccess){
		alert('保存成功！');
		var activityId = $F("activityId")
		loadFormData(activityId);
	}else{
		alert("保存失败!"+bSuccess);
	}
}

var tpl = '<tpl for="."><div class="x-combo-list-item" ext:qtitle="" ext:qtip="{Name}">{Name}</div></tpl>'
var comboStore = new Ext.data.Store({
	proxy: new Ext.data.HttpProxy({url:"comboJson.jsp"}), // 数据源 
    reader: new Ext.data.JsonReader({root:"Data",fields:[{name: 'ID'},{name: 'Name'}]})// 如何解析
});
var combo = new Ext.form.ComboBox({
    store: comboStore,
    hiddenName: 'ID',
    valueField:'ID',
    editable: false,
    displayField:'Name',
    typeAhead: true,
    //autoload: true,
    mode: 'local',
    triggerAction: 'all',
    emptyText:'',
    selectOnFocus:true,
    tpl :tpl, 
    applyTo: 'AUTOASSIGNMENT'
});
//设置父节点div宽度，解决ie7下ext combobox显示不全的问题
document.getElementById('AUTOASSIGNMENT').parentNode.style.width="100%";
