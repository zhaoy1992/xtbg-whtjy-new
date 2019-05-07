
package com.chinacreator.xtbg.pub.personwork.service.impl;


import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.personwork.dao.impl.PriManageDaoImpl;
import com.chinacreator.xtbg.pub.personwork.entity.PGroupBean;
import com.chinacreator.xtbg.pub.personwork.service.*;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
/**
 * 
 * <p>Title: 分组管理biz</p>
 * <p>Description: 分组管理biz</p>
 * <p>Copyright: Copyright (c) 2011</p>
 * <p>Company: chinacreator</p>
 * @author 刘为玮
 * @version 1.0
 * Feb 16, 2012  日期
 *
 */
public class PGroupServiceImpl implements  PGroupServiceIfc{

	
	@Override
	public boolean queryExist(String paramjosn) {
		boolean eflag=false;
		PGroupBean pGroupBean=null;
		pGroupBean=JSONObject.parseObject(paramjosn,PGroupBean.class);
		try {
			PriManageDaoImpl primdao= (PriManageDaoImpl)DaoImplClassUtil.getDaoImplClass("priManageDaoImpl");
			eflag=primdao.queryExist(pGroupBean);
		} catch (Exception e) {
			
		}
		return eflag;
	}
	/**
	 * 权限配置增加条目
	 */
	public boolean pGroupAdd(String paramjosn){
		boolean flag=true;
		PGroupBean pGroupBean=null;
		pGroupBean=JSONObject.parseObject(paramjosn,PGroupBean.class);
		try {
			PriManageDaoImpl primdao= (PriManageDaoImpl)DaoImplClassUtil.getDaoImplClass("priManageDaoImpl");
			flag=primdao.insertGroup(pGroupBean);
		} catch (Exception e) {
			
		}
		return flag;
	}
	
	
	@Override
	public boolean pGroupUpdate(String paramjosn) {
		boolean flag=true;
		PGroupBean pGroupBean=null;
		pGroupBean=JSONObject.parseObject(paramjosn,PGroupBean.class);
		try {
			PriManageDaoImpl primdao= (PriManageDaoImpl)DaoImplClassUtil.getDaoImplClass("priManageDaoImpl");
			flag=primdao.updateGroup(pGroupBean);
		} catch (Exception e) {
			
		}
		return flag;
	}
	/**
	 * 删除分组
	 */
	public boolean pGroupDelete(String groupId){
		boolean flag=true;
		PGroupBean pGroupBean=new PGroupBean();
		if (!StringUtil.isBlank(groupId)) {
			groupId = DataControlUtil.replaceStr(groupId);
			groupId = Escape.unescape(groupId);	
		}
		pGroupBean.setGroupID(groupId);
		try {
			PriManageDaoImpl primdao= (PriManageDaoImpl)DaoImplClassUtil.getDaoImplClass("priManageDaoImpl");
			flag=primdao.deleteGroup(pGroupBean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
}
