package com.chinacreator.xtbg.pub.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jxl.Cell;
import jxl.CellType;
import jxl.DateCell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

public class ParseExcelUtil {
	private static ParseExcelUtil parseExcelUtil = null;
	
	public ParseExcelUtil(String filepath){
		 //生成一个可读取的excel文件对象
	      try {
			workbook = Workbook.getWorkbook(new File(filepath));
		} catch (BiffException e) {
			
		} catch (IOException e) {
			
		}
	      //使用第一个工作表
	      sheet = workbook.getSheet(0);
	}
	

	
	/**
	 * 单例方法
	 * @return
	 */
	public static ParseExcelUtil getInstance(String filepath) {
		if (parseExcelUtil == null) {
			synchronized(ParseExcelUtil.class) {
				parseExcelUtil = new ParseExcelUtil(filepath);
			}
		}
		return parseExcelUtil;
	}
	
	public Workbook workbook;
	public  Sheet sheet;
	/**
	 *<br>方法说明：读取excel文件一行数据
	 *<br>输入参数：int row指定的行数
	 *<br>返回类型：String〔〕结果数组
	 */  
	  public String[] readLine(int row){
	    try{
	      //获取数据表列数
	      int colnum = sheet.getColumns();
	      String[] rest = new String[colnum];
	      for(int i = 0; i < colnum; i++){
	        String sTemp = read(i,row);
	        if(sTemp!=null)
	         rest[i] = sTemp;
	      }
	      return rest;
	    }catch(Exception e){
	      System.out.println("readLine err:"+e);
	      workbook.close();
	      return null;
	    }
	  }
	/**
	 *<br>方法说明：读取excel的指定单元数据
	 *<br>输入参数：
	 *<br>返回类型：
	 */




	  public String read(int col, int row){
	 	    try{
	 	      //获得单元数据
	 	      Cell a2 = sheet.getCell(col,row); 
	 	      if(a2.getType()==CellType.DATE){
	 	    	  DateCell dc = (DateCell)a2;
	 	    	  Date d = dc.getDate(); 
	 	    	  long time = (d.getTime() / 1000) - 60 * 60 * 8;
	 	            d.setTime(time * 1000); 
	 	    	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	 	    	  return sdf.format(d);
	 	      }else{
	 	    	  return a2.getContents(); 
	 	      }  
	 	    }catch(Exception e){
	 	      System.out.println("read err:"+e);
	 	      workbook.close();
	 	      return null;
	 	    }
	 	  }
}
