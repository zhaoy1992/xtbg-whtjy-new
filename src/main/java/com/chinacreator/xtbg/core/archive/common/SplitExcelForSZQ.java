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
import org.apache.poi.ss.util.CellRangeAddress;

import com.chinacreator.xtbg.core.archive.entity.ExcelBean;
import com.chinacreator.xtbg.core.archive.entity.ExcelDetailBean;
import com.chinacreator.xtbg.core.archive.entity.SplitUnitBean;
import com.chinacreator.xtbg.core.archive.service.SplitUnitService;
import com.chinacreator.xtbg.core.archive.service.impl.SplitUnitServiceImpl;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;
/**
 *<p>Title:SplitExcelForSZ.java</p>
 *<p>Description:指标文拆分--拆市州区模板</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *2014-4-16
 */
public class SplitExcelForSZQ implements SplitExcel {
	private SplitUnitService service = new SplitUnitServiceImpl();
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
					getAreaList(bean, list, sheet);
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
					getAreaList(bean, list, sheet);
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
					getAreaList(bean, list, sheet);
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
			SpliteUtil.removeRow(sheet, bean.getEndRowNum()+1,1);
		}
		//从录入的起始行开始删除
		int tmpRowLength = bean.getStartRowNum()-startNum;	//得到要删除的行数
		for(int i = 0;i<tmpRowLength;i++){
			SpliteUtil.removeRow(sheet, startNum,1);
		}
		sheet.createFreezePane(0, sheet.getLastRowNum()+1);	//冻结操作后的数据，防止出现滚动条
		
		bean = getDetail(bean,sheet);
		System.out.println(bean);
		
		//如果是区县，需要手动合并第一列
		if(bean.getTitle().equals(bean.getArea())){
			SpliteUtil.unMergedCell(sheet,startNum+1,0);
			sheet.getRow(startNum).getCell(0).setCellValue(bean.getCity());
			sheet.addMergedRegion(new CellRangeAddress(startNum, startNum+bean.getTotalNum()-1, 0, 0));
		}
		
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
		System.out.println("--->"+sourceFilePath+" 指标文开始拆分,共需要拆分文件："+list.size()+" 个！");
		System.out.println(list);
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
		String tempArea = "";
		for (int i = startNum; i < startNum+bean.getTotalNum(); i++) {
			ExcelDetailBean detailBean = new ExcelDetailBean();
			HSSFRow row = sheet.getRow(i);
			if (row == null) {
				continue;
			}
			String areaStr = row.getCell(1).getStringCellValue();	//区县数据
			tempArea = "".equals(areaStr) ? tempArea : areaStr;
			detailBean = SpliteUtil.getDetailBean(row,bean);
			detailBean.setCity(bean.getCity());
			if(detailBean.getArea() == null || "".equals(detailBean.getArea())){
				if(bean.getArea() == null || "".equals(bean.getArea())){
					detailBean.setArea(tempArea);
				} else {
					detailBean.setArea(bean.getArea());
				}
			}
			if(detailBean.getAmount() != 0){	//金额等于0的，不加入到列表，因为有些excel程序读出来的行大于实际行，所以得到的所有数据为空
				detailList.add(detailBean);				
			}
		}
		
		List<ExcelDetailBean> list = new ArrayList<ExcelDetailBean>();
		list.addAll(detailList);
		//再次循环解析出来的数据，去除小计行，去掉已维护的区县行。（只对市州的数据操作）
		if(bean.getTitle().equals(bean.getCity())){
			if(detailList.size() > 0){	//大于一行的数据才去按条件删除
				for(ExcelDetailBean detailBean : detailList){
					//过滤第一行数据
					if(detailBean.getArea().contains("小计")){
						list.remove(detailBean);
					}
					//过滤用户录入的单位，excel拆分只拆分用户规定的单位(过滤区县，保留市本级)
					ResultMap<ResultCode, SplitUnitBean> result = service.getByUnitName(detailBean.getArea());
					if(result.getCode().equals(ResultCode.OK)){
						list.remove(detailBean);
					}
				}
			}
		}
		bean.setList(list);
		return bean;
	}
	
	private List<ExcelBean> getAreaList(ExcelBean bean,List<ExcelBean> list,HSSFSheet sheet){
		//获取要拆分的数据
		ExcelBean bean2 = null;
		String tempValue = "";
		int startRowNum = 0;
		//循环表格 解析
		for (int r = bean.getStartRowNum(); r <= bean.getEndRowNum(); r++) {
			HSSFRow row = sheet.getRow(r);
			if (row == null) {
				continue;
			}
			HSSFCell cell1 = row.getCell(1);	//区（这个是取第二列的数据）
			int rowNum = row.getRowNum();
			String titleValue = cell1.getStringCellValue();
			//组装list
			if (titleValue != null && !"".equals(titleValue.trim())) {
				if (!"".equals(tempValue)) {
					bean2 = new ExcelBean();
					bean2.setAllItemSame(bean.isAllItemSame());
					bean2.setHeaders(bean.getHeaders());
					bean2.setTitle(tempValue.trim());
					bean2.setCity(bean.getCity());
					bean2.setArea(tempValue.trim());
					bean2.setStartRowNum(startRowNum);
					bean2.setEndRowNum(rowNum - 1);
					bean2.setTotalNum(rowNum - startRowNum);
					
					list.add(bean2);
				}
				startRowNum = row.getRowNum();
				tempValue = titleValue;
				if (rowNum == bean.getEndRowNum()) { // 解析有值的最后一行，也就是只有一行数值的最后一行
					bean2 = new ExcelBean();
					bean2.setAllItemSame(bean.isAllItemSame());
					bean2.setHeaders(bean.getHeaders());
					bean2.setTitle(tempValue.trim());
					bean2.setCity(bean.getCity());
					bean2.setArea(tempValue.trim());
					bean2.setStartRowNum(startRowNum);
					bean2.setEndRowNum(rowNum);
					bean2.setTotalNum(1);
					list.add(bean2);
				}
			} else if (titleValue != null && "".equals(titleValue.trim())) {
				if (rowNum  == bean.getEndRowNum()) { // 解析最后一行
					bean2 = new ExcelBean();
					bean2.setAllItemSame(bean.isAllItemSame());
					bean2.setHeaders(bean.getHeaders());
					bean2.setTitle(tempValue);
					bean2.setCity(bean.getCity());
					bean2.setArea(tempValue.trim());
					bean2.setStartRowNum(startRowNum);
					bean2.setEndRowNum(rowNum);
					bean2.setTotalNum(rowNum - startRowNum);
					list.add(bean2);
					startRowNum = row.getRowNum();
					tempValue = titleValue;
				}
			}
		}
		return list;
	}
}