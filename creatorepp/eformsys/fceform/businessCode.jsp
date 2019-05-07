<%@ page language="java" import="com.chinacreator.security.AccessControl,java.util.*"
	contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>业务逻辑层管理</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link rel="stylesheet" type="text/css" href="./js/Ext/css/ext-all.css" />
	</head>
	<script type="text/javascript" charset="utf-8"
		src="./js/Ext/ext-base.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="./js/Ext/ext-all.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="./js/Ext/ext-lang-zh_CN.js"></script>
	<script type="text/javascript">	
	Ext.QuickTips.init();
	var keywords = ['↙', 'int', 'void', 'public', 'private', 'String', 'float', 'protect', 'static', 'final', 'try', 'catch', 'fanally', 'boolean'];
	var ignoreKeys = [33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 8];
	
	window.onload = function(){
	    Ext.BLANK_IMAGE_URL = './js/Ext/images/default/s.gif';
	    
	    var record = new Ext.data.Record.create([{
	        name: 'codeid',mapping: 0
	    }, {
	        name: 'package',mapping: 1
	    }, {
	        name: 'classname',mapping: 2
	    }, {
	        name: 'importstr',mapping: 3
	    }, {
	    	name: 'javacode',defaultValue: 'unopen'
	    }]);
	    
	    var reader = new Ext.data.JsonReader({
	    	totalProperty: "total",
    		root: "rows"
	    },record);
	    var s = new Ext.data.GroupingStore({
	        reader: reader,
	        sortInfo: {
	            field: 'classname',
	            direction: "ASC"
	        },
	        groupField: 'package',
	        proxy: new Ext.data.HttpProxy({
	            url: '<%=path%>/servlet/CreatorPTServlet?key=getJavaList',
	            method: 'GET'
	        })
	    });
	    
	    var pagingBar = new Ext.PagingToolbar({
	        pageSize: 20,
	        store: s,
	        displayInfo: true,
	        displayMsg: '当前显示第 {0} - {1} 条 共{2}条',
	        emptyMsg: "没有数据"
	    });
	    
	    var grid1 = new Ext.grid.GridPanel({
	        store: s,
	        cm: new Ext.grid.ColumnModel([new Ext.grid.RowNumberer(), {
	            header: "类名",
	            sortable: true,
	            dataIndex: 'classname'
	        }, {
	            header: "引入类",
	            sortable: true,
	            dataIndex: 'importstr'
	        }, {
	            header: "包路径",
	            sortable: true,
	            dataIndex: 'package'
	        }]),
	        view: new Ext.grid.GroupingView({
	            forceFit: true,
	            groupTextTpl: '{text}'
	        }),
	        sm: new Ext.grid.RowSelectionModel({singleSelect: true}),
	        loadMask: true,
	        collapsible: true,
	        width      : 525,
	        enableDragDrop   : true,
	        //stripeRows       : true,
			region           : 'west',
	        ddGroup: 'gridDDGroup',
	        animCollapse: false,
	        title: '业务逻辑代码',
	        iconCls: 'icon-grid',
	        bbar: pagingBar
	    });
	    //alert(2);
	    s.load({params:{start:0, limit:20}});
	    //alert(3);
	    var textarea = new Ext.form.TextArea({
	        emptyText: '这里输入 Java 代码'
	    });
	    
	    var win = new Ext.Window({
	        title: '业务代码',
	        layout: 'fit',
	        width: 500,
	        height: 300,
	        closeAction: 'hide',
	        plain: true,
	        items: textarea,
	        buttons: [{
	            text: '确定',
	            handler: function(){
	            	var r = grid1.getSelectionModel().getSelected();
	            	r.set('javacode',textarea.getRawValue().replace(/↙/g,'\r\n'));
	    			formPanel.getForm().loadRecord(r);
	                win.hide();
	            }
	        }, {
	            text: '取消',
	            handler: function(){
	            	textarea.setRawValue("");
	                win.hide();
	            }
	        }]
	    });
	    
	    var flag = false;
	    
	    var menu = new Ext.menu.Menu([{
	    	id : 'del',
	    	text : '删除',
	    	handler : function(){
	    		 displayPanel.getEl().mask('操作进行中.....');
	    		 Ext.Ajax.request({
						   url: '<%=path%>/servlet/CreatorPTServlet?key=delJavaCode',
						   success: function(response){
						   		try{						   		
			                		var obj = Ext.decode(response.responseText);
			                		if(obj.success==true){
			                			Ext.Msg.alert('提示','删除操作成功!');
			                			grid1.getStore().reload();
			                			if(rightrecord.get('codeid')==textField4.getValue){
			                				formPanel.getForm().reset();
			                			}
			                		}
		                		}catch(e){
		                			Ext.Msg.alert('提示','删除操作失败!');
		                		}
		                		menu.hide();
		                		displayPanel.getEl().unmask();
						   },
						   failure : function(){
						   		Ext.Msg.alert('提示','删除操作失败!');
						   		menu.hide();
		                		displayPanel.getEl().unmask();
						   },
						   method : 'GET',
						   params: { codeid: rightrecord.get('codeid') }
				});	
	    	}
	    },{
	    	id : 'cancel',
	    	text : '取消',
	    	handler : function(){
	    		menu.hide();
	    	}
	    }]);
	    
	    var rightrecord;
	    grid1.on('rowcontextmenu',function(obj,index,e){
	    	rightrecord = obj.getStore().getAt(index);
	    	e.preventDefault();
	    	menu.showAt(e.getPoint());
	    });
	    
	    grid1.on("rowclick", function(a, b, c){
	    	var r = grid1.getSelectionModel().getSelected();
	    
	    	formPanel.getForm().loadRecord(r);	
				
			formPanel.getBottomToolbar().items.item(0).getEl().innerHTML="当前状态:<b>修改</b>";
			
			formPanel.body.stopFx();
			formPanel.body.highlight();
	    });
	    
	    grid1.on("rowdblclick", function(a, b, c){
	    	var r = grid1.getSelectionModel().getSelected();
	    	if(r.get('javacode') != ""&&r.get('javacode') != "unopen"){
	    		str = r.get('javacode');
	    		win.show();
		        win.getEl().fadeIn({
		            duration: 1
		        });
		        showOnTextarea(str);
	    	}else{
		        win.show();
		        win.getEl().fadeIn({
		            duration: 1
		        });
		        Ext.Ajax.request({
						   url: '<%=path%>/servlet/CreatorPTServlet?key=getJavaCode',
						   success: function(response){
						   		//textarea.setRawValue(response.responseText);
		                		str = unescape(decodeURI(response.responseText));
		                		//alert(str);
						        showOnTextarea(str);
						   },
						   method : 'GET',
						   params: { codeid: r.get('codeid') }
				});	    
			}    
	    });
	    
	    function showOnTextarea(str){
	    	var obj = document.createElement("SPAN");
	        str = str.replace(/\r\n|↙/g, "<font color=blue>↙</font><br/>");
	        for (var i = 0; i < keywords.length; ++i) {
	            var regexTmp = new RegExp('\\b(' + keywords[i] + ')\\b', 'g');
	            str = str.replace(regexTmp, "<font color=blue>$1</font>");
	        }
	        obj.innerHTML = str;
	        textarea.setRawValue("");	        
	        textarea.el.dom.appendChild(obj);
	    }
	    
	    
	    var textField1 = new Ext.form.TextField({
			fieldLabel : '类名',
			name       : 'classname',
			allowBlank : false,
			blankText : '类名不允许为空',
			enableKeyEvents : true
		});
		
		
		var textField2 = new Ext.form.TextField({
			fieldLabel : '包名',
			name       : 'package',
			allowBlank : false,
			blankText : '包名不允许为空',
			enableKeyEvents : true
		});
		
		
		var textField3 = new Ext.form.TextField({
			fieldLabel : '引入类',
			name       : 'importstr',
			enableKeyEvents : true
		});	
		
		function bindGrid(obj){
			if(textField4.getValue!=''){		
				var r = grid1.getSelectionModel().getSelected();		
				if(typeof(r)!='undefined'){
					r.set(obj.getName(),obj.getValue());					
				}else{
					gridAddNullRow();
					r = grid1.getSelectionModel().getSelected();		
					r.set(obj.getName(),obj.getValue());
				}
				obj.focus(false,10);
			}
		}
		
		function gridAddNullRow(){
			var r = new record({
       			codeid : '',
       			package : '',
       			classname : '',
       			importstr : '',
       			javacode : ''
       		});
       		s.add(r);
       		var sm = grid1.getSelectionModel();
			sm.selectRecords([r]);
		}
		
		textField1.on('keyup',bindGrid);
		textField2.on('keyup',bindGrid);
		textField3.on('keyup',bindGrid);
		
		var textField4 = new Ext.form.TextField({
			fieldLabel : 'codeid',
			name       : 'codeid',
			hideLabel  : true,
			cls		   : 'x-hidden'
			 
		});	
		
		var textField5 = new Ext.form.TextArea({
			fieldLabel : 'javacode',
			name       : 'javacode',
			hideLabel  : true,
			cls		   : 'x-hidden'
			 
		});	
		textField5.setValue("unopen");
		// Setup the form panel 
			
		var formPanel = new Ext.form.FormPanel({
			region     : 'center',
			title      : 'Generic Form Panel',
			bodyStyle  : 'padding: 10px; background-color: #DFE8F6',
			labelWidth : 100,
			width      : 325,
			items      : [
				textField1,
				textField2,
				textField3,
				textField4,
				textField5
			],
			bbar    : [
				{		
					text:'当前状态:<b>新增</b>',
					xtype:'tbtext'
				},
				'->',
				{
					text : '新	增'	 ,
		        	handler : function(){
		        		formPanel.getForm().reset();
		        		formPanel.getBottomToolbar().items.item(0).getEl().innerHTML="当前状态:<b>新增</b>";
		        		gridAddNullRow();	
		        		textField5.setValue("unopen");	        		
		        	}
	        	},
	        	{
					text    : '保  存',
					type	: 'submit',
					handler : function(){
						if(textField1.getValue().replace(/\s/g,'')==''||textField2.getValue().replace(/\s/g,'')==''){
							Ext.Msg.alert('消息', '类名或者包名不能为空');
							return;
						}
						if(grid1.getStore().queryBy(function(r){
							return r.get('classname')==textField1.getValue().replace(/\s/g,'') && r.get('package') == textField2.getValue().replace(/\s/g,'');
						}).length >1){
							Ext.Msg.alert('消息', '该类已经存在!');
							return;
						}
						formPanel.getForm().doAction('submit',{
							url : '<%=path%>/servlet/CreatorPTServlet?key=insertJavaCode',
							method:'POST',
							waitMsg:'正在保存...',  
							timeout:10000,
							success:function(form, action){  
								var isSuc = action.result.success;  
								if(isSuc) {
				                    Ext.Msg.alert('消息', '保存操作成功');  
				                    grid1.getStore().reload();
				                }else{
				                	//alert(unescape(decodeURI(action.result.message)));
				                	Ext.Msg.alert('消息', '保存操作失败!'+unescape(decodeURI(action.result.message)));  
				                }
			                },  
			                failure:function(form, action){  
			                    Ext.Msg.alert('消息','保存操作失败!'+unescape(decodeURI(action.result.message)));
			                }  
						});
						//formPanel.getForm().submit();
					}	
				}
			]
		});
	
	
		
		//Simple 'border layout' panel to house both grids
		var displayPanel = new Ext.Panel({
			width    : 850,
			height   : 400,
			layout   : 'border',
			renderTo : 'gridlist',
			items    : [
				grid1,
				formPanel
			]			
		});
		
	
		var formPanelDropTargetEl =  formPanel.body.dom;
		
		var formPanelDropTarget = new Ext.dd.DropTarget(formPanelDropTargetEl, {
			ddGroup     : 'gridDDGroup',
			notifyEnter : function(ddSource, e, data) {
				
				formPanel.body.stopFx();
				formPanel.body.highlight();
			},
			notifyDrop  : function(ddSource, e, data){
				
				var selectedRecord = ddSource.dragData.selections[0];						
				
				formPanel.getForm().loadRecord(selectedRecord);	
				
				formPanel.getBottomToolbar().items.item(0).getEl().innerHTML="当前状态:<b>修改</b>";
				//ddSource.grid.store.remove(selectedRecord);	
				return(true);
			}
		}); 
	};
	
	 
	</script>

	<body>
		<div id="gridlist" style="margin-left: 10px; margin-top: 50px"></div>
	</body>
</html>
