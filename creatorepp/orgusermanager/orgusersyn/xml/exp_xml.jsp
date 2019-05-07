<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.epp.util.orgusertb.DBTableXmlManager"%>

<%@page import="com.frameworkset.orm.transaction.TransactionManager"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="com.chinacreator.eppissue.util.FileManager"%>
<%@ page import="com.chinacreator.eppissue.menuissue.vo.MenuIssueVo"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
	String userFileUrl = request.getParameter("userUrl");
	if(userFileUrl==null)userFileUrl = "";
	String orgFileUrl = request.getParameter("orgUrl");
	if(orgFileUrl==null)orgFileUrl = "";
	String orgUserFileUrl = request.getParameter("orgUserUrl");
	if(orgUserFileUrl==null)orgUserFileUrl = "";
	String userJobFileUrl = request.getParameter("userJobUrl");
	if(userJobFileUrl==null)userJobFileUrl = "";
	String type = request.getParameter("type");
	if(type==null)type = "";
	String allDept_User = request.getParameter("allDept_User");
	if(allDept_User==null)allDept_User = "";
	String dir = request.getParameter("dir");
	if(dir==null)dir = "";
	String queryString2 = request.getParameter("queryString2");
	if(queryString2==null)queryString2 = "";
		boolean r = false;
		String message = "";
		String expxml = "";
		DBTableXmlManager dm = new DBTableXmlManager();		
		if(type.equals("exp")){//导出
			expxml = dm.expXMLToFilepath(queryString2);
			if(null==expxml || expxml.trim().equals("")){
				message = "导出失败！";
			}
		}else{
			message = "导出失败！";
		}
	if(message.equals("") && !expxml.trim().equals("")){
		request.setCharacterEncoding("GBK");
		response.setContentType("text/html;charset=GBK");

		String path = "/"; //文件在web应用下的相对路径
		String root = getServletContext().getRealPath("/"); //得到网站绝对路径
		//String filepath = "upload/tra_dutam/";                            
		//String filepath = path.replace("/", "\\");      
		String filepath = File.separator;//path.replace("/", "\\");
		//filepath = filepath + "\\\\";

		String myName = new File(expxml).getName();

		// 设置响应头和下载保存的文件名
		response.reset();
		response.setContentType("application/x-msdownload"); //windows
		response
				.setHeader("Content-Disposition",
				"attachment; filename=\""
				+ new String(myName.getBytes("GBK"),
						"iso8859-1") + "\"");

		//新建文件输入输出流
		OutputStream output = null;
		FileInputStream fis = null;
		try {
			//新建File对象
			File f = new File(root + filepath + expxml);
			//add by minghua.guo 2010-05-20
			out.clear();
			out = pageContext.pushBody();
			//新建文件输入输出流对象
			output = response.getOutputStream();
			fis = new FileInputStream(f);
			//设置每次写入缓存大小
			byte[] b = new byte[(int) f.length()];
			//out.print(f.length());
			//把输出流写入客户端
			int i = 0;
			while ((i = fis.read(b)) > 0) {
				output.write(b, 0, i);
			}
			//add by minghua.guo 2010-05-20
			out.clear();
			out = pageContext.pushBody();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				fis.close();
				fis = null;
			}
			if (output != null) {
				output.close();
				output = null;
			}
		}
		String delFile = new File(MenuIssueVo.s_ROOT_PATH+expxml).getParent();
		if((new File(delFile).getParent()).toString().equals((new File(MenuIssueVo.s_MENUUPDATE_TEMP)).getPath())){
			FileManager.delAllFile(delFile);
		}
	}
%>
<script language="javascript">
	var mes = '<%=message%>';
	if(mes!=""){
		alert(mes);
	}
</script>