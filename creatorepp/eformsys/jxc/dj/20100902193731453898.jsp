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
					
			mtJsFileArray("eformsys/fceform/js/Ext/ext-base.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-all.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-lang-zh_CN.js", true, eppDataWrObj, "UTF-8");
         mtJsFileArray("eformsys/fceform/js/Ext/css/ext-all.css", true, optmGetUsdatObj());
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
		
		//����Ӧ��ȷ����ʽ��Ŀ¼
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
		            <TD><DIV style="BORDER-RIGHT: skyblue 2px solid; BORDER-TOP: skyblue 2px solid; FONT-SIZE: 15px; BACKGROUND: #ffffff; BORDER-LEFT: skyblue 2px solid; WIDTH: 150px; PADDING-TOP: 9px; BORDER-BOTTOM: skyblue 2px solid; HEIGHT: 40px; solid: #000000">���ڼ��ء���</DIV></TD>
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

<!-- ��ʾ������Ϊҳ���JS&CSS���� -->
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

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
var buId=creator_getQueryString("BU_ID");
var buName=creator_getQueryString("BU_NAME");

//��ʼ��ִ��������Ϣ
function init(){
     addButton();//���ư�ť����ʾ��Ӱ�� 
      findBusinessById(buId);//�޸Ĳ���ֵ�ĳ�ʼ��
      findLawUserByBuId(buId);//��ѯ��Ӧִ�������µ�ִ����Ա
       if(IsSpace(buId)){
           $("VC_ID").value = -1 ;
           $("AD_ID").value = -1 ; 
      }else{
           $("BU_NAME").value = buName ;
           $("BU_ID").value = buId ; 
           $("orgNames").value = $("BU_NAME").value ;
           $("orgIds").value = $("ORG_ID").value ;
      }
}

//����ִ��������US_ID��ѯִ�����壬����ʼ������
function findBusinessById(buId){
    if(IsSpace(buId)){//���ǰ��׼������
         document.getElementById("cf_aa").innerText = "����ִ������" ;
        ${'BU_NAME'}.value = "";
        ${'BU_BRIEF_NAME'}.value = "";
        ${'BU_BRIEF_CODE'}.value = "";
        ${'BU_CODE'}.value = "";
        ${'BU_LEGAL_PERSON'}.value = "";
        ${'BU_COERCIVE_POWER'}.value = "";
        ${'BU_LEGAL_BASIS'}.value = "";
        ${'BU_REMARK'}.value = "";
        addButton();//���ư�ť����ʾ��Ӱ��  
    } else {//�޸�ǰ��׼������
        document.getElementById("cf_aa").innerText= "�޸�ִ������" ;
       changeGrayButton();//�ѿؼ��û�
        dispalayButton();//��ʾ������ɾ����ť 
       var obj = new xzcf.vo.BusinessUnit();
       var businessUnitVo = DBUtil.getVoFromPage(obj);
       var sql = BusinessUnit.findByBusinessUnitId(buId);
       addBusinessUnitDateset.Open(sql);
    }
    reloadExtGrid();
}

//�޸�ִ������ʱ��ִ�����塢��ҵ���ࡢ���������û�
function changeGrayButton(){
    $("BU_NAME").disabled = true;
    $("VC_ID").disabled = true;
    $("AD_NAME").disabled = true;
}

//����������ɾ����ť����ʾ
function addButton(){
    if(IsSpace(buId)){
        $("addLawUser").style.display = "none";
        $("delLawUser").style.display = "none";
    }else{
        $("addLawUser").style.display = "";
        $("delLawUser").style.display = "";
    }
}

//˫���޸�ִ����Ա��Ϣ
function updateLawUser(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var userId= row.get("user_id");
    var tempPara="dialogWidth:800px;dialogHeight:330px;";
    var tempURL="20100902194102000659.jsp?userId="+userId+"&bu_id="+buId+"&bu_name="+$("BU_NAME").value;
    //window.location.href(tempURL);
    showModalDialog(tempURL,"window",tempPara);
    reloadExtGrid();
}

//������ɾ���İ�ť��ʾ
function dispalayButton(){
    $("addLawUser").style.display = "";
    $("delLawUser").style.display = "";
    $("BU_NAME").readOnly = true;
}

