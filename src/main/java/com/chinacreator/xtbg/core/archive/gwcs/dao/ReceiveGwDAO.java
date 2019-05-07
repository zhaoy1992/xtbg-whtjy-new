package com.chinacreator.xtbg.core.archive.gwcs.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.archive.gwcs.bean.GwreceiveBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.OctlDocumentBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwHandleBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-7-3
 */
public interface ReceiveGwDAO {

	/**
	 * 保存公文基本信息
	 * @param gwreceiveBean
	 * @param conn 
	 * @return
	 */
	public boolean saveGwReceiveInfo(GwreceiveBean gwreceiveBean, Connection conn) throws Exception;
	
	/**
	 * 保存word信息
	 * @param 
	 * @param 
	 * @return
	 */
	public void saveGwReceiveWord(OctlDocumentBean octlDocumentBean) throws Exception;
	
	/**
	 * 保存附件信息
	 * @param conn 
	 * @param 
	 * @param 
	 * @return
	 */
	public boolean saveGwReceiveAttach(List<FileInfoBean> fileInfoBeanList, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findReceiveGwList(查询公文接收列表信息)
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findReceiveGwList(GwreceiveBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize)throws Exception ;
	/**
	 * 
	*<b>Summary: </b>
	* findReceiveGwHandleList(来文办理情况列表)
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findReceiveGwHandleList(ReceiveGwHandleBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize)throws Exception ;
	/**
	 * 
	*<b>Summary: </b>
	* findAttachid(根据条件查询出附件表的djsn)
	* @param attach_id
	* @param filename
	* @param conn
	* @return
	* @throws Exception
	 */
	public String findAttachid(String attach_id, String filename,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findReceiveGw(根据id查询接收文件信息)
	* @param id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> findReceiveGw(String id,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateGwReceivezd(把来文接收表的是否受理字段置1)
	* @param conn
	* @throws Exception
	 */
	public void updateGwReceivezd( String is_accept,String id,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateGwReceivezd(把来文接收表的是否受理字段置1)
	* @param conn
	* @throws Exception
	 */
	public void updateGwReceivezdOrgId(String org_id,String id,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* UpdateGwReceiveOrgID(更新来文接收表ORG_ID字段)
	* @param id
	* @param org_id
	* @param conn
	* @return
	 */
	public boolean UpdateGwReceiveOrgID(String id,String org_id,Connection conn)throws Exception;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* queryGwReceiveID(根据流程实例ID在T_LWGL表中查询公文接收表对应ID)
	* @param ins_id
	* @param conn
	* @return
	 */
	public String queryGwReceiveID(String ins_id,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActDefByActId(根据环节ID获取环节定义ID)
	* @param action_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public String getActDefByActId(String action_id, Connection conn)throws Exception;

	/**
	 * 
	 * @param conn
	 * @param beanId
	 */
	public boolean deleteGwreceiveBeansById(Connection conn, String beanId)throws Exception;

}
