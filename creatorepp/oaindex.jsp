<%--
系统首页
1:支持URL登录系统
2:支持进入系统后直接打开某页面
参数:
1.1:userName[可选]:用户名
1.2:password[可选]:密码
2.1:firstPagerURL[可选]:进入系统后直接打开某页面
2.2:firstPagerName[可选]:进入系统后直接打开某页面所属标签页名称
--%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.workbench.cache.WorkbenchConfCache" %>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="java.net.URLDecoder"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	String userName = StringUtil.deNull(request.getParameter("userName"));
	//1:url登录
	if(userName.length()==0){
		accesscontroler.checkAccess(request, response);
	}else{//url登录系统
		String password = StringUtil.deNull(request.getParameter("password"));
		accesscontroler.login(request,response,userName,password);
	}
	//2:是否是超级管理
	boolean isAdmin = accesscontroler.isAdmin();
	//3:直接打开某页面
	boolean showOnePage = false;
	String firstPagerURL = StringUtil.deNull(request.getParameter("firstPagerURL"));
	String firstPagerName = "welcome";
	if(firstPagerURL.length()>0){
		firstPagerURL = Escape.unescape(Escape.unescape(request.getParameter("firstPagerURL").replaceAll("@@","&")));
		firstPagerName = request.getParameter("firstPagerName");
		firstPagerName=URLDecoder.decode(firstPagerName, "utf-8");
		showOnePage = true;
	}
	//特检员OA 2014-05-23 start  需要按菜单权限展示常驻的【档案管理】TAB页
	//档案管理员角色
	boolean isFlieROLE = FileUtil.isRolesUser(accesscontroler.getUserID(), FileConstant.FILE_ROLE_NAME);
	//特检员OA 2014-05-23 end 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=WorkbenchConfCache.getSystemBean().getSys_name() %></title>
<script type="text/javascript">
var indexFlager = true;
</script>
<script type="text/javascript" src="ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="ccapp/oa/resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"></script>
<script type="text/javascript" src="ccapp/oa/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="ccapp/oa/resources/util/public.js" ></script>
<script type="text/javascript" src="ccapp/oa/resources/plug/ifrom/js/ifrom-ui-newcommonuse.js"></script>
<!-- 特检院 OA追加 项目中 ifrom-ui-newcommonuse.js start -->
<script type="text/javascript" src="ccapp/xtbg/resources/plug/ifrom/js/ifrom-ui-newcommonuse.js"></script>
<!-- 特检院 OA追加 项目中 ifrom-ui-newcommonuse.js end -->
<script type="text/javascript" src="ccapp/oa/resources/plug/ifrom/js/ifrom-ui-layout.1.1.js"></script>
<script type="text/javascript" src="ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>
<script type="text/javascript">
var windowTopUtil = //系统顶级页面的公用工具类
{
	getSystemParam:function(_key){//根据key获取系统配置属性
		var value = "";
		$.ajaxSetup({async : false});
		$.post("getsystemparam.jsp",{key:_key},function(obj){
			  value = obj.value;
		},"json");
		
		return value;
	}
} 

