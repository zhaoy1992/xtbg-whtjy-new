
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevRepairFlowDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-7   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo;

/**
 *<p>Title:DevRepairFlowDaoImpl.java</p>
 *<p>Description:设备维修流程业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-7
 */
public class DevRepairFlowDaoImpl  extends XtDbBaseDao implements FlowBusiDataSaveDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveBusiInfo
	  * @param request
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao#saveBusiInfo(javax.servlet.http.HttpServletRequest, java.sql.Connection) 
	  */
	@Override
	public boolean saveBusiInfo(HttpServletRequest request, Connection conn)
			throws Exception {
		
		//当前环节
		String action_defid = request.getParameter("action_defid");
		//设备ID
		String sb_id = request.getParameter("TA_OA_DEVREPAIR__T_SB_ID");
		//填写申请环节 修改设备基础信息中设备完好状态  
		if(action_defid.equals("sbwx_wp1_act1")){
			//设备基本信息
			DevAccountInfo devaccountinfo = new DevAccountInfo();
			//设备ID
			devaccountinfo.setId(sb_id);
			//设备完好状态  1:完好2:在修 3:报废 4:损耗
			devaccountinfo.setDev_state("4");
			DevAccountInfoDaoImpl dao = new DevAccountInfoDaoImpl();
			dao.update(devaccountinfo);
		}
		
		//下个环节
		String xzsp_workflowControl_selectAct = request.getParameter("xzsp_workflowControl_selectAct");
		//办结环节 修改设备基础信息中设备使用状态和设备完好状态
		if(xzsp_workflowControl_selectAct.equals("sbwx_wp1_act4")){
			//设备基本信息
			DevAccountInfo devaccountinfo = new DevAccountInfo();
			//设备ID
			devaccountinfo.setId(sb_id);
			//设备完好状态  1:完好2:在修 3:报废 4:损耗
			devaccountinfo.setDev_state("2");
			DevAccountInfoDaoImpl dao = new DevAccountInfoDaoImpl();
			dao.update(devaccountinfo);
		}
		return true;
	}

}