// �������޸�ִ������
function addOrUpdBusiness(){
    if(IsSpace(buId)){
        if(!validate1()){//��������
        
        }else{
            var obj = new xzcf.vo.BusinessUnit();
            var businessUnitVo= DBUtil.getVoFromPage(obj);
            businessUnitVo.BU_ID = buId;
            var tmp1 = "";
            var aa = document.getElementsByName('RGBU_VALID') ;
            if(aa[0].checked){
                tmp1 = aa[0].value ;
            }else{
                tmp1 = aa[1].value ;
            }  
            businessUnitVo.BU_VALID = tmp1 ;
            var bb = document.getElementsByName('RGBU_COERCIVE_POWER') ;
            if(bb[0].checked){
                businessUnitVo.BU_COERCIVE_POWER=1 ;
            }else{
                businessUnitVo.BU_COERCIVE_POWER=0 ;
            }
            var rv = BusinessUnit.addOrUpdBusinessUnit(businessUnitVo);
            if(rv){
                alert("����������Ϣʧ�ܣ�");
            }else{
                alert("����������Ϣ�ɹ���");
                $("BU_NAME").disabled = true;
                var org_id = $("ORG_ID").value ;
                var temp = DBUtil.SqlToField(BusinessUnit.findByBuIdBiz(org_id));
                $("BU_ID").value = temp;//�������ݳɹ�ʱ�������ݷŻص�����
                  buId = $("BU_ID").value;//���ڱ��沢����
                  findLawUserByBuId(temp);//��ѯ��Ӧִ�������µ�ִ����Ա
                  dispalayButton();
           }
        }
    }else{
        if(validate1()){//�޸�����
              var obj = new xzcf.vo.BusinessUnit();
            var businessUnitVo= DBUtil.getVoFromPage(obj);
            businessUnitVo.BU_ID = buId;
            var tmp1 = "";
            var aa = document.getElementsByName('RGBU_VALID') ;
            if(aa[0].checked){
                tmp1 = aa[0].value ;
            }else{
                tmp1 = aa[1].value ;
            }  
            businessUnitVo.BU_VALID = tmp1 ;
            var bb = document.getElementsByName('RGBU_COERCIVE_POWER') ;
            if(bb[0].checked){
                businessUnitVo.BU_COERCIVE_POWER=1 ;
            }else{
                businessUnitVo.BU_COERCIVE_POWER=0 ;
            }
            var rv = BusinessUnit.addOrUpdBusinessUnit(businessUnitVo);
            if(rv){
                alert("����������Ϣʧ�ܣ�");
            }else{
                alert("����������Ϣ�ɹ���");
                $("BU_ID").value = buId;//�������ݳɹ�ʱ�������ݷŻص����У�
                  dispalayButton();
            }    
        }
    }
    reloadExtGrid();
}

//�򿪷��ɷ���ѡ�����
function showLaw(obj){
    var tempPara="dialogWidth:780px;dialogHeight:600px;";
    var tempURL="20100904171631828947.jsp";
    var tmp = showModalDialog(tempURL,window,tempPara);
    if (!IsSpace(tmp)) {
        var name_tmp = tmp.names;
        var id_tmp = tmp.ids;
        $("flyj").value = id_tmp;
        for(var i=0;i<name_tmp.length;i++){
            obj.value = obj.value + "\n" + "��"+ name_tmp[i]+ "��";
            if ($("flyj").value=="") {
                    $("flyj").value = "";
                } else {
                    $("flyj").value = $("flyj").value + "," + id_tmp[i];
                }
        }
    }
}

//�ж�ѡ��ķ��ɷ����Ƿ�����ͬ��¼
function isSame(ids, names,type){
    if (ids!=null ){
        var nameValue = "" ;
        for(var j=0;j<ids.length;j++){
            if (($("flyj").value).indexOf(ids[j])!=-1) {
                nameValue = names[j];
                break;
            }
        }    
        return nameValue;
    }
}

//��������ִ����Ա 
function addLawUserLoad(){
        var buId = $("bu_id").value;
       var tempPara="dialogWidth:800px;dialogHeight:330px;";
       var tempURL="20100902194102000659.jsp?bu_id="+buId+"&bu_name="+$("BU_NAME").value+"&org_id="+$("ORG_ID").value;
       //window.location.href(tempURL);
       var rv = showModalDialog(tempURL,"window",tempPara);
       reloadExtGrid();   
}

