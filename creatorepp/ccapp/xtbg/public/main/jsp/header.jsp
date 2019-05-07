<%@page import="com.chinacreator.xtbg.pub.workflow.dao.imploracle.ElectDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.dao.ElectDao"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>

<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();
	String username = accesscontroler.getUserName();//获得当前登录用户姓名
	String loginName =  accesscontroler.getUserAccount(); //登录名
	String userDeptName = accesscontroler.getChargeOrgName(); //科室
	//当前用户的机构id和机构名
		ResourceConfigDao resourceConfigDao = new ResouceConfigDaoImpl();
		ResourceRoleUserBean rruBean = new ResourceRoleUserBean();
		if (!StringUtil.nullOrBlank(userid)) {
			rruBean = resourceConfigDao.queryUserMatchOrg(userid);
		}
		String userOrgId = "";
		String userOrgName = "";
		if (!StringUtil.isBlank(rruBean.getOrgid())) {
			userOrgId = rruBean.getOrgid();
		}
		if (!StringUtil.isBlank(rruBean.getOrgname())) {
			userOrgName = rruBean.getOrgname();
		}
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
		String top_img = CacheCommonManageProxy.getSystemParam("index_top_img");
        
		//郴州即时通讯的模块
		ElectDao electDao = new ElectDaoImpl();
		String userPassword = electDao.queryUserPassword(userid);
		
		//显示个人修改界面
		String index_top_updatePersonUrl = CacheCommonManageProxy.getSystemParam("index_top_updatePerson");
		//财政厅退出时直接关闭页面不跳回到登录页。这个在财政厅的配置文件中配置的oacommon@421006.properties
		String is_logout_close_win = CacheCommonManageProxy.getSystemParam("czt_is_logout_close_win");
		if(is_logout_close_win == null || "".equals(is_logout_close_win)){
			is_logout_close_win = "";
		} 
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/message.js"></script>
<script type="text/javascript">
    	/**
     *刷新消息盒子的数据
     */
     var refreshmessage = function(){
         jQuery.ajax({
             type: "post", 
             url: '<%=path%>/ajaxServlet?className='
                 +'com.chinacreator.xtbg.core.common.msgcenter.action.MessageAction'
                 +'&method=countUnReadMessage',  
             contentType: "application/x-www-form-urlencoded; charset=utf-8",
             data : {                      
                 userId : "<%=userid%>"
             },
             dataType: "json", 
             success: function (data) {
                 if(data&&data.flag){
                     if(data.count){
                         jQuery("#messageCount").css("color","red").text(data.count);
                         jQuery("#message_div").attr("class","header_message_div_hasnew");
                     }else{
                         jQuery("#messageCount").css("color","").text(data.count);
                         jQuery("#message_div").attr("class","header_message_div");
                     }
                 }
             }, 
             error: function (XMLHttpRequest, textStatus, errorThrown){
             //忽略异常
             }
          });
     }
   var alert_content_show = false;
     $(function(){
		$("#exit_a").on("click",function(){
			if("<%=userArea%>" == "421006" && "true" == "<%=is_logout_close_win%>"){
				window.opener=null;
			    window.open('','_self');
			    window.close();
			} else {
				$(this).attr("href","../../../../../login.jsp?isoutsys=true");
			}
		});
		
		<%if(CacheCommonManageProxy.getBooleanSystemParam("header_message")) {%>
				//执行一次
		refreshmessage();
	         //定时任务，每半分钟刷新一次统计
         var timeOut = setInterval("refreshmessage()","<%=CacheCommonManageProxy.getBooleanSystemParam("header_message_time")%>");
         $("#messageBox").click(function(){
        	 openWindows('message_messagelist','消息中心'
        	            ,'<%=path%>/ccapp/oa/msgcenter/jsp/messagelist.jsp?windowId=message_messagelist'
        	            ,false,false,false,true,true);
	      }); 
		<%}%>
   })
	var clickName = function(e) {
		if(!alert_content_show){
			$("#alert_content").show();
			alert_content_show = true;
		}
		else{
			$("#alert_content").hide();
			alert_content_show = false;
		}
   }
	
	$("#user_baseInfoId").hover(function(){
		var mouseleft=0;
		var mousetop=0;
		if (!document.all) {
			mouseleft = e.pageX;
			mousetop = e.pageY;
		} else {
			mouseleft = document.body.scrollLeft
					+ event.clientX;
			mousetop = document.body.scrollTop
					+ event.clientY;
		}
		var windowsWidth = $(window).width();
		var mouseleft = windowsWidth-mouseleft;
		if(mousetop>163 || (mouseleft<117||mouseleft>210)||mousetop<10){
			$("#alert_content").hide();
			alert_content_show = false;
		}
    });
	
	//手机客户端下载 按钮
	var alert_Phone_content_show = false;
	var clickPhoneName = function(e) {
		if(!alert_content_show){
			$("#alert_PhoneContent").show();
			alert_Phone_content_show = true;
		}
		else{
			$("#alert_PhoneContent").hide();
			alert_Phone_content_show = false;
		}
   }
	
   //手机客户端下载 
   $("#user_phoneInfoId").hover(function(){
		var mouseleft=0;
		var mousetop=0;
		if (!document.all) {
			mouseleft = e.pageX;
			mousetop = e.pageY;
		} else {
			mouseleft = document.body.scrollLeft
					+ event.clientX;
			mousetop = document.body.scrollTop
					+ event.clientY;
		}
		var windowsWidth = $(window).width();
		var mouseleft = windowsWidth-mouseleft;
		if(mousetop>80 || (mouseleft<318||mouseleft>200)||mousetop<10){
			$("#alert_PhoneContent").hide();
			alert_Phone_content_show = false;
		}
    });
	
   //下载手机端android
   var loadAndroid = function(){
	   var url ="http://172.18.103.131:800/creatorapp/version/MobileOA1.1.apk";
	   location.href=url;
	}
   
   
	$("#changeskin_div").hover(function(){
		var mouseleft=0;
		var mousetop=0;
		if (!document.all) {
			mouseleft = e.pageX;
			mousetop = e.pageY;
		} else {
			mouseleft = document.body.scrollLeft
					+ event.clientX;
			mousetop = document.body.scrollTop
					+ event.clientY;
		}
		var windowsWidth = $(window).width();
		var mouseleft = windowsWidth-mouseleft;
		if(mousetop>92 || (mouseleft < 218 || mouseleft >300) || mousetop<10){
			$("#changeskin_div_bottom").hide();
			$("#changeskin_div_all").hide();
		}
    });
	
	//修改密码 
	var updatePassword = function(id) {
		$("#alert_content").hide();
		alert_content_show = false;
		var url = '../../../../../editpassword.jsp?loginName=<%=loginName%>';
		openAlertWindows('',url,'修改用户密码',600,200,'25%','25%');
	}
	//查看个人资料 
	var selectInfo = function(id) {
		$("#alert_content").hide();
		alert_content_show = false;
		<%if("410001".equals(StringUtil.deNull(userArea))){ %>
		var title=" 修改个人资料";
		<%}else{%>
		var title="查看个人资料";
		<%}%>
		var url = "";
		
		<%if("431003".equals(userArea)){%>
			title="查看并修改个人资料";
			url='../../../../../edituserinfo.jsp?typeid=<%=userid%>';
			this.alertHeight = 500;
		<%}else{%>
			url='<%=index_top_updatePersonUrl%>?userid=<%=userid%>';
			this.alertHeight = 225;
		<%}%>
			openAlertWindows('',url,title,795,this.alertHeight,'10%','30%');
		
	}
	
	//软件下载
	var showDownload = function(){
		var url = '../../../yimingju/main/ymj_filedownload.jsp';
		openAlertWindows('',url,'软件下载 ',595,445,'20%','30%');
	}
	
	//下载中心
	var showDownloadCenter = function(){
		var url = '../../../yimingju/main/ymj_filedownload.jsp';
		openAlertWindows('',url,'下载中心 ',595,445,'20%','30%');
	}
	//论坛单点登录
	var dddl = function(){
		var userName = '<%= loginName%>';
		var url = "ssoinfo.jsp"
		var	params = {userName:""+userName+""};
		$.ajax({
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				if("null" == data.url){
					alert("根据用户名，获取论坛映射配置信息出错。")
				}else{
					window.open(data.url);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("根据用户名，获取论坛映射配置信息出错。")
			}
		});
	}
	/**
     *刷新消息盒子的数据
     */
     var refresh = function(){
         jQuery.ajax({
             type: "post", 
             url: '<%=path%>/ajaxServlet?className='
                 +'com.chinacreator.xtbg.core.common.msgcenter.action.MessageAction'
                 +'&method=countUnReadMessage',  
             contentType: "application/x-www-form-urlencoded; charset=utf-8",
             data : {                      
                 userId : "<%=userid%>"
             },
             dataType: "json", 
             success: function (data) {
                 if(data&&data.flag){
                     if(data.count){
                         jQuery("#messageCount").text(data.count);
                         queryMessage();
                         //jQuery("#message_div").attr("class","header_message_div_hasnew");
                     }else{
                         jQuery("#messageCount").text(data.count);
                         //jQuery("#message_div").attr("class","header_message_div");
                     }
                 }
             }, 
             error: function (XMLHttpRequest, textStatus, errorThrown){
             //忽略异常
             }
          });
     }
 	function queryMessage(){
        jQuery.ajax({
            type: "post", 
            url: "getAjaxMessage.jsp",  
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data : {                      
                userId : "<%=userid%>"
            },
            dataType: "text", 
            success: function (data) {
            	showMessage(data);
            	document.getElementById("sound").play(); 
      /*           if(data&&data.flag){
                    if(data.count){
                        jQuery("#messageCount").text(data.count);
                        //jQuery("#message_div").attr("class","header_message_div_hasnew");
                    }else{
                        jQuery("#messageCount").text(data.count);
                        //jQuery("#message_div").attr("class","header_message_div");
                    }
                } */
            }, 
            error: function (XMLHttpRequest, textStatus, errorThrown){
            //忽略异常
            }
         });
	} 
	<%if(CacheCommonManageProxy.getBooleanSystemParam("header_xxzx")) {%>
    //打开消息盒子
	$(function(){
		//执行一次
		refresh();
         //定时任务，每半分钟刷新一次统计
         var timeOut = setInterval("refresh()",18000);
         		
         $("#messageBox").click(function(){
        	 openWindows('message_messagelist','消息中心'
        	            ,'<%=path%>/ccapp/oa/msgcenter/jsp/messagelist.jsp?windowId=message_messagelist'
        	            ,false,false,false,true,true);
         }); 
     });
    <%}%>
    
    
    
