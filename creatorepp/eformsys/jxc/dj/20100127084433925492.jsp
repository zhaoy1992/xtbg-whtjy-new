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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcopendj.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcopendj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcselfuse.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcselfuse.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcother.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcother.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:webgrid","behavior: url(../../fceform/htc/webgrid.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:fc_code","behavior: url(../../fceform/htc/fc_code.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcwebgrid.js');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
/*added by zhou.luo in 2008-10-03
���Զ������ɵı���Ҫ�õ��ĺ��������ڲ�ѯ
*/
function creator_query(obj_ds){
    var texts = document.all;
    var condition = "";
    for(var i = 0;i < texts.length;i++){
        if(texts[i].id.substring(0,8)=='cc_text_'){
            var fieldtype = texts[i].id.substring(8,9);
            var fieldname = texts[i].id.substring(10);
            if(texts[i].value.trim().length > 0){       
                var op = " = '";
                var end = "'";
                if(fieldtype=='s'){
                    op = " like '%";
                    end = "%'";    
                }else if(fieldtype=='i'){
                    op = " = ";
                    end = "";
                }
                var temp = fieldname + op + texts[i].value + end; 
                if(condition.length <= 1){
                    condition +=temp;
                }else{
                    condition+=" and "+ temp;
                }    
            }
        } 
    }
    var sql = "";
    if(obj_ds.ccTempSql==undefined){
        obj_ds.ccTempSql = obj_ds.opensql;
    }
    sql = obj_ds.ccTempSql;
    if(!IsSpace(sql) && condition.length > 1){
        if( sql.indexOf(" where ") > 0){
            sql += " and " + condition;
        }else {
            sql += " where " + condition;
        }
    }
    //alert(sql);
    obj_ds.Open(sql);
}
/*added by zhou.luo in 2008-10-03
���Զ������ɵı���Ҫ�õ��ĺ��������ڴ���ϸҳ�档���������޸ģ�չ������
*/
function creator_opendj(djid,obj_ds,optype,title){
    DjOpen(djid,obj_ds,optype,'��ģʽ����','ֱ��',title);
    obj_ds.Open(obj_ds.opensql);
}
/*added by zhou.luo in 2008-10-04
����ѯ�ֶε�����
*/
function creator_reset(){
     var texts = document.all;
     var condition = "";
     for(var i = 0;i < texts.length;i++){
         if(texts[i].id.substring(0,8)=='cc_text_'){
             texts[i].value = "";
         }
     }
}

</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();" contxml="<root><label><id>cc_label_s_XB</id><id>cc_label_s_XM</id><id>cc_label_s_STU_ID</id></label><div><id>div4</id><id>div5</id><id>div7</id></div><button><id>button8</id><id>button9</id><id>button5</id><id>button6</id><id>button7</id></button><text><id>cc_text_s_XB</id><id>cc_text_s_XM</id><id>cc_text_s_STU_ID</id></text><grid><id>grid10</id></grid><dataset><id>dataset1</id></dataset></root>" billtaborder="<root><taborder>button5</taborder><taborder>button6</taborder><taborder>button7</taborder><taborder>grid10</taborder><taborder>button8</taborder><taborder>button9</taborder><taborder>cc_text_s_XB</taborder><taborder>cc_text_s_XM</taborder><taborder>cc_text_s_STU_ID</taborder></root>" dj_sn="20100127084433925492" caption="�Զ����ɲ���" mkbh codeheader="BBB" entertype="�޸�" poswidth="800" posheight="600" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:2;SKBILLgrid:0;shape:0;tab:0;div:7;DsMain_field:0;a:0;button:7;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:10;dataset:4;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" version="1.0" creator_pagination="grid10,dataset1,10;" type="ZW" creatorType="20091219104852735215" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js" center="����">

&nbsp;

<DIV id=div4 style="BORDER-RIGHT: black 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: black 1px solid; OVERFLOW-Y: hidden; PADDING-LEFT: 10px; LEFT: 190px; OVERFLOW-X: hidden; PADDING-BOTTOM: 10px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 700px; PADDING-TOP: 10px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 69px; HEIGHT: 195px; BACKGROUND-COLOR: #ebeae8" onmovestart=moveStart() ; controltype="div" NotBg="��" 196px? HEIGHT:>
   <TABLE width="100%">
      <CAPTION>�Զ����ɲ���</CAPTION>
      <TBODY>
         <TR>
            <TD><DIV id=cc_label_s_XB style="LEFT: 32px; WIDTH: 65px; POSITION: static; TOP: 49px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label1">XB</DIV></TD>
            <TD><INPUT id=cc_text_s_XB style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
            <TD><DIV id=cc_label_s_XM style="LEFT: 32px; WIDTH: 65px; POSITION: static; TOP: 49px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label1">XM</DIV></TD>
            <TD><INPUT id=cc_text_s_XM style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
         </TR>
         <TR>
            <TD><DIV id=cc_label_s_STU_ID style="LEFT: 32px; WIDTH: 65px; POSITION: static; TOP: 49px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label1">STU_ID</DIV></TD>
            <TD><INPUT id=cc_text_s_STU_ID style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
            <TD></TD>
            <TD></TD>
         </TR>
      </TBODY>
   </TABLE>
   <BUTTON id=button8 style="LEFT: 365px; WIDTH: 86px; POSITION: absolute; TOP: 140px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("creator_reset()")'>����</BUTTON>
   <BUTTON id=button9 style="LEFT: 234px; WIDTH: 86px; POSITION: absolute; TOP: 140px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("creator_query(dataset1)")'>��ѯ</BUTTON>
</DIV>

<DIV id=div5 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; OVERFLOW-Y: hidden; LEFT: 190px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 700px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 266px; HEIGHT: 437px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">
   <BUTTON id=button5 style="LEFT: 446px; WIDTH: 75px; POSITION: absolute; TOP: 1px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;creator_opendj('20100127084433926207',dataset1,'����','��Ӽ�¼')&quot;)">����</BUTTON>
   &nbsp;
</DIV>

<DIV id=div7 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 192px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 689px; BORDER-BOTTOM: 0px; POSITION: absolute; TOP: 302px; HEIGHT: 392px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">&nbsp;
   <DIV style="LEFT: 233px; WIDTH: 300px; POSITION: absolute; TOP: 295px; HEIGHT: 50px" name="Ctrlgrid10">
      <INPUT id=firstpagegrid10 onclick="buttonevent('grid10','firstpage')" type=button value=��ҳ>
      <INPUT id=prevpagegrid10 onclick="buttonevent('grid10','prevpage')" type=button value=��һҳ>
      <INPUT id=nextpagegrid10 onclick="buttonevent('grid10','nextpage')" type=button value=��һҳ>
      <INPUT id=lastpagegrid10 onclick="buttonevent('grid10','lastpage')" type=button value=βҳ>
      <BUTTON style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none; BACKGROUND-COLOR: #ffffff" value="" ?>
         <DIV id=pageInfogrid10></DIV>
      </BUTTON>
   </DIV>
   <?xml:namespace prefix = fc />
   <fc:webgrid id=grid10 onkeydown='bill_ongridkeydown("<grid10><col></col><col></col><col></col><col></col><col></col></grid10>")' ondblclick='bill_ongriddblclick("<grid10><col></col><col></col><col></col><col></col><col></col></grid10>")' onclick='bill_ongridclick("<grid10><col></col><col></col><col></col><col></col><col></col></grid10>")' top="34" width="692px" height="239" format="<cols><col><fname>REMARK</fname><cname>REMARK</cname><width>200</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>SCORE</fname><cname>SCORE</cname><width>22</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>STU_ID</fname><cname>STU_ID</cname><width>20</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>XB</fname><cname>XB</cname><width>10</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>XM</fname><cname>XM</cname><width>30</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col></cols>" dataset="dataset1" visible="��" canselect="��" autoheight="��" autowidth="��" autoappend="��" readonly="��" SetRowHeight="��" hideVscroll="��" hideHscroll="��" autosize="��" bodyrowheight="-1" bodyrows="-1" left="0" ParentPos="���">
      <TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=1 width="100%" frame=box>
         <TBODY>
            <TR class=fcGridFirstRow>
               <TD></TD>
            </TR>
         </TBODY>
      </TABLE>
   </fc:webgrid>
</DIV>

<BUTTON id=button6 style="LEFT: 712px; WIDTH: 75px; POSITION: absolute; TOP: 268px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;creator_opendj('20100127084433926207',dataset1,'�޸�','�޸ļ�¼')&quot;)">�޸�</BUTTON>

<BUTTON id=button7 style="LEFT: 789px; WIDTH: 75px; POSITION: absolute; TOP: 268px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("DelGridRow(dataset1)")'>ɾ��</BUTTON>

<fc:dataset id=dataset1 format="<fields><field><fieldname>REMARK</fieldname><datatype>�ַ�</datatype><displaylabel>REMARK</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SCORE</fieldname><datatype>�ַ�</datatype><displaylabel>SCORE</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>STU_ID</fieldname><datatype>�ַ�</datatype><displaylabel>STU_ID</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XB</fieldname><datatype>�ַ�</datatype><displaylabel>XB</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XM</fieldname><datatype>�ַ�</datatype><displaylabel>XM</displaylabel><size>30</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" sqltrans="%F4%D8%E6%D8%D4%F6XrnbXrn%DA%F2%EC%E8Xrn%F6%D0%CC%D6%F8%D0%EA" onSetText='bill_ondatasetsettext("<dsid><REMARK></REMARK><SCORE></SCORE><STU_ID></STU_ID><XB></XB><XM></XM></dsid>")' onGetText='bill_ondatasetgettext("<dsid><REMARK></REMARK><SCORE></SCORE><STU_ID></STU_ID><XB></XB><XM></XM></dsid>")' onValid='bill_ondatasetvalid("<dsid><REMARK></REMARK><SCORE></SCORE><STU_ID></STU_ID><XB></XB><XM></XM></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>