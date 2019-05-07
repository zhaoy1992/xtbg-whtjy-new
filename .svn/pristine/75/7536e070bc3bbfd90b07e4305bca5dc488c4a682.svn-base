package com.chinacreator.xtbg.tjy.device.data;

import java.io.File;
import java.sql.Connection;
import java.util.Map;
import org.apache.log4j.Logger;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevAccountInfoDaoImpl;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevAppraisalDaoImpl;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevCalibrateRecodeDaoImpl;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevCheckInfoDaoImpl;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevCompareRecodeDaoImpl;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevSubjectRecordDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevAppraisalBean;
import com.chinacreator.xtbg.tjy.device.entity.DevCalibrateRecode;
import com.chinacreator.xtbg.tjy.device.entity.DevCheckInfoBean;
import com.chinacreator.xtbg.tjy.device.entity.DevCompareRecode;
import com.chinacreator.xtbg.tjy.device.entity.DevSubjectRecordBean;

/**
 * 
 *<p>Title:DevckApprDaoExcelImpl.java</p>
 *<p>Description:仪器设备台帐资料-核查检定信息导入</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author邱炼
 *@version 1.0
 *2014-5-21
 */
public class DevckApprDaoExcelImpl extends BusiExcelToData{
	
	public static final Logger LOG = Logger.getLogger(DevckApprDaoExcelImpl.class.getName());
	
	DevAccountInfoDaoImpl devAccountInfoDaoImpl = new DevAccountInfoDaoImpl();
	
	DevCheckInfoDaoImpl devcheckinfodaoimpl = new DevCheckInfoDaoImpl();
	
	DevAppraisalDaoImpl devappraisaldaoimpl = new DevAppraisalDaoImpl();
	
	DevCalibrateRecodeDaoImpl devcalibraterecodedaoimpl = new DevCalibrateRecodeDaoImpl();
	
	DevCompareRecodeDaoImpl devcomparerecodedaoimpl = new DevCompareRecodeDaoImpl();
	
	DevSubjectRecordDaoImpl devsubjectrecorddaoimpl = new DevSubjectRecordDaoImpl();
	
