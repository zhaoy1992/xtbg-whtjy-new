package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean;

/**
 * 固定资产dao接口
 * @author 王淑滨
 *
 */
public interface OsAccountDao {
	/**
	 * 得固定资产部门统计分页列表
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getAccountList(OsAccountBean bean,String sortName,String sortOrder, long offset, int maxPagesize)throws Exception;
	/**
	 * 得固定资产详情分页列表
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getAccountDetailList(OsAccountBean bean,String sortName,String sortOrder, long offset, int maxPagesize)throws Exception;
	/**
	 * 新增固定资产
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean insertAccount(OsAccountBean bean,Connection conn)throws Exception;
	/**
	 * 更新固定资产信息
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean updateAccount(OsAccountBean bean,Connection conn)throws Exception;
	/**
	 * getbyid
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public OsAccountBean getByID(String id,Connection conn) throws Exception;
	/**
	 * 删除固定资产
	 * @param ids
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteAccount(String ids,Connection conn)throws Exception;
	/**
	 * 改变资产状态等
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean changeState(OsAccountBean bean,Connection conn)throws Exception;
	/**
	 * 更新设备类检验时间
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean updateCalibrationTime(OsAccountBean bean,Connection conn)throws Exception;
	
}
