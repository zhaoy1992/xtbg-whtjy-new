<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>

<head>  
  <title>��������</title>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
  
  <script language="javascript">
    function disableButton(){        
        while(!getPropertiesToolbar().tools1){
            ;
        }
        getPropertiesToolbar().tools1.disabled = true;            
        getPropertiesToolbar().tools2.disabled = true;
        getPropertiesToolbar().tools3.disabled = true;           
    }
    //window.onload=disableButton;
    
  </script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder">

<table>
  <tr>
    <td>
      ��ѡ��һ��������
    </td>
  </tr>
</table>

</div>
<%@ include file="../sysMsg.jsp"%>
</body>
</html>
  
     
 
 
