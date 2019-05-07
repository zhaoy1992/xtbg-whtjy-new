<%@ page language="java"
	import="java.sql.*,java.util.*,com.chinacreator.iWebOffice2006.iDBManager2000,com.chinacreator.sysmgrcore.entity.Permission,
	com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil,
	com.chinacreator.epp.util.EgpManager,com.chinacreator.config.ConfigManager,com.frameworkset.util.ListInfo,
	com.chinacreator.sysmgrcore.manager.db.ResManagerImpl,com.chinacreator.security.AccessControl"
	contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>


		<title>文档模板权限设置</title>

		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link rel="stylesheet" type="text/css"
			href="../../eformsys/fceform/js/Ext/css/ext-all.css" />
		<script type="text/javascript" charset="utf-8"
			src="../../eformsys/fceform/js/Ext/ext-base.js"></script>
		<script type="text/javascript" charset="utf-8"
			src="../../eformsys/fceform/js/Ext/ext-all-debug.js"></script>
		<script type="text/javascript" charset="utf-8"
			src="../../eformsys/fceform/js/Ext/ext-lang-zh_CN.js"></script>
		<script type="text/javascript" charset="utf-8"
			src="../../eformsys/fceform/js/Ext/TreeCheckBoxNodeUI.js"></script>
	</head>

	<body>
		<script>
		var path = "<%=path%>";
		var treedata = {id:'0',text:'机构文档树',leaf:false};
	 	-function(){
	    <%  
	    	Connection conn = null;
	    	Statement orgquery = null;
	    	try{
	    		String orgtree = ConfigManager.getInstance().getConfigValue("office.templet.manager.orgtree");//只否只显示授权的机构
	    		List orgPermission = new ArrayList();
	    		if("1".equals(orgtree)&&!accesscontroler.isAdmin()){
		            Map paramMap = new HashMap();
		            paramMap.put("type", "user");
					paramMap.put("id", userId);
		            ListInfo listInfor = new ResManagerImpl().getResList(paramMap, 0, 1000);
		            List allResource = listInfor.getDatas();
		            for(int j=0;j<allResource.size();j++){
		            	String resTypeName = ((Permission)allResource.get(j)).getResTypeName();
		            	if("机构资源".equals(resTypeName)){
		            		orgPermission.add(((Permission)allResource.get(j)).getResId());
		            	}
		            }
	    		}
	    		StringBuffer orgoutstr = new StringBuffer("var orgdata = [");
		    	//查询机构数据
		    	//String orgsql = "select org_name, t.org_id, t.parent_id, decode(sign((select max(level) from td_sm_organization t  connect by prior t.org_id = t.parent_id   start with t.parent_id = 0) - level),  0,  'false',  'true') hasson  from td_sm_organization t connect by prior t.org_id = t.parent_id start with t.parent_id = 0 order by level asc";
	    		String orgsql = "select org_name, t.org_id, t.parent_id, decode(sign((select max(level) from td_sm_organization s  connect by prior s.org_id = s.parent_id   start with s.parent_id = t.org_id) - level),  0,  'true',  'false') hasson  from td_sm_organization t connect by prior t.org_id = t.parent_id start with t.parent_id = 0 order by level asc";
		   		conn = DBUtil.getConection(EgpManager.getAppDBName());
		   		orgquery = conn.createStatement();
		   		ResultSet rs = orgquery.executeQuery(orgsql);	   		
		   		while(rs.next()){
		   			String orgId = rs.getString("org_id");
		   			if("1".equals(orgtree)&&!accesscontroler.isAdmin()){
		   				if(orgPermission.contains(orgId))
		   				orgoutstr.append("{orgname:'"+rs.getString("org_name")+"',orgid:'"+orgId+"',parent_id:'"+rs.getString("parent_id")+"',hasson:"+rs.getString("hasson")+"},");
		   			}else{
		   				orgoutstr.append("{orgname:'"+rs.getString("org_name")+"',orgid:'"+orgId+"',parent_id:'"+rs.getString("parent_id")+"',hasson:"+rs.getString("hasson")+"},");
		   			}
		   		}
		   		out.println(orgoutstr.toString().replaceAll(",$","")+"];");	   			   		
	    	}catch(Exception e){
	    		e.printStackTrace();
	    		out.println("var orgdata = [];");
	    	}finally{
	    		if(orgquery!=null){
	    			orgquery.close();
	    		}
	    		if(conn!=null){
	    			conn.close();   
	    		}
	    	}
	    %>
	    	
	    	//递归生成树
		    function buildTreeNodeJson(obj){
		    	var jsondata = new Array();	   		
		    	for(var i=0;i<orgdata.length;++i){
		    		var tmpobj = {};
			    	if(orgdata[i].parent_id==obj.orgid){
			    		tmpobj.id = orgdata[i].orgid;
				    	tmpobj.text = orgdata[i].orgname;
				    	tmpobj.leaf = orgdata[i].hasson==true?false:true;
			    		if(orgdata[i].hasson){
				    		tmpobj.children = buildTreeNodeJson(orgdata[i]);
			    		}else{
			    			tmpobj.children = [];
			    		}
			    		jsondata.push(tmpobj);
			    	}
		    	}
		    	return jsondata;
		    }
		    treedata.children = buildTreeNodeJson({orgid:'0'});
		    
	    }();
	    
	    var curOrgId = 0;
	    
	    Ext.onReady(function(){
		    Ext.BLANK_IMAGE_URL = '../../eformsys/fceform/js/Ext/images/default/s.gif';
		    
		    var tree = new Ext.tree.TreePanel({
		        //el: 'ExtTree1',
		        title: '机构树',
		        width:200,
		        region: 'west',
		        frame: false,
		        autoScroll: 'true',
		        enableDD:true,
		        loader: new Ext.tree.TreeLoader({
		        	dataUrl:''
		        }),
		        tbar: [new Ext.form.TextField({
		            emptyText: '输入过滤字符',
		            allowBlank: true,
		            listeners: {
		                render: function(f){
		                    f.el.on('keydown', filterTree, f, {
		                        buffer: 350
		                    });
		                }
		            }
		        })],
				ddGroup: 'GridToTreeGroup',
				listeners: {
			        beforenodedrop: function(dropEvent) {  
			            var node = dropEvent.target;    // 目标结点  
			            var data = dropEvent.data;      // 拖拽的数据  
			            var point = dropEvent.point;    // 拖拽到目标结点的位置  
			            // 如果data.node为空，则不是tree本身的拖拽，而是从grid到tree的拖拽，需要处理  
			            if(!data.node) {  
			                var records = "";
			                for(var i=0,len = data.selections.length;i<len;++i){
			                	records += data.selections[i].get('recordid')+",";
			                }
			                records = records.replace(",$","");
				            Ext.Ajax.request({
							   url: path+'/servlet/CreatorPTServlet',
							   success: function(res){
							   		if(res.responseText == 'true'){							   			
							   			Ext.Msg.alert('提示',' 操 作 成 功! ');
							   			data.grid.store.reload();
							   		}else{
							   			Ext.Msg.alert('提示',' 操 作 失 败! ');
							   		}
							   },
							   failure: function(err){
							   		Ext.Msg.alert('提示',' 操 作 失 败! ');
							   },
							   params: { key: 'saveTmpOrg',recordid:records,orgid:node.attributes.id }
							});
			            }else{
			            	return false; //禁止树本身拖拽
			            }
			        }  
				 }  
		    });
		    var root = new Ext.tree.AsyncTreeNode(treedata);
		    tree.setRootNode(root);		   
		    
		    
		    var filter = new Ext.tree.TreeFilter(tree, {
		        clearBlank: true,
		        autoClear: true
		    });
		    
		    function filterTree(e){
		        var text = e.target.value;
		        var re = new RegExp(Ext.escapeRe(text), 'i');
		        filter.filterBy(function(n){
		            return re.test(n.text);
		        });
		    }
		    Ext.QuickTips.init();
		    if (Ext.isIE6) {
		        var nodes = null;
		        tree.on('beforecollapsenode', function(node){
		            nodes = tree.getChecked();
		        });
		        tree.on('expandnode', function(){
		            if (nodes == null) 
		                return;
		            for (var i = 0; i < nodes.length; ++i) {
		                if (nodes[i].isLeaf()) 
		                    nodes[i].getUI().toggleCheck(true);
		            }
		        });
		    }
		    
		    tree.on('click',function(node,e){
		    	curOrgId = node.id;
		    	grid.store.reload({params:{'orgid':curOrgId}});
		    	var detailPanel = Ext.getCmp('detailPanel');
		    	detailPanel.body.update('<span style="font-size:14px;color:blue">温馨提示:</span><span style="font-size:14px">双击列表中的一行修改权限,拖拽表格记录到机构树节点可以重新设置文档所属机构</span>');
		    });

		    var template = Ext.data.Record.create([
			    {name: 'recordid', mapping: 0}, 
			    {name: 'filename', mapping: 1},
			    {name: 'userid', mapping: 2},
			    {name: 'usergrant', mapping: 3},
			    {name: 'roleid', mapping: 4},
			    {name: 'rolegrant', mapping: 5},
			    {name: 'granttype', mapping: 6}
			]);

		    var store = new Ext.data.Store({		    		    	
		        proxy: new Ext.data.HttpProxy({
		            url: path+'/servlet/CreatorPTServlet'
		        }),
		        baseParams:{key:'getDocTmpList',userId:'<%=userId%>',isAdmin:'<%=accesscontroler.isAdmin()%>'},
		        reader:new Ext.data.ArrayReader({
		        	id:0
		        },template) 
		    });

		    var grid = new Ext.grid.GridPanel({
		    	ddGroup : 'GridToTreeGroup',
		    	enableDragDrop   : true,
		        //title:'模板列表',
		        store: store,
		        region: 'north',
		        width : 300,
		        height:200,
		        trackMouseOver:false,
		        disableSelection:true,
		        loadMask: true,
		        sm: new Ext.grid.RowSelectionModel({
		        	singleSelect:false
		        }),
		
		        // grid columns
		        columns:[{
		            header: "文档ID",
		            dataIndex: 'recordid',
		            align: 'center',
		            sortable: true
		        },{
		            header: "文件名称",
		            width:200,
		            dataIndex: 'filename',
		            align: 'center',
		            renderer:decode,
		            sortable: true
		        },{
		            header: "用户权限",
		            width:150,
		            dataIndex: 'usergrant',
		            renderer:decode,
		            align: 'center',
		            sortable: true
		        },{
		            header: "角色权限",
		            width:150,
		            renderer:decode,
		            dataIndex: 'rolegrant',
		            align: 'center',
		            sortable: true
		        }]
		    });
		    
		    store.load({params:{'orgid':curOrgId}});
		    
		    var unsignTmp = Ext.data.Record.create([
			    {name: 'recordid', mapping: 0},
			    {name: 'filename', mapping: 1},
			    {name: 'orgid', mapping: 2}
			]);
			
			var unsignstore = new Ext.data.Store({		    		    	
		        proxy: new Ext.data.HttpProxy({
		            url: path+'/servlet/CreatorPTServlet'
		        }),
		        baseParams:{key:'getUnsignTmpList'},
		        reader:new Ext.data.ArrayReader({
		        	id:0
		        },unsignTmp) 
		    });
		    
		    var unsigngrid = new Ext.grid.GridPanel({
		    	ddGroup : 'GridToTreeGroup',
		    	enableDragDrop   : true,
		        title:'无机构模板列表',
		        store: unsignstore,
		        region: 'center',
		        width : 300,
		        trackMouseOver:false,
		        //disableSelection:true,
		        loadMask: true,
		        sm: new Ext.grid.RowSelectionModel({
		        	singleSelect:false
		        }),
		
		        // grid columns
		        columns:[{
		            header: "文档ID",
		            dataIndex: 'recordid',
		            align: 'center',
		            sortable: true
		        },{
		            header: "文件名称",
		            width:200,
		            dataIndex: 'filename',
		            align: 'center',
		            renderer:decode,
		            sortable: true
		        },{
		            header: "原属机构ID",
		            width:150,
		            dataIndex: 'orgid',
		            align: 'center',
		            sortable: true
		        }]
		    });
		    
		    unsignstore.load();
		    
		    var subp = new Ext.Panel({
		    	title: '文档列表',
		        collapsible:false,
		        layout   : 'border',
		        region: 'center',
		        items:[
		        	grid,
		        	unsigngrid,
		        	{
						id: 'detailPanel',
						region: 'south',
						bodyStyle: {
							background: '#ffffff',
							padding: '7px'
						},
						html: '<span style="font-size:14px;color:blue">温馨提示:</span><span style="font-size:14px">双击文档列表中的一行修改权限,拖拽表格记录到机构树节点可以重新设置文档所属机构</span>'
					}
		        ]
		    });

		    
			var p = new Ext.Panel({
		        title: '文档权限设置',
		        collapsible:false,
		        layout   : 'border',
		        renderTo: 'panel',	
		        height:500,	        
		        items:[
		        	tree,
		        	subp
		        ]
		        
		    });
		    root.expand();
		    
		    grid.on('rowdblclick',function(grid,row,e){
		    	getGrantData(grid,grid.store.getAt(row));
		    }); 
		    
		    grid.store.on('update',function(s){
		    	var detailPanel = Ext.getCmp('detailPanel');
		    	detailPanel.body.update('');
		    	var button = new Ext.Button({
		    		renderTo:detailPanel.body,
		    		text:'保存权限设置',
		    		handler:function(){
		    			var ids="";
		    			var granttype="";
		    			var names="";
		    			var records="";
		    			var rs = grid.store.getModifiedRecords();
		    			if(rs.length<1){
		    				Ext.Msg.alert('提示','没有任何权限修改!');
		    				return;
		    			}
		    			for(var i=0;i<rs.length;++i){
		    				if(i!=0){
		    					ids +="||";
		    					granttype +="||";
		    					names +="||";
		    					records += "||";
		    				}
		    				records += rs[i].get('recordid');
		    				if(rs[i].get('granttype')=='role'){
			    				ids += rs[i].get('roleid');
			    				granttype += rs[i].get('granttype');
			    				names += rs[i].get('rolegrant');
			    			}else{
			    				ids += rs[i].get('userid');
			    				granttype += rs[i].get('granttype');
			    				names += rs[i].get('usergrant');
			    			}
		    			}
		    			Ext.Ajax.request({
						   url: path+'/servlet/CreatorPTServlet',
						   success: function(res){
						   		if(res.responseText == 'true'){
						   			Ext.Msg.alert('提示','操 作 成 功!');
						   			grid.store.reload({params:{'orgid':curOrgId}});
						   		}else{
						   			Ext.Msg.alert('提示','操 作 失 败!');
						   		}
						   },
						   failure: function(err){
						   		Ext.Msg.alert('提示','操 作 失 败!');
						   },
						   params: { key: 'saveTmpGrant',recordid:records,orgid:curOrgId,ids_str:ids,names_str:names,grantType:granttype }
						});
		    		}
		    	});
		    });		    
		   	
		   	
		   
		   	
		   	function getGrantData(grid,record){		
		   		var ids,granttype,names;		
				if(record.get('granttype')=='role'){
					granttype = 'role';
					ids = record.get('roleid');
					names = record.get('rolegrant');
				}else{
					granttype = 'user';
					ids = record.get('userid');
					names = record.get('usergrant');
				}
				var ret = showModalDialog('TemplateGrantSelect.jsp?ids_str='+ids+'&selectedTabPaneId='+granttype,ids+';'+names+';'+granttype,'dialogWidth: 500px;dialogHeight: 500px');	
				if(ret!="undefined" && ret!=null)
				{
			        var ret_arr = ret.split(";");
			        ids = ret_arr[0];
			        names = ret_arr[1];
			        granttype = ret_arr[ret_arr.length-1];
			        if(granttype=="role"){
			        	record.set('userid','');
			        	record.set('usergrant','');
			        	record.set('granttype','role');
			        	record.set('roleid',ids);
			        	record.set('rolegrant',names);
			        }else{
			        	record.set('granttype','user');
			        	record.set('userid',ids);
			        	record.set('usergrant',names);
			        	record.set('roleid','');
			        	record.set('rolegrant','');
			        }
			    }
			}
		   	
		});
		
		function decode(val){
			return decodeURI(val);
		}	
		
    
    </script>
		<DIV id=panel style="margin-left: 2%;"></DIV>
	</body>
</html>
