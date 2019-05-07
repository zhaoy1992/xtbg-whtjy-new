package com.chinacreator.xtbg.core.common.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import org.apache.log4j.Logger;


/**
 * 
 *<p>Title:DataExpExcel.java</p>
 *<p>Description:数据导出excel工具</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author steven.zhu
 *@version 1.0
 *2013-3-13
 */
public class DataExpExcel {
	
	//日志输出
	private static final Logger LOG = Logger.getLogger(DataExpExcel.class);
	
	//生成的临时文件在服务器上的储路径
	private  String filePath = "";
	//是否删除生成的临时文件
	private  boolean delMark=true;       
	
	public DataExpExcel(String filePaht,boolean delMark){
		this.filePath=filePaht;
		this.delMark=delMark;
	}
	
	
	/**
	 * 
	*<b>Summary: </b>
	* expData(单工作薄文件的生成)
	* @param tempFilePath   模板文件的在服务器上的存储路径
	* @param list           需要生成的数据信息
	* @return 				返回生成的文件信息
	* @throws WriteException
	* @throws IOException
	* @throws SQLException
	 */
	public  String expData(String tempFilePath, List<String[]> list)throws BiffException,WriteException, IOException, SQLException {
		//如果是单工作薄 则需要封装成map进行处理 
		Map<Integer, List<String[]>> map = new HashMap<Integer, List<String[]>>();
		map.put(0, list);
		return expData(tempFilePath, map);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* expData(导出数据到EXCEL文件)
	* @param tempFilePath 模板文件的在服务器上的存储路径
	* @param mapVal       需要生成的数据信息
	* @return             返回生成的文件信息
	* @throws BiffException
	* @throws WriteException
	* @throws IOException
	* @throws SQLException
	 */
	public  String expData(String tempFilePath,Map<Integer,List<String[]>> mapVal)throws BiffException,WriteException, IOException, SQLException  {
		String fullPath="";                     						//生成的文件路径以及名称信息
		InputStream fs = null;                 
        Workbook workBook = null;
    	WritableWorkbook wwb = null;
    	int[] rows=null;                                    			//存储文件标题所占的行数 识别数据开始写入的行数
    	int sheetCount=0;                                   			//存储sheet个数                                
		try {

			//1.判断目标模板文件是否存在 如果存在则进行处理
			if (fileExists(tempFilePath)) {
				markDir(filePath);                                      //创建文件保存的临时目录

				//2.读取模板信息（标题和字段名称）
				fs = new FileInputStream(tempFilePath); 				//加载excel文件
				workBook = Workbook.getWorkbook(fs); 					//得到 workbook
				sheetCount = workBook.getSheetNames().length; 			//得到一个excel中的文件的工作薄个数
				rows = new int[sheetCount];                             //每个工作薄的标题占的行数
	
				//3.分别获得每个sheet
				for (int s = 0; s < sheetCount; s++) {
					Sheet sheet = workBook.getSheet(s); 				//取每一个sheet的内容，默认从0开始
					rows[s] = sheet.getRows();
				}
												
              
				//4生成文件信息
				Date date = new Date();                                 //组织文件名称信息模板名称加入时间信息
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String curDatetime = sdf.format(date);

				String tableName = tempFilePath.substring(tempFilePath.lastIndexOf("\\"),tempFilePath.lastIndexOf("."));
				fullPath = filePath + tableName + "(" + curDatetime + ")"+ ".xls";
				
				//根据路径和名称生成文件
				File outFile = new File(fullPath);
                 wwb = Workbook.createWorkbook(outFile, workBook);
                //5根据每个工作薄的标题分别生成文件内容
				if (wwb != null) {
					for (int s = 0; s < sheetCount; s++) {               //循环生成每个工作薄
						WritableSheet ws = wwb.getSheet(s);              //读取每个工作表再写入信息
	
						//6.根据传入值写文件
						if (mapVal.size() > s) {                                       //循环写每个工作薄的信息
							List<String[]> list = mapVal.get(s);                      
							if (list != null && list.size() > 0) {
								for (int r = 0; r < list.size(); r++) {
									String[] dataVal = (String[]) list.get(r);
									for (int c = 0; c < dataVal.length; c++) {
										Label nameLable = new Label(c, r+ rows[s], dataVal[c]);  //写文件单元
										ws.addCell(nameLable);
									}
								}
							}
						}

					}

				}
				wwb.write();
				
			}else{
			    //找不到文件 抛出异常
				 throw new IOException("模板文件不存在");
			}
		}finally {
			//关闭打开的文件信息
			workBook.close(); 
			try{
				if(wwb!=null){
					wwb.close();
				}
			}catch(Exception e){
				LOG.error("WritableWorkbook关闭出错", e);
			}
        
		}
		return fullPath;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* expData(导出数据到EXCEL文件)
	* @param tempFilePath 模板文件的在服务器上的存储路径
	* @param mapVal       需要生成的数据信息
	* @return             返回生成的文件信息
	* @throws BiffException
	* @throws WriteException
	* @throws IOException
	* @throws SQLException
	 */
	public  String expData(String tempFilePath,List<List<Map<String,String>>> mapVal,List<String []> key)throws BiffException,WriteException, IOException, SQLException  {
		String fullPath="";                     						//生成的文件路径以及名称信息
		InputStream fs = null;                 
        Workbook workBook = null;
    	WritableWorkbook wwb = null;
    	int[] rows=null;                                    			//存储文件标题所占的行数 识别数据开始写入的行数
    	int sheetCount=0;                                   			//存储sheet个数                                
		try {
			//1.判断目标模板文件是否存在 如果存在则进行处理
			if (fileExists(tempFilePath)) {
				markDir(filePath);                                      //创建文件保存的临时目录

				//2.读取模板信息（标题和字段名称）
				fs = new FileInputStream(tempFilePath); 				//加载excel文件
				workBook = Workbook.getWorkbook(fs); 					//得到 workbook
				sheetCount = workBook.getSheetNames().length; 			//得到一个excel中的文件的工作薄个数
				rows = new int[sheetCount];                             //每个工作薄的标题占的行数
				//3.分别获得每个sheet
				for (int s = 0; s < sheetCount; s++) {
					Sheet sheet = workBook.getSheet(s); 				//取每一个sheet的内容，默认从0开始
					rows[s] = sheet.getRows();
				}
				//4生成文件信息
				Date date = new Date();                                 //组织文件名称信息模板名称加入时间信息
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String curDatetime = sdf.format(date);

				String tableName = tempFilePath.substring(tempFilePath.lastIndexOf("\\"),tempFilePath.lastIndexOf("."));
				fullPath = filePath + tableName + "(" + curDatetime + ")"+ ".xls";
				
				//根据路径和名称生成文件
				File outFile = new File(fullPath);
                 wwb = Workbook.createWorkbook(outFile, workBook);
                //5根据每个工作薄的标题分别生成文件内容
				if (wwb != null) {
					for (int s = 0; s < sheetCount; s++) {               //循环生成每个工作薄
						WritableSheet ws = wwb.getSheet(s);              //读取每个工作表再写入信息
	
						//6.根据传入值写文件
						if (mapVal.size() > s) {  
							
							//循环写每个工作薄的信息
							List<Map<String,String>> list = mapVal.get(s);     
							//得到Map的key数组
							String[] keyArray = key.get(s);
							if (list != null && list.size() > 0) {

								for (int r = 0; r < list.size(); r++) {
									Map<String, String> dataVal = list
											.get(r);
									if (null != keyArray && keyArray.length > 0) {
										for (int c = 0; c < keyArray.length; c++) {
											Label nameLable = new Label(c, r
													+ rows[s], String
													.valueOf(dataVal.get(
															keyArray[c]))); // 写文件单元
											ws.addCell(nameLable);
										}
									}
								}
							}
						}
					}
				}
				wwb.write();
				
			}else{
			    //找不到文件 抛出异常
  				 throw new IOException("模板文件不存在");
			}
		}finally {
			if(null != workBook){
			//关闭打开的文件信息
			workBook.close(); 
			}
			try{
				if(wwb!=null){
					wwb.close();
				}
			}catch(Exception e){
				LOG.error("WritableWorkbook关闭出错", e);
			}
        
		}
		return fullPath;
	}
	
	/**
	 * 
	*<b>Summary: 单个的sheet，导出</b>
	* expData()
	* @param tempFilePath 模板路径
	* @param mapVal       数据
	* @param key          map的key数组
	* @return
	* @throws BiffException
	* @throws WriteException
	* @throws IOException
	* @throws SQLException
	 */
	public  String expData(String tempFilePath,List<Map<String,String>> mapVal,String [] key)throws BiffException,WriteException, IOException, SQLException {
		List<List<Map<String,String>>> val = new ArrayList<List<Map<String,String>>>();
		val.add(mapVal);
		
		List<String []> keyList = new ArrayList<String []>();
		keyList.add(key);
		
		return expData(tempFilePath,val,keyList);
	}

	/**
	 * 
	*<b>Summary: </b>
	* expDataStream(执行导出操作)
	* @param tempFilePath 模板文件的在服务器上的存储路径
	* @param list         数据信息
	* @param response
	 */
	public void expDataStream(String tempFilePath, List<String[]> list,String excelName,HttpServletResponse response) {
		//如果是单工作薄 则需要封装成map进行处理 
		Map<Integer, List<String[]>> map = new HashMap<Integer, List<String[]>>();
		map.put(0, list);
		expDataStream(tempFilePath,map,excelName,response);
	}
	/**
	 * 
	*<b>Summary: </b>
	* expDataStream(执行导出操作)
	* @param tempFilePath  模板文件的在服务器上的存储路径
	* @param mapVal        数据信息
	* @param response
	 */
	public void expDataStream(String tempFilePath,Map<Integer,List<String[]>> mapVal,String excelName,HttpServletResponse response) {
		// 封装成输出流
		OutputStream output = null;
		FileInputStream fis = null;
		String fullPath="";
		try {
			 fullPath = expData(tempFilePath, mapVal);
			String fileName = ""; //用户显示的excel名字    如果传入了excel名称就使用传入的，没有则使用模板+时间
			
			if(excelName!=null && !"".equals(excelName)){
				fileName = excelName+".xls";
			}else{
				fileName = fullPath.substring(fullPath.lastIndexOf("\\"));
			}
			
			response.reset();
			response.setContentType("application/msexcel");
			response.addHeader("Content-disposition", "attachment; filename=\""+ toChinese(fileName) + "\"");

			output = response.getOutputStream();
			fis = new FileInputStream(fullPath);

			byte[] b = new byte[1024];
			int i = 0;

			while ((i = fis.read(b)) > 0) {
				output.write(b, 0, i);
			}
			output.flush();
		} catch (Exception e) {
			LOG.error("数据导出excel出错", e);
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
					output.close();
					output = null;
				}
			} catch (Exception e) {
				LOG.error("OutputStream关闭出错", e);
			}
			
			//文件允许删除
			File outFile = new File(fullPath);
		    if(delMark && outFile.isFile()&&outFile.exists()){
		    	outFile.delete();   
		    }   
		}
		
	}
	
	
	/**
	 * 
	*<b>Summary: 多sheet的导出</b>
	* expDataStream()
	* @param tempFilePath 模板路径
	* @param mapVal       数据集合
	* @param key          数据列的key
	* @param excelName    导出文件名
	* @param response
	 */
	public void expDataStream(String tempFilePath,List<List<Map<String,String>>> mapVal,List<String[]> key,String excelName,HttpServletResponse response) {
		// 封装成输出流
		OutputStream output = null;
		FileInputStream fis = null;
		String fullPath="";
		try {
			 fullPath = expData(tempFilePath, mapVal,key);
			String fileName = ""; //用户显示的excel名字    如果传入了excel名称就使用传入的，没有则使用模板+时间
			
			if(excelName!=null && !"".equals(excelName)){
				fileName = excelName+".xls";
			}else{
				fileName = fullPath.substring(fullPath.lastIndexOf("\\"));
			}
			response.reset();
			response.resetBuffer();
			response.setContentType("application/octet-stream");
	        response.addHeader("Content-disposition", "attachment; filename=\""+ toChinese(fileName) + "\"");

			output = response.getOutputStream();
			fis = new FileInputStream(fullPath);

			byte[] b = new byte[fis.available()];
			fis.read(b);
//			int i = 0;
            
//			while ((i = fis.read(b)) > 0) {
				
//			}
			output.write(b);
			
		} catch (Exception e) {
			LOG.error("数据导出excel出错", e);
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
			
			//文件允许删除
			File outFile = new File(fullPath);
		    if(delMark && outFile.isFile()&&outFile.exists()){
		    	 boolean ok =	outFile.delete();   
			      LOG.error("是否删除成功"+ok);
		    }   
		}
		
	}

