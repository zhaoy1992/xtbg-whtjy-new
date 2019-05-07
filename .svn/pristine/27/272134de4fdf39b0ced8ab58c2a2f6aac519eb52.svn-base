package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.io.File;
import java.sql.Connection;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.constant.DirectoryConstant;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
import com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo;
/**
 * 
 *<p>Title:DevAccountInfoDaoExcelImpl.java</p>
 *<p>Description:设备台账导入</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-4-9
 */
public class DevAccountInfoDaoExcelImpl extends BusiExcelToData {
	public static final Logger LOG = Logger
			.getLogger(DevAccountInfoDaoExcelImpl.class.getName());
	DevAccountInfoDaoImpl devAccountInfoDaoImpl = new DevAccountInfoDaoImpl();
	
	public DevAccountInfoDaoExcelImpl(){
		
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
				String userid = useridArry[i];
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
				
				DevAccountInfo devAccountInfo = new DevAccountInfo();
				
				String haveInfo = devAccountInfoDaoImpl.getgetDevAccountByDevCode(data[0]);
				
				devAccountInfo.setDev_code(data[0]);  //
				devAccountInfo.setDev_name(data[1]);
				devAccountInfo.setType(data[2]);
				devAccountInfo.setMake_users(data[3]);
				//供应商
				if(!StringUtil.isBlank(data[4])){
					String devsup_id = DaoUtil.sqlToField("select t.devsup_id from ta_oa_devsupplier t where t.devsup_mc ='"+data[4].trim()+"'");
					devAccountInfo.setDevsup_id(devsup_id);
				}
				//生产日期
				if(!StringUtil.isBlank(data[5])){
					devAccountInfo.setCreat_date(StringUtil.convertStringToTimestamp(StringUtil.deNull(data[5]),"yyyy-MM-dd"));
				}
				//出厂编号
				devAccountInfo.setFactory_no(data[6]);
				//到货日期
				if(!StringUtil.isBlank(data[7])){
					devAccountInfo.setArrive_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(data[7]),"yyyy-MM-dd"));
				}
				//金额
				devAccountInfo.setPrice(data[8]);
				//使用状态
				if(!StringUtil.isBlank(data[9])){
					devAccountInfo.setDev_stockflag(DirectoryConstant.parseDev_stockflag(data[9],false));
				} else {
					devAccountInfo.setDev_stockflag("");
				}
				//完好状态
				if(!StringUtil.isBlank(data[10])){
					devAccountInfo.setDev_state(DirectoryConstant.parseDev_state(data[10],false));
				} else {
					devAccountInfo.setDev_state(DirectoryConstant.parseDev_state(data[10],false));
				}
				//备注
				devAccountInfo.setRemark(data[11]);
				//保管部门
				String user_orgname = StringUtil.deNull(data[12]);
				devAccountInfo.setUser_orgname(user_orgname);
				//保管部门ID
				String orgSql = "select * from td_sm_organization t where t.org_name='"+user_orgname.trim()+"'";
				String user_orgid = DaoUtil.sqlToField(orgSql);
				devAccountInfo.setUser_orgid(user_orgid);
				//保管人
				String custos_username = StringUtil.deNull(data[13]);
				devAccountInfo.setCustos_username(custos_username);
				//保管人ID
				String userSql = "";
				String custos_userid ="";	
				if(!StringUtil.isBlank(custos_username)){
					if(!StringUtil.isBlank(user_orgid)){
						userSql = "select t.user_id from td_sm_user t,td_sm_orguser org where t.user_id = org.user_id and org.org_id='"+user_orgid+"' and t.user_realname='"+custos_username.trim()+"'";
					} else {
						userSql = "select t.user_id from td_sm_user t where t.user_realname='"+custos_username.trim()+"'";
					}
					custos_userid = DaoUtil.sqlToField(userSql);
				}
				devAccountInfo.setCustos_userid(custos_userid);
				
				//登记人
				devAccountInfo.setCreater_username(custos_username);
				//登记人ID
				devAccountInfo.setCreater_userid(custos_userid);
				//保管用户单位ID
				String user_unit = "";
				String user_unitname = "";
				if(!StringUtil.isBlank(custos_userid)){
					UserCacheBean userBean= UserCache.getUserCacheBean(custos_userid);
					user_unitname = userBean.getUnit_name();
					user_unit = userBean.getUnit_id();
				} 
				//所在单位ID
				devAccountInfo.setUser_unit(user_unit);
				//所在单位名称
				devAccountInfo.setUser_unitname(user_unitname);
				if ("false".equals(haveInfo)) {
					devAccountInfo.setId(UUID.randomUUID().toString());
					devAccountInfo.setCreat_time(StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(),"yyyy-MM-dd"));
					devAccountInfoDaoImpl.insert(devAccountInfo);
				}else{
					devAccountInfo.setId(haveInfo);
					devAccountInfoDaoImpl.update(devAccountInfo);
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
