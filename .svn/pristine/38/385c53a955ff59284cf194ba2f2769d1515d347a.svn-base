package com.chinacreator.xtbg.core.file.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import jxl.write.biff.RowsExceededException;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.commonlist.PublicAjaxAction;
import com.chinacreator.xtbg.core.common.excel.ExcelUtil;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;
import com.chinacreator.xtbg.core.file.service.FileFilesService;
import com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl;

/**
 * 
 *<p>Title:FileExportExcelAction.java</p>
 *<p>Description:进行导出的action</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-8-14
 */
public class FileExportExcelAction extends PublicAjaxAction {
	private static final Logger LOG = Logger
			.getLogger(FileExportExcelAction.class);
	private FileFilesBean bean;
	private String filesId;//档案id
	private String exportKey ;//导出要用到的key
	private String exportHeader;//表头数组
	private String exportTitle;//导出文件名
	private String userName;//当前登录人 
	
	/**
	 * 需求:档案管理----导出卷内文件时，导出的EXELE文件中需要保持13行的表格格式，就算数据没有那么多表格也要有13行。（格式调整尽量合适）
	 * 调用该方法的有四个方法
	 * exportDocList4doc 
	 * exportDocList 光盘和视频
	 * exportDocList4Pic
	 *<b>Summary: </b>
	 * addNullData()
	 * @param eutil
	 * @param startRow
	 * @param startColumn
	 * @param list
	 * @param key
	 * @param sheet
	 * @param format
	 * @throws WriteException 
	 * @throws RowsExceededException 
	 */
	private int addNullData(ExcelUtil eutil,int startRow, int startColumn,
			List<Map<String, String>> list, String[] key, WritableSheet sheet,
			CellFormat format) throws RowsExceededException, WriteException{
		int addLine = 13-list.size();
		if(addLine>0){
			startRow = startRow+list.size();
			List<Map<String, String>> nullList = new ArrayList<Map<String, String>>();
			for (int i = 0; i < addLine; i++) {
				Map<String, String> nullMap = new HashMap<String, String>();
				for (int j = 0; j < key.length; j++) {
					nullMap.put(key[j],"");
				}
				nullList.add(nullMap);
			}
			eutil.addRowData(startRow, startColumn, nullList, key, sheet, eutil.getDataFormat());
		}else{
			addLine = 0;
		}
		return addLine;
	}
	
