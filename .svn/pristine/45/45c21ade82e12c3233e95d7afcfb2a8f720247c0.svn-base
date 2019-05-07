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
<script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><script >document.styleSheets[0].addRule("fc\\:webgrid","behavior: url(../../fceform/htc/webgrid.htc)",0);</script><script src='../../fceform/js/fcwebgrid.js'></script><script >document.styleSheets[0].addRule("fc\\:fc_code","behavior: url(../../fceform/htc/fc_code.htc)",0);</script><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script><script src='../../fceform/js/fcdataset.js'></script>
<script>
//加载页面的动作
function myonload()
{
    //进行结束状态的修改
    var updateSql = "update tb_delegate t set t.delegate_stat='3' where t.delegate_stat='1' and t.delegate_end_time is not null and t.delegate_end_time < sysdate ";
    InsertSql(RepXml(updateSql));
    var sql = "select t.DESIGNATOR_ID,t.DESIGNATOR,t.designee_id,t.designee_name,decode(t.delegate_type,2,'委派他人',1,'上级委派') as delegate_type,to_char(t.DELEGATE_TIME,'yyyy-MM-dd') as DELEGATE_TIME,decode(t.DELEGATE_STAT,1,'等待确认',2,'委派中',3,'委派结束',4,'委派取消',5,'拒绝委派') as DELEGATE_STAT,t.Ec_Name,delegate_id,to_char(DELEGATE_END_TIME,'yyyy-MM-dd') as DELEGATE_END_TIME,to_char(DELEGATE_CANCEL_TIME,'yyyy-MM-dd') as DELEGATE_CANCEL_TIME from tb_delegate t where t.designee_id='"+getSysElement("userAccount")+"' and t.app_id='<%=appId%>' order by t.delegate_id desc";
    dataset1.Open(sql);
    buttonevent('grid1','firstpage');
}
//以模态窗口形式打开
function openDilogByUrl(url)
{
    var retx = window.showModalDialog(url);
    if(retx) location.reload(true);
}

//打开记录的修改页面
function showUpdatePage()
{
    var col = grid1.curTD.parentNode.childNodes;
    //alert(col[6].innerHTML);
    var delegateId = col[1].innerText;
    var url = "609.jsp?isUpdate=true&delegateId="+delegateId;
    openDilogByUrl(url);
}

//获得当前记录的指定单元格
function getTdByCol(num)
{
    var tdList = grid1.curTD.parentNode.childNodes;
    if(num>0&&num<=tdList.length)
    {
        return tdList[num];
    }
    else
    {
        return undefined;
    }
}
//更新次数
var tmp_num = 0;

