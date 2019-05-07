
����
/*------------------------------------------------------------------------*
 *ҳ���ʼ������������������������������                                      ��*
 * js_io_smartInput_buildDiv();    //��[��ʾ���ҳ��]��ʼ��ʱ������           *
 * document.onkeydown = js_io_smartInput_responseUpDownEnterKey;          *
 *    ����������������������������������//��[����Ƕҳ��]��Ӧ"��,��,ȷ����"�¼�  ��  *
 *------------------------------------------------------------------------*/

/**
* @param obj : ������� "�ı������"
* @param urlName: ��ѯҳ�� "smartInput.jsp"����� "��Ӧ�ô˿ؼ���ҳ��"��·��
* @param smartInputSQL:��ѯ�� SQL���
* @param backCellsName�������ֶ��б�,Ҫ��:1.��һ��Ϊ"����"��ʶ��(��ֵΪ 0:����,1:�����ݿ���ȡ��)
*                       ÿ�ֶ���ҳ������ҪΨһ����˳��Ҫ�� SQL �������ȫһ��)",���ֶμ��� [:] ����,����Ҫ���ص��á�NULL�����档
* @param viewCellsName : ��Ҫ��ʾ���ֶεı�ͷ��,���ֶμ��� [:] ����
* @param viewCellsIndex����Ҫ��ʾ���ֶ���"��ѯ�ֶ��б�"�е�λ��,�� 0��ʼ�����ֶμ��� [:] ������
* @param isShowWidget [��ֵ��<input isShowWidget='' >��ȡ,default=1]:   �ؼ��Ƿ�Ҫ��ʾ, 0: ����  1������Ϊ:��ʾ
* @param isNewAllow   [��ֵ��<input isNewAllow='' >��ȡ,default=1]:     �Ƿ������û�������������, 0:������   1:����
                         ���[0:������]��:�û���[Esc]��,��[Tab]��,�����ؼ����Ϸ�[X]ʱ,���û��������������յ�
* */
	function js_io_smartInput_onfocus(obj,urlName,smartInputSQL,backCellsName,viewCellsName,viewCellsIndex){
    	var isShowWidget = obj.getAttribute("isShowWidget");
    	if(isShowWidget == null || isShowWidget == ""){
        	isShowWidget = "1";
        }
        var isNewAllow = obj.getAttribute("isNewAllow");
        if(isNewAllow == null || isNewAllow == ""){
         	isNewAllow = "1";
        }
    	if(isShowWidget == "1"){
            //���ò���������cookie��
            	var smartInputName = obj.name;   //����smartInput�ؼ��ġ���������֡�
        	js_io_smartInput_setParam(smartInputSQL,backCellsName,viewCellsName,viewCellsIndex,isNewAllow,isShowWidget,smartInputName);
        	js_io_smartInput_fillFrame('smartInputFrame',urlName); //����
    		js_io_smartInput_textTail();                           //�ı����ý���ʱ��������������
    	}else{
        	js_io_smartInput_setCookie("isShowWidget","0");
      	}
    }

	/*  @���Ĳ���Ƕ�����Ƕ���ҳ��
   		@param myFrame : �����
  		@param url     : �������ʾ��ҳ�� url
	*/
	function js_io_smartInput_fillFrame(myFrame,url){
    	var  cal=document.getElementById(myFrame);          //��ȡ����Ƕ�Ŀ��
    	cal.src = url;
	}

	//���ò���������cookie��
	function js_io_smartInput_setParam(smartInputSQL,backCellsName,viewCellsName,viewCellsIndex,isNewAllow,isShowWidget,smartInputName){
        //���ԭ��Cookie��ֵ
    	/*js_io_smartInput_clearCookie("smartInputSQL");
    	js_io_smartInput_clearCookie("backCellsName");
    	js_io_smartInput_clearCookie("viewCellsName");
    	js_io_smartInput_clearCookie("viewCellsIndex");
    	js_io_smartInput_clearCookie("isNewAllow");
    	js_io_smartInput_clearCookie("smartInputName");
    	js_io_smartInput_clearCookie("isShowWidget");*/
        //�����µ�Cookie
    	js_io_smartInput_setCookie("smartInputSQL",smartInputSQL);
    	js_io_smartInput_setCookie("backCellsName",backCellsName);
    	js_io_smartInput_setCookie("viewCellsName",viewCellsName);
    	js_io_smartInput_setCookie("viewCellsIndex",viewCellsIndex);
    	js_io_smartInput_setCookie("isNewAllow",isNewAllow);
    	js_io_smartInput_setCookie("smartInputName",smartInputName);
    	js_io_smartInput_setCookie("isShowWidget",isShowWidget);
    }

	/**
	* �ı�����Ӧ�û����̶���
	* @param obj : �ı������
	* @param myColor:������ʾ����ɫ
	* */
    function js_io_smartInput_responseKey(obj,myColor){
    	var cal=document.getElementById("martInputDiv");
    	if(js_io_smartInput_getCookie("isShowWidget") == "1"){
   	 if(event.keyCode==27 || event.keyCode==9){	 //��[Esc][Tab]
    		if(cal.style.display != "none"){
    			js_io_smartInput_closeDiv();
                }
   	 }else if(event.keyCode==40){//���¼�ͷ���������Ƶ�SmartInput��
              //����ؼ�������ʾ,���ҿؼ������صģ���������ʾ
            if(cal.style.display == "none"){
            	js_io_smartInput_showDiv(obj); //��ʾ��
            }else{
            	js_io_smartInput_goDown('smartInputBody','smartInputTable',myColor);
            }
        }else if(event.keyCode == 13 || event.keyCode == 20 || event.keyCode == 16 || event.keyCode == 17){
        }else{
            if(js_io_smartInput_getCookie("isShowWidget") == "1" && cal.style.display == "none"){
            	js_io_smartInput_showDiv(obj); //��ʾ��
            }
            js_io_smartInput_ref(obj);	                         //��������ִ��SmartInput����
        }
      }
    }

	/*������������
    *@param backCellsName ����Ҫ��յ�<input>���ִ�����<input>�����ԡ������ֿ�
    */
	function js_io_smartInput_clearInput(cellsArray){
        for(var i=1;i<cellsArray.length;i++){
            if(cellsArray[i] != "NULL" && document.all(cellsArray[i]) != null){
            	document.all(cellsArray[i]).value = "";
            }
        }
	}

