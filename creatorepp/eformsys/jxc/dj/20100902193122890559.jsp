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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/BusinessUnit.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/BusinessUnit.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');
adv_loadjsfile('/eformsys/fceform/css/luna/tab.css');
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
<%@page import="com.chinacreator.xzcf.baseservice.menu.OrgAccessUtil "%>
<%
OrgAccessUtil orgAccess = new OrgAccessUtil();
String idName = orgAccess.getLawOrgIdName(accesscontroler.getUserID());
String queryName = "";
if (!"1".equals(accesscontroler.getUserID())) {
    queryName = orgAccess.getBuIdByOrgIds(accesscontroler.getUserID()) ;
} 
String idTmp = "";
String nameTmp = "";
if("".equals(idName)){
    idTmp = "";
    nameTmp = "";
}else{
    String[] tmps = idName.split("_");
    idTmp = tmps[0];
    nameTmp = tmps[1];
}
%>
var buId=creator_getQueryString("BU_ID");
var user_id = getSysElement("userid");
var id = "" ;
var name = "" ;
var queryIds = "0";

//��ʼ���б�
function init(){
   $("BU_NAMES").readOnly = true ; //����ִ������ֻ��
   $("buNames").readOnly = true ; //����ִ������ֻ��
   $("buIds").value = "<%=idTmp %>";
   $("buNames").value = "<%=nameTmp %>";
   $("orgNames").value = $("buNames").value ;
   $("orgIds").value = $("buIds").value ;
   
   $("BU_ID").value = "<%=idTmp %>";
   $("BU_NAMES").value = "<%=nameTmp %>";
   $("orgNames").value = $("BU_NAMES").value ;
   $("orgIds").value = $("BU_ID").value ;

   lawUserQueryList();
   businessUnitQueryList();
}

//˫���޸�ִ��������Ϣ
function updateBusinessUnit(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var buId = row.get("bu_id");
    var buName = row.get("bu_name");
    var tempPara="dialogWidth:800px;dialogHeight:600px;";
    var tempURL="20100902193731453898.jsp?BU_ID="+buId+"&BU_NAME="+buName;
    //window.location.href(tempURL);
    showModalDialog(tempURL,"window",tempPara);
    reloadExtGrid();
}

//˫���޸�ִ����Ա��Ϣ
function updateLawUser(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var userId= row.get("user_id");
    var buId = row.get("bu_id");
    var buName = row.get("bu_name");
    var tempPara="dialogWidth:800px;dialogHeight:320px;";
    var tempURL="20100902194102000659.jsp?userId="+userId;
    tempURL += "&bu_id=" + buId + "&bu_name=" + buName;
    showModalDialog(tempURL,"window",tempPara);
    reloadExtGrid();
}

//��ѯִ��������Ϣ
function businessUnitQueryList(){
     if (user_id==1){
         queryIds = BusinessUnit.getAllBuIds();
     } else {
         queryIds = "<%=queryName%>";
     }
     if (queryIds=="") {
         queryIds="0";
     }
     var zfzt_Name = $("orgIds").value.trim();
     var zfzt_Id = $("BU_BRIEF_CODE").value.trim();
     var tmp = document.getElementsByName('radiobutton');
        if (tmp[0].checked) {
            cl_enable1 = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable1 = tmp[1].value ;
        } else {
            cl_enable1 = -1 ;
        } 
     var zfzt_Qz_IsNo = cl_enable1;   
     var tmp1 = document.getElementsByName('state');
        if (tmp1[0].checked) {
            cl_enable2 = tmp1[0].value ;
        } else if (tmp1[1].checked) {
            cl_enable2 = tmp1[1].value ;
        } else {
            cl_enable2 = -1 ;
        }
     var zfzt_Zt_IsNo = cl_enable2;
     var pagePrams= { 
          zfzt_Name:zfzt_Name,
          zfzt_Id:zfzt_Id,
          zfzt_Qz_IsNo:zfzt_Qz_IsNo,
          zfzt_Zt_IsNo:zfzt_Zt_IsNo,
          queryName:queryIds         
     }
    var sql = BusinessUnit.queryZfzt(pagePrams);
    businessUnitDataset.Open(sql);
    reloadExtGrid();
}

