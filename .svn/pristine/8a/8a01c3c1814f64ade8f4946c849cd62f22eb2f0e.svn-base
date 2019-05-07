<%@ page contentType="text/html;charset=GBK" %>
<%	String appmap = request.getContextPath();
	String printImage = "<img src='" + appmap + "/images/print.gif' border=no alt='打印报表'>";
	String excelImage = "<img src='" + appmap + "/images/excel.gif' border=no alt='导出为excel'>";
	String pdfImage = "<img src='" + appmap + "/images/pdf.gif' border=no alt='导出为pdf'>";
    String wordImage = "<img src='" + appmap + "/images/doc.gif' border=no alt='导出为word'>";
    String iePrientImage ="<img src='" + appmap + "/treeimages/roottreenode.gif' border=no alt='打印报表区域'>";
%>

<table id=titleTable width=100% cellspacing=0 cellpadding=0 border=0 ><tr>
	<td height="22" width=100% valign="middle"  style="font-size:13px" background="../images/ta51top.jpg">
		<table width="100%">
			<tr >
				<td width=53% align="left"  style="font-size:13px" >&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td width="47%" align="center" valign="middle"   style="font-size:12px" >
				<a href="#" onClick="report1_print();return false;"><%=printImage%></a>
				<a href="#" onClick="report1_saveAsExcel();return false;"><%=excelImage%></a>
				<a href="#" onClick="report1_saveAsPdf();return false;"><%=pdfImage%></a>
				<a href="#" onClick="report1_saveAsWord();return false;"><%=wordImage%></a>
				<a href="#" onclick="printReport();return false;"><%=iePrientImage %></a>
			  </td>
			</tr>
	  </table>
	</td>
</table>