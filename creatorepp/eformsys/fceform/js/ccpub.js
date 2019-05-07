/*20080918新增，得到一个新的uuid*/
function creator_getUUID(){
	var sXml="<No></No>";
	var retX=SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append(fcpubdata.servletPath).append("/DbTools").append(fcpubdata.dotnetVersion).append("?creator_getUUID").toString(),sXml);
	return retX;
}

/*
 * 20080919
   动态设置grid中的image控件的图片SRC，需要参数：
   1，grid的id;
   2，cellId （第几个单元格）
   3，得到图片url的回调函数。回调函数的例子见function getImgUrl(i)；

   如果要使用该方法，必须在dataset打开后。

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
表单自动绘制，发送到后台处理的部分
*/
function creator_formDrawSend(ds_design,ds_run,formRet,queryField,showField,eform_class,myopensql){
	var sXml=new StringBuffer().append("<No>").append(ds_design).append("</No><No>").append(ds_run).append("</No><No>").append(formRet).append("</No><No>").append(queryField).append("</No><No>").append(showField).append("</No><No>").append(eform_class).append("</No><No>").append(myopensql).append("</No>").toString();
    var retX=SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append(fcpubdata.servletPath).append("/WebDesign").append(fcpubdata.dotnetVersion).append("?formAutoDraw").toString(),sXml);
    return retX;
}

/*下面两个函数用于表单自动化绘制，已经自动生成到表单的自定义函数当中。*/
/*added by zhou.luo in 2008-10-03
表单自动化生成的表单需要用到的函数，用于查询
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
表单自动化生成的表单需要用到的函数，用于打开详细页面。有新增，修改，展现三种
*/
/*
function creator_opendj(djid,obj_ds,optype,title){
    DjOpen(djid,obj_ds,optype,'有模式窗口','直接',title);
    obj_ds.Open(obj_ds.opensql);
}
*/
/*added by zhou.luo in 2008-10-04
表单查询字段的重置
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
用于在流程中打开非流程的word文档    现在没人用到，可以去掉*/
/*
function creator_openOfficeByWordid(djid,wordid){
    var temp_cc_id = fcpubdata.cc_form_instanceid;
    var url=getOpenUrlByDjid(djid)+"&wordid="+wordid;
    window.showModalDialog(url);
    creator_setSession("cc_form_instanceid",temp_cc_id);
}
*/

/*added by zhou.luo in 2008-10-16
在流程中打开其他流程的word文档 ，这个只是作为一个示例 */
function openOtherWorkflowWord(djid,other_form_instanceid,other_djid,other_aswfdoc){
var cc_id = fcpubdata.cc_form_instanceid;
var url = new StringBuffer().append(getOpenUrlByDjid(djid)).append("&other_form_instanceid=").append(other_form_instanceid).append("&other_djid=").append(other_djid).append("&cc_form_instanceid=").append(cc_id).toString();
if(!IsSpace(other_aswfdoc)){
    url += "&other_aswfdoc="+other_aswfdoc;
}
window.open(url);
}

/*added by zhou.luo in 2008-10-16
在流程中打开非流程的word文档，这个只是作为一个示例 */
function openOtherNoneWorkflowWord(djid,other_officeid,other_aswfdoc){
var cc_id = fcpubdata.cc_form_instanceid;
var url = new StringBuffer().append(getOpenUrlByDjid(djid)).append("&other_officeid=").append(other_officeid).append("&cc_form_instanceid=").append(cc_id).toString();
if(!IsSpace(other_aswfdoc)){
    url += "&other_aswfdoc="+other_aswfdoc;
}
window.open(url);
}

/*用于在流程活动中将表单元素“设置为只读”权限 element 将设置只读的元素 style 将在动态创建的输入框上应用的样式*/
function elementReadOnly(element,styleName)  
{ 
	var id = element.id;
	var value = element.value;
	var tmp = element.outerHTML.substring(0,7).toUpperCase();
	if (tmp == "<SELECT") 				//选择框的取值需要特殊处理
	{
		var index = element.selectedIndex;
		if (index == -1)
			value = '';
		else
			value = element.options[index].text;
	}
	
	//创建输入框
	var myElement = document.createElement("input");
	myElement.setAttribute("value",value);      //赋值
	myElement.style.cssText = element.style.cssText;
		
	myElement.readOnly = "true"; 				 //只读
	if(styleName.length != 0)
	{
		myElement.className = styleName; 			 //应用样式
	}
	element.style.display = "none"; 			 //隐藏原元素
	element.parentNode.insertBefore(myElement,element); //将动态创建的输入框插入到原元素之前
}

/*
added by zhou.luo 2008-10-27
modified by zhou.luo 2008-11-14
* 用于判断表单中引用控件中的iframe是否加载完成。
* 参数：iframeid 传递了该参数，则只判断该iframe是否完成加载。
* 返回值："true"：加载完成；'false':加载未完成。
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
用于判断表单中所有动态加载的表单是否完成加载
* 参数：iframeid 传递了该参数，则只判断该iframe是否完成加载。
返回值："true":加载完成;"false":加载未完成。
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
/*构造一个Map对象*/
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

/*added by zhou.luo 2008-11-19 判断grid中的checkbox是否至少勾选了一项*/
function isSelectedOne(dataset) {
    var flag = false;

    var rowcount = dataset.RecordCount;
    dataset.MoveFirst();
    //alert("rowcount:"+rowcount);
    for(var i = 0;i < rowcount;i++){
       //alert(i+": "+ dataset.oDom.documentElement.childNodes(i).getAttribute("creator_multisel")
       //                 +"  "+ dataset.Fields.Field['B'].Value); 
       if(dataset.oDom.documentElement.childNodes(i).getAttribute("creator_multisel") == '是'){
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
获取表单已经进行了权限控制的元素id的接口
返回一个这样的对象：{readonlyId:"",disabledId:"",hiddenId:"",readonlyStyle:""}
*/
function creator_getElementAuthority(oid,djid){
	var ret = {readonlyId:"",disabledId:"",hiddenId:"",readonlyStyle:""};
	var strsql = "select substr(t.ctrl_id,length(to_char(t.djid))+1),t.perattr_type,t.readonlystyle from td_form_perattr t where t.oid='"+oid+"' and t.djid="+djid;
	var sXml = SelectSql(strsql,1,200);
	if(sXml=="<root></root>"){
		//从数据库中查出来的记录为空,不执行任何操作。
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