</script>
</head>
<body>
	<%if(CacheCommonManageProxy.getBooleanSystemParam("messound")) {%>
		 	<embed id="sound" src="../resources/sound/mes.wma"  autostart="false" hidden="true" loop="false">
	<%}%>
    <div style="position: absolute;left:510px;top:15px;color:#fff8a5;padding-top: 5px;">
    <font style="color:#fff8a5; font-size:25px;font-weight:bold;font-family:黑体">
    </font>
    </div>
    <div class="topMenu"></div>
	<div class="top">
		<div class="<%=top_img %>"></div>
		<div id="gray_redborder_on" class="gray_redborder_on"></div>
		<div class="top_but">
			<div class="_header_button_box" >
			 <%if(CacheCommonManageProxy.getBooleanSystemParam("header_xxzx")) {%>
				 <div id="message_div" class="top_but05">
			        <span id="messageBox" style="margin-left: 20px">消息中心(<span id="messageCount">0</span>)</span>
			     </div>
			 <%} %>   
			 <%if(CacheCommonManageProxy.getBooleanSystemParam("header_message")) {%>
			 	 <div id="message_div" class="header_message_div" >
			        <span id="messageBox" style="height:25px;width:80px;;line-height: 25px;padding-left:15px;">消息中心(<span id="messageCount">0</span>)</span>
			     </div>
			 <%} %> 
			  <% if("421000".equals(StringUtil.deNull(userArea))){ %>
		         <div class="downloadSkin" id="downloadSkin">
				     <span onclick="showDownload()">软件下载</span>
		         </div>
		      <%} else if("431000".equals(StringUtil.deNull(userArea)) || "421005".equals(StringUtil.deNull(userArea)) || "421007".equals(StringUtil.deNull(userArea)) || "410004".equals(StringUtil.deNull(userArea)) ){ %>
		         <div class="downloadSkin" id="downloadSkin">
				     <span onclick="showDownloadCenter()">下载中心</span>
		         </div>
		      <%}%>
			  <%if(CacheCommonManageProxy.getBooleanSystemParam("index_top_luntan")) {%>
			 	 <div class="changeskin_div" id="changeskin_div">
				     <a onclick="dddl()">论坛</a>
		         </div>
		          <%} %>
		      <%if(CacheCommonManageProxy.getBooleanSystemParam("index_top_addBtnDown")) {%>
		       		 <div class="changeskin_topDown_div" id='user_phoneInfoId'>
		       		  <a onclick="clickPhoneName(this)">手机客户端下载</a>
						<div class="container_phonets" id="alert_PhoneContent" style="display: none;">
							<div class="content_phonets">
								<div>
									<img alt="" src="<%=request.getContextPath()%>/Document/images/apk.jpg">
									手机扫描即可下载哦！！
									<input name="" type="button" value="下载到本地" class="but_y_105" onclick="loadAndroid()" 
										   onmouseover="javascript:$(this).attr('class','but_y_105_y');" 
										   onmouseout="javascript:$(this).attr('class','but_y_105');" />
								</div>
							</div>
						</div>
					 </div>
		       		 
		       		  <div class="changeskin_topDown_div" id="changeskin_topDown_div">
				    	 <a href="<%=request.getContextPath()%>/epp/eppTemplate/help/help.zip">帮助文档下载</a>
		       		 </div>
		      <%} %>
		      <%if(CacheCommonManageProxy.getBooleanSystemParam("webdoor_page_back")) {%>
		        <div class="top_but04">
					<a href="../../../../../ccapp/xtbg/fagaiwei/homePage/main.jsp?subsystem_id=module" id="webdoor_back" title="返回门户">返回门户</a>
				</div>
				<%} %>
		          <%if(CacheCommonManageProxy.getBooleanSystemParam("index_top_css")) {%>
			     <div class="changeskin_div" id="changeskin_div">
				     <span onclick="showChangeskin($(changeskin_div_all),$(changeskin_div_bottom))" title="样式切换">样式切换</span>
					 <div style="display: none;" id="changeskin_div_all" class="changeskin_div_all">
					    <div class="changeskin_div_red" onclick="changeskin('/')">中国红</div>
					    <div class="changeskin_div_blue" onclick="changeskin('blue')">经典蓝</div>
					    <%if(CacheCommonManageProxy.getBooleanSystemParam("index_top_css_gray")) {//如果有灰色样式%>
					    	<div class="changeskin_div_gray" onclick="changeskin('gray')">传统灰</div>
					    <%} %>
					    
					 </div>
					 <div class=" changeskin_div_bottom
					 <%if(CacheCommonManageProxy.getBooleanSystemParam("index_top_css_gray")) {//如果有灰色样式%>
					 	changeskin_div_bottom_hadgray
					 <%} %>
					 " id="changeskin_div_bottom" style="display: none;"></div>
		         </div>
		          <%} %>
				<div class="top_but01" id='user_baseInfoId'>
					<a onclick="clickName(this)" title="您的信息">
					<%if("410001".equals(StringUtil.deNull(userArea))){ %>
					修改个人信息
					<%}else{ %>
					<%=username%>
					<%} %>
					</a>
					<div class="container_ts" id="alert_content" style="display: none;">
						<div class="content_ts">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="top_ts_textleft">姓名：</td>
										<td class="top_ts_textname"><%=username%></td>
									</tr>
									<tr>
										<td class="top_ts_textleft">单位：</td>
										<td class="top_ts_textname"><%=userOrgName%></td>
									</tr>
									<!-- <tr>
						<td class="top_ts_textleft">权限：</td>
						<td>超级管理员</td>
					</tr> -->
								</table>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
									<%if("410001".equals(StringUtil.deNull(userArea))){ %>
										<td align="center" class="top_ts_but_td"><input name=""
											type="button" value="修改个人资料" class="but_y_105"
											onclick="selectInfo()" onmouseover="javascript:$(this).attr('class','but_y_105_y');" 
											onmouseout="javascript:$(this).attr('class','but_y_105');" />
										</td>
									<%}else{ %>
										<td align="center" class="top_ts_but_td"><input name=""
											type="button" value="查看个人资料" class="but_y_105"
											onclick="selectInfo()" onmouseover="javascript:$(this).attr('class','but_y_105_y');" 
											onmouseout="javascript:$(this).attr('class','but_y_105');" />
										</td>
									<%} %>
									</tr>
									<%if(!"421001".equals(CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE"))){%>
									<tr>
										<td align="center" class="top_ts_but_td"><input name=""
											type="button" value="修改登录密码" class="but_y_105"
											onclick="updatePassword()" onmouseover="javascript:$(this).attr('class','but_y_105_y');" 
											onmouseout="javascript:$(this).attr('class','but_y_105');" /></td>
									</tr>
									<%} %>
								</table>
							</div>
						</div>
						<s> <i></i></s>
					</div>
				</div>
				<!-- 	<div class="top_but02">
							<a href="#">帮助</a>
				</div> -->
				<!--隐藏即时通讯界面-->
				<%if("421004".equals(CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE"))
				||"410004".equals(CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE"))){%>
				<iframe src="../../../../xtbg/public/main/jsp/openfire.jsp" width="0" height="0" ></iframe>
				<%} %>
				<div class="top_but03">
					<a href="###" id="exit_a" title="退出">退出</a>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>