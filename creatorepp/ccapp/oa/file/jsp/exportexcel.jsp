
<%--  
描述：文档列表导出
作者：邹拓
版本：1.0
日期：2013-06-13
--%>
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
    }%>
<%

OutputStream output = null;
FileInputStream fis = null;
InputStream obis = null;
String path = request.getContextPath();//根据实际情况写路径 /xtbgExcel.xls  /fgw_xtbgExcel.xls
try {
     //文件下载数据
    Class c = Class.forName(request.getParameter("className"));
    ExportBean actionBean = (ExportBean)c.newInstance();
    List<Map<String,String>> list = actionBean.getData(request,response);
    response.reset();
    ByteArrayInputStream bais = null;
    if (list.size() > 0) {
            output = response.getOutputStream();
            response
                    .setContentType("application/octet-stream;charset=gb2312");
            response.addHeader("Content-disposition",
                    "attachment; filename="+toUtf8String(actionBean.getTitleName())+".xls");

            WritableWorkbook wwk = Workbook.createWorkbook(response.getOutputStream());
            WritableSheet ws = wwk.createSheet("sheet1", 0);
            WritableFont wf = new WritableFont(WritableFont.ARIAL, 16,
                    WritableFont.BOLD);
            WritableCellFormat wcf = new WritableCellFormat(wf);
            wcf.setAlignment(Alignment.CENTRE);
            
            Integer[] colSize = actionBean.getColSize();
            if(colSize!=null){
            	int tmpI = 0;
            	for(Integer i : colSize){
            		ws.setColumnView(tmpI++, i);
            	}
            }
            //row1
            Label lab1 = new Label(0, 0, "", wcf);
            ws.addCell(lab1);
            //row2
            List<String> colNames = actionBean.getColTitleNames();
            if(colNames.size()>1){
            	ws.mergeCells(0, 1, colNames.size()-1, 1);
            }
            Label lab2 = new Label(0, 1, actionBean.getTitleName(), wcf);
            ws.addCell(lab2);
            //row3
            WritableFont wf1 = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD);
			WritableCellFormat wcf1 = new WritableCellFormat(wf1);
			wcf1.setAlignment(Alignment.CENTRE);
            int baseCol = 0;
            for(String colName : colNames){
            	ws.addCell(new Label(baseCol++, 2, colName,wcf1));
            }
            //rown
            List<String> fieldNames = actionBean.getFieldName();
            int baseRow = 3;
            for(Map<String,String> bean : list){
            	baseCol = 0;
            	for(String fieldName:fieldNames){
            		String val = bean.get(fieldName);
            		if(val==null){
            			val="";
            		}
            		ws.addCell(new Label(baseCol++, baseRow, val));
            	}
            	baseRow++;
            }
           
            wwk.write();
            wwk.close();

            output.flush();
            out.clear();
            out = pageContext.pushBody();
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
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
