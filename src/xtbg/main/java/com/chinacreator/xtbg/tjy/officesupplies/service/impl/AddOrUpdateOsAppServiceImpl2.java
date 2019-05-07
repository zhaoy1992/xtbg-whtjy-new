package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;


import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService;

/**
 * 办公用品申购计划流程业务实现类
 * @author 王淑滨
 *
 */
public class AddOrUpdateOsAppServiceImpl2 extends XtDbBaseDao implements FlowBusiDataSaveDao{

	@Override
	public boolean saveBusiInfo(HttpServletRequest request, Connection conn)
			throws Exception {
		String t_id = request.getParameter("t_id");
		String unit_id = request.getParameter("unit_id");
		String unit_name = request.getParameter("unit_name");
		String t_org_id = request.getParameter("t_org_id");
		String t_org_name = request.getParameter("t_org_name");
		
		String[] type_id = request.getParameterValues("TYPE_ID");
		String[] type = request.getParameterValues("TYPE_NAME");
		String[] ofustype_id = request.getParameterValues("NAME_ID");
		String[] ofustype_name = request.getParameterValues("NAME");
		String[] it_id = request.getParameterValues("IT_NAME_ID");
		String[] it_name = request.getParameterValues("IT_NAME");
		String[] t_os_ob_no = request.getParameterValues("T_OS_OB_NO");
		String[] t_os_ob_bz = request.getParameterValues("T_OS_OB_BZ");
		//String[] ofustype_money = request.getParameterValues("OFUSTYPE_MONEY");
		
		if(!StringUtil.nullOrBlank(t_id)){
        	OsAppObjectService objectService = new OsAppObjectServiceImpl();
        	//删除物品表中数据
        	objectService.deleteOsAppObjectByIds(new String[]{t_id});
			for(int i=0;i<t_os_ob_no.length;i++){
				if((!t_os_ob_no[i].equals("0")) && (!StringUtil.nullOrBlank(t_os_ob_no[i]))){
					OsAppObjectBean bean = new OsAppObjectBean();
					bean.setT_id(t_id);
					bean.setUnit_id(unit_id);
					bean.setUnit_name(unit_name);
					bean.setT_org_id(t_org_id);
					bean.setT_org_name(t_org_name);
					bean.setT_os_ob_id(DaoUtil.getUUID());
					bean.setType_id(type_id[i]);
					bean.setType(type[i]);
					bean.setOfustype_id(ofustype_id[i]);
					bean.setOfustype_name(ofustype_name[i]);
					bean.setIt_id(it_id[i]);
					bean.setIt_name(it_name[i]);
					bean.setT_os_ob_bz(t_os_ob_bz[i]);
					bean.setT_os_ob_no(t_os_ob_no[i]);
					//bean.setOfustype_money(ofustype_money[i]);
					
					objectService.insertOrUpdateOsApp(bean);
				}
			}
		}
		return true;
	}

}
