package com.chinacreator.xtbg.core.personholder.data;

import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.constant.DirectoryConstant;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.dao.imploracle.DirectoryDaoImpl;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao;
import com.chinacreator.xtbg.core.personholder.dao.imploracle.PersonHolderDaoImpl;
import com.chinacreator.xtbg.core.personholder.entity.TrainBean;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;

/**
 * 人员持证综合信息
 * @author Administrator
 *
 */
public class HolderDaoExcelImpl extends BusiExcelToData{
	
	public static final Logger LOG = Logger.getLogger(HolderDaoExcelImpl.class.getName());
	
	private PersonHolderDao personholderdao = new PersonHolderDaoImpl();
	
	private DirectoryDao directoryDao = new DirectoryDaoImpl();
	
	public HolderDaoExcelImpl(){
		
	}
	
	/**
	* 
	*<b>Summary: </b>
	* exportExcelToData(根据传入的用户id数组，查询相应的人员信息并生成excel到指定路径，最后成功返回该路径)
	* @param useridArry 用户id数组
	* @return
	*/
	public String exportExcelToData(Map<String,String> params){
		
	String tempExportFilePath1 = getTempExportFilePath()+System.currentTimeMillis()+".xls";
		
	try {

			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath.trim());
			//写入excel行
			DirectoryBean directoryBean = directoryDao.getTypeBeanById(
					params.get("userids"), "view");
			//用户名称不为空
			if (!StringUtil.nullOrBlank(directoryBean.getDirectoryname())) {
				String name = directoryBean.getDirectoryname();//姓名
				String job_no =directoryBean.getNew_job_no();//工号
				String org_name = directoryBean.getDepartment();//所在部门
				
				poiExcelUtil.write(1,0, job_no);// 工号
				poiExcelUtil.write(3,0, name);// 姓名
				poiExcelUtil.write(6,0, org_name);// 所在部门
				String education = directoryBean.getEducation();//第一学历
				String new_first_zy = directoryBean.getNew_first_zy();//专业
				String school = directoryBean.getSchool();//毕业院校
				
				poiExcelUtil.write(1,1, education);// 第一学历
				poiExcelUtil.write(4,1, new_first_zy);// 专业
				poiExcelUtil.write(7,1, school);// 毕业院校
				
				String new_zg_xl = directoryBean.getNew_zg_xl();//最高学历
				String new_zg_zy = directoryBean.getNew_zg_zy();//最高专业
				String new_zg_byyx = directoryBean.getNew_zg_byyx();//最高毕业院校
				poiExcelUtil.write(1,2, DirectoryConstant.parseEducation(new_zg_xl,true));//最高学历
				poiExcelUtil.write(4,2, new_zg_zy);// 最高专业
				poiExcelUtil.write(7,2, new_zg_byyx);// 最高毕业院校
				
				String new_jszc = directoryBean.getNew_jszc();//职称
				String new_zc_getdate = directoryBean.getNew_zc_getdate();//职称获取时间
				poiExcelUtil.write(1,3, DirectoryConstant.parseNewjszc(new_jszc,true));// 职称
				poiExcelUtil.write(4,3, new_zc_getdate);// /职称获取时间
				
				List<Map<String,String>> persionList = personholderdao.selPersonHolderData(params.get("userids"));
				CellStyle persionCellstyle = poiExcelUtil.getWorkbook().createCellStyle();
				Font persionFont = poiExcelUtil.getWorkbook().createFont();    
				persionFont.setFontName("宋体");    
				persionFont.setFontHeightInPoints((short) 10);//设置字体大小    
				persionCellstyle.setAlignment(CellStyle.ALIGN_CENTER); 
				persionCellstyle.setBorderRight(CellStyle.BORDER_THIN);
				persionCellstyle.setBorderLeft(CellStyle.BORDER_THIN);
				persionCellstyle.setBorderBottom(CellStyle.BORDER_THIN);
				persionCellstyle.setWrapText(true);
				persionCellstyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
				persionCellstyle.setFont(persionFont);
				if(persionList.size() >0){
					//持证信息
					for (int m = 0; m < persionList.size(); m++) {
						//行
						String[] values = new String[9];
						//持证信息
						Map<String,String> persionMap =(Map<String,String>)persionList.get(m); 
						values[0] =  persionMap.get("hold_name");//持证项目
						values[1] =  DirectoryConstant.parseDirectoryhold_org(persionMap.get("hold_org"),true);//审批机构
						values[2] =  persionMap.get("hold_number");//证书编号
						values[3] =  persionMap.get("hold_ratifytime");//取证日期
						values[4] =  persionMap.get("hold_validtime");//有效日期
						values[5] =  persionMap.get("hold_replactime");//换证日期
						values[6] =  StringUtil.deNull(persionMap.get("hold_remark"));//备注
						values[7] =  "";//备注
						values[8] =  "";//备注
						
						poiExcelUtil.writeLine(m+5, values,persionCellstyle);// 从模版的第二行开始 写入
					}
				}
				//培训记录表头
				//行
				CellStyle cellstyle = poiExcelUtil.getWorkbook().createCellStyle();
				Font font = poiExcelUtil.getWorkbook().createFont();    
				font.setFontName("宋体");    
				font.setFontHeightInPoints((short) 12);//设置字体大小    
				font.setBoldweight(Font.BOLDWEIGHT_BOLD);
				cellstyle.setAlignment(CellStyle.ALIGN_CENTER); 
				cellstyle.setBorderRight(CellStyle.BORDER_THIN);
				cellstyle.setBorderLeft(CellStyle.BORDER_THIN);
				cellstyle.setBorderBottom(CellStyle.BORDER_THIN);
				cellstyle.setWrapText(true);
				cellstyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
				cellstyle.setFont(font);
				String[] values = new String[9];
				values[0] =  "培训类型";//培训
				values[1] =  "培训课时";//培训课时
				values[2] =  "培训主题";//培训主题
				values[3] =  "培训地点";//培训地点
				values[4] =  "证件名称";//证件名称
				values[5] =  "培训单位";//培训单位
				values[6] =  "培训成绩";//培训成绩
				values[7] =  "考核成绩";//考核成绩
				values[8] =  "培训\n费用";//培训费用
				poiExcelUtil.writeLine(persionList.size()+5, values,cellstyle);// 从模版的第二行开始 写入
				
				//培训记录数据
				TrainBean trainbean = new TrainBean();
				trainbean.setTr_usersn(params.get("userids"));
				List<Map<String,String>> trainList = personholderdao.selPersonTrainData(trainbean);
				
				CellStyle cellstyle1 = poiExcelUtil.getWorkbook().createCellStyle();
				Font trainFont = poiExcelUtil.getWorkbook().createFont();    
				trainFont.setFontName("宋体");    
				trainFont.setFontHeightInPoints((short) 10);//设置字体大小    
				cellstyle1.setAlignment(CellStyle.ALIGN_CENTER); 
				cellstyle1.setBorderRight(CellStyle.BORDER_THIN);
				cellstyle1.setBorderLeft(CellStyle.BORDER_THIN);
				cellstyle1.setBorderBottom(CellStyle.BORDER_THIN);
				cellstyle1.setWrapText(true);
				cellstyle1.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
				cellstyle1.setFont(trainFont);
				for (int m = 0; m < trainList.size(); m++) {
					String[] valuesdate = new String[9];
					//持证信息
					Map<String,String> trainMap =(Map<String,String>)trainList.get(m); 
					valuesdate[0] =  DirectoryConstant.parseTrain_level(trainMap.get("tr_level"),true);//是否专业
					valuesdate[1] =  trainMap.get("tr_hour");//培训课时
					valuesdate[2] =  trainMap.get("tr_title");//培训主题
					valuesdate[3] =  trainMap.get("tr_address");//地点
					valuesdate[4] =  trainMap.get("tr_name");//证件名称
					valuesdate[5] =  trainMap.get("tr_unit");//培训单位
					valuesdate[6] =  trainMap.get("tr_results");//培训成绩
					valuesdate[7] =  trainMap.get("tr_assess");//考核成绩
					valuesdate[8] =  trainMap.get("tr_money");//培训费用
					poiExcelUtil.writeLine(persionList.size()+5+ m+1, valuesdate,cellstyle1);// 从模版的第二行开始 写入
				}
			}
			poiExcelUtil.writeExcelToPath(tempExportFilePath1);
		
		}catch(Exception e){
			LOG.error(e.getMessage());
		}
	return tempExportFilePath1;
	}
}
