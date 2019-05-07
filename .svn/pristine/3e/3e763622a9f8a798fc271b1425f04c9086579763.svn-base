<%--  
描述：档案管理-公文待归档-下载zip
作者：邹拓
版本：1.0
日期：2013-06-13
参数:
beanId:待归档的公文的ID
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.ZipUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.tools.zip.ZipEntry"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.frameworkset.common.poolman.PreparedDBUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="org.apache.tools.zip.ZipOutputStream"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.write.*"%>
<%@page import="jxl.Workbook"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.ExportBean"%>
<%@ page language="java" contentType="application/octet-stream; charset=utf-8"%>

<%!public static String toUtf8String(String s) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < s.length(); i++) {
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
                    if (k < 0)
                        k += 256;
                    sb.append("%" + Integer.toHexString(k).toUpperCase());
                }
            }
        }
        return sb.toString();
    }

    public static String toChinese(String strvalue) {
        try {
            if (strvalue == null)
                return null;
            else {
                strvalue = new String(strvalue.getBytes("GBK"), "ISO8859_1");
                return strvalue;
            }
        } catch (Exception e) {
            return null;
        }
    }
%>


<%
	String path = request.getContextPath();
	String beanId = request.getParameter("beanId");
    String zipName = "gongwen.zip";
	try {
		
		DBUtil pdb = new DBUtil();
		StringBuffer sql = new StringBuffer();
		//sql.append("select tbla.f_oldfile_content file_content, '原文.doc' file_name");
		//sql.append("  from oa_file_before_archive_info tbla");
		//sql.append(" where tbla.f_id = '"+beanId+"'");
		//sql.append(" union all ");
		//sql.append("select tblb.f_mainfile_content, '正文.doc'");
		//sql.append("  from oa_file_before_archive_info tblb");
		//sql.append(" where tblb.f_id = '"+beanId+"'");
		//sql.append(" union all ");
		sql.append("select tblc.attachcontent file_content, tblc.filename file_name");
		sql.append("  from oa_fc_attach tblc");
		sql.append(" where tblc.djbh = '"+beanId+"'");
		System.out.println(sql);
		pdb.executeSelect(sql.toString());
		if(pdb.size()>0){
			Map<String,byte[]> files = new HashMap<String,byte[]>();
			for (int i = 0; i < pdb.size(); i++) {
				files.put(pdb.getString(i,"file_name").trim(),pdb.getByteArray(i,"file_content"));
			}
			ZipUtil util = new ZipUtil();
			response.setContentType("application/octet-stream;charset=gb2312");
			response.addHeader("Content-disposition", "attachment; filename="+toUtf8String(zipName));
			util.zipFile2(response.getOutputStream(), files);
		}
	} catch(Exception e){
		System.out.println(beanId+"  exception"+e.getMessage());
		e.printStackTrace();
	}finally {
		
		//zipOut.finish();
		//zipOut.close();
	}
	
	//for exception [java.lang.IllegalStateException: getOutputStream() has already been called for this response]
	out.clear();   
	out = pageContext.pushBody();  

%>
