 <!--
 var parentObj;
// menu source code

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//    ����Ϊ�����˵��Ĳ���
//_______________________________________

 //�˵����Ľṹ
 function menu_bar(name,ico,text,key,tip,skey,type,cmd) {
     this.name = name;     //����
     this.ico = ico;      //ͼ��
     this.text = text;     //����
     this.key = key;      //�ȼ�
     this.tip = tip;      //��ʾ
     this.skey = skey;     //��ݼ�
     this.type = type;     //�������ͣ�0Ϊ�����¼��˵���1Ϊִ��һ������(��ת����һ���ļ�)
     this.cmd = cmd;      //�¼��˵������ƻ������ַ���������type��ֵ����
 }
 
 //�˵��Ľṹ
 function menu(name) {
     this.name = name;      //����
     this.bar = new Array();   //�������Ĳ˵�������
 }
 
 //���һ�Ѷ�������˵������ŵ�
 function popMainMenu(menu,left,top,width,height) {
     var strHTML, posLeft, posTop, i;
   
     strHTML = "<div id='" + menu.name + "' style='left:" + left + ";top:" + top + ";width:" + width + ";height:" + height + "' class='MainMenuBG'>";
     document.write (strHTML);

     posLeft = 2;
     posTop = 0;
     for (i=0;i<menu.bar.length;i++) {
         strHTML = "<div id='" + menu.bar[i].name + "' nowrap style='left:" + posLeft + ";top:" + posTop + ";height:26;' class='MainMenu' " +
                   "onmouseover='return menu_onmouseover(this,\"" + menu.bar[i].cmd + "\",\"" + menu.bar[i].text + "\")' onmouseout='return menu_onmouseout(this)' " +
                   "onclick='return menu_onclick(this,\"" + menu.bar[i].cmd + "\",\"" + menu.bar[i].text + "\")' title='" + menu.bar[i].tip + "'>" + menu.bar[i].text;
         if (menu.bar[i].key!="") {
             strHTML += "(<u>" + menu.bar[i].key + "</u>)";
         }
         strHTML += "</div>";
   
	     document.write (strHTML);
         posLeft += document.all.item(menu.bar[i].name).offsetWidth + 1;
     } 
     strHTML = "</div>";
  
     document.write (strHTML);
 }
 
 //���һ���Ѷ�����Ӳ˵������ŵ�
 function popSubMenu(menu) {  
     var strHTML, posLeft, posTop, i;

     strHTML = "<div id='" + menu.name + "' style='left:20;top:30;width:104;height:10;' class='SubMenuBG'>";
  
     /*���������select�ᱻ���ǵ�����______��ѧ��.20050113*/
     strHTML += "<iframe name='menuIframe' scrolling='no' src='test.jsp' frameborder='0' width='100%' height='" + (18 * menu.bar.length+2) + "'></iframe>";
     /*���������select�ᱻ���ǵ�����______��ѧ��.20050113*/

     document.write (strHTML);
  
     posLeft = 1;
     posTop = 1;

     for (i=0;i<menu.bar.length;i++) {
         if (menu.bar[i].name!="\-") {    //������Ʋ��ǡ�\-������ʾ��һ����ͨ�˵���
             strHTML = "<div id='" + menu.bar[i].name + "' style='left:" + posLeft + ";top:" + posTop + ";' class='SubMenu' " +
                       "title='" + menu.bar[i].tip + "' " +
                       "onmouseover='return bar_onmouseover(this," + menu.bar[i].type + ",\"" + menu.bar[i].cmd + "\")' " +
                       "onmouseout='return bar_onmouseout(this," + menu.bar[i].type + ",\"" + menu.bar[i].cmd + "\")' " +
                       "onclick='return bar_onclick(this," + menu.bar[i].type + ",\"" + menu.bar[i].cmd + "\",\"" + menu.bar[i].text + "\")'>" +
                       "  <table border=0 cellspacing=0 cellpadding=0 width=102>" +
                       "    <tr>";
			          /* �ڲ˵�����ʾͼƬ��λ��
					  +
                       "      <td nowrap align=center width=20 id='" + menu.bar[i].name + "_ico' class='ico'>";
             if (menu.bar[i].ico!="") {
                 strHTML += "<img border=0 width=16 height=16 src='" + menu.bar[i].ico + "'>";
             }else {
                 strHTML += "&nbsp;";
             }
             strHTML += "</td>" +
			          �ڲ˵�����ʾͼƬ��λ��*/
             strHTML += "      <td nowrap id='" + menu.bar[i].name + "_text' class='text'>" + menu.bar[i].text;
             /*�ڲ˵�����ʾ�ȼ���λ��
			 if (menu.bar[i].key!="") { strHTML = strHTML + "(<u>" + menu.bar[i].key + "</u>)"; }*/
             strHTML += "</td>" /*+
             strHTML += "<td nowrap align=right id='" + menu.bar[i].name + "_skey' class='skey'>";
             if (menu.bar[i].skey!="") {
                 strHTML += menu.bar[i].skey;
             }else {
                 strHTML += "&nbsp;";
             }
             strHTML += "     </td>" +
			 �ڲ˵�����ʾ�ȼ���λ��*/
             strHTML += "      <td nowrap align=center width=20 id='" + menu.bar[i].name + "_sub' class='sub'>";
             if (menu.bar[i].type==0) {
                 //strHTML += "��";��������Ӳ˵�����ʾ��ͼ��
            	 strHTML += "<img border='0' width='6' height='10' src='common/images/jiantou-r.gif'>";
             }
			 else {
                 strHTML += "&nbsp;&nbsp;";
             }
             strHTML += "</td>" +
                        "    </tr>" +
                        "  </table>" +
                        "</div>";
             document.write (strHTML);
             posTop += document.all.item(menu.bar[i].name).offsetHeight;
         }
		 else {       //��������ǡ�\-������ʾ��һ���ָ���
             strHTML = "<div style='left:" + posLeft + ";top:" + posTop + ";' class='SubMenu'>" +
                       "  <table border='0' cellpadding='0' cellspacing='0' width='100'>" +
                       "    <tr>" +
                       "      <td nowrap style='background-color: #89A5CF;' width=100></td>" +
                       "      <td nowrap style='padding-left:0px;padding-top:0px;padding-bottom:0px;'>" +
                       "        <table border=0 cellpadding=0 cellspacing=0 width=100%>" +
                       "          <tr><td height=1 bgcolor='#89A5CF'></td></tr>" +
                       "        </table>" +
                       "      </td>" +
                       "    </tr>" +
                       "  </table>" +
                       "</div>";
             document.write (strHTML);
             posTop += 3;
         }
     }
     strHTML = "</div>";

     document.write (strHTML);
     document.all.item(menu.name).style.height = posTop;    //�����Ӳ˵�������
 }


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//    ����Ϊ���ݲ˵��Ĳ���
//_________________________________________________

 function showMenu(menu,submenu) {  //��ʾһ���Ӳ˵�
     document.all.item(submenu).style.left = menu.parentElement.offsetLeft + menu.offsetLeft+1;   //�����Ӳ˵�λ��
     document.all.item(submenu).style.top = menu.parentElement.offsetTop + menu.offsetTop + menu.offsetHeight -1;   //�����Ӳ˵���λ��
     document.all.item(submenu).style.visibility = "visible";   //��ʾ�Ӳ˵�
     mnuPrev[mnuPrev.length] = new menuinfo(submenu,1);   //���´򿪵��Ӳ˵���ID���뵱ǰ��ʾ�˵�ID����
 }
 
 function showSubMenu(menu,submenu) {  //��ʾ�����������Ӳ˵�
     document.all.item(submenu).style.left = menu.parentElement.offsetLeft + menu.offsetLeft + menu.offsetWidth + 2;   //�����Ӳ˵�λ��
     document.all.item(submenu).style.top = menu.parentElement.offsetTop + menu.offsetTop + 1;   //�����Ӳ˵���λ��
     if (document.all.item(submenu).offsetLeft + document.all.item(submenu).offsetWidth > doc_width) {
         document.all.item(submenu).style.left = menu.parentElement.offsetLeft - document.all.item(submenu).offsetWidth + 1;
     }
     if (document.all.item(submenu).offsetTop + document.all.item(submenu).offsetHeight > doc_height) {
         document.all.item(submenu).style.top = document.all.item(submenu).offsetTop + menu.offsetHeight - document.all.item(submenu).offsetHeight + 2;
     }
     document.all.item(submenu).style.visibility = "visible";   //��ʾ�Ӳ˵�
     mnuPrev[mnuPrev.length] = new menuinfo(submenu,1);   //���´򿪵��Ӳ˵���ID���뵱ǰ��ʾ�˵�ID����
 }
 
 function showstatus() {   //���Խ׶��õĺ�������ʾ��ǰ�˵�ID�����ڵ�����
     lblMsg.innerText = "";
     for(var i=0;i<mnuPrev.length;i++) {
         lblMsg.innerText += mnuPrev[i].id + " > ";
     }
 }
 
 function menuinfo(id,type) {
     this.id = id;    //0��ʾ�˵��1��ʾ�˵���
     this.type = type;
 }

 function menu_onmouseover(obj,cmd,pObj) {
     if(!mClick) {
         obj.className = "MainMenuOver";
         mnuPrev[mnuPrev.length] = new menuinfo(obj.id,0);    //����ǰ�Ĳ˵�IDѹ�뵱ǰ�˵�ID����
         //showstatus();   //���Խ׶�ʹ��
     }
	 else {
         if (mnuPrev[0].id == obj.id) { return false; }   //������ڱ������ƶ�������Ϊ
         document.all.item(mnuPrev[0].id).className = "MainMenu";
         for (var i=1;i<mnuPrev.length;i++) {
             if (mnuPrev[i].type==0) {   //����ǲ˵�����ó�Ĭ����ʽ
                 /*document.all.item(mnuPrev[i].id + "_ico").className = "ico";*/
                 document.all.item(mnuPrev[i].id + "_text").className = "text";
                 /*document.all.item(mnuPrev[i].id + "_skey").className = "skey";*/
                 document.all.item(mnuPrev[i].id + "_sub").className = "sub";
             }
			 else {   //����ǲ˵���������
                 document.all.item(mnuPrev[i].id).style.visibility = "hidden";
             }
         }
         mnuPrev.length = 0;
         obj.className = "MainMenuClick";
         mnuPrev[mnuPrev.length] = new menuinfo(obj.id,0);
         showMenu(obj,cmd);
         //showstatus();   //���Խ׶�ʹ��

         parentObj = pObj;
     }
 }

 function menu_onmouseout(obj) {	
     if(!mClick) {
         obj.className = "MainMenu";
         mnuPrev.length --;   //������һ��ѹ�뵱ǰ�˵�ID����Ĳ˵�ID
         //showstatus();   //���Խ׶�ʹ��
     }
 }
 
 function menu_onclick(obj,cmd,pObj) {
	 
	 parentObj = pObj;

     if(!mClick) {    //����˵���ǰ״̬�Ƿǵ��״̬��֤����ǰ�Ǵӷǵ��״̬�����״̬
         obj.className = "MainMenuClick";    //���õ�ǰ�˵�Ϊ��굥��֮���״̬
         showMenu(obj,cmd);    //��ʾ�Ӳ˵�
         //showstatus();   //���Խ׶�ʹ��
         mClick = true;   //���ò˵���ǰ�ǵ��״̬
     }
	 else {
         obj.className = "MainMenuOver";    //���õ�ǰ�˵�Ϊ����ƶ������״̬���ǵ��״̬
         document.all.item(mnuPrev[mnuPrev.length-1].id).style.visibility = "hidden";
         mnuPrev.length --;
         //showstatus();   //���Խ׶�ʹ��
         mClick = false;    //���˵���ǰ�Ƿǵ��״̬
     }
     bMenuClick = true;   //��һ���˵��ϵ�����������״̬Ϊtrue,��������document_click�¼�
 }

 function bar_onmouseover(obj,type,cmd) {
     for (var i=1;i<mnuPrev.length;i++) {
         if(mnuPrev[i].id==obj.parentElement.id) {
             for (var j=i+1;j<mnuPrev.length;j++) {    //������ǰһ���˵���򿪵��Ӳ˵��������ж��
                 if (mnuPrev[j].type==0) {   //����ǲ˵�����ó�Ĭ����ʽ
                     /*document.all.item(mnuPrev[j].id + "_ico").className = "ico";*/
                     document.all.item(mnuPrev[j].id + "_text").className = "text";
                     /*document.all.item(mnuPrev[j].id + "_skey").className = "skey";*/
                     document.all.item(mnuPrev[j].id + "_sub").className = "sub";
                 }
				 else {   //����ǲ˵���������
                     document.all.item(mnuPrev[j].id).style.visibility = "hidden";
                 }
             }
             mnuPrev.length = i + 1;
             break;
         }
     }
     mnuPrev[mnuPrev.length] = new menuinfo(obj.id,0);
     //showstatus();   //���Խ׶�ʹ��
     /*document.all.item(obj.id + "_ico").className = "icoOver";*/
     document.all.item(obj.id + "_text").className = "textOver";
     /*document.all.item(obj.id + "_skey").className = "skeyOver";*/
     document.all.item(obj.id + "_sub").className = "subOver";
     if (type==0) { showSubMenu(obj,cmd); }   //�������һ���˵���չ��
         //showstatus();   //���Խ׶�ʹ��
 }
  
 function bar_onmouseout(obj,type,cmd) {
     if (type!=0) {
         /*document.all.item(obj.id + "_ico").className = "ico";*/
         document.all.item(obj.id + "_text").className = "text";
         /*document.all.item(obj.id + "_skey").className = "skey";*/
         document.all.item(obj.id + "_sub").className = "sub";
         if (mnuPrev.length>0) {
             mnuPrev.length --;
         }
         //showstatus();   //���Խ׶�ʹ��
     }
 }

  function bar_onclick(obj,type,cmd,text) {
     	 
     if (type==1) {
		 showStatusBar(text); //���·���״̬������ʾ����Ϣ

         //window.navigate(cmd);   //��ת����Ӧ���ļ�
         document.main.document.location = cmd; //��ʾ�ڼ䣬���ļ�����ʾ����
     }
	 else {
         bMenuClick = true;   //��һ���˵��ϵ�����������״̬Ϊtrue,��������document_click�¼�
     }
 }


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//    ����Ϊ�����ļ��йصĿ��Ʋ��֣�����ʹ��ʱ��Ҫ��ע��Ҳ�����ⲿ�ֶ���
//_____________________________________________________________

 var doc_width;    //��ǰ���ڵĿ�ȣ��洰�ڴ�С�ı���ı�
 var doc_height;    //��ǰ���ڵĸ߶ȣ��洰�ڴ�С�ı���ı�
 
 var mClick = false;   //һ���˵��Ƿ񱻵������ʼһ���˵���δ�����״̬
 var bMenuClick = false;    //�����Ƿ�����һ���˵��ϣ���ʼ����������һ���˵���
 var mnuPrev = new Array();   //��ǰ��ʾ�Ĳ˵�ID���飬��ʼΪ��

 function document_onselectstart() {
     return false;    //��������ѡ����
 }
 
 //���·���״̬������ʾ����Ϣ
 function showStatusBar(message) {
	 if(parent.bottom!=null) {
		 var text = parentObj + " ---> " + message
         window.open('bottom.jsp?moduleName='+text,'bottom'); 
	 }
 } 

 function document_onclick() {
     if(!bMenuClick) {
         if (mnuPrev.length>0) {
             for (var i=1;i<mnuPrev.length;i++) {
                 if (mnuPrev[i].type==0) {   //����ǲ˵�����ó�Ĭ����ʽ
                     /*document.all.item(mnuPrev[i].id + "_ico").className = "ico";*/
                     document.all.item(mnuPrev[i].id + "_text").className = "text";
                     /*document.all.item(mnuPrev[i].id + "_skey").className = "skey";*/
                     document.all.item(mnuPrev[i].id + "_sub").className = "sub";
                 }
				 else {   //����ǲ˵���������
                     document.all.item(mnuPrev[i].id).style.visibility = "hidden";
                 }
             }
             document.all.item(mnuPrev[0].id).className = "MainMenu";    //�����˵���״̬�ָ���ͨ״̬
         }
         mnuPrev.length = 0;    //��յ�ǰ��ʾ�˵�
         mClick = false;    //����˵����״̬
     }
	 else {
         bMenuClick = false;
     }
 }

 function window_onresize() {
      //�����ڳߴ�仯ʱ�ı���Ӧ������ֵ
      doc_height = window.document.body.offsetHeight;
      doc_width = window.document.body.offsetWidth;
 }

 function window_onload() {
      //��ʼ�����ڳߴ�
      doc_height = window.document.body.offsetHeight;
      doc_width = window.document.body.offsetWidth;
 }

 function document.onclick() {
	 //���ز˵�
     document_onclick();
 }


//-->
