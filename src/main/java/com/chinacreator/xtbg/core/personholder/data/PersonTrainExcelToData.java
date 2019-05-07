
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     PersonTrainExcelToData.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-13   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.personholder.data;

import java.io.File;
import java.sql.Connection;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.constant.DirectoryConstant;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.dao.imploracle.DirectoryDaoImpl;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao;
import com.chinacreator.xtbg.core.personholder.dao.imploracle.PersonHolderDaoImpl;
import com.chinacreator.xtbg.core.personholder.entity.TrainBean;
import com.chinacreator.xtbg.core.personholder.service.TrainServiceIfc;
import com.chinacreator.xtbg.core.personholder.service.imp.TrainServiceImpl;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:PersonTrainExcelToData.java</p>
 *<p>Description:人员持证培训记录导入导出</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-13
 */
public class PersonTrainExcelToData {
	
	public static final Logger LOG = Logger .getLogger(PersonTrainExcelToData.class.getName());
	
	private String exportTemplateFilePath = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam("personTrain_excelTemplateFilePath");// 导出模版所在路径
	private String tempExportFilePath = FileUtil.getAppContextPath() + CacheCommonManageProxy.getSystemParam("personholder_tempExcelFilePath");// 导出临时文件所在位置
	private String printTemplateFilePath = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam("printTrain_excelTemplateFilePath");// 打印模版所在路径
	private POIExcelUtil poiExcelUtil = null;
	private DirectoryDao directoryDao = new DirectoryDaoImpl();
	private PersonHolderDao personholderdao = new PersonHolderDaoImpl();
	private String outStr = "";
	private int cgdrNumber = 0;// 成功导入数量
	private int cggxNumber = 0;// 成功更新数量
	private int drsbNumber = 0;// 导入失败数量

	public PersonTrainExcelToData() {

	}

