<%@ page contentType="text/html;charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*,java.util.regex.*" %>

<HTML>
<HEAD>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<TITLE>eWebEditor �� ��ҳ��ʾ����ʾ��</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<link rel='stylesheet' type='text/css' href='example.css'>
</HEAD>
<BODY>

<p><b>���� �� <a href="default.jsp">ʾ����ҳ</a> &gt; ��ҳ��ʾ����ʾ��</b></p>
<p>������ʾ��eWebEditor�ı�׼��ҳģʽ�£�����Ա�׼��ҳ���Ĵ������������Բ鿴��ҳ����Դ���룬���˽��׼��ҳ���ṹ��ʹ�÷�����</p>


<%
// eWebEditor ��׼��ҳ����ʽ���壺
// -------------------------------------------------------------------
// <!--ewebeditor:page title="��NҳС����"-->
// ��Nҳ����HTML����
// <!--/ewebeditor:page-->
// -------------------------------------------------------------------





// sContent���������༭�����ݣ�һ���Ǵ����ݿ���ȡ��������Ϊģ������
// sContent = rs("field")
String sContent = "<!--ewebeditor:page title=\"��һҳС����\"-->\r\n" +
           "<style>\r\n" +
		   ".p1{font-size:14px;color:#000000;}\r\n" +
		   ".p2{font-size:16px;color:#ff0000;}\r\n" +
		   ".p3{font-size:18px;color:#0000ff;}\r\n" +
		   "</style>\r\n" +
           "<p class=p1>��һҳ����</p>\r\n" +
           "<!--/ewebeditor:page-->\r\n" +
		   "<!--ewebeditor:page title=\"�ڶ�ҳС����\"-->\r\n" +
           "<p class=p2>�ڶ�ҳ����</p>\r\n" +
           "<!--/ewebeditor:page-->\r\n" +
		   "<!--ewebeditor:page title=\"����ҳС����\"-->\r\n" +
           "<p class=p3>����ҳ����</p>\r\n" +
           "<!--/ewebeditor:page-->";
// sContent = "<p>ֻ��һҳ��</p>"




String sPage = dealNull(request.getParameter("page"));
String[] arr = eWebEditorPagination(sContent, sPage);
String sOutputContent = arr[1];
String sOutputTitles = arr[2];

// ��ʾ�����б���ҳ����
if (!sOutputTitles.equals("")){
	out.print("<hr size=1>");
	out.print(sOutputTitles);
}

// ��ʾ����
out.print("<hr size=1>");
out.print(sOutputContent);

%>

</BODY>
</HTML>

<%!

// eWebEditor ��׼��ҳ����ʽ���壺
// -------------------------------------------------------------------
// <!--ewebeditor:page title="��NҳС����"-->
// ��Nҳ����HTML����
// <!--/ewebeditor:page-->
// -------------------------------------------------------------------
// eWebEditor��׼��ҳ������������ʾ��, ����ʵ����Ҫ�޸�, ���ض�ֵ����
// -------------------------------------------------------------------
static String[] eWebEditorPagination(String s_Content, String s_CurrPage){
	// С�����б���ǰҳ���⣬��ǰҳ����
	String s_Titles = "";
	String s_CurrTitle = "";
	String s_CurrContent = s_Content;

	// ҳ����0��ʾû�з�ҳ
	int n_PageCount = 0;

	// ��ǰҳ
	int n_CurrPage = 1;

	// ���з�ҳʱ�����ҳ���ĺͱ�������飬�±��1��ʼ
	ArrayList a_PageContent = new ArrayList();
	ArrayList a_PageTitle = new ArrayList();
	a_PageContent.add("");
	a_PageTitle.add("");


	// ������ʽ����
	Pattern p;
	Matcher m;
	int flags = Pattern.CASE_INSENSITIVE | Pattern.DOTALL;

	// ����������е�CSS��ʽ���֣�Ȼ���ڸ�ҳ�кϲ���ʹ����ҳ����ʾЧ������
	// <style>...</style>
	String s_Style = "";
	p = Pattern.compile("<style[^>]*>([\\s\\S]+?)</style>", flags);
	m = p.matcher(s_CurrContent);
	while (m.find()){
		s_Style = "\r\n" + s_Style + m.group() + "\r\n";
	}
	if (!s_Style.equals("")){
		s_CurrContent = m.replaceAll("");
	}

	// ʹ��������ʽ�Է�ҳ���д���
	p = Pattern.compile("<!--ewebeditor:page title=\"([^\"]*)\"-->([\\s\\S]+?)<!--/ewebeditor:page-->", flags);
	m = p.matcher(s_CurrContent);
	while (m.find()){
		n_PageCount = n_PageCount + 1;
		a_PageTitle.add(m.group(1));
		a_PageContent.add(m.group(2));
	}

	if (n_PageCount == 0){
		// û�з�ҳ
		s_Titles = "";
		s_CurrContent = s_Content;
	}else{
		// �з�ҳ
		// �Ӳ����жϵ�ǰҳ����Ч��
		if (!IsInt(s_CurrPage)){
			n_CurrPage = 1;
		}else{
			n_CurrPage = Integer.parseInt(s_CurrPage);
			if (n_CurrPage < 1 || n_CurrPage > n_PageCount){
				n_CurrPage = 1;
			}
		}

		// ���ж��ҳʱ����ʾ��ҳС���⼰��ҳ����
		s_Titles = "";
		for (int i=1; i<=n_PageCount; i++) {
			if (i == n_CurrPage){
				s_Titles = s_Titles + "<li>" + i + ") " + a_PageTitle.get(i).toString() + "";
			}else{
				s_Titles = s_Titles + "<li><a href='?page=" + i + "'>" + i + ") " + a_PageTitle.get(i).toString() + "</a>";
			}
		}

		// ��ǰҳ���������
		s_CurrTitle = a_PageTitle.get(n_CurrPage).toString();
		s_CurrContent = s_Style + a_PageContent.get(n_CurrPage).toString();
	}

	// ����ֵ���飬��ʵ����Ҫ�޸�
	String[] ret = new String[4];
	ret[1] = s_CurrContent;		//��ǰҳ����
	ret[2] = s_Titles;			//�����б�
	ret[3] = s_CurrTitle;		//��ǰҳ����

	return ret;
}


static String dealNull(String str) {
	String returnstr = null;
	if (str == null) {
		returnstr = "";
	} else {
		returnstr = str;
	}
	return returnstr;
}

static Object dealNull(Object obj) {
	Object returnstr = null;
	if (obj == null){
		returnstr = (Object) ("");
	}else{
		returnstr = obj;
	}
	return returnstr;
}

static boolean IsInt(String str){
	if (str.equals("")){
		return false;
	}

	Pattern p = Pattern.compile("[^0-9]+");
	Matcher m = p.matcher(str);
	if (m.matches()){
		return false;
	}

	return true;
}

%>
