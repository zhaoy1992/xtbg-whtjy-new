   function checkButton(){        
        
       
        while(!basePropertiesToolbar.tools1){
            ;
        }
        basePropertiesToolbar.tools1.disabled = false;            
        basePropertiesToolbar.tools2.disabled = true;
        basePropertiesToolbar.tools3.disabled = true;
       
    }
    //window.onload=checkButton;
    
    function checkboxevent(chkbx){
        
        if(chkbx.checked){            
            if(basePropertiesToolbar.tools2){
                basePropertiesToolbar.tools2.disabled = false;
            }
            if(basePropertiesToolbar.tools3){
                basePropertiesToolbar.tools3.disabled = false;
            }
        }
        else if(!chkbx.checked){         
            var allcheckbox = document.all.item("serviceid");
            //alert(allcheckbox.length);
            var flag = false;
            for(var i = 0;i < allcheckbox.length; i++){
                if(allcheckbox[i].checked){
                    flag = true;
                }
            }
            if(!flag){
                if(basePropertiesToolbar.tools2){
                    basePropertiesToolbar.tools2.disabled = true;
                }
                if(basePropertiesToolbar.tools3){
                    basePropertiesToolbar.tools3.disabled = true;
                }
            }
        }
        
    }
    
    function editBussiness()
    {
            var allcheckbox = document.all.item("serviceid");
            if(!allcheckbox)
            {
                alert("û��Ҫ�༭�ļ�¼");
                return;
            }
            if(allcheckbox.length)
            {
    	        var count = 0;
    	        for(var i = 0;i < allcheckbox.length; i++){
                    if(allcheckbox[i].checked){
                        count++;                        
                    }
                    if(count > 1)
                        break;
                }
                if(count>1){
                    alert("ֻ��ѡ��һ���޸�");
                    return;
                }
                if(count == 0)
                {
                    alert("��ѡ��һ���޸�");
                    return;
                }
            }
            else if(!allcheckbox.checked)
            {
                alert("��ѡ��һ���޸�");
                return;
            }
            mainform.action = "editbussiness.jsp";
            mainform.submit();            
    }
    
    function delBussiness()
    {
            var allcheckbox = document.all.item("serviceid");
            if(!allcheckbox)
            {
                alert("û��Ҫɾ���ļ�¼");
                return;
            }
            
            var count = 0;
            if(allcheckbox.length)
            {    	        
    	        for(var i = 0;i < allcheckbox.length; i++){
                    if(allcheckbox[i].checked){
                        count++;                        
                    }
                }
                if(count == 0)
                {
                    alert("������ѡ��һ��ɾ��");
                    return;
                }
            }
            else {
                count = 1;
                if(!allcheckbox.checked)
                {
                    alert("������ѡ��һ��ɾ��");
                    return;
                }
            }
            var del = window.confirm("��ȷ��ɾ����ѡ��"+count+"��ҵ����?");
            if(!del){
                return;
            }
            else{
            mainform.action = "delbussiness.jsp";
            mainform.submit();
            }
    }