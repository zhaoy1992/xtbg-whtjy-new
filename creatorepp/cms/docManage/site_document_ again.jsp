<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<title>���ݹ��������</title>
<script src="../inc/js/func.js"></script>
<script language="javascript" >
 function validBox(eleName)
{
        var ele = document.getElementsByName(eleName); //add by eyes
        //alert(ele[2].mis);
        //alert("ele length:"+ele.length);
        //   eval("var chks="+name+"."+ele.name);
        var selectCount=0;
        for(var i=0;i<ele.length;i++)
        {
                if(ele[i].checked)
                {
                        selectCount++;
                }
        }

        if(ele[0].mis!=null && !isNaN(ele[0].mis))//ע��������ele[0]��������ele.minsel
        {
                //alert("��mis");
                if(selectCount<parseInt(ele[0].mis))
                {
                        alert(convertNullToSpace(ele.on)+"����ѡ��"+ele[0].mis+"��");
                        ele[0].focus();
                        return false;
                }
        }
        if(ele[0].mas!=null && !isNaN(ele[0].mas))
        {
                if(selectCount>parseInt(ele[0].mas))
                {
                        alert(convertNullToSpace(ele[0].on)+"����ѡ��"+ele[0].mas+"��");
                        ele[0].focus();
                        return false;
                }
        }
        return true;
}
function selectAll(form)
{
  for (var i=0;i<form.elements.length;i++)
    {
     var e = form.elements[i];
     e.checked = 1;
    }
	div_all.style.display="none";
	div_no.style.display="block";
	
}

function selectNo(form)
{
  for (var i=0;i<form.elements.length;i++)
    {
     var e = form.elements[i];
     e.checked = 0;
    }
	div_all.style.display="block";
	div_no.style.display="none";
	
}
function again()
	{
		getPropertiesContent().location.href="../docManage/document_factum_again.jsp";   
	}

