<%@ page contentType="text/html; charset=GBK" %><%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
  if(!accesscontroler.checkAccess(request, response)){
  		return;
  }
  String appPath = "app_"+accesscontroler.getCurrentSystemID();
  String appId = accesscontroler.getCurrentSystemID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">		
		<STYLE> .userData{behavior:url(#default#userData);}
	</STYLE>
	<script type="text/javascript" src="../../../cachloader/pre_load.js"></script>	
	<script language="javascript">
		var __dj_win_flag__ = true;
		function load_over(){
			document.getElementById("preloadView").style.display="none";
			document.getElementById("SKbillsheet").style.visibility="visible";
		}
	
		function optmGetUsdatObj()
		{
			if((typeof(eppDataWrObj) != "undefined") && eppDataWrObj.isCanUse()) return eppDataWrObj;
			if((typeof(userDataWrObj) != "undefined") && userDataWrObj.isCanUse()) return userDataWrObj;
			return null;			
		}
		
		function optmGetFlashObj()
		{
			if((typeof(eppDataWrObj) != "undefined") && eppDataWrObj.isCanUse()) return eppDataWrObj;
			if((typeof(flashWrObj) != "undefined") && flashWrObj.isCanUse()) return flashWrObj;
			return null;
		}
		
		function ex_prePageInit()
		{	
			var bSucced = __pre_loadjsFrame();
			if(!bSucced) 
			{
				document.body.innerHTML = "<font color='#ff0000'>preload js frame failure!</font>";
				return;
			}
			
			mtJsFileArray("eformsys/fceform/js/fcpub.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/fcvalid.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceformext/js/usertb.js", true, optmGetUsdatObj());			
			mtJsFileArray("eformsys/fceform/js/ccpub.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/fcrundj.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/tabpane.js", true, optmGetFlashObj());
			mtJsFileArray("eformsys/fceform/js/fcsavedj.js", true, eppDataWrObj);
					
			s=0;
			s=1;
		
			bSucced = prePageInit(false, true);
			if(!bSucced) 
			{
				document.body.innerHTML = "<font color='#ff0000'>preload js file failure!</font>";
				return;
			}
			
			pub_djhtm();
			fcpubdata.creatorStyle='creatorBlue';
		}
		
		//根据应用确定样式的目录
		var stylePath = "../../../ccapp/<%=appPath%>/";			
	</script>
		
	</HEAD>
	<body  onload="load_over();pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<DIV style="Z-INDEX: 1000; BACKGROUND: #e0e0e0; FILTER: alpha(opacity=80); LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%" id="preloadView">
		   <TABLE style="VERTICAL-ALIGN: middle; WIDTH: 100%; HEIGHT: 100%; TEXT-ALIGN: center">
		      <TBODY>
		         <TR>
		            <TD><DIV style="BORDER-RIGHT: skyblue 2px solid; BORDER-TOP: skyblue 2px solid; FONT-SIZE: 15px; BACKGROUND: #ffffff; BORDER-LEFT: skyblue 2px solid; WIDTH: 150px; PADDING-TOP: 9px; BORDER-BOTTOM: skyblue 2px solid; HEIGHT: 40px; solid: #000000">正在加载……</DIV></TD>
		         </TR>
		      </TBODY>
		   </TABLE>
		</DIV>
		
		<iframe id="_newframe" name="_newframe" height="0" width="0"></iframe>
		<script>
			var pubdjbh=parent.sOpenDjNo;
			var pubEdit=false;
			var pubDataSet=null;
			var pubRequest=parent.oRequest;
			var pubEformEnterStatus="OK"; 
			ex_prePageInit();
		</script>

<!-- 提示：以下为页面的JS&CSS内容 -->
<%
 String iWebOfficeVersion  = com.chinacreator.config.ConfigManager.getInstance().getConfigValue("iWebOfficeVersion", "7,8,0,4");
String strDgMode = com.chinacreator.config.ConfigManager.getInstance().getConfigValue("file.upload.jsdgmode");
boolean bDgMode = !((strDgMode == null) || !strDgMode.equals("1"));
%><script language='javascript'>
<%if(bDgMode){%>  var myhead = document.getElementsByTagName('head')[0];
  var mylink = document.createElement("link");
  mylink.setAttribute("type","text/css");
  mylink.setAttribute("rel","stylesheet");
  mylink.setAttribute('href','../../../ccapp/<%=appPath%>/css//allStyle.css');
  myhead.appendChild(mylink);
<%}else{%>  adv_loadjsfile('ccapp/<%=appPath%>/css//allStyle.css');
<%}%>  fcpubdata.creatorStyle='';
</script>
<%
if(!bDgMode) out.println("<script language='javascript'>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/BusinessUnit.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/BusinessUnit.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var buId=creator_getQueryString("bu_id");//执法主体编号
var buName=creator_getQueryString("bu_name");//执法主体名称
var userId = creator_getQueryString("userId");//执法人员编号
var orgId= creator_getQueryString("org_id");//执法人员编号

//初始化信息
function init(){
   $("BU_ID").value = buId;
   $("BU_NAME").value = buName;
   $("orgIds").value = buId;
   addOrUpdLawUserInfo();  
}

//判断是新增还是修改数据的初始化
function addOrUpdLawUserInfo(){
    $("BU_ID").value = buId; 
    if(IsSpace(buId)){
        $("BWT_ID").value = -1 ;
        $("ELU_STATUS").value = -1 ;
    }else{        
        $("BU_ID").disabled = true;
    }
    //如果执法人员编号为空，则进行新增数据初始化;否则进行修改数据初始化
    if(IsSpace(userId)){
        $("BWT_ID").value = -1 ;
        $("ELU_STATUS").value = -1 ;
        document.getElementById("CF_BB").innerText = "新增执法人员" ;      
    }else{
         $('BU_ID').disabled = true ;
         $("USER_NAME").disabled = true ;
         document.getElementById("CF_BB").innerText = "修改执法人员" ;
         var sql = BusinessUnit.findLawUserById(userId);//初始化修改时数据        
          addLawUserDateset.Open(sql);
    }
}

//保存函数
function addOrUpdLawUser(){
    //如果执法人员编号为空，则进行新增数据;否则进行修改数据
    if(IsSpace(userId)){     
        addLawUser();//新增数据  
    }else{
        updLawUsre();//修改数据       
    }
}

//新增执法人员
function addLawUser(){
    var flag = validate();
    if(!flag){
         return;
    }else{
        var obj = new xzcf.vo.LawUser();
        var lawUserVo= DBUtil.getVoFromPage(obj);
        var user_Id = $("USER_ID").value ;
        lawUserVo.USER_ID = user_Id ;
        var tmp = "";
        var temp = document.getElementsByName('RGELU_STATUS');
        for(var i = 0 ; i<temp.length ; i++){
            if(temp[i].checked == true){
                tmp = temp[i].value ;
            }
        }
        lawUserVo.ELU_STATUS = tmp ;
        lawUserVo.ELU_ACCESSORIES = $('ELU_ACCESSORIES').value ;
        var rv = BusinessUnit.addLawUser(lawUserVo);
        if(rv){
            alert("保存数据信息失败！");
            userId = "" ;
        }else{
            alert("保存数据信息成功！");
        }
    }
       
}

//修改执法人员
function updLawUsre(){
        if(validate()){
            var obj = new xzcf.vo.LawUser();
            var LawUserVo= DBUtil.getVoFromPage(obj);
            userId =$("USER_ID").value ;
            LawUserVo.USER_ID = userId ;
            var rv = BusinessUnit.updateLawUsre(LawUserVo);
            if(rv){
                alert("保存数据信息成功");
            }else{
                alert("保存数据信息失败");
            }  
        }
}

//附件上传按钮函数
function openUploadAndDownView(){
    var isAllowDelete = true ;
    var id = $('ELU_ACCESSORIES').value;
    if(IsSpace(id)){
        id = DBUtil.getSeq('SEQ_LITIGANT_RD');
        $('ELU_ACCESSORIES').value = id;
    }
    var allowAdd = true;
    var name = "app_xzcf";
    var viewAddr =getOpenUrlByDjid("20100920113019725484")+"&id="+id+"&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name+"&djbh="+id +
             "&fileCount=10" ;
    var featrues = "dialogWidth:640px;dialogHeight:360px;center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    return rtn ;
}


//验证方法 
function validate() {
    var flag = true;
    if (flag) {
        flag = SValidator.validate(${'USER_ID'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'USER_ID'}.value]},
            MESSAGE : "姓名不能为空"
        }, true);
    }
    if (flag) {
        if($("BU_ID").value==-1){
            alert("执法主体不能为空");
            flag = false ;
        }
    }
    
     if (flag) {
        if($("BWT_ID").value==-1){
            alert("执法类别不能为空");
            flag = false ;
        }    
    }
 
    if (flag) {
        flag = SValidator.validate(${'ELU_DOCUMENT_NO'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'ELU_DOCUMENT_NO'}.value]},
            MESSAGE : "证件编号不能为空"
        }, true);
    }
    if (flag) {
        var reg=/[\u4E00-\u9FA5]+/g;
        if (reg.test($("ELU_DOCUMENT_NO").value)){
            flag = false;
            alert("证件编号不能包含汉字！");
        }            
    }

    if (flag) {
        flag = SValidator.validate(${'ELU_DOCUMENT_NO'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "证件编号最大不能超过{0}字符"
        }, true);
    }
    
    if(flag){
        flag = validateNum();
        if(!flag){
            alert("证件编号不能重复，请重新填写");
            flag = false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'ELU_LICENCE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'ELU_LICENCE'}.value]},
            MESSAGE : "发证机关不能为空"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'ELU_LICENCE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [200],maxlength : 200},
            MESSAGE : "发证机关最大不能超过{0}字符"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'ELU_CERTIFICATION_DATE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'ELU_CERTIFICATION_DATE'}.value]},
            MESSAGE : "发证日期不能为空"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'ELU_CERTIFICATION_DATE'}.value, {
            CHECK_TYPE : "date",
            ARGUMENT : {placeholders : ["发证日期"]}
        }, true);
    }
    
    if(flag){
        if(!IsSpace($("ELU_END_DATE").value)){
            //失效日期必须大于发证日期
            if(${'ELU_END_DATE'}.value >= ${'ELU_CERTIFICATION_DATE'}.value){
                flag = true;
            }else{
                alert("失效日期必须大于发证日期");
                flag = false ;
            }
        }
    }
    
    return flag ;
}

