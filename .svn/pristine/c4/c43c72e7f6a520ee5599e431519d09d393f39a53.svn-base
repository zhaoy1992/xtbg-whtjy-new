

<%@page import="com.chinacreator.xtbg.pub.personwork.entity.PersonSearchBean"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.PublicAddressDirectoryBean"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.dao.impl.PersonInfoDaoImpl"%>
<%@ page import="jxl.write.Label"%>
<%@ page import="jxl.format.Alignment"%>
<%@ page import="jxl.write.WritableCellFormat"%>
<%@ page import="jxl.write.WritableFont"%>
<%@ page import="jxl.write.WritableSheet"%>
<%@ page import="jxl.Workbook"%>
<%@ page import="jxl.write.WritableWorkbook"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.xtbg.pub.common.PagingBean"%>
<%@ page import="com.chinacreator.eform.util.Escape"%>
<%@ page import="com.alibaba.fastjson.JSONObject"%>
<%@ page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.chinacreator.xtbg.pub.util.LoadPropertiesUtil"%>
<%@ page import="org.apache.commons.configuration.PropertiesConfiguration"%>
<%@ page import="org.apache.poi.poifs.filesystem.DocumentEntry"%>
<%@ page import="org.apache.poi.poifs.filesystem.DirectoryEntry"%>

<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.ByteArrayInputStream"%>
<%@ page import="com.frameworkset.common.poolman.PreparedDBUtil"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DataControlUtil"%>
<%@ page language="java" contentType="application/octet-stream; charset=gbk"%>


<%--  公共通讯录excel导出
描述：系统文件下载页面
作者：steven.zhu
版本：1.0
日期：2011-7-11
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
 

	//文件的绝对地址(如d:\workspce....之类的)
	
	//文件下载数据
   // excel文件名
       String parmjson = request.getParameter("parmjson");
       PersonSearchBean personSearchBean = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			personSearchBean = (PersonSearchBean) JSONObject.parseObject(parmjson, PersonSearchBean.class);
			personSearchBean.setPageValue("0");
		}
	   PagingBean pb = new PagingBean();
	   pb = new PersonInfoDaoImpl().findPublicAddressBook4RoleuserList(personSearchBean, "", "", 0, 1);
	   List<PublicAddressDirectoryBean> list  = (List<PublicAddressDirectoryBean>) pb.getList();
	
	 response.reset();

    
	OutputStream output = null;
	FileInputStream fis = null;
	InputStream obis = null;
	FileInfoBean fib = null;
	ByteArrayInputStream bais = null;
    FileOutputStream fos = null;
    String path = LoadPropertiesUtil.getInstance().getPropertiesValue("config/oacommon/oacommon.properties","towordtemppath");  //根据实际情况写路径
	
    File file = new File(path+"Excel.xls");
    FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
	try {
		 if (list.size() > 0) {
			    fos = new FileOutputStream(path+"Excel.xls");
			    output = response.getOutputStream();
				response.setContentType("application/octet-stream;charset=gb2312");
				response.addHeader("Content-disposition", "attachment; filename=Excel.xls");
          
				WritableWorkbook wwk = Workbook.createWorkbook(fos);
				WritableSheet ws = wwk.createSheet("公共通讯录", 0);
				WritableFont wf = new WritableFont(WritableFont.ARIAL, 16,
						WritableFont.BOLD);
				WritableCellFormat wcf = new WritableCellFormat(wf);
				wcf.setAlignment(Alignment.CENTRE);

				ws.mergeCells(0, 4, 0, 0);
				Label lab1 = new Label(1, 0, "", wcf);
				Label lab2 = new Label(4, 1, "公共通讯录", wcf);
				ws.addCell(lab1);
				ws.addCell(lab2);
				Label lab3 = new Label(1, 2, "姓名");
				Label lab4 = new Label(2, 2, "职务");
				Label lab5 = new Label(3, 2, "办公手机");
				Label lab6 = new Label(4, 2, "常用手机");
				Label lab7 = new Label(5, 2, "办公电话");
				Label lab8 = new Label(6, 2, "电子邮件");
				Label lab9 = new Label(7, 2, "所在单位");
				ws.addCell(lab3);
				ws.addCell(lab4);
				ws.addCell(lab5);
				ws.addCell(lab6);
				ws.addCell(lab7);
				ws.addCell(lab8);
				ws.addCell(lab9);
				/* ws.setColumnView(0, 50); //设置列宽
				ws.setColumnView(1, 30);
				ws.setColumnView(2, 30);
				ws.setColumnView(3, 30);
				ws.setColumnView(4, 30);
				ws.setColumnView(5, 30);
				ws.setColumnView(6, 30); */
				 for (int i = 3; i < list.size() + 3; i++) {
					Label lab21 = new Label(1, i, list.get(i - 3).getDirectoryname());
					Label lab22 = new Label(2, i, list.get(i - 3).getPost());
					Label lab23 = new Label(3, i, list.get(i - 3).getMobile());
					Label lab24 = new Label(4, i, list.get(i - 3).getMobile());
					Label lab25 = new Label(5, i, list.get(i - 3).getWorkphone());
					Label lab26 = new Label(6, i, list.get(i - 3).getEmail());
					Label lab27 = new Label(7, i, list.get(i - 3).getOrgname());
					
					ws.addCell(lab21);
					ws.addCell(lab22);
					ws.addCell(lab23);
					ws.addCell(lab24);
					ws.addCell(lab25);
					ws.addCell(lab26);
					ws.addCell(lab27);

				} 
				wwk.write();
				wwk.close();
				fos.flush();
				fos.close();
 
            obis = (InputStream)(new FileInputStream(path+"Excel.xls"));
             
            byte[] b = new byte[1024];
 			int i = 0;
 			while ((i = obis.read(b)) > 0) {
 				output.write(b, 0, i);
 			}
 		
	 		output.flush();
	 		out.clear();
	 		out = pageContext.pushBody();
             
            // bais.close();
             //fos.close();
		 }
		
			
			
			//String filename = fib.getFilename().replaceAll(";","；").replaceAll("·","`");
			
			//filename = new String(filename.getBytes("GB2312"), "ISO8859-1");
			//filename = "\""+filename + "\"";
			
			
			
			
			

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
