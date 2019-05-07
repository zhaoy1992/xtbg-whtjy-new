package com.chinacreator.xtbg.core.file.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.imploracle.FileDocDaoImpl;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.entity.FileDocPhotoInfoBean;
import com.chinacreator.xtbg.core.file.entity.FilePanExtBean;
import com.chinacreator.xtbg.core.file.service.FileDocService;
/**
 * 
 *<p>Title:FileFilesServiceImpl.java</p>
 *<p>Description:档案管理业务层实现类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *2013-7-17
 */
public class FileDocServiceImpl implements FileDocService {
	private static final Logger LOG = Logger
	.getLogger(FileDocServiceImpl.class);
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getPhotoMess
	 * @param id
	 * @param type
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileDocService#getPhotoMess(java.lang.String, java.lang.String)
	 */
	@Override
	public List<Map<String, String>> getPhotoMess(String id, String type) {
		Connection conn = null;
		List<Map<String, String>> list = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileDocDaoImpl dao = new FileDocDaoImpl();
			//1:照片组,2:照片
			if("1".equals(type)){
				list = dao.getPhotoFileById(id, conn);
			}else if("2".equals(type)){
				list = dao.getPhotoMessById(id, conn);
			}else{
				list = new ArrayList<Map<String, String>>();
			}
		}catch (Exception e) {
			LOG.info("打印获取照片说明失败",e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getPhotoFileMess
	 * @param id
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileDocService#getPhotoFileMess(java.lang.String)
	 */
	@Override
	public List<Map<String, String>> getPhotoFileMess(String id) {
		Connection conn = null;
		List<Map<String, String>> list = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileDocDaoImpl dao = new FileDocDaoImpl();
			list = dao.getPhotoBaseFileById(id, conn);
		}catch (Exception e) {
			LOG.info("打印获取照片组说明失败",e);
			list = new ArrayList<Map<String, String>>();
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getPhoto
	 * @param id
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileDocService#getPhoto(java.lang.String)
	 */
	@Override
	public List<Map<String, String>> getPhoto(String id) {
		Connection conn = null;
		List<Map<String, String>> list = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileDocDaoImpl dao = new FileDocDaoImpl();
			list = dao.getPhoto(id, conn);
		}catch (Exception e) {
			LOG.info("打印获取照片失败",e);
			list = new ArrayList<Map<String, String>>();
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 initBeanForArchive
	 * @param fileDocBeforeArchiveBeanId
	 * @param fjId
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileDocService#initBeanForArchive(java.lang.String, java.lang.String)
	 */
	@Override
	public FileDocBean initBeanForArchive(String userId,String mFilePath,String fileDocBeforeArchiveBeanId,
			String fjId) {
		Connection conn = null;
		FileDocBean docBean = new FileDocBean();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileDocDaoImpl dao = new FileDocDaoImpl();
			//1:提取信息
			Map<String, String> bean = dao.getfileDocBeforeArchiveBeanById(fileDocBeforeArchiveBeanId, conn);
			docBean.setF_doc_name(bean.get("f_title"));
			docBean.setF_doc_fontsize(bean.get("f_file_no"));
			docBean.setF_org_id(bean.get("f_org_id"));
			docBean.setF_org_name(bean.get("f_org_name"));
			docBean.setF_dept_id(bean.get("f_dept_id"));
			docBean.setF_dept_name(bean.get("f_dept_name"));
			//2:依据fjId创建正文 原文
			dao.insertAttachForFileDoc(userId,mFilePath,bean,fjId,conn);
		}catch (Exception e) {
			LOG.info("initBeanForArchive",e);
			DbManager.rollBackNoThrow(conn);
		}finally{
			DbManager.closeConnection(conn);
		}
		return docBean;
	}
	/**
	 * 卷外复制文件 (方法实现仿照卷内复制文件)
	 * <b>Summary: </b>
	 *     复写方法 copyFileById
	 * @param oldId
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileDocService#copyFileById(java.lang.String)
	 */
	@Override
	public String copyFileById(String oldId) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileDocBean docBean = new FileDocBean();
			docBean.setF_doc_id(oldId);
			FileDocDaoImpl dao = new FileDocDaoImpl();
			docBean = (FileDocBean) ((BaseDao) dao).queryToBean(docBean,
					conn);
			if (null != docBean) {
				String newId = StringUtil.getUUID();
				docBean.setF_doc_id(newId);
				docBean.setF_file_formtime(new Timestamp(System.currentTimeMillis()));
				docBean.setF_creator_time(docBean.getF_file_formtime());
				docBean.setF_file_time(docBean.getF_file_formtime());
				
				docBean.setF_attach_id(StringUtil.getUUID());
				docBean.setF_doc_state("0");
				docBean.setF_doc_state_name("待归档");
				docBean.setF_file_num("1");
				//件号+1
				docBean.setF_doc_num((dao.getMaxFDocNumByBean(docBean,conn,null)+1)+"");
				((BaseDao) dao).insert(docBean, conn);
				//复制文件扩展信息
				copyPlanExt(oldId,newId,conn);
				conn.commit();
				return docBean.getF_doc_id();
			}else{
				conn.commit();
				return null;
			}	
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
			return null;
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * copy  FileFilesServiceImpl.copyPlanExt
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
		FileDocDaoImpl dao = new FileDocDaoImpl();
		extBean = (FilePanExtBean)((BaseDao)dao).queryToBean(extBean, conn);
		if(null !=extBean){
		   extBean.setPKey("f_pan_id");	
		   extBean.setF_pan_id(StringUtil.getUUID());
		   extBean.setF_doc_id(newDocId);
		   ((BaseDao)dao).insert(extBean,conn);
		}
	}
	@Override
	public String copyDocPhotoMessById(String oldId) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileDocPhotoInfoBean docBean = new FileDocPhotoInfoBean();
			docBean.setF_id(oldId);
			FileDocDaoImpl dao = new FileDocDaoImpl();
			docBean = (FileDocPhotoInfoBean) ((BaseDao) dao).queryToBean(docBean,
					conn);
			if (null != docBean) {
				String newId = StringUtil.getUUID();
				docBean.setF_id(newId);
				docBean.setF_attach_id(StringUtil.getUUID());
				String newFno= "1";
				try{
					newFno=""+(Integer.parseInt(docBean.getF_no())+1);
				}catch(Exception e){}
				docBean.setF_no(newFno);
				((BaseDao) dao).insert(docBean, conn);
				//复制文件扩展信息
				copyPlanExt(oldId,newId,conn);
				conn.commit();
				return docBean.getF_id();
			}else{
				conn.commit();
				return null;
			}	
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
			return null;
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * s
	 * <b>Summary: </b>
	 *     复写方法 getNewMessForInsert
	 * @param userId
	 * @param fileType
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileDocService#getNewMessForInsert(java.lang.String, java.lang.String)
	 */
	@Override
	public Map<String, String> getNewMessForInsert(String userId,
			String fileType,String deptId,String f_files_id) {
		Connection conn = null;
		Map<String, String> bean = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileDocDaoImpl dao = new FileDocDaoImpl();
			bean = dao.getNewMessForInsert(userId,fileType,deptId,f_files_id,conn);
		}catch (Exception e) {
			LOG.info("为新增获得初始化数据",e);
			bean = new HashMap<String, String>();
		}finally{
			DbManager.closeConnection(conn);
		}
		return bean;
	}
}
