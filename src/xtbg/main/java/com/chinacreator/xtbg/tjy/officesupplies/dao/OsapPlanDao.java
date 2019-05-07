package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean;
/**
 * 申购处理
 * @author 王淑滨
 *
 */
public interface OsapPlanDao {
	/**
	 * 根据id查申购计划表信息
	 * @param t_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public OsApplanBean getById(String t_id,Connection conn) throws Exception;
	
	/**
	 * 新增申购表信息
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean insertApplan(OsApplanBean bean,Connection conn)throws Exception;
	/**
	 * 得申购表列表
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getAppList(OsApplanBean bean,String sortName,String sortOrder, long offset, int maxPagesize)throws Exception;
	/**
	 * 改变申购表入库状态
	 * @param t_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean changeState(OsApplanBean bean,Connection conn)throws Exception;
	/**
	 * 改变申购物品清单入库状态
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean changeItemState(OsAppObjectBean bean,Connection conn)throws Exception;
	/**
	 * 根据用户id查申购清单
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getAppByUserID(OsApplanBean bean,String sortName,String sortOrder, long offset, int maxPagesize)throws Exception;
}
