
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAppItemFlowDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-27   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.entity.DevAppItem;
import com.chinacreator.xtbg.tjy.device.service.DevAppItemService;
import com.chinacreator.xtbg.tjy.device.service.impl.DevAppItemServiceImpl;

/**
 *<p>Title:DevAppItemFlowDaoImpl.java</p>
 *<p>Description:政府采购申请流程业务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-27
 */
public class DevAppItemFlowDaoImpl extends XtDbBaseDao implements FlowBusiDataSaveDao{

	
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
		//业务类型Code
		//String busiTypeCode = request.getParameter("busiTypeCode");
		//主键ID
		String busi_id = request.getParameter("busi_id");
		//物品名称  
		String[] array_name = request.getParameterValues("item_name");
		//型号规格
		String[] array_type = request.getParameterValues("item_type");
		//技术参数
		String[] array_jscs = request.getParameterValues("item_jscs");
		//推荐制造厂家
		String[] array_tjzccj = request.getParameterValues("item_tjzccj");
		//数量
		String[] array_sl = request.getParameterValues("item_sl");
		//购置理由
		String[] array_gzly = request.getParameterValues("item_gzly");
		//预算费用
		String[] array_ysfy = request.getParameterValues("item_ysfy");
		
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(request.getSession());
		//登记人ID
		String user_id = accesscontroler.getUserID();
		//当前用户信息
		String user_name = accesscontroler.getUserName();
		
		if(!StringUtil.isBlank(busi_id)){
			DevAppItemService devappitemservice = new DevAppItemServiceImpl();
			//删除物品列表数据
			devappitemservice.deleteDevAppItemByIds(new String[]{busi_id});
			//添加物品列表数据
			for(int i = 0;i< array_name.length;i++){
				DevAppItem devappitem = new DevAppItem();
				//申购ID
				devappitem.setItem_plainid(busi_id);
				//物品排序号
				devappitem.setItem_no(i+"");
				//物品名称
				devappitem.setItem_name(array_name[i]);
				//型号规格
				devappitem.setItem_type(array_type[i]);
				//技术参数
				devappitem.setItem_jscs(array_jscs[i]);
				//推荐制造厂家
				devappitem.setItem_tjzccj(array_tjzccj[i]);
				//数量
				devappitem.setItem_sl(array_sl[i]);
				//购置理由
				devappitem.setItem_gzly(array_gzly[i]);
				//预算费用
				devappitem.setItem_ysfy(array_ysfy[i]);
				//被设备验证采用数量  默认为'0'
				devappitem.setItem_sfyz("0");
				//院长审批
				if(action_defid.equals("sbzfcg_wp1_act4")){
					//批准人ID
					devappitem.setItem_pzrid(user_id);
					//批准人名称
					devappitem.setItem_pzrmc(user_name);
				}
				//增加
				devappitemservice.insertOrUpdateDevAppItem(devappitem);
			}
		} 
		
		return true;
	}
		
}