//��ѯִ����Ա��Ϣ
function lawUserQueryList(){
     if (user_id==1){
         queryIds = BusinessUnit.getAllBuIds();
     } else {
         queryIds = "<%=queryName%>";
     }
     if (queryIds=="") {
         queryIds="0";
     }
     var USER_REALNAME = $("USER_REALNAME").value.trim();
     var ELU_DOCUMENT_NO = $("ELU_DOCUMENT_NO").value.trim();
     var BU_NAMES = $("BU_ID").value.trim();
     var tmp = document.getElementsByName('zhuangtai');
        if (tmp[0].checked) {
            cl_enable1 = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable1 = tmp[1].value ;
        } else {
            cl_enable1 = -1 ;
        } 
     var state = cl_enable1;
     var ELU_CERTIFICATION_DATE = $("ELU_CERTIFICATION_DATE").value;
     var ELU_CERTIFICATION_DATE1 = $("ELU_CERTIFICATION_DATE1").value;
     validateTime();
     var Prams = { 
          USER_REALNAME:USER_REALNAME,
          ELU_DOCUMENT_NO:ELU_DOCUMENT_NO,
          BU_NAMES:BU_NAMES,
          state:state,
          ELU_CERTIFICATION_DATE:ELU_CERTIFICATION_DATE ,
          ELU_CERTIFICATION_DATE1:ELU_CERTIFICATION_DATE1 ,
          queryName:queryIds          
     }
     var sql = BusinessUnit.lawUser(Prams);
     dataset4.Open(sql);
     reloadExtGrid();
}

//��֤ʱ�����֤
function validateTime(){
    var ELU_CERTIFICATION_DATE = $("ELU_CERTIFICATION_DATE").value;
    var ELU_CERTIFICATION_DATE1 = $("ELU_CERTIFICATION_DATE1").value;
    if(!IsSpace(ELU_CERTIFICATION_DATE) && !IsSpace(ELU_CERTIFICATION_DATE1)){
        if(ELU_CERTIFICATION_DATE>ELU_CERTIFICATION_DATE1){
            alert("��֤��ʼ���ڲ��ܴ�����ֹ����");
            return false ;
        }
    }
}

//ִ��������Ϣ��ѯ����
function businessUnitReset(){
    $("buIds").value = "<%=idTmp %>";
    $("buNames").value = "<%=nameTmp %>";
    $("orgIds").value = "" ;
    $("orgNames").value = "" ;
    $("BU_BRIEF_CODE").value = "";
    var boxes = document.getElementsByName('radiobutton');
    boxes[2].checked = true;
    var box = document.getElementsByName('state');
    box[2].checked = true;
}

//ִ����Ա��Ϣ��ѯ����
function lawUserReset(){
     $("USER_REALNAME").value="";
     $("ELU_DOCUMENT_NO").value="";
     $("BU_ID").value = "<%=idTmp %>";
     $("BU_NAMES").value = "<%=nameTmp %>";
     $("state").value="";
     var boxes = document.getElementsByName('zhuangtai');
     boxes[0].checked = true;
     $("ELU_CERTIFICATION_DATE").value="";
     $("ELU_CERTIFICATION_DATE1").value="";
}

//ִ������������ת
function addBusinessUnitLoad(){
   var tempPara="dialogWidth:800px;dialogHeight:600px;";
   var tempURL="20100902193731453898.jsp";
   //window.location.href(tempURL);
   showModalDialog(tempURL,"window",tempPara);
   businessUnitQueryList();
}

//ִ������ɾ��
function delBusinessUnit(){
    var grid =  creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds("BU_ID", grid);
       if(ids.length==0){    
       alert("��ѡ��Ҫɾ���ļ�¼");
       return false;
    } else if (confirm('�Ƿ�Ҫɾ����ѡ����?')) {
       var rv = BusinessUnit.delBusinessUnit(ids);
       if(rv){
          alert("ɾ��������Ϣ�ɹ�");
       }else{
           alert("ִ�����屻���ò��ܽ���ɾ��");
       }
     reloadExtGrid();
    }
}

