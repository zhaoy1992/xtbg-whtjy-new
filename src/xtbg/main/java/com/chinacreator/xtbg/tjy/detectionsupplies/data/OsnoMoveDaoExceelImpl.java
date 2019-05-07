
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsnoMoveDaoExceelImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-7-11   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.detectionsupplies.service.OsHavaObjectService;
import com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OsHavaObjectServiceImpl;

/**
 *<p>Title:OsnoMoveDaoExceelImpl.java</p>
 *<p>Description:固定资产领用审批表-打印</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-7-11
 */
public class OsnoMoveDaoExceelImpl extends BusiExcelToData{
	
	public static final Logger LOG = Logger.getLogger(OsnoMoveDaoExceelImpl.class.getName());
	
	private OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	
	private OsPlanDataDaoImpl osplandatadaoimpl = new OsPlanDataDaoImpl();
	
	public OsnoMoveDaoExceelImpl(){
		
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
				Map<String,String> objPlan = osplandatadaoimpl.getOsnoMove(params.get("busi_id"));
				//写入excel行
				//用户名称不为空
				if (!StringUtil.nullOrBlank(objPlan.get("t_osnom_org_name"))) {
					//填报时间
					String t_osnom_date = objPlan.get("t_osnom_date");
					poiExcelUtil.write(3,2,t_osnom_date.toString());
					
					//部门
					String t_osnom_org_name = objPlan.get("t_osnom_org_name");
					poiExcelUtil.write(1,2,t_osnom_org_name);
					
					//部门负责人 意见
					String t_osnom_bmfzryj = objPlan.get("t_osnom_bmfzryj");
					poiExcelUtil.write(1,3,t_osnom_bmfzryj);
					
					//领取人
					String t_osnom_user_name = objPlan.get("t_osnom_user_name");
					poiExcelUtil.write(4,3,t_osnom_user_name);
					
					//办公室负责人
					String t_osnom_bgsfzryj = objPlan.get("t_osnom_bgsfzryj");
					poiExcelUtil.write(1,4,t_osnom_bgsfzryj);
					
					//主管领导审核意见
					String t_osnom_zgldyj = objPlan.get("t_osnom_zgldyj");
					poiExcelUtil.write(1,5,t_osnom_zgldyj);
					
					//院长审核意见
					String t_osnom_yzyj = objPlan.get("t_osnom_yzyj");
					poiExcelUtil.write(1,6,t_osnom_yzyj);
					
					List<Map<String,String>> listItems = osHavaObjectService.queryNoMoveObjectForRegId(params.get("busi_id"));
					
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
							
							String oftype_name =  items.get("oftype_name");//类别
							poiExcelUtil.write(0,9+m,oftype_name,cellstyle);
							
							String it_name =  items.get("it_name");//规格型号
							poiExcelUtil.write(1,9+m,it_name,cellstyle);
							
							String ofustype_name =  items.get("ofustype_name");//名称
							poiExcelUtil.write(2,9+m,ofustype_name,cellstyle);
							
							String t_ha_sbno =  items.get("t_ha_sbno");// 设备编号
							poiExcelUtil.write(3,9+m,t_ha_sbno,cellstyle);
							
							String t_nomove_ob_bz =  items.get("t_nomove_ob_bz");// 备    注
							poiExcelUtil.write(4,9+m,t_nomove_ob_bz,cellstyle);
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