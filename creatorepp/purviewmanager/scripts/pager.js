
var  commitevent ;

 
/**
*url:ҳ���ַ
*pages:��ǰҳ������
*maxPageItem:ÿҳ��ʾ������¼��
*hasParam:�жϵ�ǰҳ��ַ�Ƿ������  
*/
function goTo(url,
              pages,
              maxPageItem,
              hasParam, 
              sortKey,desc,id,
              formName,
              params,
              promotion)
{
	
	var regx = /\d+/g;
	var gotopage = document.all.item("gotopage");
	
    var goPage = "NaN";
    if(gotopage.length)
    {
	    for(var i = 0; i < gotopage.length; i ++ )
	    {
	    	//var temp = parseInt(gotopage[i].value);
	    	//if(!isNaN(temp))
	    	var temp = gotopage[i].value;
	    	if(regx.test(temp))
	        	goPage = temp;

	    }
	}
	else
	{
		//var temp = parseInt(gotopage.value);
		var temp = gotopage.value;
    	//if(!isNaN(temp))
	    	if(regx.test(temp))
	    	{
	        	goPage = temp;
		}

	}

    if(isNaN(goPage) || goPage.indexOf(".") != -1)
    {
		alert("��������תҳ������תҳ����Ϊ����");
		return;
    }
    //�����תҳ����ҳ����ʱ������תҳָ��Ϊpages
    
    if(pages < goPage)
    {
    	goPage = pages;
    }
    
    var offset = (goPage - 1) * maxPageItem;
    var offset_key = "";
    var desc_key = "";
    var sort_key = "";
    if(id)
    {
        offset_key = id + ".offset";
        desc_key = id + ".desc"
        sort_key = id + ".sortKey";
    }
    else
    {
        offset_key = "pager.offset";
        desc_key = "desc";
        sort_key = "sortKey";
    }
    var forwardurl = url + (hasParam?"&":"?") + offset_key + "=" + offset;
    
    if(sortKey)
        forwardurl = forwardurl + "&" + sort_key + "=" + sortKey  + "&" + desc_key + "=" + desc;
    //params = (hasParam?"&":"") + offset_key + "=" + offset + "&"+ sort_key + "=" + sortKey  + "&" + desc_key + "=" + desc;
    params += (hasParam?"&":"") + offset_key + "=" + offset + "&"+ sort_key + "=" + sortKey  + "&" + desc_key + "=" + desc;
    
	var flag = false;
    if(commitevent){
        flag = eval(commitevent);
    }
	
    if(formName && flag)
        pageSubmit(formName,params,forwardurl,promotion,id);
    else
	{
		
		location.replace(forwardurl);
	}

}

 /**
 * ʵ�ַ�ҳ��ǩ�з�ҳ��ť�ύ������
 * formName:������
 * params:ҳ�����
 * forwardurl:��תҳ��
 * promotion:�Ƿ���ʾ��Ϣ
 */
function pageSubmit(formName,params,forwardurl,promotion,id)
{
	
    //�����Ҫ��ʾ�Ƿ񱣴�ҳ�����ݵ��޸ģ��򵯳���ʾ���ڣ�
    var paramsName = "PAGE_QUERY_STRING";
    if(id)
        paramsName = id + ".PAGE_QUERY_STRING";
	var flag = false;
    if(commitevent){
        flag = eval(commitevent);
    }
    if(promotion && flag)
    {
    	
        if(!confirm("�Ƿ񱣴浱ǰҳ���޸ĵ����ݣ�\r\n�ǣ����'ȷ��'���񣬵��'ȡ��'."))
		{		
			
            location.replace(forwardurl);            
            //document.all.item(paramsName).value = params;
			//if(document.all.sendOrgId){
			//    document.all.sendOrgId.value = "";
			//}
            //document.forms(formName).submit();
		}
        else
        {   
			if(commitevent){
				try
				{
					eval(commitevent);

				}
				catch(e)
				{
					alert("Error Command:\n\""+commitevent+"\".\n"+e.description);
				}
				
			}
            document.all.item(paramsName).value = params;
            document.forms(formName).submit();
        }
    }
    else
    {		
        document.all.item(paramsName).value = params;
        document.forms(formName).submit();
    }
}
function keydowngo(goid)
{
	if(window.event.keyCode == 13)
	{
		document.getElementById(goid).onclick();
	}
	
	return false;
}