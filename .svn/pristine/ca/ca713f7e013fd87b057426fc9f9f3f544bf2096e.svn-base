package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;

/**
 * 库存处理
 * @author 王淑滨
 *
 */
public interface OsKucunDao {

	/**
	 * getByID
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getByID(String t_ha_id,Connection conn)throws Exception;
	/**
	 * 新增
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public boolean insert(OsHavaObjectBean bean,Connection conn)throws Exception;
	/**
	 * 更新
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean update(OsHavaObjectBean bean,Connection conn)throws Exception;
	/**
	 * 入库
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean updateNo(OsHavaObjectBean bean,Connection conn)throws Exception;
	/**
	 * 出库
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean updateNumber(Map<String, String> map,Connection conn) throws Exception;
	/**
	 * 删除
	 * @param ids
	 * @return
	 * @throws Exception
	 */
	public boolean delete(String ids,Connection conn)throws Exception;
	/**
	 * 删除没有规格的物品啊（批量新增用）
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteByItem(String id,Connection conn)throws Exception;

	
}
