package com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.cache.OrgCache;
import com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsHavaLYObjectBean;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsHavaObjectBean;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsNoMoveObjectBean;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsofficeAccountBean;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OfficeDetailService;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsHavaObjectService;

/**
 * 
 *<p>Title:AddOrUpdateOsNoMoveObject.java</p>
 *<p>Description:固定资产登记物品业务数据处理</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-12
 */
public class AddOrUpdateOsNoMoveObject extends XtDbBaseDao implements FlowBusiDataSaveDao{

	private static final Log LOG=LogFactory.getLog(AddOrUpdateOsNoMoveObject.class);

	/**
	 * 
	  * <b>Summary: 固定资产登记物品业务数据处理</b>
	  *     复写方法 saveBusiInfo
	  * @param request
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao#saveBusiInfo(javax.servlet.http.HttpServletRequest, java.sql.Connection)
	 */
	public boolean saveBusiInfo(HttpServletRequest request, Connection conn)
			throws Exception {

		 //物品名称
	    String[] OFUSTYPE_NAME_VALUE_Arr = request.getParameterValues("OFUSTYPE_NAME_VALUE");
	    
	    //物品规格名称
	    String[] IT_NAME_VALUE_Arr = request.getParameterValues("IT_NAME_VALUE");
	    
	    //物品分类ID
	    String[] OFTYPE_ID_Arr = request.getParameterValues("OFTYPE_ID");
	    
	    //物品分类name
		String[] OFTYPE_NAME_Arr = request.getParameterValues("OFTYPE_NAME");
		
		//登记物品主键ID
		String[] T_NOMOVE_OB_ID_Arr = request.getParameterValues("T_NOMOVE_OB_ID");
		
		//库存物品主键ID
		String[] T_HA_ID_Arr = request.getParameterValues("T_HA_ID");
		
		//备注
		String[] T_NOMOVE_OB_BZ_Arr = request.getParameterValues("T_NOMOVE_OB_BZ");
		
		//环节ID
		String action_defid = request.getParameter("action_defid");
		
		//固定资产登记表ID
		String busi_id = request.getParameter("busi_id");
		
		//相关库存物品IDs
		String osAppIds = request.getParameter("TA_OA_CANOSNOMOVE__T_HAVA_IDS");
		
		//部门ID
		String org_id = request.getParameter("org_id");
		
		//部门名称
		String org_name = request.getParameter("orgName");
		
		//填写人ID
		String user_id = request.getParameter("TA_OA_CANOSNOMOVE__T_OSNOM_USER_ID");
		
		//填写人名称
		String user_name = request.getParameter("TA_OA_CANOSNOMOVE__T_OSNOM_USER_NAME");
		
		//领用日期
		String lyDate = request.getParameter("TA_OA_CANOSNOMOVE__T_OSNOM_DATE");
		
		//设备编号
		String[] T_HA_SBNO_Arr = request.getParameterValues("T_HA_SBNO");
		
		//领用部门ID
		String t_osnom_org_id = request.getParameter("TA_OA_CANOSNOMOVE__T_OSNOM_ORG_ID");
		//领用部门名称
		String t_osnom_org_name = request.getParameter("TA_OA_CANOSNOMOVE__T_OSNOM_ORG_NAME");
		
		//暂存状态
		String doTempState = StringUtil.deNull(request.getParameter("doTempState")); 
		
		if (!StringUtil.isBlank(busi_id)) {
			OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
			
			//删除物品表中数据
			osHavaObjectService.deleteOsNoMoveObjectByIds(new String[]{busi_id});
			
			//添加物品表中数据
			for (int i = 0; i < T_HA_ID_Arr.length; i++) {
				OsNoMoveObjectBean osNoMoveObjectBean = new OsNoMoveObjectBean();
				if (!StringUtil.isBlank(T_HA_ID_Arr[i])) {
					osNoMoveObjectBean.setT_nomove_ob_id(T_NOMOVE_OB_ID_Arr[i]);
					osNoMoveObjectBean.setOftype_id(OFTYPE_ID_Arr[i]);
					osNoMoveObjectBean.setOftype_name(OFTYPE_NAME_Arr[i]);
					osNoMoveObjectBean.setOfustype_name(OFUSTYPE_NAME_VALUE_Arr[i]);
					osNoMoveObjectBean.setIt_name(IT_NAME_VALUE_Arr[i]);
					osNoMoveObjectBean.setT_nomove_ob_bz(T_NOMOVE_OB_BZ_Arr[i]);
					osNoMoveObjectBean.setT_osnom_id(busi_id);
					osNoMoveObjectBean.setT_ha_id(T_HA_ID_Arr[i]);
					osHavaObjectService.insertOrUpdateNoMoveObject(osNoMoveObjectBean);
					
					//不是暂存
					if(!doTempState.equals("1")){
						if ("gdzcly_wp1_act6".equals(action_defid)) {  //物品发放环节
							osHavaObjectService.updateHavaObjectForIds(T_HA_ID_Arr[i]);//更新库存表状态
							OsHavaObjectBean osHavaObjectBean = new OsHavaObjectBean();
							osHavaObjectBean.setT_ha_org_id(t_osnom_org_id);
							osHavaObjectBean.setT_ha_org_name(t_osnom_org_name);
							osHavaObjectBean.setT_ha_id(T_HA_ID_Arr[i]);
							osHavaObjectBean.setT_ha_sbno(T_HA_SBNO_Arr[i]);
							osHavaObjectService.updateHavaObjectOrg(osHavaObjectBean);   // 更新库存固定资产所属部门
							
							OsHavaLYObjectBean osHavaLYObjectBean = new OsHavaLYObjectBean();
							osHavaLYObjectBean.setOftype_id(OFTYPE_ID_Arr[i]);
							osHavaLYObjectBean.setOftype_name(OFTYPE_NAME_Arr[i]);
							osHavaLYObjectBean.setOfustype_name(OFUSTYPE_NAME_VALUE_Arr[i]);
							osHavaLYObjectBean.setIt_name(IT_NAME_VALUE_Arr[i]);
							osHavaLYObjectBean.setT_ha_sbno(T_HA_SBNO_Arr[i]);
							osHavaLYObjectBean.setT_ha_id(T_HA_ID_Arr[i]);
							osHavaLYObjectBean.setT_ly_date(lyDate);
							osHavaLYObjectBean.setT_ly_org_id(t_osnom_org_id);
							osHavaLYObjectBean.setT_ly_org_name(t_osnom_org_name);
							osHavaLYObjectBean.setT_ly_user_id(user_id);
							osHavaLYObjectBean.setT_ly_user_name(user_name);
							osHavaLYObjectBean.setT_lydj_id(busi_id);
							osHavaObjectService.insertOrUpdateHavaLYObject(osHavaLYObjectBean);
							
							//更新固定资产台帐信息
							OrgCacheBean orgcachebean= OrgCache.getOrgCacheBean(t_osnom_org_id);
							List<Map<String, String>> mapbean = osHavaObjectService.queryHavaObjectByHaId(T_HA_ID_Arr[i]);
							OsofficeAccountBean osofficeaccountbean = new OsofficeAccountBean();
							osofficeaccountbean.setCode(T_HA_SBNO_Arr[i]);//标识卡编号
							osofficeaccountbean.setName(OFUSTYPE_NAME_VALUE_Arr[i]);//名称
							osofficeaccountbean.setType(OFTYPE_NAME_Arr[i]+"/"+IT_NAME_VALUE_Arr[i]);//规格\型号
							osofficeaccountbean.setMoney(mapbean.get(0).get("t_ha_dj"));//金额
							osofficeaccountbean.setReceive_day(StringUtil.deNull(DateUtil.getCurrentDate()));//领取时间
							osofficeaccountbean.setReceive_username(user_name);//领用人
							osofficeaccountbean.setOrg_id(t_osnom_org_id);//领用部门ID
							osofficeaccountbean.setOrg_name(t_osnom_org_name);//领用部门名称
							osofficeaccountbean.setUnit_id(orgcachebean.getUnit_id());
							osofficeaccountbean.setUnit_name(orgcachebean.getUnit_name());
							OfficeDetailService officedetailservice = new OfficeDetailServiceImpl();
							officedetailservice.insertOrUpdateOfficeDetail(osofficeaccountbean);
						}
					}
				}
			}
		}
		
		
		return true;
	}
}
