/*20080918�������õ�һ���µ�uuid*/
function creator_getUUID(){
	var sXml="<No></No>";
	var retX=SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append(fcpubdata.servletPath).append("/DbTools").append(fcpubdata.dotnetVersion).append("?creator_getUUID").toString(),sXml);
	return retX;
}

/*
 * 20080919
   ��̬����grid�е�image�ؼ���ͼƬSRC����Ҫ������
   1��grid��id;
   2��cellId ���ڼ�����Ԫ��
   3���õ�ͼƬurl�Ļص��������ص����������Ӽ�function getImgUrl(i)��

   ���Ҫʹ�ø÷�����������dataset�򿪺�

*/
function setGridImageSrc(gridId,cellId,callback)
{
    var re = /src=\S*/ig;
    var tmp="",t="",img="";
    for(var i=0;i<gridId.Rows;i++)
    {
       if(i!=0)
       {
          var obj = gridId.tab.rows(i).cells(cellId);
          tmp = obj.innerHTML;
          img = callback(i);
          t = tmp.replace(re,new StringBuffer().append("src=").append(img).append(">").toString());
          obj.innerHTML=t;
       }
    }
}
/*
function getImgUrl(i)
{
   if(i%2==0)
   {
       return 'http://localhost:8081/dzzwpt/images/yellowlight.png';
   }
   else
       return 'http://localhost:8081/dzzwpt/images/greenlight.png';
}
*/

/*
added by zhou.luo in 2008-09-28
���Զ����ƣ����͵���̨����Ĳ���
*/
function creator_formDrawSend(ds_design,ds_run,formRet,queryField,showField,eform_class,myopensql){
	var sXml=new StringBuffer().append("<No>").append(ds_design).append("</No><No>").append(ds_run).append("</No><No>").append(formRet).append("</No><No>").append(queryField).append("</No><No>").append(showField).append("</No><No>").append(eform_class).append("</No><No>").append(myopensql).append("</No>").toString();
    var retX=SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append(fcpubdata.servletPath).append("/WebDesign").append(fcpubdata.dotnetVersion).append("?formAutoDraw").toString(),sXml);
    return retX;
}

/*���������������ڱ��Զ������ƣ��Ѿ��Զ����ɵ������Զ��庯�����С�*/
/*added by zhou.luo in 2008-10-03
���Զ������ɵı���Ҫ�õ��ĺ��������ڲ�ѯ
*/
/*
function creator_query(obj_ds){
    //var texts = document.getElementsByTagName("input");
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
*/

/*added by zhou.luo in 2008-10-03
���Զ������ɵı���Ҫ�õ��ĺ��������ڴ���ϸҳ�档���������޸ģ�չ������
*/
/*
function creator_opendj(djid,obj_ds,optype,title){
    DjOpen(djid,obj_ds,optype,'��ģʽ����','ֱ��',title);
    obj_ds.Open(obj_ds.opensql);
}
*/
/*added by zhou.luo in 2008-10-04
����ѯ�ֶε�����
*/
/*
function creator_reset(){
     var texts = document.all;
     var condition = "";
     for(var i = 0;i < texts.length;i++){
         if(texts[i].id.substring(0,8)=='cc_text_'){
             texts[i].value = "";
         }
     }
}
*/


/*
added by zhou.luo in 2008-09-26
�����������д򿪷����̵�word�ĵ�    ����û���õ�������ȥ��*/
/*
function creator_openOfficeByWordid(djid,wordid){
    var temp_cc_id = fcpubdata.cc_form_instanceid;
    var url=getOpenUrlByDjid(djid)+"&wordid="+wordid;
    window.showModalDialog(url);
    creator_setSession("cc_form_instanceid",temp_cc_id);
}
*/

/*added by zhou.luo in 2008-10-16
�������д��������̵�word�ĵ� �����ֻ����Ϊһ��ʾ�� */
function openOtherWorkflowWord(djid,other_form_instanceid,other_djid,other_aswfdoc){
var cc_id = fcpubdata.cc_form_instanceid;
var url = new StringBuffer().append(getOpenUrlByDjid(djid)).append("&other_form_instanceid=").append(other_form_instanceid).append("&other_djid=").append(other_djid).append("&cc_form_instanceid=").append(cc_id).toString();
if(!IsSpace(other_aswfdoc)){
    url += "&other_aswfdoc="+other_aswfdoc;
}
window.open(url);
}