/*��������¼����������������������㡱�ڣ���������ʾ����ѯ������ĵ�һ��
  @param smartInputBody  : �����Ƕҳ��body��id �磺<body id="smartInputBody">
  @param smartInputTable : ��ʾ����ѯ�������table��id���磺<table id="smartInputTable">
  @param myColor : ������ʾ����ɫ����ΪСд����#ff0000��
*/
function js_io_smartInput_goDown(smartInputBody,smartInputTable,myColor){
 	var objBody = document.smartInputFrame.document.getElementById(smartInputBody);   //<body> Object
    objBody.focus();                              //�ò���Ƕҳ���ý���
    var smartInputTable = document.smartInputFrame.document.getElementById(smartInputTable);  //<table> Object
    var colCount = smartInputTable.rows.length;                                  //��������
    if(colCount > 0){
       var myCol =  smartInputTable.rows(1);
    	myCol.style.backgroundColor=myColor;
    }
}

/* @��Ӧÿһ��keyUp�¼��������������ύ�����㣢�ڴ���
   @param  obj  : �������¼��Ķ���
*/
function js_io_smartInput_ref(obj) {
     if(document.smartInputFrame!=null&&document.smartInputFrame.smartInputResponseForm!=null){
		document.smartInputFrame.smartInputResponseForm.smartInputCode.value = obj.value;
		document.smartInputFrame.smartInputResponseForm.submit()
		return true;
     }
}

      /**�ɼ�[Esc][Tab]�رհ�ť[X]�رղ�ʱ�����κ���
      *
      * */
      function js_io_smartInput_closeDiv(){
      	    var cal=document.getElementById("martInputDiv");
            js_io_smartInput_hideDiv(cal);
            //��ԭ��������ʶ��
            var backCellsName = js_io_smartInput_getCookie("backCellsName");
       		 var cellsArray = backCellsName.split(":");//���� backCellsName
            if(cellsArray[0] != "NULL" && document.all(cellsArray[0]) != null){
            		document.all(cellsArray[0]).value = "0";
        	}
            //�����������������,�����е�ֵ���
            var isNewAllow = js_io_smartInput_getCookie("isNewAllow");
            if(isNewAllow == "0"){
            	js_io_smartInput_clearInput(cellsArray);
            }
            //��������������
            var smartInputName = js_io_smartInput_getCookie("smartInputName");
            document.all(smartInputName).focus();
  		}

		/*@desc  ��Ӧ[������\��\ȷ����],������ʾ�û�ѡ������
        @param event           (ϵͳ�¼�)
        @param smartInputTable :        ��Ҫ��Ӧ�����¼��ı��"id
        @param hightLightColor: ��ѡ���е���ɫ
        @param lowLightColor:   δ��ѡ���е���ɫ
        @memo  ��ɫ��ҪСд
        Ӧ��ʾ����document.onkeydown = js_io_smartInput_responseUpDownEnterKey;    //ҳ����Ӧ"��,��,��,ȷ����"�¼�
        */
    	function js_io_smartInput_responseUpDownEnterKey(){
            var smartInputTable = document.getElementById("smartInputTable");  //������
            var hightLightColor = '#ff0000';                   //"������ʾ"����ɫ
            var lowLigthColor = '';                            //"δѡ��"�е���ɫ
            var colCount = smartInputTable.rows.length;                  //��������
            if(event.keyCode==38){ //���ϼ�
                for(i=1;i<colCount;i++){
                	if(smartInputTable.rows(i).style.backgroundColor == hightLightColor){
                        smartInputTable.rows(i).style.backgroundColor = lowLigthColor;
                    	if(i==1){
                        	smartInputTable.rows(colCount - 1).style.backgroundColor = hightLightColor;
                        }else{
                         	smartInputTable.rows(i-1).style.backgroundColor = hightLightColor;
                        }
                        break;
                    }
                }
            }else if(event.keyCode==40){��//���¼�
                for(i=1;i<colCount;i++){
                	if(smartInputTable.rows(i).style.backgroundColor == hightLightColor){
                        smartInputTable.rows(i).style.backgroundColor = lowLigthColor;
                    	if(i==(colCount - 1)){
                        	smartInputTable.rows(1).style.backgroundColor = hightLightColor;
                        }else{
                         	smartInputTable.rows(i+1).style.backgroundColor = hightLightColor;
                        }
                        break;
                    }
                }
            }
            else if(event.keyCode == 13){  //ȷ����
                var hightLightCol ;   //�û�ѡ�е�"�����һ��"[����]
                for(i=0;i<colCount;i++){
                 	if(smartInputTable.rows(i).style.backgroundColor == hightLightColor){
                    	hightLightCol = smartInputTable.rows(i);
                        js_io_smartInput_returnValue(hightLightCol);
                    }
                }
            }
            else if(event.keyCode == 27 || event.keyCode==9){  //[Esc][Tab] �� = ���ز�,�������
            	parent.window.js_io_smartInput_closeDiv();
            }else if(event.keyCode == 37){ //�����ͷ
            	//��������������
            	var smartInputName = js_io_smartInput_getCookie("smartInputName");
           		parent.document.all(smartInputName).focus();
            }
   		 }

        /**
    	* ���ز�ѯ���
        * @param hightLightCol ��ѡ�е��ж���
        * */
        function js_io_smartInput_returnValue(hightLightCol){
        	var backFieldStr = js_io_smartInput_getCookie("backCellsName");
        	var backFieldArray = backFieldStr.split(":");

        	for(var i=1;i<backFieldArray.length;i++){
                if(backFieldArray[i] != "NULL" && parent.document.all(backFieldArray[i]) != null){
                	if(parent.document.all(backFieldArray[i]).type=="select-one") {
                        	if(hightLightCol.getAttribute(backFieldArray[i])==""){
                           		parent.document.all(backFieldArray[i]).selectedIndex = 0;
                        	}else{
                            		parent.document.all(backFieldArray[i]).value = hightLightCol.getAttribute(backFieldArray[i]);
                        	}
                    	}else{
                 	 	parent.document.all(backFieldArray[i]).value = hightLightCol.getAttribute(backFieldArray[i]);
                    	}
                }
            }
            if(backFieldArray[0] != "NULL" && parent.document.all(backFieldArray[0]) != null){
                parent.document.all(backFieldArray[0]).value = "1"; //"������ʶ"��־Ϊ�������ݿ�ȡ��
            }
			//�����˲�ѯ����󣬽���ѯ�ؼ�����
            var cal = parent.document.getElementById("martInputDiv");
            js_io_smartInput_hideDiv(cal);
            //��������������
            var smartInputName = js_io_smartInput_getCookie("smartInputName");
            parent.document.all(smartInputName).focus();
        }




