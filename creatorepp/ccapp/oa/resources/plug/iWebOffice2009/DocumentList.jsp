<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date" %>
<%@page import="com.chinacreator.iWebOffice2006.iDBManager2000"%>
<%!
iDBManager2000 DbaObj=new iDBManager2000();

//�г�����ģ��
public String GetTemplateList(String ObjType, String FileType)
  {
    String mTemplateList,mstr="";
    mTemplateList = "<select name=" + ObjType + " >";
    mTemplateList = mTemplateList +  "<option value=''>--------����ģ��--------</option>";
    String Sql = "select RecordID,Descript from Template_File where FileType='" + FileType + "'"; //�����ݿ�
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          mstr="selected";
          while (result.next()) {
            mTemplateList = mTemplateList + "<option value='" + result.getString("RecordID") + "'"+mstr+">" + result.getString("Descript") + "</option>";
          }
          result.close();
        }
        catch (SQLException sqlex) {
          System.out.println(sqlex.toString());
        }
      }
      else {
        System.out.println("GetTemplateList: OpenDatabase Error");
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    mTemplateList = mTemplateList + "</select>";
    return (mTemplateList);
  }

  /**
   * ���ܻ����ã���ʽ������ʱ��
   * @param DateValue �������ڻ�ʱ��
   * @param DateType ��ʽ�� EEEE������, yyyy����, MM����, dd����, HH��Сʱ, mm�Ƿ���,  ss����
   * @return ����ַ���
   */
  public String FormatDate(String DateValue,String DateType)
  {
    String Result;
    SimpleDateFormat formatter = new SimpleDateFormat(DateType);
    try{
      Date mDateTime = formatter.parse(DateValue);
      Result = formatter.format(mDateTime);
    }catch(Exception ex){
      Result = ex.getMessage();
    }
    if (Result.equalsIgnoreCase("1900-01-01")){
      Result = "";
    }
    return Result;
  }
%>
<html>
<head>
<title>���Ƽ�-iWebOffice2009ȫ����עʵ��</title>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color=ff0000>ȫ����ע�м��Ӧ��ʾ��[iWebOffice2009 OCX��]</font></div>
<hr size=1>
<div class=IptStyle>
  <p>ע����ʾ���ܴ򿪺ͱ��������ϵ��ļ�����ʽ���ʵ�ָ�ǿ��Ĺ��ܣ���Ҫ��ʽ�棬������Ƽ���ϵ��<br>
  &nbsp;&nbsp;&nbsp;&nbsp;��Ҫ��ȷ��ʾ��ʾ���������:<br>
    1.��װOffice2000ϵͳ��IE5.0���ϰ汾�������Window 98���ϵļ���������С�<br>
  2.��װiWebOffice2009����������ڴ򿪱�ҳ��ĵ�������ʱ��ѡ��[��]��ť,�����������С�<br>
  3.������������Զ���װiWebOffice2009�����<a href="InstallClient.zip">�������������ر��ذ�װ����</a>��<br>
  </p>
</div>
<hr size=1>
  <table width="100%"><tr><td height="25"><script src="iWebOffice2009.js"></script></td></tr></table>
<hr size=1>
<br>
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
<tr>
  <td colspan=6 class="TDTitleStyle">
     &nbsp;<input type=button name="BookMark" value="��ǩ����"  onclick="javascript:location.href='BookMark/BookMarkList.jsp'">
     &nbsp;<input type=button name="Template" value="ģ�����"  onclick="javascript:location.href='Template/TemplateList.jsp'">
     &nbsp;<input type=button name="Template" value="ǩ�¹���"  onclick="javascript:location.href='Signature/SignatureList.jsp'">
  </td>
</tr>

