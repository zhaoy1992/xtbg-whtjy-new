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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Diagnoses.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Diagnoses.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/DiagnosesDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/DiagnosesDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/EvidenceList.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/EvidenceList.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/EvidenceListDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/EvidenceListDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
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
var wft_id =creator_getQueryString("wft_id"); //Υ��ʵ��ID
var pi_id =creator_getQueryString("pi_id"); //����ID
var ndp_id =creator_getQueryString("ndp_id"); //��ǰ�׶�ID
var bu_id =creator_getQueryString("bu_id"); //ִ������ID
var bu_name =creator_getQueryString("bu_name"); //ִ����������
var user_id = getSysElement("userid");
//var readOnlyFlag =creator_getQueryString("readOnlyFlag"); // �Ƿ�ֻ��
var readOnlyFlag = "" ;
var flags =creator_getQueryString("eflag");
if(IsSpace(wft_id)){
    var wft_id = 907 ;  
}
function init(){
    findEvidenceList();
    commandBut2() ;
}


//��ѯ��������ʵ������Ӧ��֤����Ϣ�б���
function findEvidenceList(){
    var sql = EvidenceList.findEvidenceList(wft_id);
    dataset1.Open(sql);
}

//����֤�ݰ�ť����
function openNewProof(){
    var tempPara="dialogWidth:800px;dialogHeight:300px;";
    var tempURL="20100928171808109374.jsp?wft_id="+wft_id+"&pi_id="+pi_id+"&ndp_id="+ndp_id+"&bu_id="+bu_id+"&bu_name="+bu_name+"&readOnlyFlag="+readOnlyFlag ; 
    showModalDialog(tempURL,"window",tempPara);
    reloadExtGrid();

}

//ɾ��ѡ��֤�ݰ�ť����
function deleteProof(){
    var grid =  creator_pt_grids[0].obj;
    var rows = grid.getSelectionModel().getSelections();
        var ids = new Array();
        for(var i=0;i<rows.length;i++){
           var el_id = rows[i].get("el_id");
           ids[ids.length] = el_id ;                     
        }
        if(ids.length==0){    
           alert("��ѡ��Ҫɾ���ļ�¼��");
           return false;
        }else{
           var rv = EvidenceList.delEvidenceList(ids);
           if(rv){
              alert("ɾ��������Ϣ�ɹ���");
           }else{
               alert("ɾ��������Ϣʧ�ܣ�");
           }
        }
     reloadExtGrid();

}

//˫���޸�֤����Ϣ����
function updateLoadProof(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var el_id= row.get("el_id");
    var tempPara="dialogWidth:800px;dialogHeight:300px;";
    var tempURL="20100928171808109374.jsp?WFT_ID="+wft_id+"&EL_ID="+el_id;
    showModalDialog(tempURL,"window",tempPara);
    reloadExtGrid();
}

