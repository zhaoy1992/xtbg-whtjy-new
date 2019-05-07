/**
*显示图形
*@date 2003-07-31
**/
function ShowGraph(){
//计算图形分析
/*
<div type="graph" id=g1 dataset=dssub1 other="" style="position:absolute;left:0;top:30;height:200;width:300">
graphtype="直方图/折线图/圆饼图"
garphxml="
   <root>
      <samplevalues>
            <field>字段</field>
            <field>字段</field>
			...
      </samplevalues>
      <samplelabels>
            <field>字段</field>
      </samplelabels>
   </root>
   "
</div>
*/
	var o=window.document.all.tags("img");
	for(var ii=0;ii<o.length;ii++){
		if(o[ii].type=="graph"){
			
			ShowOneGraph(o[ii]);
		}	
	}



}
function ShowOneGraph(obj){
		var iWidth=obj.style.pixelWidth;
		var iHeight=obj.style.pixelHeight;
		var dssub1=eval("window."+obj.datasetdata);
		
		var sXml=obj.graphxml;
		var oXml=new ActiveXObject("Microsoft.XMLDOM");
		oXml.async=false;
		oXml.loadXML (sXml);

		//计算内容串
		var ssamplevalue="sampleValues"	;		
		var s1='';
		var inum=0;
		var s3='<param name=seriesLabels value="';  //存字段中文名串
		if(oXml.documentElement.childNodes(0).childNodes.length >1){
			ssamplevalue="sampleValues_0";
			//多列时加上列数属性
			s1+='<param name=seriesCount value="'+oXml.documentElement.childNodes(0).childNodes.length +'">';
	
		}
		for (var j=0;j<oXml.documentElement.childNodes(0).childNodes.length ;j++) {
			s1+='<param name="'+ssamplevalue+'" value=" ';

			var colno=dssub1.FieldNameToNo(oXml.documentElement.childNodes(0).childNodes(j).text);
			s3+=dssub1.Fields.Field[colno].DisplayLabel+",";
			for(var i=0;i<dssub1.oDom.documentElement.childNodes.length-1;i++){
				s1+=dssub1.oDom.documentElement.childNodes(i).childNodes(colno).text+",";
			}
			s1=s1.substring(0,s1.length-1);   //去掉最后的,号  
			s1+='">';
			
			inum++;
			ssamplevalue="sampleValues_"+inum;
		}
		
		
		//计算标题串
		var colno=dssub1.FieldNameToNo(oXml.documentElement.childNodes(1).childNodes(0).text);
		var s2='<param name="sampleLabels" value=" ';
		for(var i=0;i<dssub1.oDom.documentElement.childNodes.length-1;i++){
			s2+=dssub1.oDom.documentElement.childNodes(i).childNodes(colno).text+",";
		}
		s2=s2.substring(0,s2.length-1);
		s2+='">';
		
		//<param name=seriesLabels value="Data A,Data B">
		s3=s3.substring(0,s3.length-1);
		s3+='">';
		
		var sType="";
		switch (obj.graphtype)  {
		   case "折线图" :
		       sType=" code=cn.com.fcsoft.chart.LineChartApplet ";
		       break;
		   case "圆饼图" :
		       sType=" code=cn.com.fcsoft.chart.PieChartApplet ";
		       break;
		   default :
		       sType=" code=cn.com.fcsoft.chart.BarChartApplet ";
	
		}
		var sAll='<Applet archive="'+fcpubdata.Path+'/fceform/common/chart.jar" ondblclick="SetGraph()" ';
			sAll+=" width="	+iWidth+" ";
			sAll+=" height=" +iHeight+" ";
		
		sAll+=sType;
		sAll+=' >';
		sAll+=s1+s2+s3;
		if(isSpace(obj.other)==false)
			sAll+=obj.other; //其它属性
		sAll+='</Applet>';
		//CopyToPub(sAll)
		var sdiv="<div style='position:absolute;left:"+obj.style.left+";top:"+obj.style.top+";width:"+obj.style.width+";height:"+obj.style.height+"'>";
		//obj.innerHTML=sAll		
		obj.outerHTML=sdiv+sAll+"</div>";
}
/**
*设置图形风格
*@param divGraph 为div对象
**/
function SetGraph(divGraph){
	//var divGraph=event.srcElement
	//if(divGraph.tagName.toUpperCase()!="DIV")
	//	divGraph=divGraph.parentNode
	//alert(divGraph.tagName)	
	var arr=new Array();
	arr[0]=divGraph.graphtype;
	arr[1]=divGraph.other;

	var arrRet=window.showModalDialog(fcpubdata.Path+"/fceform/common/setgraph.htm",arr,"status:no;dialogHeight:500px;dialogWidth:470px;center:yes"); 
	
	if(arrRet[0]!=""){
		divGraph.graphtype=arrRet[0];
		divGraph.other=arrRet[1];

		ShowGraph();
	}
}
/**
*打印图形,
*@param g1 图形控件ID
*@date 2003-12-16
**/
function PrintGraph(g1){
	var s1=g1.innerHTML;
    var sRet=window.showModalDialog(fcpubdata.Path+"/fceform/common/printgraph.htm",s1,"status:no;scroll:no;dialogHeight:2px;dialogWidth:5px;") ;
	//window.open("printgraph.htm")
	
}


// initialization hook up
if ( typeof window.attachEvent != "undefined" ) {
	window.attachEvent( "onload", ShowGraph );
	
}

