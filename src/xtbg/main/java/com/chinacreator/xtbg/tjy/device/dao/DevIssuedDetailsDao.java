package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.tjy.device.entity.DevIssuedDetailsBean;

/**
 * 核验计划核验设备清单dao
 * @author 王淑滨
 *
 */
public interface DevIssuedDetailsDao {
	/**
	 * 根据计划表id删除
	 * @param ids
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean delete(String plan_id,Connection conn) throws Exception;
	/**
	 * 新增设备清单
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean insert(DevIssuedDetailsBean bean,Connection conn)throws Exception;
	/**
	 * 根据计划表id查清单列表
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getByPlanID(String id,Connection conn)throws Exception;
}