//���ƽ���Ԫ�ص���ʾ(�׶����Ե���ȡ֤)
function commandBut2(){
    if(flags==0){  //�Ӳ˵���ȥ
       var num = Diagnoses.findCountNum1Biz(wft_id);//�жϸõ���ȡ֤�׶��Ƿ����ύ
        /*if(num>0){//����ȡ֤���ύ
             $("button2").style.display = "none" ;
           var num3 = Diagnoses.findPurviewByWftIdBiz(wft_id);//�ж����ɴ��������Ƿ��Ѿ��ύ
             if(num3 > 0){//���ɴ��������Ѿ��ύ�������ذ�ť֮��ȫ��Ӱ��
                  //��ǰ����ֻ����ֻ���·��ذ�ť���Բ���
                $("button1").style.display = "none" ;
                readOnlyFlag = "readOnly";
                $("read_only").value = readOnlyFlag;
            }
       }*/
       var num1 = Diagnoses.findCountNumBiz(wft_id);//�ж�������֮�����ȡ֤֮ǰ
             if(num1>0){
              num4 = Diagnoses.findCountBYLABiz(wft_id);//�ж��Ƿ��ǲ�������������
                if(num4>0){
                    //��ǰ����ֻ����ֻ���·��ذ�ť���Բ���
                       $("button1").style.display = "none" ;
                    $("button2").style.display = "none" ;
                    readOnlyFlag = "readOnly";
                    $("read_only").value = readOnlyFlag ;
              }
          }else{
                 var num = Diagnoses.findCountNum1Biz(wft_id);//�жϸõ���ȡ֤�׶��Ƿ����ύ
                    if(num>0){//����ȡ֤���ύ
                        $("button2").style.display = "none" ;
                        var num3 = Diagnoses.findPurviewByWftIdBiz(wft_id);//�ж����ɴ��������Ƿ��Ѿ��ύ
                        if(num3 > 0){//���ɴ��������Ѿ��ύ�������ذ�ť֮��ȫ��Ӱ��
                            //��ǰ����ֻ����ֻ���·��ذ�ť���Բ���
                            $("button1").style.display = "none" ;
                         readOnlyFlag = "readOnly";
                         $("read_only").value = readOnlyFlag ;
                     }else{//����ȡ֤֮�����ɴ�������֮ǰ
                             var num = Diagnoses.findCountBYCFBiz(wft_id);
                          if(num>0){//�������״̬�ǳ������Ͳ��账��״̬
                                   //��ǰ����ֻ����ֻ���·��ذ�ť���Բ���
                                    $("button1").style.display = "none" ;
                                $("button2").style.display = "none" ;
                                readOnlyFlag = "readOnly";
                                $("read_only").value =readOnlyFlag;
                          }else{
                                $("button2").style.display = "none" ;
                          }
                     }       
                  }
             }
    }else { //�Ӿ��ڽ�ȥ
        var num2 = Diagnoses.findPurviewByUserIdAndPiIdBiz(user_id,pi_id);//�жϵ�ǰ�û��Ƿ�߱����ʵ���ȡ֤��Ȩ��
         if(num2>0){//�����ǰ�û���Ȩ��
             var num1 = Diagnoses.findCountNumBiz(wft_id);//�ж�������֮�����ȡ֤֮ǰ
             if(num1>0){
              num4 = Diagnoses.findCountBYLABiz(wft_id);//�ж��Ƿ��ǲ�������������
                if(num4>0){
                    //��ǰ����ֻ����ֻ���·��ذ�ť���Բ���
                       $("button1").style.display = "none" ;
                    $("button2").style.display = "none" ;
                    readOnlyFlag = "readOnly";
                    $("read_only").value = readOnlyFlag ;
              }
          }else{
                 var num = Diagnoses.findCountNum1Biz(wft_id);//�жϸõ���ȡ֤�׶��Ƿ����ύ
                    if(num>0){//����ȡ֤���ύ
                        $("button2").style.display = "none" ;
                        var num3 = Diagnoses.findPurviewByWftIdBiz(wft_id);//�ж����ɴ��������Ƿ��Ѿ��ύ
                        if(num3 > 0){//���ɴ��������Ѿ��ύ�������ذ�ť֮��ȫ��Ӱ��
                            //��ǰ����ֻ����ֻ���·��ذ�ť���Բ���
                            $("button1").style.display = "none" ;
                         readOnlyFlag = "readOnly";
                         $("read_only").value = readOnlyFlag ;
                     }else{//����ȡ֤֮�����ɴ�������֮ǰ
                             var num = Diagnoses.findCountBYCFBiz(wft_id);
                          if(num>0){//�������״̬�ǳ������Ͳ��账��״̬
                                   //��ǰ����ֻ����ֻ���·��ذ�ť���Բ���
                                    $("button1").style.display = "none" ;
                                $("button2").style.display = "none" ;
                                readOnlyFlag = "readOnly";
                                $("read_only").value =readOnlyFlag;
                          }else{
                                $("button2").style.display = "none" ;
                          }
                     }       
                  }
             }
        }else{
            //��ǰ����ֻ����ֻ���·��ذ�ť���Բ���
             $("button1").style.display = "none" ;
            $("button2").style.display = "none" ;
            readOnlyFlag = "readOnly";
            $("read_only").value = readOnlyFlag ;
        }

    }   
}

