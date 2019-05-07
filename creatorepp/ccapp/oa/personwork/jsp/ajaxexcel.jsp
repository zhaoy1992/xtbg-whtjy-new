
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@page import="jxl.format.UnderlineStyle"%>
<%--  
描述：通讯录导出功能
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@page	import="com.chinacreator.xtbg.core.personwork.entity.PersonSearchBean"%>
<%@page	import="com.chinacreator.xtbg.core.personwork.entity.PublicAddressDirectoryBean"%>
<%@page	import="com.chinacreator.xtbg.core.personwork.dao.impl.PersonInfoDaoImpl"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.write.*"%>
<%@page import="jxl.Workbook"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.PagingBean"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page	import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@page	import="com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao"%>
<%@page	import="com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl"%>
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
	
	/**
     * 
    *<b>Summary: 表格表头的样式</b>
    * titleFormat()
    * @return
    * @throws WriteException
     */
    public WritableCellFormat getHeadFormat() throws WriteException {
        
        WritableFont allToFont = new WritableFont(WritableFont.ARIAL, 12,
                WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,
                Colour.BLACK);

        WritableCellFormat format = new WritableCellFormat(allToFont);
        format.setAlignment(Alignment.CENTRE);
        format.setBackground(Colour.getInternalColour(22));
        format.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);

        return format;
    }
    
    /**
     * 
    *<b>Summary:正文的样式 </b>
    * getDataFormat()
    * @return
    * @throws WriteException
     */
    public WritableCellFormat getDataFormat() throws WriteException {
        
        WritableFont allToFont = new WritableFont(WritableFont.ARIAL, 12,
                WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE,
                Colour.BLACK);
        WritableCellFormat format = new WritableCellFormat(allToFont);
        format = new WritableCellFormat(allToFont);
        format.setAlignment(Alignment.LEFT);
        format.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
        format.setVerticalAlignment(VerticalAlignment.CENTRE);
        format.setWrap(true); 
        return format;
    }
	%>
<%
	//文件下载数据
	// excel文件名
	String parmjson = request.getParameter("parmjson");
	PersonSearchBean personSearchBean = null;
	if (!StringUtil.isBlank(parmjson)) {
		parmjson = DataControlUtil.replaceStr(parmjson);
		parmjson = Escape.unescape(parmjson);
		personSearchBean = (PersonSearchBean) JSONObject.parseObject(
				parmjson, PersonSearchBean.class);
		personSearchBean.setPageValue("0");
	}
	PagingBean pb = new PagingBean();
	pb = new PersonInfoDaoImpl().findPublicAddressBook4RoleuserList(
			personSearchBean, "", "", 0, 1);
	List<PublicAddressDirectoryBean> list = (List<PublicAddressDirectoryBean>) pb
			.getList();

	response.reset();

	OutputStream output = null;
	FileInputStream fis = null;
	InputStream obis = null;
	FileInfoBean fib = null;
	ByteArrayInputStream bais = null;
	FileOutputStream fos = null;
	String path =  FileUtil.getAppContextPath() + CacheCommonManageProxy.getSystemParam("personholder_tempExcelFilePath");//根据实际情况写路径

	File file = new File(path + "Excel.xls");
	FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
	try {
		 if(!file.exists()){
             file.createNewFile();
         }
		if (list.size() > 0) {
			fos = new FileOutputStream(path + "Excel.xls");
			output = response.getOutputStream();
			response
					.setContentType("application/octet-stream;charset=gb2312");
			response.addHeader("Content-disposition",
					"attachment; filename="+toChinese("单位通讯录.xls"));

			WritableWorkbook wwk = Workbook.createWorkbook(fos);
			WritableSheet ws = wwk.createSheet("单位通讯录", 0);
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 16,
					WritableFont.BOLD);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setAlignment(Alignment.CENTRE);

			ws.mergeCells(1, 1, 7, 1);
			Label lab2 = new Label(1, 1, "单位通讯录", wcf);
			ws.addCell(lab2);
			Label lab3 = new Label(1, 2, "姓名");
			Label lab4 = new Label(2, 2, "职务");
			Label lab5 = new Label(3, 2, "办公手机");
			//特检院OA 2014-05-27 start 通讯录导出的内容中删除【常用手机】列，改为【短号】列填充用户的短号信息。
			//Label lab6 = new Label(4, 2, "常用手机");
			Label lab6 = new Label(4, 2, "短号");
			//特检院OA 2014-05-27 end 通讯录导出的内容中删除【常用手机】列，改为【短号】列填充用户的短号信息。
			Label lab7 = new Label(5, 2, "办公电话");
			Label lab8 = new Label(6, 2, "电子邮件");
			Label lab9 = new Label(7, 2, "所在单位");
			lab3.setCellFormat(getHeadFormat());
			lab4.setCellFormat(getHeadFormat());
			lab5.setCellFormat(getHeadFormat());
			lab6.setCellFormat(getHeadFormat());
			lab7.setCellFormat(getHeadFormat());
			lab8.setCellFormat(getHeadFormat());
			lab9.setCellFormat(getHeadFormat());
			
			ws.addCell(lab3);
			ws.addCell(lab4);
			ws.addCell(lab5);
			ws.addCell(lab6);
			ws.addCell(lab7);
			ws.addCell(lab8);
			ws.addCell(lab9);			
			ws.setColumnView(1, "姓名".length() * 2 + 10);
			ws.setColumnView(2, "职务".length() * 2 + 10);
			ws.setColumnView(3, "办公手机".length() * 2 + 10);
			ws.setColumnView(4, "办公手机".length() * 2 + 10);
			ws.setColumnView(5, "办公手机".length() * 2 + 10);
			ws.setColumnView(6, "办公手机".length() * 2 + 10);
			ws.setColumnView(7, "办公手机".length() * 2 + 10);
			
			for (int i = 3; i < list.size() + 3; i++) {
				Label lab21 = new Label(1, i, list.get(i - 3)
						.getDirectoryname());
				Label lab22 = new Label(2, i, list.get(i - 3).getPost());
				Label lab23 = new Label(3, i, list.get(i - 3)
						.getMobile());
				//特检院OA 2014-05-27 start 通讯录导出的内容中删除【常用手机】列，改为【短号】列填充用户的短号信息。
				/* Label lab24 = new Label(4, i, list.get(i - 3)
						.getMobile()); */
				Label lab24 = new Label(4, i, list.get(i - 3)
						.getRemark4());
				//特检院OA 2014-05-27 end 通讯录导出的内容中删除【常用手机】列，改为【短号】列填充用户的短号信息。
				Label lab25 = new Label(5, i, list.get(i - 3)
						.getWorkphone());
				Label lab26 = new Label(6, i, list.get(i - 3)
						.getEmail());
				Label lab27 = new Label(7, i, list.get(i - 3)
						.getOrgname());
				lab21.setCellFormat(getDataFormat());
				lab22.setCellFormat(getDataFormat());
				lab23.setCellFormat(getDataFormat());
				lab24.setCellFormat(getDataFormat());
				lab25.setCellFormat(getDataFormat());
				lab26.setCellFormat(getDataFormat());
				lab27.setCellFormat(getDataFormat());
				
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