	/**
	 * 
	 * <b>Summary: </b>
	 * exportExcelToData(根据传入的用户id数组，查询相应的人员持证信息并生成excel到指定路径，最后成功返回该路径)
	 * 
	 * @param useridArry
	 *            用户id数组
	 * @return
	 */
	public String exportExcelToData(String[] useridArry) {
		try {
			tempExportFilePath += System.currentTimeMillis() + ".xls";
			TrainBean trainbean = new TrainBean();
			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath);
			//写入excel行
			int count =0;
			for (int i = 0; i < useridArry.length; i++) {
				String userid = useridArry[i];
				DirectoryBean directoryBean = directoryDao.getTypeBeanById(
						userid, "view");
				//用户名称不为空
				if (!StringUtil.nullOrBlank(directoryBean.getDirectoryname())) {
					trainbean.setTr_usersn(userid);
					List<Map<String,String>> persionList = personholderdao.selPersonTrainData(trainbean);
					if(persionList.size() >0){
						//持证信息
						for (int m = 0; m < persionList.size(); m++) {
							//行
							count ++;
							String[] values = new String[19];
							values[0] = userid;//人员ID
							values[1] = directoryBean.getDepartment();//所在分院/部门
							values[2] = directoryBean.getDirectoryname();//姓名
							values[3] = directoryBean.getNew_job_no();//职工工号
							values[4] = DirectoryConstant.parsePost(directoryBean.getPost(), true);//职务名称/岗位
							values[5] =  DirectoryConstant.parseNewjszc(directoryBean.getNew_jszc(), true);//职称
							values[6] =  directoryBean.getNew_zc_getdate();//职称获得时间
							
							//持证信息
							Map<String,String> persionMap =(Map<String,String>)persionList.get(m); 
						
							values[7] =  persionMap.get("tr_id");//记录ID
							values[8] =  DirectoryConstant.parseTrain_level(persionMap.get("tr_level"),true);//是否专业
							values[9] =  persionMap.get("tr_title");//培训主题
							values[10] =  persionMap.get("tr_content");//培训内容
							values[11] =  persionMap.get("tr_time");//培训时间
							values[12] =  persionMap.get("tr_hour");//培训课时
							values[13] =  persionMap.get("tr_address");//地点
							values[14] =  persionMap.get("tr_money");//培训费用
							values[15] =  persionMap.get("tr_name");//证件名称
							values[16] =  persionMap.get("tr_unit");//培训单位
							values[17] =  persionMap.get("tr_results");//培训成绩
							values[18] =  persionMap.get("tr_assess");//考核成绩
							
							poiExcelUtil.writeLine(count, values);// 从模版的第二行开始 写入
						}
					} else {
						//行
						count ++;
						String[] values = new String[19];
						values[0] = userid;//人员ID
						values[1] = directoryBean.getDepartment();//所在分院/部门
						values[2] = directoryBean.getDirectoryname();//姓名
						values[3] = directoryBean.getNew_job_no();//职工工号
						values[4] = DirectoryConstant.parsePost(directoryBean.getPost(), true);//职务名称/岗位
						values[5] =  DirectoryConstant.parseNewjszc(directoryBean.getNew_jszc(), true);//职称
						values[6] =  directoryBean.getNew_zc_getdate();//职称获得时间
						
						values[7] =  "";//记录ID
						values[8] =  "";//是否专业
						values[9] =  "";//培训主题
						values[10] =  "";//培训内容
						values[11] =  "";//培训时间
						values[12] =  "";//培训课时
						values[13] =  "";//地点
						values[14] =  "";//培训费用
						values[15] =  "";//证件名称
						values[16] =  "";//培训单位
						values[17] =  "";//培训成绩
						values[18] =  "";//考核成绩
						
						poiExcelUtil.writeLine(count, values);// 从模版的第二行开始 写入
					}
				}
				poiExcelUtil.writeExcelToPath(tempExportFilePath);
			}
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
		}
		return tempExportFilePath;
	}

	/**
	 * 
	 * <b>Summary: </b> importExcelToData(导入excel数据，user_id为空的不导入)
	 */
	public String importExcelToData(String filepath) {
		
		Connection conn = null;
		try {
			TrainServiceIfc trainserviceifc = new TrainServiceImpl();
			poiExcelUtil = new POIExcelUtil(filepath);

			conn = DbManager.getInstance().getTransactionConnection();
			String[][] datas = poiExcelUtil.readSheet();// 将excel中的数据全部获取出来放置在二维数组中
			String user_id =""; //用户ID
			for (int i = 1; i < datas.length; i++) {// 从第一行开始读取
				String[] data = datas[i];
				//培训主题和培训时间
				if(StringUtil.isBlank(data[9])||StringUtil.isBlank(data[11])){
					continue;
				}
				TrainBean trainbean = new TrainBean();
				if(!StringUtil.isBlank(data[0])){
					user_id = data[0];
				} 
				
				trainbean.setTr_usersn(user_id);//用户ID
				trainbean.setTr_id(data[7]);//培训主键ID
				trainbean.setTr_level(DirectoryConstant.parseTrain_level(data[8],false));//是否专业
				trainbean.setTr_title(data[9]);//培训主题
				trainbean.setTr_content(data[10]);//培训内容
				trainbean.setTr_time(data[11]);//培训时间
				trainbean.setTr_hour(data[12]);//培训课时
				trainbean.setTr_address(data[13]);//地点
				trainbean.setTr_money(data[14]);//培训费用
				trainbean.setTr_name(data[15]);//证件名称
				trainbean.setTr_unit(data[16]);//培训单位
				
				trainbean.setTr_results(data[17]);//培训成绩
				trainbean.setTr_assess(data[18]);//考核成绩
				trainserviceifc.insertOrUpdateTrain(trainbean);
				
				cggxNumber++;
			}
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			LOG.error(e.getMessage());
			DbManager.closeTransactionConnection(conn, false);
		}
		outStr = outStr + "成功更新" + cggxNumber + "条记录<br>";
		return outStr;
	}
	
	/**
	 * 
	 * <b>Summary: </b>
	 * printExcelToData(根据传入的用户id数组，查询相应的人员持证培训信息并生成excel到指定路径，最后成功返回该路径)
	 * 
	 * @param useridArry
	 *            用户id数组
	 * @return
	 */
	public String printExcelToData(String userid) {
		try {
			tempExportFilePath += System.currentTimeMillis() + ".xls";

			poiExcelUtil = new POIExcelUtil(printTemplateFilePath);
			DirectoryBean directoryBean = directoryDao.getTypeBeanById(
					userid, "view");
			TrainBean trainbean = new TrainBean();
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
				
				trainbean.setTr_usersn(userid);//用户ID
				List<Map<String,String>> persionList = personholderdao.selPersonTrainData(trainbean);
				if(persionList.size() >0){
					//持证信息
					for (int m = 0; m < persionList.size(); m++) {
						//行
						String[] values = new String[9];
						//持证信息
						Map<String,String> persionMap =(Map<String,String>)persionList.get(m); 
					
						values[0] =  DirectoryConstant.parseTrain_level(persionMap.get("tr_level"),true);//是否专业
						values[1] =  persionMap.get("tr_hour");//培训课时
						values[2] =  persionMap.get("tr_title");//培训主题
						values[3] =  persionMap.get("tr_address");//地点
						values[4] =  persionMap.get("tr_money");//培训费用
						values[5] =  persionMap.get("tr_name");//证件名称
						values[6] =  persionMap.get("tr_unit");//培训单位
						values[7] =  persionMap.get("tr_results");//培训成绩
						values[8] =  persionMap.get("tr_assess");//考核成绩
						poiExcelUtil.writeLine(m+5, values);// 从模版的第二行开始 写入
					}
				}
			}
			poiExcelUtil.writeExcelToPath(tempExportFilePath);
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
		}
		return tempExportFilePath;
	}
	
	
	//查询所有人员信息
	public String[] selectUserId() throws Exception{
		
		StringBuffer buf = new StringBuffer();
		buf.append(" select user_id from td_sm_user 	       ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString());
		db.executePrepared();
		String[] userArray = new String[db.size()];
		for (int i = 0; i < db.size(); i++) {
			userArray[i] = db.getString(i,"user_id");
		}
		return userArray;
	}

	public String getTempExportFilePath() {
		return tempExportFilePath;
	}

	public void setTempExportFilePath(String tempExportFilePath) {
		this.tempExportFilePath = tempExportFilePath;
	}

	/**
	 * 
	 * <b>Summary: </b> deleteExportTempFile(删除导出临时文件)
	 * 
	 * @param tempExportFile
	 */
	public void deleteExportTempFile(File tempExportFile) {
		if (tempExportFile.exists()) {
			tempExportFile.delete();
		}
	}

	public static void main(String[] args) throws Exception {
		// new
		// DirectoryExcelToData().importExcelToData("D:\\WorkSpace\\xtbg-tjy\\creatorepp\\ccapp\\oa\\directory\\excel\\tmp\\1394358420265.xlsx");
		// new DirectoryExcelToData().exportExcelToData("3,4".split(","));
		File testFile = new File(
				"D:/WorkSpace/xtbg-tjy/creatorepp/ccapp/oa/directory/excel/tmp/1394419886765.xls");
		testFile.delete();
	}
}
