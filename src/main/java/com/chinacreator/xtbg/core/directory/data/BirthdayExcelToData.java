package com.chinacreator.xtbg.core.directory.data;

import java.io.File;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;

/**
 * 导出生日提醒
 * @author 王淑滨
 *
 */
public class BirthdayExcelToData {
	public static final Logger LOG = Logger
			.getLogger(DirectoryExcelToData.class.getName());
	private String exportTemplateFilePath = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam("brithday_excelTemplateFilePath");//导出模版所在路径
	private String tempExportFilePath = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam("directry_tempExcelFilePath");//导出临时文件所在位置
	private POIExcelUtil poiExcelUtil = null;
	private DirectoryDao directoryDao = (DirectoryDao) LoadSpringContext
			.getApplicationContext().getBean("directoryDaoImpl");
	
	private int cggxNumber = 0;//成功更新数量
	
	public BirthdayExcelToData(){
		
	}
	/**
	 * 
	*<b>Summary: </b>
	* exportExcelToData(根据传入的用户id数组，查询相应的人员信息并生成excel到指定路径，最后成功返回该路径)
	* @param useridArry 用户id数组
	* @return
	 */
	public String exportExcelToData(String[] useridArry){
		try{
			tempExportFilePath += System.currentTimeMillis()+".xls";

			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath);
			
			for(int i=0 ; i < useridArry.length; i++){
				cggxNumber ++;
				String userid = useridArry[i];
				DirectoryBean directoryBean = directoryDao.getTypeBeanById(userid,"view");

				if(!StringUtil.nullOrBlank(directoryBean.getDirectoryname())){
					String[] values = new String[4];
					values[0] = String.valueOf(cggxNumber);
					values[1] = directoryBean.getDirectoryname();
					values[2] = directoryBean.getDepartment();
					values[3] = directoryBean.getDirectoryyear();
					poiExcelUtil.writeLine(2+i, values);//从模版的第二行开始 写入
				}
				poiExcelUtil.writeExcelToPath(tempExportFilePath);
			}
		}catch(Exception e){
			LOG.error(e.getMessage());
		}
		return tempExportFilePath;
	}
		
	public String getTempExportFilePath() {
		return tempExportFilePath;
	}
	public void setTempExportFilePath(String tempExportFilePath) {
		this.tempExportFilePath = tempExportFilePath;
	}
	/**
	 * 
	*<b>Summary: </b>
	* deleteExportTempFile(删除导出临时文件)
	* @param tempExportFile
	 */
	public void deleteExportTempFile(File tempExportFile){
		if(tempExportFile.exists()){
			 tempExportFile.delete();
	    }
	}
	
	public static void main(String[] args) throws Exception{
		//new DirectoryExcelToData().importExcelToData("D:\\WorkSpace\\xtbg-tjy\\creatorepp\\ccapp\\oa\\directory\\excel\\tmp\\1394358420265.xlsx");
		//new DirectoryExcelToData().exportExcelToData("3,4".split(","));
		File testFile = new File("D:/WorkSpace/xtbg-tjy/creatorepp/ccapp/oa/directory/excel/tmp/1394419886765.xls");
		testFile.delete();
	}
}