//��ѯִ����������Ӧ��ִ����Ա
function findLawUserByBuId(buId){
   var sql = BusinessUnit.findLawUserByBuId(buId);
   lawUserDateset.Open(sql);
}


//ɾ��ִ����Ա
function delLawUserList(){
        var grid =  creator_pt_grids[0].obj;
        var rows = grid.getSelectionModel().getSelections();
        var ids = new Array();
        for(var i=0;i<rows.length;i++){
           var user_id = rows[i].get("user_id");
           ids[ids.length] = user_id ;                     
        }
        if(ids.length==0){    
           alert("��ѡ��Ҫɾ���ļ�¼��");
           return false;
        }else if (confirm('�Ƿ�Ҫɾ����ѡ����?')) {
           var rv = BusinessUnit.delLawUser(ids);
           if(rv){
              alert("ɾ��������Ϣ�ɹ���");
           }else{
               alert("ɾ��������Ϣʧ�ܣ�");
           }
           reloadExtGrid();
       }
}

//����ƽ̨������
/*
function myOpenTree(){
    if(IsSpace(buId)){
        openTree('org',ORG_ID,BU_NAME,true);
    }
}*/

//��֤���� 
function validate1() {
    var flag = true;
    if (flag) {
        flag = SValidator.validate(${'BU_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'BU_NAME'}.value]},
            MESSAGE : "ִ�����岻��Ϊ��"
        }, true); 
    }
    if (IsSpace(buId)) {
        if (flag) {
            flag = checkORGID();
            if (!flag) {
                alert('ִ�������Ѵ���');
                return false ;
            }
        }
    }    
    
    if (flag) {
        flag = SValidator.validate(${'BU_NAME'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [150],maxlength : 150},
            MESSAGE : "ִ����������ܳ���{0}�ַ�"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'BU_BRIEF_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'BU_BRIEF_NAME'}.value]},
            MESSAGE : "��Ʋ���Ϊ��"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'BU_BRIEF_NAME'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [150],maxlength : 150},
            MESSAGE : "�������ܳ���{0}�ַ�"
        }, true);
    }
      
    if (flag) {
        flag = SValidator.validate(${'BU_BRIEF_CODE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'BU_BRIEF_CODE'}.value]},
            MESSAGE : "ִ����Ų���Ϊ��"
        }, true);
    }
    if (flag) {
        var reg=/[\u4E00-\u9FA5]+/g;
        if (reg.test($("BU_BRIEF_CODE").value)){
            flag = false;
            alert("ִ����Ų��ܰ������֣�");
        }            
    }
    if (flag) {
        flag = SValidator.validate(${'BU_BRIEF_CODE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [4],maxlength : 4},
            MESSAGE : "ִ���������ܳ���{0}�ַ�"
        }, true);
    }
    
    if (flag) {
        flag = checkBUBRIEFCODE();//�ж�ִ����ŵ�Ψһ��
        if (!flag) {
            alert('ִ������Ѵ���,��������д');
            return false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'BU_CODE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'BU_CODE'}.value]},
            MESSAGE : "��λ���벻��Ϊ��"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'BU_CODE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [10],maxlength : 10},
            MESSAGE : "��λ��������ܳ���{0}�ַ�"
        }, true);
    } 
    
    if (flag) {
        flag = checkBUCODE();
        if (!flag) {
            alert('��λ�����Ѵ���,��������д');
            return false ;
        }
    }

    
    if (flag) {
        flag = SValidator.validate(${'BU_LEGAL_PERSON'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "���˴�������ܳ���{0}�ַ�"
        }, true);
    }
           
    if (flag) {
        var vc_id = $("VC_ID").value ;
        if(vc_id == -1){
            alert("��ѡ����ҵ����");
            return false ;
        }
    }
    
    if (flag) {
        var ad_id = $("AD_ID").value ;
        if(ad_id == -1){
            alert("��ѡ����������");
            return false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'AD_ID'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "������������ܳ���{0}�ַ�"
        }, true);
    }
    if (flag) {
        var tmp = "";
        var aa = document.getElementsByName('RGBU_VALID') ;
        if(aa[0].checked){
            tmp = aa[0].value ;
        }else{
            tmp = aa[1].value ;
        }        
        flag = SValidator.validate(tmp, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [tmp]},
            MESSAGE : "��ѡ���Ƿ���Ч"
        }, true);
    }
    
    if (flag) {
        var tmp = "";
        var aa = document.getElementsByName('RGBU_COERCIVE_POWER') ;
        if(aa[0].checked){
            tmp = aa[0].value ;
        }else{
            tmp = aa[1].value ;
        }
        flag = SValidator.validate(tmp, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [tmp]},
            MESSAGE : "��ѡ���Ƿ����ǿ��Ȩ"
        }, true);
    }
    return flag; 
}


