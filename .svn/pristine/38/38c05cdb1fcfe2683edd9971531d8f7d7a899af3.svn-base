package com.chinacreator.xtbg.core.file.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileStorageLocationDao;
import com.chinacreator.xtbg.core.file.entity.FileStorageLocationBean;
import com.chinacreator.xtbg.core.file.service.FileStorageLocationServiceIfc;
/**
 * 
 *<p>Title:FileStorageLocationServiceImpl.java</p>
 *<p>Description:档案存放位置管理服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-15
 */
public class FileStorageLocationServiceImpl implements FileStorageLocationServiceIfc {

	private static final Log LOG=LogFactory.getLog(FileStorageLocationServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteFileStorage
	  * @param f_storage_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileStorageLocationServiceIfc#deleteFileStorage(java.lang.String)
	 */
	public String deleteFileStorage(String f_storage_id) {
		Connection conn = null;
		String flag = "false";
		String[]  f_storage_idsArray = null;
		int count=0;
		FileStorageLocationBean fileStorageLocationBean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileStorageLocationDao fileStorageLocationDao = (FileStorageLocationDao)LoadSpringContext.getApplicationContext().getBean("fileStorageLocationDaoImpl");
			if(!StringUtil.isBlank(f_storage_id)) {
				f_storage_idsArray = f_storage_id.split(",");
				for (int i = 0; i < f_storage_idsArray.length; i++) {
					fileStorageLocationBean = new FileStorageLocationBean();
					fileStorageLocationBean.setF_storage_id(f_storage_idsArray[i]);
					if(fileStorageLocationDao.isFileStorageLocationBean(f_storage_idsArray[i], conn)==0){
						((BaseDao)fileStorageLocationDao).deleteListById(fileStorageLocationBean, conn, f_storage_idsArray[i]);
					}else{
						count++;//有子类就加一
					}
				}
			}
			if(count>0){
				flag="parent";
			}else{
				flag = "true";
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFileStorangeLocationBean
	  * @param f_storage_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileStorageLocationServiceIfc#getFileStorangeLocationBean(java.lang.String)
	 */
	public Map<String, String> getFileStorangeLocationBean(String f_storage_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			FileStorageLocationDao fileStorageLocationDao = (FileStorageLocationDao)LoadSpringContext.getApplicationContext().getBean("fileStorageLocationDaoImpl");
			viewMap = fileStorageLocationDao.getFileStorageLocationBean(f_storage_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addFileStorageLocation
	  * @param fileStorageLocationBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileStorageLocationServiceIfc#addFileStorageLocation(com.chinacreator.xtbg.core.file.entity.FileStorageLocationBean)
	 */
	public boolean addFileStorageLocation(
			FileStorageLocationBean fileStorageLocationBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			List<Map<String, String>> list= new ArrayList<Map<String,String>>();
			FileStorageLocationDao fileStorageLocationDao = (FileStorageLocationDao)LoadSpringContext.getApplicationContext().getBean("fileStorageLocationDaoImpl");
			if(StringUtil.isBlank(fileStorageLocationBean.getF_perant_id())){
				fileStorageLocationBean.setF_perant_id("0");
			}
			fileStorageLocationBean.setF_storage_id(StringUtil.getUUID());
			if(StringUtil.isBlank((String)fileStorageLocationBean.getF_creator_time())) {
				fileStorageLocationBean.setF_creator_time(null);
			} else {
				fileStorageLocationBean.setF_creator_time(StringUtil.convertStringToTimestamp(fileStorageLocationBean.getF_creator_time().toString()));
			}
			//得到存放位置的URL
			list=fileStorageLocationDao.getFileStorageLocationURL(fileStorageLocationBean.getF_perant_id());
			String urlid="";
			String urlname="";
			if(list.size()>0){
				for (int i = 0; i < list.size(); i++) {
					Map<String, String> valueMap=list.get(i);
					urlid += valueMap.get("f_storage_id")+",";
					urlname +=valueMap.get("f_storage_shotname")+"->";
				}
			}
			urlid+=fileStorageLocationBean.getF_storage_id();
			urlname+=fileStorageLocationBean.getF_storage_shotname();
			
			fileStorageLocationBean.setF_storage_urlid(urlid);
			fileStorageLocationBean.setF_storage_urlname(urlname);
			((BaseDao)fileStorageLocationDao).insert(fileStorageLocationBean, conn);
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);			
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateFileStorageLocatio
	  * @param fileStorageLocationBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileStorageLocationServiceIfc#updateFileStorageLocatio(com.chinacreator.xtbg.core.file.entity.FileStorageLocationBean)
	 */
	public boolean updateFileStorageLocation(
			FileStorageLocationBean fileStorageLocationBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileStorageLocationDao fileStorageLocationDao = (FileStorageLocationDao)LoadSpringContext.getApplicationContext().getBean("fileStorageLocationDaoImpl");
			if(StringUtil.isBlank((String)fileStorageLocationBean.getF_creator_time())) {
				fileStorageLocationBean.setF_creator_time(null);
			} else {
				fileStorageLocationBean.setF_creator_time(StringUtil.convertStringToTimestamp(fileStorageLocationBean.getF_creator_time().toString()));
			}
			//更新存放路径
			String urlname=fileStorageLocationBean.getF_storage_urlname();
			String urlnameold=fileStorageLocationBean.getF_storage_urlname();
			if(!StringUtil.isBlank(urlname)&&(urlname.indexOf("->")>-1)){
				urlname=urlname.substring(0, urlname.lastIndexOf("->")+2)+fileStorageLocationBean.getF_storage_shotname();
			}else if(!StringUtil.isBlank(urlname)&&(urlname.indexOf("->")==-1)){
				urlname=fileStorageLocationBean.getF_storage_shotname();
			}
			fileStorageLocationBean.setF_storage_urlname(urlname);
			((BaseDao)fileStorageLocationDao).update(fileStorageLocationBean, conn);
			//更新子类存放位置
			List<Map<String, String>> list=new ArrayList<Map<String,String>>();
			list=fileStorageLocationDao.selChildFileStorageLocationBean(fileStorageLocationBean.getF_storage_id());
			for (int i = 0; i < list.size(); i++) {
				Map<String, String> mapvalue=new HashMap<String , String>();
				FileStorageLocationBean filestorage=new FileStorageLocationBean();
				mapvalue=list.get(i);
				String id=mapvalue.get("f_storage_id");
				String name=mapvalue.get("f_storage_urlname");
				name=name.replace(urlnameold, urlname);
				filestorage.setF_storage_id(id);
				filestorage.setF_storage_urlname(name);
				((BaseDao)fileStorageLocationDao).update(filestorage, conn);
			}
			
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);			
		}
		return flag;
	}
	
}
