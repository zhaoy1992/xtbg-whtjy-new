<%@ page language="java"
	import="java.sql.*,com.chinacreator.iWebOffice2006.iDBManager2000,com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil,com.chinacreator.epp.util.EgpManager"
	contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//AccessControl control = AccessControl.getInstance();
	//control.checkAccess(request,response);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	

		<title>文档模板导出</title>

		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link rel="stylesheet" type="text/css"
			href="../../eformsys/fceform/js/Ext/css/ext-all.css" />
		<script type="text/javascript" charset="utf-8"
			src="../../eformsys/fceform/js/Ext/ext-base.js"></script>
		<script type="text/javascript" charset="utf-8"
			src="../../eformsys/fceform/js/Ext/ext-all.js"></script>
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
	    	Statement templatequery = null;
	    	try{
	    		StringBuffer orgoutstr = new StringBuffer("var orgdata = [");
		    	//查询机构数据
	    		String orgsql = "select org_name, t.org_id, t.parent_id, decode(sign((select max(level) from td_sm_organization t  connect by prior t.org_id = t.parent_id   start with t.parent_id = 0) - level),  0,  'false',  'true') hasson  from td_sm_organization t connect by prior t.org_id = t.parent_id start with t.parent_id = 0 order by level asc";
		   		conn = DBUtil.getConection(EgpManager.getAppDBName());
		   		orgquery = conn.createStatement();
		   		ResultSet rs = orgquery.executeQuery(orgsql);	   		
		   		while(rs.next()){
		   			orgoutstr.append("{orgname:'"+rs.getString("org_name")+"',orgid:'"+rs.getString("org_id")+"',parent_id:'"+rs.getString("parent_id")+"',hasson:"+rs.getString("hasson")+"},");
		   		}
		   		out.println(orgoutstr.toString().replaceAll(",$","")+"];");	   		
		   		//查询模板数据
		   		templatequery = conn.createStatement();
		   		String templatesql = "select t.recordid,t.filename,t.filetype,t.org_id from td_octl_template_file t";
		   		StringBuffer templateoutstr = new StringBuffer("var templatedata = [");
		   		rs = templatequery.executeQuery(templatesql);
		   		while(rs.next()){
		   			templateoutstr.append("{recordid:'"+rs.getString("recordid")+"',filename:'"+rs.getString("filename")+"',filetype:'"+rs.getString("filetype")+"',org_id:'"+rs.getString("org_id")+"'},");
		   		}
		   		out.println(templateoutstr.toString().replaceAll(",$","")+"];");	   		
	    	}catch(Exception e){
	    		e.printStackTrace();
	    		out.println("var orgdata = [];");
	    		out.println("var templatedata = [];");
	    	}finally{
	    		if(orgquery!=null){
	    			orgquery.close();
	    		}
	    		if(templatequery!=null){
	    			templatequery.close();
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
				    	tmpobj.leaf = false;
						tmpobj.children = buildTreeNodeJson(orgdata[i]);
			    		jsondata.push(tmpobj);			    		
			    	}
		    	}
		    	for(var n=0;n<templatedata.length;++n){
	    			if(templatedata[n].org_id==obj.orgid){
	    				jsondata.push({id:templatedata[n].recordid,text:templatedata[n].filename,leaf:true});
	    			}
			    }
		    	return jsondata;
		    }
		    treedata.children = buildTreeNodeJson({orgid:'0'});
		    
	    }();
	    
	    Ext.onReady(function(){
		    Ext.BLANK_IMAGE_URL = '../../eformsys/fceform/js/Ext/images/default/s.gif';
		    
		    var tree = new Ext.tree.TreePanel({
		        //el: 'ExtTree1',
		        //title: '机构文档树',
		        frame: false,
		        autoScroll: 'true',
		        loader: new Ext.tree.TreeLoader({
		        	dataUrl:'',
		            baseAttrs: {
		                uiProvider: Ext.ux.TreeCheckNodeUI
		            }
		        }),
		        checkModel: 'cascade',
		        //onlyLeafCheckable: true,
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
		        })]
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
		   	
		   	var p = new Ext.Panel({
		        title: '文档导出',
		        collapsible:false,
		        renderTo: 'panel',
		        
		        items:[
		        	tree
		        ],
		        bbar:[
		        	'->',
		        	{
		        		text:'导出选中文件',
		        		handler:function(){
		        			var nodes = tree.getChecked();
		        			var flag = false;
		        			for(var i=0,len=nodes.length;i<len;++i){
		        				if(nodes[i].attributes.leaf){
		        					flag = true;
		        					break;
		        				}
		        			}
		        			if(!flag){
		        				Ext.Msg.alert('提示', '请选择至少一条模板记录!');
		        				return;
		        			}
		        			var records = "";
		        			for(var i=0;i<nodes.length;++i){
		        				if(nodes[i].isLeaf()){
		        					records += nodes[i].id+","
		        				}
		        			}
		        			records = records.replace(/,$/,'');
		        			actionframe.location.href=path+'/servlet/CreatorPTServlet?records='+records+'&key=exportDocTmp';
		        		}
		        	}
		        ]
		        
		    });
		    root.expand();
		});
    
    </script>
    <DIV id=panel style="margin:2%;"></DIV>
    <iframe name="actionframe" border="0" width="0" height="0" src=""></iframe>
	</body>
</html>