//�ж�ִ����ŵ�Ψһ��
function checkBUBRIEFCODE(){
    var tflag = true;
   var briefCode = $('BU_BRIEF_CODE').value;//ִ�����
   var bu_id = $('BU_ID').value ;
   var sql = BusinessUnit.checkBrife_Code(briefCode,bu_id);
   var num = DBUtil.SqlToField(sql);
   if(num>0){
       tflag = false;
   }else{
       tflag = true;
   }
   if(!tflag){//�����ִ����Ŷ�Ӧ��ִ�����壬���ѯ��ִ������ID
       var tempVariable = BusinessUnit.findBu_idByBu_brief_code(briefCode);//ִ������ID
       if(tempVariable == buId){
           tflag = true;
       } else {
           tflag = false;
       }
   }
   return tflag;
}


//��֤��Ԫ�����Ψһ��
function checkBUCODE(){
   var buCode = $('BU_CODE').value.trim();
   var bu_id = $('BU_ID').value.trim() ;
   var sql = BusinessUnit.checkCode(buCode,bu_id);
   var num = DBUtil.SqlToField(sql);
   if(num>0){
       return false;
   }else{
       return true;
   }
}

//��ִ֤�������Ψһ��
function checkORGID(){
   var orgId = $('ORG_ID').value.trim();
   var bu_id = $('BU_ID').value.trim() ;
   var sql = BusinessUnit.checkORG_ID(orgId);
   var num = DBUtil.SqlToField(sql);
   if(num>0){
       return false;
   }else{
       return true;
   }
}

//������������ѡ��
function openDivisionTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseDivisionTree.jsp"; 
    window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}

