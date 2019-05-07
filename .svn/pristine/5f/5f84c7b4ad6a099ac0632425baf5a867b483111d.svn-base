package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import javax.servlet.http.HttpServletRequest;
import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo;

/**
 * 
 *<p>Title:DevTransferFlowDaoImpl.java</p>
 *<p>Description:设备出租、调拨流程业务类</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author 陈郊
 *@version 1.0
 *@CreateDate:2015-12-21
 */
public class DevTransferFlowDaoImpl extends XtDbBaseDao implements FlowBusiDataSaveDao{

	
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
		String sb_id = request.getParameter("TA_OA_DEVTRANSFER__T_SB_ID");
		//System.out.println("设备出租、调拨流程业务类");
		if("sbjygh_wp1_act5".equals(action_defid)){
			//设备基本信息
			DevAccountInfo devaccountinfo = new DevAccountInfo();
			//设备ID
			devaccountinfo.setId(sb_id);
			if("yqsb_zccz".equals(busiTypeCode)){//出租环节
				//设备使用状态  1:在库 2:借出 3:出租
				devaccountinfo.setDev_stockflag("3");
				DevAccountInfoDaoImpl dao = new DevAccountInfoDaoImpl();
				dao.update(devaccountinfo);
			}else{//调拨环节 修改设备基础信息中设备使用状态
				//设备使用状态  1:在库 2:借出 3:出租 4:调拨
				devaccountinfo.setDev_stockflag("4");
				String user_orgid = request.getParameter("TA_OA_DEVTRANSFER__T_LYORG_ID");
				String user_orgname = request.getParameter("TA_OA_DEVTRANSFER__T_LYORG_MC");
				String custos_userid = request.getParameter("TA_OA_DEVTRANSFER__T_JBR_ID");
				String custos_username = request.getParameter("TA_OA_DEVTRANSFER__T_JRE_MC");
				devaccountinfo.setUser_orgid(user_orgid);
				devaccountinfo.setUser_orgname(user_orgname);
				devaccountinfo.setCustos_userid(custos_userid);
				devaccountinfo.setCustos_username(custos_username);
				DevAccountInfoDaoImpl dao = new DevAccountInfoDaoImpl();
				dao.update(devaccountinfo);
			}
		}
		return true;
	}
}
