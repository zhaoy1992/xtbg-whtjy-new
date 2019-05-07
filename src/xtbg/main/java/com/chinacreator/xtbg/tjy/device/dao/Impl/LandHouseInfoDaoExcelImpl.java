package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
import com.chinacreator.xtbg.tjy.device.dao.LandHouseInfoDao;
import com.chinacreator.xtbg.tjy.device.entity.LandHouseBean;
/**
 * 
 *<p>Title:LandHouseInfoDaoExcelImpl.java</p>
 *<p>Description:土地房屋信息导入</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author 陈郊
 *@version 1.0
 *@CreateDate:2015-11-23
 */
public class LandHouseInfoDaoExcelImpl extends BusiExcelToData {
	public static final Logger LOG = Logger
			.getLogger(LandHouseInfoDaoExcelImpl.class.getName());
	DevAccountInfoDaoImpl devAccountInfoDaoImpl = new DevAccountInfoDaoImpl();
	LandHouseInfoDao dao = new LandHouseInfoDaoImpl();
	public LandHouseInfoDaoExcelImpl(){
		
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
				LandHouseBean bean = new LandHouseBean();
				String lh_id = dao.getLandHouseByLh_Number(data[0]);
				bean.setLh_number(data[0]);
				bean.setLh_name(data[1]);
				bean.setLh_area(data[2]);
				bean.setLh_location(data[3]);
				bean.setLh_identify_code(data[4]);
				bean.setLh_date(StringUtil.convertStringToTimestamp(StringUtil.deNull(data[5]), "yyyy-MM-dd"));
				bean.setLh_money(data[6]);
				bean.setLh_remarks(data[7]);
				if ("false".equals(lh_id)) {
					bean.setLh_id(UUID.randomUUID().toString());
					((XtDbBaseDao) dao).insert(bean);
				}else{
					bean.setLh_id(lh_id);
					((XtDbBaseDao) dao).update(bean);
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
	
}
