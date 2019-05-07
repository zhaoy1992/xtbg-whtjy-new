package com.chinacreator.xtbg.pub.core.dwr;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.pub.core.entity.CityBean;
import com.chinacreator.xtbg.pub.util.LoadPropertiesUtil;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:GetProvinceCityAreaOrg.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author 刘健
 *@version 1.0
 *2011-4-11
 */
public class GetProvinceCityAreaOrg {
	
	/**
	 * 根据系统初始化配置来初始机构
	 */
	public List initArea(String orgCode) throws Exception{
		LoadPropertiesUtil lpu=LoadPropertiesUtil.getInstance();
	    String[] areaCodes=lpu.getPropertiesAreaCode("deploymentConfig.properties", "areaCode");
		
		StringBuffer sql=new StringBuffer("select area_code, area_name from ta_dic_area t ");
		if(!orgCode.equals("")){
			sql.append(" where t.parent_area_code="+orgCode);
		}else{
	       if(areaCodes.length!=0){
	    	   sql.append("  where t.area_code in (");
				for (int i = 0; i < areaCodes.length; i++) {
					sql.append("'"+areaCodes[i].toString()+"'");
					if(i!=areaCodes.length-1)
						sql.append(",");
				}
				sql.append(")");
	    	}
		}
		List list = new ArrayList();
		DBUtil pdb = new DBUtil();
		pdb.executeSelect(sql.toString());
		for(int i=0;i<pdb.size();i++){
			CityBean city = new CityBean();
			city.setCode(pdb.getString(i,"area_code"));
			city.setName(pdb.getString(i,"area_name"));
			list.add(city);
		}
		return list;
	}

	//查市或区
	public List getCityArea(String code) throws SQLException {
		String sql="select area_code, area_name from ta_dic_area t where t.parent_area_code= ?";
		List list = new ArrayList();
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, code);
		pdb.executePrepared();
		for(int i=0;i<pdb.size();i++){
			CityBean city = new CityBean();
			city.setCode(pdb.getString(i,"area_code"));
			city.setName(pdb.getString(i,"area_name"));
			list.add(city);
		}
		return list;
	}
//	
//	//查区下的机构
//	public List getOrg(String code) throws SQLException {
//		String sql="select * from ta_dic_organization  o where o.area_code= ? and o.isLevel=0";
//		List list = new ArrayList();
//		PreparedDBUtil pdb = new PreparedDBUtil();
//		pdb.preparedSelect(sql);
//		pdb.setString(1, code);
//		pdb.executePrepared();
//		for(int i=0;i<pdb.size();i++){
//			CityBean city = new CityBean();
//			city.setCode(pdb.getString(i,"org_code"));
//			city.setName(pdb.getString(i,"org_name"));
//			list.add(city);
//		}
//		return list;
//		
//	}
	
	//查区下的机构
/**	public CityBean getOrgLevel(String code) throws SQLException {
		String sql="select * from ta_dic_organization  o where o.area_code= ? and o.isLevel=1";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, code);
		pdb.executePrepared();
		CityBean city =null ;
	    if(pdb.size()!=0){
	    	city=new CityBean();
			city.setCode(pdb.getString(0,"org_code"));
			city.setName(pdb.getString(0,"org_name"));
		}
		return city;
		
	}**/
	
	//判断是否有本级处室，如果无则不让添加二级处室
	public boolean getExisOrg(String orgCode) throws Exception{
		int num=Integer.parseInt(orgCode.substring(22,23));
		num-=1;
		String newOrgCode=orgCode.substring(0,22)+num;
		String sql="select org_id from TD_SM_ORGANIZATION o where o.remark1 like '"+newOrgCode+"%'";
		DBUtil db=new DBUtil();
		db.executeSelect(sql);
		if(db.size()!=0)
			return false;
		 return true;
		
	}
	
	//判断用户是否有增加根机构的权限
	public boolean isOperateAdd() throws Exception{
		boolean isOperate=true;
		LoadPropertiesUtil lpu=LoadPropertiesUtil.getInstance();
	    String[] areaCodes=lpu.getPropertiesAreaCode("deploymentConfig.properties", "areaCode");
	    String sql="select * from td_sm_organization t where t.org_xzqm in(";
	    for (int i = 0; i < areaCodes.length; i++) {
			String areaCode=areaCodes[i].toString();
			sql+="'"+areaCode;
			if(i!=areaCodes.length){
				sql+="'";
			}
		 }
	    sql+=")";
	    DBUtil db=new DBUtil();
	    db.executeSelect(sql);
	    if(db.size()>=areaCodes.length){
	    	isOperate=false;
	    }
		return isOperate;
	}
}
