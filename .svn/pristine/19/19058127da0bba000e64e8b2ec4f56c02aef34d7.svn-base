package com.chinacreator.xtbg.core.agency.dao;

import java.util.List;

import com.chinacreator.xtbg.core.agency.entity.AgencyBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

public interface AgencyDao {

	/**
	 * 查询委托待办的列表
	 * @param agencyBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean findAgencyAll(AgencyBean agencyBean, String sortName, String sortOrder, long offset, int maxPagesize);
	/**
	 * 根据id来清除设置的交办
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public String delAgencyById(String id)throws Exception;
	
	/**
	 * 添加委托待办
	 * @param work_name
	 * @return true
	 * @throws Exception
	 */
	public String setAgencyByName(AgencyBean agencyBean)throws Exception;
	/**
	 * 根据id来查询数据
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public AgencyBean findAgencyBeanById(String id)throws Exception;
	/**
	 * 更新
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public String updateAgencyBeanById(AgencyBean agencyBean)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findAgencyBeanList(查询委托列表)
	* @param agencyBean
	* @return
	* @throws Exception
	 */
	public List<AgencyBean> findAgencyBeanList(AgencyBean agencyBean)throws Exception;
}
