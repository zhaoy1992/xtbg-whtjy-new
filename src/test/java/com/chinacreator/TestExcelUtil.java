package com.chinacreator;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.chinacreator.xtbg.pub.excel.POIExcelUtil;

public class TestExcelUtil {
	
	 public static void main(String[] args) throws Exception {
	   POIExcelUtil poiUtil = new POIExcelUtil("E:\\2013.10.22 特检院办公系统\\测试个人通讯录模版.xlsx");
	   String[] arry = poiUtil.readLine(2);
	   System.out.println("1");
	   new TestExcelUtil().readXlsObj();
	 
	 }
	 
	 private void readXlsObj() throws IOException {
		 try{
			 Workbook workbook1 = WorkbookFactory.create(new FileInputStream("E:\\2013.10.22 特检院办公系统\\测试个人通讯录模版.xlsx"));
			 // 创建对工作表的引用。  
			 // 本例是按名引用（让我们假定那张表有着缺省名"Sheet1"）  
			 Sheet sheet1 = workbook1.getSheet("Sheet1");
			 // 也可用getSheetAt(int index)按索引引用，  
			 // 在Excel文档中，第一张工作表的缺省索引是0，  
			 // 其语句为：HSSFSheet sheet = workbook.getSheetAt(0);  
			 // 读取左上端单元  
			 Row row1 = sheet1.getRow(0); 
			 Cell cell1 = row1.getCell((short)0); 
			 // 输出单元内容，cell.getStringCellValue()就是取所在单元的值  
			 printExcel(cell1); 
			 sheet1 = workbook1.getSheetAt(0);
			 row1 = sheet1.getRow(2); 
			 for(int i = 0 ; i < 58; i++){
				 Cell cell2 = row1.getCell(i); 
				 printExcel(cell2);
			 }
			  
		 }catch(Exception e) {  
			 System.out.println("已运行xlRead() : " + e );
		 }
	 }
	 
	 public static void printExcel(Cell cell)
	 {
		 if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING)
		 System.out.println("单元格是字符串，值是： " + cell.getStringCellValue());
		 else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC)
		 System.out.println("单元格是数字，值是： " + cell.getNumericCellValue());
		 else
		 System.out.println("单元格的值不是字符串或数值。");
	 }
	 
	    /**
	     * 读取xls文件内容
	     * 
	     * @return List<XlsDto>对象
	     * @throws IOException
	     *             输入/输出(i/o)异常
	     */
	    private void readXls() throws IOException {
	        InputStream is = new FileInputStream("E:\\2013.10.22 特检院办公系统\\测试个人通讯录模版.xlsx");
	        XSSFWorkbook workbook = new XSSFWorkbook(is);
	        // 循环工作表Sheet
	        for (int numSheet = 0; numSheet < workbook.getNumberOfSheets(); numSheet++) {
	            XSSFSheet hssfSheet = workbook.getSheetAt(numSheet);
	            if (hssfSheet == null) {
	                continue;
	            }
	            // 循环行Row
	            for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
	            	XSSFRow hssfRow = hssfSheet.getRow(rowNum);
	                if (hssfRow == null) {
	                    continue;
	                }
	                for(int i = 0 ; i < 10 ; i++){
	                	XSSFCell xh = hssfRow.getCell(i);
	                	System.out.println(getValue(xh));
	                }
	                
	            }
	        }
	    }
	 
	    /**
	     * 得到Excel表中的值
	     * 
	     * @param hssfCell
	     *            Excel中的每一个格子
	     * @return Excel中每一个格子中的值
	     */
	    @SuppressWarnings("static-access")
	    private String getValue(XSSFCell xssfCell) {
	        if (xssfCell.getCellType() == xssfCell.CELL_TYPE_BOOLEAN) {
	            // 返回布尔类型的值
	            return String.valueOf(xssfCell.getBooleanCellValue());
	        } else if (xssfCell.getCellType() == xssfCell.CELL_TYPE_NUMERIC) {
	            // 返回数值类型的值
	            return String.valueOf(xssfCell.getNumericCellValue());
	        } else {
	            // 返回字符串类型的值
	            return String.valueOf(xssfCell.getStringCellValue());
	        }
	    }
	 
	}
	 

