package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsExaBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;

/**
 * 
 *<p>Title:OsExaminationObjectDao.java</p>
 *<p>Description: 申购审批物品及相关计划表处理dao层</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-7
 */
public interface OsExaminationObjectDao {
	
	/**
	 * 
	*<b>Summary: </b>
	* selectOsAppByIds(根据ids查询出相关计划表数据)
	* @param osAppIds
	* @param bus_id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> selectOsAppByIds(String osAppIds,String bus_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findOsAppList(查询计划表列表)
	* @param osApplanBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findOsAppList(OsApplanBean osApplanBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* selectOsAppObjectByIds(根据计划表id查询出相应的物品列表)
	* @param osAppIds
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> selectOsAppObjectByIds(String osAppIds,String bus_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* selectOsExaObject(根据计划审批表id查询出物品列表)
	* @param t_id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> selectOsExaObject(String t_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteOsExaObject(根据计划审批表id删除物品)
	* @param t_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deleteOsExaObject(String t_id, Connection conn) throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsApplanState(更新相关计划表审批状态)
	* @param ids
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean updateOsApplanState(String ids, Connection conn) throws Exception ;
	/**
	 * 
	*<b>Summary: </b>
	* queryOsAppIdsForExaId(根据审批id查询存储的计划表id)
	* @param exaId
	* @return
	 */
	public String queryOsAppIdsForExaId(String exaId) throws Exception ;

	/**
	 * 
	*<b>Summary: </b>
	* selectOsExaObjectByIds(根据计划审批表ids查询出物品列表)
	* @param t_ids
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> selectOsExaObjectByIds(String t_ids) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findOsExaList(查询计划审批表已办结未入库的列表)
	* @param osExaBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findOsExaList(OsExaBean osExaBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* findOsShowOrgList(查看已汇总的常用物品的明细)
	* @param osExaBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findOsShowOrgList(OsAppObjectBean osappobjectbean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;

	public void insertApplanObject(OsApplanBean osApplanBean, Connection conn) throws Exception;

	public void insertApplanObject(OsHavaObjectBean osHavaObjectBean,
			Connection conn) throws Exception;
	
}
