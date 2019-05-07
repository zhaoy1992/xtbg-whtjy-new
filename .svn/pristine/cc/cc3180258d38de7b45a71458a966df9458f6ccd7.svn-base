/**
 * [Product]
 *     xtbg-tjy
 * [Copyright]
 *     Copyright © 2014 ICSS All Rights Reserved.
 * [FileName]
 *     PersonholderExcelToData.java
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
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.constant.DirectoryConstant;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.dao.imploracle.DirectoryDaoImpl;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao;
import com.chinacreator.xtbg.core.personholder.dao.imploracle.PersonHolderDaoImpl;
import com.chinacreator.xtbg.core.personholder.entity.PersonHolder;
import com.chinacreator.xtbg.core.personholder.entity.TrainBean;
import com.chinacreator.xtbg.core.personholder.service.PersonHolderServiceIfc;
import com.chinacreator.xtbg.core.personholder.service.imp.PersonHolderServiceImpl;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * <p>
 * Title:PersonholderExcelToData.java
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright:Copyright (c) 2013
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * 
 * @author 邱炼
 * @version 1.0 2014-3-13
 */
public class PersonholderExcelToData {
	
	public static final Logger LOG = Logger .getLogger(PersonholderExcelToData.class.getName());
	
	private String exportTemplateFilePath = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam("personholder_excelTemplateFilePath");// 导出模版所在路径
	private String tempExportFilePath = FileUtil.getAppContextPath() + CacheCommonManageProxy.getSystemParam("personholder_tempExcelFilePath");// 导出临时文件所在位置
	private String printTemplateFilePath = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam("printholder_excelTemplateFilePath");// 打印模版所在路径
	private String printHolderTrainTemplateFilePath = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam("printHolderTrain_excelTemplateFilePath");// 持证和培训打印模版所在路径
	private POIExcelUtil poiExcelUtil = null;
	private DirectoryDao directoryDao = new DirectoryDaoImpl();
	private PersonHolderDao personholderdao = new PersonHolderDaoImpl();
	private String outStr = "";
	private int cgdrNumber = 0;// 成功导入数量
	private int cggxNumber = 0;// 成功更新数量
	private int drsbNumber = 0;// 导入失败数量