//选择状态时触发记录更新
function updateData()
{
   var _id = getTdByCol(1).innerText;
   var stat = grid1.curTD.innerText;
   var op = "";
   if(stat==2) op="endDelegate";
   else op="cancelDelegate";
    alert(tmp_num);
    if(tmp_num==0)
    {
         var url1 = location.protocol+"//"+location.host+fcpubdata.servletPath+"/ProcessTools?op="+op+"&delegateId="+_id;
         var retx = SendHttp(url1);
         if(retx=="success")
         {
             tmp_num++;
             alert("操作成功！");
         }
         else
         {
             alert("操作失败！");
         }
    }
    else
    {
        window.location.reload();
    }
}</script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creatorType="5680" type="ZW" creator_elementAuthoritySwitch="否" toolbar="不带工具栏" contxml="<root><grid><id>grid1</id></grid><dataset><id>dataset1</id></dataset></root>" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:2;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:4;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0" billtaborder="<root><taborder>grid1</taborder></root>" version="1.0" idtype="2" OtherSave="否" isfile="否" posheight poswidth postop posleft isprotect="是" islog="否" hasWorkflowButton="否" creator_remark entertype="修改" window="当前窗口" BLONclose="UnLoadWebOffice();" BLONopen="setAuthority();myonload();" keyfield codeheader="BBB" mkbh caption="委派给我的列表" dj_sn="636" creator_pagination="grid1,dataset1,15;" djid><TABLE cellSpacing=2 cellPadding=0 width="99%" align=left border=0>
<TBODY>
<TR>
<TD style="FONT-SIZE: 20pt; TOP: 100px" vAlign=center align=middle height=25>&nbsp;<?xml:namespace prefix = fc /><fc:dataset id=dataset1 saveastable="APP_244.tb_delegate" multiResult="是" temptable="TMP_DATASET1" opensortno="1" format="<fields><field><fieldname>delegate_id</fieldname><datatype>整数</datatype><displaylabel>流水号</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DESIGNATOR_ID</fieldname><datatype>字符</datatype><displaylabel>委派人ID</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DESIGNATOR</fieldname><datatype>字符</datatype><displaylabel>委派人</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DESIGNEE_ID</fieldname><datatype>字符</datatype><displaylabel>被委派人ID</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DESIGNEE_NAME</fieldname><datatype>字符</datatype><displaylabel>被委派人</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DELEGATE_TYPE</fieldname><datatype>字符</datatype><displaylabel>委派类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DELEGATE_TIME</fieldname><datatype>字符</datatype><displaylabel>委派开始时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DELEGATE_STAT</fieldname><datatype>字符</datatype><displaylabel>委派状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>EC_NAME</fieldname><datatype>字符</datatype><displaylabel>委派范围</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DELEGATE_END_TIME</fieldname><datatype>字符</datatype><displaylabel>结束时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DELEGATE_CANCEL_TIME</fieldname><datatype>字符</datatype><displaylabel>取消时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field></fields>" onValid='bill_ondatasetvalid("<dsid><delegate_id></delegate_id><DESIGNATOR_ID></DESIGNATOR_ID><DESIGNATOR></DESIGNATOR><DESIGNEE_ID></DESIGNEE_ID><DESIGNEE_NAME></DESIGNEE_NAME><DELEGATE_TYPE></DELEGATE_TYPE><DELEGATE_TIME></DELEGATE_TIME><DELEGATE_STAT></DELEGATE_STAT><EC_NAME></EC_NAME><DELEGATE_END_TIME></DELEGATE_END_TIME><DELEGATE_CANCEL_TIME></DELEGATE_CANCEL_TIME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><delegate_id></delegate_id><DESIGNATOR_ID></DESIGNATOR_ID><DESIGNATOR></DESIGNATOR><DESIGNEE_ID></DESIGNEE_ID><DESIGNEE_NAME></DESIGNEE_NAME><DELEGATE_TYPE></DELEGATE_TYPE><DELEGATE_TIME></DELEGATE_TIME><DELEGATE_STAT></DELEGATE_STAT><EC_NAME></EC_NAME><DELEGATE_END_TIME></DELEGATE_END_TIME><DELEGATE_CANCEL_TIME></DELEGATE_CANCEL_TIME></dsid>")' onSetText='bill_ondatasetsettext("<dsid><delegate_id></delegate_id><DESIGNATOR_ID></DESIGNATOR_ID><DESIGNATOR></DESIGNATOR><DESIGNEE_ID></DESIGNEE_ID><DESIGNEE_NAME></DESIGNEE_NAME><DELEGATE_TYPE></DELEGATE_TYPE><DELEGATE_TIME></DELEGATE_TIME><DELEGATE_STAT>updateData()</DELEGATE_STAT><EC_NAME></EC_NAME><DELEGATE_END_TIME></DELEGATE_END_TIME><DELEGATE_CANCEL_TIME></DELEGATE_CANCEL_TIME></dsid>")'></fc:dataset>&nbsp;&nbsp; </TD></TR>
<TR>
<TD style="FONT-SIZE: 20pt; TOP: 100px" vAlign=center align=middle height=25>委派给我的</TD></TR>
<TR>
<TD vAlign=top width="100%" height=380>&nbsp; <fc:webgrid id=grid1 onkeydown='bill_ongridkeydown("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' ondblclick='bill_ongriddblclick("<grid1><col>showUpdatePage()</col><col>showUpdatePage()</col><col>showUpdatePage()</col><col>showUpdatePage()</col><col>showUpdatePage()</col><col>showUpdatePage()</col><col>showUpdatePage()</col><col>showUpdatePage()</col><col>showUpdatePage()</col><col>showUpdatePage()</col><col>showUpdatePage()</col></grid1>")' onclick='bill_ongridclick("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' dataset="dataset1" bodyrows="-1" bodyrowheight="-1" autosize="是" hideHscroll="是" hideVscroll="是" SetRowHeight="是" autoheight="否" autowidth="否" autoappend="否" canselect="是" readonly="否" visible="是" format="<cols><col><fname>delegate_id</fname><cname>流水号</cname><width>20</width><dtype>整数</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>DESIGNATOR_ID</fname><cname>委派人ID</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>DESIGNATOR</fname><cname>委派人</cname><width>200</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>DESIGNEE_ID</fname><cname>被委派人ID</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>DESIGNEE_NAME</fname><cname>被委派人</cname><width>200</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>DELEGATE_TYPE</fname><cname>委派类型</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>DELEGATE_TIME</fname><cname>委派开始时间</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>120</columnwidth><align>left</align></col><col><fname>DELEGATE_STAT</fname><cname>委派状态</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>EC_NAME</fname><cname>委派范围</cname><width>200</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>DELEGATE_END_TIME</fname><cname>结束时间</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>120</columnwidth><align>left</align></col><col><fname>DELEGATE_CANCEL_TIME</fname><cname>取消时间</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>120</columnwidth><align>left</align></col></cols>" width="903" height="348" top="0" left="0">
<TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=1 frame=box>
<TBODY>
<TR class=fcGridFirstRow>
<TD></TD></TR></TBODY></TABLE></fc:webgrid></TD></TR>
<TR>
<TD vAlign=center align=middle width="80%">
<DIV style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 150px; HEIGHT: 28px" name="Ctrlgrid1"><INPUT id=firstpagegrid1 onclick="buttonevent('grid1','firstpage')" type=button value=首页><INPUT id=prevpagegrid1 onclick="buttonevent('grid1','prevpage')" type=button value=上一页><INPUT id=nextpagegrid1 onclick="buttonevent('grid1','nextpage')" type=button value=下一页><INPUT id=lastpagegrid1 onclick="buttonevent('grid1','lastpage')" type=button value=尾页><BUTTON style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none; BACKGROUND-COLOR: #ffffff" ? value="">
<DIV id=pageInfogrid1></DIV></BUTTON></DIV></TD></TR></TBODY></TABLE></DIV></body></html>