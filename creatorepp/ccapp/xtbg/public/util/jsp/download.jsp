
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.FileDownLoadHandler"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.impl.FiletransferServiceImpl"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DataControlUtil"%><%@ page language="java" contentType="application/octet-stream; charset=gbk"%>


<%--
������ϵͳ�ļ�����ҳ��
���ߣ�steven.zhu
�汾��1.0
���ڣ�2011-7-11
--%>
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

public static String toChinese(String strvalue)
{
         try{
             if(strvalue == null)
                return null;
             else
             {
                strvalue = new String(strvalue.getBytes("GBK"), "ISO8859_1");
                return strvalue;
         }
         }catch(Exception e){
               return null;
         }
}

%>
<%
// request.setCharacterEncoding("gbk");
//response.setCharacterEncoding("gbk");
 

	//�ļ��ľ��Ե�ַ(��d:\workspce....֮���)
    String filelocation = DataControlUtil.replaceStr(request.getParameter("filelocation"));
	String djsn = DataControlUtil.replaceStr(request.getParameter("djsn"));
	String attachid = DataControlUtil.replaceStr(request.getParameter("attachid"));
	//�ļ���������
   // String displayname= new String(request.getParameter("displayname").getBytes("GBK"), "UTF-8");
	String displayname= DataControlUtil.replaceStr(request.getParameter("displayname"));
	//displayname="bug�ļ�";
    response.reset();
    String onlineEdit = DataControlUtil.replaceStr(request.getParameter("onlineEdit"));//���߱༭(֧��word,excel)  
   
    String  mFilePath = request.getSession().getServletContext().getRealPath("") ;  //ȡ�÷�����·��

	OutputStream output = null;
	FileInputStream fis = null;
	InputStream obis = null;
	FileInfoBean fib = null;
	FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
	File file = null;
	fib = fsd.getFileByDjsn(djsn);
	
	try {
		if(FileDownLoadHandler.ifOnlineEdit(onlineEdit,fib.getExtend())){//�������߱༭ ���� ����ָ��������
			response.setContentType("text/plain; charset=UTF-8");
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			String send_Url = request.getContextPath()+FileDownLoadHandler.getOnlineEditUrl(djsn);
			//response.sendRedirect(request.getContextPath()+FileDownLoadHandler.getOnlineEditUrl(djsn));
			StringBuffer do_script = new StringBuffer();
						do_script.append("<script type='text/javascript'>");
						//do_script.append("openOnlineEditWindow = function(url,model){");
						//do_script.append("	if('' !== url)");
						//do_script.append("	window.open(url,model);");
						//do_script.append("	setTimeOut(function(){url = '';},200);");
						//do_script.append("};");
						do_script.append("window.open('"+send_Url+"');");
						do_script.append("</script>");
						
			response.getWriter().write(do_script.toString());
			response.getWriter().flush();
			response.getWriter().close();
		}else{
			output = response.getOutputStream();

			
			file = new File(mFilePath+FiletransferServiceImpl.upload_To_SeverPath+fib.getDjsn()+fib.getExtend());
			
			//response.setContentType("application/octet-stream");
			response.setContentType("application/octet-stream;charset=gb2312");
			
			String filename = fib.getFilename().replaceAll(";","��").replaceAll("��","`");
			
			filename = new String(filename.getBytes("GB2312"), "ISO8859-1");
			//filename = "\""+filename + "\"";
			response.addHeader("Content-disposition", "attachment; filename="+filename);
			
			//response.setHeader("Content-Disposition", "attachment;filename="+ new String(filename.replaceAll(";","��").getBytes("GB2312"), "ISO8859-1"));
			if(file.exists()){
				obis = new FileInputStream(file);
			}else{
				obis = (InputStream)fib.getFileInput();
			}
			byte[] b = new byte[1024];
			int i = 0;
			while ((i = obis.read(b)) > 0) {
				output.write(b, 0, i);
			}
		
			output.flush();
			out.clear();
			out = pageContext.pushBody();
		}
		

	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
		if (fis != null) {
			fis.close();
			fis = null;
		}
		if(obis != null) {
			obis.close();
			obis = null;
		}
		if (output != null) {
			output.close();
			output = null;
		}
	}
%>


