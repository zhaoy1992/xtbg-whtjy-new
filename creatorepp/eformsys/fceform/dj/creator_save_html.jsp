<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<%
     AccessControl control = AccessControl.getInstance();
     control.checkAccess(request,response);
     String currentSystemID = control.getCurrentSystemID();
     String appUserName = "app_"+currentSystemID;
     appUserName=appUserName.toUpperCase();
     //System.out.println("appUserName:"+appUserName);
    %>
	<HEAD>
		<STYLE>
.userData {
	behavior: url(#default#userData);
}

@import url(../css/dj.css);
</STYLE>
		<script src="../js/fcpub.js"></script>
		<script src="../js/fcrundj.js"></script>
		<script src="../js/tabpane.js"></script>
		<script src="../js/cclog.js"></script>
		<script langage="javascript">
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			mylink.setAttribute("href","../../fceform/css/"+fcpubdata.creatorStyle+"/allStyle.css");
			var myhead = document.getElementsByTagName("head")[0];
			myhead.appendChild(mylink);
		</script>
	</HEAD><%@ include file="/epp/css/cssControl.jsp"%>
	<body background="../images/ef_run_background.gif"
		onload="pub_window_onload()" onkeydown="RunTabindex()"
		onbeforeunload="pub_window_onbeforeunload()"
		onkeypress="pub_window_onkeypress()" onresize="pub_window_onresize()">
		
		
		<script>
	var pubdjbh=parent.sOpenDjNo;
	var pubEdit=false;   			
	var pubDataSet=null;
	var pubRequest=parent.oRequest;
	var pubEformEnterStatus="OK"; 
	pub_djhtm();
  	var appUserName = "<%=appUserName%>";
	var dbName = "<%=com.chinacreator.epp.util.EgpManager.getEgpDBName()%>";

	function initdbNameselect(){
		var dbnames = SendHttp(location.protocol+"//"+location.host+ fcpubdata.servletPath + "/CreatorPTServlet"+fcpubdata.dotnetVersion+"?key=getDbNames");
		dbnames = dbnames.replace(/\|\|$/g,'');	
		var arr = dbnames.split("||");
		var dbSelectops = document.getElementById('dbNameSelect').options;
		for(var i=0,len = arr.length;i<len;++i){
			var temp = arr[i];
			dbSelectops.add(new Option(temp,temp));
		}
	}
	function uf_open(){
		dbName = document.getElementById('dbNameSelect').value;
	}


	var djsns = null;
	var total = 0;
	var ErrArr = new Array();
	var djsnArr = new Array();
	
	function saveEFormDJ(){
	    if (djsns.length == 0) {
	        alert("处理完毕！");
			showError();
	        return;
	    }  
	    var djsn = djsns.shift();
	    if (djsn) {
	        var des = $("design");
	        //加载完成后执行自动保存操作
	        des.onreadystatechange = function() {
				try{
					if (this.readyState == "complete") {
						//屏蔽保存成功提示信息
						design.window.alert = function(){};
						design.topic.window.alert = function(){};

						//屏蔽离开页面提示信息
						design.topic.document.body.onbeforeunload = function(){};
						//调用menutoolbar.htm的保存按钮事件
						design.menu.Add("save");
						setProgressValue(total-djsns.length, total);
						setTimeout(saveEFormDJ, 0);
					}
				}catch(e){
						djsnArr.push(djsn.djid);
						ErrArr.push(e.message);
						setTimeout(saveEFormDJ, 0);
				}
	        },
				//eformsys/fceform/design/design.jsp?tbtype=1&cssfolder=creatorBlue&djsn=20100423083418328416&eform_class=20090428133550218938&moduleId=
		        //加载需要保存的页面
		        des.src = location.protocol + "//" + location.host + "/" + fcpubdata.mAppName + "/eformsys/fceform/design/design.jsp?tbtype=1&cssfolder="+djsn.cssFolder+"&djsn=" + djsn.djid 
					+ "&eform_class="+djsn.eformId+"&moduleId=";

	    }   
	}
	
	function clearMessageDiv(){
		ErrArr.length =0;
		djsnArr.length =0 ; 
		$('messageDiv').innerHTML = "";
	}

	function showError(){
		var disTable = new Array();
		disTable.push("<table width='100%' border='0' cellpadding='1' cellspacing='1' class='thin'><tr><td class='detailtitle'   align=left colspan=2>以下表单保存失败</td><tr>");
		for(i=0;i<ErrArr.length;i++){
			disTable.push("<tr><td class='detailcontent' style='width:30%'>"+djsnArr[i]+"</td><td  style='width:50%' class='detailcontent'>"+ErrArr[i]+"</td><tr>");
		}
		disTable.push("</table>");
		$('messageDiv').innerHTML = disTable.join("");
	}

	function batchSave(){
		clearMessageDiv();
		var path = "<%=request.getContextPath()%>";
		resetProgress();
		showHideProgress(true);
		var tempVal = SendHttp(location.protocol + "//" + location.host+path+ "/eformsys/fceform/dj/creator_save.jsp?dbName="+dbName);
	    djsns = eval(tempVal);
	    if ((total=djsns.length) != 0) {
	        setTimeout(saveEFormDJ, 0);
	    }
	}
	function showHideProgress(bShow){
		document.getElementById("progressContainerDiv").style.display = bShow?"block":"none";
	}
	function resetProgress(){
		document.getElementById("progressValueDiv").style.width = "0%";
	}
	function setProgressValue(currentValue, totalValue){
		
		var currentProgress = parseInt((currentValue/totalValue)*100, 10);
		//alert(currentProgress);
		document.getElementById("progressDiv").innerHTML = currentProgress+"%";
		document.getElementById("progressValueDiv").style.width = currentProgress+"%";
	}

</script>
		<script src='../js/fcopendj.js'></script>
		<script defer src='../js/fcsavedj.js'></script>
		<script src='../js/fcstring.js'></script>
		<script src='../js/fcnumdate.js'></script>
		<script src='../js/fcselfuse.js'></script>
		<script src='../js/fcbasecont.js'></script>
		<script defer src='../js/fcother.js'></script>
		<script defer src='../js/selectdate.js'></script>
		<script src='../../fceformext/js/userfunc.js'></script>
		<link href=../css/tabstyle.css type=text/css rel=stylesheet>
		<link type='text/css' rel='stylesheet' href='../css/Button.css' />
		<DIV id=SKbillsheet
			jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcstring.js&#13;&#10;fcnumdate.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js"
			idtype="1" isfile="否" postop posleft window="当前窗口" keyfield
			controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0"
			posheight poswidth entertype="修改" codeheader="BBB" mkbh
			caption="批量保存表单" type="ST" dj_sn="data_fldlist"
			billtaborder="<root><taborder>FCButton1</taborder><taborder>FCButton2</taborder></root>"
			contxml="<root><label><id>Label1</id><id>Label2</id></label><button><id>FCButton1</id><id>FCButton2</id></button></root>"
			BLONopen="" toolbar="不带工具栏" OtherSave="否">

			<table width="100%" border="0" cellpadding="1" cellspacing="1"
				class="thin">
				
				<tr>
					<td colspan="2" class="detailcontent" width="30%" align="left">
						注意：点击下面的按钮后将会整个数据库的表单重新保存,在未保存完毕前请勿离开页面！！
					</td>
				</tr>
				<tr>
					<td colspan="2" class="detailcontent" align="left">
						<BUTTON id=FCButton1 class=input onmovestart=moveStart()
							controltype="button" class="button_long"
							onclick='bill_onclick("batchSave()")' dropstyle="否">
							批量保存表单
						</BUTTON>
					</td>
				</tr>
			</table>
		</DIV>
		
		<DIV id="progressContainerDiv" style="display:none;BORDER: skyblue 2px solid;  FONT-SIZE: 15px; BACKGROUND: #ffffff;  WIDTH: 100%; HEIGHT: 30px; solid: #000000">
			<div id="progressValueDiv" style="z-index:100;position:relative;top:0px;left:0px;width:0%;height:100%;background-image: url('../images/th_img_bg.gif');background-repeat: repeat-x;"></div>
		</DIV>
		<div id="progressDiv" style="position:relative;width:100%;height:15px;text-align:center"></div>
		<IFRAME id=design height=0  src=""  width=0></IFRAME>
		<DIV id="messageDiv" style="width:100%;"></DIV>
	</body>
</html>

