package com.chinacreator.xtbg.tjy.officesupplies.data;


import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegObjectBean;

/**
 * 办公用品领用表
 * @author 王淑滨
 *
 */
public class OsHavaLyOrgExcelToData2 {
	public static final Logger LOG = Logger
			.getLogger(OsHavaLyOrgExcelToData.class.getName());
	private String exportTemplateFilePath = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam("bgyply_excelTemplateFilePath");//导出模版所在路径
	private String tempExportFilePath = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam("tempExcelFilePath");//导出临时文件所在位置
	private POIExcelUtil poiExcelUtil = null;
	public OsHavaLyOrgExcelToData2(){
		
	}
	/**
	 * 
	*<b>Summary: </b>
	* exportExcelToData(根据传入的用户id数组，查询相应的人员信息并生成excel到指定路径，最后成功返回该路径)
	* @param useridArry 用户id数组
	* @return
	 */
	public String exportExcelToData(List<Map<String,String>> list){
		try{
			tempExportFilePath += System.currentTimeMillis()+".xls";

			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath);
			poiExcelUtil.write(4,2,DateUtil.getCurrentDateString("yyyy-MM-dd"));
			poiExcelUtil.write(1,2,list.get(0).get("org_name"));
			
			int count = 6;
			for(int i=0;i<list.size();i++){
				Map<String,String> map = list.get(i);
				if(!StringUtil.nullOrBlank(map.get("ofustype_name"))){
					count++;
					String[] values = new String[5];
					values[0] = Integer.toString(count - 6);
					values[1] = map.get("ofustype_name");
					values[2] = "个";
					values[3] = map.get("t_osappreg_ob_no");
					values[4] = map.get("it_name");
					poiExcelUtil.writeLine(count, values);// 从模版的第五行开始 写入
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
