package com.chinacreator.xtbg.core.personholder.data;

import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import com.chinacreator.xtbg.core.directory.constant.DirectoryConstant;
import com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao;
import com.chinacreator.xtbg.core.personholder.dao.imploracle.PersonHolderDaoImpl;
import com.chinacreator.xtbg.core.personholder.entity.PersonHolder;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;

/**
 * <p>
 * Title:PersonHolderYujingToData.java
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
public class PersonHolderYujingToData extends BusiExcelToData{
	

	public static final Logger LOG = Logger.getLogger(HolderDaoExcelImpl.class.getName());
	
	private PersonHolderDao personholderdao = new PersonHolderDaoImpl();
	
	
	public PersonHolderYujingToData(){
		
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
			int count =1;
			String validStart_time = params.get("validStart_time"); //有效日期开始时间
			String validEtart_time = params.get("validEtart_time");//有效日期结束时间
			String org_Ids = params.get("orgIds");
			PersonHolder personholder = new PersonHolder();
			personholder.setValidStart_time(validStart_time);
			personholder.setValidEtart_time(validEtart_time);
			personholder.setOrgIds(org_Ids);
			List<Map<String,String>> persionList = personholderdao.selPersonHolderYjToData(personholder);
			//用户名称不为空
			if(persionList.size() >0){
				//持证信息
				for (int m = 0; m < persionList.size(); m++) {
					//行
					count ++;
					//持证信息
					Map<String,String> persionMap =(Map<String,String>)persionList.get(m); 
					String[] values = new String[18];
					values[0] = persionMap.get("hold_usesnid");//人员ID
					values[1] = persionMap.get("department");//所在分院/部门
					values[2] = persionMap.get("hold_userrealname");//姓名
					values[3] = persionMap.get("new_job_no");//职工工号
					values[4] = DirectoryConstant.parsePost(persionMap.get("duties"), true);//职务名称/岗位
					values[5] =  DirectoryConstant.parseNewjszc(persionMap.get("new_jszc"), true);//职称
					values[6] =  persionMap.get("new_zc_getdate");//职称获得时间
					
					values[7] =  persionMap.get("hold_id");//记录ID
					values[8] =  persionMap.get("hold_name");//持证项目
					values[9] =  DirectoryConstant.parseDirectoryhold_org(persionMap.get("hold_org"),true);//审批机构
					values[10] =  persionMap.get("hold_number");//证书编号
					values[11] =  persionMap.get("hold_ratifytime");//取证日期
					values[12] =  persionMap.get("hold_replactime");//换证日期
					values[13] =  persionMap.get("hold_validtime");//有效日期
					values[14] =  persionMap.get("hold_level");//持证级别
					values[15] =  DirectoryConstant.parsePersionhold_state(persionMap.get("hold_state"),true);//持证状态
					values[16] =  DirectoryConstant.parseDirectoryhold_state(persionMap.get("register_flag"),true);//是否注册
					values[17] =  persionMap.get("hold_remark");//备注
					poiExcelUtil.writeLine(count, values);// 从模版的第二行开始 写入
				}
			}
			poiExcelUtil.writeExcelToPath(tempExportFilePath1);
		}catch(Exception e){
			LOG.error(e.getMessage());
		}
	return tempExportFilePath1;
	}
}