/**----------------------------------------------------------------------------------------
* �ؼ���ܻ������ƺ���
* ----------------------------------------------------------------------------------------*/

   var browserName=navigator.appName;
   var isIE=browserName.indexOf("Microsoft")!=-1?true:false;

  /*����̬�������㣢��*/
  function js_io_smartInput_buildDiv()
  {
      document.write("<div id='martInputDiv' style=\"display:none;position:absolute;width:220;background:#DEE5FF;z-index:100\">");
      document.write("<table width='220' align='center' border='1' bordercolorlight='#000000' bordercolordark='#FFFFFF' >");
      document.write("<tr><td align='left' width='195'><font color='#FF0000'>����������������</font></td>");
      document.write("<td  align=\"center\" width='25'><span title=�ر� style=\"CURSOR: hand;color:#FF0000;font-size:12px;font-weight:bold;margin-right:4px;\" onclick=js_io_smartInput_closeDiv() >��</span>");
      document.write("</td></tr>");
      document.write("<tr><td colspan='2'>");
      document.write("<iframe id=\"smartInputFrame\"  border=\"0\" frameborder=\"0\" framespacing=\"0\" marginheight=\"10\" name=\"smartInputFrame\" noResize scrolling=\"auto\" src=\"\"  vspale=\"0\" width=\"100%\" height=\"240\"></iframe>");
      document.write("</td></tr>");
      document.write("</table>");
      document.write("</div>");
	  var cal=document.getElementById("martInputDiv");
	  js_io_smartInput_hideDiv(cal);
  }��

