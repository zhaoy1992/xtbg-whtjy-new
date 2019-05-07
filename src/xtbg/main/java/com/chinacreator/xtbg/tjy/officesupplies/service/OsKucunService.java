package com.chinacreator.xtbg.tjy.officesupplies.service;

import java.util.Map;

import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;

/**
 * 库存处理
 * @author 王淑滨
 *
 */
public interface OsKucunService {

	/**
	 * 根据库存id得物品信息
	 * @param bean
	 * @return
	 */
	public Map<String, String>getByID(String t_ha_id);
	/**
	 * 新增
	 * @param bean
	 * @return
	 */
	public boolean insert(OsHavaObjectBean bean);
	/**
	 * 更新
	 * @param bean
	 * @return
	 */
	public boolean update(OsHavaObjectBean bean);
	/**
	 * 整单入库
	 * @param bean
	 * @return
	 */
	public boolean updateNo(OsHavaObjectBean bean);
	
	/**
	 * 整单出库
	 * @param bean
	 * @return
	 */
	public boolean updateNumber(Map<String, String> map);
	/**
	 * 删除库存//删除一个库存就要删除一个规格
	 * @param ids
	 * @param it_idsd
	 * @return
	 */
	public boolean delete(String ids,String it_ids);
	/**
	 * 删除没有规格的库存（批量增加时用）
	 * @param id
	 * @return
	 */
	public boolean deleteByItem(String id);

}
