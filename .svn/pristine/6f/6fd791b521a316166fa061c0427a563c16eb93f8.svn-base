
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsApplanDaoExcelImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-6-26   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.detectionsupplies.data;

import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
import com.chinacreator.xtbg.tjy.detectionsupplies.service.OsAppObjectService;
import com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OsAppObjectServiceImpl;
/**
 *<p>Title:OsApplanDaoExcelImpl.java</p>
 *<p>Description:申购计划表-打印</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-6-26
 */
public class OsApplanDaoExcelImpl extends BusiExcelToData{
	
	public static final Logger LOG = Logger.getLogger(OsApplanDaoExcelImpl.class.getName());
	
	private OsAppObjectService osapplanitemserviceimpl = new OsAppObjectServiceImpl();
	
	private OsPlanDataDaoImpl osplandatadaoimpl = new OsPlanDataDaoImpl();
	
	public OsApplanDaoExcelImpl(){
		
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
			Map<String,String> objPlan = osplandatadaoimpl.getOsApplyPlan(params.get("busi_id"));
			//写入excel行
			//用户名称不为空
			if (!StringUtil.nullOrBlank(objPlan.get("t_org_name"))) {
				//填报时间
				String t_creator_time = objPlan.get("t_creator_time");
				poiExcelUtil.write(3,2,t_creator_time.toString());
				
				//部门
				String t_org_name = objPlan.get("t_org_name");
				poiExcelUtil.write(1,2,t_org_name);
				
				//部门负责人 意见
				String t_bmfzyj = objPlan.get("t_bmfzyj");
				poiExcelUtil.write(1,3,t_bmfzyj);
				
				List<Map<String,String>> listItems = osapplanitemserviceimpl.selectOsAppObject(params.get("busi_id"));
				
				CellStyle cellstyle = poiExcelUtil.getWorkbook().createCellStyle(); 
				Font font = poiExcelUtil.getWorkbook().createFont();    
				font.setFontName("宋体");    
				font.setFontHeightInPoints((short) 12);//设置字体大小    
				cellstyle.setAlignment(CellStyle.ALIGN_CENTER); 
				cellstyle.setBorderLeft(CellStyle.BORDER_THIN);
				cellstyle.setBorderRight(CellStyle.BORDER_THIN);
				cellstyle.setBorderBottom(CellStyle.BORDER_THIN);
				cellstyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
				cellstyle.setFont(font);
				if(listItems.size() >0){
					//申购物品清单
					for (int m = 0; m < listItems.size(); m++) {
						//物品信息
						Map<String,String> items =(Map<String,String>)listItems.get(m); 
						
						String ofustype_name =  items.get("ofustype_name");//物品名称
						poiExcelUtil.write(0,6+m,ofustype_name,cellstyle);
						
						String it_name =  items.get("it_name");//物品规格
						poiExcelUtil.write(1,6+m,it_name,cellstyle);
						
						String t_os_ob_no =  items.get("t_os_ob_no");//物品数量
						poiExcelUtil.write(2,6+m,t_os_ob_no,cellstyle);
						
						String t_os_ob_bz =  items.get("t_os_ob_bz");//物品备注
						poiExcelUtil.write(3,6+m,t_os_ob_bz,cellstyle);
					}
				}
			}
			poiExcelUtil.writeExcelToPath(tempExportFilePath1);
		
		}catch(Exception e){
			LOG.error(e.getMessage());
			e.printStackTrace();
		}
	return tempExportFilePath1;
	}
}
