
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevIssuedPlanService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.Map;
import com.chinacreator.xtbg.tjy.device.entity.DevIssuedPlanBean;

/**
 *<p>Title:DevIssuedPlanService.java</p>
 *<p>Description:下达核检计划业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-3
 */
public interface DevIssuedPlanService {
	
	/**
	*<b>Summary: </b>
	* getDevIssuedPlanBean(根据类型Id查询下达核检计划)
	* @param plan_id
	* @return
	 */
	public Map<String, String> getDevIssuedPlanBean(String plan_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateDevIssuedPlan(增加和修改下达核检计划)
	* @param bean
	* @return
	 */
	public String insertOrUpdateDevIssuedPlan(DevIssuedPlanBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteDevIssuedPlanByIds(根据IDs 删除下达核检计划)
	* @param ids
	* @return
	 */
	public String  deleteDevIssuedPlanByIds(String[] ids);
	/**
	 * 新增下达核验计划
	 * @param bean
	 * @return
	 */
	public String insertDevIssuedPlan(DevIssuedPlanBean bean);
	/**
	 * 更新下达核验计划
	 * @param bean
	 * @return
	 */
	public String updateDevIssuedPlan(DevIssuedPlanBean bean);
}
