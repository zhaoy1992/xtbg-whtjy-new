package com.chinacreator.xtbg.pub.core.dwr;

import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:OrgDwr.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author 刘健
 *@version 1.0
 *2011-4-11
 */
public class OrgDwr {


	/**
	 * 	
	 *获得deploymentConfig.properties 配置获得初始化区域
	 * @param code 此处无用，预留值
	 * @return
	 * @throws Exception 
	 */
	public List getInitArea(String orgCode) throws Exception{
		GetProvinceCityAreaOrg p = new GetProvinceCityAreaOrg();
		return p.initArea(orgCode);
	}
	
	/**
	 * 获取市和区的数据
	 */
	public List getCity(String code) throws SQLException{
		GetProvinceCityAreaOrg p = new GetProvinceCityAreaOrg();
		List list = p.getCityArea(code);
		return list;
	}
//	//查机构
//	public CityBean getOrgLevel(String code) throws SQLException{
//		GetProvinceCityAreaOrg p = new GetProvinceCityAreaOrg();
//		return p.getOrgLevel(code);
//	}
//	
//	//查机构
//	public List getOrg(String code) throws SQLException{
//		GetProvinceCityAreaOrg p = new GetProvinceCityAreaOrg();
//		List list = p.getOrg(code);
//		return list;
//	}
	
	public boolean getExisOrg(String orgCode) throws Exception{
		GetProvinceCityAreaOrg p = new GetProvinceCityAreaOrg();
		return p.getExisOrg(orgCode);
	}
	
	/**
	 * 判断当前机构是那个级别
	 * @param areaCode
	 * @param parentAreaCode
	 * @return
	 */
	public String getAreaLevel(String areaCode, String parentAreaCode) {
		String areaLevelCode = "";
		try {
			String levelCode = getLevelCode(areaCode);
			if (StringUtil.isBlank(parentAreaCode)) {
				areaLevelCode = levelCode + "0";
			} else {
				String parentlevelCode=parentAreaCode.substring(21, 22);
				int num=0;
				if(levelCode.equals(parentlevelCode)){
					num=Integer.parseInt(parentAreaCode.substring(22, 23));
					num+=1;
				}
                areaLevelCode= levelCode+num;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return areaLevelCode;
	}

	/**
	 * 根据区域代码获取当前区域的级别码
	 * @param areaCode
	 * @return
	 * @throws SQLException
	 */
	public String getLevelCode(String areaCode) throws SQLException {
		String levelCode = "";
		String sql = "select AREALEVELCODE from TA_DIC_AREALEVEL where AREACODE=?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, areaCode);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			levelCode = pdb.getString(0, "AREALEVELCODE");
		}
		return levelCode;
	}
}
