
package com.chinacreator.xtbg.pub.personwork.service.impl;

import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.personwork.dao.impl.PriManageDaoImpl;
import com.chinacreator.xtbg.pub.personwork.entity.PriManageBean;
import com.chinacreator.xtbg.pub.personwork.service.PriManageServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
/**
 * 
 * <p>Title: 通讯录权限配置biz</p>
 * <p>Description: 通讯录权限配置biz</p>
 * <p>Copyright: Copyright (c) 2011</p>
 * <p>Company: chinacreator</p>
 * @author 刘为玮
 * @version 1.0
 * Feb 15, 2012  日期
 *
 */
public class PriManageServiceImpl implements  PriManageServiceIfc{

	
	/**
	 * 权限配置增加条目
	 */
	public boolean priManageAdd(String paramjosn){
		boolean flag=false;
		PriManageBean pBean=null;
		pBean=JSONObject.parseObject(paramjosn,PriManageBean.class);
		String strName[]=pBean.getLeadName().split("[\\,,\\，]");
		String strID[]=pBean.getLeadsID().split("[\\,,\\，]");
		try {
			PriManageDaoImpl primdao= (PriManageDaoImpl)DaoImplClassUtil.getDaoImplClass("priManageDaoImpl");
			for(int i=0;i<strName.length;i++){
				pBean.setLeadID(strID[i]);
				List list=primdao.queryUserID(pBean);
				if(list.size()!=0){
					for(int j=0;j<list.size();j++){
						PriManageBean priManageBean=new PriManageBean();
						priManageBean=(PriManageBean)list.get(j);
						String oldPersons=priManageBean.getReLeaders();
						String newPersons=pBean.getPersons();
						String oldPersonsID=priManageBean.getRepersonsID();
						String newPersonsID=pBean.getPersonsID();
						newPersons=deleteRe(oldPersons, newPersons);
						newPersonsID=deleteRe(oldPersonsID, newPersonsID);
						pBean.setPersons(newPersons);
						pBean.setPersonsID(newPersonsID);
						flag=primdao.updatePriInfo(pBean);
					}
				}else {
					flag=primdao.insertPrivilege(pBean);
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	/**
	 * 删除记录
	 */
	public boolean priManageDelete(String flowids){
		boolean flag=false;
		PriManageBean pBean=null;
		pBean=JSONObject.parseObject(flowids,PriManageBean.class);
		String strID[]=pBean.getLeadsID().split("[\\,,\\，]");
		try {
			PriManageDaoImpl primdao= (PriManageDaoImpl)DaoImplClassUtil.getDaoImplClass("priManageDaoImpl");
			for(int i=0;i<strID.length;i++){
				pBean.setLeadID(strID[i]);
				flag=primdao.deletePriInfo(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}
	/**
	 * 查询单调记录
	 */
	public PriManageBean querySingle(PriManageBean pBean){
		
		try {
			PriManageDaoImpl primdao= (PriManageDaoImpl)DaoImplClassUtil.getDaoImplClass("priManageDaoImpl");
			pBean=primdao.querySingle(pBean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return pBean;
	}
	
	
	/**
	 * 去掉重复字符
	 */
	public String deleteRe(String oldstr,String newstr){
		StringBuffer stringBuffer=new StringBuffer();
		newstr=oldstr+","+newstr;
		String[] strs=newstr.split("[\\,,\\，]");
		Set set = new TreeSet();
		for (int i = 0; i < strs.length; i++) {
			set.add(strs[i]);
		}
		strs = (String[]) set.toArray(new String[0]);
		for (int i = 0; i < strs.length; i++) {
			if(i!=strs.length-1){
				stringBuffer.append(strs[i]+",");
			}else{
				stringBuffer.append(strs[i]);
			}
		}
		newstr=stringBuffer.toString();
		return newstr;
	}
}
