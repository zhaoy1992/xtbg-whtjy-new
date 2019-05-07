package ewebeditor.admin;

import java.util.*;
import java.util.regex.*;
import java.text.*;
import java.io.*;


import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;


public class main_jsp
{
		
	private HttpServletRequest m_request;
	private HttpServletResponse m_response;
	private HttpSession m_session;
	private ServletContext m_application;
	private PageContext m_pagecontext;
	private JspWriter m_out; 

	private ewebeditor.admin.util myUtil;


	public main_jsp(){
		myUtil = new ewebeditor.admin.util();
	}



	public final void Load(PageContext pagecontext) throws ServletException,IOException{
		m_pagecontext = pagecontext;
		m_application = pagecontext.getServletContext();
		m_request = (HttpServletRequest)pagecontext.getRequest();
		m_response = (HttpServletResponse)pagecontext.getResponse();
		m_session = (HttpSession)pagecontext.getSession();
		m_out = pagecontext.getOut();

		
		if (!myUtil.InitAdmin(pagecontext, true)){
			return;
		}



		myUtil.sPosition = myUtil.sPosition + "��̨������ҳ";

		m_out.print(myUtil.Header());



		m_out.print("<table border=0 cellspacing=1 align=center class=navi>"+
		"<tr><th>" + myUtil.sPosition + "</th></tr>"+
		"</table><br>");

		

		m_out.print("<table border=0 cellspacing=1 align=center class=list>"+
		"<tr><th colspan=2>eWebEditor 8.3 ��Ȩ��������ϵ����������֧��</th></tr>"+
		"<tr>"+
			"<td width='15%'>����汾��</td>"+
			"<td width='85%'>eWebEditor Version 8.3 for JSP ����������ҵ��</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='15%'>��Ȩ���У�</td>"+
			"<td width='85%'><a href='http://www.ewebsoft.com' target='_blank'>eWebSoft.com</a>&nbsp;&nbsp;�ѻ�ù��Ұ�Ȩ�ְ䷢�ġ�������������Ȩ�Ǽ�֤�顷,�ǼǺ�:2004SR06549</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='15%'>��ҳ��ַ��</td>"+
			"<td width='85%'><a href='http://www.ewebeditor.net/' target='_blank'>eWebEditor����վ(www.eWebEditor.net)</a>&nbsp;&nbsp;&nbsp;<a href='http://service.ewebeditor.net/' target='_blank'>�ͷ�����(service.eWebEditor.net)</a></td>"+
		"</tr>"+
		"<tr>"+
			"<td width='15%'>��Ȩ��֤��</td>"+
			"<td width='85%'>");

		if (myUtil.sLicense.equals("")){
			m_out.print("<span class=red>δ��Ȩ</span> [<a href='modilicense.jsp'>������Ȩ���к�</a>]");
		}else{
			m_out.print("<iframe name=ifrLicense src='' style='width:100%;height:20px;margin:0' scrolling='no' frameborder=0></iframe>"+
				"<div style='display:none;position:absolute;'>"+
				"<form name=formLicense action='http://service.ewebeditor.net/i_license.asp' target='ifrLicense' method=post>"+
				"<input type=hidden name='d_license' value=\""+myUtil.sLicense+"\">"+
				"<input type=hidden name='d_url' value=''>"+
				"<input type=hidden name='d_version' value='8.3'>"+
				"</form>"+
				"</div>"+
				"<script type='text/javascript'>submitLicense();</script>");
		}
		
		m_out.print("</td>"+
		"</tr>"+
		"</table><br>");

		m_out.print("<table border=0 cellspacing=1 align=center class=list>"+
		"<tr><th colspan=2>���������йز���</th></tr>"+
		"<tr>"+
			"<td width='20%'>����������</td>"+
			"<td width='80%'>" + m_request.getServerName() + "</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='20%'>������IP��</td>"+
			"<td width='80%'>" + m_request.getRemoteAddr() + "</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='20%'>�������˿ڣ�</td>"+
			"<td width='80%'>" + String.valueOf(m_request.getServerPort()) + "</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='20%'>������ʱ�䣺</td>"+
			"<td width='80%'>" + (new java.util.Date() ).toString() + "</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='20%'>URL·����</td>"+
			"<td width='80%'>" + m_request.getRequestURL() + "</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='20%'>URI·����</td>"+
			"<td width='80%'>" + m_request.getRequestURI() + "</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='20%'>Servlet·����</td>"+
			"<td width='80%'>" + m_request.getServletPath() + "</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='20%'>Context·����</td>"+
			"<td width='80%'>" + m_request.getContextPath() + "</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='20%'>����·����</td>"+
			"<td width='80%'>" + m_application.getRealPath("/") + "</td>"+
		"</tr>"+
		"<tr>"+
			"<td width='20%'>Server Info��</td>"+
			"<td width='80%'>" + m_pagecontext.getServletConfig().getServletContext().getServerInfo() + "</td>"+
		"</tr>"+
		"</table>");


		m_out.print(myUtil.Footer());



	}



}