	/**
	 * 
	*<b>Summary: 单个sheet的导出</b>
	* expDataStream()
	* @param tempFilePath 模板路径
	* @param mapVal       数据集合
	* @param key          数据列的key
	* @param excelName    导出文件名
	* @param response
	 */
	public void expDataStream(String tempFilePath,
			List<Map<String, String>> mapVal, String[] key, String excelName,
			HttpServletResponse response) {
		List<List<Map<String, String>>> val = new ArrayList<List<Map<String, String>>>();
		val.add(mapVal);

		List<String[]> keyList = new ArrayList<String[]>();
		keyList.add(key);

		expDataStream(tempFilePath, val, keyList, excelName, response);

	}
		
	/**
	 * 
	*<b>Summary: </b>
	* fileExists(判断模板文件是否存在)
	* @param path
	* @return
	 */
	private  boolean fileExists(String path){
		boolean res = false;
			File f = new File(path);
			if (f.exists()) {
				res = true;
			} else {
				res = false;
			}
	
		return res;
	}
	/**
	 * 
	*<b>Summary: </b>
	* fileExists(创建文件夹)
	* @param path
	* @return
	 */
	private  void markDir(String path) throws IOException{
		File file = new File(filePath);
		if (!file.exists()){
			file.mkdirs();
		}
	}
	/**
	 * 
	*<b>Summary: </b>
	* toChinese(转码)
	* @param strvalue
	* @return
	 */
	public  String toChinese(String strvalue) {
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
}