</script>
<style type="text/css">
<!--
body {
	background-color: #ffffff;
}
.STYLE1 {color: #0000FF}
.STYLE2 {color: #000099}
-->
</style></head>

<body topmargin="3" rightmargin="0">
<form id="form1" name="form1" method="post" action="">
<table width="100%" height="565" border="0"   cellpadding="0" align="center" cellspacing="0">
  <tr>
    <td height="82" valign=top background="../images/pagebar.jpg" style="background-repeat:no-repeat"><table width="100%" border="0">
      <tr>
        <td height="23">&nbsp;&nbsp;&nbsp;&nbsp; ��ǰλ��:�ҵĹ����������ĵ�</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
	   <tr>
       <td >
	     <div align="right">
	     <div align="right"><a href="site_document.jsp">�����б�</a>  <a href="site_document_submit.jsp">�ѳ��ĵ�</a>  <a href="site_document_%20again.jsp">�����ĵ�</a>  <a href="site_document_each.jsp">�����ĵ�</a>  <a href="site_document_draft.jsp">�ݸ���</a>  <a href="site_document_dustbin.jsp"></a>  <a href="../main.jsp">��ҳ</a></div></td>
       </tr>
    </table></td>
  </tr>
  <tr>
    <td  height="483" valign=top background="../images/tile.jpg" bgcolor="#FFFFFF"><table width="98%" border="0" align="center">

      <tr>
        <td width="18%">&nbsp; ���⣺
          <input name="textfield" type="text" class="cms_text" size="10"></td>
        <td width="21%">&nbsp; �������ݣ�
          <input name="textfield" type="text" class="cms_text" size="10"></td>
        <td width="21%">&nbsp; &nbsp; �ؼ��ʣ�
          <input name="textfield" type="text" class="cms_text" size="10"></td>
        <td width="18%">              <div align="left">���ߣ�
            <input name="textfield" type="text" class="cms_text" size="10">
</div></td>
        <td width="22%"> �����ˣ�
          <input name="textfield" type="text" class="cms_text" size="10"> </td>
      </tr>
	    <tr>
        <td width="18%">&nbsp;</td>
        <td width="21%">&nbsp; ����ʱ�䣺          
          <select name="select" class="cms_select">
            <option>����</option>
            <option>���һ��</option>
            <option>���һ��</option>
            <option>���һ��</option>
            <option>�������</option>
            <option>���һ��</option>
          </select></td>
          <td width="21%">&nbsp; &nbsp; ��ȫ����
            <select name="select" class="cms_select">
              <option>ȫ��</option>
              <option>���</option>
              <option>��</option>
              <option>��</option>
              <option>��ͨ</option>
            </select></td>
        <td>              <div align="left">
          </div></td>
        <td><div align="center">
            <input name="Submit" type="submit" class="cms_button" value="��ѯ">
            <input name="Submit" type="submit" class="cms_button" value="��ʾ����"> 
          </div></td>
      </tr>
      <tr>
        <td colspan="5"><table width="98%" border="0" align="center">
          <tr class="cms_report_tr">
            <td width="6%" ><div  id="div_all" onClick="selectAll(form1)" align="center" style="cursor:hand">
              <div align="center">ȫѡ</div>
            </div><div  style='display:none;cursor:hand' id='div_no' onClick='selectNo(form1)' align='center' >
              <div align="center">ȫ��ѡ</div>
            </div></td>
            <td width="8%" ><div align="center">�ĵ�״̬</div></td>
            <td width="34%" height="19"><div align="center">�ĵ�����</div></td>
            <td width="12%"><div align="center">������</div></td>
            <td width="17%"><div align="center">�����</div></td>
            <td width="23%"><div align="center">���ʱ��</div></td>
          </tr>
          <tr class="cms_data_tr">
            <td>
                <div align="left">
                  <input type="checkbox" name="checkbox" value="checkbox" />
                  <span class="STYLE2">1</span></div></td>
            <td><div onClick="openWin('template_edit.jsp',900,800)" style="cursor:hand">
              <div align="center">�¸�</div>
            </div></td>
          
			 <td><div onClick="openWin('../templateManage/Managetemplate_edit.jsp',900,800)" style="cursor:hand"><u>���ϴ�ѧ��ҳģ��</u></div></td>
            <td><div align="center">admin</div></td>
            <td><div align="center">admin</div></td>
            <td><div align="center">2006��11��27</div></td>
          </tr>
          <tr class="cms_data_tr">
            <td>
              <div align="left">
                <input type="checkbox" name="checkbox2" value="checkbox" />
                <span class="STYLE2">2</span> </div></td>
            <td><div onClick="openWin('template_edit.jsp',900,800)" style="cursor:hand">
              <div align="center">�¸�</div>
            </div></td>
            <td><div align="left"><u><a href="../templateManage/template_preview.jsp">У������ϸ��ģ��</a></u></div></td>
            <td><div align="center">admin</div></td>
            <td><div align="center">admin</div></td>
            <td><div align="center">2006��11��27</div></td>
          </tr>
          <tr class="cms_data_tr">
            <td>
              <div align="left">
                <input type="checkbox" name="checkbox22" value="checkbox" />
                <span class="STYLE2">3</span></div></td>
            <td><div align="center">�¸�</div></td>
            <td><div align="left"><a href="../templateManage/template_preview.jsp">����ָ�ϸ���</a></div></td>
            <td><div align="center">admin</div></td>
            <td><div align="center">admin</div></td>
            <td><div align="center">2006��11��27</div></td>
          </tr>
          <tr class="cms_data_tr">
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
          </tr>
          <tr class="cms_data_tr">
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
          </tr>
          <tr class="cms_data_tr">
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
          </tr>
          <tr class="cms_data_tr">
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
          </tr>
          <tr class="cms_data_tr">
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
          </tr>
          <tr class="cms_data_tr">
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
            <td><div align="left"></div></td>
          </tr>
        </table> </td>
      </tr>
      <tr>
        <td colspan="4"><div align="center">��1ҳ ��1ҳ| ��һҳ | ��һҳ | βҳ<span class="STYLE1"> Go</span>
          <label>
          <select name="select" class="cms_select">
            <option value="1">1</option>
            <option value="2">2</option>
          </select>
          </label> 
          ҳ
</div></td>
        <td><div align="center">
        
           <input name="Submit" type="button" class="cms_button" value="�ٴγ���" onClick="again()">
        </div></td>
      </tr>
    </table></td>
  </tr>
 
</table> </form>
</body>
</html>
