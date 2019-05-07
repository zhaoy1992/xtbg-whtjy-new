package com.chinacreator.xtbg.pub.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * 
 *<p>Title:POIExcelUtil.java</p>
 *<p>Description:poi-excel导入导出工具</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2014-3-9
 */
public class POIExcelUtil {
	private Workbook workbook = null;
	private CellStyle cellstyle = null;
	/*  * 判断是xls文件还是xlsx文件  */  
    public POIExcelUtil(String filepath) throws IOException{ 
    	File tempfile = new File(filepath);
    	FileInputStream is = new FileInputStream(tempfile);
        if(tempfile.getName().toLowerCase().endsWith("xls")){   
        	workbook = new HSSFWorkbook(is);    
        }   
        if(tempfile.getName().toLowerCase().endsWith("xlsx")){    
        	workbook = new XSSFWorkbook(is);   
        } 
	      //使用第一个工作表
	    sheet = workbook.getSheetAt((short)0);
		maxrownum = sheet.getPhysicalNumberOfRows();
		maxcols = sheet.getRow(0).getLastCellNum();
    }
    /**
     * 
    *<b>Summary: </b>
    * writeExcelToPath(将excel缓存写入到指定的路径)
    * @param path
    * @throws IOException
     */
    public void writeExcelToPath(String path) throws IOException{
    	OutputStream out = new FileOutputStream(path);
    	workbook.write(out);
        out.close();
    }
    
	public Sheet sheet;
	public int maxrownum;//最大行数量
	public int maxcols;//最大列数量
	
	/**
	 * 
	*<b>Summary: </b>
	* setCurrSheet(设置当前表格)
	* @param index
	 */
	public void setCurrSheet(int index) throws Exception{
		sheet = workbook.getSheetAt((short)index);
	}
	/**
	 * 
	*<b>Summary: </b>
	* getSheet(得到当前的表格)
	* @param index
	 */
	public Sheet getSheet(){
		return sheet;
	}
	/**
	 * 
	*<b>Summary: </b>
	* readSheet(读取整个表数据)
	* @return
	* @throws Exception
	 */
	public String[][] readSheet() throws Exception{
		String[][] rest = new String[maxrownum][maxcols];
		for(int i = 0; i < maxrownum; i++){
			rest[i] = readLine(i);
		}
		return rest;
	}
	
	/**
	 *<br>方法说明：读取excel文件一行数据
	 *<br>输入参数：int row指定的行数
	 *<br>返回类型：String〔〕结果数组
	 */  
	  public String[] readLine(int row) throws Exception{
	    try{
	      //获取数据表列数
	      String[] rest = new String[maxcols];
	      for(int i = 0; i < maxcols; i++){
	        String sTemp = read(i,row);
	        if(sTemp!=null)
	         rest[i] = sTemp;
	      }
	      return rest;
	    }catch(Exception e){
	      System.out.println("readLine err:"+e);
	      throw e;
	    }
	  }
	/**
	 *<br>方法说明：读取excel的指定单元数据
	 *<br>输入参数：
	 *<br>返回类型：
	 */
	  public String read(int col, int rows) throws Exception{
	 	    try{
	 	      Row row = sheet.getRow(rows); 
	 	      //获得单元数据
	 	      Cell cell = row.getCell(col);
	 	     if(cell!=null){
	 	    	  return printExcel(cell);
	 	      }else{
	 	    	  return null;
	 	      }
	 	    }catch(Exception e){
	 	      System.out.println("read err:"+e+",rows:"+rows+",cols:"+col);
	 	     throw e;
	 	    }
	  }
	/**
	 *<br>方法说明：向excel指定行写入数据
	 *<br>输入参数：int row指定的行数
	 *<br>输入参数：CellStyle 单位格样式
	 *<br>返回类型：String〔〕结果数组
	 */  
	 public void writeLine(int row,String[] values,CellStyle cellstyle) throws Exception{
		 for(int i = 0 ; i < values.length; i++){
			 write(i,row,values[i],cellstyle);
		 }
	 }
	  
	/**
	 *<br>方法说明：往excel的指定单元写数据
	 *<br>输入参数：
	 *<br>输入参数：CellStyle 单位格样式
	 *<br>返回类型：
	 */
	 public void write(int col,int rows,String value,CellStyle cellstyle) throws Exception{
		 Row row = sheet.getRow(rows);
		 if(row==null){
			 row = sheet.createRow(rows);
			 row.setHeight(sheet.getRow(rows-1).getHeight());
		 }
	      //获得单元数据
	      Cell cell = row.getCell(col);
	      if(cell==null){
	    	  cell = row.createCell(col);
	      }
	      cell.setCellValue(value);
	      cell.setCellStyle(cellstyle);
	 }
	 /**
		 *<br>方法说明：向excel指定行写入数据
		 *<br>输入参数：int row指定的行数
		 *<br>返回类型：String〔〕结果数组
		 */  
		 public void writeLine(int row,String[] values) throws Exception{
			 for(int i = 0 ; i < values.length; i++){
				 write(i,row,values[i]);
			 }
		 }
		  
		/**
		 *<br>方法说明：往excel的指定单元写数据
		 *<br>输入参数：
		 *<br>返回类型：
		 */
		 public void write(int col,int rows,String value) throws Exception{
			 Row row = sheet.getRow(rows);
			 if(row==null){
				 row = sheet.createRow(rows);
			 }
		      //获得单元数据
		      Cell cell = row.getCell(col);
		      if(cell==null){
		    	  cell = row.createCell(col);
		      }
		      cell.setCellValue(value);
		 }
		 
	  /**
	   * 
	  *<b>Summary: </b>
	  * printExcel(打印excel单元格)
	  * @param cell
	  * @return
	   */
	  public  String printExcel(Cell cell)
		 {
			 if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING)
			     return cell.getStringCellValue();
			 else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC){
				 return toIntStr(String.valueOf(cell.getNumericCellValue()));
			 }else if (cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA)
				 return null;
			 else if (cell.getCellType() == HSSFCell.CELL_TYPE_BLANK)
				 return "";
			 else
			     return null;
		 }

	public Workbook getWorkbook() {
		return workbook;
	}
	public void setWorkbook(Workbook workbook) {
		this.workbook = workbook;
	}
    
	public CellStyle getCellstyle() {
		return cellstyle;
	}
	public void setCellstyle(CellStyle cellstyle) {
		this.cellstyle = cellstyle;
	}
	/**
	 * 
	*<b>Summary: </b>
	* toIntStr(判断是否整数字符串)
	* @param str
	* @return
	 */
	public boolean ifIntStr(String str){
		return str.matches("[0-9]+.?0*");
	}
	/**
	 * 
	*<b>Summary: </b>
	* toIntStr(如果为整数字符串则去掉后面的小数点)
	* @param str
	* @return
	 */
	public String toIntStr(String str){
		if(ifIntStr(str))
			return str.split("\\.")[0];
		return str;
	}
	
	public static void main(String[] args){
		//System.out.println(ifIntStr("12.001"));
	}
}
