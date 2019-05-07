package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.sql.Connection;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.excel.POIExcelUtil;
import com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieTypeBean;
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
public class OfficeTypeInfoDaoExcelImpl extends BusiExcelToData {
	public static final Logger LOG = Logger
			.getLogger(OfficeTypeInfoDaoExcelImpl.class.getName());
	OsupplieTypeDaoImpl dao = new OsupplieTypeDaoImpl();
	
	public OfficeTypeInfoDaoExcelImpl(){
		
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
				OsupplieTypeBean bean = new OsupplieTypeBean();
				String oftype_id = dao.getOsupplieType(data[0]);
				bean.setOftype_name(data[0]);
				bean.setOftype_remark(data[1]);
				bean.setUnit_name(data[2]);
				//根据部门名称获取部门id
				if(!StringUtil.nullOrBlank(data[2])){
					String unit_id = DaoUtil.sqlToField("select org_id from td_sm_organization where org_name = '"+data[2]+"'");
					bean.setUnit_id(unit_id);
				}
				bean.setOftype_flag("2");//易耗品
				bean.setOftype_no(data[3]);
				if ("false".equals(oftype_id)) {
					bean.setOftype_id(UUID.randomUUID().toString());
					((XtDbBaseDao) dao).insert(bean);
				}else{
					bean.setOftype_id(oftype_id);
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
