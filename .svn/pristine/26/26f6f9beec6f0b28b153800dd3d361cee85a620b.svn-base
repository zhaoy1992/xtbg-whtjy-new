package com.chinacreator.xtbg.core.common.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.CellFormat;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.WritableFont.FontName;
import jxl.write.biff.RowsExceededException;

import org.apache.log4j.Logger;

/**
 * 
 *<p>
 * Title:ExcelUtil.java
 * </p>
 *<p>
 * Description:excel导出工具类
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-8-15
 */
public class ExcelUtil {
	//日志输出
	private static final Logger LOG = Logger.getLogger(ExcelUtil.class);
	private  int defaultWidth = 10;//单元格默认增加的宽度
	/**
	 * 临时文件的存放路径
	 */
	private String fileName;
	/**
	 * 
	 *<b>Summary:创建excel文件 </b> createExcel()
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 */
	public WritableWorkbook createExcel(HttpServletRequest request)
			throws IOException {
		// 新建导出文件
		this.fileName = request.getContextPath()+UUID.randomUUID() + ".xls";
		File file = new File(fileName);
		file.createNewFile();		
		WritableWorkbook book = Workbook.createWorkbook(file);
		return book;
	}

	/**
	 * 
	 *<b>Summary:往excel的sheet中添加数据 </b> addData()
	 * 
	 * @param startRow
	 *            开始添加数据的行
	 * @param list
	 *            要添加的数据列表
	 * @param key
	 *            数据对应的键值对
	 * @param sheet
	 *            sheet对象
	 * @param format
	 *            单元格的格式化样式
	 * @throws WriteException
	 * @throws RowsExceededException
	 */
	public void addRowData(int startRow, int startColumn,
			List<Map<String, String>> list, String[] key, WritableSheet sheet,
			CellFormat format) throws RowsExceededException, WriteException {
		if (null == list || null == key || list.isEmpty() || key.length == 0) {
			return;
		}
		for (Map<String, String> map : list) {
			for (int i = 0; i < key.length; i++) {
				String value = map.get(key[i]);
				Label label = new Label(startColumn + i, startRow, value);
				if (null != format) {
					label.setCellFormat(format);// 设置样式
				}
				sheet.addCell(label);
			}
			// 添加数据的行自增长
			startRow++;
		}
	}

	/**
	 * 
	 *<b>Summary: </b> addRowData()
	 * 
	 * @param startRow
	 * @param startColumn
	 * @param list
	 * @param sheet
	 * @param format
	 * @throws RowsExceededException
	 * @throws WriteException
	 */
	public void addRowData(int startRow, int startColumn,
			List<List<String>> list, WritableSheet sheet, CellFormat format)
			throws RowsExceededException, WriteException {
		if (null == list || list.isEmpty()) {
			return;
		}
		for (List<String> values : list) {
			for (int i = 0; i < values.size(); i++) {
				String value = values.get(i);
				Label label = new Label(startColumn + i, startRow, value);
				if (null != format) {
					label.setCellFormat(format);// 设置样式
				}
				sheet.addCell(label);
			}
			// 添加数据的行自增长
			startRow++;
		}
	}

