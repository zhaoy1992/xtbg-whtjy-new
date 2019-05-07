package com.chinacreator.xtbg.tjy.officesupplies.service;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean;

/**
 * 申购计划表处理
 * @author 王淑滨
 *
 */
public interface OsapPlanService {
	/**
	 * 根据id查申购表信息
	 * @param ids
	 * @return
	 */
	public OsApplanBean getById(String ids);
	/**
	 * 新增申购表信息
	 * @param bean
	 */
	public boolean insertApplan(OsApplanBean bean);
	/**
	 * 改变计划表入库状态
	 * @param t_id
	 * @return
	 */
	public boolean changeState(OsApplanBean bean);
	/**
	 * 新增申购表信息
	 * @param bean
	 * @param request
	 * @return
	 */
	public boolean insertApplan(OsApplanBean bean,HttpServletRequest request);
	
}
