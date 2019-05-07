package com.chinacreator.xtbg.tjy.detectionsupplies.service.impl;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsAppObjectBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.service.OsAppObjectService;

/**
 * 
 *<p>Title:AddOrUpdateOsAppServiceImpl.java</p>
 *<p>Description: 办公用品申购计划流程业务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-6
 */
public class AddOrUpdateOsAppServiceImpl extends XtDbBaseDao implements FlowBusiDataSaveDao{
	
	private static final Log LOG=LogFactory.getLog(AddOrUpdateOsAppServiceImpl.class);

	/**
	 * 
	  * <b>Summary: 处理添加入计划表的物品数据</b>
	  *     复写方法 saveBusiInfo
	  * @param request
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao#saveBusiInfo(javax.servlet.http.HttpServletRequest, java.sql.Connection)
	 */
	public boolean saveBusiInfo(HttpServletRequest request, Connection conn)
			throws Exception {
        //计划表ID
        String sub_id  =  request.getParameter("busi_id");
        
        //机构ID
        String org_id  =  request.getParameter("TA_OA_DETOSAPPLAN__T_ORG_ID");
        
        //机构名称
        String orgName  =  request.getParameter("TA_OA_DETOSAPPLAN__T_ORG_NAME");
        
        //主键ID
        String[] T_OS_OB_ID_Arr = request.getParameterValues("T_OS_OB_ID");
        // 所属单位
        String unit_id  =  request.getParameter("TA_OA_DETOSAPPLAN__UNIT_ID");
        String unit_name  =  request.getParameter("TA_OA_DETOSAPPLAN__UNIT_NAME");
        //数量
        String[] T_OS_OB_NO_Arr = request.getParameterValues("T_OS_OB_NO");
        
        //物品名称
        String[] OFUSTYPE_NAME_VALUE_Arr = request.getParameterValues("OFUSTYPE_NAME_VALUE");
        
        //物品ID
        String[] OFUSTYPE_ID_VALUE_Arr = request.getParameterValues("OFUSTYPE_ID_VALUE");
        
        //物品规格名称
        String[] IT_NAME_VALUE_Arr = request.getParameterValues("IT_NAME_VALUE");
        
        //物品规格ID
        String[] IT_ID_VALUE_Arr = request.getParameterValues("IT_ID_VALUE");
        
        //备注
        String[] T_OS_OB_BZ_Arr = request.getParameterValues("T_OS_OB_BZ");
        
        
        if(!StringUtil.isBlank(sub_id)){
        	OsAppObjectService objectService = new OsAppObjectServiceImpl();
        	//删除物品表中数据
        	objectService.deleteOsAppObjectByIds(new String[]{sub_id});
        	
        	//添加物品表中数据
        	for (int i = 0; i < T_OS_OB_NO_Arr.length; i++) {
        		if ((!T_OS_OB_NO_Arr[i].equals("0")) && (!StringUtil.isBlank(T_OS_OB_NO_Arr[i]))) {
        			OsAppObjectBean objectBean = new OsAppObjectBean();
        			
        			String[] NEW_IT_ID_VALUE_Arr = IT_ID_VALUE_Arr[i].split(";");
        			
        			String[] NEW_OFUSTYPE_ID_VALUE_Arr = OFUSTYPE_ID_VALUE_Arr[i].split(";");
        			
        			if (NEW_IT_ID_VALUE_Arr.length == 1) {
        				objectBean.setIt_id("");
					}else{
						objectBean.setIt_id(NEW_IT_ID_VALUE_Arr[1]);
					}
        			
        			if (NEW_OFUSTYPE_ID_VALUE_Arr.length == 1) {
        				objectBean.setOfustype_id("");
					}else{
						objectBean.setOfustype_id(NEW_OFUSTYPE_ID_VALUE_Arr[1]);
					}
        			
        			//物品名称
        			objectBean.setOfustype_name(OFUSTYPE_NAME_VALUE_Arr[i]);
        			//规格名称
        			objectBean.setIt_name(IT_NAME_VALUE_Arr[i]);
        			//主键ID
        			objectBean.setT_os_ob_id(T_OS_OB_ID_Arr[i]);
        			//计划ID
        			//所属单位
        			objectBean.setUnit_id(unit_id);
        			objectBean.setUnit_name(unit_name);
        			objectBean.setT_id(sub_id);
        			//计划表申请部门ID
        			objectBean.setT_org_id(org_id);
        			//计划表申请部门名称
        			objectBean.setT_org_name(orgName);
        			//备注
        			objectBean.setT_os_ob_bz(T_OS_OB_BZ_Arr[i]);
        			//数量
        			objectBean.setT_os_ob_no(T_OS_OB_NO_Arr[i]);
        			
        			objectService.insertOrUpdateOsApp(objectBean);
        		}
        	}
        }
		return true;
	}

}
