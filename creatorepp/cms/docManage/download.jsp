<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%!
public static String toUtf8String(String s) {
	StringBuffer sb = new StringBuffer();
	for (int i=0;i<s.length();i++) {
		char c = s.charAt(i);
		if (c >= 0 && c <= 255) {
			sb.append(c);
		} else {
			byte[] b;
			try {
				b = Character.toString(c).getBytes("utf-8");
			} catch (Exception ex) {		
				b = new byte[0];
			}
			for (int j = 0; j < b.length; j++) {
				int k = b[j];
				if (k < 0) k += 256;
				sb.append("%" + Integer.toHexString(k).toUpperCase());
			}
		}
	}
	return sb.toString();
}
%>


<%
String s = request.getParameter("file");
System.out.println(s);
File t_file = new java.io.File(s);
if (!t_file.exists()){%>
	<script language="JavaScript">
		alert("�ļ��Ѿ�������!");
	</script>
<%
		return;
	}

InputStream in = new FileInputStream(t_file); 
if(in != null){
	String fs = t_file.getName();
	//new String(fs.getBytes("ISO8859-1"),"gb2312")
	int l=(int)t_file.length();
	response.reset();
	response.setHeader("Content-Disposition", "attachment;filename=\"" + toUtf8String(fs) + "\"");
	//response.setHeader("Content-Disposition", "attachment; filename="+toUtf8String(fs)); 
	byte[] b = new byte[l]; 
	int len = 0; 
	while((len=in.read(b))>0){
		OutputStream os = response.getOutputStream();
		os.write(b,0,len);
		os.flush();
		os.close();
	} 
	in.close(); 
}
%>