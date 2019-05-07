package com.chinacreator.xtbg.core.task.dao.imploracle;

import java.io.File;
import java.sql.Connection;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.task.dao.TasksReportDao;
import com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
/**
 * 
 *<p>Title:TaskTJDaoExcelImpl.java</p>
 *<p>Description:任务交办任务统计导出Excel类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-4-3
 */
public class TaskTJDaoExcelImpl extends BusiExcelToData {
	public static final Logger LOG = Logger
			.getLogger(TaskTJDaoExcelImpl.class.getName());
	
	TasksReportDao tasksReportDao = new TasksReportDaoImpl();
	
	public TaskTJDaoExcelImpl(){
		
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
			String[] useridArry = (params.get("userids")).split(",");
			String start_time = params.get("start_time");             //查询的开始时间
			String end_time = params.get("end_time");                 //查询的结束时间
			TasksReportDao tasksReportDao = new TasksReportDaoImpl();
			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath);
			String[] times = new String[5];
			times[3] = "统计区间：";
			times[4] = start_time+" - "+end_time;   //第5列
			
			poiExcelUtil.writeLine(1, times);//从模版的第二行 写入
			poiExcelUtil.writeExcelToPath(tempExportFilePath1);
			
			for(int i=0 ; i < useridArry.length; i++){
				String userid = useridArry[i];
				TaskBaseInfoBean taskBaseInfoBean = tasksReportDao.findTasksTJBean(userid);

				if(!StringUtil.nullOrBlank(taskBaseInfoBean.getReceive_username())){
					String[] values = new String[5];
					values[0] = ""+(i+1);
					values[1] = taskBaseInfoBean.getReceive_orgname();
					values[2] = taskBaseInfoBean.getReceive_username();
					values[3] = taskBaseInfoBean.getOverno();
					values[4] = taskBaseInfoBean.getOvernumber();
					
					poiExcelUtil.writeLine(3+i, values);//从模版的第四行开始 写入
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