/*added by zhou.luo in 2008-10-16
�������д򿪷����̵�word�ĵ������ֻ����Ϊһ��ʾ�� */
function openOtherNoneWorkflowWord(djid,other_officeid,other_aswfdoc){
var cc_id = fcpubdata.cc_form_instanceid;
var url = new StringBuffer().append(getOpenUrlByDjid(djid)).append("&other_officeid=").append(other_officeid).append("&cc_form_instanceid=").append(cc_id).toString();
if(!IsSpace(other_aswfdoc)){
    url += "&other_aswfdoc="+other_aswfdoc;
}
window.open(url);
}

/*���������̻�н���Ԫ�ء�����Ϊֻ����Ȩ�� element ������ֻ����Ԫ�� style ���ڶ�̬�������������Ӧ�õ���ʽ*/
function elementReadOnly(element,styleName)  
{ 
	var id = element.id;
	var value = element.value;
	var tmp = element.outerHTML.substring(0,7).toUpperCase();
	if (tmp == "<SELECT") 				//ѡ����ȡֵ��Ҫ���⴦��
	{
		var index = element.selectedIndex;
		if (index == -1)
			value = '';
		else
			value = element.options[index].text;
	}
	
	//���������
	var myElement = document.createElement("input");
	myElement.setAttribute("value",value);      //��ֵ
	myElement.style.cssText = element.style.cssText;
		
	myElement.readOnly = "true"; 				 //ֻ��
	if(styleName.length != 0)
	{
		myElement.className = styleName; 			 //Ӧ����ʽ
	}
	element.style.display = "none"; 			 //����ԭԪ��
	element.parentNode.insertBefore(myElement,element); //����̬�������������뵽ԭԪ��֮ǰ
}

/*
added by zhou.luo 2008-10-27
modified by zhou.luo 2008-11-14
* �����жϱ������ÿؼ��е�iframe�Ƿ������ɡ�
* ������iframeid �����˸ò�������ֻ�жϸ�iframe�Ƿ���ɼ��ء�
* ����ֵ��"true"��������ɣ�'false':����δ��ɡ�
*/
function creator_iframeIsCompleted(iframeid){
    var oIframes = document.all.tags('iframe');

    for(var i = 0;i < oIframes.length;i++){
        if(!IsSpace(oIframes[i].controltype) && oIframes[i].controltype=="creatorSubForm"){
        	if(!IsSpace(iframeid)){
        		if(oIframes[i].id != iframeid){
        			continue;
        		}
        	}
        	if(oIframes[i].autoload=='yes'){
            	//alert(oIframes[i].id+":"+oIframes[i].readyState);
            	if(oIframes[i].src =="" || oIframes[i].readyState!='complete'){
                	return 'false';
            	}
        	}
        }
    }
    return 'true';  
}

/*
added by zhou.luo 2008-10-29
modified by zhou.luo 2008-11-14
�����жϱ������ж�̬���صı��Ƿ���ɼ���
* ������iframeid �����˸ò�������ֻ�жϸ�iframe�Ƿ���ɼ��ء�
����ֵ��"true":�������;"false":����δ��ɡ�
*/
function creator_dnyIframeIsCompleted(iframeid){
    var oIframes = document.all.tags('iframe');
    
    for(var i = 0;i < oIframes.length;i++){
        if(!IsSpace(oIframes[i].controltype) && oIframes[i].controltype=="creatorSubForm"){
        	if(!IsSpace(iframeid)){
        		if(oIframes[i].id != iframeid){
        			continue;
        		}
        	}
        	if(oIframes[i].autoload=='no'){
            	//alert(oIframes[i].id+":"+oIframes[i].readyState);
            	if(oIframes[i].src =="" || oIframes[i].readyState!='complete'){
                	return 'false';
            	}
        	}
        }
    }
    return 'true';  
}
/*����һ��Map����*/
function MapClass() 
{ 
    function node(key, value)
	{ 
	  this.key = key; 
	  this.value = value; 
	} 
	this.map = new Array(); 
    this.setAttr =function(key, value)
				{ 
				  for (var i = 0; i < this.map.length; i++) 
				  { 
					if ( this.map[i].key == key ) 
					{ 
					  this.map[i].value = value; 
					  return; 
					} 
				  } 
				  this.map[this.map.length] = new node(key, value); 
				}; 
    this.getAttr  = function(key) 
					{ 
					  for (var i = 0; i < this.map.length; i++) 
					  { 
						if ( this.map[i].key === key ) 
						{ 
						  return this.map[i].value; 
						} 
					  } 
					  return null; 
					}; 
    this.removeAttr = function(key) 
					{ 
					  var v; 
					  for (var i = 0; i < this.map.length; i++) 
					  { 
						v = this.map.pop(); 
						if ( v.key == key ) 
						  continue; 
						this.map.unshift(v); 
					  } 
					};
	this.clearAll=function()
				 {
					 while(this.map.length>0)
                         this.map.pop();  
				 };
    this.getCount = function()
					{ 
					  return this.map.length; 
					};
    this.isEmpty = function()
					{ 
					  return this.map.length <= 0; 
					} 
} 