	/**
	 * 
	 *<b>Summary:往excel的sheet中添加数据 </b> addData()
	 * 
	 * @param startRow
	 *            开始添加数据的行
	 * @param list
	 *            要添加的数据列表
	 * @param key
	 *            数据对应的键值对
	 * @param sheet
	 *            sheet对象
	 * @param format
	 *            单元格的格式化样式
	 * @throws WriteException
	 * @throws RowsExceededException
	 */
	public void addRowData(int startRow, int startColumn, String[] list,
			WritableSheet sheet, CellFormat format)
			throws RowsExceededException, WriteException {
		if (null == list || list.length == 0) {
			return;
		}
		for (int i = 0; i < list.length; i++) {
			Label label = new Label(startColumn + i, startRow, list[i]);
			if (null != format) {
				label.setCellFormat(format);// 设置样式
			}
			sheet.addCell(label);
			if (null != list[i]) {
				// 列宽自适应，汉字占两字节(首先获得列的宽度，如果当前列宽小于要设置的列宽，才进行设置)
				sheet.setColumnView(startColumn + i, list[i].length() * 2
						+ this.defaultWidth);
			}
		}
	}
	/**
	 * 
	*<b>Summary: 添加行数据，不设置列宽 </b>
	* addRowDataNotSetWidth()
	* @param startRow
	* @param startColumn
	* @param list
	* @param sheet
	* @param format
	* @throws RowsExceededException
	* @throws WriteException
	 */
	public void addRowDataNotSetWidth(int startRow, int startColumn, String[] list,
			WritableSheet sheet, CellFormat format)
			throws RowsExceededException, WriteException {
		if (null == list || list.length == 0) {
			return;
		}
		for (int i = 0; i < list.length; i++) {
			//不为空，才添加单元格
			if (null != list[i]) {
				Label label = new Label(startColumn + i, startRow, list[i]);
				if (null != format) {
					label.setCellFormat(format);// 设置样式
				}
				sheet.addCell(label);
			}
		}
	}
	/**
	 * 
	 *<b>Summary:往excel的sheet中添加数据 </b> addRowData()
	 * 
	 * @param startRow
	 *            开始行
	 * @param startColumn
	 *            开始列
	 * @param countColumn
	 *            合并的列数
	 * @param list
	 *            数据
	 * @param sheet
	 * @param format
	 *            格式化
	 * @throws RowsExceededException
	 * @throws WriteException
	 */
	public void addRowData(int startRow, int startColumn, int countColumn,
			String list, WritableSheet sheet, CellFormat format)
			throws RowsExceededException, WriteException {
		String[] array = { list };
		// 添加数据
		addRowData(startRow, startColumn, array, sheet, format);
		// 合并单元格
		sheet.mergeCells(startColumn, startRow, startColumn
				+ countColumn-1, startRow);
	}
	

