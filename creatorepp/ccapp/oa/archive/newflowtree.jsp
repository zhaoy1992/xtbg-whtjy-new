<%--
	描述：新建流程树
	作者：shuqi.liu
	版本：1.0
	日期：2013-7-23
--%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
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
	String userid = accessControl.getUserID();
	String busitype_type_code=StringUtil.deNull(request.getParameter("busitype_type_code"));
	String type =OASystemCache.getContextProperty("createWorkListType");
	String orgid="";
	//判断是否要通过单位过滤
	String flag=OASystemCache.getContextProperty("unit_filter");
	if("true".equals(flag)){//要过滤
		UserCacheBean userbean=UserCache.getUserCacheBean(accessControl.getUserID());
		if(userbean!=null){
			orgid=userbean.getUnit_ids();
		}
	}
%>
	<TITLE>新建流程主页面</TITLE>	
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="css.css" type="text/css" />
	<!--引入jQuery_zTree  -->
	<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
	<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
	<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>
	<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	
	<!-- 引入其它 -->
	<script src="../resources/util/public.js" type="text/javascript"></script>
	<script src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" type="text/javascript"></script>
	<SCRIPT type="text/javascript">
	
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			searchTree();
		}
	});

	var treetypestr = 'dd';
	var setting = {
		async: {
	    	enable: true,//启用异步加载
	    	url: window.top.getContextPath() + '/commonTreeServlet?classNameId=com.chinacreator.xtbg.core.process.processconfig.dao.impl.FlowInfoTree', 
			autoParam:["busitype_type_code", "name=busitype_type_code", "level=lv"],
			otherParam:{"toporgId":"0","orgid":"<%=orgid%>","busitype_type_code":"<%=busitype_type_code%>"}
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
				var nodesd =zTree.getNodesByParamFuzzy("org_id","<%=busitype_type_code%>",null);
				if(nodesd&&nodesd.length>0){
						zTree.selectNode(nodesd[0]);
						onclick(event,"treeDemo",nodesd[0]);
						return;
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
				var type='<%=type%>';
				jQuery("#busitype_type_code").val(treeNode.id);
				if("image"==type){
					var url="newflowlist.jsp?busitype_type_code="+treeNode.id;
				}else{
					var url="newflowlist1.jsp?busitype_type_code="+treeNode.id;
				}
			   	parent.getTempValue(url);
			}
		}
		
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting);
			
		});
	
		
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

<body onload="adaptationWH('','treeDemo',60)">
<form id="form12345" name="form12345" method="post" onsubmit="javascript:if(!this.target){return false;};">
<input type="hidden" id="busitype_type_code" name="busitype_type_code" ></input>
<input type="hidden" id="action" name="action" value="deleteType"></input>
	<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="gongwen">		
		<tr>
	    <td height="30" class="gwlink">选择公文类型</td>
	  	</tr>
		<tr>
		  	<td>
		  	<table border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;">
		      <tr>	
      			<td width="169" align="center">
      			 <input align="left" class="input_cx_title_120" id="key"></input>
      			</td>
      			<td width="169" align="center">
		  		 <input type="button" onclick="searchTree()" value="搜索" class="but_y_01"></input>
      			</td>
		      </tr>
		    </table>
		  	
		  	</td>
	  	</tr>
	</table>
	<div>
	<ul id="treeDemo" class="ztree" style="width:220px;height: 550px; overflow:scroll;overflow-x:hidden;" scrolling="yes"></ul>
	</div>
</form>
</body>
</html>