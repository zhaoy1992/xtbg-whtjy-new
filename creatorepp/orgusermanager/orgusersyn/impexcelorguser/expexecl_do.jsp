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
		
				String path = "/"; //�ļ���webӦ���µ����·��
				String root = getServletContext().getRealPath("/"); //�õ���վ����·��
				//String filepath = "upload/tra_dutam/";                            
				String filepath = path.replace("/", "\\");
				//filepath = filepath + "\\\\";
		
				String myName = new File(expmess[1]).getName();
		
				// ������Ӧͷ�����ر�����ļ���
				response.reset();
				response.setContentType("application/x-msdownload"); //windows
				response
						.setHeader("Content-Disposition",
						"attachment; filename=\""
						+ new String(myName.getBytes("gb2312"),
								"iso8859-1") + "\"");
		
				//�½��ļ����������
				OutputStream output = null;
				FileInputStream fis = null;
				try {
					//�½�File����
					File f = new File(expmess[1]);
					//�½��ļ��������������
					output = response.getOutputStream();
					fis = new FileInputStream(f);
					//����ÿ��д�뻺���С
					byte[] b = new byte[(int) f.length()];
					//out.print(f.length());
					//�������д��ͻ���
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
				message = "�����ļ�·������";
			}
		}else if("err".equals(expmess[0])){
			message = expmess[1];
		}else{
			message = "��������";
		}
	}
%>
<script language="javascript">
	var mes = '<%=message%>';
	if(mes!=""){
		alert(mes);
	}
</script>