package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountDetails;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountManagerBean;

/**
 * 固定资产管理dao
 * @author 王淑滨
 *
 */
public interface OsAccountManageDao {
/**
 * 得到使用管理记录清单
 * @param bean
 * @param sortName
 * @param sortOrder
 * @param offset
 * @param maxPagesize
 * @return
 * @throws Exception
 */
	public PagingBean getAccountManageList(OsAccountManagerBean bean, String sortName,String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 新增使用管理记录
	 * @param bean
	 * @param conn
	 * @return
	 */
	public boolean insertManager(OsAccountManagerBean bean,Connection conn)throws Exception;
	/**
	 * getbyid
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public OsAccountManagerBean getByID(String id,Connection conn)throws Exception;
	/**
	 * 根据使用记录id查使用物品清单
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getByMid(String id,Connection conn)throws Exception;
	/**
	 * 新增使用记录使用物品清单
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean insertManagerDetails(OsAccountDetails bean,Connection conn)throws Exception;
	/**
	 * 删除使用记录使用物品清单
	 * @param m_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteManagerDetails(String m_id,Connection conn)throws Exception;
}
