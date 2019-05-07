package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsExaminationBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsExaminationObjectService;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService;

/**
 * 
 *<p>Title:AddOrUpdateOsAppServiceImpl.java</p>
 *<p>Description: 办公用品申购计划审批流程业务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-8
 */
public class AddOrUpdateOsExaObjectServiceImpl extends XtDbBaseDao implements FlowBusiDataSaveDao{
	
	private static final Log LOG=LogFactory.getLog(AddOrUpdateOsExaObjectServiceImpl.class);

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
        //计划审批表ID
        String busi_id  =  request.getParameter("busi_id");
        
        //当前环节
        //String action_defid = request.getParameter("action_defid");
        
        //相关计划表IDs
        String T_IDS = request.getParameter("T_IDS");
        String org_id = request.getParameter("org_id");
        String orgName = request.getParameter("orgName");
        String T_OSEXA_TITLE = request.getParameter("T_OSEXA_TITLE");
        String T_OSEXA_DATE = request.getParameter("T_OSEXA_DATE");
        String T_OSEXA_USER_ID = request.getParameter("T_OSEXA_USER_ID");
        String T_OSEXA_USER_NAME = request.getParameter("T_OSEXA_USER_NAME");
        String unit_id = request.getParameter("unit_id");
        String unit_name = request.getParameter("unit_name");
        
        //机构ID
        String[] T_OSEXA_OB_ORG_IDS_Arr  =  request.getParameterValues("T_OSEXA_OB_ORG_IDS");
        
        //机构名称
        String[] T_OSEXA_OB_ORG_NAMES_Arr  =  request.getParameterValues("T_OSEXA_OB_ORG_NAMES");
        
        //计划表物品ID
        String[] T_OS_OB_ID_Arr  =  request.getParameterValues("T_OS_OB_ID");
        
        //主键ID
        String[] T_OSEXA_OB_ID_Arr = request.getParameterValues("T_OSEXA_OB_ID");
        
        //数量
        String[] T_OSEXA_OB_NO_Arr = request.getParameterValues("T_OSEXA_OB_NO");
        
        //物品名称
        String[] OFUSTYPE_NAME_VALUE_Arr = request.getParameterValues("OFUSTYPE_NAME_VALUE");
        
        //物品ID
        String[] OFUSTYPE_ID_VALUE_Arr = request.getParameterValues("OFUSTYPE_ID_VALUE");
        
        //物品规格名称
        String[] IT_NAME_VALUE_Arr = request.getParameterValues("IT_NAME_VALUE");
        
        //物品规格ID
        String[] IT_ID_VALUE_Arr = request.getParameterValues("IT_ID_VALUE");
        
        //单价
        String[] T_OSEXA_OB_DJ_Arr = request.getParameterValues("T_OSEXA_OB_DJ");
        
        //备注
        String[] T_OSEXA_OB_BZ_Arr = request.getParameterValues("T_OSEXA_OB_BZ");
        OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
        
