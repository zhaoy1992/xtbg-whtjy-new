package com.chinacreator.xtbg.core.file.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;
import com.chinacreator.xtbg.core.file.entity.FileNoteBean;
import com.chinacreator.xtbg.core.file.entity.FileTypeBean;

/**
 * 
 *<p>Title:FileFilesService.java</p>
 *<p>Description:档案管理service接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-17
 */
public interface FileFilesService {
	/**
	 * 
	 *<b>Summary: 根据字典类型编号查询对应的记录</b> queryDictByCode()
	 * 
	 * @param code
	 *            编号
	 * @return List<Map<String,String>>形式的字典数据
	 * @throws Exception
	 */
	public List<Map<String, String>> queryDictByCode(String code);
	
	/**
	 * 
	*<b>Summary: 根据id查询得到对应的档案</b>
	* queryToFileFilesBean()
	* @param id 档案id
	* @return
	 */
	public FileFilesBean queryToFileFilesBean(String id);
	/**
	 * 
	*<b>Summary: 插入档案</b>
	* insertFileFiles()
	* @param bean 档案对象
	* @return 插入是否成功的标示
	 */
	public boolean insertFileFiles(FileFilesBean bean) ;
	/**
	 * 
	*<b>Summary: 更新档案</b>
	* updateFileFiles()
	* @param bean
	* @return
	 */
	public boolean updateFileFiles(FileFilesBean bean);
	/**
	 * 
	*<b>Summary: 批量删除</b>
	* deleteListFileFiles()
	* @param ids id列表,以","分割
	* @return
	 */
	public boolean deleteListFileFiles(String ids);
	
	/**
	 * 
	*<b>Summary: 根据单位id查询全宗号列表</b>
	* queryListFondsno()
	* @param orgId 机构id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryListFondsno(String orgId);
	
	/**
	 *
	*<b>Summary:批量更新档案信息 </b>
	* updateListFiles()
	* @param map
	* @return
	 */
	public boolean updateListFiles(Map<String,Object> map);
	
	/**
	 * 
	 *<b>Summary: 文件的入卷操作</b>
	 * insertDocFiles()
	 * @param ids    文件id列表，用,拼接
	 * @param fileId 文档id
	 * @return 是否操作成功的标示
	 */
    public boolean insertDocFiles(String ids,String fileId,String userId,String userName);
    
    /**
     * 
    *<b>Summary: 文件出卷操作</b>
    * deleteDocFiles()
    * @param ids   文件与文档对应关系表id列表
    * @param docIds 文件id列表
    * @return
     */
    public boolean deleteDocFiles(String ids,String docIds);
    /**
	 * 
	*<b>Summary:批量修改文件信息 </b>
	* updateListDoc()
	* @param map
	* @param conn
	* @throws Exception
	 */
	public boolean updateListDoc(Map<String, Object> map);
	
	/**
	 * 
	*<b>Summary:修改文件的件号 </b>
	* updateFileDoc()
	* @param bean
	* @return
	 */
	public boolean updateFileDoc(FileDocBean bean);
	
	/**
	 * 
	*<b>Summary: 根据档案id查询备考表信息</b>
	* queryToFileNote()
	* @param fileId 档案id
	* @return
	 */
	public FileNoteBean queryToFileNote(String fileId);	
	
	/**
	 * 
	*<b>Summary:保存或更新备考表信息 </b>
	* saveFileNoteBean()
	* @param bean
	* @return
	 */
	public boolean saveFileNoteBean(FileNoteBean bean);

	/**
	 * 
	*<b>Summary:根据档案类型id查询程序界面信息 </b>
	* queryProgramByTypeId()
	* @param typeId
	* @return
	 */
	public Map<String, String> queryProgramByTypeId(String typeId);
	
