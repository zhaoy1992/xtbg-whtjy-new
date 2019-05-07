
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ElectTJDaoExcelImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-7-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.suxian.electroniccheck.data;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectInfoDaoImpl;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoCountSearchBean;

/**
 *<p>Title:ElectTJDaoExcelImpl.java</p>
 *<p>Description:考勤数据导出</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-7-8
 */
public class ElectTJDaoExcelImpl extends BusiExcelToData{

	public static final Logger LOG = Logger.getLogger(ElectTJDaoExcelImpl.class.getName());
	
	private ElectInfoDaoImpl electInfoDaoImpl = new ElectInfoDaoImpl();
	
	
	public ElectTJDaoExcelImpl(){
		
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
			int count =2;
			ElectInfoCountSearchBean bean = new ElectInfoCountSearchBean();
			if (!StringUtil.isBlank(params.get("parmjson")) ) {
				String parmjson = DataControlUtil.replaceStr(params.get("parmjson"));
				parmjson = Escape.unescape(parmjson); 
				bean = (ElectInfoCountSearchBean) JSONObject.parseObject(parmjson, ElectInfoCountSearchBean.class);
			}
			
			List<ElectInfoCountSearchBean> persionList = electInfoDaoImpl.findCountExcelInfoList(bean);
			poiExcelUtil.write(4,1, bean.getStart_time());// 开始时间
			poiExcelUtil.write(7,1, bean.getEnd_time());// 结束时间
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
			//用户名称不为空
			if(persionList.size() >0){
				//持证信息
				for (int m = 0; m < persionList.size(); m++) {
					//行
					count ++;
					//考勤信息
					ElectInfoCountSearchBean searchBean =persionList.get(m); 
					String[] values = new String[19];
					values[0] =  StringUtil.deNull(searchBean.getOrgname());//部门名称
					values[1] =  StringUtil.deNull(searchBean.getUsername());//人员
					values[2] =  StringUtil.deNull(searchBean.getZccount());//正常
					values[3] = StringUtil.deNull(searchBean.getWqcount());//外勤
					values[4] =  searchBean.getQjcount();//请假
					values[5] =  searchBean.getSjcount();//事假
					values[6] =  searchBean.getNxjcount();//年休假
					values[7] =  searchBean.getXxpxjcount();//学习培训假
					values[8] =  searchBean.getGcjcount();//公差假
					values[9] =  searchBean.getBsjcount();//病伤假
					values[10] =  searchBean.getCjcount();//产假
					values[11] =  searchBean.getGsjcount();//工伤假
					values[12] =  searchBean.getHjcount();//婚假
					values[13] =  searchBean.getCdcount();//迟到
					values[14] =  searchBean.getJhsyjcount();//计划生育假
					values[15] =  searchBean.getSajcount();//丧假
					values[16] =  searchBean.getZtcount();//早退
					values[17] =  searchBean.getCdztcount();//迟到并早退
					values[18] =  searchBean.getKgcount();//矿工
					poiExcelUtil.writeLine(count, values,cellstyle);// 从模版的第二行开始 写入
				}
			}
			poiExcelUtil.writeExcelToPath(tempExportFilePath1);
		}catch(Exception e){
			LOG.error(e.getMessage());
		}
	return tempExportFilePath1;
	}
}