        if(!StringUtil.isBlank(busi_id)){
        	OsExaminationObjectService osExaminationObjectService = new OsExaminationObjectServiceImpl();
        	//删除物品表中数据
        	osExaminationObjectService.deleteOsExaObjectByIds(new String[]{busi_id});
        	
        	//OsAppObjectService osAppObjectService = new OsAppObjectServiceImpl();
        	
        	for (int i = 0; i < T_OSEXA_OB_NO_Arr.length; i++) {
        		if ((!T_OSEXA_OB_NO_Arr[i].equals("0")) && (!StringUtil.isBlank(T_OSEXA_OB_NO_Arr[i]))) {
        			
        		}
        	}	
        	
        	//合并同类物品
        	for (int j = 0; j < IT_ID_VALUE_Arr.length; j++) {
				for (int k = 0; k < IT_ID_VALUE_Arr.length; k++) {
					if ((!StringUtil.isBlank(IT_ID_VALUE_Arr[j])) && (!StringUtil.isBlank(IT_ID_VALUE_Arr[k])) && (IT_ID_VALUE_Arr[j].equals(IT_ID_VALUE_Arr[k])) && j!=k) {  //常用物品规格ID不为空且相同
						long noJ = Long.parseLong(T_OSEXA_OB_NO_Arr[j]);
						long noK = Long.parseLong(T_OSEXA_OB_NO_Arr[k]);
						long sum = noJ + noK;
						T_OSEXA_OB_NO_Arr[j] = ""+sum;
						if(!T_OSEXA_OB_ORG_IDS_Arr[j].equals(T_OSEXA_OB_ORG_IDS_Arr[k])){
							T_OSEXA_OB_ORG_IDS_Arr[j] = T_OSEXA_OB_ORG_IDS_Arr[j]+","+T_OSEXA_OB_ORG_IDS_Arr[k];
							T_OSEXA_OB_ORG_NAMES_Arr[j] = T_OSEXA_OB_ORG_NAMES_Arr[j]+","+T_OSEXA_OB_ORG_NAMES_Arr[k];
						}
						T_OS_OB_ID_Arr[j] = T_OS_OB_ID_Arr[j]+","+T_OS_OB_ID_Arr[k];
						T_OSEXA_OB_NO_Arr[k] = "0";
						IT_ID_VALUE_Arr[k] = "";
					}
				}
			}
        	
        	//添加物品表中数据
        	for (int i = 0; i < T_OSEXA_OB_NO_Arr.length; i++) {
        		if ((!T_OSEXA_OB_NO_Arr[i].equals("0")) && (!StringUtil.isBlank(T_OSEXA_OB_NO_Arr[i]))) {
        			OsExaminationBean osExaminationBean = new OsExaminationBean();
        			
        			String[] NEW_IT_ID_VALUE_Arr = IT_ID_VALUE_Arr[i].split(";");
        			
        			String[] NEW_OFUSTYPE_ID_VALUE_Arr = OFUSTYPE_ID_VALUE_Arr[i].split(";");
        			
        			if (NEW_IT_ID_VALUE_Arr.length == 1) {
        				osExaminationBean.setIt_id("");
					}else{
						osExaminationBean.setIt_id(NEW_IT_ID_VALUE_Arr[1]);
					}
        			
        			if (NEW_OFUSTYPE_ID_VALUE_Arr.length == 1) {
        				osExaminationBean.setOfustype_id("");
					}else{
						osExaminationBean.setOfustype_id(NEW_OFUSTYPE_ID_VALUE_Arr[1]);
					}
        			
        			//物品名称
        			osExaminationBean.setOfustype_name(OFUSTYPE_NAME_VALUE_Arr[i]);
        			//规格名称
        			osExaminationBean.setIt_name(IT_NAME_VALUE_Arr[i]);
        			//主键ID
        			osExaminationBean.setT_osexa_ob_id(T_OSEXA_OB_ID_Arr[i]);
        			//计划审批ID
        			osExaminationBean.setT_osexa_id(busi_id);
        			//所属单位
        			osExaminationBean.setUnit_id(unit_id);
        			osExaminationBean.setUnit_name(unit_name);
        			//计划审批表申请部门ID
        			osExaminationBean.setT_osexa_ob_org_ids(T_OSEXA_OB_ORG_IDS_Arr[i]);
        			//计划审批表申请部门名称
        			osExaminationBean.setT_osexa_ob_org_names(T_OSEXA_OB_ORG_NAMES_Arr[i]);
        			//备注
        			osExaminationBean.setT_osexa_ob_bz(T_OSEXA_OB_BZ_Arr[i]);
        			//数量
        			osExaminationBean.setT_osexa_ob_no(T_OSEXA_OB_NO_Arr[i]);
        			//单价
        			osExaminationBean.setT_osexa_ob_dj(T_OSEXA_OB_DJ_Arr[i]);
        			//计划表IDS
        			osExaminationBean.setT_os_ob_ids(T_OS_OB_ID_Arr[i]);
        			osExaminationObjectService.insertOrUpdateOsExaObject(osExaminationBean);
        			
        			//入库
        			OsHavaObjectBean osHavaObjectBean = new OsHavaObjectBean();
        			osHavaObjectBean.setT_ha_rkuser_name(T_OSEXA_USER_NAME);
        			osHavaObjectBean.setT_ha_rkuser_id(T_OSEXA_USER_ID);
        			osHavaObjectBean.setUnit_id(unit_id);
        			osHavaObjectBean.setUnit_name(unit_name);
        			if(StringUtil.nullOrBlank(T_OSEXA_OB_ORG_IDS_Arr[i])){
        				osHavaObjectBean.setT_ha_org_id(org_id);
        			}else{
        				osHavaObjectBean.setT_ha_org_id(T_OSEXA_OB_ORG_IDS_Arr[i]);
        			}
        			if(StringUtil.nullOrBlank(T_OSEXA_OB_ORG_NAMES_Arr[i])){
        				osHavaObjectBean.setT_ha_org_name(orgName);
        			}else{
        				osHavaObjectBean.setT_ha_org_name(T_OSEXA_OB_ORG_NAMES_Arr[i]);
        			}
        			osHavaObjectBean.setT_ha_bz(T_OSEXA_OB_BZ_Arr[i]);
        			osHavaObjectBean.setT_ha_buydate(T_OSEXA_DATE);
        			osHavaObjectBean.setT_ha_dj(T_OSEXA_OB_DJ_Arr[i]);
        			if (NEW_OFUSTYPE_ID_VALUE_Arr.length == 1) {
        				osHavaObjectBean.setOfustype_id("");
					}else{
						osHavaObjectBean.setOfustype_id(NEW_OFUSTYPE_ID_VALUE_Arr[1]);
						//获取物品类型ID与类型名称
						String oftype_id = "";
						String oftype_name = "";
						oftype_id = DaoUtil.sqlToField("select t.oftype_id from ta_oa_osupplieusetype l,TA_OA_OSUPPLIETYPE t " +
								"where l.oftype_id = t.oftype_id and l.ofustype_id = '"+NEW_OFUSTYPE_ID_VALUE_Arr[1]+"'");
						oftype_name = DaoUtil.sqlToField("select t.oftype_name from ta_oa_osupplieusetype l,TA_OA_OSUPPLIETYPE t " +
								"where l.oftype_id = t.oftype_id and l.ofustype_id = '"+NEW_OFUSTYPE_ID_VALUE_Arr[1]+"'");
						osHavaObjectBean.setOftype_id(StringUtil.deNull(oftype_id));
						osHavaObjectBean.setOftype_name(StringUtil.deNull(oftype_name));
					}
        			osHavaObjectBean.setOfustype_name(OFUSTYPE_NAME_VALUE_Arr[i]);
        			//osHavaObjectBean.setOfustype_name(OFUSTYPE_NAME_VALUE_Arr[i]);
        			osHavaObjectBean.setIt_name(IT_NAME_VALUE_Arr[i]);
        			osHavaObjectBean.setT_ha_sbstate("1");
        			if (NEW_IT_ID_VALUE_Arr.length == 1) {
        				osHavaObjectBean.setIt_id("");
					}else{
						osHavaObjectBean.setIt_id(NEW_IT_ID_VALUE_Arr[1]);
						List<Map<String, String>> havaValueList = new ArrayList<Map<String,String>>();
						havaValueList = osHavaObjectService.queryHavaInfoByItId(IT_ID_VALUE_Arr[i]);
						if(havaValueList.size()>0){
							osHavaObjectBean.setT_ha_id(havaValueList.get(0).get("t_ha_id"));
							long t_ha_no = Long.parseLong(havaValueList.get(0).get("t_ha_nos"));
							long now_t_ha_no = Long.parseLong(T_OSEXA_OB_NO_Arr[i]);
							t_ha_no += now_t_ha_no;
							osHavaObjectBean.setT_ha_no(""+t_ha_no);
						}else{
							osHavaObjectBean.setT_ha_no(T_OSEXA_OB_NO_Arr[i]);
						}
					}
        			if(!StringUtil.isBlank(IT_ID_VALUE_Arr[i])){
        				osHavaObjectService.insertOrupdateHavaObject(osHavaObjectBean);
        			}
        			
        			//osExaminationObjectService.insertOrUpdateHavaObject(osHavaObjectBean);
        			//更新计划表状态
            		osExaminationObjectService.updateOsAplan(T_IDS);
        			/*if(action_defid.equals("sgsp_wp1_act5")){
        				OsAppObjectBean osAppObjectBean = new OsAppObjectBean();
            			osAppObjectBean.setT_os_ob_id(T_OS_OB_ID_Arr[i]);
            			osAppObjectBean.setIt_id(NEW_IT_ID_VALUE_Arr[1]);
            			osAppObjectBean.setOfustype_id(NEW_OFUSTYPE_ID_VALUE_Arr[1]);
            			osAppObjectBean.setIt_name(IT_NAME_VALUE_Arr[i]);
            			osAppObjectBean.setOfustype_name(OFUSTYPE_NAME_VALUE_Arr[i]);
            			//更新计划表物品列表
            			osAppObjectService.onlyUpdateOsApp(osAppObjectBean);
                	}*/
        		}
        	}
        	
        	//保存数据DAO计划表中
        	OsApplanBean applanBean = new OsApplanBean();
        	applanBean.setT_id(busi_id);
        	applanBean.setT_creator_time(T_OSEXA_DATE);
        	applanBean.setT_org_id(org_id);
        	applanBean.setT_org_name(orgName);
        	applanBean.setT_title(T_OSEXA_TITLE);
        	applanBean.setT_user_id(T_OSEXA_USER_ID);
        	applanBean.setT_user_name(T_OSEXA_USER_NAME);
        	applanBean.setUnit_id(unit_id);
        	applanBean.setUnit_name(unit_name);
        	osExaminationObjectService.insertOrUpdateOsApplanObject(applanBean);
        	
        }
		return true;
	}

}
