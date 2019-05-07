package com.chinacreator.xtbg.tjy.officesupplies.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountDetails;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountManagerBean;
import javax.servlet.http.HttpServletRequest;

/**
 * 固定资产使用管理记录service
 * @author 王淑滨
 *
 */
public interface OsAccountManageService {
	/**
	 * 新增使用记录
	 * @param bean
	 * @return
	 */
	public boolean insertManager(OsAccountManagerBean bean,HttpServletRequest request);
	/**
	 * 根据id得记录详情
	 * @param id
	 * @return
	 */
	public OsAccountManagerBean getByID(String id);
	/**
	 * 根据记录id的记录物品详情
	 * @param id
	 * @return
	 */
	public List<Map<String, String>> getByMid(String id);
	/**
	 * 新增记录物品详情
	 * @param bean
	 * @return
	 */
	public boolean insertManagerDetails(OsAccountDetails bean);
	/**
	 * 删除记录物品信息
	 * @param ids
	 * @return
	 */
	public boolean deleteManagerDetails(String[] ids);

}