/*added by zhou.luo 2008-11-19 �ж�grid�е�checkbox�Ƿ����ٹ�ѡ��һ��*/
function isSelectedOne(dataset) {
    var flag = false;

    var rowcount = dataset.RecordCount;
    dataset.MoveFirst();
    //alert("rowcount:"+rowcount);
    for(var i = 0;i < rowcount;i++){
       //alert(i+": "+ dataset.oDom.documentElement.childNodes(i).getAttribute("creator_multisel")
       //                 +"  "+ dataset.Fields.Field['B'].Value); 
       if(dataset.oDom.documentElement.childNodes(i).getAttribute("creator_multisel") == '��'){
            flag = true;
            break;
        }
        dataset.MoveNext();
    }    
    //alert(flag);
    return flag;
}

/**
 * var url='http://localhost:8888/test.jsp?arg='+toUN.on(a);
 */
var toUN = {    
   
    on : function (str) { 
        if(str.replace(/\s+/g,"").length==0){
     return "";
     }   
        var a = [], i = 0;    
            
        for (; i < str.length ;) a[i] = ("00" + str.charCodeAt(i ++).toString(16)).slice(-4);    
            
        return "\\u" + a.join("\\u");    
    },    
        
    un : function (str) {    
        return unescape(str.replace(/\\/g, "%"));    
    }    
        
}; 

/*
added by zhou.luo 2009-02-25
��ȡ���Ѿ�������Ȩ�޿��Ƶ�Ԫ��id�Ľӿ�
����һ�������Ķ���{readonlyId:"",disabledId:"",hiddenId:"",readonlyStyle:""}
*/
function creator_getElementAuthority(oid,djid){
	var ret = {readonlyId:"",disabledId:"",hiddenId:"",readonlyStyle:""};
	var strsql = "select substr(t.ctrl_id,length(to_char(t.djid))+1),t.perattr_type,t.readonlystyle from td_form_perattr t where t.oid='"+oid+"' and t.djid="+djid;
	var sXml = SelectSql(strsql,1,200);
	if(sXml=="<root></root>"){
		//�����ݿ��в�����ļ�¼Ϊ��,��ִ���κβ�����
	}else{
		var oXml = SetDom(sXml) ;
	    var len = oXml.documentElement.childNodes.length;
		for(var i = 0;i<len-1;i++){
	        	var elementId = oXml.documentElement.childNodes[i].childNodes[0].text;
	        	var authority = oXml.documentElement.childNodes[i].childNodes[1].text;       
	            var styleName = oXml.documentElement.childNodes[i].childNodes[2].text;
				authority = authority - 0;				
	        	switch(authority){
	            	case 0: break;
	            	case -2:ret.readonlyId+=elementId+","; ret.readonlyStyle+=styleName+","; break;
	            	case 1: ret.disabledId+=elementId+","; break;
	            	case 2: ret.hiddenId+=elementId+","; break;
				}
		}
		if(ret.readonlyId.length > 0){
			ret.readonlyId = ret.readonlyId.substring(0,ret.readonlyId.length-1);
			ret.readonlyStyle = ret.readonlyStyle.substring(0,ret.readonlyStyle.length-1);
		}
		if(ret.disabledId.length > 0){
			ret.disabledId = ret.disabledId.substring(0,ret.disabledId.length-1);
		}
		if(ret.hiddenId.length > 0){
			ret.hiddenId = ret.hiddenId.substring(0,ret.hiddenId.length-1);
		}
	}
	return ret;
}