package com.chinacreator.xtbg.core.archive.common;

import java.io.File;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;

import com.chinacreator.xtbg.core.archive.entity.ExcelBean;
import com.chinacreator.xtbg.core.archive.entity.ExcelDetailBean;

public class SpliteUtil {
	/**
	 *<b>Summary:</b>
	 * createChildFile(创建切分文件夹)
	 * @param sourceUrl
	 * @param name
	 * @return
	 */
	public static File createChildFile(String sourceUrl, String name) {
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
	public static void removeRow(HSSFSheet sheet, int rowIndex,int colIndex) {
		int lastRowNum = sheet.getLastRowNum();
		if (rowIndex >= 0 && rowIndex < lastRowNum){
			unMergedCell(sheet, rowIndex, colIndex);
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
	 * @param rowIndex	(需要合并的区域的起始行)
	 * @param colIndex	(需要合并的区域的起始列。比如:合并市州，只需要合并第一列的合并区域，此值为0，合并区县此值为1)
	 */
	public static void unMergedCell(HSSFSheet sheet, int rowIndex, int colIndex) {
		int num = sheet.getNumMergedRegions();
	    for(int i = 0; i < num; i++) {
	        CellRangeAddress range = sheet.getMergedRegion(i);
	        if((range.getFirstColumn() <= colIndex) && (range.getFirstRow() == rowIndex)) {
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
	public static HSSFWorkbook changeFormulaToString(HSSFWorkbook wb,HSSFSheet sheet){
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
	
	public static ExcelDetailBean getDetailBean(HSSFRow row,ExcelBean excelBean){
		ExcelDetailBean bean = new ExcelDetailBean();
		List<String> headers = excelBean.getHeaders();
		//从第二列开始
		for(int i=1;i<headers.size();i++){
			HSSFCell cell = row.getCell(i);
			if(cell != null){
				if(Constants.area.equals(headers.get(i))){
					//如果区县没有数据，说明这个是市州，需要写area数据
					if(excelBean.getArea() == null || "".equals(excelBean.getArea())){
						bean.setArea(cell.getStringCellValue());
					}
				}else if(Constants.projectName.equals(headers.get(i))){
					bean.setProjectName(cell.getStringCellValue());
				} else if(Constants.amount.equals(headers.get(i))){
					bean.setAmount(cell.getNumericCellValue());
				} else if(Constants.remark.equals(headers.get(i))){
					bean.setRemark(cell.getStringCellValue());
				} else if(Constants.functionItem.equals(headers.get(i))){
					bean.setFunctionItem(cell.getStringCellValue());
				} else if (Constants.economyItem.equals(headers.get(i))){
					bean.setEconomyItem(cell.getStringCellValue());
				}
			}
		}
		return bean;
	}
}