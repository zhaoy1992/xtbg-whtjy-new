<%@ page contentType="text/html; charset=GBK" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
  accesscontroler.checkAccess(request, response);
  String appPath = "app_"+accesscontroler.getCurrentSystemID();
  String appId = accesscontroler.getCurrentSystemID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">		
		<STYLE> .userData{behavior:url(#default#userData);}
	</STYLE>		
		<script src="../../fceform/js/fcpub.js"></script>
		<script src="../../fceform/js/fcrundj.js"></script>
		<script src="../../fceform/js/tabpane.js"></script>
		<script src="../../fceform/js/ccpub.js"></script>
		<script src="../../fceform/js/ccapp_pub.js"></script>		
		<script src="../../../public/gaeditor.js"></script>
		<script src="../../../iWebOffice2006/js/iWebOffice2006.js"></script>
		<script langage="javascript">
			//根据应用确定样式的目录
			var stylePath = "../../../ccapp/<%=appPath%>/"; 
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			mylink.setAttribute("href",stylePath+"css/"+fcpubdata.creatorStyle+"/allStyle.css");
			var myhead = document.getElementsByTagName("head")[0];
			myhead.appendChild(mylink);
		</script>
				
		<jsp:include page="../../../iWebOffice2006/js/iWebOffice2006Event.jsp" flush="false"/>
	</HEAD>
	<body background="../../fceform/images/ef_run_background.gif" onload="pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<iframe id="_newframe" name="_newframe" height="0" width="0"></iframe>
		<script>
var pubdjbh=parent.sOpenDjNo;
var pubEdit=false;   			
var pubDataSet=null;
var pubRequest=parent.oRequest;
var pubEformEnterStatus="OK"; 
pub_djhtm();
		</script>
<script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><link type='text/css' rel='stylesheet' href='../../fceform/css/Button.css'/><link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/>
<script>function hiddenCheckbox1(){
        label3.style.display = "none";
        label4.style.display = "none";
        listName.style.display = "none";
        delFun.style.display = "none";
        addFun.style.display = "none";
        alterFun.style.display = "none";
}

function displayCheckbox1(){
        label3.style.display = "block";
        label4.style.display = "block";
        listName.style.display = "block";
        delFun.style.display = "block";
        addFun.style.display = "block";
        alterFun.style.display = "block";
        if(!checkbox2.children[0].checked){
            addFun.disabled= true;
            alterFun.disabled = true;
        }            
}

function displayCheckbox2(){
       label2.style.display = "block";
       detailName.style.display = "block";
       addFun.disabled= false;
       alterFun.disabled = false;
}
function hiddenCheckbox2(){
        label2.style.display = "none";
        detailName.style.display = "none";
        addFun.disabled = true;
        alterFun.disabled = true;
}

function init(){
    if(!checkbox1.children[0].checked){
        hiddenCheckbox1();
    }
    if(!checkbox2.children[0].checked){
        hiddenCheckbox2();
    }
}

function display1(){
    if(!checkbox1.children[0].checked){
        hiddenCheckbox1();          
    }else{
        displayCheckbox1();
    }
}

function display2(){
    if(!checkbox2.children[0].checked){
        hiddenCheckbox2();
    }else{
        displayCheckbox2();
    }
}

function creator_ok(){
    var ret = "";
    if(checkbox1.children[0].checked){
        ret = '是,';
    }else{
        ret = '否,';
    }
    if(checkbox2.children[0].checked){
        ret += '是';
    }else{
        ret += '否';
    }
    if(checkbox1.children[0].checked){
        if(listName.value.trim()==""){
            alert("请填写列表页面名称!");
            return;
        }
        ret += "," + listName.value +","
                   + addFun.value+","
                   + alterFun.value+","
                   + delFun.value; 
    }else{
        ret +=",no,no,no,no";
    }
    if(checkbox2.children[0].checked){
        if(detailName.value.trim()==""){
            alert("请填写详细页面名称!");
            return; 
        }
        ret += "," + detailName.value;
    }else{
        ret  +=",no";
    }    
    window.returnValue=ret;
    window.close();
}</script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js" creatorType="20080926152939906790" type="ZW" contxml="<root><checkbox><id>checkbox1</id><id>checkbox2</id><id>addFun</id><id>alterFun</id><id>delFun</id></checkbox><label><id>label2</id><id>label5</id><id>label3</id><id>label4</id></label><button><id>button1</id><id>button2</id></button><text><id>detailName</id><id>listName</id></text></root>" controlno="SKButton:0;SKDBedit:0;checkbox:12;label:8;radio:0;listbox:0;textarea:0;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:1;div:2;DsMain_field:0;a:0;button:2;text:5;hr:0;checkboxlist:1;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:1;ebshow:0;creatorSubForm:0;creator_div:0" billtaborder="<root><taborder>checkbox1</taborder><taborder>checkbox2</taborder><taborder>button1</taborder><taborder>button2</taborder><taborder>detailName</taborder><taborder>addFun</taborder><taborder>alterFun</taborder><taborder>delFun</taborder><taborder>listName</taborder></root>" creator_pagination version="1.0" idtype="1" OtherSave="否" isfile="否" posheight poswidth postop posleft isprotect="是" islog="否" creator_office_isBindForm="否" creator_showAlert="否" creator_elementAuthoritySwitch="否" hasWorkflowButton="否" creator_remark entertype="修改" window="当前窗口" BLONclose="UnLoadWebOffice();" BLONopen="setAuthority();init();" keyfield codeheader="BBB" mkbh caption="表单自动绘制设置页面" dj_sn="20080926154518093882" toolbar="不带工具栏">&nbsp; 
<DIV id=label2 style="LEFT: 99px; WIDTH: 65px; POSITION: absolute; TOP: 290px; HEIGHT: 15px" onmovestart=moveStart() noWrap NotBg="否" value="label2" controltype="label">详细页面名称：</DIV><INPUT id=detailName style="LEFT: 208px; WIDTH: 170px; POSITION: absolute; TOP: 288px; HEIGHT: 20px" onmovestart=moveStart() size=29 controltype="text"> 
<DIV id=checkbox1 style="LEFT: 74px; WIDTH: 80px; POSITION: absolute; TOP: 70px; HEIGHT: 20px" onmovestart=moveStart() noWrap NotBg="否" value="否" controltype="checkbox" onclick='bill_onclick("display1();")' divtype="checkbox" truevalue="是" falsevalue="否"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>是否生成列表页面</SPAN></DIV>
<DIV id=checkbox2 style="LEFT: 74px; WIDTH: 80px; POSITION: absolute; TOP: 251px; HEIGHT: 20px" onmovestart=moveStart() noWrap NotBg="否" value="否" controltype="checkbox" onclick='bill_onclick("display2()")' divtype="checkbox" truevalue="是" falsevalue="否"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>是否生成详细页面</SPAN></DIV><BUTTON id=button1 style="LEFT: 115px; WIDTH: 75px; POSITION: absolute; TOP: 342px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" onclick='bill_onclick("creator_ok()")' dropstyle="否">生成</BUTTON><BUTTON id=button2 style="LEFT: 264px; WIDTH: 75px; POSITION: absolute; TOP: 342px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" onclick='bill_onclick("CloseBill()")' dropstyle="否">取消</BUTTON> 
<DIV id=label5 style="LEFT: 167px; WIDTH: 65px; POSITION: absolute; TOP: 36px; HEIGHT: 15px" onmovestart=moveStart() noWrap NotBg="否" value="label5" controltype="label">表单自动生成向导</DIV>
<DIV id=label3 style="LEFT: 99px; WIDTH: 65px; POSITION: absolute; TOP: 110px; HEIGHT: 15px" onmovestart=moveStart() noWrap NotBg="否" value="label7" controltype="label">列表页面名称：</DIV><INPUT id=listName style="LEFT: 208px; WIDTH: 170px; POSITION: absolute; TOP: 106px; HEIGHT: 20px" onmovestart=moveStart() size=30 controltype="text"> 
<DIV id=label4 style="LEFT: 99px; WIDTH: 65px; POSITION: absolute; TOP: 148px; HEIGHT: 15px" onmovestart=moveStart() noWrap NotBg="否" value="label8" controltype="label">是否生成下列功能：</DIV>
<DIV id=addFun style="LEFT: 119px; WIDTH: 80px; POSITION: absolute; TOP: 180px; HEIGHT: 20px" onmovestart=moveStart() noWrap NotBg="否" value="否" controltype="checkbox" divtype="checkbox" truevalue="是" falsevalue="否"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>新增</SPAN></DIV>
<DIV id=alterFun style="LEFT: 212px; WIDTH: 80px; POSITION: absolute; TOP: 180px; HEIGHT: 20px" onmovestart=moveStart() noWrap NotBg="否" value="否" controltype="checkbox" divtype="checkbox" truevalue="是" falsevalue="否"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>修改</SPAN></DIV>
<DIV id=delFun style="LEFT: 315px; WIDTH: 80px; POSITION: absolute; TOP: 180px; HEIGHT: 20px" onmovestart=moveStart() noWrap NotBg="否" value="否" controltype="checkbox" divtype="checkbox" truevalue="是" falsevalue="否"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>删除</SPAN></DIV></DIV></body></html>