//��ִ�������ѡ��
function openOrgTree(){
    var url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourse.jsp";
    $("orgNames").value = $("buNames").value ;
    $("orgIds").value = $("buIds").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("buNames").value = $("orgNames").value ;
    $("buIds").value  = $("orgIds").value ;

}

//��ִ�������ѡ��
function openOrgTree1(){
    var url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourse.jsp";
    $("orgNames").value = $("BU_NAMES").value ;
    $("orgIds").value = $("BU_ID").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("BU_NAMES").value = $("orgNames").value ;
    $("BU_ID").value = $("orgIds").value ;

}

//ִ�����嵼��excel
function businessUnitExcel(){
    var title = "ִ��������Ϣ";//����
    var BU_NAME="ִ������";
    var BU_BRIEF_CODE="ִ�����";
    var BU_LEGAL_PERSON="���˴���";
    var BU_COERCIVE_POWER="�Ƿ����ǿ��Ȩ";
    var BU_VALID="�Ƿ���Ч";
    var AD_NAME="������������";
    var VC_NAME="��ҵ����";
    var id = "TipstaffMainBody";
    var Name = $("orgIds").value.trim();//ִ������
     var Ids = $("BU_BRIEF_CODE").value.trim();//ִ�����
     var tmp = document.getElementsByName('radiobutton');
        if (tmp[0].checked) {
            cl_enable1 = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable1 = tmp[1].value ;
        } else {
            cl_enable1 = -1 ;
        } 
     var IsNo = cl_enable1;//�Ƿ���Ч   
     var tmp1 = document.getElementsByName('state');
        if (tmp1[0].checked) {
            cl_enable2 = tmp1[0].value ;
        } else if (tmp1[1].checked) {
            cl_enable2 = tmp1[1].value ;
        } else {
            cl_enable2 = -1 ;
        }
     var ZT = cl_enable2;//״̬
      var queryName = queryIds ;
     var url="<%=request.getContextPath() %>/ccapp/app_xzcf/excel/jsp/poiCommond.jsp";
     url+="?title="+title+"&BU_NAME="+BU_NAME+"&BU_BRIEF_CODE="+BU_BRIEF_CODE+"&BU_LEGAL_PERSON="+BU_LEGAL_PERSON;
     url+="&BU_COERCIVE_POWER="+BU_COERCIVE_POWER+"&BU_VALID="+BU_VALID+"&AD_NAME="+AD_NAME+"&VC_NAME="+VC_NAME+"&id="+id; //ģ���id
     url+="&Name="+Name+"&Ids="+Ids+"&IsNo="+IsNo+"&ZT="+ZT+"&queryName="+queryName; //����
      window.location.href=url;
}


//ִ����Ա����excel
function lawUserExcel(){
    var title = "ִ����Ա��Ϣ";
    var ELU_DOCUMENT_NO="֤�����";
    var ELU_LICENCE="��֤����";
    var ELU_CERTIFICATION_DATE="��֤����";
    var ELU_END_DATE="ʧЧ����";
    var ELU_STATUS="״̬";
    var USER_REALNAME="����";
    var BWT_NAME="ִ�����";
    var BU_NAME="ִ����������";

    //���ϼ�����������ģ����ֶ�ͷһ��
    var id = "TipstaffPeople";
    //�����idΪ�����ļ���Ӧ��
     var user_Name = $("USER_REALNAME").value.trim();
     var elu_No = $("ELU_DOCUMENT_NO").value.trim();
     var bu_name = $("BU_ID").value.trim();
     var tmp = document.getElementsByName('zhuangtai');
        if (tmp[0].checked) {
            cl_enable1 = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable1 = tmp[1].value ;
        } else {
            cl_enable1 = -1 ;
        } 
     var elu_Status = cl_enable1;
     var begin_Time = $("ELU_CERTIFICATION_DATE").value;
     var end_Time = $("ELU_CERTIFICATION_DATE1").value;
     var queryName = queryIds ;

  var url="<%=request.getContextPath() %>/ccapp/app_xzcf/excel/jsp/poiCommond.jsp";
  url+="?title="+title+"&ELU_DOCUMENT_NO="+ELU_DOCUMENT_NO+"&ELU_LICENCE="+ELU_LICENCE ;
  url+="&ELU_CERTIFICATION_DATE="+ELU_CERTIFICATION_DATE+"&ELU_END_DATE="+ELU_END_DATE ;
  url+="&ELU_STATUS="+ELU_STATUS+"&USER_REALNAME="+USER_REALNAME+"&BWT_NAME="+BWT_NAME ;
  url+="&BU_NAME="+BU_NAME+"&id="+id ;
  url+="&user_Name="+user_Name+"&elu_No="+elu_No+"&bu_name="+bu_name+"&elu_Status="+elu_Status;
  url+="&begin_Time="+begin_Time+"&end_Time="+end_Time+"&queryName="+queryName ;
  window.location.href=url;
}

