package com.chinacreator.xtbg.tjy.detectionsupplies.service.impl;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsAppRegObjectBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsHavaLYObjectBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsHavaObjectBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.service.OsHavaObjectService;

/**
 * 
 *<p>Title:AddOrUpdateOsAppRegObject.java</p>
 *<p>Description: 易耗品登记物品业务处理类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-11
 */
public class AddOrUpdateOsAppRegObject extends XtDbBaseDao implements FlowBusiDataSaveDao{

	private static final Log LOG = LogFactory.getLog(AddOrUpdateOsAppRegObject.class);

	/**
	 * 
	  * <b>Summary: 易耗品登记物品数据处理</b>
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
	    //String[] OFUSTYPE_NAME_VALUE_Arr = request.getParameterValues("OFUSTYPE_NAME_VALUE");
		String[] OFUSTYPE_NAME_VALUE_Arr = request.getParameterValues("OFUSTYPE_SELECT");
	    
	    //物品ID
	    String[] OFUSTYPE_ID_VALUE_Arr = request.getParameterValues("OFUSTYPE_ID_VALUE");
	    
	    //物品规格名称
	   // String[] IT_NAME_VALUE_Arr = request.getParameterValues("IT_NAME_VALUE");
	    String[] IT_NAME_VALUE_Arr = request.getParameterValues("IT_NAME_SELECT");
	    
	    //物品规格ID
	    String[] IT_ID_VALUE_Arr = request.getParameterValues("IT_ID_VALUE");
	    
	    //物品分类ID
	    String[] OFTYPE_ID_Arr = request.getParameterValues("OFTYPE_ID");
	    
	    //物品分类name
		String[] OFTYPE_NAME_Arr = request.getParameterValues("OFTYPE_NAME");
		
		//登记物品主键ID
		String[] T_OSAPPREG_OB_ID_Arr = request.getParameterValues("T_OSAPPREG_OB_ID");
		
		//数量
		String[] T_OSAPPREG_OB_NO_Arr = request.getParameterValues("T_OSAPPREG_OB_NO");
		
		//备注
		String[] T_OSAPPREG_OB_BZ_Arr = request.getParameterValues("T_OSAPPREG_OB_BZ");
		
		//物品添加方式
		String[] ADD_STATE = request.getParameterValues("ADD_STATE");
		
		//环节ID
		String action_defid = request.getParameter("action_defid");
		
		//易耗品登记表ID
		String busi_id = request.getParameter("busi_id");
		
		//相关计划表IDs
		String osAppIds = request.getParameter("TA_OA_DETOSAPPREGYHP__T_APPREGYHP_APPIDS");
		
		//部门ID
		String org_id = request.getParameter("org_id");
		
		//部门名称
		String org_name = request.getParameter("orgName");
		
		//填写人ID
		String user_id = request.getParameter("TA_OA_DETOSAPPREGYHP__T_APPREGYHP_USER_ID");
		
		//填写人名称
		String user_name = request.getParameter("TA_OA_DETOSAPPREGYHP__T_APPREGYHP_USER_NAME");
		
		//领用日期
		String lyDate = request.getParameter("TA_OA_DETOSAPPREGYHP__T_APPREGYHP_DATE");
		
		if (!StringUtil.isBlank(busi_id)) {
			OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
			
			//删除物品表中数据
			osHavaObjectService.deleteOsAppRegObjectByIds(new String[]{busi_id});
			
			//添加物品表中数据
			for (int i = 0; i < T_OSAPPREG_OB_NO_Arr.length; i++) {
				if ((!T_OSAPPREG_OB_NO_Arr[i].equals("0")) && (!StringUtil.isBlank(T_OSAPPREG_OB_NO_Arr[i])) && (!StringUtil.isBlank(IT_ID_VALUE_Arr[i]))) {
					
					String[] NEW_IT_ID_VALUE_Arr = IT_NAME_VALUE_Arr[i].split(";");
        			
        			String[] NEW_OFUSTYPE_ID_VALUE_Arr = OFUSTYPE_NAME_VALUE_Arr[i].split(";");
        			
					OsAppRegObjectBean osAppRegObjectBean = new OsAppRegObjectBean();
					osAppRegObjectBean.setT_osappreg_ob_id(T_OSAPPREG_OB_ID_Arr[i]);
					osAppRegObjectBean.setIt_id(IT_ID_VALUE_Arr[i]);
					
					//物品规格名称
					String tempIt_ID_values="";
					if (NEW_IT_ID_VALUE_Arr.length == 1) {
						tempIt_ID_values="";
					}else{
						tempIt_ID_values = NEW_IT_ID_VALUE_Arr[1];
					}
					osAppRegObjectBean.setIt_name(tempIt_ID_values);
					//osAppRegObjectBean.setIt_name(IT_NAME_VALUE_Arr[i]);
					osAppRegObjectBean.setOftype_id(OFTYPE_ID_Arr[i]);
					osAppRegObjectBean.setOftype_name(OFTYPE_NAME_Arr[i]);
					osAppRegObjectBean.setOfustype_id(OFUSTYPE_ID_VALUE_Arr[i]);
					//物品名称
					String tempNew_Ofusertype_name="";
					if (NEW_OFUSTYPE_ID_VALUE_Arr.length == 1) {
						tempNew_Ofusertype_name = "";
					}else{
						tempNew_Ofusertype_name = NEW_OFUSTYPE_ID_VALUE_Arr[1];
					}
					osAppRegObjectBean.setOfustype_name(tempNew_Ofusertype_name);
					osAppRegObjectBean.setT_osappreg_ob_no(T_OSAPPREG_OB_NO_Arr[i]);
					osAppRegObjectBean.setT_osappreg_ob_bz(T_OSAPPREG_OB_BZ_Arr[i]);
					osAppRegObjectBean.setAdd_state(ADD_STATE[i]);//物品添加方式
					osAppRegObjectBean.setT_appregyhp_id(busi_id);
					
					osHavaObjectService.insertOrUpdateOsAppRegObject(osAppRegObjectBean);
					
					if ("yhply_wp1_act2".equals(action_defid)) {
						osHavaObjectService.updateOsAppFroReg(osAppIds);  //更新相关计划表的状态
						//更新库存表信息
						OsHavaObjectBean osHavaObjectBean = new OsHavaObjectBean();
						osHavaObjectBean.setIt_id(IT_ID_VALUE_Arr[i]);
						osHavaObjectBean.setT_ha_no(T_OSAPPREG_OB_NO_Arr[i]);
						osHavaObjectService.updateOsHavaObject(osHavaObjectBean);
						
						OsHavaLYObjectBean osHavaLYObjectBean = new OsHavaLYObjectBean();
						osHavaLYObjectBean.setOftype_id(OFTYPE_ID_Arr[i]);
						osHavaLYObjectBean.setOftype_name(OFTYPE_NAME_Arr[i]);
						osHavaLYObjectBean.setOfustype_id(OFUSTYPE_ID_VALUE_Arr[i]);
						osHavaLYObjectBean.setOfustype_name(tempNew_Ofusertype_name);
						osHavaLYObjectBean.setIt_id(IT_ID_VALUE_Arr[i]);
						osHavaLYObjectBean.setIt_name(tempIt_ID_values);
						osHavaLYObjectBean.setT_ly_no(T_OSAPPREG_OB_NO_Arr[i]);
						osHavaLYObjectBean.setT_ly_date(lyDate);
						osHavaLYObjectBean.setT_ly_org_id(org_id);
						osHavaLYObjectBean.setT_ly_org_name(org_name);
						osHavaLYObjectBean.setT_ly_user_id(user_id);
						osHavaLYObjectBean.setT_ly_user_name(user_name);
						osHavaLYObjectBean.setT_lydj_id(busi_id);
						osHavaObjectService.insertOrUpdateHavaLYObject(osHavaLYObjectBean);
						LOG.info("success");
					}
				}
			}
		}
		return true;
	}
}
