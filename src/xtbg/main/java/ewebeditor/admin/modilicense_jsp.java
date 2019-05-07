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


public class modilicense_jsp
{
		
	private HttpServletRequest m_request;
	private HttpServletResponse m_response;
	private HttpSession m_session;
	private ServletContext m_application;
	private PageContext m_pagecontext;
	private JspWriter m_out; 

	private ewebeditor.admin.util myUtil;


	public modilicense_jsp(){
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




		myUtil.sPosition = myUtil.sPosition + "������Ȩ���к�";

		m_out.print(myUtil.Header());


		if (myUtil.sAction.equals("MODI")) {
			String sNewLicense = myUtil.dealNull(m_request.getParameter("d_license"));

			if ((sNewLicense.indexOf("'")!=-1) || (sNewLicense.indexOf("\"")!=-1)) {
				m_out.print(myUtil.getError("���кŲ��ܺ��������ַ���"));
				return;
			}

			myUtil.sLicense = sNewLicense;

			myUtil.WriteConfig(myUtil.eWebEditorPath, myUtil.sLicense, myUtil.sUsername, myUtil.sPassword, myUtil.aStyle, myUtil.aToolbar);

			
			m_out.print("<table border=0 cellspacing=1 align=center class=navi>"+
			"<tr><th>" + myUtil.sPosition + "</th></tr>"+
			"</table><br>");

			

			m_out.print("<table border=0 cellspacing=1 align=center class=list>"+
			"<tr>"+
				"<td>��Ȩ���к����óɹ���</td>"+
			"</tr>"+
			"</table>");

		} else {

			m_out.print("<table border=0 cellspacing=1 align=center class=navi>"+
			"<tr><th>" + myUtil.sPosition + "</th></tr>"+
			"</table><br>");

			m_out.print("<table border=0 cellspacing=1 align=center class=form>"+
			"<form action='?action=modi' method=post name=myform>"+
			"<tr>"+
				"<th>��������</th>"+
				"<th>������������</th>"+
				"<th>����˵��</th>"+
			"</tr>"+
			"<tr>"+
				"<td width='15%'>���кţ�</td>"+
				"<td width='55%'><input type=text class=input size=60 name=d_license value=\"" + myUtil.htmlEncode(myUtil.sLicense) + "\"></td>"+
				"<td width='30%'>����ԷֺŸ�����<a href='http://service.ewebeditor.net/' target='_blank'>�ӿͷ����Ļ�ȡ</a></td>"+
			"</tr>"+
			"<tr><td align=center colspan=3><input type=submit name=bSubmit value='  �ύ  '></a>&nbsp;<input type=reset name=bReset value='  ����  '></td></tr>"+
			"</form>"+
			"</table>");


		}


		m_out.print(myUtil.Footer());


	}



}
