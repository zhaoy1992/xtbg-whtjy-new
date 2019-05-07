<%@ page language="java"  contentType="application/x-msdownload"	pageEncoding="GBK"%>
<%@page import="com.chinacreator.iWebOffice2006.iWebOfficeBusiness"%>
<%@page import="com.chinacreator.epp.util.EgpManager"%>
<%@page import="DBstep.iMsgServer2000"%>
<%@page import="com.chinacreator.iWebOffice2006.OfficerBean"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedOutputStream"%>

<%!

   String toUtf8String(String s) {
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
 %>

<%

out.clear(); 
out = pageContext.pushBody(); 
	
	BufferedInputStream bfis  =null;
	BufferedOutputStream bfos= null;
		try{
			String recordId = request.getParameter("recordId");
			System.out.println(recordId);
			//recordId = "w1008121439346710000";
			 iWebOfficeBusiness ibs = new iWebOfficeBusiness(
						new iMsgServer2000(),
						new OfficerBean());
			ibs.setDbName(EgpManager.getAppDBName());
			bfis = new BufferedInputStream(ibs.getMsInputStream(recordId));
			String newFilename=recordId+".doc";
			int len = bfis.available();
			byte[] docByte = new byte[len];
			ServletOutputStream  os = response.getOutputStream();
			bfos = new BufferedOutputStream(os);
			bfis.read(docByte, 0, len);
			response.setHeader("Content-Disposition","attachment;filename=\"" + toUtf8String(recordId+".doc")+ "\"");
			bfos.write(docByte);
			bfos.flush();
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			bfos.close();
			bfis.close();
		}

 %>
