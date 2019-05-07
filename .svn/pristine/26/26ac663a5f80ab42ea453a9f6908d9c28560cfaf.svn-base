package com.chinacreator.xtbg.core.directory.dao.imploracle;

import java.io.File;
import java.sql.Connection;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.constant.DirectoryConstant;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.directory.entity.UserinfoBean;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
/**
 * 
 *<p>Title:DirectoryDaoExcelImpl.java</p>
 *<p>Description:人员薪酬导入导出实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-26
 */
public class DirectoryDaoExcelImpl extends BusiExcelToData {
	public static final Logger LOG = Logger
			.getLogger(DirectoryDaoExcelImpl.class.getName());
    DirectoryDao directoryDao = new DirectoryDaoImpl();
	
	public DirectoryDaoExcelImpl(){
		
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
			
			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath.trim());
			
			for(int i=0 ; i < useridArry.length; i++){
				String userid = useridArry[i];
				DirectoryBean directoryBean = directoryDao.getTypeBeanById(userid,"view");

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
				}
				poiExcelUtil.writeExcelToPath(tempExportFilePath1);
			}
		}catch(Exception e){
			LOG.error(e.getMessage());
			e.printStackTrace();
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
				UserinfoBean userinfoBean = new UserinfoBean();
				
				userinfoBean.setUserid(data[0]);//用户id
				
				userinfoBean.setNew_user_type(DirectoryConstant.parsePersonType(data[1],false));//人员类别
				userinfoBean.setNew_job_state(DirectoryConstant.parseJobState(data[2], false));//在岗状态
				userinfoBean.setNew_job_no(data[3]);//职工工号
				userinfoBean.setUserRealname(data[4]);//姓名
				
				//data[5]工作部门 字段不存
				
				userinfoBean.setNew_xc_gwgz(data[6]);//岗位工资
				userinfoBean.setNew_xc_xjgz(data[7]);//薪级工资
				data[8] = "" + (Float.parseFloat(data[6])+Float.parseFloat(data[7]));
				userinfoBean.setNew_xc_yfgz(data[8]); //应发合计不存
				userinfoBean.setNew_xc_yb(data[9]);//医保
				userinfoBean.setNew_xc_ylbx(data[10]);//养老保险
				userinfoBean.setNew_xc_sybx(data[11]);//失业保险
				userinfoBean.setNew_xc_gjj(data[12]);//公积金
				userinfoBean.setNew_xc_cb(data[13]);//补扣
				data[14] = "" + (Float.parseFloat(data[9])+Float.parseFloat(data[10])+Float.parseFloat(data[11])+Float.parseFloat(data[12])+Float.parseFloat(data[13]));
				userinfoBean.setNew_xc_cbhj(data[14]);//扣款合计不存
				data[15] = "" + (Float.parseFloat(data[8])-Float.parseFloat(data[14]));
				userinfoBean.setNew_xc_sfhj(data[15]);//实发合计不存
				
				directoryDao.updateUserXCinfo(userinfoBean, conn);
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
