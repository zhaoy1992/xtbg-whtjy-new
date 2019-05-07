
<%@page import="com.chinacreator.xtbg.pub.util.LoadPropertiesUtil"%>
<%@page import="com.chinacreator.xtbg.pub.common.LoadConfigurationProperties"%>
<%@page import="org.apache.commons.configuration.PropertiesConfiguration"%>
<%@page import="org.apache.poi.poifs.filesystem.DocumentEntry"%>
<%@page import="org.apache.poi.poifs.filesystem.DirectoryEntry"%>

<%@page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="com.frameworkset.common.poolman.PreparedDBUtil"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DataControlUtil"%><%@ page language="java" contentType="application/octet-stream; charset=gbk"%>


<%--
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
	
	//文件下载名称
   // String displayname= new String(request.getParameter("displayname").getBytes("GBK"), "UTF-8");
	String content_type= DataControlUtil.replaceStr(request.getParameter("content_type"));
	String business_id= DataControlUtil.replaceStr(request.getParameter("business_id"));
	StringBuffer sql = new StringBuffer();
    PreparedDBUtil pdb = new PreparedDBUtil();
    if("announcementdrew".equals(content_type)){
    	sql.append("select nr from ta_oa_announcement_content where ggbh = '"+business_id+"'");
    }else if("inforeportdetailview".equals(content_type)){
    	sql.append("select submit_content from ta_oa_infre_submitted_info where submittedinfo_id = '"+business_id+"'");
    }else if("showmettinginfo".equals(content_type)){
    	sql.append("select tent from sx_ta_oa_mettinginfo where id = '"+business_id+"'");
    }else if("briefsbrowsedrew".equals(content_type)){
    	sql.append("select zw from ta_oa_briefs_edit where briefs_id = '"+business_id+"'");
    }else if("poeleaderpishi".equals(content_type)){
    	sql.append("select edit_content from ta_oa_poe_pubopinion_edit where edit_id = '"+business_id+"'");
    }else if("showconferencedetail2".equals(content_type)){
    	sql.append("select content from ta_conference_base where sn = '"+business_id+"'");
    }else if("infosb".equals(content_type)){
    	sql.append("select information_content from hh_oa_ifm_reporting where information_id = '"+business_id+"'");
    }
    pdb.preparedSelect(sql.toString()); 
    pdb.executePrepared();
	
	
	//displayname="bug文件";
    response.reset();
    
    
   
	
	OutputStream output = null;
	FileInputStream fis = null;
	InputStream obis = null;
	FileInfoBean fib = null;
	ByteArrayInputStream bais = null;
    FileOutputStream fos = null;
    String path = LoadPropertiesUtil.getInstance().getPropertiesValue("config/oacommon/oacommon.properties","towordtemppath");  //根据实际情况写路径
	FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
	try {
		output = response.getOutputStream();
		response.setContentType("application/octet-stream;charset=gb2312");
		response.addHeader("Content-disposition", "attachment; filename=word.doc");
		 if (pdb.size() > 0) {
			 bais = new ByteArrayInputStream(("<table border='0' style='border: 0px' >"+pdb.getString(0,0)+"</table>").getBytes("GBK"));
             POIFSFileSystem poifs  = new POIFSFileSystem();
             DirectoryEntry directory = poifs.getRoot();
             DocumentEntry documentEntry = directory.createDocument("WordDocument", bais);
             
             fos = new FileOutputStream(path + "temp.doc");
             poifs.writeFilesystem(fos);
             
             obis = (InputStream)(new FileInputStream(path + "temp.doc"));
             
             byte[] b = new byte[1024];
 			int i = 0;
 			while ((i = obis.read(b)) > 0) {
 				output.write(b, 0, i);
 			}
 		
	 		output.flush();
	 		out.clear();
	 		out = pageContext.pushBody();
             
             bais.close();
             fos.close();
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
