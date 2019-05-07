
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevFeedbackFlowDaoImpl.java
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
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.entity.DevSupplier;

/**
 *<p>Title:DevFeedbackFlowDaoImpl.java</p>
 *<p>Description:设备使用反馈流程接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-7
 */
public class DevFeedbackFlowDaoImpl extends XtDbBaseDao implements FlowBusiDataSaveDao {

	
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
		//String action_defid = request.getParameter("action_defid");
		//主键ID
		//String busi_id = request.getParameter("busi_id");
		String xzsp_workflowControl_selectAct = request.getParameter("xzsp_workflowControl_selectAct");
		//办结环节
		if(xzsp_workflowControl_selectAct.equals("sbsyfk_wp1_act4")){ 
			//供货商ID
			String devsup_id = request.getParameter("TA_OA_DEVFEEDBACK__DEVSUP_ID");
			//供应商名称
			String devsup_mc = request.getParameter("TA_OA_DEVFEEDBACK__T_DEVSUP_MC"); 
			//收录时间
			String devsup_slsj = request.getParameter("TA_OA_DEVFEEDBACK__T_XJSJ");
			//供方性质
			String devsup_gfxz = request.getParameter("TA_OA_DEVFEEDBACK__T_DEVSUP_GFXZ");
			//供方类别
			String devsup_gflb = request.getParameter("TA_OA_DEVFEEDBACK__T_DEVSUP_GFLB");
			//供方地址
			String devsup_gfdz = request.getParameter("TA_OA_DEVFEEDBACK__T_DEVSUP_GFDZ");
			//法定代表人
			String devsup_fddbr = request.getParameter("TA_OA_DEVFEEDBACK__T_DEVSUP_FDDBR");
			//联系代表
			String devsup_lxdb = request.getParameter("TA_OA_DEVFEEDBACK__T_DEVSUP_LXDB");
			//联系电话
			String devsup_lxdh = request.getParameter("TA_OA_DEVFEEDBACK__T_DEVSUP_LXDH");
			//信誉度
			String devsup_xyd = request.getParameter("TA_OA_DEVFEEDBACK__T_DEVSUP_XYD");
			//提供产品
			String devsup_tgcp = request.getParameter("TA_OA_DEVFEEDBACK__T_DEVSUP_TGCP");
			
			//设备基本信息
			DevSupplier devsupplier = new DevSupplier();
			//供应商名称
			devsupplier.setDevsup_mc(devsup_mc);
			//收录时间
			devsupplier.setDevsup_slsj(StringUtil.convertStringToTimestamp(StringUtil.deNull(devsup_slsj), "yyyy-MM-dd HH:mm:ss.S"));
			//供方性质
			devsupplier.setDevsup_gfxz(devsup_gfxz);
			//供方类别
			devsupplier.setDevsup_gflb(devsup_gflb);
			//供方地址
			devsupplier.setDevsup_gfdz(devsup_gfdz);
			//法定代表人
			devsupplier.setDevsup_fddbr(devsup_fddbr);
			//联系代表
			devsupplier.setDevsup_lxdb(devsup_lxdb);
			//联系电话
			devsupplier.setDevsup_lxdh(devsup_lxdh);
			//信誉度
			devsupplier.setDevsup_xyd(devsup_xyd);
			//是否有效
			devsupplier.setDevsup_sfyx("1");
			//提供产品
			devsupplier.setDevsup_tgcp(devsup_tgcp);
			
			DevSupplierDaoImpl dao = new DevSupplierDaoImpl();
			//供应商主键
			if(StringUtil.isBlank(devsup_id)){
				devsupplier.setDevsup_id(StringUtil.getUUID());
				dao.insert(devsupplier);
			} else {
				dao.update(devsupplier);
			}
		} 
		return true;
	}

}