//��ִ�������ѡ��
function openOrgTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgPermisionTree.jsp";
    $("orgNames").value = $("BU_NAME").value ;
    $("orgIds").value = $("ORG_ID").value ;     
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("BU_NAME").value = $("orgNames").value ;
    $("ORG_ID").value = $("orgIds").value ;
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><radio><id>BU_COERCIVE_POWER</id><id>BU_VALID</id></radio><textarea><id>BU_LEGAL_BASIS</id><id>BU_REMARK</id></textarea><combobox><id>VC_ID</id></combobox><button><id>button2</id><id>button3</id><id>button4</id><id>addLawUser</id><id>delLawUser</id></button><text><id>BU_NAME</id><id>zfjt1</id><id>orgNames</id><id>orgIds</id><id>BU_BRIEF_NAME</id><id>jc</id><id>BU_BRIEF_CODE</id><id>zfbh</id><id>BU_CODE</id><id>dydm</id><id>BU_LEGAL_PERSON</id><id>frdb</id><id>hyfl</id><id>AD_NAME</id><id>sfyx</id><id>xzqh</id><id>AD_ID</id><id>flyj</id><id>bj</id><id>sfqzq</id><id>BU_ID</id><id>ORG_ID</id></text><dataset><id>addBusinessUnitDateset</id><id>lawUserDateset</id></dataset><ExtGrid><id>ExtGrid4</id></ExtGrid></root>" billtaborder="<root><taborder>BU_NAME</taborder><taborder>BU_BRIEF_NAME</taborder><taborder>BU_BRIEF_CODE</taborder><taborder>BU_CODE</taborder><taborder>BU_LEGAL_PERSON</taborder><taborder>BU_LEGAL_BASIS</taborder><taborder>button2</taborder><taborder>BU_REMARK</taborder><taborder>button3</taborder><taborder>button4</taborder><taborder>addLawUser</taborder><taborder>delLawUser</taborder><taborder>BU_ID</taborder><taborder>ORG_ID</taborder><taborder>zfjt1</taborder><taborder>jc</taborder><taborder>zfbh</taborder><taborder>dydm</taborder><taborder>frdb</taborder><taborder>hyfl</taborder><taborder>xzqh</taborder><taborder>sfyx</taborder><taborder>flyj</taborder><taborder>bj</taborder><taborder>VC_ID</taborder><taborder>BU_VALID</taborder><taborder>BU_COERCIVE_POWER</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder><taborder>AD_NAME</taborder><taborder>AD_ID</taborder><taborder>sfqzq</taborder></root>" dj_sn="20100902193731453898" caption="�������޸�ִ������" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:7;listbox:0;textarea:0;combobox:10;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:31;hr:0;checkboxlist:0;radiolist:0;dropdownlist:4;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181546343920" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/vo.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/BusinessUnit.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=cf_aa colSpan=4 value=""></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">ִ������<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_image id=BU_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=123 controltype="text" field="BU_NAME" china="ִ������" dataset="addBusinessUnitDateset" onclick='bill_onclick("openOrgTree();")'><INPUT id=zfjt1 style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=6 controltype="text" field="BU_NAME" china="ִ������" dataset="addBusinessUnitDateset"><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 91px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=14 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 83px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=14 controltype="text"></TD>
                     <TD class=c2 width="15%">���<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=BU_BRIEF_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=27 name=Input32 controltype="text" field="BU_BRIEF_NAME" china="���" dataset="addBusinessUnitDateset"><INPUT id=jc style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="BU_BRIEF_NAME" china="���" dataset="addBusinessUnitDateset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">ִ�����<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=BU_BRIEF_CODE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=34 name=Input3 controltype="text" field="BU_BRIEF_CODE" china="ִ�����" dataset="addBusinessUnitDateset"><INPUT id=zfbh style="DISPLAY: none; LEFT: 0px; WIDTH: 35px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=6 controltype="text" field="BU_BRIEF_CODE" china="ִ�����" dataset="addBusinessUnitDateset"></TD>
                     <TD class=c2 width="15%">��λ����<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=BU_CODE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=31 name=Input2 controltype="text" field="BU_CODE" china="��Ԫ����" dataset="addBusinessUnitDateset"><INPUT id=dydm style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="BU_CODE" china="��Ԫ����" dataset="addBusinessUnitDateset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">���˴���</TD>
                     <TD width="35%"><INPUT class=input_out id=BU_LEGAL_PERSON style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=34 name=Input controltype="text" field="BU_LEGAL_PERSON" china="���˴���" dataset="addBusinessUnitDateset"><INPUT id=frdb style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="BU_LEGAL_PERSON" china="���˴���" dataset="addBusinessUnitDateset"></TD>
                     <TD class=c2 width="15%">��ҵ����<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><SELECT id=VC_ID style="LEFT: 0px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%BA%94%CC%A0%96Xr%94%BA%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%BA%AC%94%90%B6%A0%AC%AA%CC%94%AC%AA%B4%B6%A0%B6%B8%B6%AC%B2Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%BA%94%CC%AC%B2%96%98%B2" controltype="combobox" field="VC_ID" china="��ҵ����" dataset="addBusinessUnitDateset" tempvalue="-1" temptext="---��ѡ��---" sql check="1"><OPTION value=-1 selected>---��ѡ��---</OPTION></SELECT><INPUT id=hyfl style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="VC_ID" china="��ҵ����" dataset="addBusinessUnitDateset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��������<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_image id=AD_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=30 controltype="text" field="AD_NAME" china="������������" dataset="addBusinessUnitDateset" onclick='bill_onclick("openDivisionTree();")'><INPUT id=sfyx style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="BU_VALID" china="�Ƿ���Ч" dataset="addBusinessUnitDateset"><INPUT id=xzqh style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="AD_ID" china="��ҵ��������" dataset="addBusinessUnitDateset"><INPUT id=AD_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 28px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="AD_ID" china="��ҵ��������" dataset="addBusinessUnitDateset"></TD>
                     <TD class=c2 width="15%">�Ƿ����ǿ��Ȩ<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD><FIELDSET id=BU_COERCIVE_POWER contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 152px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="radio" field="BU_COERCIVE_POWER" china="ǿ��ִ��Ȩ" dataset="addBusinessUnitDateset" tempvalue="1&#13;&#10;0" temptext="��&#13;&#10;��" aspect="����" legend NotBg="��" value="0"><INPUT type=radio CHECKED value=1 name=RGBU_COERCIVE_POWER text="��"><SPAN onclick=RGBU_COERCIVE_POWER[0].checked=true;BU_COERCIVE_POWER.value=RGBU_COERCIVE_POWER[0].value;RGBU_COERCIVE_POWER[0].focus();>��</SPAN>&nbsp;<INPUT type=radio value=0 name=RGBU_COERCIVE_POWER text="��"><SPAN onclick=RGBU_COERCIVE_POWER[1].checked=true;BU_COERCIVE_POWER.value=RGBU_COERCIVE_POWER[1].value;RGBU_COERCIVE_POWER[1].focus();>��</SPAN>&nbsp;</FIELDSET></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��������</TD>
                     <TD width="85%" colSpan=3><TEXTAREA id=BU_LEGAL_BASIS style="LEFT: 0px; WIDTH: 85%; POSITION: static; TOP: 0px; HEIGHT: 103px" onmovestart=moveStart() cols=21 controltype="textarea" field="BU_LEGAL_BASIS" china="��������" dataset="addBusinessUnitDateset" value="textarea2" induce="��"></TEXTAREA><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;showLaw(${'BU_LEGAL_BASIS'})&quot;)">��ӷ��ɷ���</BUTTON><?xml:namespace prefix = fc /><fc:dataset id=addBusinessUnitDateset format="<fields><field><fieldname>BU_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_BRIEF_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>���</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_BRIEF_CODE</fieldname><datatype>�ַ�</datatype><displaylabel>ִ�����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_CODE</fieldname><datatype>�ַ�</datatype><displaylabel>��Ԫ����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_LEGAL_PERSON</fieldname><datatype>�ַ�</datatype><displaylabel>���˴���</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��ҵ����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��ҵ��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_VALID</fieldname><datatype>�ַ�</datatype><displaylabel>�Ƿ���Ч</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_COERCIVE_POWER</fieldname><datatype>�ַ�</datatype><displaylabel>ǿ��ִ��Ȩ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_LEGAL_BASIS</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_REMARK</fieldname><datatype>�ַ�</datatype><displaylabel>��ע</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>ִ������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>������������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ORG_ID</fieldname><datatype>�ַ�</datatype><displaylabel>������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><BU_ID></BU_ID><BU_BRIEF_NAME></BU_BRIEF_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_CODE></BU_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><AD_ID></AD_ID><BU_VALID></BU_VALID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><BU_LEGAL_BASIS></BU_LEGAL_BASIS><BU_REMARK></BU_REMARK><BU_NAME></BU_NAME><AD_NAME></AD_NAME><ORG_ID></ORG_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><BU_ID></BU_ID><BU_BRIEF_NAME></BU_BRIEF_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_CODE></BU_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><AD_ID></AD_ID><BU_VALID></BU_VALID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><BU_LEGAL_BASIS></BU_LEGAL_BASIS><BU_REMARK></BU_REMARK><BU_NAME></BU_NAME><AD_NAME></AD_NAME><ORG_ID></ORG_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><BU_ID></BU_ID><BU_BRIEF_NAME></BU_BRIEF_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_CODE></BU_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><AD_ID></AD_ID><BU_VALID></BU_VALID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><BU_LEGAL_BASIS></BU_LEGAL_BASIS><BU_REMARK></BU_REMARK><BU_NAME></BU_NAME><AD_NAME></AD_NAME><ORG_ID></ORG_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset><INPUT id=flyj style="DISPLAY: none; LEFT: 0px; WIDTH: 96px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=14 controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��ע</TD>
                     <TD width="85%" colSpan=3><TEXTAREA id=BU_REMARK style="LEFT: 0px; WIDTH: 85%; POSITION: static; TOP: 0px; HEIGHT: 103px" onmovestart=moveStart() cols=24 controltype="textarea" field="BU_REMARK" china="��ע" dataset="addBusinessUnitDateset" value="textarea2" induce="��"></TEXTAREA><INPUT id=bj style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="BU_REMARK" china="��ע" dataset="addBusinessUnitDateset"><INPUT id=sfqzq style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="BU_COERCIVE_POWER" china="ǿ��ִ��Ȩ" dataset="addBusinessUnitDateset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">�Ƿ���Ч<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%" colSpan=3><FIELDSET id=BU_VALID contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 152px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 24px" onmovestart=moveStart() controltype="radio" field="BU_VALID" china="�Ƿ���Ч" dataset="addBusinessUnitDateset" tempvalue="1&#13;&#10;0" temptext="��Ч&#13;&#10;��Ч" aspect="����" legend NotBg="��" value="1"><INPUT type=radio CHECKED value=1 name=RGBU_VALID text="��Ч"><SPAN onclick=RGBU_VALID[0].checked=true;BU_VALID.value=RGBU_VALID[0].value;RGBU_VALID[0].focus();>��Ч</SPAN>&nbsp;<INPUT type=radio value=0 name=RGBU_VALID text="��Ч"><SPAN onclick=RGBU_VALID[1].checked=true;BU_VALID.value=RGBU_VALID[1].value;RGBU_VALID[1].focus();>��Ч</SPAN>&nbsp;</FIELDSET></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("addOrUpdBusiness()")'>����</BUTTON><BUTTON class=button id=button4 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("CloseBill()")'>�ر�</BUTTON></TD>
      </TR>
      <TR>
         <TD align=right><BUTTON class=addbutton1 id=addLawUser style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("addLawUserLoad();")'>����</BUTTON><BUTTON class=sbutton1 id=delLawUser style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("delLawUserList()")'>ɾ��</BUTTON></TD>
      </TR>
      <TR>
         <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid4 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid4;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid4_retint = 0;
