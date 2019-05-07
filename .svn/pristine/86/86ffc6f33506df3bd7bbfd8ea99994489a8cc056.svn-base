package com.chinacreator.xtbg.pub.common;

import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;

import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:ExpExcel.java</p>
 *<p>Description:导出公用类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author haibo.wang
 *@version 1.0
 *@date 2013-03-04
 */
public class ExpExcel {
	private static final Logger LOG = Logger.getLogger(ExpExcel.class);
	
	/**
	 * @category 获取Excel文件数据并导出
	 * @param wbook
	 *            表名
	 * @param paramHead
	 *            表序列
	 * @param params
	 *            字段名
	 * @param title
	 *            字段类型
	 * @param tableName
	 *            列内容
	 * @param columnWidth
	 *            列内容
	 */
	@SuppressWarnings("deprecation")
	public void getExcel(HSSFWorkbook wbook, String paramHead,
			String sql, String title,
			String columnWidth) 
	{

		HSSFSheet sheet = wbook.createSheet("sheet1");
		String temp[] = paramHead.split(",");
		HSSFRow row = sheet.createRow((short) 0);
		HSSFCell cells[] = new HSSFCell[temp.length];
		createExcelHead(sheet,wbook,temp,row,cells,title);	
		//解析每个列的宽度
		short[] cwidth = new short[cells.length];;
		if(columnWidth != null && !"".equals(columnWidth)){
			try{
				String[] wstr = columnWidth.split(",");			    
				for(int w = 0;w < wstr.length && w < cells.length;w++){
					cwidth[w] = Short.parseShort(wstr[w]);
				}
			}catch(Exception e){}
		}
		//设置每个列的宽度  short范围0-65536
		for(int y = 0;y < cells.length;y++){
			if(cwidth[y] > 0){				
				sheet.setColumnWidth((short)y,cwidth[y]);
			}else{
				sheet.setColumnWidth((short)y,(short)6000);
			}
		}

		//获取数据
		String [][] list = queryExcelInfoForList(sql);
		//输出数据到excel
		HSSFCellStyle styleCell = wbook.createCellStyle();
		styleCell.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		if(list != null && list.length > 0){
			int j = 2;
			for(int  k = 0;k<list.length;k++){	
				row = sheet.createRow(j++);
				for(int i=0;i<cells.length;i++){
					cells[i] = row.createCell((short) i);
					cells[i].setCellType(1);  
					cells[i].setCellStyle(styleCell);
					try {
						cells[i].setCellValue(list[k][i]);
					} catch (Exception e) {
						e.printStackTrace();
					} 
				}
			}	
		}
	}


	/**
	 * @category 查询指定的Excel数据,拼接Sql
	 * @param sql 查询语句
	 *           条件字段
	 */
	private String[][] queryExcelInfoForList(String sql) {
		String [][] result = null;
		try {
			PreparedDBUtil  preDBUtil = new PreparedDBUtil();
			preDBUtil.executeSelect(sql);
			LOG.info("查询SQL"+sql);
			result = DaoUtil.SqlToFieldsArray(preDBUtil);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	/**
	 * @category 查询指定的Excel数据,拼接Sql
	 * 
	 * @param params
	 *           条件字段
	 * @param tablesolt
	 *           拼接字段名
	 * @param tableName
	 *           表名
	 */
	@SuppressWarnings("unused")
	private String[][] getParamHeadInfo(String paramHead, String temp[][]) {
		String[] str = paramHead.split(",");
		temp[0] = new String[str.length];
		temp[1] = new String[str.length];
		if(str.length > 0){
			String value[] = null;
			for(int i=0;i<str.length;i++){
				value = str[i].split(":");
				if(value.length > 0){
					try{
						temp[0][i] = value[0].substring(0, 1).toUpperCase() + value[0].substring(1);
						temp[1][i] = value[1];
					}catch(Exception e){
						e.printStackTrace();
					}
				}
			}
		}
		return temp;
	}
	/**
	 * @category 创建ExcelHead标题
	 * 
	 * @param params
	 *           条件字段
	 * @param tablesolt
	 *           拼接字段名
	 * @param tableName
	 *           表名
	 */
	@SuppressWarnings({ "deprecation", "deprecation" })
	private void createExcelHead(HSSFSheet sheet,HSSFWorkbook wbook,String head[],HSSFRow row,HSSFCell cells[],String title){			
		//第一行为文件名		
		HSSFCell cell = row.createCell((short) 0);
		//		wbook.setSheetName(0, title); 
		cell.setCellValue(  title);
		HSSFCellStyle style = wbook.createCellStyle();
		HSSFFont headfont = wbook.createFont();   
		headfont.setFontName("宋体");   
		headfont.setFontHeightInPoints((short) 24);// 字体大小   
		headfont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFont(headfont);
		cell.setCellStyle(style); 
		sheet.addMergedRegion(new Region(0,(short)0,0,(short)(cells.length-1))); 

		//第二行，excel的标头列
		row = sheet.createRow((short) 1);
		headfont = wbook.createFont();   
		headfont.setFontHeightInPoints((short)14);// 字体大小	 	
		headfont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		HSSFCellStyle styleHead = wbook.createCellStyle();
		styleHead.setFont(headfont);
		styleHead.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		for(int i=0;i<cells.length;i++){	    	
			cells[i] = row.createCell((short) i);	    	
			// 	    	cells[i].setEncoding((short) 1);
			cells[i].setCellType(1);
			cells[i].setCellStyle(styleHead);
			cells[i].setCellValue(head[i]);
		}
	}
}
