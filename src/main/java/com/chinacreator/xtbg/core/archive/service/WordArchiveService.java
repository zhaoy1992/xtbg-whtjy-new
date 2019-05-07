package com.chinacreator.xtbg.core.archive.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean;
import com.chinacreator.xtbg.core.wordnumdef.entity.SerialNumberBean;

/**
 *<p>Title:WordArchiveService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-30
 */
public interface WordArchiveService {
	/**
	 * 
	*<b>Summary: </b>
	* getMaxArchiveNumber(获取number_type，number_year，busi_id中最大公文编号)
	* @param number_type
	* @param number_year
	* @param busi_id
	* @return
	 */
	public String getMaxArchiveNumber(String number_type,String number_year,String busi_id);
	
	public boolean isArchiveNumber(String number_type,String number_year,String number_code);
	
	//特检院OA  查询是否存在公文编号 2014-06-23
	/**
	*<b>Summary: </b>
	* isArchivReadyNmuberByBusId(查询公文编号是否已经被占用了)
	* @param busi_id
	* @param number_type
	* @param number_year
	* @param number_year
	* @return
	*/
	public boolean isArchivReadyNmuberByBusId(String busi_id,String number_type,String number_year,String number_code);
	
	/**
	*<b>Summary: </b>
	* isArchiveNumberBybusId(查询是否存在公文编号)
	* @param busi_id
	* @param number_type
	* @param number_year
	* @return
	 */
	public boolean isArchiveNumberBybusId(String busi_id);
	//特检院OA  查询是否存在公文编号 2014-06-23
	
	/**
	 * 
	*<b>Summary: </b>
	* saveNumber(保存公文编号)
	* @param paramJson
	* @return
	 */
	public boolean saveNumber(String paramJson);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateNumber(更新公文编号)
	* @param paramJson
	* @return
	 */
	public boolean updateNumber(String paramJson);
	/**
	 * 
	*<b>Summary: </b>
	* updateGz(更新盖章成功)
	* @param gz
	* @return
	 */
	public boolean updateGz(String gz,String id);
	
	/**
	 * 
	*<b>Summary: </b>
	* delNumber(删除公文编号)
	* @param number_id
	* @return
	 */
	public boolean delNumber(String number_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* getNumber(查询编号)
	* @param busi_id
	* @return
	 */
	public OaWordNumberBean getNumber(String busi_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* savepaperNumber(保存纸质公文编号)
	* @param paramJson
	* @return
	 */
	public boolean savepaperNumber(String paramJson);
	
	/**
	 * 
	*<b>Summary: </b>
	* getWordNumber(查询有权限的公文编号)
	* @param org_id
	* @return
	 */
	public Map<String,List<OaWordNumberBean>> getWordNumber(String org_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* wordToGWCS(将WORD正文上传至公文传输)
	* @param ins_id
	* @param mRecordID
	* @param wordToGwcsWsdl
	* @return
	 */
	public String wordToGWCS(String ins_id, String mRecordID,String wordToGwcsWsdl);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveOrUpdateArchiveDispatch(插入代发公文要素，地址信息)
	* @param archiveDispatchBean
	* @return
	 */
	public boolean saveOrUpdateArchiveDispatch(ArchiveDispatchBean archiveDispatchBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* sendToArchive(调用发文接口,发送CEB文件)
	* @param ins_id
	* @param uuid
	* @return
	 */
	public String sendToArchiveCeb(ArchiveDispatchBean archiveDispatchBean, String uuid);
	
	/**
	 * 
	*<b>Summary: </b>
	* sendToArchive(调用发文接口，发送公文保存的UUID)
	* @param ins_id
	* @param uuid
	* @return
	 */
	public String sendToArchive(ArchiveDispatchBean archiveDispatchBean, String uuid);
	
	/**
	 * 
	*<b>Summary: </b>
	* sendUnionArchive(联合盖章发送)
	* @param archiveDispatchBean
	* @param uuid
	 */
	public String sendUnionArchive(ArchiveDispatchBean archiveDispatchBean,String uuid);
	/**
	 * 
	*<b>Summary: </b>
	* toTempFile(将正文WORD,附件放入零时文件夹)
	* @param mRecordID 正文ID
	* @param ins_id 流程实例ID
	* @param busi_id 业务ID
	* @param n_attach_id 附件ID
	* @return
	 */
	public boolean toTempFile(String mRecordID,String ins_id,String busi_id,String n_attach_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* getArchiveDispatch(获取公文要素)
	* @param archiveDispatchBean
	* @return
	 */
	public ArchiveDispatchBean getArchiveDispatch(String uuid);
	/**
	 * 
	*<b>Summary: </b>
	* getArchiveDispatchbean(获取公文要素)
	* @param archiveDispatchBean
	* @return
	 */
	public ArchiveDispatchBean getArchiveDispatchbean(String ins_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* sendToArchiveFZ(调用方正公文传输接口)
	* @param archiveDispatchBean
	* @return
	 */
	public String sendToArchiveFZ(ArchiveDispatchBean archiveDispatchBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* getUUID(根据流程实例ID，获取保存在公文要素表中的上传WORD公文ID)
	* @param ins_id
	* @return
	 */
	public String getUUID(String ins_id);
	/**
	 * 
	 *<b>Summary: </b>
	 * getTempActionId()
	 * @param ins_id
	 * @return
	 */
	public String getTempActionId(String ins_id);

	/**
	 * 
	 * @param attachId
	 * @param oldAttachId
	 * @return
	 */
	public Map<String,String> copyAttachForNewFlow(Map<String,String> argMap);
	/**
	 * 公文登记(来文登记)获得数据
	 * @param offDocRegId
	 * @param templateId
	 * @param mFilePath
	 * @param userId
	 * @return Object[] [0]:文本数据(type:Map<String,String> like '1,2,3', '标题')
	 *                  [1]:附件数据(type:Map<String,String> like 'TABLE_ID__FJ_ID','UUID—code')
	 * @throws Exception
	 */
	public Object[] getOfficialDocumentRegisterMess(String offDocRegId,String templateId,String mFilePath,String userId) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getLastActByIns_id(根据流程实例ID获取办结环节的环节ID)
	* @param ins_id
	* @return
	 */
	public String getLastActByIns_id(String ins_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* findSerialcode(根据规则获取MAX流水号)
	* @param scode
	* @param conn
	* @return
	 */
	public SerialNumberBean findSerialcode(String scode);
	
	/**
	*<b>Summary: </b>
	* deleteWordInfoByIds(删除纸质编号)
	* @param bus_ids
	* @param number_codes
	* @param bean
	* @return
	 */
	public String deleteWordInfoByIds(String[] bus_ids,String[] number_codes,OaWordNumberBean bean);
}
