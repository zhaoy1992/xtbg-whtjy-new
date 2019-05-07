
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevborrowFlowDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-5   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import javax.servlet.http.HttpServletRequest;
import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo;

/**
 *<p>Title:DevborrowFlowDaoImpl.java</p>
 *<p>Description:设备借用、归还流程业务类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-5
 */
public class DevborrowFlowDaoImpl extends XtDbBaseDao implements FlowBusiDataSaveDao{

	
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
		//业务类型code
		String busiTypeCode = request.getParameter("busiTypeCode");
		//设备ID
		String sb_id = request.getParameter("TA_OA_DEVBORROW__T_SB_ID");
		if("sbjygh_wp1_act5".equals(action_defid)){
			//设备基本信息
			DevAccountInfo devaccountinfo = new DevAccountInfo();
			//设备ID
			devaccountinfo.setId(sb_id);
			if("uuid_722".equals(busiTypeCode)){//借用环节 修改设备基础信息中设备使用状态
				//设备使用状态  1:在库 2:借出
				devaccountinfo.setDev_stockflag("2");
				DevAccountInfoDaoImpl dao = new DevAccountInfoDaoImpl();
				dao.update(devaccountinfo);
			}else{//归还环节 修改设备基础信息中设备使用状态和设备完好状态
				String dev_state = request.getParameter("dev_state");
				//设备使用状态  1:在库 2:借出
				devaccountinfo.setDev_stockflag("1");
				//设备完好状态  1:完好2:在修 3:报废 4:损耗
				devaccountinfo.setDev_state(dev_state);
				DevAccountInfoDaoImpl dao = new DevAccountInfoDaoImpl();
				dao.update(devaccountinfo);
			}
		}
		return true;
	}
	
}
