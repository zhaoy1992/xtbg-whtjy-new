
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevEquiptaccFlowDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-5   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo;
import com.chinacreator.xtbg.tjy.device.entity.DevAppItem;
import com.chinacreator.xtbg.tjy.device.service.DevAppItemService;
import com.chinacreator.xtbg.tjy.device.service.impl.DevAppItemServiceImpl;

/**
 *<p>Title:DevEquiptaccFlowDaoImpl.java</p>
 *<p>Description:政府采购设备验收流程业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-5
 */
public class DevEquiptaccFlowDaoImpl extends XtDbBaseDao implements FlowBusiDataSaveDao{
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
		//主键ID
		String busi_id = request.getParameter("busi_id");
		if(!StringUtil.isBlank(busi_id)){ 
			//设备ID
			String sb_id = request.getParameter("TA_OA_DEVEQUIPMENTACC__T_SB_ID");
			//物品明细表ID
			String item_id = request.getParameter("TA_OA_DEVEQUIPMENTACC__ITEM_ID"); 
			//设备名称
			String t_sbName = request.getParameter("TA_OA_DEVEQUIPMENTACC__T_SBNAME");
			//规格型号
			String t_ggNo = request.getParameter("TA_OA_DEVEQUIPMENTACC__T_GGNO");
			//生产厂
			String t_factory = request.getParameter("TA_OA_DEVEQUIPMENTACC__T_FACTORY");
			//出厂编号
			String t_ccno = request.getParameter("TA_OA_DEVEQUIPMENTACC__T_CCNO");
			//到货日期
			String t_dhdate = request.getParameter("TA_OA_DEVEQUIPMENTACC__T_DHDATE");
			
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request.getSession());
			//登记人ID
			String user_id = accesscontroler.getUserID();
			//当前用户信息
			String user_name = accesscontroler.getUserName();
			
			//第一个环节 向设备基础信息中加入数据
			if(action_defid.equals("sbzfcgys_wp1_act1")){
				//设备基本信息
				DevAccountInfo devaccountinfo = new DevAccountInfo();
				devaccountinfo.setId(sb_id);
				devaccountinfo.setDev_name(t_sbName);
				devaccountinfo.setType(t_ggNo);
				devaccountinfo.setMake_users(t_factory);
				devaccountinfo.setFactory_no(t_ccno);
				devaccountinfo.setArrive_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(t_dhdate), "yyyy-MM-dd HH:mm:ss.S"));
				devaccountinfo.setCreater_userid(user_id);
				devaccountinfo.setCreater_username(user_name);
				//设备使用状态   1:"在库"
				devaccountinfo.setDev_stockflag("1");
				//设备完好状态   1:"完好"
				devaccountinfo.setDev_state("1");
				//登记时间
				devaccountinfo.setCreat_time(StringUtil.convertStringToTimestamp(DateUtil.getCurrentDate(), "yyyy-mm-dd"));
				DevAccountInfoDaoImpl dao = new DevAccountInfoDaoImpl();
				dao.insert(devaccountinfo);
				
				//修改申请采购中 被设备验证采用 +"1" 标识被领用了一台
				DevAppItem devappitem = new DevAppItem();
				devappitem.setItem_id(item_id);
				//被采用的数量 设置
				DevAppItemService devappitemservice = new  DevAppItemServiceImpl();
				Map<String,String> devappitemMap = devappitemservice.getDevAppItemBeanInfo(item_id);
				devappitem.setItem_sfyz((Integer.valueOf(devappitemMap.get("item_sfyz"))+1)+"");
				DevAppItemDaoImpl devappitemdaoimpl = new DevAppItemDaoImpl();
				
				devappitemdaoimpl.update(devappitem);
			}
			//下个环节
			String xzsp_workflowControl_selectAct = request.getParameter("xzsp_workflowControl_selectAct");
			//自动办结环节
			if(xzsp_workflowControl_selectAct.equals("sbzfcgys_wp1_act5")){
				//设备基本信息
				DevAccountInfo devaccountinfo = new DevAccountInfo();
				devaccountinfo.setId(sb_id);
				devaccountinfo.setDev_name(t_sbName);
				devaccountinfo.setType(t_ggNo);
				devaccountinfo.setMake_users(t_factory);
				devaccountinfo.setFactory_no(t_ccno);
				devaccountinfo.setArrive_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(t_dhdate), "yyyy-MM-dd HH:mm:ss.S"));
				DevAccountInfoDaoImpl dao = new DevAccountInfoDaoImpl();
				dao.update(devaccountinfo);
			}
		} 
		return true;
	}
}