//姓名是否被引用过
function validateName(){
    var uId = $("USER_ID").value ;
    var flag = true;
    var vr = BusinessUnit.findByUserId(uId);
    if(IsSpace(vr)){
        flag = true ;
    }else{
        flag = false ;
    }
    return flag ;
}

//证件号码的唯一性
function validateNum(){
    var flag = true ;
    var num = $("ELU_DOCUMENT_NO").value ;
    var userId = $("USER_ID").value ;
    var vr = BusinessUnit.findByELU_DOCUMENT_NO(num,userId);
    if(vr>0){
        flag = false ;
    }else{
        flag = true ;
    }
    return flag ;
}

function closeWindows() {
    window.close();
}

//打开平台人员的选择
function openUserTree(){
    var url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgUserPermissionTree.jsp?org_id="+orgId;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}


//打开执法主体的选择
function openOrgTree(){
    var url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourseSingle.jsp";
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><radio><id>ELU_STATUS</id></radio><combobox><id>BWT_ID</id></combobox><button><id>button1</id><id>button2</id><id>button3</id></button><text><id>USER_NAME</id><id>USER_ID</id><id>BU_NAME</id><id>orgIds</id><id>orgNames</id><id>BU_ID</id><id>ELU_DOCUMENT_NO</id><id>ELU_LICENCE</id><id>ELU_CERTIFICATION_DATE</id><id>ELU_END_DATE</id><id>ELU_ACCESSORIES</id></text><dataset><id>addLawUserDateset</id></dataset></root>" billtaborder="<root><taborder>ELU_DOCUMENT_NO</taborder><taborder>ELU_LICENCE</taborder><taborder>ELU_CERTIFICATION_DATE</taborder><taborder>ELU_END_DATE</taborder><taborder>button2</taborder><taborder>button3</taborder><taborder>USER_NAME</taborder><taborder>USER_ID</taborder><taborder>BWT_ID</taborder><taborder>button1</taborder><taborder>ELU_ACCESSORIES</taborder><taborder>ELU_STATUS</taborder><taborder>BU_NAME</taborder><taborder>orgIds</taborder><taborder>orgNames</taborder><taborder>BU_ID</taborder></root>" dj_sn="20100902194102000659" caption="新增或修改执法人员" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:2;listbox:0;textarea:0;combobox:6;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:13;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:8;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181546343920" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/vo.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/BusinessUnit.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=CF_BB colSpan=4 VALUE=""></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">姓名<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_image id=USER_NAME style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="user_realname" china="真实名字" dataset="addLawUserDateset" onclick='bill_onclick("openUserTree()")'><INPUT id=USER_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 39px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=3 controltype="text" field="USER_ID" china="执法人员编号" dataset="addLawUserDateset"></TD>
                     <TD class=c2 width="15%">执法主体<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_image id=BU_NAME style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%" height=25>执法类别<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><SELECT id=BWT_ID style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=select2 sqltrans="%F4%D8%E6%D8%D4%F6Xrn%92%BC%B6%CC%A0%96Xr%94%92%BC%B6%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%92%B8%B4%A0%AA%98%B4%B4%CC%B6%C0%AE%98Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%92%BC%B6%CC%A0%96" controltype="combobox" field="BWT_ID" china="执法类别" dataset="addLawUserDateset" tempvalue="-1" temptext="---请选择---" sql check="1"><OPTION value=-1 selected>---请选择---</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">证件编号<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=ELU_DOCUMENT_NO style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=33 name=Input2 controltype="text" field="ELU_DOCUMENT_NO" china="执法编号" dataset="addLawUserDateset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">发证机关<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=ELU_LICENCE style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=33 name=Input3 controltype="text" field="ELU_LICENCE" china="发证机关" dataset="addLawUserDateset"></TD>
                     <TD class=c2 width="15%">发证日期<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=its_out id=ELU_CERTIFICATION_DATE style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px" onmovestart=moveStart() readOnly size=33 name=Input4 controltype="text" field="ELU_CERTIFICATION_DATE" china="发证日期" dataset="addLawUserDateset" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">失效日期</TD>
                     <TD width="35%"><INPUT class=its_out id=ELU_END_DATE style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px" onmovestart=moveStart() readOnly size=33 name=Input5 controltype="text" field="ELU_END_DATE" china="失效日期" dataset="addLawUserDateset" onclick='bill_onclick("SelectDate()")'></TD>
                     <TD class=c2 width="15%">是否有效<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><FIELDSET id=ELU_STATUS contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 152px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 16px" onmovestart=moveStart() controltype="radio" field="ELU_STATUS" china="状态" dataset="addLawUserDateset" tempvalue="1&#13;&#10;0" temptext="有效&#13;&#10;无效" aspect="横向" legend NotBg="否" value="1"><INPUT type=radio CHECKED value=1 name=RGELU_STATUS text="有效"><SPAN onclick=RGELU_STATUS[0].checked=true;ELU_STATUS.value=RGELU_STATUS[0].value;RGELU_STATUS[0].focus();>有效</SPAN>&nbsp;<INPUT type=radio value=0 name=RGELU_STATUS text="无效"><SPAN onclick=RGELU_STATUS[1].checked=true;ELU_STATUS.value=RGELU_STATUS[1].value;RGELU_STATUS[1].focus();>无效</SPAN>&nbsp;</FIELDSET></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">证件附件</TD>
                     <TD colSpan=3><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openUploadAndDownView();")'>附件上传</BUTTON><INPUT id=ELU_ACCESSORIES style="DISPLAY: none; LEFT: 0px; WIDTH: 55px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=10 controltype="text" field="ELU_ACCESSORIES" china="证件附件" dataset="addLawUserDateset"></TD>
                  </TR>
               </TBODY>
            </TABLE>
            <TR>
               <TD align=middle><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addOrUpdLawUser()")'>保存</BUTTON><BUTTON class=button id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("CloseBill()")'>关闭</BUTTON></TD>
            </TR>
            <TR>
               <TD>
                  <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
                     <TBODY>
                        <TR>
                           <TD>&nbsp;</TD>
                        </TR>
                     </TBODY>
                  </TABLE>
               </TD>
            </TR>
         </TBODY>
      </TABLE>
      <?xml:namespace prefix = fc />
      <fc:dataset id=addLawUserDateset showtypeXml="<root><showType><name>checkBox</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkBox%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkBox</fieldname><datatype>字符</datatype><displaylabel>选择</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkBox%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_DOCUMENT_NO</fieldname><datatype>字符</datatype><displaylabel>证件编号</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_LICENCE</fieldname><datatype>字符</datatype><displaylabel>发证机关</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BWT_ID</fieldname><datatype>字符</datatype><displaylabel>执法类别</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_CERTIFICATION_DATE</fieldname><datatype>日期</datatype><displaylabel>发证日期</displaylabel><size>7</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_END_DATE</fieldname><datatype>日期</datatype><displaylabel>失效日期</displaylabel><size>7</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_ACCESSORIES</fieldname><datatype>图象</datatype><displaylabel>证件附件</displaylabel><size>4000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_ORDER</fieldname><datatype>字符</datatype><displaylabel>序号</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_ID</fieldname><datatype>字符</datatype><displaylabel>执法人员编号</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_NAME</fieldname><datatype>字符</datatype><displaylabel>名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>user_realname</fieldname><datatype>字符</datatype><displaylabel>真实名字</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkBox></checkBox><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><ELU_ACCESSORIES></ELU_ACCESSORIES><ELU_ORDER></ELU_ORDER><BU_ID></BU_ID><USER_ID></USER_ID><USER_NAME></USER_NAME><user_realname></user_realname></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkBox></checkBox><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><ELU_ACCESSORIES></ELU_ACCESSORIES><ELU_ORDER></ELU_ORDER><BU_ID></BU_ID><USER_ID></USER_ID><USER_NAME></USER_NAME><user_realname></user_realname></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkBox></checkBox><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><ELU_ACCESSORIES></ELU_ACCESSORIES><ELU_ORDER></ELU_ORDER><BU_ID></BU_ID><USER_ID></USER_ID><USER_NAME></USER_NAME><user_realname></user_realname></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>
   </DIV>
<div id='grid_tip'></div></body></html>