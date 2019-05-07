package com.chinacreator.xtbg.core.file.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;



import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.cache.FileCache;
import com.chinacreator.xtbg.core.file.dao.FileFilesDao;
import com.chinacreator.xtbg.core.file.dao.FileFirstPageDao;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.entity.FileDocFilesBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;
import com.chinacreator.xtbg.core.file.entity.FileNoteBean;
import com.chinacreator.xtbg.core.file.entity.FilePanExtBean;
import com.chinacreator.xtbg.core.file.entity.FileTypeBean;
import com.chinacreator.xtbg.core.file.entity.ShowItemBean;
import com.chinacreator.xtbg.core.file.service.FileFilesService;
import com.chinacreator.xtbg.core.file.service.FileFirstPageService;
import com.chinacreator.xtbg.core.file.util.FileConstant;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FileFilesServiceImpl.java</p>
 *<p>Description:档案管理业务层实现类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-17
 */
public class FileFilesServiceImpl implements FileFilesService,FileFirstPageService {
	private static final Logger LOG = Logger
			.getLogger(FileFilesServiceImpl.class);
	private FileFilesDao dao = null;

	/**
	 * 
	 * <b>Summary: </b> 构造一个 FileFilesServiceImpl <b>Remarks: </b> 构造类
	 * FileFilesServiceImpl 的构造函数 FileFilesServiceImpl
	 */
	public FileFilesServiceImpl() {
		this.dao = (FileFilesDao) LoadSpringContext.getApplicationContext()
				.getBean("fileFilesDaoImpl");
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 queryDictByCode
	 * 
	 * @param code
	 * @return
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesService#queryDictByCode(java.lang.String)
	 */
	@Override
	public List<Map<String, String>> queryDictByCode(String code) {
		try {
			if (StringUtil.nullOrBlank(code)) {
				return new ArrayList<Map<String, String>>();
			}
			return dao.queryDictByCode(code);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ArrayList<Map<String, String>>();
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryToFileFilesBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFilesService#queryToFileFilesBean(java.lang.String)
	 */
	public FileFilesBean queryToFileFilesBean(String id) {
		Connection conn = null;		
		FileFilesBean bean = new FileFilesBean();
		try {
			conn = DbManager.getInstance().getConnection();		
			bean.setF_files_id(id);			
			return (FileFilesBean)((BaseDao)dao).queryToBean(bean,conn);			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return bean;
		}finally{
			DbManager.closeConnection(conn);
		}
	}	
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertFileFiles
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFilesService#insertFileFiles(com.chinacreator.xtbg.core.file.entity.FileFilesBean)
	 */
	public boolean insertFileFiles(FileFilesBean bean) {
		Connection conn = null;
		try {
			if (null == bean) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			
			// 将字符串时间转换为Timestamp
			bean.setF_start_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_start_time())));
			bean.setF_end_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_end_time())));
			bean.setF_file_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_file_time())));
			// 插入
			((BaseDao) dao).insert(bean, conn);			

			conn.commit();
			return true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateFileFiles
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFilesService#updateFileFiles(com.chinacreator.xtbg.core.file.entity.FileFilesBean)
	 */
	public boolean updateFileFiles(FileFilesBean bean) {
		Connection conn = null;
		try {
			if (null == bean) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			
			// 将字符串时间转换为Timestamp
			bean.setF_start_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_start_time())));
			bean.setF_end_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_end_time())));
			bean.setF_file_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_file_time())));
			// 更新 
			((BaseDao) dao).update(bean, conn);			

			conn.commit();
			return true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateListFiles
	  * @param map
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFilesService#updateListFiles(java.util.Map)
	 */
	public boolean updateListFiles(Map<String, Object> map) {
		Connection conn = null;
		try {
			if (null == map) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			dao.updateListFiles(map, conn);
			String flag = StringUtil.deNull(map.get("filenoFlag"));
			if (FileConstant.FILENO_CREATE_YES.equals(flag)) {
				// 根据条件查询案卷列表
				List<Map<String, String>> fileList = dao.queryListFile4update(
						map, conn);
				// 重新生成档号
				if (null != fileList) {
					for (Map<String, String> file : fileList) {
						String fileId = file.get("f_files_id");
						String typeId = file.get("f_type_id");
						if (!StringUtil.nullOrBlank(fileId)
								&& !StringUtil.nullOrBlank(typeId)) {
							createFileno(typeId, fileId, conn);
						}
					}
				}
			}
			conn.commit();
			return true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}

	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteListFileFiles
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFilesService#deleteListFileFiles(java.lang.String)
	 */
	public boolean deleteListFileFiles(String ids) {
		// 数据库连接
		Connection conn = null;
		try {
			if(StringUtil.nullOrBlank(ids)){
				return true;
			}
			conn = DbManager.getInstance().getTransactionConnection();			
			//更改文件的状态为待归档
			dao.updateDocStateByFileIds(ids, conn);
			//删除备考表
			dao.deleteFileNote(ids,conn);
			//删除档案文件对应关系表数据
			dao.deleteListDocFiles(ids, conn);
			FileFilesBean bean = new FileFilesBean();
			bean.setDeleteKey("f_files_id");
			
			// 删除档案操作
			((BaseDao) dao).deleteListById(bean, conn, ids);
			// 关闭连接并提交事务
			conn.commit();
			return true;
		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	*<b>Summary: 根据单位id查询全宗号列表</b>
	* queryListFondsno()
	* @param orgId 机构id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryListFondsno(String orgId){
		try {
			if (StringUtil.nullOrBlank(orgId)) {
				return new ArrayList<Map<String, String>>();
			}
			return dao.queryListFondsno(orgId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ArrayList<Map<String, String>>();
		}		
	}

	/**
	 * 
	 *<b>Summary: 文件的入卷操作</b>
	 * insertDocFiles()
	 * @param ids    文件id列表，用,拼接
	 * @param fileId 文档id
	 * @return 是否操作成功的标示
	 */
    public boolean insertDocFiles(String ids,String fileId,String userId,String userName){
    	// 数据库连接
		Connection conn = null;
		try {
			if (StringUtil.nullOrBlank(ids) || StringUtil.nullOrBlank(fileId)) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			String[] idArray = ids.split("\\,");
			// 先将可能存在的冗余数据删掉(一个文件只允许入卷一次)
			((BaseDao) dao).deleteListById(new FileDocFilesBean()
					.setDeleteKey("f_doc_id"),conn, ids);
			//循环插入数据
			FileDocFilesBean bean ;
			FileDocBean doc;
			for (String id : idArray) {
				bean = new FileDocFilesBean();
				bean.setF_doc_id(id);
				bean.setF_docfiles_id(StringUtil.getUUID());
				bean.setF_files_id(fileId);
				((BaseDao) dao).insert(bean,conn);
				
				//更新文件信息（状态改为已归档）
				doc = new FileDocBean();
				doc.setF_doc_id(id);
				doc.setF_doc_state(FileDocBean.STATE_YGD);
				doc.setF_doc_state_name(FileDocBean.STATE_YGD_NM);
				doc.setF_file_time(new Timestamp(System.currentTimeMillis()));
				doc.setF_file_userid(userId);
				doc.setF_file_username(userName);
				((BaseDao) dao).update(doc,conn);				
			}
			
			//
			this.keepRightData(conn,fileId);
			//提交事务
			conn.commit();
			return true;

		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
    }
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
			String idsTo) {
		// 数据库连接
		Connection conn = null;
		try {
			if (StringUtil.nullOrBlank(fileId)||StringUtil.nullOrBlank(fileIdTo)) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			// 先将可能存在的冗余数据删掉(一个文件只允许入卷一次)
			((BaseDao) dao).deleteListById(new FileDocFilesBean()
					.setDeleteKey("f_doc_id"), conn, ids + "," + idsTo);
		
			//插入数据
			insertFileDocFiles(fileId,ids,conn);
			insertFileDocFiles(fileIdTo,idsTo,conn);			

			this.keepRightData(conn,fileId,fileIdTo);
			// 提交事务
			conn.commit();
			return true;

		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary: </b>
	* insertFileDocFiles()
	* @param filesId
	* @param ids
	* @param conn
	* @throws Exception
	 */
	private void insertFileDocFiles(String filesId,String ids,Connection conn) throws Exception{
		

		String[] idArray = {};
		if (!StringUtil.nullOrBlank(ids)) {
			idArray = ids.split("\\,");
		}
		// 循环插入数据
		FileDocFilesBean bean;
		for (String id : idArray) {
			bean = new FileDocFilesBean();
			bean.setF_doc_id(id);
			bean.setF_docfiles_id(StringUtil.getUUID());
			bean.setF_files_id(filesId);
			((BaseDao) dao).insert(bean, conn);
		}
	}
    
    /**
     * 
      * <b>Summary: </b>
      *     复写方法 deleteDocFiles
      * @param ids
      * @param docIds
      * @return 
      * @see com.chinacreator.xtbg.core.file.service.FileFilesService#deleteDocFiles(java.lang.String, java.lang.String)
     */
    public boolean deleteDocFiles(String ids,String docIds){
    	// 数据库连接
		Connection conn = null;
		try {
			if (StringUtil.nullOrBlank(ids) || StringUtil.nullOrBlank(docIds)) {
				return false;
			}
			
			PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql.append("select f_files_id from oa_file_docfiles where '"+ids+"' like '%'||f_docfiles_id||'%'");
			preparedDBUtil.executeSelect(sql.toString());//这里不能加conn
			String f_files_id = preparedDBUtil.getString(0, 0);
			//删除对应关系
			conn = DbManager.getInstance().getTransactionConnection();
			((BaseDao) dao).deleteListById(new FileDocFilesBean(),conn, ids);			
			
			//更新文件状态为未归档
			String[] docIdArray = docIds.split("\\,");
			FileDocBean bean ;
			for(String id : docIdArray){
				bean = new FileDocBean();
				bean.setF_doc_id(id);
				bean.setF_doc_state(FileDocBean.STATE_DGD);
				bean.setF_doc_state_name(FileDocBean.STATE_DGD_NM);
				//bean.setF_file_time(null);底层不支持将时间修改为null
				bean.setF_file_userid("");
				bean.setF_file_username("");
				bean.setF_file_no("");//入卷 加档号靠JS，出卷直接删
				((BaseDao) dao).update(bean,conn);
			}
			
			this.keepRightData(conn, f_files_id);
			//提交事务
			conn.commit();
			return true;

		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
    }


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateListDoc
	  * @param map
	  * @see com.chinacreator.xtbg.core.file.service.FileFilesService#updateListDoc(java.util.Map, java.sql.Connection)
	 */
	public boolean updateListDoc(Map<String, Object> map) {
		Connection conn = null;
		try {
			if (null == map) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			dao.updateListDoc(map, conn);
			conn.commit();
			return true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}		
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateFileDoc
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFilesService#updateFileDoc(com.chinacreator.xtbg.core.file.entity.FileDocBean)
	 */
	public boolean updateFileDoc(FileDocBean bean){
		Connection conn = null;
		try {
			if (null == bean) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			((BaseDao)dao).update(bean, conn);//更新
			conn.commit();
			return true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}		
	}
	
	/**
	 * 
	*<b>Summary: 根据档案id查询备考表信息</b>
	* queryToFileNote()
	* @param fileId 档案id
	* @return
	 */
	public FileNoteBean queryToFileNote(String fileId) {
		FileNoteBean bean = new FileNoteBean();
		Connection conn = null;
		try {
			if (StringUtil.nullOrBlank(fileId)) {
				return bean;
			}
			conn = DbManager.getInstance().getConnection();

			// 根据档案id查询
			bean.setPKey("f_files_id");
			bean.setF_files_id(fileId);
			return (FileNoteBean) ((BaseDao) dao).queryToBean(bean, conn);

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return bean;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	
	/**
	 * 
	*<b>Summary:保存或更新备考表信息 </b>
	* saveFileNoteBean()
	* @param bean
	* @return
	 */
	public boolean saveFileNoteBean(FileNoteBean bean) {
		Connection conn = null;
		try {
			if (null == bean) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			bean.setF_creat_time(StringUtil.convertStringToTimestamp(bean
					.getF_creat_time()));
			if (StringUtil.nullOrBlank(bean.getF_note_id())) {
				bean.setF_note_id(StringUtil.getUUID());
				((BaseDao) dao).insert(bean, conn);
			} else {
				((BaseDao) dao).update(bean, conn);
			}
			conn.commit();
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary:保存文件信息 </b>
	* saveFileNoteBean()
	* @param bean
	* @return
	 */
	public boolean saveFileDocBean(HttpServletRequest request) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			// 获得档案的id
			String filesId = getValue("busi_id", request);           
			FileDocBean docBean = new FileDocBean();
			// 文件标题
			docBean.setF_doc_name(getValue("OA_FILE_FILES__F_FILES_TITLE",
					request));
			docBean.setF_type_id(getValue("OA_FILE_FILES__F_TYPE_ID", request));
			docBean.setF_type_name(getValue("OA_FILE_FILES__F_TYPE_NAME",
					request));
			docBean.setF_secrecy_id(getValue("OA_FILE_FILES__F_SECRECY_ID",
					request));
			docBean.setF_secrecy_name(getValue("OA_FILE_FILES__F_SECRECY_NAME",
					request));
			docBean.setF_org_id(getValue("OA_FILE_FILES__F_ORG_ID", request));
			docBean
					.setF_org_name(getValue("OA_FILE_FILES__F_ORG_NAME",
							request));
			docBean.setF_dept_id(getValue("OA_FILE_FILES__F_DEPT_ID", request));
			docBean.setF_dept_name(getValue("OA_FILE_FILES__F_DEPT_NAME",
					request));
			docBean.setF_user_id(getValue("OA_FILE_FILES__F_FILE_USERID",
					request));
			docBean.setF_user_name(getValue("OA_FILE_FILES__F_FILE_USERNAME",
					request));
			docBean.setF_entity_type(getValue("OA_FILE_FILES__F_ENTITY_TYPE",
					request));
			docBean.setF_entity_type_name(getValue(
					"OA_FILE_FILES__F_ENTITY_TYPE_NAME", request));

			docBean.setF_doc_deadline(getValue("OA_FILE_FILES__F_DOC_DEADLINE",
					request));
			String year = getValue("OA_FILE_FILES__F_DOC_YEAR", request);
			if (StringUtil.nullOrBlank(year)) {
				year = getValue("OA_FILE_FILES_ACC__F_FILE_MONTH", request);
				if (StringUtil.nullOrBlank(year)) {
					docBean.setF_doc_year("2013");
				} else {
					docBean.setF_doc_year(year.substring(0, 3));
				}

			} else {
				docBean.setF_doc_year(year);
			}
			FileDocFilesBean docFile = new FileDocFilesBean();
			docFile.setPKey("f_files_id");
			docFile.setF_files_id(filesId);
			XtDbBaseBean xtdbBean = ((BaseDao) dao).queryToBean(docFile, conn);
			// 如果文件已经存在，更新，
			if (null != xtdbBean) {
				docBean.setF_doc_id(((FileDocFilesBean) xtdbBean)
								.getF_doc_id());
				((BaseDao) dao).update(docBean, conn);

			} else {
				// 不存在插入文件信息和对应关系
				docBean.setF_doc_id(StringUtil.getUUID());
				docBean.setF_doc_state("2");
				docBean.setF_doc_state_name("已归档");
				docBean.setF_doc_media("0");// 介质类型默认为电子和实物
				docBean.setF_doc_media_name("电子和实物");
				docBean.setF_file_num("1");// 数量默认插入1
				docBean.setF_file_num_unit_name("件");
				docBean.setF_file_num_unit("1");
				docBean.setF_file_formtime(new Timestamp(System
						.currentTimeMillis()));
				docBean.setF_creator_time(new Timestamp(System
						.currentTimeMillis()));
				((BaseDao) dao).insert(docBean, conn);

				// 插入档案文件对应关系
				FileDocFilesBean insertDocFile = new FileDocFilesBean();
				insertDocFile.setF_docfiles_id(StringUtil.getUUID());
				insertDocFile.setF_doc_id(docBean.getF_doc_id());
				insertDocFile.setF_files_id(filesId);
				((BaseDao) dao).insert(insertDocFile, conn);
			}

			conn.commit();
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary: 获得值,并转码</b>
	* getValue()
	* @param name
	* @param request
	* @return
	 */
	private String getValue(String name, HttpServletRequest request) {
		String value = request.getParameter(name);
		if (!StringUtil.nullOrBlank(value)) {
			// 解码
			return Escape.unescape(DataControlUtil.replaceStr(value));
		} else {
			return "";
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryProgramByTypeId
	  * @param typeId
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFilesService#queryProgramByTypeId(java.lang.String)
	 */
	public Map<String, String> queryProgramByTypeId(String typeId){
		Connection conn = null;
		try {			
			conn = DbManager.getInstance().getConnection();
			Map<String,String> map = dao.queryProgramByTypeId(typeId, conn);
			
			return map;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new HashMap<String,String>();
		} finally {
			DbManager.closeConnection(conn);
		}
	
	}
	
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
			PageInfoBean page) {
		try {
			return dao.findFilesPageBean4acc(bean, page);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return null;
		}
	}
	
	/**
	 * 
	*<b>Summary:根据备考表模板生成备考表信息 </b>
	* queryNoteTemplement()
	* @param typeId   档案类型id
	* @param filesId  档案id
	* @return
	* @throws Exception
	 */
	public String queryNoteTemplement(String typeId, String filesId){
		Connection conn = null;
		JSONObject json = new JSONObject();
		try {
			// 没传入id，则返回空字符串
			if (StringUtil.nullOrBlank(typeId)
					|| StringUtil.nullOrBlank(filesId)) {
				json.put("flag", false);
				json.put("value","");
				json.put("msg","操作失败");
				return json.toJSONString();
			}

			conn = DbManager.getInstance().getConnection();		
			
			//获得备考表模板
			FileTypeBean type = queryToFileType(typeId,conn);	
            String temp = type.getF_template_record_table();
            
            if(StringUtil.nullOrBlank(temp)){
            	json.put("flag", false);
				json.put("value","");
				json.put("msg","没有为该类型档案配置备考表模板");
				return json.toJSONString();
            }
            
            //根据模板信息查询存在的键值对
            List<Map<String,String>> dictMap = dao.queryDictDataByTemp(temp,FileConstant.DICT_TYPE_BKBMBCS_ID,conn);
            //根据档案主表表单id，查询主表名，及其子表名
            List<Map<String,String>> tableMap = dao.queryTables(FileConstant.FILE_TABLE_ID,conn);
            
            if(null != tableMap && !tableMap.isEmpty()){
				for (Map<String, String> table : tableMap) {
					Map<String, String> values = dao.queryByTableName(table
							.get("table_code"), filesId, conn);
					for(Map<String,String> dictData : dictMap){
						//得到模板中的键对应的档案中值
						String value = values.get(dictData.get("dictdata_value").toLowerCase());
						if(!StringUtil.nullOrBlank(value)){
							 //将模板中匹配的值替换掉,(由于分类管理里面是用【】包围变量，故需要将中括号也一并替换掉)
							 temp = temp.replaceAll("【"+dictData.get("dictdata_name")+"】", value);
						}			
					}
				}
            }
            json.put("flag", true);
			json.put("value",temp);
			json.put("msg","操作成功");
			return json.toJSONString();          
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			json.put("flag", false);
			json.put("value","");
			json.put("msg","出现异常,操作失败");
			return json.toJSONString();
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: 根据id查询类型信息</b>
	* queryToFileNote()
	* @param id 类型id
	* @return
	 * @throws Exception 
	 */
	private FileTypeBean queryToFileType(String id,Connection conn) throws Exception {
		FileTypeBean bean = new FileTypeBean();
		if (StringUtil.nullOrBlank(id)) {
			return bean;
		}
		// 根据id查询
		bean.setF_type_id(id);

		return (FileTypeBean) ((BaseDao) dao).queryToBean(bean, conn);
    }
	
	/**
	 * 
	*<b>Summary:根据id查询类型信息 </b>
	* queryToFileType()
	* @param id 类型id
	* @return
	 */
	public FileTypeBean queryToFileType(String id){
		Connection conn = null;
		try{
			conn = DbManager.getInstance().getConnection();
			return queryToFileType(id,conn);
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
			return null;
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary:根据类型id查询是否分类档案管理员 </b>
	* isFileTypeAdmin()
	* @param userId 用户id
	* @param typeId 档案分类id
	 */
	public boolean isFileTypeAdmin(String userId, String typeId) {
		Connection conn = null;
		try{
			conn = DbManager.getInstance().getConnection();
			if (StringUtil.nullOrBlank(userId)
					|| StringUtil.nullOrBlank(typeId)) {
				return false;
			}
			return dao.isFileTypeAdmin(userId, typeId, conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	*<b>Summary:根据档号模板生成档号信息 </b>
	* queryNoteTemplement()
	* @param typeId   档案类型id
	* @param filesId  档案id
	* @return
	* @throws Exception
	 */
	public String createFileno(String typeId, String filesId){
		Connection conn = null;
		JSONObject json = new JSONObject();
		json.put("flag", false);
		json.put("value","");
		json.put("msg","操作失败");
		try {
			// 没传入id，则返回空字符串
			if (StringUtil.nullOrBlank(typeId)
					|| StringUtil.nullOrBlank(filesId)) {
				return json.toJSONString();
			}

			conn = DbManager.getInstance().getTransactionConnection();		
			
			//获得档号模板
			FileTypeBean type = queryToFileType(typeId,conn);	
            String temp = type.getF_fileno_template();
            
			if (StringUtil.nullOrBlank(temp)) {
				json.put("msg", "没有为该类型档案配置备档号模板");
				return json.toJSONString();
			}
            
            //根据模板信息查询存在的键值对
            List<Map<String,String>> dictMap = dao.queryDictDataByTemp(temp,FileConstant.DICT_TYPE_DADHMBCS_ID, conn);
            //根据档案主表表单id，查询主表名，及其子表名
            List<Map<String,String>> tableMap = dao.queryTables(FileConstant.FILE_TABLE_ID,conn);
            
            if(null != tableMap && !tableMap.isEmpty()){
				for (Map<String, String> table : tableMap) {
					Map<String, String> values = dao.queryByTableName(table
							.get("table_code"), filesId, conn);
					for(Map<String,String> dictData : dictMap){
						//得到模板中的键对应的档案中值
						String value = values.get(dictData.get("dictdata_value").toLowerCase());
						if(!StringUtil.nullOrBlank(value)){
							 //将模板中匹配的值替换掉,(由于分类管理里面是用【】包围变量，故需要将中括号也一并替换掉)
							 temp = temp.replaceAll("【"+dictData.get("dictdata_name")+"】", value);
						}	
					}
				}     
            }
            //将档号更新到档案表
            FileFilesBean file = new FileFilesBean();
            file.setF_files_id(filesId);
            file.setF_files_no(temp);
            ((BaseDao)dao).update(file,conn);
            
            //将档号更新到文件表
            dao.updateDocFileno(filesId, temp, conn);
            //将档号更新到照片
            dao.updateDocFileno4pic(filesId, temp, conn);
			conn.commit();
            json.put("flag", true);
			json.put("value",temp);
			json.put("msg","操作成功");
			return json.toJSONString();          
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);			
			LOG.error(e.getMessage(), e);
			return json.toJSONString();
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: 在添加时，生成档号信息，由于记录尚未保存，故获取数据后在前台拼接数据</b>
	* createFileno4Add()
	* @param typeId
	* @param filesId
	* @return
	 */
	public String createFileno4Add(String typeId, String filesId){
		Connection conn = null;
		JSONObject json = new JSONObject();
		json.put("flag", false);
		json.put("value","");
		json.put("msg","操作失败");
		try {
			// 没传入id，则返回空字符串
			if (StringUtil.nullOrBlank(typeId)
					|| StringUtil.nullOrBlank(filesId)) {
				
				return json.toJSONString();
			}

			conn = DbManager.getInstance().getTransactionConnection();		
			
			//获得档号模板
			FileTypeBean type = queryToFileType(typeId,conn);	
            String temp = type.getF_fileno_template();
            
			if (StringUtil.nullOrBlank(temp)) {
				json.put("msg", "没有为该类型档案配置档号模板");
				return json.toJSONString();
			}
            
            //根据模板信息查询存在的键值对
            List<Map<String,String>> dictMap = dao.queryDictDataByTemp(temp,FileConstant.DICT_TYPE_DADHMBCS_ID, conn);
            conn.commit();
            json.put("flag", true);
			json.put("value",temp);
			json.put("list", dictMap);
			json.put("msg","操作成功");			
			return json.toJSONString();          
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);			
			LOG.error(e.getMessage(), e);
			return json.toJSONString();
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: 查询卷内文件</b>
	* findDocPageBeanForFiles()
	* @param map
	* @return
	 */
	public PagingBean findDocPageBeanForFiles(Map<String, String> map) {
		try {
			FileFilesDao dao = (FileFilesDao) LoadSpringContext
					.getApplicationContext().getBean("fileFilesDaoImpl");
			return dao.findDocPageBeanForFiles(map);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return null;
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryDocDesc4Export
	  * @param filesId
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.service.FileFilesService#queryDocDesc4Export(java.lang.String, java.sql.Connection)
	 */
	@Override
	public List<Map<String,String>> queryDocDesc4Export(String filesId ) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			return dao.queryDocDesc4Export(filesId, conn);
		}finally{
			DbManager.closeConnection(conn);
		}		
	}
	/**
	 * 
	*<b>Summary:根据档案id查询该档案内的光盘详情，用于 导出</b>
	* queryDocTip()
	* @param filesId
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> queryDocDesc4ExportDisk(String filesId) throws Exception{
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			return dao.queryDocDesc4ExportDisk(filesId, conn);
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary: 批量修改案卷状态</b>
	* updateListFileState()
	* @param state
	* @param fileIds
	 * @throws SQLException 
	 * @throws SQLException 
	 */
	public boolean updateListFileState(String state,String stateName,String fileIds){
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			dao.updateListFileState(state, stateName, fileIds, conn);
			conn.commit();
			return true;
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
			return false;
		}finally{			
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: 复制档案</b>
	* copyFile()
	* @param fileId
	* @return
	 */
	public FileFilesBean copyFile(String fileId){
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileFilesBean fileBean = new FileFilesBean();
			fileBean.setF_files_id(fileId);
			fileBean = (FileFilesBean) ((BaseDao) dao).queryToBean(fileBean,
					conn);
			if (null != fileBean) {
				fileBean.setF_files_num("0");
				// 复制案卷
				String newFileId = StringUtil.getUUID();
				fileBean.setF_files_id(newFileId);
				fileBean.setF_files_state("0");
				fileBean.setF_files_state_name("待归档");
				// 案卷号设置为当前最大案卷号+1
				String typeId = fileBean.getF_type_id();
				String fileNo = StringUtil.deNull(queryMaxFileNo(typeId,fileBean.getF_org_id()).get(
						"f_filesno"));
				fileBean.setF_filesno(fileNo);
				if (!StringUtil.nullOrBlank(fileBean.getF_file_time())) {
					fileBean
							.setF_file_time(StringUtil
									.convertStringToTimestamp(fileBean
											.getF_file_time()));
				} else {
					fileBean.setF_file_time(null);
				}
				if (!StringUtil.nullOrBlank(fileBean.getF_start_time())) {
					fileBean.setF_start_time(StringUtil
							.convertStringToTimestamp(fileBean
									.getF_start_time()));
				} else {
					fileBean.setF_start_time(null);
				}
				if (!StringUtil.nullOrBlank(fileBean.getF_end_time())) {
					fileBean
							.setF_end_time(StringUtil
									.convertStringToTimestamp(fileBean
											.getF_end_time()));
				} else {
					fileBean.setF_end_time(null);
				}
				
				((BaseDao) dao).insert(fileBean, conn);

				// 复制会计档案信息
				dao.copyFileAcc(fileId, newFileId, conn);
			}			
			
			conn.commit();
			return fileBean;			
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
			return null;
		}finally{			
			DbManager.closeConnection(conn);
		}
	}
	
	
	/**
	 * 
	*<b>Summary: 复制文件</b>
	* copyFile()
	* @param fileId
	* @return
	 */
	public FileDocBean copyDoc(String docId,String fileId){
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileDocBean docBean = new FileDocBean();
			docBean.setF_doc_id(docId);
			docBean = (FileDocBean) ((BaseDao) dao).queryToBean(docBean,
					conn);
			if (null != docBean) {
				// 复制案卷
				String newId = StringUtil.getUUID();
				docBean.setF_doc_id(newId);				
				
				if (!StringUtil.nullOrBlank(docBean.getF_file_formtime())) {
					docBean
							.setF_file_formtime(StringUtil
									.convertStringToTimestamp(docBean
											.getF_file_formtime()));
				}else{
					docBean.setF_file_formtime(null);
				}
				if (!StringUtil.nullOrBlank(docBean.getF_creator_time())) {
					docBean
							.setF_creator_time(StringUtil
									.convertStringToTimestamp(docBean
											.getF_creator_time()));
				}else{
					docBean.setF_creator_time(null);
				}
				if (!StringUtil.nullOrBlank(docBean.getF_file_time())) {
					docBean
							.setF_file_time(StringUtil
									.convertStringToTimestamp(docBean
											.getF_file_time()));
				}else{
					docBean.setF_file_time(null);
				}
				//清空附件
				docBean.setF_attach_id("");
				//件号自动加1
				String f_doc_num = StringUtil.deNull(dao.queryMaxDocNo(fileId,conn).get("f_doc_num"));
				if(!StringUtil.nullOrBlank(f_doc_num)){
					docBean.setF_doc_num(f_doc_num);
				}
				
				((BaseDao) dao).insert(docBean, conn);
				
				//将文件归档
				FileDocFilesBean docFile = new FileDocFilesBean();
				docFile.setF_doc_id(newId);
				docFile.setF_docfiles_id(StringUtil.getUUID());
				docFile.setF_files_id(fileId);
				((BaseDao) dao).insert(docFile, conn);
				//复制文件扩展信息
				copyPlanExt(docId,newId,conn);
				
				//
				this.keepRightData(conn, fileId);
			}				
			
			conn.commit();
			return docBean;			
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
			return null;
		}finally{			
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: 插入文件扩展信息</b>
	* copyPlanExt()
	* @param oldDocId
	* @param newDocId
	* @param conn
	* @throws Exception
	 */
	private void copyPlanExt(String oldDocId,String newDocId,Connection conn) throws Exception{
		FilePanExtBean extBean = new FilePanExtBean();
		//根据文件id查询文件扩展信息
		extBean.setPKey("f_doc_id");
		extBean.setF_doc_id(oldDocId);
		extBean = (FilePanExtBean)((BaseDao)dao).queryToBean(extBean, conn);
		if(null !=extBean){
		   extBean.setPKey("f_pan_id");	
		   extBean.setF_pan_id(StringUtil.getUUID());
		   extBean.setF_doc_id(newDocId);
		   ((BaseDao)dao).insert(extBean,conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: 根据类型id，生成档号</b>
	* createFileno()
	* @param typeId 类型id
	* @param filesId 档案id
	* @param conn
	 */
	private void createFileno(String typeId, String filesId,Connection conn){
		try{
			// 没传入id，则返回空字符串
			if (StringUtil.nullOrBlank(typeId)
					|| StringUtil.nullOrBlank(filesId)) {
				return ;
			}

			
			//获得档号模板
			FileTypeBean type = queryToFileType(typeId,conn);	
            String temp = type.getF_fileno_template();
            
			if (StringUtil.nullOrBlank(temp)) {
				return ;
			}
            
            //根据模板信息查询存在的键值对
            List<Map<String,String>> dictMap = dao.queryDictDataByTemp(temp,FileConstant.DICT_TYPE_DADHMBCS_ID, conn);
            //根据档案主表表单id，查询主表名，及其子表名
            List<Map<String,String>> tableMap = dao.queryTables(FileConstant.FILE_TABLE_ID,conn);
            
            if(null != tableMap && !tableMap.isEmpty()){
				for (Map<String, String> table : tableMap) {
					Map<String, String> values = dao.queryByTableName(table
							.get("table_code"), filesId, conn);
					for(Map<String,String> dictData : dictMap){
						//得到模板中的键对应的档案中值
						String value = values.get(dictData.get("dictdata_value").toLowerCase());
						if(!StringUtil.nullOrBlank(value)){
							 //将模板中匹配的值替换掉,(由于分类管理里面是用【】包围变量，故需要将中括号也一并替换掉)
							 temp = temp.replaceAll("【"+dictData.get("dictdata_name")+"】", value);
						}	
					}
				}     
            }
            //将档号更新到档案表
            FileFilesBean file = new FileFilesBean();
            file.setF_files_id(filesId);
            file.setF_files_no(temp);
            ((BaseDao)dao).update(file,conn);
            
            //将档号更新到文件表
            dao.updateDocFileno(filesId, temp, conn);
            //将档号更新到照片
            dao.updateDocFileno4pic(filesId, temp, conn);			
                 
		} catch (Exception e) {		
			LOG.error(e.getMessage(), e);
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryFirstPageData
	  * @param itemID
	  * @param userID
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFirstPageService#queryFirstPageData(java.lang.String, java.lang.String)
	 */
	@Override
	public List<Map<String, String>> queryFirstPageData(String itemID, String userID) {
		ShowItemBean showItemBean = FileCache.getShowItemMap().get(itemID);//first_config.xml配置信息
		List<Map<String, String>> list = null;
		Connection conn = null;
		try {
			if(showItemBean != null){
				conn = DbManager.getInstance().getConnection();
				list = new ArrayList<Map<String,String>>();
				String sql = showItemBean.getSql();
				List<String> params = new ArrayList<String>();
				for (int i = 0; i < showItemBean.getParamCount(); i++) {//默认sql中的所有参数只能为userid
					params.add(userID);
				}
				String columnString =  showItemBean.getShowColumns();//显示字段
				
				if(!"".equals(columnString) && !"".equals(showItemBean.getRealShowColumns())){//加样式的显示字段
					columnString += "," + showItemBean.getRealShowColumns();
				}
				
				if(!"".equals(columnString) && !"".equals(showItemBean.getUrlParamColumns())){//url参数字段
					columnString += "," + showItemBean.getUrlParamColumns();
				}
				
				if(!"".equals(columnString) && !"".equals(showItemBean.getDynamicUrlColumns())){//动态连接地址
					columnString += "," + showItemBean.getDynamicUrlColumns();
				}
				List<String> dbColumns = Arrays.asList(columnString.split(","));
				FileFirstPageDao fdao = (FileFirstPageDao) LoadSpringContext.getApplicationContext()
				.getBean("fileFilesDaoImpl");
				list = fdao.queryUserData(sql, params, dbColumns,showItemBean.getMaxRownum(), conn);
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}
	 /**
	* 
	*<b>Summary:获得当前类型最大的案卷号，并自增1 </b>
	* queryMaxFileNo()
	* @return
	* @throws Exception
	*/
	public Map<String, String> queryMaxFileNo(String typeId,String orgId){
		Connection conn = null;
		Map<String, String> map = null;
		try{
			conn = DbManager.getInstance().getConnection();
			if(StringUtil.nullOrBlank(typeId)){
				map = new HashMap<String,String>();
			}
			map = dao.queryMaxFileNo(typeId,orgId,conn);			
		}catch (Exception e) {
			LOG.error(e.getMessage(),e);
			map = new HashMap<String,String>();
		}finally{
			DbManager.closeConnection(conn);
		}
		return map;
	}
	
	/**
	 * 
	 *<b>Summary:查询卷内文件的最大件号+1 </b> queryMaxDocNo()
	 * 
	 * @param fileId
	 *            档案编号
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> queryMaxDocNo(String fileId){
		Connection conn = null;
		Map<String, String> map = null;
		try{
			conn = DbManager.getInstance().getConnection();
			if(StringUtil.nullOrBlank(fileId)){
				map = new HashMap<String,String>();
			}
			map = dao.queryMaxDocNo(fileId,conn);	
		}catch (Exception e) {
			LOG.error(e.getMessage(),e);
			map = new HashMap<String,String>();
		}finally{
			DbManager.closeConnection(conn);
		}
		return map;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 updateFilesListOrder
	 * @param bean
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesService#updateFilesListOrder(com.chinacreator.xtbg.core.file.entity.FileFilesBean)
	 */
	@Override
	public boolean updateFilesListOrder(FileFilesBean bean) {
		String ids = bean.getF_files_id();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			return dao.updateFilesListOrder(bean,conn);
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return false;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 updateFileListInFilesOrder
	 * @param bean
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesService#updateFileListInFilesOrder(com.chinacreator.xtbg.core.file.entity.FileFilesBean)
	 */
	@Override
	public boolean updateFileListInFilesOrder(FileFilesBean bean) {
		String ids = bean.getF_files_id();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			return dao.updateFileListInFilesOrder(bean,conn);
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return false;
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * keepRightData(在出卷,入卷,调卷,卷内新增的时候,维系案卷.F_FILES_NUM卷内件数的正确值)
	 * @param id
	 * @throws SQLException 
	 */
	public void keepRightData(Connection conn,String ...ids) throws  Exception{
		PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
		for (String id : ids) {
			//1,判断是那种类型的案卷
			StringBuffer sql = new StringBuffer();
			sql.append("select f_program_id");
			sql.append("          from oa_file_type");
			sql.append("         where f_type_id =");
			sql.append("               (select f_type_id");
			sql.append("                  from oa_file_files");
			sql.append("                 where F_FILES_ID = '"+id+"')");
			preparedDBUtil.executeSelect(sql.toString(), conn);
			String f_program_id = preparedDBUtil.getString(0, 0);
			sql = new StringBuffer();
			if(!FileDocBean.F_PROGRAM_ID_ZAHO_PIAN.equals(f_program_id)){
				sql.append("select count(1) countt from oa_file_docfiles where F_FILES_ID = '"+id+"'");
			}else{//照片类，查看照片信息数量
				sql = new StringBuffer();
				sql.append("select count(1) countt");
				sql.append("  from oa_file_photo_info");
				sql.append(" where f_file_id in");
				sql.append("       (select F_DOC_ID");
				sql.append("          from oa_file_docfiles");
				sql.append("         where F_FILES_ID = '"+id+"')");
			}
			preparedDBUtil.executeSelect(sql.toString(), conn);
			String count = preparedDBUtil.getString(0, 0);
			FileFilesBean file = new FileFilesBean();
            file.setF_files_id(id);
            file.setF_files_num(count);
            ((BaseDao)dao).update(file,conn);
		}
	}
}
