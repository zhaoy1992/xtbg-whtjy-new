<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.epp.ouexcelmanager.ExpExeclOrgUser"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.eppissue.util.FileManager"%>
<%@ page import="com.chinacreator.eppissue.menuissue.vo.MenuIssueVo"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%
	String orguserid = StringUtil.replaceNull(request.getParameter("checkorguser"), "");
	ExpExeclOrgUser execlOrgUser = new ExpExeclOrgUser();
	String[] expmess = execlOrgUser.expExeclByOrgUserId(orguserid);
	String message = "";
	if(null!=expmess && expmess.length>1){
		if("succeed".equals(expmess[0])){
			if(null!=expmess[1] && !expmess[1].trim().equals("")){
				request.setCharacterEncoding("GBK");
				response.setContentType("text/html;charset=GBK");
		
				String path = "/"; //文件在web应用下的相对路径
				String root = getServletContext().getRealPath("/"); //得到网站绝对路径
				//String filepath = "upload/tra_dutam/";                            
				String filepath = path.replace("/", "\\");
				//filepath = filepath + "\\\\";
		
				String myName = new File(expmess[1]).getName();
		
				// 设置响应头和下载保存的文件名
				response.reset();
				response.setContentType("application/x-msdownload"); //windows
				response
						.setHeader("Content-Disposition",
						"attachment; filename=\""
						+ new String(myName.getBytes("gb2312"),
								"iso8859-1") + "\"");
		
				//新建文件输入输出流
				OutputStream output = null;
				FileInputStream fis = null;
				try {
					//新建File对象
					File f = new File(expmess[1]);
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
					output.flush();
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
				if((new File(expmess[1]).getParent()).toString().equals((new File(MenuIssueVo.s_MENUUPDATE_TEMP)).getPath())){
					FileManager.delAllFile(expmess[1]);
				}
			}else{
				message = "导出文件路径错误！";
			}
		}else if("err".equals(expmess[0])){
			message = expmess[1];
		}else{
			message = "导出错误！";
		}
	}
%>
<script language="javascript">
	var mes = '<%=message%>';
	if(mes!=""){
		alert(mes);
	}
</script>