	/**
	 * 
	*<b>Summary: 查询会计档案列表（汇帐凭证）</b>
	* findFilesPageBean4acc()
	* @param bean  档案对象
	* @param page  分页对象
	* @param fileMonth 档案年月
	* @return
	* @throws Exception
	 */
	public PagingBean findFilesPageBean4acc(FileFilesBean bean,
			PageInfoBean page);
	/**
	 * 
	*<b>Summary:根据备考表模板生成备考表信息 </b>
	* queryNoteTemplement()
	* @param typeId   档案类型id
	* @param filesId  档案id
	* @return
	* @throws Exception
	 */
	public String queryNoteTemplement(String typeId, String filesId);
	/**
	 * 
	*<b>Summary:根据档号模板生成档号信息 </b>
	* queryNoteTemplement()
	* @param typeId   档案类型id
	* @param filesId  档案id
	* @return
	* @throws Exception
	 */
	public String createFileno(String typeId, String filesId);
	
	/**
	 * 
	*<b>Summary: 在添加时，生成档号信息，由于记录尚未保存，故获取数据后在前台拼接数据</b>
	* createFileno4Add()
	* @param typeId
	* @param filesId
	* @return
	 */
	public String createFileno4Add(String typeId, String filesId);
	/**
	 * 
	*<b>Summary: 查询卷内文件</b>
	* findDocPageBeanForFiles()
	* @param map
	* @return
	 */
	public PagingBean findDocPageBeanForFiles(Map<String, String> map);
	/**
	 * 
	*<b>Summary:根据档案id查询该档案类的照片详情，用于 导出</b>
	* queryDocTip()
	* @param filesId
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> queryDocDesc4Export(String filesId) throws Exception;
	/**
	 * 
	*<b>Summary:根据档案id查询该档案内的光盘详情，用于 导出</b>
	* queryDocTip()
	* @param filesId
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> queryDocDesc4ExportDisk(String filesId) throws Exception;

	 /**
     * 
    *<b>Summary: 调卷操作</b>
    * fitFiles()
    * @param fileId 源案卷id
    * @param ids    文件列表
    * @param fileIdTo 目标案卷id
    * @param idsTo    文件列表
    * @return
     */
	public boolean fitFiles(String fileId, String ids, String fileIdTo,
			String idsTo);
	/**
	 * 
	*<b>Summary:保存文件信息 </b>
	* saveFileNoteBean()
	* @param bean
	* @return
	 */
	public boolean saveFileDocBean(javax.servlet.http.HttpServletRequest request);
	/**
	 * 
	*<b>Summary:根据id查询类型信息 </b>
	* queryToFileType()
	* @param id 类型id
	* @return
	 */
	public FileTypeBean queryToFileType(String id);
	/**
	 * 
	*<b>Summary:根据类型id查询是否分类档案管理员 </b>
	* isFileTypeAdmin()
	* @param userId 用户id
	* @param typeId 档案分类id
	 */
	public boolean isFileTypeAdmin(String userId, String typeId);
	/**
	 * 
	*<b>Summary: 批量修改案卷状态</b>
	* updateListFileState()
	* @param state
	* @param fileIds
	 * @throws SQLException 
	 */
	public boolean updateListFileState(String state,String stateName,String fileIds);
    
	/**
	 * 
	*<b>Summary: 复制档案</b>
	* copyFile()
	* @param fileId
	* @return
	 */
	public FileFilesBean copyFile(String fileId);
	/**
	 * 
	*<b>Summary: 复制文件</b>
	* copyFile()
	* @param fileId
	* @return
	 */
	public FileDocBean copyDoc(String docId,String fileId);
	 /**
	  * 
	 *<b>Summary: 获得当前类型最大的案卷号，并自增1</b>
	 * queryMaxFileNo()
	 * @param typeId
	 * @param orgId
	 * @return
	  */
	public Map<String, String> queryMaxFileNo(String typeId,String orgId);
	
	/**
	 * 
	 *<b>Summary:查询卷内文件的最大件号+1 </b> queryMaxDocNo()
	 * 
	 * @param fileId
	 *            档案编号
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> queryMaxDocNo(String fileId);
	/**
	 * 
	 *<b>Summary:排序</b>
	 * @return
	 * @throws Exception
	 */
	public boolean updateFilesListOrder(FileFilesBean bean);
	/**
	 * 
	 *<b>Summary: </b>
	 * updateFileListInFilesOrder(请用一句话描述这个方法的作用)
	 * @param bean
	 * @return
	 */
	public boolean updateFileListInFilesOrder(FileFilesBean bean);
	
	public void keepRightData(Connection conn,String...ids) throws Exception;
	
}
