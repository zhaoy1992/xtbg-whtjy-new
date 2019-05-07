package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.io.File;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService;
import com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsHavaObjectServiceImpl;
/**
 * 
 *<p>Title:OsNomoveDaoExcelImpl.java</p>
 *<p>Description:固定资产台账导出</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-4-3
 */
public class OsNomoveDaoExcelImpl extends BusiExcelToData {
	public static final Logger LOG = Logger
			.getLogger(OsNomoveDaoExcelImpl.class.getName());
	
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	
	public OsNomoveDaoExcelImpl(){
		
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
		try{
			String[] t_ha_idArry = (params.get("t_ha_ids")).split(",");
			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath);
			
			for(int i=0 ; i < t_ha_idArry.length; i++){
				String t_ha_id = t_ha_idArry[i];
				List<Map<String, String>> osHavaList = osHavaObjectService.queryHavaObjectByHaId(t_ha_id);
				Map<String, String> osHavaMap = osHavaList.get(0);

				if(!StringUtil.nullOrBlank(osHavaMap.get("oftype_name"))){
					String[] values = new String[6];
					values[0] = ""+(i+1);
					values[1] = osHavaMap.get("ofustype_name");
					values[2] = osHavaMap.get("oftype_name");
					values[3] = osHavaMap.get("it_name");
					values[4] = osHavaMap.get("t_ha_dj");
					values[5] = osHavaMap.get("t_ha_sbno");
					
					poiExcelUtil.writeLine(2+i, values);//从模版的第二行开始 写入
				}
				poiExcelUtil.writeExcelToPath(tempExportFilePath1);
			}
		}catch(Exception e){
			LOG.error(e.getMessage());
		}
		return tempExportFilePath1;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* importExcelToData(导入excel数据，user_id为空的不导入)
	 */
	public String importExcelToData(String filepath){
		Connection conn = null;
		int cggxNumber = 0;//成功更新数量
		String outStr = "";
		try {
			
		    poiExcelUtil = new POIExcelUtil(filepath);

			conn = DbManager.getInstance().getTransactionConnection();
			String[][] datas = poiExcelUtil.readSheet();//将excel中的数据全部获取出来放置在二维数组中
			for(int i = 2 ; i < datas.length; i++){//从第二行开始读取
				String[] data = datas[i];
				if(StringUtil.nullOrBlank(data[0])){
					break;
				}
				cggxNumber ++;
			}
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			LOG.error(e.getMessage());
			DbManager.closeTransactionConnection(conn, false);
		}
		outStr = outStr + "成功更新" + cggxNumber + "条记录<br>";
		return outStr;
	}
	
	public static void main(String[] args) throws Exception{
		//new DirectoryExcelToData().importExcelToData("D:\\WorkSpace\\xtbg-tjy\\creatorepp\\ccapp\\oa\\directory\\excel\\tmp\\1394358420265.xlsx");
		//new DirectoryExcelToData().exportExcelToData("3,4".split(","));
		File testFile = new File("D:/WorkSpace/xtbg-tjy/creatorepp/ccapp/oa/directory/excel/tmp/1394419886765.xls");
		testFile.delete();
	}
}
