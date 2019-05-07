package com.chinacreator.xtbg.core.archive.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.contrib.HSSFCellUtil;
import org.apache.poi.ss.util.CellRangeAddress;

import com.chinacreator.xtbg.core.archive.entity.ExcelBean;
import com.chinacreator.xtbg.core.archive.entity.SplitUnitBean;
import com.chinacreator.xtbg.core.archive.service.SplitUnitService;
import com.chinacreator.xtbg.core.archive.service.impl.SplitUnitServiceImpl;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 *<p>Title:SplitExcelFile.java</p>
 *<p>Description:拆分Excel工具类，这里用到了工具包POI，原来的有bug，现在是改了后重新打的包，如果更新了此包，将不能正常运行</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 17, 2013
 */
public class SplitExcelFile {
	int startNum = 0;	//标题行数，这些行将不会被解析
	public SplitExcelFile(int startNum){
		this.startNum = startNum;
	}
	
	/**
	 * 
	*<b>Summary: 拆分文件</b>
	* splitExcelFile()
	* @param sourceFilePath
	* @return
	* @throws Exception
	 */
	public List<ExcelBean> splitExcelFile(String sourceFilePath) throws Exception{
		List<ExcelBean> excelBeanList = new ArrayList<ExcelBean>();
		List<ExcelBean> list = getExcelContent(sourceFilePath);
		SplitUnitService service = new SplitUnitServiceImpl();
		System.out.println("--->"+sourceFilePath+" 指标文开始拆分,共需要拆分文件："+list.size()+" 个！");
		for(ExcelBean bean : list){
			//过滤用户录入的单位，excel拆分只拆分用户规定的单位
			ResultMap<ResultCode, SplitUnitBean> result = service.getByUnitName(bean.getTitle());
			if(result.getCode().equals(ResultCode.OK)){
				ExcelBean excelBean = splitExcel(sourceFilePath, bean);
				excelBean.setUnit_id(result.getResult().getUnit_id());
				excelBeanList.add(excelBean);
			} else {
				excelBeanList.clear();	//如果一旦发现有还未维护的单位，跳出循环，设置list为空
				break;
			}
		}
		return excelBeanList;
	}
	
	/**
	 * 
	 *<b>Summary:</b>
	 * getExcelContent(得到拆分的元素，将信息放到ExcelBean里，从录入的起始行开始解析)
	 * @param filename
	 * @return
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	private List<ExcelBean> getExcelContent(String filename) throws FileNotFoundException, IOException {
		List<ExcelBean> list = new ArrayList<ExcelBean>();
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(filename));
		HSSFSheet sheet = wb.getSheetAt(0);
		int rows = sheet.getPhysicalNumberOfRows();

		ExcelBean bean = null;
		String tempValue = "";
//		double amountValue = 0.0;
//		String remarkValue = "";
		int startRowNum = 0;
		//循环表格 解析
		for (int r = startNum; r <= rows; r++) {
			HSSFRow row = sheet.getRow(r);
			if (row == null) {
				continue;
			}
			HSSFCell cell0= row.getCell(0);
//			HSSFCell cell1= row.getCell(1);
//			HSSFCell cell2= row.getCell(2);
			int rowNum = row.getRowNum();
			String titleValue = cell0.getStringCellValue();
			//组装list
			if (titleValue != null && !"".equals(titleValue.trim())) {
				if (!"".equals(tempValue)) {
					bean = new ExcelBean();
					bean.setTitle(tempValue.trim());
					bean.setStartRowNum(startRowNum);
					bean.setEndRowNum(rowNum - 1);
					bean.setTotalNum(rowNum - startRowNum);
					
//					bean.setAmount(amountValue);
//					bean.setRemark(remarkValue);
					list.add(bean);
				}
				startRowNum = row.getRowNum();
				tempValue = titleValue;
//				amountValue = cell1.getNumericCellValue();
//				remarkValue = cell2.getStringCellValue();
				if (rowNum + 1 == rows) { // 解析有值的最后一行，也就是只有一行数值的最后一行
					bean = new ExcelBean();
					bean.setTitle(tempValue);
					bean.setStartRowNum(startRowNum);
					bean.setEndRowNum(rowNum);
					bean.setTotalNum(1);
//					bean.setAmount(amountValue);
//					bean.setRemark(remarkValue);
					list.add(bean);
				}
			} else if (titleValue != null && "".equals(titleValue.trim())) {
				if (rowNum + 1 == rows) { // 解析最后一行
					bean = new ExcelBean();
					bean.setTitle(tempValue);
					bean.setStartRowNum(startRowNum);
					bean.setEndRowNum(rowNum);
					bean.setTotalNum(rowNum - startRowNum);
//					bean.setAmount(amountValue);
//					bean.setRemark(remarkValue);
					list.add(bean);
				}
			}
		}
		return list;
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * splitExcel(拆分文件)
	 * @param sourceUrl
	 * @param bean
	 * @throws Exception
	 */
	private ExcelBean splitExcel(String sourceUrl, ExcelBean bean) throws Exception {
		System.out.println("拆分文件--->"+bean);
		FileInputStream is = new FileInputStream(sourceUrl);
		HSSFWorkbook workbook = new HSSFWorkbook(is);
		HSSFSheet sheet = workbook.getSheetAt(0);
		
		changeFormulaToString(workbook,sheet);
		
		int lastRowNum = sheet.getLastRowNum();
		//先从这个数据的下面开始删除
		for(int i = bean.getEndRowNum();i <= lastRowNum;i++){
			removeRow(sheet, bean.getEndRowNum()+1);
		}
		//从录入的起始行开始删除
		int tmpRowLength = bean.getStartRowNum()-startNum;	//得到要删除的行数
		for(int i = 0;i<tmpRowLength;i++){
			removeRow(sheet, startNum);
		}
		sheet.createFreezePane(0, sheet.getLastRowNum()+1);	//冻结操作后的数据，防止出现滚动条
		
		File childFile = createChildFile(sourceUrl,bean.getTitle());
		FileOutputStream os = new FileOutputStream(childFile);
		workbook.write(os);
		is.close();
		os.close();
		System.out.println("--拆分完成！");
		//将数据写入bean返回
		bean.setUnit_id("");
		bean.setFile_size(childFile.length());
		bean.setTitle(childFile.getName());
		return bean;
	}
	