$(function(){
	var fristMenu = "eppmanager,sysmanager,meetingmanager,gwgl,workflowHadder,vote,tzgg,task,sysparam,"
		+"dict,scheduleManage,guest,paper,directory,inspectManager,emails,suxian_elect,ymj_clgl,ymj_zcgl,pzgl,officeSupplies,news,detectionSupplies,canteenitemsSupplies,review,vote,personholder,device,czt_tsgl,answers"
		+",processing,stdlib";
	style = getSystemStyle("blue");
	var layouts =new  $.IfromLayout();
	   layouts.layoutID = "mian";
	   layouts.leftUrl='ccapp/oa/common/main/left_.jsp?subSysFristMenu=' + fristMenu + "&subSysName=fristPage";
	   layouts.headerUrl='ccapp/oa/common/main/header.jsp';
	   layouts.showList=[{
			   menuId:'_firstPagerAAAS',
			   menuName:'个人办公',
			   oper:true,
			   url:'ccapp/oa/common/main/workbench.jsp',
			   lefturl:'ccapp/oa/common/main/left_.jsp?subSysFristMenu=' + fristMenu + '&subSysName=fristPage'
		   },
		   {
			   menuId:'_firstPagerKBMAAAS',
			   menuName:'体系文件',
			   url:'ccapp/oa/kbm/jsp/kbmfrist.jsp',
			   lefturl:'ccapp/oa/common/main/left_.jsp?subSysFristMenu=kbm,persondata,data' + '&subSysName=kbmPage'
			},
			<%if(isFlieROLE==true){%>
           {
               menuId:'_firstPagerFileFirstAAAS',
               menuName:'档案管理',
               url:'ccapp/oa/file/jsp/filefirstpage.jsp',
               lefturl:'ccapp/oa/common/main/left_.jsp?subSysFristMenu=filefilesmanage_m,filedocManage,'
                   +'filequeryManage,filecollectManage,fileBorrowManage,fileDestroyManage,beforearchivelistManage,file'
                    + '&subSysName=fileFirstPage'
            }
            <%}%>
            <%--
            {
                menuId:'_firstPagerOpenfireFirstAAAS',
                menuName:'即时通讯',
                url:'ccapp/xtbg/public/main/jsp/openfire.jsp',
                lefturl:'ccapp/oa/common/main/left_.jsp?subSysFristMenu=' + fristMenu + '&subSysName=fristPage',
                isReload:true,
                oper:true
             },
             {
                 menuId:'_firstPagerXtjInfoFirstAAAS',
                 menuName:'湖南特检',
                 url:'ccapp/xtbg/public/main/jsp/infoOuterNet.jsp',
                 lefturl:'ccapp/oa/common/main/left_.jsp?subSysFristMenu=' + fristMenu + '&subSysName=fristPage'
              }--%>
		   ];
	   <%
	   		if(isAdmin) {
	   %>
	   			layouts.showList=[{menuId:'_firstPagerAAAS',menuName:'个人办公',oper:true,url:'ccapp/oa/common/main/workbench.jsp',lefturl:'ccapp/oa/common/main/left_.jsp?subSysFristMenu=' + fristMenu}];
	   <%
	   		}
	   %>
	   
	   <%if(showOnePage){%>
				layouts.showList.push({menuId:'_zeroPagerAAAS',menuName:'<%=firstPagerName%>',isClose:true,isReload:true,oper:true,url:'<%=firstPagerURL%>'});
	   <%}%>
	   layouts.layout();
	   var p = ["/ccapp/oa/resources/style/"+style+"/css/style.css",
	            "/ccapp/oa/resources/plug/JQuery zTree v3.0/"+style+"/css/zTreeStyle/zTreeStyle.css",
	            "/ccapp/oa/resources/plug/JQuery zTree v3.0/"+style+"/css/demoout.css",
	            "/ccapp/oa/resources/plug/ifrom/"+style+"/css/ifrom-ui-core.css"
	            ];
	   loadCss(p);
	   $("body").hover(function(){
		   try{
			   var win = getIFrameWindow('_document_body_mian_firstPagerAAAS');
				if(null != win){
					win.opetDate = new Date();
				}
		   }catch(error){}
		   
	   })
});

	//屏蔽鼠标右键、Ctrl+N、Shift+F10、F11、F5刷新、退格键  
	document.oncontextmenu = function() {
		 event.keyCode=0;
		event.returnValue = false;
	}//屏蔽鼠标右键  
	window.onhelp = function() {
		return false
	} //屏蔽F1帮助  
	document.onkeydown = function() {

		if ((event.keyCode == 116) || //屏蔽 F5 刷新键  
		(event.ctrlKey && event.keyCode == 82)) { //Ctrl + R  
			event.keyCode = 0;
			event.returnValue = false;
		}
		if (event.keyCode == 122) {
			event.keyCode = 0;
			event.returnValue = false;
		} //屏蔽F11  
		if (event.ctrlKey && event.keyCode == 78)
			event.returnValue = false; //屏蔽 Ctrl+n
		if (event.shiftKey && event.keyCode == 121)
			event.returnValue = false; //屏蔽 shift+F10  
		if (window.event.srcElement.tagName == "A" && window.event.shiftKey)
			window.event.returnValue = false; //屏蔽 shift 加鼠标左键新开一网页  
		if ((window.event.altKey) && (window.event.keyCode == 115)) //屏蔽Alt+F4  
		{
			window.showModelessDialog("about:blank", "",
					"dialogWidth:1px;dialogheight:1px");
			return false;
		}
	}
	 document.oncontextmenu=function(e){return   false;}   
	 

</script>
</head>
<body id="_superbodys"  style="overflow:hidden;">
	<div id="mian" class="_mian"></div>
</body>
</html>