</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><button><id>button1</id><id>button2</id></button><text><id>read_only</id></text><dataset><id>dataset1</id></dataset><ExtGrid><id>ExtGrid8</id></ExtGrid></root>" billtaborder="<root><taborder>button1</taborder><taborder>button2</taborder><taborder>read_only</taborder></root>" dj_sn="20100928144328000151" caption="֤����Ϣ" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:10;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Diagnoses.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/DiagnosesDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/EvidenceList.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/EvidenceListDao.js&#13;&#10;">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox width="50%">֤����Ϣ</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD colSpan=2><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid8 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid8;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid8_retint = 0;
var ExtGrid8_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("dataset1");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid8_retint==0) ExtGrid8_retint = setInterval(ExtGrid8_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid8_retint);ExtGrid8_retint = null ;var pagesize =5;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("dataset1"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid8 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid8',        store: store,
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
    var grid=ExtGrid8;
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
//cm.setHidden(1,true);
//cm.setHidden(4,true);
//cm.setHidden(8,true);
grid.addListener('rowdblclick',updateLoadProof);ExtGrid8.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid8',obj:ExtGrid8,dataset:'dataset1',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid8_onReady();window.onresize=function(){try{ExtGrid8.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
      </TR>
      <TR>
         <TD align=middle colSpan=2><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("openNewProof()")'>�ϴ���֤��</BUTTON><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("deleteProof()")'>ɾ��ѡ��֤��</BUTTON><INPUT id=read_only style="DISPLAY: none; LEFT: 0px; WIDTH: 1%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
      </TR>
      <TR>
         <TD align=left colSpan=2>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY>
                  <TR>
                     <TD></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <?xml:namespace prefix = fc />
      <fc:dataset id=dataset1 showtypeXml="<root><showType><name>checkBox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>checkbox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="<root><columnWidth1><name>checkbox</name><columnWidth2>10</columnWidth2></columnWidth1><columnWidth1><name>EL_ACQUISITION_TIME</name><columnWidth2>50</columnWidth2></columnWidth1><columnWidth1><name>EL_DESCRIPTION</name><columnWidth2>50</columnWidth2></columnWidth1><columnWidth1><name>EL_ID</name><columnWidth2>50</columnWidth2></columnWidth1><columnWidth1><name>mt_name</name><columnWidth2>50</columnWidth2></columnWidth1></root>" format="<fields><field><fieldname>checkbox</fieldname><datatype>�ַ�</datatype><displaylabel>ѡ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10</columnWidth2></columnWidth1></field><field><fieldname>mt_name</fieldname><datatype>�ַ�</datatype><displaylabel>֤������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>50</columnWidth2></columnWidth1></field><field><fieldname>EL_ACQUISITION_TIME</fieldname><datatype>�ַ�</datatype><displaylabel>����ȡ֤ʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>50</columnWidth2></columnWidth1></field><field><fieldname>EL_DESCRIPTION</fieldname><datatype>�ַ�</datatype><displaylabel>֤������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>50</columnWidth2></columnWidth1></field><field><fieldname>EL_ID</fieldname><datatype>�ַ�</datatype><displaylabel>֤�ݱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>50</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkbox></checkbox><mt_name></mt_name><EL_ACQUISITION_TIME></EL_ACQUISITION_TIME><EL_DESCRIPTION></EL_DESCRIPTION><EL_ID></EL_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkbox></checkbox><mt_name></mt_name><EL_ACQUISITION_TIME></EL_ACQUISITION_TIME><EL_DESCRIPTION></EL_DESCRIPTION><EL_ID></EL_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkbox></checkbox><mt_name></mt_name><EL_ACQUISITION_TIME></EL_ACQUISITION_TIME><EL_DESCRIPTION></EL_DESCRIPTION><EL_ID></EL_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>