	public DevckApprDaoExcelImpl(){
	
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
		String outStr = "";
		try {
		
		    poiExcelUtil = new POIExcelUtil(filepath);
		
			conn = DbManager.getInstance().getTransactionConnection();
			String[][] datas = poiExcelUtil.readSheet();//将excel中的数据全部获取出来放置在二维数组中
			for(int i = 1 ; i < datas.length; i++){//从第二行开始读取
				String[] data = datas[i];
				if(StringUtil.nullOrBlank(data[0])){
					break;
				}
				//设备编号判断
				String haveInfo = devAccountInfoDaoImpl.getgetDevAccountByDevCode(data[0]);
				
				//核查记录实体bean
				DevCheckInfoBean devcheckinfobean = new DevCheckInfoBean();
				devcheckinfobean.setId(StringUtil.getUUID());
				devcheckinfobean.setT_sb_id(haveInfo);//设备iD
				//检查日期
				if(!StringUtil.isBlank(data[3])){
					devcheckinfobean.setChinfo_date(StringUtil.convertStringToTimestamp(StringUtil.deNull(data[3]),"yyyy-MM-dd"));
				}
				//责任人ID
				String user_name = StringUtil.deNull(data[4]);
				String user_id = "";
				if(!StringUtil.isBlank(user_name)){
					user_id = DaoUtil.sqlToField("select t.user_id from td_sm_user t where t.user_realname='"+user_name.trim()+"'");
				}
				devcheckinfobean.setUser_id(user_id);
				//责任人名称
				devcheckinfobean.setUser_name(user_name);
				//备注
				devcheckinfobean.setRemark(StringUtil.deNull(data[5]));
				
				//设备检定记录
				DevAppraisalBean devappraisalbean = new DevAppraisalBean();
				devappraisalbean.setAppr_id(StringUtil.getUUID());
				devappraisalbean.setT_sb_id(haveInfo);
				//检定日期
				if(!StringUtil.isBlank(StringUtil.deNull(data[6]))){
					devappraisalbean.setAppr_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(data[6]),"yyyy-MM-dd"));
				}
				//鉴定有效期
				if(!StringUtil.isBlank(StringUtil.deNull(data[7]))){
					devappraisalbean.setAppr_valitime(StringUtil.convertStringToTimestamp(StringUtil.deNull(data[7]),"yyyy-MM-dd"));
				}
				//鉴定单位
				devappraisalbean.setAppr_org_name(StringUtil.deNull(data[8]));
				//鉴定证书编号
				devappraisalbean.setAppr_no(StringUtil.deNull(data[9]));
				
				//校准记录实体
				DevCalibrateRecode devcalibraterecode = new DevCalibrateRecode();
				devcalibraterecode.setCalib_id(StringUtil.getUUID());
				devcalibraterecode.setT_sb_id(haveInfo);
				//校准日期
				if(!StringUtil.isBlank(data[10])){
					devcalibraterecode.setCalib_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(data[10]),"yyyy-MM-dd"));
				}
				//校准有效日期
				if(!StringUtil.isBlank(data[11])){
					devcalibraterecode.setCalib_valitime(StringUtil.convertStringToTimestamp(StringUtil.deNull(data[11]),"yyyy-MM-dd"));
				}
				//校准类型
				devcalibraterecode.setCalib_type(StringUtil.deNull(data[12]));
				//校准单位
				devcalibraterecode.setCalib_org_name(StringUtil.deNull(data[13]));
				//校准证书编号
				devcalibraterecode.setCalib_no(StringUtil.deNull(data[14]));
				
				//对比记录实体
				DevCompareRecode devcomparerecode = new DevCompareRecode();
				devcomparerecode.setComp_id(StringUtil.getUUID());
				devcomparerecode.setT_sb_id(haveInfo);
				//对比日期
				if(!StringUtil.isBlank(data[15])){
					devcomparerecode.setCreator_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(data[15]),"yyyy-MM-dd"));
				}
				//对比设备ID
				if(!StringUtil.isBlank(data[16])){
					String haveInfoId = devAccountInfoDaoImpl.getgetDevAccountByDevCode(data[16].trim());
					if(!"false".equals(haveInfoId)){
						devcomparerecode.setComp_sb_id(haveInfoId);
					}
				}
				//对比结果
				devcomparerecode.setComp_result(StringUtil.deNull(data[17]));
				
				//标对实体bean
				DevSubjectRecordBean devsubjectrecordbean = new DevSubjectRecordBean();
				devsubjectrecordbean.setSub_id(StringUtil.getUUID());
				devsubjectrecordbean.setT_sb_id(haveInfo);
				devsubjectrecordbean.setT_sb_id(haveInfo);
				//标对日期
				if(!StringUtil.isBlank(data[18])){
					devsubjectrecordbean.setCreator_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(data[18]),"yyyy-MM-dd"));
				}
				//标样名称
				devsubjectrecordbean.setSub_name(StringUtil.deNull(data[19]));
				//标对结果
				devsubjectrecordbean.setSub_result(StringUtil.deNull(data[20]));
				
				
				if (!"false".equals(haveInfo)) {
					//核查日期
					if(devcheckinfobean.getChinfo_date()!=null){
						devcheckinfodaoimpl.insert(devcheckinfobean);
					}
					//检定日期
					if(devappraisalbean.getAppr_time()!=null){
						devappraisaldaoimpl.insert(devappraisalbean);
					}
					//校准日期
					if(devcalibraterecode.getCalib_time()!=null){
						devcalibraterecodedaoimpl.insert(devcalibraterecode);
					}
					//比对日期
					if(devcomparerecode.getCreator_time()!=null){
						devcomparerecodedaoimpl.insert(devcomparerecode);
					}
					//标对日期
					if(devsubjectrecordbean.getCreator_time()!=null){
						devsubjectrecorddaoimpl.insert(devsubjectrecordbean, conn);
					}
					
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
