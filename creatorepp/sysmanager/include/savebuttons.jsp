<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<script language="JavaScript">
function topClose() {
    returnValue="cancel";
    top.close();
}
</script>
<TABLE  width="100%" id="idToolbar" cellpadding='0' cellspacing='0'>
  <TR align="left" valign="top">
    <TD width="*" NOWRAP>&nbsp;</TD>
    <TD width="60" NOWRAP> <A class="tbButton" href="#" title="ȷ��" onclick="if (document.forms[0].onsubmit()) document.forms[0].submit();"><html:img page="/images/dialog-ok.gif" align="absmiddle"  border="0"/> <font color="#0000cc">ȷ��</font></A></td>
        <TD width="10" NOWRAP>&nbsp;</TD>
    <TD width="60" NOWRAP><a class="tbButton" href="#" onclick="topClose()" title="ȡ��"><html:img page="/images/dialog-cancel.gif" align="absmiddle" border="0"/> <font color="#0000cc">ȡ��</font></a></td>
  </tr>
</table>