<tr>
  <td colspan=4 class="TDTitleStyle" >
    ��ѡ��ģ��:<%=GetTemplateList("doc",".doc")%>
    <input type=button value="�½�word�ĵ�  "  onclick="javascript:location.href='DocumentEdit.jsp?FileType=.doc&UserName='+username.value+'&Template='+doc.value;">
    <br>
    ��ѡ��ģ��:<%=GetTemplateList("xls",".xls")%>
    <input type=button value="�½�excel�ĵ� "  onclick="javascript:location.href='DocumentEdit.jsp?FileType=.xls&UserName='+username.value+'&Template='+xls.value;">
    <br>
    ��ѡ��ģ��:<%=GetTemplateList("wps",".wps")%>
    <input type=button value="�½�wps�ĵ�   "  onclick="javascript:location.href='DocumentEdit.jsp?FileType=.wps&UserName='+username.value+'&Template='+wps.value;">
    <br>
    ��ѡ��ģ��:<%=GetTemplateList("et",".et")%>
    <input type=button value="�½���ɽ���  "  onclick="javascript:location.href='DocumentEdit.jsp?FileType=.et&UserName='+username.value+'&Template='+et.value;">
    <br>
    ��ѡ��ģ��:<%=GetTemplateList("ppt",".ppt")%>
    <input type=button value="�½�ppt�ĵ�   "  onclick="javascript:location.href='DocumentEdit.jsp?FileType=.ppt&UserName='+username.value+'&Template='+ppt.value;">
    <br>
    ��ѡ��ģ��:<%=GetTemplateList("vsd",".vsd")%>
    <input type=button value="�½�visio�ĵ� "  onclick="javascript:location.href='DocumentEdit.jsp?FileType=.vsd&UserName='+username.value+'&Template='+vsd.value;">
  </td>
  <td colspan=2 class="TDTitleStyle">���ڲ�ͬ�û������ۼ���ʹ�ò�ͬ����ɫ���������޸��ĵ�ʱ��������<input type=text name=username size=8 value="��ʾ��">
  </td>
</tr>

<tr>
  <td nowrap align=center class="TDTitleStyle" height="25">���</td>
  <td nowrap align=center class="TDTitleStyle">����</td>
  <td nowrap align=center class="TDTitleStyle">����</td>
  <td nowrap align=center class="TDTitleStyle">����</td>
  <td nowrap align=center class="TDTitleStyle">����</td>
  <td nowrap align=center class="TDTitleStyle">����</td>
</tr>
<%
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery("select Status,RecordID,HtmlPath,DocumentID,Subject,Author,FileType,FileDate from Document order by DocumentID desc");
          while (result.next()) {
            String RecordID = result.getString("RecordID");
            String HTMLPath = result.getString("HtmlPath");
            if (HTMLPath == null)
               HTMLPath = "";
%>
<tr>
  <td class="TDStyle"><%=result.getString("DocumentID")%>&nbsp;</td>
  <td class="TDStyle"><%=result.getString("Subject")%>&nbsp;</td>
  <td class="TDStyle"><%=result.getString("Author")%>&nbsp;</td>
  <td class="TDStyle"><%=result.getString("FileType")%>&nbsp;</td>
  <td class="TDStyle"><%=FormatDate(result.getString("FileDate"),"yyyy-MM-dd")%>&nbsp;</td>
  <td class="TDStyle" nowrap>
    <input type=button onClick="javascript:location.href='DocumentEdit.jsp?RecordID=<%=RecordID%>&EditType=0,0&ShowType=1&UserName='+username.value;" value="�Ķ�">
    <input type=button onClick="javascript:location.href='DocumentEdit.jsp?RecordID=<%=RecordID%>&EditType=1,1&ShowType=1&UserName='+username.value;" value="�޸�[�޺ۼ�]">
    <input type=button onClick="javascript:location.href='DocumentEdit.jsp?RecordID=<%=RecordID%>&EditType=2,1&ShowType=1&UserName='+username.value;" value="�޸�[�кۼ�]">
    <input type=button onClick="javascript:location.href='DocumentEdit.jsp?RecordID=<%=RecordID%>&EditType=3,1&ShowType=2&UserName='+username.value;" value="�쵼��д">
    <input type=button onClick="javascript:location.href='DocumentEdit.jsp?RecordID=<%=RecordID%>&EditType=3,0&ShowType=0&UserName='+username.value;" value="���">
    <input type=button <% if (HTMLPath.equalsIgnoreCase("")) out.write("disabled"); %> onClick="javascript:window.open('<%=HTMLPath%>');" value="HTML">
  </td>
</tr>
<%
          }
          result.close();
        }
        catch (SQLException sqlex) {
          System.out.println(sqlex.toString());
        }
      }
      else {
        out.println("OpenDatabase Error");
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
%>
</table>
</body>
</html>