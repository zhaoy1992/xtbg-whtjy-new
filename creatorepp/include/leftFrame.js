var layerTop=0;       //�˵����߾�
var layerLeft=0;      //�˵���߾�
var layerWidth=234;    //�˵��ܿ��
var contentHeight; //�������߶�
var stepNo=10;         //�ƶ���������ֵԽ���ƶ�Խ��
var titleHeight=stepNo*2;    //�������߶�


var toItemIndex;
var onItemIndex;
var oldClickedItem= -1;
var isMoving=0;
var copyrightHeight=0;

var itemNodes = new Array; //�˵�������
var itemNo=0;			//�˵�������

function itemNode(itemId,itemTitle,action,isClicked)
{	
	this.itemId=itemId;
	this.itemTitle=itemTitle;
	this.action=action;
	this.isClicked=isClicked;
}

function init(n)			//����һ����Ϊ"itemsLayer"�Ĳ㣬�����������в˵�����ʾ��Χ��
{
	document.write('<div id="itemsLayer" '+
		'style="position:absolute;overflow:hidden;'+
		'border:1px solid #1954BD;left:'+layerLeft+';top:'+
		layerTop+';width:'+layerWidth+';">');
	copyrightHeight=stepNo*3+document.body.offsetHeight%stepNo;
	contentHeight=document.body.offsetHeight - n*titleHeight-copyrightHeight;
}

function finishIt()
{
	document.write('</div>');   //����"itemsLayer"��
	//����"itemsLayer"��ĸ߶ȣ�
	itemsLayer.style.height = itemNo*titleHeight+contentHeight+2;
	var copyrightTop=itemsLayer.style.height;
	
	document.write('<div style="position:absolute;top:'+copyrightTop+';left:0;width:'+(layerWidth)+';'+
	';color:white;"><iframe name=copyright width='+(layerWidth)+
	' height='+copyrightHeight+' border=0 frameborder=no scrolling=no hidefocus=true></iframe></div>');
	var doc;
	doc=copyright.window.document;
	doc.write('<html><body bgcolor=#1954BD leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" oncontextmenu="return false" onselectstart="return false" ondragstart="return false">'+
	'<img style="cursor:default;" src="../images/itemBottom.gif" width=100% height=100% border=0>'+
	'<span style="position:absolute;font-size:9pt;COLOR: #FFE074;top:2;left:0;border:0;width:100%;height:100%;text-align:center;cursor:default;'+
	'vertical-align:center;FILTER:DropShadow(Color=#001E88, OffX=-1, OffY=1, Positive=1);">&#169;��Ȩ����&nbsp;2003<br>ChinaCreator</span></body></html>');	

	doc.close();
}

function addItem(itemId,itemTitle,action)  //�������׼�����ܲ˵���������ݵ�д��
{
	itemNodes[itemNodes.length] = new itemNode(itemId,itemTitle,action,0);

	itemHTML='<div id=item'+itemNo+' itemIndex='+itemNo+
	' style="position:relative;left:0;top:-'+(contentHeight*itemNo)+
	';width:'+layerWidth+';z-index:'+(itemNo+1)+';background-color:#B9CEF0">'+
    '<table width=100% cellspacing="0" cellpadding="0" border=0>'+
    '<tr><td height='+titleHeight+' align=center>'+
	'<iframe scrolling=no STYLE="background-color: #B9CEF0" allowTransparency="true" FRAMEBORDER="no" width='+(layerWidth-1)+' height=100% border=0 name=title_'+itemNo+' hidefocus=true></iframe>'+
	'</td></tr><tr><td height='+contentHeight+' class="contentStyle">'+
    '<iframe class="contentdiv1" scrolling=auto STYLE="background-color: #B9CEF0" allowTransparency="true" FRAMEBORDER="no" border=0 name=content_'+itemNo+' hidefocus=true></iframe></td></tr></table></div>';
	document.write(itemHTML);
	var doc;
	eval('doc=title_'+itemNo+'.window.document');
	doc.write('<html><body bgcolor=#B9CEF0 leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" oncontextmenu="return false" onselectstart="return false" ondragstart="return false">'+
	'<img style="cursor:hand;" onclick="parent.clickItem('+itemNo+')" src="../images/item.gif" width=100% height=100% border=0>'+
	'<span onclick="parent.clickItem('+itemNo+')" style="position:absolute;font-size:10pt;COLOR: #ffffff;top:4;left:0;border:0;width:100%;height:100%;text-align:center;cursor:hand;'+
	'vertical-align:center;FILTER:DropShadow(Color=#001E88, OffX=-1, OffY=1, Positive=1);">'+itemTitle+'</span></body></html>');
	
	itemNo++;

	toItemIndex=itemNo-1;
	onItemIndex=itemNo-1;
}


//��д�������ʱ�ƶ���Ӧ�Ĳ㣺
//��ʼ������"toItemIndex"��"onItemIndex"�����Ƿֱ����ڼ�¼"Ӧ����ʾ�Ĳ�"��"������ʾ�Ĳ�":

var runtimes=0;  //"runtimes"���ڼ�¼���ƶ�����
//�˵����ⱻ���ʱ�������������
function clickItem(itemIndex)
{
	if(itemNodes[itemIndex].isClicked == 0)
	{
		itemNodes[itemIndex].isClicked = 1;
		var FrameName='window.frames['+(itemIndex*2+1)+']';
		//var url = itemNodes[itemIndex].action+"&FrameName="+FrameName;
		var url = itemNodes[itemIndex].action;
		eval(FrameName+'.location.href="'+url+'"');
	}

	if(oldClickedItem==itemIndex)
		return;
	
	if(!isMoving)
	{
		changeItem(itemIndex);
		oldClickedItem=itemIndex;
	}
}

function changeItem(clickItemIndex)
{
	isMoving=1;
	//�ж���Ӧ�Ĳ�Ӧ���ƻ������ƣ�
	toItemIndex=clickItemIndex;
	if(toItemIndex-onItemIndex>0) 
		moveUp();
	else 
		moveDown();
    //һ����ʱ����������ƶ���ֱ�������趨�Ĳ���stepNo:
   	runtimes++;
   	if(runtimes>=stepNo)
	{
     	onItemIndex=toItemIndex;
     	runtimes=0;
		isMoving=0;
	}
   	else
     	setTimeout("changeItem(toItemIndex)",20);
}
//��Ӧ�˵����ƣ�
function moveUp()
{
	//alert(onItemIndex+';'+toItemIndex);
	//�ж�Ӧһ�����ƵĲ˵���������(��)ÿ���ƶ�contentHeight/stepNo�ľ��룺
	for(i=onItemIndex+1;i<=toItemIndex;i++)
    	eval('document.all.item'+i+'.style.top=	parseInt(document.all.item'+i+'.style.top)-contentHeight/stepNo;');
}
  //��Ӧ�˵����ƣ�
function moveDown()
{
	//alert(onItemIndex+';'+toItemIndex);
	for(i=onItemIndex;i>toItemIndex;i--)
    	eval('document.all.item'+i+'.style.top=	parseInt(document.all.item'+i+'.style.top)+contentHeight/stepNo;');
}