package com.chinacreator.xtbg.core.archive.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.chinacreator.xtbg.core.archive.entity.ExcelBean;
import com.chinacreator.xtbg.core.archive.entity.ExcelDetailBean;
import com.chinacreator.xtbg.core.archive.entity.SplitUnitBean;
import com.chinacreator.xtbg.core.archive.service.SplitUnitService;
import com.chinacreator.xtbg.core.archive.service.impl.SplitUnitServiceImpl;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;
/**
 *<p>Title:SplitExcelForSZ.java</p>
 *<p>Description:指标文拆分--拆市州模板</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *2014-4-16
 */
public class SplitExcelForSZ implements SplitExcel {
	private int startNum = 0;	//标题行数，这些行将不会被解析
	@Override
	public void init(int startNum) {
		this.startNum = startNum;
	}

	@Override
	public List<ExcelBean> beforSplit(String filename) throws Exception {
		List<ExcelBean> list = new ArrayList<ExcelBean>();
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(filename));
		HSSFSheet sheet = wb.getSheetAt(0);
		int rows = sheet.getPhysicalNumberOfRows();
		
		//解析标题行，表头
		HSSFRow headRrow = sheet.getRow(startNum - 1);
		List<String> headers = new ArrayList<String>();
		boolean isAllItemSame = true;
		for(int i = 0;i<headRrow.getPhysicalNumberOfCells();i++){
			String item = headRrow.getCell(i).getStringCellValue();
			headers.add(item);
			//如果所有功能分类和经济分类都相同，将没这两列，否则如果有这两列，则isAllItemSame返回false
			if(Constants.functionItem.equals(item) || Constants.economyItem.equals(item)){
				isAllItemSame = false;
			}
		}
		//获取要拆分的数据
		ExcelBean bean = null;
		String tempValue = "";
		int startRowNum = 0;
		//循环表格 解析
		for (int r = startNum; r <= rows; r++) {
			HSSFRow row = sheet.getRow(r);
			if (row == null) {
				continue;
			}
			HSSFCell cell0 = row.getCell(0);	//市
			int rowNum = row.getRowNum();
			String titleValue = cell0.getStringCellValue();
			//组装list
			if (titleValue != null && !"".equals(titleValue.trim())) {
				if (!"".equals(tempValue)) {
					bean = new ExcelBean();
					bean.setAllItemSame(isAllItemSame);
					bean.setHeaders(headers);
					bean.setTitle(tempValue.trim());
					bean.setCity(tempValue.trim());
					bean.setStartRowNum(startRowNum);
					bean.setEndRowNum(rowNum - 1);
					bean.setTotalNum(rowNum - startRowNum);
					
					list.add(bean);
				}
				startRowNum = row.getRowNum();
				tempValue = titleValue;
				if (rowNum + 1 == rows) { // 解析有值的最后一行，也就是只有一行数值的最后一行
					bean = new ExcelBean();
					bean.setAllItemSame(isAllItemSame);
					bean.setHeaders(headers);
					bean.setTitle(tempValue);
					bean.setCity(tempValue.trim());
					bean.setStartRowNum(startRowNum);
					bean.setEndRowNum(rowNum);
					bean.setTotalNum(1);
					list.add(bean);
				}
			} else if (titleValue != null && "".equals(titleValue.trim())) {
				if (rowNum + 1 == rows) { // 解析最后一行
					bean = new ExcelBean();
					bean.setAllItemSame(isAllItemSame);
					bean.setHeaders(headers);
					bean.setTitle(tempValue);
					bean.setCity(tempValue.trim());
					bean.setStartRowNum(startRowNum);
					bean.setEndRowNum(rowNum);
					bean.setTotalNum(rowNum - startRowNum);
					list.add(bean);
				}
			}
		}
		return list;
	}

	@Override
	public ExcelBean spliting(String sourceUrl,ExcelBean bean)throws Exception  {
		System.out.println("拆分文件--->"+bean);
		FileInputStream is = new FileInputStream(sourceUrl);
		HSSFWorkbook workbook = new HSSFWorkbook(is);
		HSSFSheet sheet = workbook.getSheetAt(0);
		
		SpliteUtil.changeFormulaToString(workbook,sheet);
		
		int lastRowNum = sheet.getLastRowNum();
		//先从这个数据的下面开始删除
		for(int i = bean.getEndRowNum();i <= lastRowNum;i++){
			SpliteUtil.removeRow(sheet, bean.getEndRowNum()+1,0);
		}
		//从录入的起始行开始删除
		int tmpRowLength = bean.getStartRowNum()-startNum;	//得到要删除的行数
		for(int i = 0;i<tmpRowLength;i++){
			SpliteUtil.removeRow(sheet, startNum,0);
		}
		sheet.createFreezePane(0, sheet.getLastRowNum()+1);	//冻结操作后的数据，防止出现滚动条
		
		bean = getDetail(bean,sheet);
		System.out.println(bean);
		
		File childFile = SpliteUtil.createChildFile(sourceUrl,bean.getTitle());
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

	@Override
	public ExcelBean afterSplit()throws Exception  {
		return null;
	}

	@Override
	public List<ExcelBean> split(int startNum, String sourceFilePath) throws Exception {
		init(startNum);
		
		List<ExcelBean> excelBeanList = new ArrayList<ExcelBean>();
		List<ExcelBean> list = beforSplit(sourceFilePath);
		SplitUnitService service = new SplitUnitServiceImpl();
		System.out.println("--->"+sourceFilePath+" 指标文开始拆分,共需要拆分文件："+list.size()+" 个！");
		for(ExcelBean bean : list){
			//过滤用户录入的单位，excel拆分只拆分用户规定的单位
			ResultMap<ResultCode, SplitUnitBean> result = service.getByUnitName(bean.getTitle());
			if(result.getCode().equals(ResultCode.OK)){
				ExcelBean excelBean = spliting(sourceFilePath, bean);
				excelBean.setUnit_id(result.getResult().getUnit_id());
				excelBeanList.add(excelBean);
			} else {
				//excelBeanList.clear();	//如果一旦发现有还未维护的单位，跳出循环，设置list为空
				//break;
			}
		}
		return excelBeanList;
	}
	
	/**
	*<b>Summary: 获取详细数据</b>
	* getDetail()
	* @param bean
	* @param sheet
	* @return
	 */
	private ExcelBean getDetail(ExcelBean bean,HSSFSheet sheet){
		List<ExcelDetailBean> detailList = new ArrayList<ExcelDetailBean>();
		//循环表格 解析
		for (int i = startNum; i < startNum+bean.getTotalNum(); i++) {
			ExcelDetailBean detailBean = new ExcelDetailBean();
			HSSFRow row = sheet.getRow(i);
			if (row == null) {
				continue;
			}
			
			detailBean = SpliteUtil.getDetailBean(row,bean);
			detailBean.setCity(bean.getTitle());
			detailList.add(detailBean);
		}
		bean.setList(detailList);
		return bean;
	}
}