	/**
	 * 
	/**
	 * 
	 *<b>Summary: 添加一列数据</b> addColumnData()
	 * 
	 * @param startRow
	 *            开始行
	 * @param startColumn
	 *            开始列
	 *            
	* @param spaceColumn 间隔列数
	 * @param values
	 *            值集合
	* @param key
	* @param sheet
	* @param format
	* @throws RowsExceededException
	* @throws WriteException
	 */
	public void addColumnData(int startRow, int startColumn,int width,int spaceColumn,
			List<Map<String, String>> values, String[] key,
			WritableSheet sheet, CellFormat format)
			throws RowsExceededException, WriteException {
		if (null == values || null == key || values.isEmpty()
				|| key.length == 0) {
			return;
		}
		int initColumn = startColumn;
		for (Map<String, String> map : values) {
			for (int i = 0; i < key.length; i++) {
				String value = map.get(key[i]);
				Label label = new Label(startColumn, startRow + i, value);
				if (null != format) {
					label.setCellFormat(format);// 设置样式
				}
				sheet.addCell(label);
				if(width ==0){
					sheet.setColumnView(startColumn, value.length()*2);
				}else{
					sheet.setColumnView(startColumn,width);
				}
			}
			// 添加数据的行自增长(隔行填充一列)
			startColumn += (1+spaceColumn);
			
			//最多允许存在1000列。超过1000列换行显示
			if(startColumn >=1000){
				startRow = startRow + key.length+1;
				startColumn = initColumn;				
			}
		}
	}
	/**
	 * 
	*<b>Summary: 按列添加数据，有间隔 </b></b>
	* addColumnData()
	* @param startRow
	* @param startColumn
	* @param width
	* @param spaceColumn 间隔的列数
	* @param values
	* @param sheet
	* @param format
	* @throws RowsExceededException
	* @throws WriteException
	 */
	public void addColumnData(int startRow, int startColumn,int width,int spaceColumn,
			List<List<String>> values, 
			WritableSheet sheet, CellFormat format)
			throws RowsExceededException, WriteException {
		if (null == values || values.isEmpty()) {
			return;
		}
		int initColumn = startColumn;
		for (List<String> map : values) {
			int length = map.size();
			for (int i = 0; i < map.size(); i++) {
				String value = map.get(i);
				Label label = new Label(startColumn, startRow + i, value);
				if (null != format) {
					label.setCellFormat(format);// 设置样式					
				}
				sheet.addCell(label);
				if(width ==0){
					sheet.setColumnView(startColumn, value.length()*2);
				}else{
					sheet.setColumnView(startColumn,width);
				}
				
			}
			// 添加数据的列自增长(隔行填充一列)
			startColumn += (1+spaceColumn);
			//最多允许存在1000列。超过1000列换行显示
			if(startColumn >=100){
				startRow = startRow + length +1;
				startColumn = initColumn;				
			}
			
		}
	}
	/**
	 * 
	*<b>Summary:纵向添加String[]形式的数据 </b>
	* addColumnData()
	* @param startRow
	* @param startColumn
	* @param width
	* @param values
	* @param sheet
	* @param format
	* @throws RowsExceededException
	* @throws WriteException
	 */
	public void addColumnData(int startRow, int startColumn,int width,
			String[] values, WritableSheet sheet, CellFormat format)
			throws RowsExceededException, WriteException {
		if (null == values || values.length == 0) {
			return;
		}
		for (int i = 0; i < values.length; i++) {
			String value = values[i];
			Label label = new Label(startColumn, startRow + i, value);
			if (null != format) {
				label.setCellFormat(format);// 设置样式
			}
			sheet.addCell(label);
			if (width == 0) {
				sheet.setColumnView(startColumn, value.length() * 2);
			}else{
				sheet.setColumnView(startColumn, width);
			}
		}
	}
	/**
	 * 
	*<b>Summary: </b>
	* addColumnData()
	* @param startRow
	* @param startColumn
	* @param width
	* @param values
	* @param key
	* @param sheet
	* @param format
	* @throws RowsExceededException
	* @throws WriteException
	 */
	public void addColumnData(int startRow, int startColumn,int width,
			Map<String,String> values,String[] key, WritableSheet sheet, CellFormat format)
			throws RowsExceededException, WriteException {
		if (null == values || values.isEmpty()|| null == key || key.length==0) {
			return;
		}
		for (int i = 0; i < key.length; i++) {
			String value = values.get(key[i]);
			Label label = new Label(startColumn, startRow + i, value);
			if (null != format) {
				label.setCellFormat(format);// 设置样式
			}
			sheet.addCell(label);
			if (width == 0) {
				sheet.setColumnView(startColumn, value.length() * 2);
			}else{
				sheet.setColumnView(startColumn, width);
			}
		}
	}
	/**
	 * 
	*<b>Summary: </b>
	* exportExcel()
	* @param values
	* @param titles
	* @param key
	* @param request
	* @param response
	* @throws IOException
	 * @throws WriteException 
	 * @throws RowsExceededException 
	 */
	public void exportExcel(List<List<String>> values, String[] titleColumns,
			String title, HttpServletRequest request,
			HttpServletResponse response) throws IOException,
			RowsExceededException, WriteException {
		WritableWorkbook excel = null;
		try {
			excel = this.createExcel(request);
			WritableSheet sheet = excel.createSheet("sheet1", 1);
			// 添加头
			this.addRowData(1, 1, titleColumns.length, title, sheet, null);
			// 添加表头
			this.addRowData(2, 1, titleColumns, sheet, null);
			// 添加数据
			this.addRowData(3, 1, values, sheet, null);

			excel.write();
			excel.close();
			// 导出
			this.responseExcel(title, response);
		} finally {
			// 删除文件
			this.deleteFile();
		}

	}
	
