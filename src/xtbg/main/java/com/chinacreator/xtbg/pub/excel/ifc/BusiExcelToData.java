package com.chinacreator.xtbg.pub.excel.ifc;

import java.util.Map;

import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;

/**
 * 
 *<p>Title:BusiExcelToData.java</p>
 *<p>Description:导入导出excel业务数据接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2014-3-16
 */
public abstract class BusiExcelToData {
	protected String exportTemplateFilePath = "";//导出模版所在路径
	protected String tempExportFilePath = "";//导出临时文件所在位置
	protected POIExcelUtil poiExcelUtil = null;
	
	protected String outStr = "";
	protected int cgdrNumber = 0;//成功导入数量
	protected int cggxNumber = 0;//成功更新数量
	protected int drsbNumber = 0;//导入失败数量
	
	/**
	* 
	*<b>Summary: </b>
	* exportExcelToData(导出excel数据)
	* params 参数
	* @return
	*/
	public String exportExcelToData(Map<String,String> params){
		return null;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* importExcelToData(导入excel数据)
	 */
	public String importExcelToData(String filepath){
		cgdrNumber = 0;
		return null;
	}

	public String getExportTemplateFilePath() {
		return exportTemplateFilePath;
	}

	public void setExportTemplateFilePath(String exportTemplateFilePath) {
		this.exportTemplateFilePath = exportTemplateFilePath;
	}

	public String getTempExportFilePath() {
		if(StringUtil.nullOrBlank(tempExportFilePath)){
			tempExportFilePath = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam("tempExcelFilePath");
		}
		return tempExportFilePath;
	}

	public void setTempExportFilePath(String tempExportFilePath) {
		this.tempExportFilePath = tempExportFilePath;
	}
	
	
}