var ExtGrid4_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("lawUserDateset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid4_retint==0) ExtGrid4_retint = setInterval(ExtGrid4_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid4_retint);ExtGrid4_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("lawUserDateset"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid4 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid4',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('50%')))/100,
		split: true,
		region: 'north',
		title:'��ѯ����б�',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'��ǰ��ʾ�� {0} - {1} ������ {2} ��',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=ExtGrid4;
		grid.getStore().on('datachanged', function() {
		var hd_checker = grid.getEl().select('div.x-grid3-hd-checker');
		var hd = hd_checker.first();
		if(hd != null){ 
			hd.removeClass('x-grid3-hd-checker-on');
		}
});

/**
ʹ��˵��                      
1.ע�Ͳ�Ҫ�� //��
2.���Բ�����ǰGrid��sm��cm��store����
3.����Ĵ�������һЩ���Ի���������ĳ�е�ĳЩ�ض�������
**/
cm.setHidden(1,true);
cm.setHidden(4,true);
cm.setHidden(8,true);
grid.addListener('rowdblclick',updateLawUser);ExtGrid4.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid4',obj:ExtGrid4,dataset:'lawUserDateset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid4_onReady();window.onresize=function(){try{ExtGrid4.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY>
                  <TR>
                     <TD><INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="BU_ID" china="ִ������" dataset="addBusinessUnitDateset"><INPUT id=ORG_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ORG_ID" china="������" dataset="addBusinessUnitDateset"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<fc:dataset id=lawUserDateset showtypeXml="<root><showType><name>checkBox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>checkbox</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkbox%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkbox</fieldname><datatype>�ַ�</datatype><displaylabel>ѡ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkbox%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����Ա���</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_DOCUMENT_NO</fieldname><datatype>�ַ�</datatype><displaylabel>֤�����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_LICENCE</fieldname><datatype>�ַ�</datatype><displaylabel>��֤����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BWT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ�����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_CERTIFICATION_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>��֤����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_END_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>ʧЧ����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_STATUS</fieldname><datatype>�ַ�</datatype><displaylabel>״̬</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BWT_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>ִ���������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_REALNAME</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><BU_ID></BU_ID><BU_NAME></BU_NAME><BWT_NAME></BWT_NAME><USER_REALNAME></USER_REALNAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><BU_ID></BU_ID><BU_NAME></BU_NAME><BWT_NAME></BWT_NAME><USER_REALNAME></USER_REALNAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><BU_ID></BU_ID><BU_NAME></BU_NAME><BWT_NAME></BWT_NAME><USER_REALNAME></USER_REALNAME></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>