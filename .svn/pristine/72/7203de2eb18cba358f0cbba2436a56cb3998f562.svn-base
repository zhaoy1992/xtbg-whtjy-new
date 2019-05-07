
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevSettlItemFlowDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo;
import com.chinacreator.xtbg.tjy.device.entity.DevEquipmentaccBean;
import com.chinacreator.xtbg.tjy.device.entity.DevSettleItemBean;
import com.chinacreator.xtbg.tjy.device.service.DevEquipmentaccService;
import com.chinacreator.xtbg.tjy.device.service.DevSettleItemService;
import com.chinacreator.xtbg.tjy.device.service.impl.DevEquipmentaccServiceImpl;
import com.chinacreator.xtbg.tjy.device.service.impl.DevSettleItemServiceImpl;

/**
 *<p>Title:DevSettlItemFlowDaoImpl.java</p>
 *<p>Description:采购验收结算物品列表流程业务类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-18
 */
public class DevSettlItemFlowDaoImpl extends XtDbBaseDao implements FlowBusiDataSaveDao{

	
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
		String busi_id = request.getParameter("busi_id");
		//货品名称
		String[] array_name = request.getParameterValues("item_name");
		//型号规格
		String[] array_type = request.getParameterValues("item_type");
		//数量
		String[] array_count = request.getParameterValues("item_count");
		//单价
		String[] array_price = request.getParameterValues("item_price");
		//货品验收表信息
		String [] devquipmentaccVo = request.getParameterValues("devquipmentaccVo");
		//下个环节
		String xzsp_workflowControl_selectAct = request.getParameter("xzsp_workflowControl_selectAct");
		//设备ID 基本信息表主键
		String t_sb_id ="";
		if(!StringUtil.isBlank(busi_id)){ 
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request.getSession());
			//登记人ID
			String user_id = accesscontroler.getUserID();
			//当前用户信息
			String user_name = accesscontroler.getUserName();
			DevEquipmentaccBean devequipmentaccbean = null;
			if(!StringUtil.isBlank(busi_id)){
				DevSettleItemService devsettleitemservice = new DevSettleItemServiceImpl();//货品列表
				DevEquipmentaccService devequipmentaccservice = new DevEquipmentaccServiceImpl();//验收单
				devequipmentaccservice.deleteDevEquipmentaccByIds(new String[]{busi_id});//删除这个流程中验收单数据
				devsettleitemservice.deleteDevSettleItemByIds(new String[]{busi_id});//删除货品列表数据
				
				//添加物品列表数据
				for(int i = 0;i< array_name.length;i++){
					//采购验收单表单
					if (!StringUtil.isBlank(devquipmentaccVo[i])) {
						devequipmentaccbean = (DevEquipmentaccBean) JSONObject.parseObject(devquipmentaccVo[i], DevEquipmentaccBean.class);
					}
					DevSettleItemBean devsettleitembean = new DevSettleItemBean();
					//结算表ID
					devsettleitembean.setDevsettle_id(busi_id);
					//货品排序
					devsettleitembean.setItem_no(i+"");
					//物品名称
					devsettleitembean.setItem_name(array_name[i]);
					//型号规格
					devsettleitembean.setItem_type(array_type[i]);
					//数量
					devsettleitembean.setItem_count(array_count[i]);
					//价格
					devsettleitembean.setItem_price(array_price[i]);
					t_sb_id = StringUtil.getUUID();
					devequipmentaccbean.setT_sb_id(t_sb_id);//设置设备ID
					devequipmentaccbean.setT_id("");//设置主键
					//增加验收单bean
					String devEquimentId = devequipmentaccservice.insertOrUpdateDevEquipmentacc(devequipmentaccbean);
					//验收单ID
					devsettleitembean.setItem_reportid(devEquimentId);
					//增加货品bean
					devsettleitemservice.insertOrUpdateDevSettleItem(devsettleitembean);
					
					//自动办结环节
					if(xzsp_workflowControl_selectAct.equals("sbzfcgys_wp1_act5")){
						//设备基本信息
						DevAccountInfo devaccountinfo = new DevAccountInfo();
						devaccountinfo.setId(t_sb_id);
						devaccountinfo.setDev_name(devequipmentaccbean.getT_sbname());
						devaccountinfo.setType(devequipmentaccbean.getT_ggno());
						devaccountinfo.setMake_users(devequipmentaccbean.getT_factory());
						devaccountinfo.setFactory_no(devequipmentaccbean.getT_ccno());
						devaccountinfo.setArrive_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(devequipmentaccbean.getT_dhdate()), "yyyy-MM-dd HH:mm:ss.S"));
						devaccountinfo.setCreater_userid(user_id);
						devaccountinfo.setCreater_username(user_name);
						devaccountinfo.setPrice(array_price[i]);
						//设备使用状态   1:"在库"
						devaccountinfo.setDev_stockflag("1");
						//设备完好状态   1:"完好"
						devaccountinfo.setDev_state("1");
						//登记时间
						devaccountinfo.setCreat_time(StringUtil.convertStringToTimestamp(DateUtil.getCurrentDate(), "yyyy-mm-dd"));
						DevAccountInfoDaoImpl dao = new DevAccountInfoDaoImpl();
						dao.insert(devaccountinfo);
					}
				}
			} 
		}
		return true;
	}

}
