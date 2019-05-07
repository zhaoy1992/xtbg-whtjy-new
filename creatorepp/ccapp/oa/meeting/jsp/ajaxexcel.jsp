<%--  
描述：通讯录导出功能
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.write.*"%>
<%@page import="jxl.Workbook"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.PagingBean"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page	import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@page	import="com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao"%>
<%@page	import="com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl"%>

<%@page import="com.chinacreator.xtbg.core.meeting.dao.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.*"%>
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
	}%>
<%

OutputStream output = null;
FileInputStream fis = null;
InputStream obis = null;
String path = request.getContextPath();//根据实际情况写路径
File file = new File(path + "Excel.xls");

try {
	if(!file.exists()){
	    file.createNewFile();
	}
	//文件下载数据
	// excel文件名
	String json = request.getParameter("json");
    String sortName = request.getParameter("sortname");
    String sortOrder = request.getParameter("sortorder");
    MeetingNoticeBean   notice = null;
	if (!StringUtil.isBlank(json)) {
		notice = StringUtil.convertStringToBean(json,MeetingNoticeBean.class);
		
	}
	PagingBean pb = null;
	//暂时调用list查询的方法，设置最大可导出一万条数据
	pb = new MeetingNoticeViewDaoImpl().findMeetingNooticePageBean(notice, sortName, sortOrder, 0, 10000);
	List<Map<String,String>> list = (List<Map<String,String>>) pb
			.getList();
	response.reset();
	
	FileInfoBean fib = null;
	ByteArrayInputStream bais = null;
	FileOutputStream fos = null;
	

	
	FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
	
		if (list.size() > 0) {
			fos = new FileOutputStream(path + "Excel.xls");
			output = response.getOutputStream();
			response
					.setContentType("application/octet-stream;charset=gb2312");
			response.addHeader("Content-disposition",
					"attachment; filename=Excel.xls");

			WritableWorkbook wwk = Workbook.createWorkbook(fos);
			WritableSheet ws = wwk.createSheet("会议通知列表", 0);
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 16,
					WritableFont.BOLD);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setAlignment(Alignment.CENTRE);

			ws.mergeCells(0, 4, 0, 0);
			Label lab1 = new Label(1, 0, "", wcf);
			Label lab2 = new Label(4, 1, "会议通知", wcf);
			ws.addCell(lab1);
			ws.addCell(lab2);
			Label lab3 = new Label(1, 2, "会议标题");
			Label lab4 = new Label(2, 2, "会议类型");
			Label lab5 = new Label(3, 2, "开始时间");
			Label lab6 = new Label(4, 2, "结束时间");
			Label lab7 = new Label(5, 2, "地点");
			Label lab8 = new Label(6, 2, "主持人");
			Label lab9 = new Label(7, 2, "联系人");
			Label lab10 = new Label(8, 2, "联系部门");
			Label lab11 = new Label(9, 2, "与会人数");
			ws.addCell(lab3);
			ws.addCell(lab4);
			ws.addCell(lab5);
			ws.addCell(lab6);
			ws.addCell(lab7);
			ws.addCell(lab8);
			ws.addCell(lab9);
			ws.addCell(lab10);
			ws.addCell(lab11);
			for (int i = 3; i < list.size() + 3; i++) {
				Label lab21 = new Label(1, i, list.get(i - 3)
						.get("m_title"));
				Label lab22 = new Label(2, i, list.get(i - 3).get("m_type_name"));
				Label lab23 = new Label(3, i, list.get(i - 3)
						.get("m_begin_time"));
				Label lab24 = new Label(4, i, list.get(i - 3)
						.get("m_end_time"));
				Label lab25 = new Label(5, i, list.get(i - 3)
						.get("m_address"));
				Label lab26 = new Label(6, i, list.get(i - 3)
						.get("m_master_user_name"));
				Label lab27 = new Label(7, i, list.get(i - 3)
						.get("m_link_user_name"));
				Label lab28 = new Label(8, i, list.get(i - 3)
                        .get("m_link_dept_name"));
				Label lab29 = new Label(9, i, list.get(i - 3)
                        .get("m_attender_count"));
				
				ws.addCell(lab21);
				ws.addCell(lab22);
				ws.addCell(lab23);
				ws.addCell(lab24);
				ws.addCell(lab25);
				ws.addCell(lab26);
				ws.addCell(lab27);
				ws.addCell(lab28);
				ws.addCell(lab29);

			}
			wwk.write();
			wwk.close();
			fos.flush();
			fos.close();

			obis = (InputStream) (new FileInputStream(path
					+ "Excel.xls"));

			byte[] b = new byte[1024];
			int i = 0;
			while ((i = obis.read(b)) > 0) {
				output.write(b, 0, i);
			}

			output.flush();
			out.clear();
			out = pageContext.pushBody();
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if(file.exists()){    
            file.delete(); 
        }
		if (fis != null) {
			fis.close();
			fis = null;
		}
		if (obis != null) {
			obis.close();
			obis = null;
		}
		if (output != null) {
			output.close();
			output = null;
		}
	}
%>