	/**
	 * 
	*<b>Summary: </b>
	* exportExcel()
	* @param values
	* @param titles
	* @param key
	* @param request
	* @param response
	* @throws IOException
	 * @throws WriteException 
	 * @throws RowsExceededException 
	 */
	public void exportExcel(List<Map<String,String>> values, String[] titleColumns,String [] keys,
			String title, HttpServletRequest request,
			HttpServletResponse response) throws IOException,
			RowsExceededException, WriteException {
		WritableWorkbook excel = null;
		try {
			excel = this.createExcel(request);
			WritableSheet sheet = excel.createSheet("sheet1", 1);
			// 添加头
			this.addRowData(0, 0, titleColumns.length, title, sheet, this.getTitleFormat());
			// 添加表头
			this.addRowData(1, 0, titleColumns, sheet, this.getHeadFormat());
			// 添加数据
			this.addRowData(2, 0, values, keys, sheet, this.getDataFormat());

			excel.write();
			excel.close();
			// 导出
			this.responseExcel(title, response);
		} finally {

			// 删除文件
			this.deleteFile();
		}

	}
	
	/**
	 * 
	*<b>Summary: 导出excel，添加单元格的方式为纵向,列之间间隔1列</b>
	* exportExcelColumnStyle()
	* @param values
	* @param title
	* @param request
	* @param response
	* @throws IOException
	* @throws RowsExceededException
	* @throws WriteException
	 */
	public void exportExcelColumnStyle(List<List<String>> values, String title,int columnWidth,HttpServletRequest request
			,HttpServletResponse response) throws IOException,
			RowsExceededException, WriteException {
		WritableWorkbook excel = null;
		try {
			excel = this.createExcel(request);
			WritableSheet sheet = excel.createSheet(title, 1);
			// 添加头
			// this.addRowData(1, 1, 1, title, sheet, null);
			// 添加数据
			this.addColumnData(1, 0,columnWidth,1, values, sheet, getDataFormat());

			excel.write();
			excel.close();
			// 导出
			this.responseExcel(title, response);
		} finally {
			// 删除文件
			this.deleteFile();
		}
	}
	/**
	 * 
	*<b>Summary: 导出excel，添加单元格的方式为纵向</b>
	* exportExcelColumnStyle()
	* @param values   数据集合
	* @param title    导出的文件名
	* @param response
	* @throws IOException
	* @throws RowsExceededException
	* @throws WriteException
	 */
	public void exportExcelColumnStyle(List<List<String>> values, String title,
			HttpServletRequest request,HttpServletResponse response) throws IOException,
			RowsExceededException, WriteException {
		//没有传入列的宽度，则宽度自适应
		this.exportExcelColumnStyle(values, title, 0, request,response);
	}
	/**
	 * 
	*<b>Summary: 导出文件</b>
	* writeExcel()
	* @param fileName
	* @param response
	* @throws IOException
	 */
	public void responseExcel(String fileName,
			HttpServletResponse response) throws IOException {
		// 封装成输出流
		OutputStream output = null;
		FileInputStream fis = null;
		try {
			if (fileName != null && !"".equals(fileName)) {
				fileName = fileName + ".xls";
			} else {
				fileName = this.fileName.substring(this.fileName.lastIndexOf("\\"));
			}
			response.reset();
			response.resetBuffer();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-disposition", "attachment; filename=\""
					+ toChinese(fileName) + "\"");
			response.setHeader("Pragma","No-cache"); 
			response.setHeader("Cache-Control","no-cache"); 
			response.setDateHeader("Expires", 0); 


			output = response.getOutputStream();
			fis = new FileInputStream(this.fileName);

//			byte[] b = new byte[fis.available()];
//			fis.read(b);
//			output.write(b);
			byte[] b = new byte[1024];
			int i = 0;
			//循环读取文件流，一次读取，文件太大时会溢出
			while ((i = fis.read(b)) > 0){
				output.write(b, 0, i);
			}
			
		} finally {
			try {
				if (fis != null) {
					fis.close();
					fis = null;
				}
			} catch (Exception e) {
				LOG.error("FileInputStream关闭出错", e);
			}
			try {
				if (output != null) {
					output.flush();
					output.close();
					output = null;
				}
			} catch (Exception e) {
				LOG.error("OutputStream关闭出错", e);
			}
		}
	}

	/**
	 * 
	 *<b>Summary: 删除用于导出的临时文件</b> deleteFile()
	 */
	public void deleteFile() {
		try {
			File file = new File(this.fileName);
			if(file.exists()){
			  file.delete();
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}

	/**
	 * 
	 *<b>Summary: </b> toChinese(转码)
	 * 
	 * @param strvalue
	 * @return
	 */
	public String toChinese(String strvalue) {
		try {
			if (strvalue == null) {
				return null;
			} else {
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
		format.setVerticalAlignment(VerticalAlignment.CENTRE);
		format.setWrap(true); 
		return format;
	}

	/**
	 * 
	*<b>Summary:表格标题的样式</b>
	* getTitleFormat()
	* @return
	* @throws WriteException
	 */
	public WritableCellFormat getTitleFormat() throws WriteException {
		
		WritableFont allToFont = new WritableFont(WritableFont.ARIAL, 14,
				WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,
				Colour.BLACK);
		WritableCellFormat format = new WritableCellFormat(allToFont);
		format = new WritableCellFormat(allToFont);
		format.setAlignment(Alignment.CENTRE);
		format.setVerticalAlignment(VerticalAlignment.CENTRE);
		format.setWrap(true); 
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
		
		WritableFont allToFont = new WritableFont(WritableFont.createFont("宋体"), 11,
				WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE,
				Colour.BLACK);
		WritableCellFormat format = new WritableCellFormat(allToFont);
		format = new WritableCellFormat(allToFont);
		format.setAlignment(Alignment.CENTRE);
		format.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
		format.setVerticalAlignment(VerticalAlignment.CENTRE);
        format.setWrap(true); 
		return format;
	}

	/**
	 * 
	*<b>Summary:正文样式 </b>
	* getDataFormat()
	* @param border 是否需要边框
	* @param align  对齐方式
	* @param font   字体
	* @param fontSize 字体大小
	* @return
	* @throws WriteException
	 */
	public WritableCellFormat getDataFormat(Boolean border, Alignment align,
			FontName font, Integer fontSize) throws WriteException {
		Boolean nativeBorder = (null == border) ? true : border;
		Alignment nativeAlign = (null == align)?Alignment.LEFT:align;
		FontName nativeFont = (null == font)?WritableFont.createFont("宋体"):font;
		int nativeFontSize = (null == fontSize)?11:fontSize;
		
		WritableFont allToFont = new WritableFont(nativeFont, nativeFontSize,
				WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE,
				Colour.BLACK);
		WritableCellFormat format = new WritableCellFormat(allToFont);
		format = new WritableCellFormat(allToFont);
		format.setAlignment(nativeAlign);
		if (nativeBorder) {
			format.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
		}
		format.setVerticalAlignment(VerticalAlignment.CENTRE);
		format.setWrap(true);
		return format;
	}
	/**
	 * 
	*<b>Summary:右对齐 </b>
	* getDataFormatAlignRight()
	* @param border
	* @return
	* @throws WriteException
	 */
	public WritableCellFormat getDataFormatAlignRight(boolean border) throws WriteException {

		WritableFont allToFont = new WritableFont(WritableFont.ARIAL, 12,
				WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE,
				Colour.BLACK);
		WritableCellFormat format = new WritableCellFormat(allToFont);
		format = new WritableCellFormat(allToFont);
		format.setAlignment(Alignment.RIGHT);
		if (border) {
			format.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
		}
		format.setVerticalAlignment(VerticalAlignment.CENTRE);
		//format.setWrap(true);
		return format;
	}	
	
	/**
	 * 
	*<b>Summary:设置默认扩展宽度 </b>
	* setDefaultWidth()
	* @param width
	 */
	public void setDefaultWidth(int width){
		this.defaultWidth = width;
	}
}
