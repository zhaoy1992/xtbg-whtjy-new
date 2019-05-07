var savename = "";
function Addobj(name){
if(bigmain.style.display == "none"){
alert("只有在设计状态下才有此功能!请点下面的设计按钮切换到设计状态后再试!");
return;
}
var oAddField = null;
switch (name){
case "button":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<button controltype='" ).append( name ).append( "' style='position:" ).append( fcpubdata.position ).append( ";left:0px;top:0px;width:75px;height:25px;' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect() id=").append(sid).append(">").append(sid).append("</button>").toString();
htmltocont(sHtml,name);
SelectObj(sid);
break;
}
case "spin":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<img controltype='" ).append( name ).append( "' id=").append(sid).append(" Min='1' Max='32000' NextNum='1' style='position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0; Height:22; Width:70;' src='../images/ef_designer_numedit.gif' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() />").toString();
htmltocont(sHtml,name);
SelectObj(sid);
oAddField = $(sid);
break;
}
case "label":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<div controltype='" ).append( name ).append( "' style='position:" ).append( fcpubdata.position ).append( ";left:0px;top:0px;width:65px;height:15px; ' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect() nowrap value=").append(sid).append(" id=").append(sid).append(">").append(sid).append("</div>").toString();
htmltocont(sHtml,name);
SelectObj(sid);
break;
}
case "hr":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<HR controltype='" ).append( name ).append( "' id=").append(sid).append(" width='95' color='silver' style='position:" ).append( fcpubdata.position ).append( ";left:0px;top:0px;width:165px;height:2px;' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect()>").toString();
htmltocont(sHtml,name);
break;
}
case "ExtTree":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<img controltype='" ).append( name ).append( "' format xml sql1  id=").append(sid).append(" multiselect='否' addrow='否'  blnempty='否'  blninput='是' visible='是' type=divbox dataset='' style='position:" ).append( fcpubdata.position ).append( ";left:0; top:0; width:150; height:200 ;' src='").append(fcpubdata.Path).append("/fceform/images/exttree.bmp' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() />").toString();
htmltocont(sHtml,name);
SelectObj(sid);
break;
}
case "a":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<a controltype='" ).append( name ).append( "' style='position:" ).append( fcpubdata.position ).append( "; left:0px; Top:0px; height:15px; Width:80px; ' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect() id=").append(sid).append(" >超级连接</a>").toString();
htmltocont(sHtml,name);
SelectObj(sid);
break;
}
case "text":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<input controltype='" ).append( name ).append( "'  style='position:" ).append( fcpubdata.position ).append( ";left:0px;top:0px;width:110px;height:20px; ' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect()  id=").append(sid).append(" >").toString();
htmltocont(sHtml,name);
SelectObj(sid);
oAddField = $(sid);
break;
}
case "checkboxlist":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<DIV controltype='" ).append( name ).append( "' id=").append(sid).append(" divtype='divcheckbox' style='background-color:#d4d0c8; overflow:auto;position:" ).append( fcpubdata.position ).append( ";left:0;top:0;width:300;height:200;border:solid 1 black; ' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() ></DIV>" ).toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break;
}
case "radiolist":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<DIV controltype='" ).append( name ).append( "' id=").append(sid).append(" divtype='divradio' style='background-color:#d4d0c8; overflow:auto;position:" ).append( fcpubdata.position ).append( ";left:0;top:0;width:300;height:200;border: solid 1 black; ' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() ></DIV>").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break;
}
case "chart":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<img controltype='" ).append( name ).append( "' id=").append(sid).append(" type=graph style='position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0; Height:188; Width:326;' src='../images/ef_designer_graph.gif' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() />").toString();
htmltocont(sHtml,name);
SelectObj(sid);
break;
}
case "dropdownlist": {
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<img controltype='" ).append( name ).append( "' format xml sql1  id=").append(sid).append(" multiselect='否' addrow='否'  blnempty='否'  blninput='是' visible='是' type=divbox dataset='' style='position:" ).append( fcpubdata.position ).append( ";left:0; top:0; width:100; height:20 ;' src='").append(fcpubdata.Path).append("/fceform/images/ef_designer_fccode.gif' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() />").toString();
htmltocont(sHtml,name);
SelectObj(sid);
oAddField = $(sid);
break;
}
case "checkbox":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<div controltype='" ).append( name ).append( "' nowrap id=").append(sid).append(" divtype='checkbox'  truevalue='是' falsevalue='否' value='否' style='position:" ).append( fcpubdata.position ).append( "; left:0px; top:0px; width:80; height:20px;'onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect()><input type=checkbox oncontrolselect=controlselectcancel()><span>复选框</span></div>").toString();
htmltocont(sHtml,name);
SelectObj(sid);
oAddField = $(sid);
break;
}
case "Fusionchar":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml="<img controltype='" + name + "' format xml sql1  id="+sid+" multiselect='否' addrow='否'  blnempty='否'  blninput='是' visible='是' type=divbox dataset='' style='position:" + fcpubdata.position + ";left:0; top:0; width:300; height:150 ;' src='"+fcpubdata.Path+"/fceform/images/fusionchartp.jpg' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() />";
htmltocont(sHtml,name);
SelectObj(sid);
oAddField = $(sid);
break;
}
case "radio":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<fieldset controltype='" ).append( name ).append( "' id=").append(sid).append(" contentEditable=false value=-1  style='position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0;Height:96;Width:152;color:#000000 ; ' dataset='' field='' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() ><legend>单选表</legend></fieldset>").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
oAddField = $(sid);
break ;
}
case "listbox":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<select controltype='" ).append( name ).append( "' size=8  style='position:" ).append( fcpubdata.position ).append( "; left:0px; top:0px; width:100px; height:80px; ' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect() id=").append(sid).append("></select>").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
oAddField = $(sid);
break;
}
case "textarea":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<textarea controltype='" ).append( name ).append( "' style='position:" ).append( fcpubdata.position ).append( "; left:0px; top:0px; width:100px; height:85px; ' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect() value=").append(sid).append(" id=").append(sid).append("></textarea>").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
oAddField = $(sid);
break ;
}
case "combobox":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<select controltype='" ).append( name ).append( "' style='position:" ).append( fcpubdata.position ).append( "; left:0px; top:0px; width:120px; height:25px; ' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect() id=").append(sid).append("></select>").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
oAddField = $(sid);
break;
}
case "upload":{
try{
obj=upload1.id;
alert("每个表单上只能有一个File Field控件！");
return;
}catch(e){
ArrNum[name]++;
var sHtml=new StringBuffer().append("<div controltype='" ).append( name ).append( "' id='upload1' style='BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid;  BORDER-RIGHT: 1px solid;BORDER-TOP: 1px solid;overflow: auto;position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0;Height:48;Width:152; ' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() ><table  border=0 cellPadding=0 cellSpacing=0  frame=box style='table-layout:fixed;BORDER-COLLAPSE: collapse;'> <tr height=30><td colspan=2 onclick='uploadAddFile()'>&nbsp;&nbsp;<a href='javascript:void(0)'></a><font color='#0000FF' style='cursor: pointer;font-size:12px'>增加附件</font></td><td colspan=3></td></tr></table></div> ").toString();
}
htmltocont(sHtml,name);
SelectObj(upload1);
break ;
}
case "dbimg":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<img controltype='" ).append( name ).append( "' id=").append(sid).append("  alt='用鼠标双击此可选择图形' ondblclick=uploadImg() style='position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0;BACKGROUND-COLOR:#FFFFFF ;color:#000000 ;' dataset='' field='' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() >").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
oAddField = $(sid);
break ;
}
case "img":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<img controltype='" ).append( name ).append( "' id=").append(sid).append(" style='position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0;' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() >").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
case "tree": {
ArrNum[name]++;
var sid = getNewContID(name,oContXml);
var sHtml = new StringBuffer().append("<img controltype='" ).append( name ).append( "' id=").append(sid).append(" isAll='true' xml ischecked='false'  src='../images/ef_designer_tree.gif' style='position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0;Height:205;Width:187;' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() >").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break;
}
case "tab":{
var sidtype=name;
ArrNum[sidtype]++;
var sid = getNewContID(name,oContXml) ;
var buffer=new StringBuffer();
buffer.append("<div id=").append(sid).append(" controltype='" ).append( name ).append( "' onresize=page_onresize() onresizestart=resizeStart() onresizeend=resizeEnd() onmovestart=moveStart() onmoveend=moveEnd() style='position:absolute;top:0px;left:0px;width:402px;height:320px'>");
buffer.append("<table id=fcpagesubtable bgcolor=white onmousedown=pageonclick() onresizestart=CancelEvent()><tbody><tr contentEditable=false><td style='background-color:white;border-left:1px solid #8BA7B6;border-top:1px solid #8BA7B6;border-right:1px solid #8BA7B6;color:red;' width=80px height=20px align=center><font size=2>页签1</font></td><td style='background-color:white;border-left:1px solid #8BA7B6;border-right:1px solid #8BA7B6;border-top:1px solid #8BA7B6;' width=80px height=20px align=center><font size=2>页签2</font></td></tr></tbody></table>");
buffer.append("<div id=fcpagesub style='z-index:1;background-color:white;position:absolute;top:22px;height:250px;border-left:1px solid #8BA7B6;border-bottom:1px solid #8BA7B6;border-right:1px solid #8BA7B6;border-top:1px solid #8BA7B6;' onmovestart=CancelEvent() onresizestart=CancelEvent() oncontrolselect=controlselect()></div>");
buffer.append("<div id=fcpagesub style='background-color:white;position:absolute;top:22px;height:250px;border-left:1px solid #8BA7B6;border-bottom:1px solid #8BA7B6;border-right:1px solid #8BA7B6;border-top:1px solid #8BA7B6;' onmovestart=CancelEvent() onresizestart=CancelEvent() oncontrolselect=controlselect()></div>");
var sHtml=buffer.append("</div>").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
case "shape":{
ArrNum[name]++;
var sid = getNewContID(name,oContXml) ;
sidtype="Shape";
var sHtml=new StringBuffer().append("<v:Rect controltype='" ).append( name ).append( "' id=").append(sid).append(" style='position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0;width:100px;height:100px;' StrokeColor='#000000'  fillcolor='#ffffff' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() > ").append(" <v:stroke dashstyle='Soild' /> ").append("</v:Rect> ").toString();
htmltocont(sHtml,name);
SelectObj(sid);
break;
}
case "grid":{
var sidtype=name;
ArrNum[sidtype]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<img controltype='" ).append( name ).append( "' id=").append(sid).append(" style='position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0;Height:140;Width:300;' src='../images/ef_designer_webgrid.gif' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() >").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
case "dataset":{
var no=1;
var sidtype=name;
ArrNum[sidtype]++;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<img controltype='" ).append( name ).append( "' id=").append(sid).append(" opensortno=").append(no).append(" style='position:absolute;Left:5;Top:5;Height:47;Width:39;' src='../images/ef_designer_dataset.gif' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() >").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
case "div": {
ArrNum[name]++ ;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<div controltype='" ).append( name ).append( "' id=").append(sid).append(" style='BORDER-BOTTOM: 1px solid black; BORDER-LEFT: 1px solid black; BORDER-RIGHT: 1px solid black; BORDER-TOP: 1px solid black;overflow: auto; background-color:#ffffff; position:" ).append( fcpubdata.position ).append( "; left:0; Top:0; width:280; height:200;' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect()></div>").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
case "ebshow": {
try{
obj=ebshow1.id;
alert("每个表单上只能有一个显示e表结果控件！");
return;
}catch(e){
ArrNum[name]++ ;
var sid = "ebshow1" ;
var sHtml=new StringBuffer().append("<div controltype='" ).append( name ).append( "' id=").append(sid).append(" style='BORDER-BOTTOM: 1px solid black; BORDER-LEFT: 1px solid black; BORDER-RIGHT: 1px solid black; BORDER-TOP: 1px solid black;overflow: auto; background-color:#ffffff; position:" ).append( fcpubdata.position ).append( "; left:0; Top:0; width:280; height:200;' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect() InHtml='").append(escape('<iframe id=fcebTopic style="WIDTH:100%; height:100%;" NORESIZE=NORESIZE SCROLLING=auto MARGINWIDTH=0 MARGINHEIGHT=0 FRAMESPACING=0 FRAMEBORDER=0 ALLOWTRANSPARENCY="true"></iframe>')).append("'></div>").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
}
break ;
}
case "excel": {
ArrNum[name]++ ;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append("<object controltype='" ).append( name ).append( "' classid='clsid:0002E510-0000-0000-C000-000000000046' id=").append(sid).append(" style='position:" ).append( fcpubdata.position ).append( "; left:0; Top:0; width:80%; height:200;'><param name='HTMLURL' value><param name='HTMLData' value='&lt;html xmlns:x=&quot;urn:schemas-microsoft-com:office:excel&quot;xmlns=&quot;http://www.w3.org/TR/REC-html40&quot;&gt;&lt;head&gt;&lt;style type=&quot;text/css&quot;&gt;&lt;!--tr{mso-height-source:auto;}td{black-space:nowrap;}.wc4590F88{black-space:nowrap;font-family:宋体;mso-number-format:General;font-size:auto;font-weight:auto;font-style:auto;text-decoration:auto;mso-background-source:auto;mso-pattern:auto;mso-color-source:auto;text-align:general;vertical-align:bottom;border-top:none;border-left:none;border-right:none;border-bottom:none;mso-protection:locked;}--&gt;&lt;/style&gt;&lt;/head&gt;&lt;body&gt;&lt;!--[if gte mso 9]&gt;&lt;xml&gt;&lt;x:ExcelWorkbook&gt;&lt;x:ExcelWorksheets&gt;&lt;x:ExcelWorksheet&gt;&lt;x:OWCVersion&gt;9.0.0.2710&lt;/x:OWCVersion&gt;&lt;x:Label Style='border-top:solid .5pt silver;border-left:solid .5pt silver;border-right:solid .5pt silver;border-bottom:solid .5pt silver'&gt;&lt;x:Caption&gt;Microsoft Office Spreadsheet&lt;/x:Caption&gt; &lt;/x:Label&gt;&lt;x:Name&gt;Sheet1&lt;/x:Name&gt;&lt;x:WorksheetOptions&gt;&lt;x:Selected/&gt;&lt;x:Height&gt;7620&lt;/x:Height&gt;&lt;x:Width&gt;15240&lt;/x:Width&gt;&lt;x:TopRowVisible&gt;0&lt;/x:TopRowVisible&gt;&lt;x:LeftColumnVisible&gt;0&lt;/x:LeftColumnVisible&gt; &lt;x:ProtectContents&gt;False&lt;/x:ProtectContents&gt; &lt;x:DefaultRowHeight&gt;210&lt;/x:DefaultRowHeight&gt; &lt;x:StandardWidth&gt;2389&lt;/x:StandardWidth&gt; &lt;/x:WorksheetOptions&gt; &lt;/x:ExcelWorksheet&gt;&lt;/x:ExcelWorksheets&gt; &lt;x:MaxHeight&gt;80%&lt;/x:MaxHeight&gt;&lt;x:MaxWidth&gt;80%&lt;/x:MaxWidth&gt;&lt;/x:ExcelWorkbook&gt;&lt;/xml&gt;&lt;![endif]--&gt;&lt;table class=wc4590F88 x:str&gt;&lt;col width=&quot;56&quot;&gt;&lt;tr height=&quot;14&quot;&gt;&lt;td&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;&lt;/body&gt;&lt;/html&gt;'> <param name='DataType' value='HTMLDATA'> <param name='AutoFit' value='0'><param name='DisplayColHeaders' value='-1'><param name='DisplayGridlines' value='-1'><param name='DisplayHorizontalScrollBar' value='-1'><param name='DisplayRowHeaders' value='-1'><param name='DisplayTitleBar' value='0'><param name='DisplayToolbar' value='-1'><param name='DisplayVerticalScrollBar' value='-1'> <param name='EnableAutoCalculate' value='-1'> <param name='EnableEvents' value='-1'><param name='MoveAfterReturn' value='-1'><param name='MoveAfterReturnDirection' value='0'><param name='RightToLeft' value='0'><param name='ViewableRange' value='1:65536'></object>").toString() ;
htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
case "word": {
ArrNum[name]++ ;
var sid = getNewContID(name,oContXml) ;
var sHtml=new StringBuffer().append('<DIV onmove=move() controltype="' ).append( name ).append('" oncontrolselect=controlselect() id=').append(sid).append(' onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 132px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 280px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 127px; HEIGHT: 200px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div">').append('<OBJECT id=word_').append(sid).append(' style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 28px; HEIGHT: 100%" codeBase=../../../Dsoframer.ocx#Version=2,0.0,4 classid=clsid:00460182-9E5E-11d5-B7C8-B8269041DD57 ><PARAM NAME="_ExtentX" VALUE="6932"><PARAM NAME="_ExtentY" VALUE="5239"><PARAM NAME="BorderColor" VALUE="-2147483632"><PARAM NAME="BackColor" VALUE="-2147483643"><PARAM NAME="ForeColor" VALUE="-2147483640"><PARAM NAME="TitlebarColor" VALUE="-2147483635"><PARAM NAME="TitlebarTextColor" VALUE="0"><PARAM NAME="BorderStyle" VALUE="1"><PARAM NAME="Titlebar" VALUE="0"><PARAM NAME="Toolbars" VALUE="1"><PARAM NAME="Menubar" VALUE="1"></OBJECT><BUTTON  id=word_taohong_').append(sid).append(' onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style="LEFT: 2px; WIDTH: 75px; POSITION: absolute; TOP: 1px; HEIGHT: 25px" onmovestart=moveStart() onclick=document.all.word_').append(sid).append('.SetFieldValue(&quot;hongtou&quot;,&quot;&quot;,&quot;::ADDMARK::&quot;);document.all.word_').append(sid).append('.SetFieldValue(&quot;hongtou&quot;,file_url,&quot;::FILE::&quot;);document.all.word_').append(sid).append('.SetTrackRevisions(4); file_url=http://localhost:8088/dzzwpt/hongtou.doc dropstyle="否">套红</BUTTON></DIV>').toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
case "WebOffice": {
ArrNum[name]++ ;
var sid = getNewContID(name,oContXml) ;

var sHtml=new StringBuffer().append('<DIV onmove=move() controltype="' ).append( name ).append('" oncontrolselect=controlselect() id=').append(sid).append(' onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 132px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 280px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 127px; HEIGHT: 200px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div">').append('<OBJECT id=WebOffice_').append(sid).append(' name="WebOffice" style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 1px; HEIGHT: 100%" codebase="../../../iWebOffice2006/iWebOffice2006.cab#version=7,8,0,4" classid="clsid:8B23EA28-723C-402F-92C4-59BE0E063499"></OBJECT></DIV>').toString();

htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
case "Scanner": {
ArrNum[name]++ ;
var sid = getNewContID(name,oContXml) ;									
var sHtml=new StringBuffer().append('<DIV onmove=move() style="DISPLAY: none;background-image:url(../images/scanner.jpg);width:60px;height:60px"  oncontrolselect=controlselect() id=').append(sid).append('_div onmovestart=moveStart() controltype="div" controltype="div" >').append('<OBJECT id=').append(sid).append('  codeBase="../../../iWebOffice2006/MyScanner.cab#version=1,0,0,1" classid="clsid:3082F03D-B139-43E6-92BC-F8DBF9642E09" name=Scanner><PARAM NAME="_Version" VALUE="65536"><PARAM NAME="_ExtentX" VALUE="0"><PARAM NAME="_ExtentY" VALUE="0"><PARAM NAME="_StockProps" VALUE="0"></OBJECT></DIV>').toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
case "gaEditor": {
ArrNum[name]++ ;
var sid = getNewContID(name,oContXml) ;
var sHtml = new StringBuffer().append("<img controltype='" ).append( name ).append( "' id=").append(sid).append(" name='gaeditor' style='position:absolute;Left:50;Top:50;Height:300;Width:550;' src='../images/ef_design_gaeditor.jpg' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() >").toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
case "workflowControl": {
ArrNum[name]++; 
var sid = getNewContID(name,oContXml) ;
/* modified by zhou.luo 2009-01-05 去掉工作流中的挂起、恢复、终止流程 */
var buffer=new StringBuffer();
buffer.append("<DIV onmove=move() oncontrolselect=controlselect() id="+sid+" onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 171.66%' onmovestart=moveStart() controltype='");
buffer.append(name).append("' NotBg='是'>");
buffer.append("<DIV onmove=move() oncontrolselect=controlselect() id=workflowControl_selectAct_div onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; BORDER-LEFT: 0px; WIDTH: 215px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px; auto: ' onmovestart=moveStart() controltype='div' NotBg='是'>");
buffer.append("请选择活动： <SELECT onmove=move() oncontrolselect=controlselect() id=workflowControl_selectAct onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 58px; WIDTH: 120px; POSITION: static; TOP: 33px; HEIGHT: 25px' onmovestart=moveStart() onchange=\"bill_onclick(&quot;changeSelectActor()&quot;)\" controltype='combobox' check='1' tempvalue temptext sql></SELECT> ");
buffer.append("</DIV>");
buffer.append("<DIV onmove=move() oncontrolselect=controlselect() id=workflowControl_selectUser onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 340px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px' onmovestart=moveStart() controltype='div' NotBg='是'>");
buffer.append("请选择执行人： <INPUT onmove=move() oncontrolselect=controlselect() id=DYNAMICPERFORMER_NAME onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px' onmovestart=moveStart() readOnly size=25 controltype='text'> <INPUT onmove=move() oncontrolselect=controlselect() id=DYNAMICPERFORMER onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px' onmovestart=moveStart() size=2 controltype='text'><BUTTON class=button1 onmove=move() oncontrolselect=controlselect() id=button_xzxr onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px' onmovestart=moveStart() controltype='button' fc_onclick=\"bill_onclick(&quot;adduser();&quot;)\" dropstyle='否'>选执行人</BUTTON> ");
buffer.append("</DIV>");
buffer.append("<DIV onmove=move() oncontrolselect=controlselect() id=workflowControl_selectAndUser onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 380px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px' onmovestart=moveStart() controltype='div' NotBg='是'>");
buffer.append("请选择执行人： <INPUT onmove=move() oncontrolselect=controlselect() id=ANDSPLITUSERS_ACTNAME onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px' onmovestart=moveStart() readOnly size=25 controltype='text'> <INPUT onmove=move() oncontrolselect=controlselect() id=ANDSPLITUSERS onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px' onmovestart=moveStart() size=2 controltype='text'><BUTTON class=button1 onmove=move() oncontrolselect=controlselect() id=button_yfzxzxr onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 0px; WIDTH: 115px; POSITION: static; TOP: 0px; HEIGHT: 25px' onmovestart=moveStart() controltype='button' fc_onclick=\"bill_onclick(&quot;addAndUser();&quot;)\" dropstyle='否'>与分支选执行人</BUTTON> ");
buffer.append("</DIV>");
buffer.append("<DIV onmove=move() oncontrolselect=controlselect() id=workflowControl_start onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px' onmovestart=moveStart() controltype='div' NotBg='是'>");
buffer.append("<BUTTON class=button1 onmove=move() oncontrolselect=controlselect() id=button_qdlc onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px' onmovestart=moveStart() controltype='button' fc_onclick=\"bill_onclick(&quot;creator_djsave('启动流程',true,true,'../../../common_workflow/main.jsp')&quot;)\" dropstyle='否'>启动流程</BUTTON>");
buffer.append("</DIV>");
buffer.append("<DIV onmove=move() oncontrolselect=controlselect() id=workflowControl_complete onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px' onmovestart=moveStart() controltype='div' NotBg='是'>");
buffer.append("<BUTTON class=button1 onmove=move() oncontrolselect=controlselect() id=button_wchd onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px' onmovestart=moveStart() controltype='button' fc_onclick=\"bill_onclick(&quot;creator_djsave('完成活动',true,true,'../../../common_workflow/main.jsp')&quot;)\" dropstyle='否'>完成活动</BUTTON>");
buffer.append("</DIV>");
buffer.append("<DIV onmove=move() oncontrolselect=controlselect() id=workflowControl_back onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px' onmovestart=moveStart() controltype='div' NotBg='是'>");
buffer.append("<BUTTON class=button1 onmove=move() oncontrolselect=controlselect() id=button_ht onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px' onmovestart=moveStart() controltype='button' fc_onclick=\"bill_onclick(&quot;creator_djsave('回退',false,true,'../../../common_workflow/main.jsp')&quot;)\" dropstyle='否'>回退</BUTTON>");
buffer.append("</DIV>");
buffer.append("<DIV onmove=move() oncontrolselect=controlselect() id=workflowControl_recycle onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px' onmovestart=moveStart() controltype='div' NotBg='是'>");
buffer.append("<BUTTON class=button1 onmove=move() oncontrolselect=controlselect() id=button_hs onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px' onmovestart=moveStart() controltype='button' fc_onclick=\"bill_onclick(&quot;creator_djsave('收回',false,true,'../../../common_workflow/main.jsp')&quot;)\" dropstyle='否'>收回</BUTTON>");
buffer.append("</DIV>");
buffer.append("<DIV onmove=move() oncontrolselect=controlselect() id=workflowControl_tempSaveForm onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px' onmovestart=moveStart() controltype='div' NotBg='是'>");
buffer.append("<BUTTON class=button1 onmove=move() oncontrolselect=controlselect() id=button_zc onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px' onmovestart=moveStart() controltype='button' fc_onclick=\"bill_onclick(&quot;creator_djsave('暂存',true,true,'../../../common_workflow/main.jsp')&quot;)\" dropstyle='否'>暂存</BUTTON>");
buffer.append("</DIV>");
buffer.append("<DIV onmove=move() oncontrolselect=controlselect() id=workflowControl_backToPrior onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px' onmovestart=moveStart() controltype='div' NotBg='是'>");
buffer.append("<BUTTON onmove=move() oncontrolselect=controlselect() id=workflowControl_result onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style='LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px' onmovestart=moveStart() controltype='button'  dropstyle='否'>返回</BUTTON>");
buffer.append("</DIV>");

var sHtml=buffer.toString();
htmltocont(sHtml,name) ;
SelectObj(sid);
break ;
}
// sxb 20080923添加表单引用控件
case "creatorSubForm":{
	ArrNum[name]++;
	var sid = getNewContID(name,oContXml) ;
	/*
	 * var sHtml = "<DIV onmove=move() oncontrolselect=controlselect()
	 * id="+sid+" onresizeend=resizeEnd() onresizestart=resizeStart()
	 * onmoveend=moveEnd() onresize=resize() style='BORDER-RIGHT: 0px;
	 * BORDER-TOP: 0px; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH:
	 * 200px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 200px;
	 * BACKGROUND-COLOR: #ffffff' onmovestart=moveStart() controltype='div'
	 * NotBg='否'>" + "<IFRAME id="+sid+"_subform style='WIDTH: 100%; HEIGHT:
	 * 100%'></IFRAME></DIV>";
	 */
	var sHtml = new StringBuffer().append("<iframe frameBorder=yes controltype='" ).append( name ).append( "' id=").append(sid).append(" style='position:absolute;Left:50;Top:50;Height:300;Width:550;' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() url autoload=yes autoSetSize=no></iframe>").toString();
	htmltocont(sHtml,name) ;
	SelectObj(sid);
	break;
}
// sxb 20080927添加表单内容复制控件
case "creator_div":{
	ArrNum[name]++ ;
	var sid = getNewContID(name,oContXml) ;
	var sHtml=new StringBuffer().append("<div controltype='" ).append( name ).append( "' id=").append(sid).append(" desc='' style='BORDER-BOTTOM: 1px solid black; BORDER-LEFT: 1px solid black; BORDER-RIGHT: 1px solid black; BORDER-TOP: 1px solid black;overflow: auto; background-color:#ffffff; position:" ).append( fcpubdata.position ).append( "; left:0; Top:0; width:280; height:200;' onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() oncontrolselect=controlselect()></div>").toString();
	htmltocont(sHtml,name) ;
	SelectObj(sid);
	break;
}
// 添加表单自动绘制功能 added by zhou.luo 2008-09-25
case "formAutoDraw":{
    // 进行自动化绘制的表单仅且只能有要有一个数据集，在这里进行判断
    var ds_id = "";    // 数据集id
	var oNode = oContXml.documentElement.selectSingleNode("dataset");
	if(oNode!=null){
		var l = oNode.childNodes.length;
		if(l!=1){
			alert('进行自动化绘制的表单有且只能有一个数据集！');
			return;
		}
		ds_id = oNode.childNodes(0).text
	}
    var formRet = window.showModalDialog('../../fceform/dj/20080926154518093882.jsp');
    if(formRet!=undefined){
    	var tmpArr = formRet.split(",");
    	if(tmpArr[0]=='否' && tmpArr[1]=='否'){ // 不需要生成列表页面和详细页面，在此退出。
        	return;
    	}
    	creator_formDraw(formRet,ds_id,SKbillsheet.creatorType);
    }
    break;
}
case "focus":{
var sXml=TaborderXml();
var oX = SetDom(sXml) ;
var sX = oX.childNodes(0).childNodes.length ;
if (RemoveRoot(sXml)!="" && sX >= 2){
SaveoUndoOneRecord();
var sRet=DjOpen('SKDBfocus',sXml,'展现',"有模式窗口","直接","焦点次序");
SKbillsheet.billtaborder=sRet;
SaveoRedoOneRecord();
}else{
alert("有两个或以上控件才能使用此控制！");
}
break;
}
case "align":{
sArray=CurrSel();
if(sArray.length<2){
alert("选中两个或以上控件才能使用此控制");
break;
}
if(sArray !=""  ){
SaveoUndoOneRecord();
var sRet=DjOpen('SKDBalign',sArray,'展现',"有模式窗口","直接","对齐面板");
SaveoRedoOneRecord();
}
break;
}
case "menu":{
var str = DjOpen('menu','','展现',"无模式窗口","直接","");
break;
}
case "cut":
if(CopyCont()){
main_onkeydown(46);
main_exec('Delete');
main_onkeyup(46);
}
break;
case "copy":
if(CopyCont() == false){
document.execCommand("Copy") ;
}
break;
case "paste":
if(PasteCont() == false){
document.execCommand("Paste") ;
}
break;
case "creator_background":
    if(document.body.style.background == "url(../images/blank.bmp)"){        
        document.body.style.background = "url('../images/grid.bmp')";
    }else{       
		document.body.style.background = "url('../images/blank.bmp')";
	}
    break;
case "front":{
AdjustPositionBefore("是");
break;
}
case "behind":{
AdjustPositionBefore("否");
break;
}
case "formatTab":{
var Htm = DjOpen('fcs_NewFormatTab','SKbillsheet','展现',"有模式窗口","直接","新建版式表格") ;
if(typeof Htm == 'undefined') {
SKbillsheet.innerHTML += "";
}else{
htmltocont(Htm);
}
blnChange=true ;
break;
}
case "HtmlTab":{
var sHTab = DjOpen('fcs_NewHtmlTab',fcpubdata,'展现',"有模式窗口","直接","新建表格") ;
if(typeof sHTab == 'undefined') {
SKbillsheet.innerHTML += "";
}else{
try{
htmltocont(sHTab) ;
}catch(e){}
}
blnChange=true;
break ;
}
case "form":{
var arrForm=new Array();
arrForm[0]=SKbillsheet;
arrForm[5]=pstrUserFunction;
arrForm[8]=parent.topdjsn;
var sRet=DjOpen('form',arrForm,'展现',"有模式窗口","直接","表单属性");
if(sRet == "ok"){
var iwidth=0;
if(isSpace(SKbillsheet.poswidth) == false ){
iwidth = parseInt(SKbillsheet.poswidth);
if(bigmain.offsetWidth<iwidth){
bigmain.style.width = iwidth;
}
}
var iheight=0;
if(isSpace(SKbillsheet.posheight) == false ) {
iheight = parseInt(SKbillsheet.posheight);
if(bigmain.offsetHeight<iheight){
bigmain.style.height = iheight;
}
}
blnChange=true ;
}
break;
}
case "ebiaoform":{
var obj = parent.dialogArguments;
var s1 = obj.eform_winprop;
if(typeof s1 == "undefined") s1="";
var sRet=DjOpen('eb_parawin',[s1,SKbillsheet],'展现',"有模式窗口","直接","设置窗口相关属性");
if(IsSpace(sRet) == false){
obj.eform_winprop = sRet;
}
break;
}
case "ebiaobind":{
if(curSelElement == null )
{
alert("请在界面上选中一个控件后再试!");
break;
}
var tmpType = curSelElement.controltype ;
if(tmpType != "text"  && tmpType != "checkbox"  && tmpType != "radio"  && tmpType != "listbox"  && tmpType != "combobox"  && tmpType != "dropdownlist"  && tmpType != "textarea"  && tmpType != "spin"){
alert("当前选中的控件不能绑定!");
break;
}
var s2 =curSelElement.id ;
if(IsSpace(s2) ) {
alert("当前选中的控件的id不能为空!");
break ;
}
var obj = parent.dialogArguments;
var s1 = obj.e_argsbak;
if(typeof s1 == "undefined") s1="";
var sRet=DjOpen('eb_parabind',[s1,s2],'展现',"有模式窗口","直接","报表参数绑定");
if(IsSpace(sRet) == false){
obj.e_argsbak = sRet;
}
break;
}
case "userfunction":{
var stmp=DjOpen('userfunction',pstrUserFunction,'展现',"有模式窗口","直接","自定义函数");
if(typeof stmp != "undefined") pstrUserFunction=stmp;
blnChange=true ;
break;
}
case "userfunction1":{
try{
var l=new ActiveXObject("CodeMax.Language.3");
}catch(e){
if(window.confirm("没有安装codemax或是IE的安全设置属性框中对没有标记为安全的activex控件进行初始化和脚本运行的选项没为启动；是否下载安装codemax!")==true){
window.open("../design/download.htm","","height=250,width=300,left=300,top=150,resizabel=no,menubar=no") ;
}
break;
}
var stmp=DjOpen('userfunction1',pstrUserFunction,'展现',"有模式窗口","直接","带颜色的自定义函数");
if(typeof stmp != "undefined") pstrUserFunction=stmp;
blnChange=true ;
break;
}
case "addhtml":{
var stmp=DjOpen('addhtml',pstrAddHtml,'展现',"有模式窗口","直接","附加页面");
if(typeof stmp != "undefined") pstrAddHtml=stmp;
blnChange=true ;
break;
}
case "opendj":{
var sRet=DjOpen('opendj','','修改',"有模式窗口","直接","选择从数据库中打开的表单");
if(isSpace(sRet)==false){
DesignDjOpen(sRet);
}
break;
}
case "opendjfile":{
var spath = '../fceform/djfile';
if(fcpubdata.dotnetVersion == "") spath = fcpubdata.Path.substring(fcpubdata.Path.indexOf("/",2),fcpubdata.Path.length)+"/fceform/djfile";
var spathback = '../../fceform/djfile';
var sRet = DjOpen('getUrl',[spath,'file','yes','dj'],'展现','有模式窗口','直接','选择文件');
if(IsSpace(sRet) == false){
var shtm=readdesignhtml(new StringBuffer().append("<no>").append(spathback).append(sRet).append("</no><no></no>").append("<No>").append(fcpubdata.Path).append("</No>").toString());
DesignDjOpenSub(shtm,0);
}
break;
}
case "save":
{
	var retX=SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host ).append( fcpubdata.servletPath ).append("/DbTools?param=noUse&key=session_check").toString());
	if(retX == 'validate')
		DesignDjSave() ;
	else
	    // alert(retX);注意会话过期时返回值并不是“invalidate”
	    window.alert("会话超时，保存失败，请重新登录！");

	blnChange=false;
	break;
}
case "saveas":{
DesignDjSaveAs() ;
blnChange=false;
break;
}
case "saveashtml":{
	// savename =
	// window.showModalDialog("../htm/dialog.htm",savename,"dialogWidth:300px;dialogHeight:150px;");
	// if(trim(savename)=="") break;
	var retX=SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host ).append( fcpubdata.servletPath ).append("/DbTools?param=noUse&key=session_check").toString());
	if(retX == 'validate'){		
		if(!isSpace(DesignDjSave("不提示"))) return;
		GenerateHtml();
		// alert(SKbillsheet.dj_sn);
		
	}else
	    // alert(retX);注意会话过期时返回值并不是“invalidate”
	    window.alert("会话超时，保存失败，请重新登录！");

	blnChange=false;
	break;
}
case "saveastemplate":{
DesignDjSaveAsTemplate();
blnChange = false;
break;
}
case "new":{
parent.objlist.select1.options.length = 0;
DesignDjNew("是") ;
break;
}
case "newempty":{
parent.objlist.select1.options.length = 0;
DesignDjNew() ;
break;
}
case "djpreview":{
var djsn=parent.topdjsn;
// if(typeof djsn == "undefined"){
if(djsn == "undefined" || IsSpace(djsn)){
alert("保存后才能预览!");
return
}
if(blnChange){
var stmp = DesignDjSave("不提示") ;
if(IsSpace(stmp) == false) {
return ;
}
}
var sUrl=new StringBuffer().append(location.protocol ).append( "//").append(location.host).append(fcpubdata.Path).append("/fceform/design/opendj.htm?djsn=").append(djsn) ;
var isfile=SKbillsheet.isfile;
if(isfile == "是"){
sUrl.append("&isfile=yes") ;
} else {
sUrl.append("&isfile=test") ;
}
alert(open);
open(sUrl.toString());
break;
}
case "directrun":{
var djsn=parent.topdjsn;
// if(typeof djsn == "undefined"){
if(djsn == "undefined" || IsSpace(djsn)){
alert("保存后才能运行!");
return;
}
var isfile=SKbillsheet.isfile;
if(isfile == "是"){
alert("文件表单无法直接运行，只有将表单保存在数据库中时才能直接运行!");
return;
}
if(blnChange){
var stmp = DesignDjSave("不提示") ;
if(IsSpace(stmp) == false) {
return ;
}
}
var sUrl=new StringBuffer().append(location.protocol ).append( "//").append(location.host).append(fcpubdata.Path).append("/fceform/common/djframe.htm?djsn=").append(djsn).append("&djtype=").append(SKbillsheet.type) ;
if(typeof(SKbillsheet.testDbName)!='undefined'&&!IsSpace(SKbillsheet.testDbName)){
	reftestDbName = creator_getSession('menuDatasource');
	creator_setSession('menuDatasource',SKbillsheet.testDbName);
	sUrl.append("&creator_dbtest=").append(SKbillsheet.testDbName);
}
open(sUrl.toString());
break;
}
case "billtype":{
var sRet=DjOpen('billtypefile','','展现',"有模式窗口","直接","表单分类维护");
break;
}
case "createhtmfile":{
if(isSpace(SKbillsheet.dj_sn)){
var s1 = '表单sn不能为空!请进入表单属性窗口输入表单SN.';
alert(s1);
return ;
}
DesignStr_RunStr_Before(SKbillsheet);
SKbillsheet.removeAttribute("contentEditable");
SKbillsheet.removeAttribute("unselectable");
var sRun=SKbillsheet.outerHTML;
sRun=DesignStr_RunStr_After(sRun);
sRun="<scr"+"ipt>"+pstrUserFunction+"</scr"+"ipt>"+sRun+pstrAddHtml	;
sRun="<![CDATA["+sRun+"]]>";
var sFile = trim(SKbillsheet.dj_sn) + ".htm";
var sPath = "dj/" + sFile;
var sXml = new StringBuffer().append("<no>djsn</no><no>").append(sRun).append("</no><no>").append(sPath).append("</no>").append("<No>").append(fcpubdata.Path).append("</No>").toString();
var ret=savedesignhtml(sXml);
if(ret == "") {
alert(sFile+"文件保存成功!");
return "";
}else{
alert(ret);
return ret;
}
break;
}
case "undo" : { cmdUndo() ; break ;}
case "redo" : { cmdRedo() ; break ;}
case "ExtGrid":{
	var sidtype=name;
	ArrNum[sidtype]++;
	var sid = getNewContID(name,oContXml) ;
	var sHtml=new StringBuffer().append("<img controltype='" ).append( name ).append( "' id=").append(sid).append(" style='position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0;Height:140;Width:300;' src='../images/extgrid.jpg' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() >").toString();
	htmltocont(sHtml,name) ;
	SelectObj(sid);
	break ;
}
case "ExtUpload":{
	var sidtype=name;
	ArrNum[sidtype]++;
	var sid = getNewContID(name,oContXml) ;
	var sHtml=new StringBuffer().append("<img id=").append(sid).append(" src='../images/extupload.bmp' controltype='ExtUpload' id=").append(sid).append(" Min='1' Max='32000' NextNum='1' style='position:" ).append( fcpubdata.position ).append( ";Left:0;Top:0; Height:22; Width:70;' src='../images/ef_designer_numedit.gif' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() />").toString();
	htmltocont(sHtml,name);
	SelectObj(sid);
	break;
}
}
if(fcpubvar.AutoAddField == "yes" && oAddField != null && $("DsMain") != null ){
var s = $("DsMain").formatxml ;
var curNo = 0;
if(typeof s == "undefined"){
s = ""
}else{
s = RemoveRoot(s);
curNo = getMaxFieldNo();
}
var sF = new StringBuffer().append('<tr><td>field').append( curNo ).append('</td><td>field').append( curNo ).append('</td><td>字符</td><td>50</td><td>0</td><td>数据项</td><td></td><td></td><td>否</td><td>否</td><td>否</td><td>否</td><td>是</td><td>否</td><td>否</td><td>否</td><td></td><td></td><td>left</td><td>80</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>').toString();
$("DsMain").formatxml = new StringBuffer().append("<root>").append(s).append(sF).append("</root>").toString();
oAddField.dataset = "DsMain";
oAddField.field = "field"+curNo;
}
function getMaxFieldNo() {
var comType = "DsMain_field";
var curNo = 0;
if(isNaN(parseInt(ArrNum[comType])) == false){ ;
curNo = parseInt(ArrNum[comType]) ;
}
var oXml = SetDom($("DsMain").formatxml);
if(oXml.documentElement != null){
for(var i=curNo;i<curNo+200;i++){
var oNode = oXml.documentElement.selectSingleNode("/root/tr/td[0][.= 'field" + i + "']");
if(oNode == null){
ArrNum[comType]=i+1;
return i;
}
}
alert("DsMain数据集的字段名重复，请立即修改。");
}
return curNo;
}
/* 2008-09-12 更新此函数，解决对TAB页控件进行后置操作后页面上会出现两个一样的TAB页控件的问题。 */
/*
 * function AdjustPositionBefore(yes) { var
 * slen=oContXml.selectNodes("//id").length; if(slen<2){ alert("单个控件不能设置此控制");
 * return; } var sArray=CurrSel(); ilen=sArray.length; if (ilen>0){
 * SaveoUndoOneRecord(); var ss=sArray[0].parentNode.innerHTML; var
 * parentid=sArray[0].parentNode.id; var strHtm=""; for(var i=0;i<ilen;i++){
 * upid=sArray[i].parentNode.id; if(upid==parentid){
 * stmp=Trim(sArray[i].outerHTML); ss=RepStr(ss,stmp,""); strHtm=strHtm+stmp; } }
 * if(yes == "是"){ sArray[0].parentNode.innerHTML=ss+strHtm ; }else {
 * sArray[0].parentNode.innerHTML=strHtm+ss ; } blnChange=true ; }
 * SaveoRedoOneRecord(); } }
 */
/* 2008-09-12添加 注意：此函数是嵌套定义在另一个函数里面！ */
function AdjustPositionBefore(yes) {
    // 当前表单控件个数
	var slen=oContXml.selectNodes("//id").length;
	if(slen<2){
		alert("单个控件不能设置此控制");
		return;
	}
	var sArray=CurrSel();
	ilen=sArray.length;
	if (ilen>0){
		SaveoUndoOneRecord();
		var oParent = sArray[0].parentNode;
		var parentid = oParent.id;
		var strHtm="";
		for(var i=0;i<ilen;i++){
			upid=sArray[i].parentNode.id;
			if(upid==parentid){
				stmp=sArray[i].outerHTML;
				sArray[i].outerHTML="";
				strHtm=strHtm+stmp;
			}
		}
		var ss=oParent.innerHTML;
		if(yes == "是"){
			oParent.innerHTML=ss+strHtm ;
		}else {
			oParent.innerHTML=strHtm+ss ;
		
		}
		blnChange=true ;
	    SaveoRedoOneRecord();
	}
}
}

function designdjsave(sXml) {
if(sXml.indexOf("<IMG id=gaEditor")!=-1){
	var divStyle = sXml.substring(sXml.indexOf("<IMG id=gaEditor"));

	divStyle = divStyle.substring(0,divStyle.indexOf(">")+1);

	divStyle = divStyle.substring(divStyle.indexOf("style=\"")+7);

	divStyle = divStyle.substring(0,divStyle.indexOf("\""));

	var arr = divStyle.split(";");

	var a3 = arr[3].substring(arr[3].indexOf("TOP:")+5,arr[3].indexOf("px"));

	var num3 = a3-50;

	divStyle = "style=\""+arr[0]+"; "+arr[1]+"; "+arr[2]+"; TOP: "+num3+"; HEIGHT: 50px\"";

	var replacePrefix = '<div id="textCtrl" name="textCtrl" '+divStyle+'><input type="button" value="保存" onclick="gasaveit(gaSavePath)"/><input type="button" value="清除" onclick="clearit()"/><input type="button" value="导出文本" onclick="exportToText()"/><input type="button" value="痕迹保留" onclick="startTrace(gaUserName)"/><input type="button" value="关闭痕迹保留" onclick="stopTrace()"><input type="button" value="全文批注" onclick="StartPostil()"><input type="button" value="清稿" onclick="EndComment()"><input type="button" value="盖章" onclick="gaizhang()"><input type="button" value="禁止新建" onclick="noNew()"><input type="button" value="允许新建" onclick="enNew()"><input type="button" value="禁止保存" onclick="noSave()"><input type="button" value="允许保存" onclick="enSave()"><input type="button" value="全文只读" onclick="nocopy()"><a onclick="goTable()" style="cursor:hand"><font color="blue"><u>表格控制</u></font></a></div><div id="tableCtrl" name="tableCtrl" '+divStyle+' style="display:none">内容<input type="text" value="" name="toinsert" style="width:80px">表格号<input type="text" value="" name="tableid" style="width:30px">行号<input type="text" value="" name="rowid" style="width:30px">列号<input type="text" value="" name="colid" style="width:30px"><input type="button" value="读取数据" onclick="readContent()"><input type="button" value="写入数据" onclick="writeContent()"><input type="button" value="清除数据" onclick="clearContent()"><input type="button" value="单元格只读" onclick="setReadonly()"><a onclick="goTxt()" style="cursor:hand"><font color="blue"><u>全文控制</u></font></a></div>';

	sXml = sXml.replace("<IMG id=gaEditor",replacePrefix+"<object classid='clsid:A8EDCBC4-6BBC-4233-B8D4-C17138493C40' codebase='/public/afxKmEditor.ocx' id=gaEditor");

	sXml = sXml.replace("src=\"../../fceform/images/ef_design_gaeditor.jpg\""," ");
	
	// alert("0506 替换后 sXml:"+sXml);
}
var retX=SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append( fcpubdata.servletPath ).append( "/WebDesign").append(fcpubdata.dotnetVersion).append("?designdjsave").toString(),sXml);
return retX;
}
function savedesignhtml(sXml) {
return SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append( fcpubdata.servletPath ).append( "/WebBill").append(fcpubdata.dotnetVersion).append("?savedesignhtml").toString(),sXml);
}
function SavePubData(Sub,strContent,userData){
var Main="pubdata";
if(typeof userData == "undefined")
userData=parent.menu.oForm.oInput ;
userData.setAttribute(Main+userData.value,strContent) ;
userData.save(Sub+userData.value) ;
}
function LoadPubData(Sub,userData){
var Main="pubdata";
if(typeof userData == "undefined")
userData=parent.menu.oForm.oInput ;
userData.load(Sub+userData.value) ;
var sTmp=userData.getAttribute(Main+userData.value) ;
if (sTmp==null) {sTmp="" ; }
return sTmp ;
}
function getNewContID(comType,oContXml){
var sRet = "id1" ;
var curNo = 1 ;
if(isNaN(parseInt(ArrNum[comType])) == false){ ;
curNo = parseInt(ArrNum[comType]) ;
}
for(var i=curNo;i<curNo+200;i++){
var sid = comType+i ;
var oList = oContXml.documentElement.selectNodes("//id[. ='"+sid+"']") ;
if(oList.length == 0 ) {
ArrNum[comType] = i ;
return sid ;
}
}
alert(sid + "控件名称重复!请立即修改!");
return sid;
}
function main_ondblclick(obj) {
var arr=new Array();
if(typeof obj == "undefined"){
try {
var obj=event.srcElement;
}catch(e){
obj=curSelElement;
}
}else{
try {
parent.topic.focus();
}catch(e) {}
}
if(obj == null) {
Addobj('form');
return;
}
if(typeof obj.tagName=="undefined"){
obj=curSelElement;
}
var strid=obj.id;
if(isSpace(strid)){
try {
var stmp1 = obj.parentNode.divtype;
if( stmp1 =="checkbox"){
obj=obj.parentNode;
strid=obj.id;
}
} catch(e) {}
}
arr[0]=obj;
arr[1]=SelFieldToArr();
arr[2]=SKbillsheet;
arr[3]=oContXml;
try{
arr[4] = Printer;
}catch(e){}
arr[5]=pstrUserFunction;
if(obj.controltype == 'upload')
{
	var ds_map=new MapClass(); 
	var oNode = oContXml.documentElement.selectSingleNode("dataset");
	if(oNode!=null)
	{
		var l = oNode.childNodes.length;
		for(var i = 0;i < l;i++)
		{						
			ds_map.setAttr(oNode.childNodes(i).text,eval(oNode.childNodes(i).text).saveastable);
		}
	}
	arr[6]=ds_map;
}
SaveoUndoOneRecord();
var arrCur = CurrSel();
if(arrCur.length>1){
arr[0]=arrCur;
var sRet=DjOpen('pubAttr',arr,'展现','有模式窗口','直接','设置多个控件的属性');
}else{
if(isSpace(obj.controltype) == false ){
if(obj.controltype != "excel"){
if(obj.controltype !="workflowControl" && obj.controltype!="WebOffice" && obj.controltype!="gaEditor"){
var sRet=DjOpen(obj.controltype,arr,'展现','有模式窗口','直接',obj.controltype+'属性');
// sxb 20080928 在属性页面修改了script
pstrUserFunction=arr[5];
}
if(obj.controltype == "dataset"){
ShowAllField();
}
}
}else {
var bool = false;
var ArrNameNew=new Array();
ArrNameNew["SKButton"]="SKButton";
ArrNameNew["SKDBedit"]="SKDBedit";
ArrNameNew["SKDBcheckbox"]="checkbox";
ArrNameNew["Label"]="label";
ArrNameNew["SKDBRadioGroup"]="radio";
ArrNameNew["SKDBListBox"]="listbox";
ArrNameNew["SKDBMemo"]="textarea";
ArrNameNew["SKDBcombobox"]="combobox";
ArrNameNew["password"]="password";
ArrNameNew["SKuploadfile"]="upload";
ArrNameNew["SKDBtext"]="SKDBtext";
ArrNameNew["SKDBchart"]="chart";
ArrNameNew["SKDBImage"]="dbimg";
ArrNameNew["Image"]="img";
ArrNameNew["SKBILLgrid"]="SKBILLgrid";
ArrNameNew["Shape"]="shape";
ArrNameNew["PageControl"]="tab";
ArrNameNew["FCDiv"]="div";
ArrNameNew["SKDBTreeView"]="SKDBTreeView";
ArrNameNew["SKDBLike"]="a";
ArrNameNew["FCButton"]="button";
ArrNameNew["FCDBedit"]="text";
ArrNameNew["HR"]="hr";
ArrNameNew["divcheckbox"]="checkboxlist";
ArrNameNew["divradio"]="radiolist";
ArrNameNew["fccode"]="textarea";
ArrNameNew["imgwebgrid"]="grid";
ArrNameNew["imgdataset"]="dataset";
ArrNameNew["NumEdit"]="spin";
ArrNameNew["excel"]="excel";
ArrNameNew["Tree"]="tree";
ArrNameNew["creatorSubForm"]="creatorSubForm";
ArrNameNew["creator_div"]="creator_div";
var ArrName1=new Array();
ArrName1[0]="SKButton";
ArrName1[1]="SKDBedit";
ArrName1[2]="SKDBcheckbox";
ArrName1[3]="Label";
ArrName1[4]="SKDBRadioGroup" ;
ArrName1[5]="SKDBListBox"
ArrName1[6]="SKDBMemo"
ArrName1[7]="SKDBcombobox"
ArrName1[8]="password" ;
ArrName1[9]="SKuploadfile" ;
ArrName1[10]="SKDBtext";
ArrName1[11]="SKDBchart";
ArrName1[12]="SKDBImage";
ArrName1[13]="Image";
ArrName1[14]="SKBILLgrid";
ArrName1[15]="Shape";
ArrName1[16]="PageControl";
ArrName1[17]="FCDiv";
ArrName1[18]="SKDBTreeView";
ArrName1[19]="SKDBLike" ;
ArrName1[20]="FCButton" ;
ArrName1[21]="FCDBedit"
ArrName1[22]="HR" ;
ArrName1[23]="divcheckbox" ;
ArrName1[24]="divradio" ;
ArrName1[25]="fccode" ;
ArrName1[26]="imgwebgrid" ;
ArrName1[27]="imgdataset" ;
ArrName1[28]="NumEdit" ;
ArrName1[29]="excel"	;
ArrName1[30]="Tree"	;
ArrName1[31]="creatorSubForm"	;
ArrName1[32]="creator_div"	;
var l=ArrName1.length;
for (var i=0;i<l;i++){
if (strid.indexOf(ArrName1[i])==0){
var sRet=DjOpen(ArrNameNew[ArrName1[i]],arr,'展现','有模式窗口','直接',ArrNameNew[ArrName1[i]]+'属性');
bool = true;
break;
}
}
if(bool == false ) {
var sTag = obj.tagName;
if(isSpace(sTag) == false ) {
sTag = sTag.toUpperCase() ;
if(sTag == "INPUT" || sTag == "SELECT" || sTag == "TEXTAREA" || sTag == "BUTTON" || sTag == "A" || sTag == "IMG") {
var sRet=DjOpen('SetCtrlType',arr,'展现','有模式窗口','直接','属性');
}
}
}
}
SaveoRedoOneRecord();
return;
}
}
function SelFieldToArr(){
var arr=new Array();
var oNode = oContXml.documentElement.selectSingleNode("dataset");
if(oNode != null) {
var l = oNode.childNodes.length;
var sOption = "";
for(var i=0;i<l;i++){
var id = oNode.childNodes(i).text;
var ods=eval(id);
sOption += "<option value='"+id+"'>"+id+"</option>";
arr[id]=ods.formatxml;
}
arr[0]=sOption;
}
return arr;
}
function initoUndooRedo(){
lngUndo=-1;
lngRedo=-1;
oUndo.loadXML("<root></root>");
oRedo.loadXML("<root></root>");
}
function SaveoRedoOneRecord(){
var root = oRedo.documentElement;
var newNode = oRedo.createNode (1, "record", "");
root.appendChild(newNode);
var newElem = oRedo.createElement("contxml");
newNode.appendChild(newElem);
newNode.lastChild.text = escape(oContXml.documentElement.xml);
var newElem = oUndo.createElement("SKbillsheet");
newNode.appendChild(newElem);
newNode.lastChild.text = escape(SKbillsheet.outerHTML);
if (oRedo.documentElement.childNodes.length >8)	{
DeleteoRedoOneRecord(0);
}
}
function SaveoUndoOneRecord(){
var root = oUndo.documentElement	;
var newNode = oUndo.createNode (1, "record", "");
root.appendChild(newNode);
var newElem = oUndo.createElement("contxml") ;
newNode.appendChild(newElem);
newNode.lastChild.text = escape(oContXml.documentElement.xml);
var newElem = oUndo.createElement("SKbillsheet");
newNode.appendChild(newElem);
newNode.lastChild.text = escape(SKbillsheet.outerHTML);
lngUndo=lngUndo+1;
if (oUndo.documentElement.childNodes.length >8)	{
DeleteoUndoOneRecord(0);
lngUndo=7;
}
}
function ReadoRedoOneRecord(lngKey){
oContXml=SetDom(unescape(oRedo.documentElement.childNodes(lngKey).childNodes(0).childNodes(0).xml));
SKbillsheet.outerHTML=unescape(oRedo.documentElement.childNodes(lngKey).childNodes(1).childNodes(0).xml);
openobjlist();
}
function ReadoUndoOneRecord(lngKey){
oContXml=SetDom(unescape(oUndo.documentElement.childNodes(lngKey).childNodes(0).childNodes(0).xml));
SKbillsheet.outerHTML=unescape(oUndo.documentElement.childNodes(lngKey).childNodes(1).childNodes(0).xml);
openobjlist();
}
function DeleteoRedoOneRecord(intR){
oRedo.documentElement.removeChild(oRedo.documentElement.childNodes.item(intR));
}
function DeleteoUndoOneRecord(intR){
oUndo.documentElement.removeChild(oUndo.documentElement.childNodes.item(intR));
}
function cmdRedo(){
var intMaxR=oRedo.documentElement.childNodes.length - 1;
if (lngRedo>=0 && lngRedo<=intMaxR){
ReadoRedoOneRecord(lngRedo);
lngUndo=lngRedo;
lngRedo=lngRedo+1;
}
window.focus();
window.SKbillsheet.focus();
}
function cmdUndo(){
var intMaxR=oUndo.documentElement.childNodes.length - 1;
if (lngUndo>=0 && lngUndo<=intMaxR){
ReadoUndoOneRecord(lngUndo);
lngRedo=lngUndo;
lngUndo=lngUndo - 1;
}
window.focus();
window.SKbillsheet.focus();
}
function resizeStart(){
SaveoUndoOneRecord();
}
function resizeEnd(){
SaveoRedoOneRecord();
}
function moveStart(){
SaveoUndoOneRecord();
}
function moveEnd(){
SaveoRedoOneRecord();
}
function IsDivCont() {
if(curSelElement == null) return false;
if (curSelElement.id == "fcpagesub"  || curSelElement.controltype == "div" || curSelElement.controltype == "tab") return true;
return false;
}

function htmltocont(sHtml,comType,NotOne){	
	SaveoUndoOneRecord();
	
	if(curSelElement==null ){		
		SKbillsheet.innerHTML+=sHtml;		
	}else if(curSelElement.id=="fcpagesub" ){		
		curSelElement.innerHTML+=sHtml;
	}else if(curSelElement.controltype =="tab"){		
		var l=curSelElement.childNodes.length;
		for(var i=1;i<l;i++){
			if(curSelElement.childNodes(i).style.zIndex==1){
				curSelElement.childNodes(i).innerHTML+=sHtml;
				break;
			}
		}
	}else if ((curSelElement.controltype == "div" && comType != "div") || curSelElement.tagName == "TD") {
		curSelElement.innerHTML += sHtml;
	}else {
		SKbillsheet.innerHTML+=sHtml;
	}
	
	if(NotOne == "是"){
	}else {
		try{
			AddContXml(comType);
		}catch(e){}
	}
	
	blnChange = true;
	SaveoRedoOneRecord();
}

function AddContXml(comType,contID) {
	if(isSpace(contID)) contID = comType + ArrNum[comType];
	var oNode = oContXml.documentElement.selectSingleNode("//id[. ='"+contID+"']") ;

	if(oNode != null) return;
	var oNode = oContXml.documentElement.selectSingleNode(comType) ;
	if(oNode == null) {
		var sxml = new StringBuffer().append("<").append(comType).append("><id>" ).append( contID ).append( "</id></").append(comType).append(">").toString();
		var oX = SetDom(sxml);
		oContXml.documentElement.appendChild(oX.documentElement);
	}else {
		var sxml = new StringBuffer().append("<id>" ).append( contID ).append( "</id>").toString();
		var oX = SetDom(sxml);
		oNode.appendChild(oX.documentElement);
	}
	parent.objlist.execScript(new StringBuffer().append("objlist_add('").append(contID).append("','").append(comType).append("')").toString());
}

function CopyCont() {
var sAll="fc__~$#@__fc";
var stype="";
if(document.selection.type=="Control"){
var o=document.selection.createRange();
strXml="";
for(var i=0;i<o.length;i++){
var sid=o(i).id;
var svalue=o(i).value;
if(isSpace(o(i).controltype)){
for (var j=0;j<ArrName.length;j++){
if (sid.indexOf(ArrName[j])>=0){
stype=ArrName[j];
break;
}
}
}else {
stype = o(i).controltype;
}
if(isSpace(stype)) continue ;
strXml=strXml+"<Node><id>"+sid+"</id>";
strXml=strXml+"<type>"+stype+"</type></Node>";
var strHtm=o(i).outerHTML;
sAll+=strHtm;
}
}
if(sAll !=""){
sAll=trim(sAll);
CopyToPub(sAll);
SavePubData("stmpid",strXml);
return true ;
}else{
return false ;
}
}
function PasteCont() {
try{
SKbillsheet.focus() ;
}catch(e){}
var s1=window.clipboardData.getData("Text") ;
if (isSpace(s1)) return false;
var sAll="fc__~$#@__fc";
if(s1.substring(0,12)!=sAll) {
return false;
}
s1 = s1.substring(12,s1.length);
sXml=LoadPubData("stmpid");
if(isSpace(sXml)) return false;
var oXml=new ActiveXObject("Microsoft.XMLDOM");
oXml.async=false;
oXml.loadXML ("<root>"+sXml+"</root>");
var newid = "" ;
var sLen=oXml.documentElement.childNodes.length;
var arrNewId = new Array() ;
for(var i=0;i<sLen;i++){
sid=oXml.documentElement.childNodes(i).childNodes(0).text;
stype=oXml.documentElement.childNodes(i).childNodes(1).text;
newid = sid;
for(j=0;j<ArrName.length;j++){
if(stype==ArrName[j]){
if(ObjIsHave(newid)) {
newid = getNewContID(stype,oContXml,ArrNum[stype]);
}
searchStr="id="+sid+" ";
replaceStr="id="+newid+" ";
svalue="value="+sid+" ";
repvalue="value="+newid+" ";
s1=RepStr(s1,searchStr,replaceStr);
s1=RepStr(s1,svalue,repvalue);
AddContXml(stype,newid);
arrNewId[i] = newid;
break;
}
}
}
htmltocont(s1,"","是");
var oControlRange = document.body.createControlRange();
for(var i=0;i<sLen;i++){
try {
oControlRange.add(eval(arrNewId[i]));
}catch(e){}
}
try {
oControlRange.select();
}catch(e){}
if(IsDivCont() == false) curSelElement = null ;
return true;
function ObjIsHave(sid){
try{
var obj = eval(sid) ;
return true;
}catch(E){
return false;
}
}
}
function CurrSel(){
var sArray=new Array();
if(document.selection.type=="Control"){
var ii = 0 ;
var o=document.selection.createRange();
for(var i=0;i<o.length;i++){
var sid=o(i).id;
if(isSpace(sid) == false  ) {
sArray[ii]=eval(sid);
ii++ ;
}
}
}
return sArray;
}
function main_onkeydel() {
if(curSelElement == null) return;
if(curSelElement.id == "fcpagesub" || curSelElement.id == "fcpagesubtable" ) return;
main_onkeydown(46);
main_exec('Delete');
main_onkeyup(46);
}
function main_onkeyup(skeycode){
if(typeof(skeycode)=="undefined"){
var scode=event.keyCode;
}else{
var scode = skeycode;
}
if(scode == 46){
SaveoRedoOneRecord();
}
}
function main_onkeydown(skeycode,sshift,sctrl){
var sArray=CurrSel();
if(arguments.length == 0){
var scode=event.keyCode;
var skey=event.shiftKey;
var sctrlkey=event.ctrlKey;
}else{
var scode = skeycode;
var skey = sshift;
var sctrlkey = sctrl;
}
if(scode == 46){
var ltmp = sArray.length ;
for(var jj=0;jj<ltmp;jj++){
if(isSpace(sArray[jj].controltype)) {
try{
event.returnValue=false;
}catch(e){}
return ;
}
}
SaveoUndoOneRecord();
var oXml = null ;
var sxml = SKbillsheet.billtaborder;
if(isSpace(sxml) == false ){
oXml = SetDom(sxml);
}
del_cont(sArray,oContXml,oXml);
if(oXml != null){
SKbillsheet.billtaborder = oXml.documentElement.xml;
}
curSelElement = null ;
return;
}
function del_cont(arr,oContXml,oXml) {
for(var i=0; i<arr.length; i++ ){
var sid = arr[i].id;
if(isSpace(sid)) continue;
var comType = arr[i].controltype;
if(isSpace(comType)){
var l=ArrName.length ;
for(var ii=0;ii<l;ii++){
if(sid.indexOf(ArrName[ii]) == 0) {
comType = ArrName[ii];
break;
}
}
}
if(isSpace(comType)) continue;
var oNode = oContXml.documentElement.selectSingleNode(comType) ;
if(oNode != null ){
var oNodeSub = oNode.selectSingleNode("//id[. ='"+sid+"']");
if(oNodeSub != null){
oNode.removeChild(oNodeSub);
parent.objlist.execScript("objlist_del('"+sid+"')");
if(comType == "dataset"){
ShowAllField();
}
}
}
if(oXml != null){
var oNode = oXml.documentElement.selectSingleNode("//taborder[. ='"+sid+"']") ;
if(oNode != null ) {
oXml.documentElement.removeChild(oNode);
}
}
if(comType == "div") {
del_cont(arr[i].all,oContXml,oXml);
}else if (comType == "tab") {
for(var jj=1;jj<arr[i].childNodes.length;jj++){
del_cont(arr[i].childNodes(jj).all,oContXml,oXml);
}
}
}
}
if (sctrlkey==true){
switch(scode){
case 40:{
for (var s=0;s<sArray.length; s++){
sArray[s].style.top=parseInt(sArray[s].style.top)+1;
}
blnChange = true ;
event.returnValue=false;
break;
}
case 38:{
for(var M=0;M<sArray.length; M++){
sArray[M].style.top=parseInt(sArray[M].style.top)-1;
}
blnChange = true ;
event.returnValue=false;
break;
}
case 39:{
for(var t=0; t<sArray.length; t++){
sArray[t].style.left=parseInt(sArray[t].style.left)+1;
}
blnChange = true ;
event.returnValue=false;
break;
}
case 37:{
for(var N=0 ; N<sArray.length; N++){
sArray[N].style.left=parseInt(sArray[N].style.left)-1;
}
blnChange = true ;
event.returnValue=false;
break;
}
case 67:{
if(CopyCont()){
event.returnValue=false;
}
break;
}
case 86:{
if(PasteCont()){
event.returnValue=false;
}
break;
}
case 88:{
if(CopyCont()){
main_onkeydown(46);
main_exec('Delete');
main_onkeyup(46);
event.returnValue=false ;
}
break;
}
case 90:{
cmdUndo();
break;
}
case 89:{
cmdRedo();
break;
}
case 83:{
Addobj('save');
event.returnValue=false;
break;
}
case 65:{
if (sArray.length==1){
try{
if (sArray[0].controltype=="ep_band")
BandSelectAll(sArray[0]);
}
catch(e){};
}
event.returnValue=false;
break;
}
}
}
if (skey==true){
switch (scode){
case 40:{
for (var Lent=0;Lent<sArray.length;Lent++){
sArray[Lent].style.height=parseInt(sArray[Lent].style.height)+1;
}
blnChange = true ;
event.returnValue=false;
break;
}
case 38:{
for (var d=0;d<sArray.length;d++){
sArray[d].style.height=parseInt(sArray[d].style.height)-1;
}
blnChange = true ;
event.returnValue=false;
break;
}
case 39:{
for (var k=0;k<sArray.length;k++){
sArray[k].style.width=parseInt(sArray[k].style.width)+1;
}
blnChange = true ;
event.returnValue=false;
break;
}
case 37:{
for (var j=0;j<sArray.length;j++){
sArray[j].style.width=parseInt(sArray[j].style.width)-1;
}
blnChange = true ;
event.returnValue=false;
break;
}
}
}
}
function SelectObj(sid,noadd_objlist){
blnChange=true ;
if(typeof noadd_objlist == "undefined"){
if(curSelElement != null){
if (IsDivCont() ) return;
}
}
try {
var oControlRange = document.body.createControlRange();
oControlRange.add(eval(sid));
oControlRange.select();
}catch(e){}
}
function openobjlist() {
parent.objlist.document.onreadystatechange= function ()
{
if (parent.objlist.document.readyState=="complete")
{
parent.objlist.select1.options.length = 0;
var sOpt =new StringBuffer();
var l=oContXml.documentElement.childNodes.length;
for(var i=0;i<l;i++){
var l1 = oContXml.documentElement.childNodes(i).childNodes.length;
var comtype =oContXml.documentElement.childNodes(i).tagName;
for(var j=0;j<l1;j++){
sOpt.append("<option controltype='").append( comtype ).append("'>").append(oContXml.documentElement.childNodes(i).childNodes(j).text).append("</option>");
}
}
var objList = parent.objlist.select1;
objList.outerHTML = SelectAddOption(objList,sOpt.toString());
}
}
}
function ShowAllField() {
parent.objlist.cboField.options.length = 0;
var sOption = new StringBuffer();
var oNode = oContXml.documentElement.selectSingleNode("dataset");
if(oNode != null) {
var l = oNode.childNodes.length;
for(var i=0;i<l;i++){
var id = oNode.childNodes(i).text;
var ods=eval(id);
if(IsSpace(ods.formatxml)) continue ;
var oXml=SetDom(ods.formatxml);
if(oXml.documentElement == null ) continue ;
var ll=oXml.documentElement.childNodes.length;
if(ll<=1) continue;
if(ll>1) sOption.append("<OPTGROUP LABEL=\"").append(id).append("\">");
for(var j=0;j<ll;j++){
sOption.append("<option value='" ).append( oXml.documentElement.childNodes(j).childNodes(0).text ).append( "'>").append(oXml.documentElement.childNodes(j).childNodes(1).text ).append("</option>");
}
if(ll>1) sOption.append( "</OPTGROUP>") ;
}
}
parent.objlist.cboField.outerHTML = '<SELECT size=2 id="cboField" style="width:100%;height:47%" ondblclick=selectField()>' +sOption.append('</SELECT>').toString();
}
function AddBindField(dsName,fieldName,chnName) {
var sStr =new StringBuffer();
var sType = "" ;
var sWid = "";
var sHei = "20px";
var sBorder = "BORDER-RIGHT: silver 1px solid; BORDER-TOP: dimgray 2px solid; BORDER-LEFT: dimgray 2px solid; BORDER-BOTTOM: silver 1px solid;" ;
var sid = "" ;
if(curSelElement != null){
if(curSelElement.tagName.toUpperCase() == "TD"){
sWid = "100%";
sHei = "100%" ;
sBorder = "" ;
}
}
if(sWid == ""){
var sSql = "[encode]%f4%d8%e6%d8%d4%f6Xrn%ec%d2%e2%fc%e0%d6%f6%deXrn%da%f2%ec%e8Xrn%9a%94Xx%da%9a%a6%96%a6%a0%b4%b6Xrn%fc%de%d8%f2%d8Xrn%da%d6%ea%d0%e8%d8Xt%d6[/encode]'"+fieldName+"'" ;
sWid = SqlToField(sSql);
if(IsSpace(sWid)) sWid = "80px" ;
}
var sSql = "[encode]%f4%d8%e6%d8%d4%f6Xrn%e0%ea%ee%f8%f6%f4%f6%u0100%e6%d8Xrn%da%f2%ec%e8Xrn%9a%94Xx%da%9a%a6%96%a6%a0%b4%b6Xrn%fc%de%d8%f2%d8Xrn%da%d6%ea%d0%e8%d8Xt%d6[/encode]'"+fieldName+"'" ;
var sV1 = SqlToField(sSql);
if(isSpace(sV1)==false && sV1 != "NULL") {
var oo= SetDom(sV1);
if(oo.documentElement != null){
if(oo.documentElement.childNodes.length>=1) var sX0 = UnRepXml(oo.documentElement.childNodes(0).text);
if(oo.documentElement.childNodes.length>=2) var sX = UnRepXml(oo.documentElement.childNodes(1).text );
if(oo.documentElement.childNodes.length>=3) var sX2  = UnRepXml(oo.documentElement.childNodes(2).text) ;
if(oo.documentElement.childNodes.length>=4) var spubOption = UnRepXml(oo.documentElement.childNodes(3).text) ;
if(oo.documentElement.childNodes.length>=5) var spubFormat = UnRepXml(oo.documentElement.childNodes(4).text ) ;
var spubCheck ="1" ;
if(IsSpace(sX2) == false) spubCheck="2";
sType = oo.documentElement.nodeName ;
switch ( sType ) {
case 'radio':{
sid = "rdo"+fieldName ;
sStr.append('<FIELDSET id="').append(sid).append('" dataset="').append(dsName).append('"  china="').append(chnName).append('" field="').append(fieldName).append('" onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() contentEditable=false style="FONT-SIZE: 12px; WIDTH: ').append(sWid).append('; COLOR: #000000; HEIGHT: 50px; backgroundColor1: #ffffff" onmovestart=moveStart() value="-1" controltype="radio" tempvalue="').append(sX0).append('" temptext="').append(sX).append('" aspect="横向" readOnly="false" legend="').append(chnName).append('"><LEGEND>').append(chnName).append('</LEGEND>');
var rdolen = sX.split('\n') ;
var rdol = sX0.split('\n') ;
for(var jj=0; jj<rdolen.length; jj++){
sStr.append('<INPUT type=radio value="').append(rdol[jj]).append('" name=RGrdo').append(fieldName).append(' text="').append(rdolen[jj]).append('"><SPAN onclick=RGrdo').append(fieldName).append('[').append(jj).append('].checked=true;');
sStr.append('rdo').append(fieldName).append('.value=RGrdo').append(fieldName).append('[').append(jj).append('].value;RGrdo').append(fieldName).append('[').append(jj).append('].focus();>').append(rdolen[jj]).append('</SPAN>&nbsp;');
}
sStr.append('</FIELDSET>') ;
break;
}
case 'readonly':{
sid = "txt"+fieldName ;
sStr.append('<LABEL onmove=move() readOnly oncontrolselect=controlselect() id="').append(sid).append('" onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() ');
sStr.append('style="').append(sBorder).append('FONT-SIZE: 12px; WIDTH: ').append(sWid).append('; HEIGHT: ').append(sHei).append('; TEXT-ALIGN: left" onmovestart=moveStart() ');
sStr.append('controltype="text" dataset="').append(dsName).append('" value="').append(chnName).append('" CanSelect="false" china="').append(chnName).append('" field="').append(fieldName).append('"></LABEL>');
break ;
}
case 'facard':{
sid = "txt"+fieldName;
sStr.append('<LABEL onmove=move() oncontrolselect=controlselect() id="').append(sid).append('" onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() ');
sStr.append('style="').append(sBorder).append('FONT-SIZE: 12px; WIDTH: ').append(sWid).append('; HEIGHT: ').append(sHei).append('; TEXT-ALIGN: left" onmovestart=moveStart() ');
sStr.append('controltype="text" dataset="').append(dsName).append('" value="').append(chnName).append('" CanSelect="false" china="').append(chnName).append('" field="').append(fieldName).append('"></LABEL>');
var iTop = tmpTop - 1;
var iLeft = parseInt(txtLeft) + parseInt(sWid) +1 ;
var sfacard = new StringBuffer().append("SelectZlSql('").append(sX0).append("','").append(sX2).append("','").append(sX).append("')").toString() ;
sStr.append('<BUTTON onmove=move() oncontrolselect=controlselect() id=cmd_').append(fieldName).append(' onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; FONT-SIZE: 12px; LEFT: ').append(iLeft).append('; BORDER-LEFT: 0px; WIDTH: 17px; BORDER-BOTTOM: 0px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 18px; BACKGROUND-COLOR: #d4d0c8" onmovestart=moveStart() controltype="button" fc_onclick="bill_onclick(&quot;').append(sfacard).append('&quot;)" dropstyle="是"></BUTTON>');
break;
}
case 'hidden':{
sStr.append('');
break;
}
case 'checkbox':{
sid = "chk"+fieldName ;
sStr.append('<DIV onmove=move() dataset="').append(dsName).append('"  china="').append(chnName).append('" field="').append(fieldName).append('" truevalue="').append(sX0).append('" falsevalue="').append(sX).append('" oncontrolselect=controlselect() id="').append(sid).append('" onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style="TEXT-ALIGN: left; backgroundColor1: #ffffff;FONT-SIZE: 12px; WIDTH: ').append(sWid).append('; HEIGHT: 20px;" onmovestart=moveStart() noWrap value="否" falsevalue="否" truevalue="是" divtype="checkbox" controltype="checkbox"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>').append(chnName).append('</SPAN></DIV>');
break;
}
case 'date':{
sid = "txt"+fieldName ;
sStr.append('<LABEL onmove=move() oncontrolselect=controlselect() id="').append(sid).append('" onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() ');
sStr.append('style="').append(sBorder).append('FONT-SIZE: 12px; WIDTH: 80px; HEIGHT: 20px; TEXT-ALIGN: left" onmovestart=moveStart() ');
sStr.append('controltype="text" dataset="').append(dsName).append('" value="').append(chnName).append('" CanSelect="false" china="').append(chnName).append('" field="').append(fieldName).append('"></LABEL>');
var sFName = fieldName;
var Selectdt = new StringBuffer().append("SelectDate(txt").append(sFName).append(")").toString();
var Seldate = new StringBuffer().append("bill_onclick(").append(a2).append(Selectdt).append(a2).append(")").toString();
sStr.append('<BUTTON onmove=move() oncontrolselect=controlselect() id=cmd_').append(fieldName).append(' onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; FONT-SIZE: 12px; BORDER-LEFT: 0px; WIDTH: 17px; BORDER-BOTTOM: 0px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 18px; BACKGROUND-COLOR: #d4d0c8" onmovestart=moveStart() controltype="button" fc_onclick=').append(a1).append(Seldate).append(a1).append(' dropstyle="是"></BUTTON>');
break;
}
case 'textarea':{
sid = "txt"+fieldName ;
sStr.append('<TEXTAREA onmove=move() dataset="').append(dsName).append('"  china="').append(chnName).append('" field="').append(fieldName).append('" oncontrolselect=controlselect() id="').append(sid).append('" onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style="FONT-SIZE: 12px; WIDTH: ').append(sWid).append('; HEIGHT: ').append(sHei).append('" onmovestart=moveStart() cols=26 controltype="textarea" value=""></TEXTAREA>');
break;
}
case 'combobox' :{
sid = "cbo"+fieldName;
sStr.append('<SELECT onmove=move() oncontrolselect=controlselect() id="').append(sid).append('" onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() ');
sStr.append('style="FONT-SIZE: 12px; WIDTH: ').append(sWid).append('; HEIGHT: 25px; " onmovestart=moveStart() controltype="combobox" ');
sStr.append('check="').append(spubCheck).append('" dataset="').append(dsName).append('" tempvalue="').append(sX0).append('" temptext="').append(sX).append('" sql="').append(sX2).append('"  china="').append(chnName).append('" field="').append(fieldName).append('">');
sStr.append(spubOption);
sStr.append('</SELECT>');
break;
}
case 'listbox':{
sid = "lst"+fieldName;
sStr.append('<SELECT onmove=move() oncontrolselect=controlselect() id="').append(sid).append('" onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style="FONT-SIZE: 12px; ');
sStr.append('WIDTH: ').append(sWid).append('; HEIGHT: 50px; " onmovestart=moveStart() size=8 controltype="listbox"');
sStr.append('dataset="').append(dsName).append('" china="').append(chnName).append('" field="').append(fieldName).append('" check="').append(spubCheck).append('" tempvalue="').append(sX0).append('" temptext="').append(sX).append('" sql="').append(sX2).append('">');
sStr.append(spubOption);
sStr.append('</SELECT>');
break;
}
case 'dropdownlist':{
sid = "ddl"+fieldName ;
sStr.append('<IMG id="').append(sid).append('" onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() style="FONT-SIZE: 12px; ');
sStr.append('WIDTH: ').append(sWid).append('; HEIGHT: 20px; BACKGROUND-COLOR: #ffffff; backgroundColor1: #ffffff; ');
sStr.append('textalign: left; ButtonWidth: 10" onmovestart=moveStart() src="../images/ef_designer_fccode.gif" controltype="dropdownlist" ');
sStr.append('dataset="').append(dsName).append('" china="').append(chnName).append('" field="').append(fieldName).append('" check="').append(spubCheck).append('" tempvalue="').append(sX0).append('" temptext="').append(sX).append('" type="divbox" visible="是" blninput="是" blnempty="否" addrow="否" multiselect="否" sql1="').append(sX2).append('" xml="').append(spubOption).append('" format="').append(spubFormat).append('" sql2>');
break;
}
default:{
sType = "";
}
}
}
}
	if(sStr.toString() == "" && sType == "")
	{
		var divId = "";
		var labelId = "";
		var textId = "";
			
	    divId = getNewContID("div",oContXml) ;
		sStr.append('<DIV  controltype="div" id="').append(divId).append('" ');
		sStr.append('style="TEXT-ALIGN: left; noWrap LEFT: 10px; TOP: 10px; WIDTH: 250px; POSITION: absolute;  HEIGHT: 45px" > ');
		
		labelId = getNewContID("label",oContXml);
		sStr.append('<div oncontrolselect=controlselect() id="').append(labelId).append('" onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() ');
	    sStr.append( 'style="POSITION: absolute; FONT-SIZE: 12px; LEFT:0px; TOP:10px; WIDTH: 50%; HEIGHT: 20px; TEXT-ALIGN: left" ');
		sStr.append( 'controltype="label"  nowrap value="').append(chnName).append('">').append(chnName).append('</div>');
		
		textId = getNewContID("text",oContXml) ;
		sStr.append('<LABEL oncontrolselect=controlselect() id="').append(textId).append('" onresize=resize() onresizestart=resizeStart() onresizeend=resizeEnd() onmove=move() onmovestart=moveStart() onmoveend=moveEnd() ');
		sStr.append('style="').append(sBorder).append(' POSITION: absolute; FONT-SIZE: 12px; LEFT:50%; TOP:10px; WIDTH: 50%; HEIGHT: 20px; TEXT-ALIGN: left" ');
		sStr.append('controltype="text" dataset="').append(dsName).append('" value="').append(chnName).append('" CanSelect="false" china="').append(chnName).append('" field="').append(fieldName).append('"></LABEL>');
			
		sStr.append('</DIV>');
			
		AddContXml("div",divId);
		AddContXml("label",labelId);
		AddContXml("text",textId);
		
		// htmltocont(sStr,sType,"是");
		htmltocont(sStr.toString(),"div","是");
		SelectObj(divId);
	}
	if(sStr.toString() == "")
	{
		alert("当前字段默认设置为隐藏！");
	}
}
function AutoAddDsMain() {
if(fcpubvar.AutoAddField == "yes" ){
var tablename="";
var newdjsn = parent.Request.QueryString("newdjsn").toString();
if(isSpace(newdjsn)){
tablename = "UD_"+getMaxNo("BBB");
}else{
tablename="UD_"+newdjsn;
SKbillsheet.dj_sn = newdjsn;
}
var s1 = "GetSession('userid')['userid']";
var sHtml=new StringBuffer().append("<img controltype='dataset' id=DsMain opensortno=1 style='position:absolute;Left:400;Top:5;Height:47;Width:39;' src='../images/ef_designer_dataset.gif' onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onresizeend=resizeEnd() formatxml=\"<root><tr><td>mainkey</td><td>mainkey</td><td>字符</td><td>11</td><td>0</td><td>数据项</td><td></td><td></td><td>否</td><td>否</td><td>否</td><td>否</td><td>是</td><td>否</td><td>否</td><td>否</td><td></td><td></td><td>left</td><td>80</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>userid</td><td>用户ID</td><td>字符</td><td>100</td><td>0</td><td>变量默认值</td><td>" ).append( s1 ).append( "</td><td></td><td>否</td><td>否</td><td>否</td><td>否</td><td>是</td><td>否</td><td>否</td><td>否</td><td></td><td></td><td>left</td><td>80</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr></root>\" AfterScroll=\"pubdjbh=DsMain.Fields.Field['mainkey'].Value\" BeforeOpen=\"DsMain.PageSize=1;\"   saveastable=\"" ).append( tablename ).append( "\" opensql=\"[encode]%f4%d8%e6%d8%d4%f6XrnXr%d0Xrn%da%f2%ec%e8Xrn[/encode]" ).append( tablename ).append( " \" >").toString();
SKbillsheet.innerHTML += sHtml;
AddContXml("dataset","DsMain");
SKbillsheet.keyfield="mainkey";
SKbillsheet.toolbar = "单表输入工具栏";
var newdjtype = parent.Request.QueryString("newdjtype").toString();
if(isSpace(newdjtype)==false)
SKbillsheet.type = newdjtype;
var newdjname = parent.Request.QueryString("newdjname").toString();
if(isSpace(newdjname)==false)
SKbillsheet.caption = unescape(newdjname);
}
}
function AutoAddQueryDj(){
var allbak = SKbillsheet.innerHTML;
DsMain.id="PubQueryGridDs"
PubQueryGridDs.opensortno="5";
PubQueryGridDs.opensql = "";
PubQueryGridDs.saveastable="";
PubQueryGridDs.BeforeOpen="ActionQueryCond();";
SKbillsheet.innerHTML =new StringBuffer().append('<DIV onmove=move() oncontrolselect=controlselect() id=divQueryFilter onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() onresize=resize() style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; OVERFLOW-Y: scroll; LEFT: 1px; OVERFLOW-X: scroll; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 97%; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 11px; HEIGHT: 214px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">' ).append( allbak ).append( '</DIV><IMG id=PubQueryGrid onresizeend=resizeEnd() onresizestart=resizeStart() onmoveend=moveEnd() style="LEFT: 1px; WIDTH: 979px; POSITION: absolute; TOP: 229px; HEIGHT: 289px" onmovestart=moveStart() src="http://localhost/WebBill/fceform/images/ef_designer_webgrid.gif" controltype="grid" dataset="PubQueryGridDs" canselect="是" autoheight="是" autowidth="是" autoappend="否" readonly="否" visible="是" titlerowheight usertitle="否" iscrosstab="否" rcount="否" rsum="否" rmin="否" rmax="否" ravg="否" ccount="否" csum="否" cmin="否" cmax="否" cavg="否" titlerows usertitlehtml crosstabtitle crosstabdatatype crosstabsumtype crosstabformat rowtitle coltitle crosstabsql>' ).append( PubQueryGridDs.outerHTML).toString();
var o=window.document.all.tags("button");
var l=o.length;
for(var ii=0;ii<l;ii++){
o[ii].style.display="none";
}
SKbillsheet.dj_sn = SKbillsheet.dj_sn+"_auto_query";
SKbillsheet.toolbar="查询工具栏" ;
curdjid=0;
DesignDjSave("不提示");
}
function e_open_ebiao_form(){
var obj = parent.dialogArguments;
var s1 = obj.eform_winprop;
if(typeof s1 == "undefined") s1="";
var sRet=DjOpen('eb_parawin',s1,'展现',"有模式窗口","直接","设置窗口相关属性");
if(IsSpace(sRet) == false){
obj.eform_winprop = sRet;
}
}
function GenerateHtml(){
	var xml = new StringBuffer().append("<djid>").append(SKbillsheet.dj_sn).append("</djid>").toString();	
	var retX=SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append( fcpubdata.servletPath ).append( "/WebDesign").append(fcpubdata.dotnetVersion).append("?generateHtml").toString(),xml);
	alert(retX);
}