</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><tab><id>tab3</id></tab><button><id>button3</id><id>button4</id><id>button5</id><id>button6</id><id>button7</id><id>button9</id><id>button10</id><id>button13</id></button><text><id>buNames</id><id>buIds</id><id>BU_BRIEF_CODE</id><id>orgNames</id><id>orgIds</id><id>USER_REALNAME</id><id>ELU_DOCUMENT_NO</id><id>BU_NAMES</id><id>BU_ID</id><id>ELU_CERTIFICATION_DATE</id><id>ELU_CERTIFICATION_DATE1</id></text><dataset><id>businessUnitDataset</id><id>dataset4</id></dataset><ExtGrid><id>ExtGrid1</id><id>ExtGrid</id></ExtGrid></root>" billtaborder="<root><taborder>buNames</taborder><taborder>BU_BRIEF_CODE</taborder><taborder>button3</taborder><taborder>button4</taborder><taborder>button5</taborder><taborder>button6</taborder><taborder>button7</taborder><taborder>USER_REALNAME</taborder><taborder>ELU_DOCUMENT_NO</taborder><taborder>BU_NAMES</taborder><taborder>ELU_CERTIFICATION_DATE</taborder><taborder>ELU_CERTIFICATION_DATE1</taborder><taborder>button9</taborder><taborder>button10</taborder><taborder>button13</taborder><taborder>BU_ID</taborder><taborder>buIds</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder></root>" dj_sn="20100902193122890559" caption="ִ��������Ϣ" mkbh codeheader="BBB" entertype="չ��" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:5;listbox:0;textarea:0;combobox:2;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:8;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:7;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:6;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181546343920" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/vo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/BusinessUnit.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js" creator_allTab="<tabs><tab><id>tab3</id><content><index>0</index><gridid></gridid><iframeid></iframeid><index>1</index><gridid></gridid><iframeid></iframeid></content></tab></tabs>">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD><DIV class=tab-pane id=tab3 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 600px" showtype="luna" IsHideTitle="��"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 582px"><H2 class=tab>ִ��������Ϣ</H2>
                  <TABLE height="100%" width="100%" border=0>
                     <TBODY>
                        <TR>
                           <TD>
                              <TABLE class=CTable cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
                                 <TBODY>
                                    <TR>
                                       <TD class=taobox align=left colSpan=4>ִ��������Ϣ��ѯ</TD>
                                       <TR>
                                          <TD class=c2 align=right width="15%">ִ������</TD>
                                          <TD width="35%"><INPUT class=input_image id=buNames style="LEFT: 0px; WIDTH: 228px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=39 name=Input controltype="text" onclick='bill_onclick("openOrgTree();")'><INPUT id=buIds style="DISPLAY: none; LEFT: 0px; WIDTH: 53px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=4 controltype="text"></TD>
                                          <TD class=c2 align=right width="15%">ִ�����</TD>
                                          <TD><INPUT class=input_out id=BU_BRIEF_CODE style="LEFT: 0px; WIDTH: 228px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=39 name=Input2 controltype="text"></TD>
                                       </TR>
                                       <TR>
                                          <TD class=c2 align=right width="15%">�Ƿ����ǿ��Ȩ</TD>
                                          <TD width="35%"><INPUT type=radio value=1 name=radiobutton>��<INPUT type=radio CHECKED value=0 name=radiobutton>��<INPUT type=radio value=-1 name=radiobutton>ȫ��</TD>
                                          <TD class=c2 align=right width="15%">״̬</TD>
                                          <TD><INPUT type=radio CHECKED value=1 name=state>��Ч<INPUT type=radio value=0 name=state>��Ч<INPUT type=radio value=-1 name=state>ȫ��</TD>
                                       </TR>
                                       <TR>
                                          <TD align=middle colSpan=4><BUTTON class=button id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("businessUnitQueryList()")'>��ѯ</BUTTON><BUTTON class=button id=button4 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("businessUnitReset()")'>����</BUTTON><BUTTON class=button id=button5 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("businessUnitExcel();")'>����excel</BUTTON><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 96px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=15 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 87px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=15 controltype="text"></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR height=32>
                              <TD align=right><BUTTON class=addbutton1 id=button6 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("addBusinessUnitLoad()")'>����</BUTTON>&nbsp;<BUTTON class=sbutton1 id=button7 style="LEFT: 786px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("delBusinessUnit()")'>ɾ��</BUTTON></TD>
                           </TR>
                           <TR>
                              <TD>&nbsp;<IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("businessUnitDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("businessUnitDataset"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid1 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid1',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('60%')))/100,
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
    var grid=ExtGrid1;
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
cm.setHidden(4,true);
cm.setHidden(6,true);
cm.setHidden(7,true);
cm.setHidden(9,true);
grid.addListener('rowdblclick',updateBusinessUnit);ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'businessUnitDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();window.onresize=function(){try{ExtGrid1.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                     <TABLE style="WIDTH: 100%; POSITION: static" cellSpacing=0 cellPadding=0 width=100 align=left border=0>
                        <TBODY>
                           <TR>
                              <TD><?xml:namespace prefix = fc /><fc:dataset id=businessUnitDataset showtypeXml="<root><showType><name>checkbox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkbox</fieldname><datatype>�ַ�</datatype><displaylabel>ѡ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>ִ������</displaylabel><size>150</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_BRIEF_CODE</fieldname><datatype>�ַ�</datatype><displaylabel>ִ�����</displaylabel><size>4</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_LEGAL_PERSON</fieldname><datatype>�ַ�</datatype><displaylabel>���˴���</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��ҵ����</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_COERCIVE_POWER</fieldname><datatype>�ַ�</datatype><displaylabel>�Ƿ����ǿ��Ȩ</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>count_people</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_VALID</fieldname><datatype>�ַ�</datatype><displaylabel>�Ƿ���Ч</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>bu_id</fieldname><datatype>����</datatype><displaylabel>ִ������ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>������������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>��ҵ����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_YY</fieldname><datatype>�ַ�</datatype><displaylabel>�Ƿ�����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkbox></checkbox><BU_NAME></BU_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><AD_ID></AD_ID><count_people></count_people><BU_VALID></BU_VALID><bu_id></bu_id><AD_NAME></AD_NAME><VC_NAME></VC_NAME><BU_YY></BU_YY></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkbox></checkbox><BU_NAME></BU_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><AD_ID></AD_ID><count_people></count_people><BU_VALID></BU_VALID><bu_id></bu_id><AD_NAME></AD_NAME><VC_NAME></VC_NAME><BU_YY></BU_YY></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkbox></checkbox><BU_NAME></BU_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><AD_ID></AD_ID><count_people></count_people><BU_VALID></BU_VALID><bu_id></bu_id><AD_NAME></AD_NAME><VC_NAME></VC_NAME><BU_YY></BU_YY></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset></TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </DIV>
                  <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 582px">
                     <H2 class=tab>ִ����Ա��Ϣ</H2>
                     <TABLE height="100%" width="100%" border=0>
                        <TBODY>
                           <TR>
                              <TD height=130>
                                 <TABLE class=CTable cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
                                    <TBODY>
                                       <TR>
                                          <TD class=taobox colSpan=6>ִ����Ա��Ϣ��ѯ</TD>
                                       </TR>
                                       <TR>
                                          <TD class=c2 align=right width="13%">����</TD>
                                          <TD align=left width="20%"><INPUT id=USER_REALNAME style="LEFT: 0px; WIDTH: 147px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=26 name=Input2 controltype="text"></TD>
                                          <TD class=c2 align=right width="13%">֤�����</TD>
                                          <TD width="20%"><INPUT id=ELU_DOCUMENT_NO style="LEFT: 0px; WIDTH: 147px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=26 name=Input2 controltype="text"></TD>
                                          <TD class=c2 align=right width="13%">����ִ������</TD>
                                          <TD><INPUT id=BU_NAMES style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=27 name=Input2 controltype="text" onclick='bill_onclick("openOrgTree1();")'><INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=8 controltype="text"></TD>
                                       </TR>
                                       <TR>
                                          <TD class=c2 align=right width="13%">״̬</TD>
                                          <TD align=left width="20%"><INPUT type=radio CHECKED value=1 name=zhuangtai>��Ч<INPUT type=radio value=0 name=zhuangtai>��Ч<INPUT type=radio value=-1 name=zhuangtai>ȫ��</TD>
                                          <TD class=c2 align=right width="13%">��֤����</TD>
                                          <TD colSpan=3><INPUT class=its_out id=ELU_CERTIFICATION_DATE style="LEFT: 0px; WIDTH: 146px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=24 name=Input2 controltype="text" onclick='bill_onclick("SelectDate()")'>��<INPUT class=its_out id=ELU_CERTIFICATION_DATE1 style="LEFT: 0px; WIDTH: 148px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=26 name=Input2 controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                                       </TR>
                                       <TR>
                                          <TD align=middle colSpan=6>&nbsp;<BUTTON class=button id=button9 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("lawUserQueryList()")'>��ѯ</BUTTON><BUTTON class=button id=button10 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("lawUserReset()")'>����</BUTTON><BUTTON class=button id=button13 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("lawUserExcel();")'>����excel</BUTTON></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR>
                              <TD>&nbsp;<IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid_retint = 0;
var ExtGrid_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("dataset4");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid_retint==0) ExtGrid_retint = setInterval(ExtGrid_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid_retint);ExtGrid_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("dataset4"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid = new Ext.grid.GridPanel({
		el: 'div_ExtGrid',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('60%')))/100,
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
    var grid=ExtGrid;
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
grid.addListener('rowdblclick',updateLawUser);ExtGrid.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid',obj:ExtGrid,dataset:'dataset4',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid_onReady();window.onresize=function(){try{ExtGrid.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                     <fc:dataset id=dataset4 showtypeXml="<root><showType><name>checkBox</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkBox%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType><showType><name>checkec</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkec%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType><showType><name>a</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27a%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType><showType><name>checkbox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkbox</fieldname><datatype>�ַ�</datatype><displaylabel>ѡ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����Ա���</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_DOCUMENT_NO</fieldname><datatype>�ַ�</datatype><displaylabel>֤�����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_LICENCE</fieldname><datatype>�ַ�</datatype><displaylabel>��֤����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BWT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ�����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_CERTIFICATION_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>��֤����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_END_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>ʧЧ����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_STATUS</fieldname><datatype>�ַ�</datatype><displaylabel>״̬</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_REALNAME</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BWT_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>ִ�����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><USER_REALNAME></USER_REALNAME><BWT_NAME></BWT_NAME><BU_NAME></BU_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><USER_REALNAME></USER_REALNAME><BWT_NAME></BWT_NAME><BU_NAME></BU_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><USER_REALNAME></USER_REALNAME><BWT_NAME></BWT_NAME><BU_NAME></BU_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="��"></fc:dataset>
                  </DIV>
               </DIV>
               <SCRIPT>var tab3 = new WebFXTabPane( document.getElementById( "tab3" ) );</SCRIPT>
               <TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width=760 align=left border=0>
                  <TBODY>
                     <TR>
                        <TD></TD>
                     </TR>
                  </TBODY>
               </TABLE>
               &nbsp;&nbsp;&nbsp;
            </TD>
         </TR>
         <TR></TR>
      </TBODY>
   </TABLE>
</TR>
</TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>