	/**
	 * 
	 *<b>Summary:</b>
	 * createChildFile(创建切分文件夹)
	 * @param sourceUrl
	 * @param name
	 * @return
	 */
	private File createChildFile(String sourceUrl, String name) {
		File file = new File(sourceUrl);
		String fileName = "";
		if (file != null && file.exists()) {
			String tempName = file.getName();
			fileName = tempName.substring(0, tempName.lastIndexOf("."));
		}
		//这个文件夹这样命名是规定好的，如果要改，必须在service中也要改这个文件夹名，因为两边保持了一致，两个地方约束好的（BudgetFileServiceImpl--拆分后）
		String splitDir = file.getParent() +File.separator+ fileName+"拆分后";
		File splitDirFile = new File(splitDir);
		if (!splitDirFile.exists()) {
			splitDirFile.mkdir();
		}
		String splitFileUrl = splitDir + File.separator + fileName + "(" + name + ").xls";
		File splitFile = new File(splitFileUrl);
		return splitFile;
	}
	
	/**
	 * 
	 *<b>Summary:</b>
	 * removeRow(删除一行,poi中只能一行一行的删除)
	 * @param sheet
	 * @param rowIndex
	 */
	private void removeRow(HSSFSheet sheet, int rowIndex ) {
		int lastRowNum = sheet.getLastRowNum();
		if (rowIndex >= 0 && rowIndex < lastRowNum){
			unMergedCell(sheet,rowIndex,0);
			sheet.shiftRows(rowIndex + 1, lastRowNum, -1,true,true);// 删除行，并上移
		}
		if (rowIndex == lastRowNum) {
			HSSFRow removingRow = sheet.getRow(rowIndex);
			if (removingRow != null)
				sheet.removeRow(removingRow);
		}
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * unMergedCell(取消合并行，如果有合并的，先取消合并再删除，不然会报错)
	 * @param sheet
	 * @param rowIndex
	 * @param colIndex
	 */
	private void unMergedCell(HSSFSheet sheet, int rowIndex, int colIndex) {
	    int num = sheet.getNumMergedRegions();
	    for(int i = 0; i < num; i++) {
	        CellRangeAddress range = sheet.getMergedRegion(i);
	        //System.out.println(range.getFirstRow()+" "+range.getLastRow()+" "+range.getFirstColumn()+" "+range.getLastColumn());
	        if(range.getFirstColumn() == colIndex && range.getFirstRow() == rowIndex) {
	           sheet.removeMergedRegion(i) ;
	           break;
	        }
	    }
	}
	/**
	 * 
	*<b>Summary: 将cell中的公式去掉，取表现值</b>
	* changeFormulaToString()
	* @param wb
	* @param sheet
	* @return
	 */
	private HSSFWorkbook changeFormulaToString(HSSFWorkbook wb,HSSFSheet sheet){
		for(int i = 0;i<sheet.getLastRowNum();i++){
			HSSFRow row = sheet.getRow(i);
			for(int j = 0;j<row.getLastCellNum();j++){
				HSSFCell cell = row.getCell(j);
				if(cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA){
					double value = cell.getNumericCellValue();
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(value);
				}
			}
		}
		return wb;
	}
}
