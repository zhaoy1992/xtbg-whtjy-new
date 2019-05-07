/**
*��ʾͼ��
*@date 2003-07-31
**/
function ShowGraph(){
//����ͼ�η���
/*
<div type="graph" id=g1 dataset=dssub1 other="" style="position:absolute;left:0;top:30;height:200;width:300">
graphtype="ֱ��ͼ/����ͼ/Բ��ͼ"
garphxml="
   <root>
      <samplevalues>
            <field>�ֶ�</field>
            <field>�ֶ�</field>
			...
      </samplevalues>
      <samplelabels>
            <field>�ֶ�</field>
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

		//�������ݴ�
		var ssamplevalue="sampleValues"	;		
		var s1='';
		var inum=0;
		var s3='<param name=seriesLabels value="';  //���ֶ���������
		if(oXml.documentElement.childNodes(0).childNodes.length >1){
			ssamplevalue="sampleValues_0";
			//����ʱ������������
			s1+='<param name=seriesCount value="'+oXml.documentElement.childNodes(0).childNodes.length +'">';
	
		}
		for (var j=0;j<oXml.documentElement.childNodes(0).childNodes.length ;j++) {
			s1+='<param name="'+ssamplevalue+'" value=" ';

			var colno=dssub1.FieldNameToNo(oXml.documentElement.childNodes(0).childNodes(j).text);
			s3+=dssub1.Fields.Field[colno].DisplayLabel+",";
			for(var i=0;i<dssub1.oDom.documentElement.childNodes.length-1;i++){
				s1+=dssub1.oDom.documentElement.childNodes(i).childNodes(colno).text+",";
			}
			s1=s1.substring(0,s1.length-1);   //ȥ������,��  
			s1+='">';
			
			inum++;
			ssamplevalue="sampleValues_"+inum;
		}
		
		
		//������⴮
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
		   case "����ͼ" :
		       sType=" code=cn.com.fcsoft.chart.LineChartApplet ";
		       break;
		   case "Բ��ͼ" :
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
			sAll+=obj.other; //��������
		sAll+='</Applet>';
		//CopyToPub(sAll)
		var sdiv="<div style='position:absolute;left:"+obj.style.left+";top:"+obj.style.top+";width:"+obj.style.width+";height:"+obj.style.height+"'>";
		//obj.innerHTML=sAll		
		obj.outerHTML=sdiv+sAll+"</div>";
}
/**
*����ͼ�η��
*@param divGraph Ϊdiv����
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
*��ӡͼ��,
*@param g1 ͼ�οؼ�ID
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
