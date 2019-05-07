<%@ page language="java"
	pageEncoding="GBK"%>
<%@page import="com.chinacreator.epp.util.EgpManager"%>
<%@page import="DBstep.iMsgServer2000"%>
<%@page import="com.chinacreator.iWebOffice2006.OfficerBean"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="com.chinacreator.iWebOffice2006.iWedOfficeDownLoad"%>
<%@page import="com.chinacreator.config.ConfigManager"%>

<%!String toUtf8String(String s) {
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
	}%>

<%
	out.clear();
	out = pageContext.pushBody();

	BufferedInputStream bfis = null;
	BufferedOutputStream bfos = null;
	try {
		String recordId = request.getParameter("recordId");
		if (recordId == null||"".equals(recordId))
			recordId = "2161";//手动设置文档ID
		iWedOfficeDownLoad ibs = new iWedOfficeDownLoad();
		String path = ConfigManager.getInstance().getConfigValue("approot");
		System.out.println(path+"/"+ recordId + ".doc");
		ibs.setDbName(EgpManager.getAppDBName());
		bfis = new BufferedInputStream(ibs.getMsInputStream(recordId));
		String newFilename = recordId + ".doc";
		FileOutputStream fos = new FileOutputStream(path+"/"+ recordId + ".doc");
		
		int len = bfis.available();
		byte[] docByte = new byte[len];
		bfos = new BufferedOutputStream(fos);
		bfis.read(docByte, 0, len);
		bfos.write(docByte);
		bfos.flush();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		//bfos.close();
		//bfis.close();
	}
%>