	public PersonholderExcelToData() {

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

			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath);
			//写入excel行
			int count =1;
			for (int i = 0; i < useridArry.length; i++) {
				String userid = useridArry[i];
				DirectoryBean directoryBean = directoryDao.getTypeBeanById(
						userid, "view");
				//用户名称不为空
				if (!StringUtil.nullOrBlank(directoryBean.getDirectoryname())) {
					List<Map<String,String>> persionList = personholderdao.selPersonHolderData(userid);
					if(persionList.size() >0){
						//持证信息
						for (int m = 0; m < persionList.size(); m++) {
							//行
							count ++;
							String[] values = new String[18];
							values[0] = directoryBean.getEng_name();//用户登录名
							values[1] = directoryBean.getDepartment();;//所在分院/部门
							values[2] = directoryBean.getDirectoryname();//姓名
							values[3] = directoryBean.getNew_job_no();//职工工号
							values[4] = DirectoryConstant.parsePost(directoryBean.getPost(), true);//职务名称/岗位
							values[5] =  DirectoryConstant.parseNewjszc(directoryBean.getNew_jszc(), true);//职称
							values[6] =  directoryBean.getNew_zc_getdate();//职称获得时间
							
							//持证信息
							Map<String,String> persionMap =(Map<String,String>)persionList.get(m); 
						
							//values[7] =  persionMap.get("hold_id");//记录ID
							values[7] =  persionMap.get("hold_name");//持证项目
							values[8] =  DirectoryConstant.parseDirectoryhold_org(persionMap.get("hold_org"),true);//审批机构
							values[9] =  persionMap.get("hold_number");//证书编号
							values[10] =  persionMap.get("hold_ratifytime");//取证日期
							values[11] =  persionMap.get("hold_replactime");//换证日期
							values[12] =  persionMap.get("hold_validtime");//有效日期
							values[13] =  persionMap.get("hold_level");//原件存放地
							values[14] =  DirectoryConstant.parsePersionhold_state(persionMap.get("hold_state"),true);//持证状态
							values[15] =  DirectoryConstant.parseDirectoryhold_state(persionMap.get("register_flag"),true);//是否注册
							values[16] =  persionMap.get("hold_remark");//备注
							poiExcelUtil.writeLine(count, values);// 从模版的第二行开始 写入
						}
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
			PersonHolderServiceIfc personholderserviceifc = new PersonHolderServiceImpl();
			poiExcelUtil = new POIExcelUtil(filepath);

			conn = DbManager.getInstance().getTransactionConnection();
			String[][] datas = poiExcelUtil.readSheet();// 将excel中的数据全部获取出来放置在二维数组中
			if(datas[0].length!=13){
				outStr = "模板格式不正确,无法导入数据,请下载正确的模板!<br>";
			}else{
				String user_id =""; //用户ID
				for (int i = 1; i < datas.length; i++) {// 从第二行开始读取
					String[] data = datas[i];
					//持证项目
					if(StringUtil.isBlank(data[3])){
						break;
					}
					if(!StringUtil.nullOrBlank(data[0])){
						user_id = DaoUtil.sqlToField("select user_id from td_sm_user where user_name = '"+data[0]+"'");
						if(!StringUtil.nullOrBlank(user_id)){
							PersonHolder personholder = new PersonHolder();
							personholder.setCreator_time(DateUtil.getCurrentDateTime());//创建时间
							personholder.setHold_usesnid(user_id);//用户ID
							personholder.setUnit_name(data[1]);//所在部门/分院
							personholder.setHold_name(data[3]);//持证项目
							personholder.setHold_org(data[4]);//考证机构
							personholder.setHold_number(data[5]);//证书编号
							personholder.setHold_ratifytime(data[6]);//初次取证日期
							personholder.setHold_replactime(data[7]);//发证日期
							personholder.setHold_validtime(data[8]);//有效日期
							personholder.setHold_level(data[9]);//持证级别
							personholder.setHold_state(data[10]);//持证状态
							String isRegister = data[11];
							if("是".equals(isRegister)){
								personholder.setRegister_flag("1");//1表示注册
							}else{
								personholder.setRegister_flag("0");//0表示不注册
							}
							personholder.setHold_remark(data[12]);//备注
							personholder.setAttachment_id(DaoUtil.getUUID());
							personholderserviceifc.insertOrUpdatePersonHolder(personholder);
							cggxNumber++;
						}else{
							outStr = outStr + "用户名为:"+data[0]+"的用户不存在,无法导入数据,请确认<br>";
						}
					}
				}
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
	 * exportExcelToData(根据传入的用户id数组，查询相应的人员持证信息并生成excel到指定路径，最后成功返回该路径)
	 * 
	 * @param useridArry
	 *            用户id数组
	 * @return
	 */
	public String printExcelToData(String userid) {
		try {
			tempExportFilePath += System.currentTimeMillis() + ".xls";

			poiExcelUtil = new POIExcelUtil(printTemplateFilePath);
			//写入excel行
			DirectoryBean directoryBean = directoryDao.getTypeBeanById(
					userid, "view");
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
				
				List<Map<String,String>> persionList = personholderdao.selPersonHolderData(userid);
				if(persionList.size() >0){
					//持证信息
					for (int m = 0; m < persionList.size(); m++) {
						//行
						String[] values = new String[8];
						//持证信息
						Map<String,String> persionMap =(Map<String,String>)persionList.get(m); 
						
						values[0] =  persionMap.get("hold_name");//持证项目
						values[1] =  DirectoryConstant.parseDirectoryhold_org(persionMap.get("hold_org"),true);//审批机构
						values[2] =  persionMap.get("hold_number");//证书编号
						values[3] =  persionMap.get("hold_ratifytime");//取证日期
						values[4] =  persionMap.get("hold_validtime");//有效日期
						values[5] =  "";
						values[6] =  persionMap.get("hold_replactime");//换证日期
						values[7] =  persionMap.get("hold_remark");//备注
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

	
	
	
	/**
	 * 
	 * <b>Summary: </b>
	 * printHolderTrainExcelToData(根据传入的用户id数组，查询相应的人员持证-人员信息并生成excel到指定路径，最后成功返回该路径)
	 * 
	 * @param useridArry
	 *            用户id数组
	 * @return
	 */
	public String printHolderTrainExcelToData(String[] useridArry) {
		try {
			tempExportFilePath += System.currentTimeMillis() + ".xls";

			poiExcelUtil = new POIExcelUtil(printHolderTrainTemplateFilePath);
			for (int i = 0; i < useridArry.length; i++) {
				String userid = useridArry[i];
				//写入excel行
				DirectoryBean directoryBean = directoryDao.getTypeBeanById(
						userid, "view");
				//用户名称不为空
				if (!StringUtil.nullOrBlank(directoryBean.getDirectoryname())) {
					String[] values1 = new String[17];
					values1[0] = (i+1)+"";
					values1[1] = directoryBean.getDepartment();//所在部门
					values1[2] = directoryBean.getDirectoryname();//姓名
					values1[3] = directoryBean.getDirectorysex();//性别
					values1[4] = directoryBean.getNew_first_xingshi();//第一学历
					values1[5] = directoryBean.getNew_first_zy();//所学专业
					values1[6] = directoryBean.getSchool();//毕业院校
					values1[7] = DirectoryConstant.parseEducation(directoryBean.getNew_zg_xl(), true);//最高学历
					values1[8] = directoryBean.getNew_zg_xingshi();//最高学历
					values1[9] = directoryBean.getNew_zg_byyx();//毕业院校
					values1[10] = DirectoryConstant.parseNewjszc(directoryBean.getNew_jszc(), true);//职称
					values1[11] = directoryBean.getNew_zc_getdate();//获得时间
					values1[12]="";//持证项目
					values1[16] = "";//备注
					//持证信息
					List<Map<String,String>> persionList = personholderdao.selPersonHolderData(userid);
					String hold_name = "";
					for (int j=0;j<persionList.size();j++){
						Map<String,String> persionMap = persionList.get(j);
						String temp = persionMap.get("hold_name");//持证项目
						if(hold_name.indexOf(temp)==-1){
							hold_name+=temp +";";
						}
					}
					if(hold_name.length()>0){
						hold_name = hold_name.substring(0, hold_name.length()-1);
					}
					values1[12] = hold_name;
					if(persionList.size() >0){
						Map<String,String> persionMap =(Map<String,String>)persionList.get(0); 
						//values1[12] = persionMap.get("hold_name");//持证项目
						values1[16] = persionMap.get("hold_remark");//备注
					}
					values1[13]="";//培训记录 主题
					//培训记录
					TrainBean trainbean = new TrainBean();
					trainbean.setTr_usersn(userid);//用户ID
					List<Map<String,String>> trainList = personholderdao.selPersonTrainData(trainbean);
					if(trainList.size() >0){
						Map<String,String> trainMap =(Map<String,String>) trainList.get(0);
						values1[13] = trainMap.get("tr_title");
					}
					//其它项目
					values1[14] ="";
					TrainBean othertrainbean = new TrainBean();
					othertrainbean.setTr_usersn(userid);//用户ID
					othertrainbean.setTr_level("2");//培训级别
					List<Map<String,String>> othertrainList = personholderdao.selPersonTrainData(othertrainbean);
					if(othertrainList.size() >0){
						String tr_title ="";
						for (int m = 0; m < othertrainList.size(); m++) {
							Map<String,String> trainotherMap =(Map<String,String>) othertrainList.get(m);
							tr_title = tr_title + trainotherMap.get("tr_title")+",";
							if(m==othertrainList.size()-1){
								tr_title.substring(tr_title.length()-1);
							}
						}
						values1[14] = tr_title;//其它项目
					}
					//身份证号码
					values1[15] = StringUtil.deNull(directoryBean.getIdnumber());
					poiExcelUtil.writeLine(2+i, values1);// 从模版的第二行开始 写入
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
