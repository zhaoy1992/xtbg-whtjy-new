<%--
	描述：字典类型树
	作者：肖杰
	版本：1.0
	日期：2013-7-23
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<%
	String path = request.getContextPath();
	String ischeck = request.getParameter("ischeck");//用来判断是否是复选框,默认是radio
	String readonly = request.getParameter("readonly"); //是否只读，1：只读，0：

	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request, response);
	String orgid = accessControl.getChargeOrgId();
	String userid = accessControl.getUserID();
	String dict_id=StringUtil.deNull(request.getParameter("dict_id"));

%>
	<TITLE>字典类型树信息</TITLE>	
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	
	<!--引入jQuery_zTree  -->
	<link rel="stylesheet" href="../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
	<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
	<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
	<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	
	<!-- 引入其它 -->
	<script src="../../resources/util/public.js" type="text/javascript"></script>
	<script src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" type="text/javascript"></script>
	<SCRIPT type="text/javascript">
	
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			searchTree();
		}
	});

	var treetypestr = 'dd';
	var setting = {
		edit: {//移动节点
			drag : {
				isCopy: false,
				isMove: true,
				prev: true,
				inner: false,
				next: true
			},
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		async: {
	    	enable: true,//启用异步加载
	    	url: window.top.getContextPath() + '/commonTreeServlet?classNameId=com.chinacreator.xtbg.core.dict.dao.impl.DictTypeTree', 
			autoParam:["dict_id", "name=dict_id", "level=lv"],
			otherParam:{"toporgId":"0","orgids":""}
	    },
		data: {
			simpleData: { //简单json类型
				enable: true, 
				idKey: "org_id",
				pIdKey: "parent_id",
				rootPId: 0
			}
		},
		check: {
			enable: false,
			/*
			chkStyle = "checkbox" 时，显示 checkbox 选择框，setting.check.chkboxType 属性有效。
			chkStyle = "radio" 时，显示 radio 选择框， setting.check.radioType 属性有效。
			
			请注意大小写，不要改变
			*/
			chkStyle: treetypestr,
			chkboxType : {
				"Y": "s",
				"N": "s"
			},
			radioType: "all"
		/*
		规则说明： 
		      Y 属性定义 CheckBox 被勾选后的情况； 
		      N 属性定义 CheckBox 取消勾选后的情况； 
		      "p" 表示操作会影响父级节点； 
		      "s" 表明操作会影响子级节点。
	    */
		},
		callback: {
			onClick:onclick,
			onAsyncSuccess: function(){
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				if(""!="<%=dict_id.replace("'", "")%>"){
					var nodesd =zTree.getNodesByParamFuzzy("org_id","<%=dict_id.replace("'", "")%>",null);
					if(nodesd&&nodesd.length>0){
						for(i = 0; i < nodesd.length; i++) { 
							zTree.selectNode(nodesd[i]);
							onclick(event,"treeDemo",nodesd[i]);
							return;
				        }
					}
				}
			}
		}
	};
		
		/**
		 *设置字体
		 */
		function getFont(treeId, node) {
			return node.font ? eval('(' + node.font + ')') : {};
		}
		/**
		 *树被点击时触发的事件
		 */
		function onclick(event,treeId,treeNode){
			if("false" != treeNode.click){
				jQuery("#dict_id").val(treeNode.org_id);
				var url="dictdataviewmain.jsp?orgid="+treeNode.org_id+"&dict_type="+treeNode.dict_type+"&treeNode="+treeNode;
			   	parent.getTempValue(url);
			}
		}
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting);
			
		});
			
		/*
		 * description: 新增
		 * date: 2013-07-24
		 * param:
		 * return:  
		 */
		function adddict() {
			var url ='<%=path %>' + '/ccapp/oa/dict/jsp/dicttypeinfo.jsp?subid=windowid&dict_id='+jQuery("#dict_id").val()+'&type=add';
			openAlertWindows('windowid',url,'添加字典类型','810','350','20%');
		}

		/*
		 * description: 修改
		 * date: 2013-07-24
		 * param:
		 * return:  
		 */
		function updatedict(orgid,parentId) {
			var orgid = jQuery("#dict_id").val();
			if(IsSpace(orgid)) {
				alert("请选择类型节点");
				
				return false;
			}
			var url = '<%=path %>/ccapp/oa/dict/jsp/dicttypeinfo.jsp?subid=windowid&type=update&dict_id='+jQuery("#dict_id").val();
			openAlertWindows('windowid',url,'修改字典类型','810','350','20%');
		}

		/*
		 * description: 删除
		 * date: 2013-07-24
		 * param:
		 * return:  
		 */
		function deldict() {
			var orgid = jQuery("#dict_id").val();
			if(IsSpace(orgid)) {
				alert("请选择类型节点");
				return ;
			}

			var url = "dicttypedo.jsp";

			var okF = function(){
				$("#form12345").attr("action",url);
				$("#form12345").attr("target","hiddenFrame");
				$('#form12345').submit();
				$("#form12345").attr("target","");
			}
			var p={
					headerText:'提示',
					okName:'确认',
					okFunction:okF,
					cancelName:'取消'
			};
			alert('你确定要删除字典类型吗？ ',p)
			
			
		}
		/*
		　 * description: 根据参数查询对应的节点
		　 * date: 2013-07-24
		　 * param:
		　 * return:  
		　 */
		var count=0; 
		var oldSearchValue = "";
		function searchTree(key){
			key = $.trim($("#key").val());
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var keyType = "name";
			if(key != ""){
				if (oldSearchValue != key) {
					var nodesd =zTree.getNodesByParamFuzzy(keyType,key,null); 
				    for(i = 0; i < nodesd.length; i++) { 
						count++; 
						if(count>=nodesd.length){ 
							count=0;
						} 
						if(nodesd[i].name.indexOf(key)!=-1){ 
							zTree.selectNode(nodesd[i]);
							zTree.expandNode(nodesd[i],false,false,false); 
							oldSearchValue = key;
							onclick(event,"treeDemo",nodesd[i]);
							count=0;
							return;
					     } 
			        }
				}
		   }
		}
	</script>
</head>

<body onload="adaptationWH('top','venter',30)">
<form id="form12345" name="form12345" method="post" onsubmit="javascript:if(!this.target){return false;};">
<input type="hidden" id="dict_id" name="dict_id" ></input>
<input type="hidden" id="action" name="action" value="deleteDicttype"></input>
	<div id="top" >
	<div class="web_tree_box_y" align="left">字典类型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
	</div>
	<div>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
	  	<tr height="30px" style="font-size: 15">
	    	<td align="center" ><a onclick="adddict()">新增</a></td>
	    	<td align="center"><a onclick="updatedict()">修改</a></td>
	    	<td align="center"><a onclick="deldict()">删除</a></td>
		</tr>
	</table>
	<table  width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
		<tr>
		  	<td align="left">
		  		 <input align="left" class="input_cx_title_120" id="key"></input>
		  	</td>
		  	<td align="left">
		  		 <input type="button" onclick="searchTree()" value="搜索" class="but_y_01"></input>
		  	</td>
	  	</tr>
	</table>
	</div>
	</div>
	<div id="venter" style="border-top:1px solid #EAEAEA;" >
	<div class="" >
	</div>
	<ul id="treeDemo" class="ztree" style="width:220px;height: 350px; overflow:auto; overflow-x:hidden;" scrolling="yes"></ul>
	</div>
</form>
</body>
</html>