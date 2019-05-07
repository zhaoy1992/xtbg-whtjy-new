<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
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
	String userOrgId = accesscontroler.getChargeOrgId();
	String userOrgName = accesscontroler.getChargeOrgName(); //科室
	String top_img = "top_img_kechuang";
	UserCacheBean userCacheBean = UserCache.getUserCacheBean(userid);
	String maleorfemale = "top_but01";
	if(userCacheBean != null) {
		if("F".equals(userCacheBean.getUser_sex())) {
			maleorfemale  = "top_but02";
		}
	}
	//特检院OA 修改手机端下载地址  start
	String phoneAddress = CacheCommonManageProxy.getSystemParam("phoneAddress");
	//特检院OA 修改手机端下载地址  end
	
	String system1 = CacheCommonManageProxy.getSystemParam("system1");
	String system2 = CacheCommonManageProxy.getSystemParam("system2");
	String system3 = CacheCommonManageProxy.getSystemParam("system3");
	
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript">
   var alert_content_show = false;
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
	$("#changeskin_div").hover(function(){
		var mouseleft=0;
		var mousetop=0;
		if (!document.all) {
			mouseleft = e.pageX;
			mousetop = e.pageY;
		} else {
			mouseleft = document.body.scrollLeft + event.clientX;
			mousetop = document.body.scrollTop + event.clientY;
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
		var url = '<%=path %>/ccapp/oa/common/main/editpassword.jsp?loginName=<%=loginName%>';
		openAlertWindows('',url,'修改用户密码',600,205,'25%','25%');
	}
	//查看个人资料 
	var selectInfo = function(id) {
		$("#alert_content").hide();
		alert_content_show = false;
		var title="查看个人资料";
		var url = '<%=path %>/ccapp/oa/common/main/selectuserinfo.jsp?typeid=<%=userid%>';
		openAlertWindows('',url,title,600,245,'25%','25%');
	}
	//修改个人资料 
	var updateInfo = function(id) {
		$("#alert_content").hide();
		alert_content_show = false;
		var title="修改个人资料";
		var url = '<%=path %>/ccapp/oa/common/main/edituserinfo.jsp?typeid=<%=userid%>';
		openAlertWindows('',url,title,795,380,'10%','30%');
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
    //打开消息盒子
	$(function(){
		
		
		<%--
		  特检院OA 去掉消息中心 start 2014-05-20 start
		 //执行一次
		refresh();
         
         //定时任务，每半分钟刷新一次统计
         var timeOut = setInterval("refresh()",18000);
         		
         $("#messageBox").click(function(){
        	 openWindows('message_messagelist','消息中心'
        	            ,'<%=path%>/ccapp/oa/msgcenter/jsp/messagelist.jsp?windowId=message_messagelist'
        	            ,false,false,false,true,true);
         }); 
                      特检院OA 去掉消息中心 start 2014-05-20 end
          --%>
     });
    
    //特检院 OA  手机端下载  2014-03-21 start
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
		if(mousetop>405 || (mouseleft<232||mouseleft>527)||mousetop<35){
			$("#alert_PhoneContent").hide();
			alert_Phone_content_show = false;
		}
    });
   
 	//下载手机端android
   var loadAndroid = function(){
	   var url ="<%=phoneAddress%>";
	   location.href=url;
	}
   //特检院 OA  手机端下载  2014-03-21 end
   
  //弹出IE窗口	
  var openSystem = function(systemUrl,systemName){
	   var width = window.screen.width;
       var height = window.screen.height;
       var parameters = "height="+height+",width="+width+",top=0,left=0,toolbar=yes,menubar=yes,scrollbars=yes, resizable=yes,location=yes, status=yes";
       targetWin = window.open(systemUrl, systemName ,parameters);
       //外网地址打开界面需要设置opener对象为null
       if(systemName=='newwindow3'){
	   		targetWin.opener=null;
       }
   }
</script>
</head>
<body>
    <div style="position: absolute;left:510px;top:15px;color:#fff8a5;padding-top: 5px;">
    <font style="color:#fff8a5; font-size:25px;font-weight:bold;font-family:黑体">
    </font>
    </div>
	<div class="top">
		<div class="<%=top_img %>"></div>
		<div class="top_but">
			<div class="_header_button_box">
				<!--  
				<div class="changeSystem_div" id="changeSystem_div">
				     <span onclick="showChangeskin($(changeSystem_div_all),$(changeSystem_div_bottom))">其他系统</span>
					 <div style="display: none;" id="changeSystem_div_all" class="changeSystem_div_all">
					    <div class="changeskin_div_blue" onclick="openSystem('<%=system1%>','newwindow1')">门户网站</div>
					    <div class="changeskin_div_blue" onclick="openSystem('<%=system2%>','newwindow2')">检验系统(内网)</div>
					    <div class="changeskin_div_blue" onclick="openSystem('<%=system3%>','newwindow3')">检验系统(外网)</div>
					 </div>
					 <div class="changeSystem_div_bottom" id="changeSystem_div_bottom" style="display: none;"></div>
		         </div>
		        -->
				<div class="changeskin_topDown_div" id='user_phoneInfoId'>
		       		  <a onclick="clickPhoneName(this)">手机客户端下载</a>
					  <div class="container_phonets" id="alert_PhoneContent" style="display: none;">
							<div class="content_phonets">
								<div>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
											   	<span style="color: white;background-color:#002c9b;"> 安卓版二维码扫描处</span>
												<img alt="" src="<%=request.getContextPath()%>/ccapp/oa/common/resources/images/apk.jpg" style="width: 200px;height:200px;">
												手机扫描即可下载哦！！
												<input name="" type="button" value="下载到本地" class="but_y_105" onclick="loadAndroid()" 
													   onmouseover="javascript:$(this).attr('class','but_y_105_y');" 
													   onmouseout="javascript:$(this).attr('class','but_y_105');" />
											</td>
											<td>
												<span style="color: white;background-color:#084800;">苹果版二维码扫描处</span>
												<img alt="" src="<%=request.getContextPath()%>/ccapp/oa/common/resources/images/pingguo.jpg" style="width: 200px;height:200px;">
												手机扫描即可下载哦！！
											<!-- 	<input name="" type="button" value="下载到本地" class="but_y_105" onclick="loadiPhone()" 
													   onmouseover="javascript:$(this).attr('class','but_y_105_y');" 
													   onmouseout="javascript:$(this).attr('class','but_y_105');" /> -->
											</td>
										</tr>
									</table>
								</div>
							</div>
					 </div>
				 </div>
			    <!--  特检院OA 去掉消息中心 start 2014-05-20 start
			    <div id="message_div" class="header_message_div" >
			        <span id="messageBox" style="height:25px;width:80px;;line-height: 25px;padding-left:15px;">消息中心(<span id="messageCount">0</span>)</span>
			     </div> 
			                         特检院OA 去掉消息中心 start 2014-05-20 end-->
			     <div class="changeskin_div" id="changeskin_div">
				     <span onclick="showChangeskin($(changeskin_div_all),$(changeskin_div_bottom))">样式切换</span>
					 <div style="display: none;" id="changeskin_div_all" class="changeskin_div_all">
					    <div class="changeskin_div_red" onclick="changeskin('red')">中国红</div>
					    <div class="changeskin_div_blue" onclick="changeskin('blue')">经典蓝</div>
					 </div>
					 <div class="changeskin_div_bottom" id="changeskin_div_bottom" style="display: none;"></div>
		         </div>

				<div class="<%=maleorfemale %>" id='user_baseInfoId'>
					<a onclick="clickName(this)"><%=username%></a>
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
								</table>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td align="center" class="top_ts_but_td"><input name=""
											type="button" value="修改个人资料" class="but_y_105"
											onclick="updateInfo()" onmouseover="javascript:$(this).attr('class','but_y_105_y');" 
											onmouseout="javascript:$(this).attr('class','but_y_105');" /></td>
									</tr>
									<tr>
										<td align="center" class="top_ts_but_td"><input name=""
											type="button" value="修改登录密码" class="but_y_105"
											onclick="updatePassword()" onmouseover="javascript:$(this).attr('class','but_y_105_y');" 
											onmouseout="javascript:$(this).attr('class','but_y_105');" /></td>
									</tr>
								</table>
							</div>
						</div>
						<s> <i></i></s>
					</div>
				</div>
				<!-- 	<div class="top_but02">
							<a href="#">帮助</a>
				</div> -->
				<div class="top_but03">
					<a href="<%=path %>/logout.jsp" id="exit_a">退出</a>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>