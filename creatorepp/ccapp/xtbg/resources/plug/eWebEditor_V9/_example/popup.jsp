<%@ page contentType="text/html;charset=GBK" pageEncoding="GBK"%>

<HTML>
<HEAD>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<TITLE>eWebEditor �� ��������ʾ��</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<link rel='stylesheet' type='text/css' href='example.css'>
</HEAD>
<BODY>

<p><b>���� �� <a href="default.jsp">ʾ����ҳ</a> &gt; ��������ʾ��</b></p>
<p>��ҳ���б���Ԫ�ؽ϶�ʱ���˷�������ʹҳ��������࣬���ӿ��ҳ�ļ����ٶȡ�</p>
<p>�����HTML�༭����ť���ڵ������ڱ༭һЩ���ݣ�Ȼ��㡰���淵�ء���ť����һ��Ч����</p>


<script type="text/javascript">
function eWebEditorPopUp(style, field, width, height) {
	window.open("../popup.htm?style="+style+"&link="+field, "", "width="+width+",height="+height+",toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no");
}
</script>


<FORM ACTION="retrieve.jsp" METHOD="post" NAME="myform">
<TABLE border="0" cellpadding="2" cellspacing="1">
<TR>
	<TD>�༭���ݣ�</TD>
	<TD>
		<TEXTAREA NAME="content1" COLS="50" ROWS="10" style="width:550px">&lt;i&gt;��������ʾ��&lt;/i&gt;</TEXTAREA><br>
		<INPUT TYPE="BUTTON" NAME="btn" VALUE="HTML�༭" ONCLICK="eWebEditorPopUp('popup', 'content1', 580, 380)">
	</TD>
</TR>
<TR>
	<TD align=right colspan=2>
	<INPUT type=submit value="�ύ">
	<INPUT type=reset value="����">
	<INPUT type=button value="�鿴Դ�ļ�" onclick="location.replace('view-source:'+location)">
	</TD>
</TR>
</TABLE>
</FORM>


</BODY>
</HTML>
