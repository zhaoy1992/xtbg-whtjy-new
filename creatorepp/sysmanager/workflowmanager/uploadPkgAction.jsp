<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="com.chinacreator.workflow.PackageManager"%>
<%@page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="java.util.*,java.io.*"%>


<%AccessControl accesscontroler = AccessControl.getInstance();
            accesscontroler.checkAccess(request, response);

            try{
				DiskFileUpload fu = new DiskFileUpload ();
				PackageManager packageManager = new PackageManager();
				List fileItems = fu.parseRequest(request);
				Iterator i = fileItems.iterator();
				FileItem fi = (FileItem)i.next();
				String fileName = fi.getName();
				if(fileName!=null){
					File fullFile = new File(fi.getName());
					String approot = ConfigManager.getInstance().getConfigValue("approot");
					//得到服务器端文件路径
					File savedFile =  new File(approot+"WEB-INF/conf/repository/external",fullFile.getName());
					//上传文件到服务器
					fi.write(savedFile);
					Long length = new Long(fullFile.length());
					byte[] buff = new byte[length.intValue()];
		            FileInputStream infile = null;
					
		            //生成对象infile 准备读取文件
		            try
		            {
		            	infile = new FileInputStream(savedFile);
		            }
		            catch (FileNotFoundException e)
		            {
			            System.err.println("没有找到文件");
			            System.exit(1);
		            }
					int n = 0;
		            while (n < length.intValue())
		            {
		                try
		                {
		                    n = infile.read(buff); // 从文件读取数据
		                }
		                catch (Exception e)
		                {
		                    out.println("读取数据出错");
		                } 
		            }
		
		            try
		            {
		                infile.close();
		            }
		            catch (IOException e)
		            {
		                System.err.println("文件错误");
		                System.exit(1);
		            }
		            if(packageManager.uploadPkg(accesscontroler,fullFile.getName(),buff)==true)
		            {
		            	out.println("<script language=\"javascript\">document.location.href=\"packagemgr.jsp\"</script>");
					}
					else
					{
						out.println("<script language=\"javascript\">document.location.href=\"packagemgr.jsp\"</script>");
					}
				}
				
						
				
			}catch(Exception e){
				out.println(e.getMessage());
			}
%>
