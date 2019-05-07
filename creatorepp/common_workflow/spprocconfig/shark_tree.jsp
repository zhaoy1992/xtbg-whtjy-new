<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.chinacreator.workflow.shark.procconfig.IProcessModuleTree"%>
<%@ page import="com.chinacreator.workflow.shark.procconfig.item.SPProcessModuleTreeImpl"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<html>
<head>

	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">

    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <title>工作流外围配制</title>
    <link rel="stylesheet" type="text/css" href="../../eformsys/fceform/js/Ext/css/ext-all.css" />
 	<script type="text/javascript" src="../../eformsys/fceform/js/Ext/ext-base.js"></script>
    <script type="text/javascript" src="../../eformsys/fceform/js/Ext/ext-all.js"></script>
    <link rel="stylesheet" type="text/css" href="examples.css" />
	

	<%
		String treeStr = "";
		String app_id = "";
		String itemtable = request.getParameter("itemtable");
		String id = request.getParameter("id"); 
		String name = request.getParameter("name");
		String parentid = request.getParameter("parentid");
		String root = request.getParameter("root");
		
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		IProcessModuleTree tree = new SPProcessModuleTreeImpl();
		treeStr  = tree.loadAll(app_id);
	%>
</head>
<body style="width:100%;height:100%;padding:0px;margin:0px;">
<DIV id=ExtTreeDiv_ExtTree1 style="LEFT:0px; POSITION: absolute; TOP: 0px;width:100%;height:100%;"></DIV>
&nbsp;
<SCRIPT type=text/javascript>
Ext.onReady(function(){
	var json  = '[<%=treeStr%>]';
	//getPropertiesContent是在panes.jsp中定义的方法
	var propertiesContentFrame = getPropertiesContent();

	var tpl = new Ext.Template('shark_content.jsp?id={id}&name={text}');
    tpl.compile();

    Ext.BLANK_IMAGE_URL = 'images/s.gif';
    var tree = new Ext.tree.TreePanel({
        el: 'ExtTreeDiv_ExtTree1',
		width:Ext.get("ExtTreeDiv_ExtTree1").getWidth(),
		height:Ext.get("ExtTreeDiv_ExtTree1").getHeight(),
		autoScroll:true,
		title: '流程事项树',
        loader: new Ext.tree.TreeLoader({}),
          listeners: {
	            'render': function(tp){
                    tp.getSelectionModel().on('selectionchange', function(tree, node){
                       var procMgrName = node.attributes.processMgrName;
                       if(procMgrName!=null && procMgrName!=""){
	                       var url = tpl.applyTemplate(node.attributes);
	                       propertiesContentFrame.location = url;
	                    }
                    })
	            }
	        },
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
    var root = new Ext.tree.AsyncTreeNode({
        text: "流程事项",
        qtip: "流程事项",
        id: "",
        children: eval(json)
    });
    tree.setRootNode(root);
    tree.render();
    root.expand();
    var filter = new Ext.tree.TreeFilter(tree, {
        clearBlank: true,
        autoClear: true
    });
    function filterTree(e){
        var text = e.target.value;
        var re = new RegExp(Ext.escapeRe(text), 'i');
        filter.filterBy(function(n){
            return !n.isLeaf() || re.test(n.text);
        });
    }
    Ext.QuickTips.init();
    if (typeof(creator_pt_trees) == 'undefined') {
        creator_pt_trees = [];
    }
    creator_pt_trees.push({
        id: 'ExtTree1',
        obj: tree
    }); 
    tree.on("click",function(node){
    	var url1 = tpl.applyTemplate(node.attributes);
    	if(node != root){
	    propertiesContentFrame.location = url1;
	    }
    });
});

</SCRIPT>

</body>
</html>
