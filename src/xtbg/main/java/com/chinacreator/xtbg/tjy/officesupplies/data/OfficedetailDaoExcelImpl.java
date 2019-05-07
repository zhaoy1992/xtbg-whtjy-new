
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OfficedetailDaoExcelImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-9   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.officesupplies.data;

import java.sql.Connection;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.cache.OrgCache;
import com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsofficeAccountDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsofficeAccountDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsofficeAccountBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OfficeDetailService;
import com.chinacreator.xtbg.tjy.officesupplies.service.impl.OfficeDetailServiceImpl;

/**
 *<p>Title:OfficedetailDaoExcelImpl.java</p>
 *<p>Description:固定资产台帐导入导出类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-9
 */
public class OfficedetailDaoExcelImpl extends BusiExcelToData{
	
	public static final Logger LOG = Logger.getLogger(OfficedetailDaoExcelImpl.class.getName());
	
	private OsofficeAccountDao osofficeaccountdao = new OsofficeAccountDaoImpl();
	
	public OfficedetailDaoExcelImpl(){
		
	}
	
	/**
	* 
	*<b>Summary: </b>
	* exportExcelToData(根据传入的用户id数组，查询相应的人员信息并生成excel到指定路径，最后成功返回该路径)
	* @return
	*/
	public String exportExcelToData(Map<String,String> params){
		
	String tempExportFilePath1 = getTempExportFilePath()+System.currentTimeMillis()+".xls";
		
	try {

			poiExcelUtil = new POIExcelUtil(exportTemplateFilePath.trim());
			String parmjson = params.get("parmjson");
			OsofficeAccountBean searchbean = (OsofficeAccountBean) JSONObject.parseObject(parmjson, OsofficeAccountBean.class);
			//用户名称不为空
			if (!StringUtil.nullOrBlank(searchbean.getOrg_id())) {
				OrgCacheBean orgcachebean= OrgCache.getOrgCacheBean(searchbean.getOrg_id());
				
				List<Map<String,String>> listItems = osofficeaccountdao.OsofficeDetailToExcel(parmjson);
				//写入excel行
				//部门/分院
				String org_name = orgcachebean.getOrg_name();
				poiExcelUtil.write(1,1,org_name);
				
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
				if(listItems.size() >0){
					//办公类固定资产台帐
					for (int m = 0; m < listItems.size(); m++) {
						//物品信息
						Map<String,String> items =(Map<String,String>)listItems.get(m); 
						
						String code =  items.get("code");//标识卡编号
						poiExcelUtil.write(0,3+m,code,cellstyle);
						
						String name =  items.get("name");//名称
						poiExcelUtil.write(1,3+m,name,cellstyle);
						
						String type =  items.get("type");//规格\型号
						poiExcelUtil.write(2,3+m,type,cellstyle);
						
						String money =  items.get("money");//金额
						poiExcelUtil.write(3,3+m,money,cellstyle);
						
						String receive_username =  items.get("receive_username");//领用人
						poiExcelUtil.write(4,3+m,receive_username,cellstyle);
						
						String receive_day =  items.get("receive_day");//领取时间
						poiExcelUtil.write(5,3+m,receive_day,cellstyle);
						
						String blame_username =  items.get("blame_username");//责任人
						poiExcelUtil.write(6,3+m,blame_username,cellstyle);
						
						String deposit_place =  items.get("deposit_place");//存放位置
						poiExcelUtil.write(7,3+m,deposit_place,cellstyle);
						
						String assetsuse =  items.get("assetsuse");//资产用途
						poiExcelUtil.write(8,3+m,assetsuse,cellstyle);
						
						String wastedisposal =  items.get("wastedisposal");//报废处置情况
						poiExcelUtil.write(9,3+m,wastedisposal,cellstyle);
						
						String remarks =  items.get("remarks");//备注
						poiExcelUtil.write(10,3+m,remarks,cellstyle);
					}
				}
			}
			poiExcelUtil.writeExcelToPath(tempExportFilePath1);
		
		}catch(Exception e){
			LOG.error(e.getMessage());
			e.printStackTrace();
		}
	return tempExportFilePath1;
	}
	
	
	/**
	 * 
	 * <b>Summary: </b> importExcelToData(导入excel数据，user_id为空的不导入)
	 */
	public String importExcelToData(String filepath) {
		
		Connection conn = null;
		try {
			OfficeDetailService officedetailservice = new OfficeDetailServiceImpl();
			poiExcelUtil = new POIExcelUtil(filepath);

			conn = DbManager.getInstance().getTransactionConnection();
			String[][] datas = poiExcelUtil.readSheet();// 将excel中的数据全部获取出来放置在二维数组中
			
			String[] data1 = datas[1];
		    if(!StringUtil.isBlank(data1[1])){
		    	String org_name = data1[1];
		    	String org_id ="";//机构ID
				String sql1 = "select t.org_id from td_sm_organization t where t.org_name='"+org_name+"'";
				org_id = DaoUtil.sqlToField(sql1);
				if(!StringUtil.isBlank(org_id)){
					OrgCacheBean orgcachebean = OrgCache.getOrgCacheBean(org_id);
					
					for (int i = 3; i < datas.length; i++) {// 从第一行开始读取
						String[] data = datas[i];
						//部门机构名称
						if(StringUtil.isBlank(data[0])
								||StringUtil.isBlank(data[1])
								||StringUtil.isBlank(data[2])
                                ||StringUtil.isBlank(data[3])){
							continue;
						}
						OsofficeAccountBean bean = new OsofficeAccountBean();
						
						
						bean.setOrg_id(org_id);//部门ID
						bean.setOrg_name(orgcachebean.getOrg_name());//部门名称
						bean.setUnit_id(orgcachebean.getUnit_id());//单位ID
						bean.setUnit_name(orgcachebean.getUnit_name());//单位名称
						bean.setCode(data[0]);//标识卡编号
						bean.setName(data[1]);//名称
						bean.setType(data[2]);//规格、型号
						bean.setMoney(data[3]);//金额
						bean.setReceive_username(data[4]);//领取人
						bean.setReceive_day(data[5]);//领取时间
						bean.setBlame_username(data[6]);//责任人
						bean.setDeposit_place(data[7]);//存放位置
						bean.setAssetsuse(data[8]);//资产用途
						bean.setWastedisposal(data[9]);//报废处置情况
						bean.setRemarks(data[10]);//备注
						officedetailservice.insertOrUpdateOfficeDetail(bean);
						
						cggxNumber++;
					}
			
			    } 
		    }
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
			DbManager.closeTransactionConnection(conn, false);
		}
		outStr = outStr + "成功更新" + cggxNumber + "条记录<br>";
		return outStr;
	}
}