	/**
	 * 
	*<b>Summary: 导出文书档案案卷目录</b>
	* exportFileList4doc()
	 */
	@SuppressWarnings("unchecked")
	public void exportFileList() {
		try {
			FileFilesService service = new FileFilesServiceImpl();
			PageInfoBean page = getPage();
			// 设置导出所有的记录，最多导出一万条
			page.setSortName("to_number(f_filesno)");// 导出时按案卷号升序
			page.setSortOrder("asc");
			page.setPage("1");
			page.setRows("50000");

			PagingBean pb = service.findFilesPageBean4acc(bean, page);

			List<Map<String, String>> list = (List<Map<String, String>>) pb
					.getList();  
			// 导出的列的key
			String[] key = null;
			if (null != exportKey && !StringUtil.nullOrBlank(exportKey)) {
				key = exportKey.split("\\,");
			}
			
			
			String[] header = null;
			if (null != exportHeader && !StringUtil.nullOrBlank(exportHeader)) {
				header = exportHeader.split("\\,");
			}			
			// 导出工具 
			ExcelUtil eutil = new ExcelUtil();
			eutil.setDefaultWidth(2);
			String title  = (StringUtil.nullOrBlank(exportTitle))?"案卷目录":exportTitle;
						
			// 构建excel
			WritableWorkbook excel = eutil.createExcel(getRequest());
			WritableSheet sheet = excel.createSheet(title, 1);

			
			int startRow = 0;
			int startColumn = 1;	
			sheet.setColumnView(0, 3);
			//添加标题
			eutil.addRowData(startRow++, startColumn, key.length, title, sheet, getTitleFormat4doc());
			
			//添加第一行数据		
			String year = DateUtil.getCurrentYear();
			if(null != list && !list.isEmpty()){
				year = list.get(0).get("f_doc_year");
			}
			String[] topRow = new String[] {"档案年度 ："+year+" " };
			sheet.setRowView(startRow,500);//设置行高
			eutil.addRowDataNotSetWidth(startRow++, startColumn, topRow,
					sheet, eutil.getDataFormatAlignRight(false)); 
			//合并单元格
			sheet.mergeCells(startColumn, startRow-1, startColumn+key.length-1,
					startRow-1);
			//添加表头
			eutil.addRowData(startRow++, startColumn, header, sheet, eutil.getHeadFormat());
			sheet.setRowView(startRow-1, 800);
			//添加数据列表
			eutil.addRowData(startRow, startColumn, list, key, sheet, eutil.getDataFormat());
			//设置数据列的行高
			for(int i=startRow;i<(startRow+list.size());i++){
				sheet.setRowView(i, 500);
			}
			// 写文件
			excel.write();
			excel.close();

			eutil.responseExcel(title, getResponse());
			
			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}
	/**
	 * 
	 *<b>Summary:导出档案列表</b> exportFileList()
	 */
	@SuppressWarnings("unchecked")
	public void exportFileList4doc() {
		try {
			FileFilesService service = new FileFilesServiceImpl();
			PageInfoBean page = getPage();
			// 设置导出所有的记录，最多导出一万条
			page.setSortName("to_number(f_filesno)");// 导出时按案卷号升序
			page.setSortOrder("asc");
			page.setPage("1");
			page.setRows("50000");

			PagingBean pb = service.findFilesPageBean4acc(bean, page);

			List<Map<String, String>> list = (List<Map<String, String>>) pb
					.getList();  
			//档案添加顺序号
			if(null!=list){
				for(int i=0;i<list.size();i++){
					list.get(i).put("num",(i+1)+"");
				}
			}
			//添加第一行数据		
			String year = DateUtil.getCurrentYear();
			if(null != list && !list.isEmpty()){
				year = list.get(0).get("f_doc_year");
			}
			String title  = year+"年度案卷排列顺序";
			// 导出的列的key
			String[] key = null;
			if (null != exportKey && !StringUtil.nullOrBlank(exportKey)) {
				key = exportKey.split("\\,");
			}
			String[] header = null;
			if (null != exportHeader && !StringUtil.nullOrBlank(exportHeader)) {
				header = exportHeader.split("\\,");
			}			
			// 导出工具 
			ExcelUtil eutil = new ExcelUtil();
			eutil.setDefaultWidth(2);
						
			// 构建excel
			WritableWorkbook excel = eutil.createExcel(getRequest());
			WritableSheet sheet = excel.createSheet(title, 1);

			
			int startRow = 0;
			int startColumn = 1;	  
			sheet.setColumnView(0, 3);
			//添加标题
			eutil.addRowData(startRow++, startColumn, key.length, title, sheet, getTitleFormat4doc());
			sheet.setRowView(startRow-1,800);//设置行高
			
			
			//添加表头
			eutil.addRowData(startRow++, startColumn, header, sheet, eutil.getHeadFormat());
			sheet.setRowView(startRow-1, 700);
			//添加数据列表
			eutil.addRowData(startRow, startColumn, list, key, sheet, eutil.getDataFormat());
			//设置数据列的行高
			for(int i=startRow;i<(startRow+list.size());i++){
				sheet.setRowView(i, 500);
			}
			
			// 写文件
			excel.write();
			excel.close();

			eutil.responseExcel(title, getResponse());			
			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}
	/**
	 * 
	*<b>Summary: 导出会计档案案卷列表</b>
	* exportFileList4acc()
	 */
	@SuppressWarnings("unchecked")
	public void exportFileList4acc() {
		try {
			FileFilesService service = new FileFilesServiceImpl();
			PageInfoBean page = getPage();
			// 设置导出所有的记录，最多导出5000条
			page.setSortName("to_number(f_filesno)");// 导出时按案卷号升序
			page.setSortOrder("asc");
			page.setPage("1");
			page.setRows("50000");

			PagingBean pb = service.findFilesPageBean4acc(bean, page);

			List<Map<String, String>> list = (List<Map<String, String>>) pb
					.getList();

			// 导出的列的key
			String[] key = null;
			if (null != exportKey && !StringUtil.nullOrBlank(exportKey)) {
				key = exportKey.split("\\,");
			}
			String[] header = null;
			if (null != exportHeader && !StringUtil.nullOrBlank(exportHeader)) {
				header = exportHeader.split("\\,");
			}
			// 导出工具
			ExcelUtil eutil = new ExcelUtil();
			eutil.setDefaultWidth(2);
			int startRow = 1;
			int startColumn = 1;
			
			// 构建excel
			WritableWorkbook excel = eutil.createExcel(getRequest());
			WritableSheet sheet = excel.createSheet(exportTitle, 1);
			
			//添加标题行
			eutil.addRowData(startRow++, startColumn, key.length,
					exportTitle, sheet, getTitleFormat4doc());
						
			String deptName = "";
			String createUser = "";
			String createDate = "";
			if (null != list && !list.isEmpty()) {
				deptName = list.get(0).get("f_dept_name");				
			    createUser = list.get(0).get("f_file_username");
			    createDate = list.get(0).get("f_file_time");
			}
			//第一行数据
			String[] firstRow = new String[]{"部门名称："+deptName};
		
			eutil.addRowData(startRow++, startColumn, firstRow, sheet, eutil.getDataFormat(false,null,null,null));
			//合并单元格
			sheet.mergeCells(startColumn, startRow-1, startColumn
					+2, startRow-1);
			sheet.setRowView(startRow-1, 500);
			//添加表头
			eutil.addRowData(startRow++, startColumn, header, sheet, eutil.getHeadFormat());
			sheet.setRowView(startRow-1, 800);
			//sheet.setColumnView(startColumn+key.length-2, 6);
			
			//添加正文数据
			eutil.addRowData(startRow, startColumn, list, key, sheet, eutil.getDataFormat());
			for(int i=startRow;i<(startRow+list.size());i++){
				sheet.setRowView(i, 500);
			}
			sheet.mergeCells(startColumn, list.size()+startRow, startColumn
					+key.length-1, list.size()+startRow);
			//添加统计数据
			eutil.addRowDataNotSetWidth(list.size()+(startRow++), startColumn,
					new String[]{"合计："+String.valueOf(list.size())+"卷"}, 
					sheet, eutil.getDataFormat(false,null,null,null));
			
			//添加底部数据
			String[] bottomRow = new String[key.length];
			String [] bottomRow2 = new String[key.length];
			if (key.length >= 4) {
				bottomRow[0] = "移交经办人："+ createUser;
				bottomRow[bottomRow.length - 3] = "档案接收人： "+ userName;
		         
				bottomRow2[0] = "移交时间："+ createDate;
				bottomRow2[bottomRow.length - 3] = "档案接收时间："+ DateUtil.getCurrentDate();
			}
			//插入数据
			eutil.addRowDataNotSetWidth(list.size()+(startRow), 
					startColumn, bottomRow, sheet, eutil.getDataFormat(false,null,null,null));
			eutil.addRowDataNotSetWidth(list.size()+(startRow+1), 
					startColumn, bottomRow2, sheet, eutil.getDataFormat(false,null,null,null));
			
			//合并单元格
			sheet.mergeCells(startColumn, startRow+list.size(), startColumn
					+2, startRow+list.size());
			sheet.mergeCells(startColumn
					+key.length-3, startRow+list.size(), startColumn
					+key.length-1, startRow+list.size());
			sheet.mergeCells(startColumn, startRow+1+list.size(), startColumn
					+2, startRow+1+list.size());
			sheet.mergeCells(startColumn
					+key.length-3, startRow+1+list.size(), startColumn
					+key.length-1, startRow+1+list.size());
			
			
			// 写文件
			excel.write();
			excel.close();

			eutil.responseExcel(exportTitle, getResponse());

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}
	/**
	 * 
	*<b>Summary:导出卷内文件列表 </b>
	* exportDocList()
	 */
	@SuppressWarnings("unchecked")
	public void exportDocList(){ 
		try {
			PagingBean pb = null;
			Map<String, String> map = new HashMap<String, String>();
			map.put("filesId", filesId);
			map.put("sortName","to_number(f_doc_num)");
			map.put("sortOrder"," asc");
			map.put("offset", "0");
			map.put("maxPagesize", "50000");
			FileFilesService service = new FileFilesServiceImpl();
			pb = service.findDocPageBeanForFiles(map);
			List<Map<String, String>> list = (List<Map<String, String>>) pb
					.getList();
			// 导出的列的key
			String[] key = null;
			if (null != exportKey && !StringUtil.nullOrBlank(exportKey)) {
				key = exportKey.split("\\,");
			}
			String[] header = null;
			if (null != exportHeader && !StringUtil.nullOrBlank(exportHeader)){
				header = exportHeader.split("\\,");
			}		
			// 导出工具
			ExcelUtil eutil = new ExcelUtil();
			eutil.setDefaultWidth(2);
			String title = (StringUtil.nullOrBlank(exportTitle))?"卷内目录":exportTitle;
			
            // 构建excel
			WritableWorkbook excel = eutil.createExcel(getRequest());
			WritableSheet sheet = excel.createSheet(title, 1);

			
			int startRow = 0;
			int startColumn = 1;	
			sheet.setColumnView(0, 3);
			//添加标题
			eutil.addRowData(startRow++, startColumn, key.length, title, sheet, getTitleFormat4doc());
			sheet.setRowView(startRow-1, 900);			
			//添加表头
			eutil.addRowData(startRow++, startColumn, header, sheet,eutil.getHeadFormat());			
			sheet.setRowView(startRow-1, 800);
			//添加数据列表
			eutil.addRowData(startRow, startColumn, list, key, sheet, eutil.getDataFormat());
			int addLine = this.addNullData(eutil, startRow, startColumn, list, key, sheet, eutil.getDataFormat());
			//设置数据列的行高
			for(int i=startRow;i<(startRow+list.size());i++){
				sheet.setRowView(i, 500);
			}
			if(addLine>0){
				for(int i=(startRow+list.size());i<(startRow+list.size()+addLine);i++){
					sheet.setRowView(i, 500);
				}
			}
			// 写文件
			excel.write();
			excel.close();

			eutil.responseExcel(title, getResponse());

		}catch(Exception e){
			LOG.error(e.getMessage(),e);
		}
	}
	/**
	 * 
	*<b>Summary: 导出文书档案卷内文件</b>
	* exportDocList4doc()
	 */

	@SuppressWarnings("unchecked")
	public void exportDocList4doc(){
		try {
			PagingBean pb = null;
			Map<String, String> map = new HashMap<String, String>();
			PageInfoBean page = getPage();
			map.put("filesId", filesId);
			map.put("sortName", page.getSortName());
			map.put("sortOrder", page.getSortOrder());
			map.put("offset", "0");
			map.put("maxPagesize", "50000");
			FileFilesService service = new FileFilesServiceImpl();
			pb = service.findDocPageBeanForFiles(map);
			List<Map<String, String>> list = (List<Map<String, String>>) pb
					.getList();
			// 导出的列的key
			String[] key = null;
			if (null != exportKey && !StringUtil.nullOrBlank(exportKey)) {
				key = exportKey.split("\\,");
			}
			String[] header = null;
			if (null != exportHeader && !StringUtil.nullOrBlank(exportHeader)){
				header = exportHeader.split("\\,");
			}		
			// 导出工具
			ExcelUtil eutil = new ExcelUtil();
			eutil.setDefaultWidth(2);
			String title = (StringUtil.nullOrBlank(exportTitle))?"卷内目录":exportTitle;
			
			//excel.exportExcel(list, header,key,title, getRequest(), getResponse());
            // 构建excel
			WritableWorkbook excel = eutil.createExcel(getRequest());
			WritableSheet sheet = excel.createSheet(title, 1);

			
			int startRow = 0;
			int startColumn = 1;	
			sheet.setColumnView(0, 3);
			//添加标题
			eutil.addRowData(startRow++, startColumn, key.length, title, sheet, getTitleFormat4doc());
			sheet.setRowView(startRow-1, 900);
			//添加第一行数据
			if (null != bean) {
				
				sheet.setRowView(startRow,700);//设置行高
				//增加类型数据
				Label label = new Label(startColumn, startRow, bean.getF_type_name());
				label.setCellFormat(eutil.getDataFormat(false,Alignment.LEFT,WritableFont.createFont("宋体"),11));
				sheet.addCell(label);
				//增加处室和盒号
				Label label2 = new Label(startColumn+4, startRow++, bean.getF_dept_name()+ "    盒号："+bean.getF_filesno() );
				label2.setCellFormat(eutil.getDataFormat(false,Alignment.RIGHT,WritableFont.createFont("宋体"),11));
				sheet.addCell(label2);
				//合并单元格
				sheet.mergeCells(startColumn, startRow-1, startColumn+3, startRow-1);
				sheet.mergeCells(startColumn+4, startRow-1, startColumn+key.length-1, startRow-1);
			}
			//添加表头
			eutil.addRowData(startRow++, startColumn, header, sheet, getHeadFormat4doc());
			//设置列宽
			String[] widthArray = null;
			String exportHeaderWidth = getRequest().getParameter("exportHeaderWidth");
			if(!StringUtil.nullOrBlank(exportHeaderWidth)){
				widthArray = exportHeaderWidth.split("\\,");
			}
			if(null!=widthArray){
				for(int i=0;i<widthArray.length;i++){
					sheet.setColumnView(startColumn+i, Integer.valueOf(widthArray[i]));
				}
			}
			sheet.mergeCells(startColumn+3, startRow-1, startColumn+4,  startRow-1);			
			//添加数据列表
			eutil.addRowData(startRow, startColumn, list, key, sheet, eutil.getDataFormat());
			int addLine =this.addNullData(eutil, startRow, startColumn, list, key, sheet, eutil.getDataFormat());
			//设置数据列的行高
			for(int i=startRow;i<(startRow+list.size());i++){
				sheet.setRowView(i, 900);
				sheet.mergeCells(startColumn+3, i, startColumn+4, i);
			}
			if(addLine>0){
				for(int i=(startRow+list.size());i<(startRow+list.size()+addLine);i++){
					sheet.setRowView(i, 900);
					sheet.mergeCells(startColumn+3, i, startColumn+4, i);
				}
			}
			// 写文件
			excel.write();
			excel.close();

			eutil.responseExcel(title, getResponse());
			
			
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
		}
	}
	
	/**
	 * 
	*<b>Summary:导出卷内文件列表 </b>
	* exportDocList()
	 */
	public void exportDocList4Pic(){
		try {
			
			FileFilesService service = new FileFilesServiceImpl();			// 数据
			List<Map<String,String>> list = service.queryDocDesc4Export(filesId);
			FileFilesBean fileBean = service.queryToFileFilesBean(filesId);
			//添加页号
			if(null!=list){
				for(int i=0;i<list.size();i++){
					int yehaom = (i+1)%3;
					int yehao = 1;
					if(yehaom==0){
						yehao = (i+1)/3;
					}else{
						yehao = (i+1)/3+1;
					}
					list.get(i).put("yehao", yehao+"");
				}
			}
			
			// 导出的列的key
			String[] key = null;
			if (null != exportKey && !StringUtil.nullOrBlank(exportKey)){
				key = exportKey.split("\\,");
			}
			String[] header = null;
			if (null != exportHeader && !StringUtil.nullOrBlank(exportHeader)){
				header = exportHeader.split("\\,");
			}
			// 导出工具
			//ExcelUtil excel = new ExcelUtil();
			//excel.exportExcel(list, header,key,"照片档案目录", getRequest(), getResponse());
			// 导出工具 
			ExcelUtil eutil = new ExcelUtil();
			eutil.setDefaultWidth(2);
			// 构建excel
			WritableWorkbook excel = eutil.createExcel(getRequest());
			WritableSheet sheet = excel.createSheet(exportTitle, 1);

			
			int startRow = 0;
			int startColumn = 1;	  
			sheet.setColumnView(0, 3);
			//添加标题
			eutil.addRowData(startRow++, startColumn, key.length, exportTitle, sheet, getTitleFormat4doc());
			sheet.setRowView(startRow-1,800);//设置行高
			//添加第一行数据
			if (null != fileBean) {
				
				sheet.setRowView(startRow,700);//设置行高
				//增加类型数据
				Label label = new Label(startColumn, startRow, fileBean.getF_type_name());
				label.setCellFormat(eutil.getDataFormat(false,Alignment.LEFT,WritableFont.createFont("宋体"),11));
				sheet.addCell(label);
				//增加处室和盒号
				Label label2 = new Label(startColumn+2, startRow++, fileBean.getF_files_no());
				label2.setCellFormat(eutil.getDataFormat(false,Alignment.RIGHT,WritableFont.createFont("宋体"),11));
				sheet.addCell(label2);
				//合并单元格
				sheet.mergeCells(startColumn, startRow-1, startColumn+1, startRow-1);
				sheet.mergeCells(startColumn+2, startRow-1, startColumn+key.length-1, startRow-1);
			}
			
			//添加表头
			eutil.addRowData(startRow++, startColumn, header, sheet, eutil.getHeadFormat());
			sheet.setRowView(startRow-1, 700);
			sheet.mergeCells(startColumn+1, startRow-1, startColumn+2, startRow-1);
			//添加数据列表
			eutil.addRowData(startRow, startColumn, list, key, sheet, eutil.getDataFormat());
			int addLine = this.addNullData(eutil, startRow, startColumn, list, key, sheet, eutil.getDataFormat());
			//设置数据列的行高，以及合并单元格
			for(int i=startRow;i<(startRow+list.size());i++){
				sheet.setRowView(i, 500);
				sheet.mergeCells(startColumn+1, i, startColumn+2, i);
			}
			if(addLine>0){
				for(int i=(startRow+list.size());i<(startRow+list.size()+addLine);i++){
					sheet.setRowView(i, 500);
					sheet.mergeCells(startColumn+1, i, startColumn+2, i);
				}
			}
			// 写文件
			excel.write();
			excel.close();

			eutil.responseExcel(exportTitle, getResponse());
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
		}
	}
	/**
	 * 
	*<b>Summary:导出照片(光盘)详细信息 </b>
	* exportPicDetail()
	 */
	public void exportPicDetail() {
		FileFilesService service = new FileFilesServiceImpl();
		try {
			// 数据
			List<Map<String,String>> list = service.queryDocDesc4Export(filesId);
			//JSONObject json = new JSONObject();
			//json.put("list", list);
			super.write4Json(list);
			
			//转换
			//List<List<String>> values = convertListToMap(list);
			
			// 导出文件名
			//String fileName = "图片标签";
			
			// 导出工具
			//ExcelUtil eutil = new ExcelUtil();
			// 导出
			//eutil.exportExcelColumnStyle(values, fileName,30,getRequest(),getResponse());

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}
	
		
	/**
	 * 
	*<b>Summary:导出照片(光盘)详细信息 </b>
	* exportPicDetail()
	 */
	public void exportDiskDetail(){		
		// 导出工具
		ExcelUtil eutil = new ExcelUtil();
		try {
			FileFilesService service = new FileFilesServiceImpl();
			// 数据
			List<Map<String, String>> list = service
					.queryDocDesc4ExportDisk(filesId);

			// 导出文件名
			String fileName = "卷内标签";

			// 导出的列的key
			String[] key = null;
			if (null != exportKey && !StringUtil.nullOrBlank(exportKey)) {
				key = exportKey.split("\\,");
			}
			String[] header = null;
			if (null != exportHeader && !StringUtil.nullOrBlank(exportHeader)) {
				header = exportHeader.split("\\,");
			}

			// 构建excel
			WritableWorkbook excel = eutil.createExcel(getRequest());
			WritableSheet sheet = excel.createSheet(fileName, 1);
			int column = 1;// 添加数据的列
			sheet.setColumnView(0, 2);
			if (null != list && null != key && null != header) {
				for (int i = 0; i < list.size(); i++) {
					Map<String, String> map = list.get(i);
					// 添加一列数据
					eutil.addColumnData(1, column++, 8, header, sheet, eutil
							.getDataFormat());
					eutil.addColumnData(1, column++, 13, map, key, sheet, eutil
							.getDataFormat());					
					sheet.setColumnView(column, 2);
					column++;// 列数据之间增加空格					
				}
				for(int i= 1;i<header.length;i++){
					sheet.setRowView(i, 590);
				}
				//设置行高
				sheet.setRowView(6, 1800);
				sheet.setRowView(8, 650);
				
			}
			// 写文件
			excel.write();
			excel.close();

			eutil.responseExcel(fileName, getResponse());

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}finally{
			eutil.deleteFile();
		}
	}
	
	/**
	 * 
	*<b>Summary:导出照片档案的背脊标签 </b>
	* exportFileBack()
	 */
	@SuppressWarnings("unchecked")
	public void exportFileBack(){

		PagingBean pb = new PagingBean();
		try {
			FileFilesService service = new FileFilesServiceImpl();
			PageInfoBean page = getPage();
			page.setPage("1");
			page.setRows("50000");
			pb = service.findFilesPageBean4acc(bean,page);
			List<Map<String,String>> list = (List<Map<String,String>>)pb.getList();
			
			//要导出的数据集合
			List<List<String>> exportList = new ArrayList<List<String>>();
			for (Map<String, String> map : list) {
				// 列数据
				List<String> column = new ArrayList<String>();
				column.add(map.get("f_org_name"));
				column.add("全宗号");
				column.add(map.get("f_fondsno"));
				column.add("保管期限");
				column.add(map.get("f_doc_deadline_name"));
				column.add("目录号");
				column.add(map.get("f_listno"));
				column.add("案卷号");
				column.add(map.get("f_filesno"));
				column.add("年度");
				column.add(map.get("f_doc_year"));
				column.add(map.get("f_type_name"));//档案分类名称
				exportList.add(column);
			}
			
			// 导出工具
			ExcelUtil eutil = new ExcelUtil();
			// 导出
			eutil.exportExcelColumnStyle(exportList, "背脊标签",15,getRequest(),getResponse());

			
			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			write4PagingBeanJson(pb);
		}
	
	}
	/**
	 * 
	*<b>Summary:导出光盘档案的背脊标签 </b>
	* exportFileBack()
	 */
	@SuppressWarnings("unchecked")
	public void exportFileBack4Disk(){
		PagingBean pb = new PagingBean();
		try {
			FileFilesService service = new FileFilesServiceImpl();
			PageInfoBean page = getPage();
			page.setPage("1");
			page.setRows("50000");
			pb = service.findFilesPageBean4acc(bean,page);
			List<Map<String,String>> list = (List<Map<String,String>>)pb.getList();
			
			//要导出的数据集合
			List<List<String>> exportList = new ArrayList<List<String>>();
			for (Map<String, String> map : list) {
				// 列数据
				List<String> column = new ArrayList<String>();
				column.add("光盘档案");
				column.add("全宗号");
				column.add(map.get("f_fondsno"));				
				column.add("目录号");
				column.add(map.get("f_listno"));
				column.add("案卷号");
				column.add(map.get("f_filesno"));
				column.add("保管期限");
				column.add(map.get("f_doc_deadline_name"));
			
				exportList.add(column);
			}			
			// 导出工具
			ExcelUtil eutil = new ExcelUtil();
			// 导出
			eutil.exportExcelColumnStyle(exportList, "背脊标签",10,getRequest(),getResponse());
			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			write4PagingBeanJson(pb);
		}	
	}
	
	/**
	 * 
	*<b>Summary: 文书档案卷内文件标题样式</b>
	* getTitleFormat4doc()
	* @return
	* @throws WriteException
	 */
    private WritableCellFormat getTitleFormat4doc() throws WriteException {
		
		WritableFont allToFont = new WritableFont(WritableFont.createFont("黑体"), 20,
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
	*<b>Summary: 文书档案卷内文件，表格表头的样式</b>
	* getHeadFormat4doc()
	* @return
	* @throws WriteException
	 */
	public WritableCellFormat getHeadFormat4doc() throws WriteException {
		
		WritableFont allToFont = new WritableFont(WritableFont.createFont("宋体"), 14,
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
	public FileFilesBean getBean(){
		return bean;
	}

	public void setBean(FileFilesBean bean) {
		this.bean = bean;
	}

	public String getFilesId() {
		return filesId;
	}

	public void setFilesId(String filesId) {
		this.filesId = filesId;
	}

	public String getExportKey() {
		return exportKey;
	}

	public void setExportKey(String exportKey) {
		this.exportKey = exportKey;
	}

	public String getExportHeader() {
		return exportHeader;
	}

	public void setExportHeader(String exportHeader) {
		this.exportHeader = exportHeader;
	}

	public String getExportTitle() {
		return exportTitle;
	}

	public void setExportTitle(String exportTitle) {
		this.exportTitle = exportTitle;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	} 
	
}