��/*���أ��㣢 */
  function js_io_smartInput_hideDiv(cal){ cal.style.display="none"; }

  /* ��ʾ���㣢��*/
  function js_io_smartInput_showDiv(obj){
        var cal=document.getElementById("martInputDiv");
     	 var desTxtId=obj;
	  	cal.style.display="";
	  	vtop=js_io_smartInput_offsetTop(obj);
	  	vheight=obj.offsetHeight;
    	 vwidth=obj.offsetWidth;
    	 vleft=js_io_smartInput_offsetLeft(obj)+vwidth;
	  	if(isIE)
	 	 {
	    	 if(vtop+cal.offsetHeight>document.body.scrollTop+document.body.clientHeight)
	     	   vtop=vtop+vheight-cal.offsetHeight;
	    	 if(vleft+cal.offsetWidth>document.body.scrollLeft+document.body.clientWidth)
	      	 vleft=js_io_smartInput_offsetLeft(obj)-cal.offsetWidth;
	    	 cal.style.top=vtop;
	    	 cal.style.left=vleft;
	 	 }
	  	else
	  	{
        	if(vtop+cal.offsetHeight>window.innerHeight)
	      	    vtop=vtop+vheight-cal.offsetHeight;
        	if(vleft+cal.offsetWidth>window.innerWidth)
	       	   vleft=js_io_smartInput_offsetLeft(obj)-cal.offsetWidth;
        	cal.style.top=vtop;
        	cal.style.left=vleft;
	 	 }
  }

��/*���ò��봰����ߵĳ���*/
  function js_io_smartInput_offsetLeft(obj)
  {
    x = obj.offsetLeft;
    for (objParent=obj.offsetParent;objParent;objParent=objParent.offsetParent)x+=objParent.offsetLeft;
    return x;
  }

��/*���ã��㣢�봰�ڶ����ĳ���*/
  function js_io_smartInput_offsetTop(obj)
  {
     y = obj.offsetTop;
     for(objParent=obj.offsetParent;objParent;objParent=objParent.offsetParent)y+=objParent.offsetTop;
     return y;
  }





/**---------------------------------------------------------------------------------------------
* �Ӿ�Ч�����ƺ���
* ---------------------------------------------------------------------------------------------*/

        /*����������������:������ڱ���һ��,������̬�Ӿ�Ч��*/
          //���� һ
          function js_io_smartInput_sbar(st){
               var hightLightColor = '#ff0000';                  //"������ʾ"����ɫ
           	 	st.style.backgroundColor = hightLightColor ;
          }
          //���� ��
          function js_io_smartInput_cbar(st){
          		var lowLigthColor = '';                            //"δѡ��"�е���ɫ
           	 	st.style.backgroundColor = lowLigthColor;
          }

          /*����: ���ı��������뽹��ʱ,����������ı���(text)���ֵ����(Tail)*/
   		  /*�÷�: <input type=text name=text1 value="123" onfocus="js_io_smartInput_textTail()"> */
          function js_io_smartInput_textTail() {
        	 var e = event.srcElement;
         	 var r =e.createTextRange();
        	 r.moveStart('character',e.value.length);
        	 r.collapse(true);
        	 r.select();
          }



/**-----------------------------------------------------------------------------------------
* ���� Cookie
* -----------------------------------------------------------------------------------------*/

		/** ����Cookie
		* @param key Cookie�ı�ʶ
		* @param value Cookie��ֵ
		* */
		function js_io_smartInput_setCookie(key,value) {
    		document.cookie = key + "=" + value + ";path=/";
		}

        /*��cookie�ж�ȡ����*/
        function js_io_smartInput_getCookie(key) {
        	var search = key + "=";
        	var returnvalue = "";
        	if (document.cookie.length > 0) {
        		offset = document.cookie.indexOf(search);
        		if (offset != -1) {
        			offset += search.length
       				end = document.cookie.indexOf(";", offset);
        			if (end == -1)
        				end = document.cookie.length;
       					returnvalue = unescape(document.cookie.substring(offset,end))
        		}
        	}
        	return returnvalue;
        }

		/** ���cookie
		* @param key Cookie��Ψһ��ʶ
		**/
		function js_io_smartInput_clearCookie(key) {
            if(js_io_smartInput_getCookie(key) != ""){
    			document.cookie = key + "=";
            }
		}


