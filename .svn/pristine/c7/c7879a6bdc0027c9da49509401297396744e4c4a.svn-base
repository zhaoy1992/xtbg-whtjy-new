package com.chinacreator.xtbg.caizhengting.ibrary.dao.impl;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService;
import com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBookInfoServiceImpl;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
/**
 * 
 *<p>Title:IbraryBookInfoDaoExcelImpl.java</p>
 *<p>Description:图书资料导入</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-4-10
 */
public class IbraryBookInfoDaoExcelImpl extends BusiExcelToData {
	public static final Logger LOG = Logger
			.getLogger(IbraryBookInfoDaoExcelImpl.class.getName());
	IbraryBookInfoService ibraryBookInfoService = new IbraryBookInfoServiceImpl();
	
	List<Map<String, String>> list = new ArrayList<Map<String,String>>();
	
	public IbraryBookInfoDaoExcelImpl(){
		
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
			
			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath);
			
			for(int i=0 ; i < useridArry.length; i++){
				/*String userid = useridArry[i];
				DirectoryBean directoryBean = new DirectoryBean();
				
				if(!StringUtil.nullOrBlank(directoryBean.getDirectoryname())){
					String[] values = new String[16];
					values[0] = userid;
					values[1] = DirectoryConstant.parsePersonType(directoryBean.getNew_user_type(), true);
					values[2] = DirectoryConstant.parseJobState(directoryBean.getNew_job_state(), true);
					values[3] = directoryBean.getNew_job_no();
					values[4] = directoryBean.getDirectoryname();
					
					values[5] = directoryBean.getDepartment();
					values[6] = directoryBean.getNew_xc_gwgz();
					values[7] = directoryBean.getNew_xc_xjgz();
					
					values[8] = directoryBean.getNew_xc_yfgz();
					values[9] = directoryBean.getNew_xc_yb();
					values[10] = directoryBean.getNew_xc_ylbx();
					values[11] = directoryBean.getNew_xc_sybx();
					values[12] = directoryBean.getNew_xc_gjj();
					values[13] = directoryBean.getNew_xc_cb();
					
					values[14] = directoryBean.getNew_xc_cbhj();
					values[15] = directoryBean.getNew_xc_sfhj();   //分离薪酬
					poiExcelUtil.writeLine(2+i, values);//从模版的第二行开始 写入
				}*/
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
	* importExcelToData(导入excel数据)
	 */
	public String importExcelToData(String filepath){
		Connection conn = null;
		int cggxNumber = 0;//成功更新数量
		String rowNumber = "";
		String outStr = "";
		list = ibraryBookInfoService.findBookInfoTree();
		Map<String, String> map = list.get(0);
		try {
			
		    poiExcelUtil = new POIExcelUtil(filepath);

			conn = DbManager.getInstance().getTransactionConnection();
			String[][] datas = poiExcelUtil.readSheet();//将excel中的数据全部获取出来放置在二维数组中
			for(int i = 2 ; i < datas.length; i++){//从第二行开始读取
				String[] data = datas[i];
				if(StringUtil.nullOrBlank(data[2])){
					break;
				}
				
				IbraryBookInfoBean ibraryBookInfoBean = new IbraryBookInfoBean();
				
				String tree_id = map.get(data[0].trim());
				if (StringUtil.isBlank(tree_id)) {
					if(!StringUtil.isBlank(rowNumber)){
						rowNumber += ",";
					}
					rowNumber = rowNumber + (""+i);
				}else{
					ibraryBookInfoBean.setBook_id(UUID.randomUUID().toString());
					ibraryBookInfoBean.setTree_id(tree_id);
					ibraryBookInfoBean.setTree_name(data[0].trim());
					ibraryBookInfoBean.setBook_no(data[1].trim());
					ibraryBookInfoBean.setBook_name(data[2].trim());
					ibraryBookInfoBean.setWhereform(data[3].trim());
					ibraryBookInfoBean.setZdtz(data[4].trim());
					ibraryBookInfoBean.setBook_number("0");
					ibraryBookInfoService.addbookinfo(ibraryBookInfoBean);
					cggxNumber ++;
				}
				
			}
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			LOG.error(e.getMessage());
			DbManager.closeTransactionConnection(conn, false);
		}
		outStr = outStr + "成功更新" + cggxNumber + "条记录<br>";
		if(!StringUtil.isBlank(rowNumber)){
			outStr = outStr + "第" + rowNumber +"行分类不存在！<br>"; 
		}
		
		return outStr;
	}
	
	public static void main(String[] args) throws Exception{
		//new DirectoryExcelToData().importExcelToData("D:\\WorkSpace\\xtbg-tjy\\creatorepp\\ccapp\\oa\\directory\\excel\\tmp\\1394358420265.xlsx");
		//new DirectoryExcelToData().exportExcelToData("3,4".split(","));
		File testFile = new File("D:/WorkSpace/xtbg-tjy/creatorepp/ccapp/oa/directory/excel/tmp/1394419886765.xls");
		testFile.delete();
	}
}
