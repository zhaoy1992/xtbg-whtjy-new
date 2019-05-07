package com.chinacreator.xtbg.core.process.flowprocessing.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowActionUserBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowDefinfoBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionExtBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InstanceBean;
import com.chinacreator.xtbg.core.process.flowprocessing.service.InitFlowExtServiceIfc;
import com.chinacreator.xtbg.core.process.flowprocessing.service.InitFlowServiceIfc;

/**
 * 
 *<p>Title:InitFlowServiceImpl.java</p>
 *<p>Description: 初始化控制器接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-20
 */
public class InitFlowServiceImpl implements InitFlowServiceIfc {

	private static final Logger LOG = Logger.getLogger(InitFlowServiceImpl.class.getName());
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 init
	  * @param map
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.service.InitFlowServiceIfc#init(java.util.Map)
	 */
	public Map<String, Object> init(Map<String, String> map) throws Exception {
		String initTypeStr = map.get("initType");
		char initType = 0;
		if(initTypeStr != null) {
			initType = initTypeStr.charAt(0);
		}
		Map<String, Object> returnMap = null;
		try {
			switch (initType) {
			case '0'://退窗
				LOG.info("退窗");
				break;
			case '1'://流程的第一环节
				returnMap = initFlowStart(map);
				break;
			case '2'://流程的中间环节
				returnMap = initFlowMiddle(map);
				break;
			case '3'://流程最后环节
				returnMap = initFlowEnd(map);
				break;
			case '4'://已办列表进入
				//returnMap = initFromPre(map);
				break;
			default:
				//returnMap = initSPDetail(map);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return returnMap;
		}
		return returnMap;

	}
	
	/**
	 * 
	*<b>Summary: </b>
	* initFlowStart(初始化流程开始方法)
	* @param map
	* @return
	 */
	public Map<String, Object> initFlowStart(Map<String, String> map){
		
		//获得项目参数
		String mgrName = map.get("mgrName");//流程包#流程版本#流程定义ID package_id#flow_version#process_id	
		String flow_id = map.get("flow_id");//流程ID
		String orgId = map.get("orgId");//机构ID
		String busiTypeCode = map.get("busiTypeCode");//业务类型
		String def_id = map.get("def_id");//业务类型
		String ins_id = map.get("ins_id");
		String action_id = "";//活动ID
		FlowUtilDao flowUtilDao = null;
		FlowDefinfoBean flowDefinfoBean = null; //流程定义Bean
		FlowWfactionBean flowWfactionBean = null; //活动定义Bean
		FlowWfactionExtBean flowWfactionExtBean = null;  //流程活动扩展Bean
		InstanceBean instanceBean = null;	//实例Bean
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		try {
			flowUtilDao = (FlowUtilDao)LoadSpringContext.getApplicationContext().getBean("flowUtilDaoImpl");
			
			if(!StringUtil.isBlank(ins_id)) {
				instanceBean = flowUtilDao.getInstanceBean(ins_id);
				resMap.put("instanceBean", instanceBean);
			}
			if (StringUtil.isBlank(ins_id)) {
				flowDefinfoBean = flowUtilDao.getFlowDefBean(orgId, busiTypeCode);
			} else {
				flowDefinfoBean = flowUtilDao.getFlowDefBean(def_id);
			}
			resMap.put("flowDefinfoBean", flowDefinfoBean);  //流程定义Bean
			if(flowDefinfoBean != null) {
				flow_id = flowDefinfoBean.getFlow_id();
				mgrName = flowDefinfoBean.getPackage_id() + "#" + flowDefinfoBean.getFlow_version() + "#" + flowDefinfoBean.getFlow_defid();
				action_id = flowUtilDao.getActionId(flowDefinfoBean.getDef_id(), flowDefinfoBean.getAction_defid());
				map.put("action_id", action_id);
				map.put("mgrName", mgrName);
				
				flowWfactionBean = flowUtilDao.getFlowWfactionBean(action_id);
				resMap.put("flowWfactionBean", flowWfactionBean);  //流程活动定义Bean
				map.put("action_defid", flowWfactionBean.getAction_defid());
				
				flowWfactionExtBean = flowUtilDao.getFlowActionExtBean(action_id);
				resMap.put("flowWfactionExtBean", flowWfactionExtBean);  //活动扩展Bean
			}
			
			InitFlowExtServiceIfc initFlowExtServiceIfc = new InitFlowExtServiceImpl();
			String ret = "";
			String actAliasOrderStr= "";
			String actUsertList= "";
			if(!StringUtil.isBlank(mgrName)) {
				ret = initFlowExtServiceIfc.getFlowInfoActNextActList(map);//得到流程信息与下一步的活动列表
				actAliasOrderStr = initFlowExtServiceIfc.getActAliasOrder(ret, flow_id); //得到环节别名与排序
				def_id = flowDefinfoBean.getDef_id();
				actUsertList = initFlowExtServiceIfc.getActUserList(ret, def_id, ins_id); //获取下环节是否动态选择，用户列表
			}
			
			resMap.put("flowinfo", ret);
			resMap.put("actionAliasAndOrderStr", actAliasOrderStr);
			resMap.put("actUsertList", actUsertList);
		} catch (Exception e) {
			LOG.error(e);
			LOG.info("初始化流程开始方法");
		}
		
		return resMap;	
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* initFlowMiddle(初始化流程中间活动)
	* @param map
	* @return
	 */
	public Map<String, Object> initFlowMiddle(Map<String, String> map){

		
		//获得项目参数
		String mgrName = map.get("mgrName");//流程包#流程版本#流程定义ID package_id#flow_version#process_id	
		String flow_id = map.get("flow_id");//流程ID
		String def_id = map.get("def_id");//业务类型
		String action_defid = map.get("action_defid");//活动定义ID
		String ins_id = map.get("ins_id");
		String procId = map.get("procId"); //流程实例ID
		String operType = map.get("operType");//操作类型
		String opType = map.get("opType"); 
		String action_id = "";//活动ID
		FlowUtilDao flowUtilDao = null;
		FlowDefinfoBean flowDefinfoBean = null; //流程定义Bean
		FlowWfactionBean flowWfactionBean = null; //活动定义Bean
		FlowWfactionExtBean flowWfactionExtBean = null;  //流程活动扩展Bean
		InstanceBean instanceBean = null;	//实例Bean
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		try {
			flowUtilDao = (FlowUtilDao)LoadSpringContext.getApplicationContext().getBean("flowUtilDaoImpl");
			
			instanceBean = flowUtilDao.getInstanceBean(ins_id);
			resMap.put("instanceBean", instanceBean);

			flowDefinfoBean = flowUtilDao.getMiddleFlowDefBean(def_id);
			
			if(flowDefinfoBean != null) {
				flow_id = flowDefinfoBean.getFlow_id();
				mgrName = flowDefinfoBean.getPackage_id() + "#" + flowDefinfoBean.getFlow_version() + "#" + flowDefinfoBean.getFlow_defid();
				map.put("mgrName", mgrName);
				
				action_id = flowUtilDao.getActionId(def_id, action_defid);
				//String action_from = flowUtilDao.getActionFrom(action_id);
				//flowDefinfoBean.setAction_form(action_from);
				
				flowWfactionBean = flowUtilDao.getFlowWfactionBean(action_id);
				
				resMap.put("flowDefinfoBean", flowDefinfoBean);  //流程定义Bean
				
				resMap.put("flowWfactionBean", flowWfactionBean);  //流程活动定义Bean
				map.put("action_defid", flowWfactionBean.getAction_defid());
				
				flowWfactionExtBean = flowUtilDao.getFlowActionExtBean(action_id);
				//如果是会签环节 查询是不是最后一人会签，如果是在前台展示时要显示选择环节，人员
				if(!StringUtil.isBlank(flowWfactionExtBean.getIssignjoinbyorder())){
					List<FlowActionUserBean>  flowActionUserBeanList = flowUtilDao.getActionUserBeanList(ins_id,null);
					/*if(flowActionUserBeanList!=null && flowActionUserBeanList.size() > 1){
						flowWfactionExtBean.setIssignjoinbyorder("Y");
					}else{
						flowWfactionExtBean.setIssignjoinbyorder("N");
					}*/
					if(flowActionUserBeanList!=null){
						flowWfactionExtBean.setIssignjoinbyorder(String.valueOf(flowActionUserBeanList.size()));
					}else{
						flowWfactionExtBean.setIssignjoinbyorder(Constant.STATUS_FALSE);
					}
				}
				resMap.put("flowWfactionExtBean", flowWfactionExtBean);  //活动扩展Bean
				
				
			}
			
			InitFlowExtServiceIfc initFlowExtServiceIfc = new InitFlowExtServiceImpl();
			String ret = "";
			String actAliasOrderStr= "";
			String actUsertList= "";
			if(!StringUtil.isBlank(mgrName)) {
				map.put("procInsId", procId);
				map.put("operType", operType);
				map.put("opType", opType);
				ret = initFlowExtServiceIfc.getFlowInfoActNextActList(map);//得到流程信息与下一步的活动列表
				actAliasOrderStr = initFlowExtServiceIfc.getActAliasOrder(ret, flow_id); //得到环节别名与排序
				actUsertList = initFlowExtServiceIfc.getActUserList(ret, def_id, ins_id); //获取下环节是否动态选择，用户列表
			}
			//resMap.put("procInsId", procId);
			resMap.put("flowinfo", ret);
			resMap.put("actionAliasAndOrderStr", actAliasOrderStr);
			resMap.put("actUsertList", actUsertList);
		} catch (Exception e) {
			LOG.error(e);
			LOG.info("初始化流程开始方法");
		}
		
		return resMap;	
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* initFlowEnd(初始化流程结束活动页面)
	* @param map
	* @return
	 */
	public Map<String, Object> initFlowEnd(Map<String, String> map){
		
		//获得项目参数
		String mgrName = map.get("mgrName");//流程包#流程版本#流程定义ID package_id#flow_version#process_id	
		String def_id = map.get("def_id");//业务类型
		String action_defid = map.get("action_defid");//活动定义ID
		String ins_id = map.get("ins_id");
		String action_id = "";//活动ID
		FlowUtilDao flowUtilDao = null;
		FlowDefinfoBean flowDefinfoBean = null; //流程定义Bean
		FlowWfactionBean flowWfactionBean = null; //活动定义Bean
		FlowWfactionExtBean flowWfactionExtBean = null;  //流程活动扩展Bean
		InstanceBean instanceBean = null;	//实例Bean
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		try {
			flowUtilDao = (FlowUtilDao)LoadSpringContext.getApplicationContext().getBean("flowUtilDaoImpl");
			
			instanceBean = flowUtilDao.getInstanceBean(ins_id);
			resMap.put("instanceBean", instanceBean);

			flowDefinfoBean = flowUtilDao.getMiddleFlowDefBean(def_id);
			
			if(flowDefinfoBean != null) {
				mgrName = flowDefinfoBean.getPackage_id() + "#" + flowDefinfoBean.getFlow_version() + "#" + flowDefinfoBean.getFlow_defid();
				map.put("mgrName", mgrName);
				
				action_id = flowUtilDao.getActionId(def_id, action_defid);
				//String action_from = flowUtilDao.getActionFrom(action_id);
				//flowDefinfoBean.setAction_form(action_from);
				
				resMap.put("flowDefinfoBean", flowDefinfoBean);  //流程定义Bean
				
				flowWfactionBean = flowUtilDao.getFlowWfactionBean(action_id);
				resMap.put("flowWfactionBean", flowWfactionBean);  //流程活动定义Bean
				map.put("action_defid", flowWfactionBean.getAction_defid());
				
				flowWfactionExtBean = flowUtilDao.getFlowActionExtBean(action_id);
				resMap.put("flowWfactionExtBean", flowWfactionExtBean);  //活动扩展Bean
			}
			
		} catch (Exception e) {
			LOG.error(e);
			LOG.info("初始化流程办结方法");
		}
		
		return resMap;	
	}

}
