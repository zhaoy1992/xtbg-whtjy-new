package com.chinacreator.xtbg.core.archive.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveAddrBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Sign;
import com.chinacreator.xtbg.core.archive.gwcs.bean.UnionArchiveSignBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:WordArchiveDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-30
 */
public interface WordArchiveDao {
	/**
	 * 
	*<b>Summary: </b>
	* getNumberByBusiId(获取busiId的文号，如果不存在，返回-1)
	 * @param conn 
	* @return
	* @throws Exception
	 */
	public int getNumberByBusiId(String busi_id,String number_year,String number_type, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getNumberByTypeYear(根据number_type，number_year获取最大文号)
	* @param number_type
	* @param number_year
	* @return
	* @throws Exception
	 */
	public int getNumberByTypeYear(String number_type, String number_year, Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveNumber(保存编号)
	* @param oaWordNumberBean
	* @return
	* @throws Exception
	 */
	public boolean saveNumber(OaWordNumberBean oaWordNumberBean ,Connection conn )throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateNumber(更新编号)
	* @param oaWordNumberBean
	* @return
	* @throws Exception
	 */
	public boolean updateNumber(OaWordNumberBean oaWordNumberBean,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateGz(更新盖章成功)
	* @param gz
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean updateGz(String gz,String id)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* delNumber(删除编号)
	* @param number_id
	* @return
	* @throws Exception
	 */
	public boolean delNumber(String busi_id,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getNumber(获取已有的编号)
	* @param busi_id
	* @return
	* @throws Exception
	 */
	public OaWordNumberBean getNumber(String  busi_id)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findCirularizeList(公文纸质编号列表查询)
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findWordNumberList(OaWordNumberBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) ;
	/**
	 * 
	*<b>Summary: </b>
	* saveNumber(保存纸质公文编号)
	* @param oaWordNumberBean
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean savepaperNumber(OaWordNumberBean oaWordNumberBean ,Connection conn )throws Exception;

	
	/**
	*<b>Summary: </b>
	* getWordNumber(查询有权限的公文编号)
	* @param org_id
	* @return 
	*/
	public List<OaWordNumberBean> getWordNumber(String org_id)throws Exception;

	
	/**
	*<b>Summary: </b>
	* getTextByte(获取公文ID的BYte数组)
	* @param mRecordID
	* @return 
	*/
	public byte[] getTextByte(String mRecordID) throws Exception ;

	
	/**
	*<b>Summary: </b>
	* saveWordCeb(将CEB表中预插入UUID字段)
	* @param uuid
	* @param conn 
	*/
	public boolean saveWordCeb(String uuid,	String ins_id, Connection conn) throws Exception;

	
	/**
	*<b>Summary: </b>
	* selWordCeb(根据ins_id查询UUID，是否上传过)
	* @param ins_id
	* @return 
	*/
	public String selWordCeb(String ins_id, Connection conn) throws Exception;

	
	/**
	*<b>Summary: </b>
	* updateWordCeb(根据ins_id更新UUID)
	* @param ins_id
	* @param uuid
	* @param conn 
	*/
	public boolean updateWordCeb(String ins_id, String uuid, Connection conn) throws Exception;

	
	/**
	*<b>Summary: </b>
	* delArchiveDispatch(删除公文要素信息)
	* @param ins_id
	* @param conn
	* @return 
	*/
	public boolean delArchiveDispatch(String ins_id, Connection conn) throws Exception;

	
	/**
	*<b>Summary: </b>
	* saveArchiveDispatch(保存公文要素信息)
	* @param archiveDispatchBean
	* @param conn
	* @return 
	*/
	public boolean saveArchiveDispatch(ArchiveDispatchBean archiveDispatchBean,Connection conn)throws Exception;

	
	/**
	*<b>Summary: </b>
	* wordToTemp(正文从数据库中读取到零时文件夹)
	* @param string
	* @param conn
	* @return 
	*/
	public boolean wordToTemp(String mRecordID,String ins_id, Connection conn);

	
	/**
	*<b>Summary: </b>
	* attachToTemp(附件从数据库中存入零时文件夹)
	* @param n_attach_id
	* @param conn
	* @return 
	*/
	public boolean attachToTemp(String n_attach_id, String ins_id , Connection conn);
	
	/**
	 * 
	*<b>Summary: </b>
	* getArchiveDispatch(根据公文系统返回的UUID回去公文要素)
	* @param uuid
	* @param conn
	* @return
	* @throws Exception
	 */
	public ArchiveDispatchBean getArchiveDispatch(String uuid,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getArchiveDispatch(根据ins_id回去公文要素)
	* @param uuid
	* @param conn
	* @return
	* @throws Exception
	 */
	public ArchiveDispatchBean getArchiveDispatchbean(String ins_id,Connection conn)throws Exception;

	
	/**
	*<b>Summary: </b>
	* saveArchiveAddr(保存公文传输地址)
	* @param archiveAddrBeanList
	* @param conn
	* @return 
	*/
	public boolean saveArchiveAddr(List<ArchiveAddrBean> archiveAddrBeanList,Connection conn)throws Exception;

	
	/**
	*<b>Summary: </b>
	* delArchiveAddr(根据流程实例ID删除公文地址信息)
	* @param ins_id
	* @param conn
	* @return 
	*/
	public boolean delArchiveAddr(String ins_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateArchiveAddr(更新公文传输地址))
	* @param archiveAddrBean
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean updateArchiveAddr(ArchiveAddrBean archiveAddrBean, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateArchiveAddr((根据流程实例ID更新公文传输地址))
	* @param ins_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean updateArchiveAddrIsSend(String ins_id, String is_send, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getArchiveUUID(获取公文UUID)
	* @param ins_id
	* @param object
	* @return 
	*/
	public String getArchiveUUID(String ins_id)throws Exception;
	/**
	*<b>Summary: </b>
	* getTempActionId()
	* @param ins_id
	* @param object
	* @return 
	*/
	public String getTempActionId(String ins_id)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findArchiveDispatchBeanList(查询公文要素列表)
	* @param archiveDispatchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findArchiveDispatchBeanList(ArchiveDispatchBean archiveDispatchBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* putUnionArchiveInfo(当联合盖章发送成功后将返回的业务ID存入要素表)
	* @param businessid
	* @param uuid
	* @return
	 */
	public boolean putUnionArchiveInfo(String businessid, String uuid, String is_send,Connection conn) throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* addSings(联合盖章发送成功后将联合盖章表更新)
	* @param signs
	* @param businessid
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean addSings(List<Sign> signs, String businessid,Connection conn)throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* getSignInfoList(根据业务ID获取签名情况)
	* @param union_archive_buss_id
	* @return
	* @throws Exception
	 */
	public List<UnionArchiveSignBean> getSignInfoList(String union_archive_buss_id) throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* getUnionArchiveDispatchBeanList(查询出公文要素集合)
	* @param archiveDispatchBean
	* @return
	 * @throws Exception 
	 */
	public List<ArchiveDispatchBean> getArchiveDispatchBeanList(ArchiveDispatchBean archiveDispatchBean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateSignInfoList(更新签名状态)
	* @param unionArchiveSignBeanList
	* @return
	* @throws Exception
	 */
	public boolean updateSignInfoList(List<UnionArchiveSignBean> unionArchiveSignBeanList, Connection conn) throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* getSendArchiveList(获取未发送成功的公文列表)
	* @return
	* @throws Exception
	 */
	public List<ArchiveDispatchBean> getSendArchiveList() throws Exception ;

	/**
	 * 
	*<b>Summary: </b>
	* updateIsSendByBussId(根据字段表更新是否发送表)
	* @param uuid
	* @return
	* @throws Exception
	 */
	public boolean updateIsSendByBussId(String colID,String colName)throws Exception ;
	
	/**
	 * 
	 * @param attachId
	 * @param oldAttachId
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> copyAttachForNewFlow(Map<String,String> argMap)
			throws Exception;
	
	/**
	 * 
	 * @param sql
	 * @param values
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> queryToSingleMap(String sql, String... values)
			throws Exception;
	/**
	 * 获得模板信息
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,String>> getTemplateList(String id, Connection conn) throws Exception;
	/**
	 * 复制附件 返回新附件ID
	 * @param oldAttachId
	 * @param conn
	 * @return
	 */
	public String copyAttach(String oldAttachId,String mFilePath,String userId, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getLastActByIns_id(根据流程实例ID获取办结环节的环节ID)
	* @param ins_id
	* @param conn
	* @return
	 */
	public String getLastActByIns_id(String ins_id, Connection conn)throws Exception ;
	
	public boolean isNumber(String number_year,String number_type, String number_code,Connection conn) throws Exception;
	
	
	//特检院OA  查询是否存在公文编号 2014-06-23 start
	/**
	*<b>Summary: </b>
	* isArchivReadyNmuberByBusId(查询公文编号是否已经被占用了)
	* @param busi_id
	* @param number_type
	* @param number_year
	* @param number_year
	* @return
	*/
	public boolean isArchivReadyNmuberByBusId(String busi_id,String number_type,String number_year,String number_code,Connection conn) throws Exception;
	/**
	*<b>Summary: </b>
	* isArchiveNumberBybusId(查询是否存在公文编号)
	* @param busi_id
	* @param number_type
	* @param number_year
	* @return
	 */
	public boolean isNumberByBusId(String busi_id,Connection conn) throws Exception;
	//特检院OA  查询是否存在公文编号 2014-06-23 end
	
}
