package com.chinacreator.xtbg.core.file.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.file.entity.FileDocBean;


/**
 * 
 *<p>Title:FileFilesService.java</p>
 *<p>Description:文件管理service接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *2013-7-17
 */
public interface FileDocService {
	/**
	 * 
	 *<b>Summary: </b>
	 * getPhotoMess(获得照片信息)
	 * @param id :照片组ID，或照片ID
	 * @param type：1：照片组，2：照片
	 * @return
	 */
	public List<Map<String,String>> getPhotoMess(String id,String type);
	
	/**
	 * 
	 *<b>Summary: </b>
	 * getPhotoFileMess(获得照片组信息)
	 * @param id
	 * @return
	 */
	public List<Map<String,String>> getPhotoFileMess(String id);
	
	/**
	 * 
	 *<b>Summary: </b>
	 * getPhoto(获得照片组信息)
	 * @param id
	 * @return
	 */
	public List<Map<String,String>> getPhoto(String id);
	/**
	 * 
	 *<b>Summary: </b>
	 * initBeanForArchive(为展开归档页面初始化归档信息)
	 * @param busiId
	 * @param fjId
	 * @return
	 */
	public FileDocBean initBeanForArchive(String userId,String mFilePath,String fileDocBeforeArchiveBeanId,String fjId);
	/**
	 * 
	 *<b>Summary: </b>
	 * copyFile(依据文件ID copy文件 ,并返回新文件的ID)
	 * 模仿 FileFilesService.copyDoc实现
	 * @param oldId
	 * @return
	 */
	public String copyFileById(String oldId);
	/**
	 * 
	 *<b>Summary: </b>
	 * copyDocPhotoMessById(依据文件ID copy文件 ,并返回新文件的ID)
	 * @param oldId
	 * @return
	 */
	public String copyDocPhotoMessById(String oldId);
	/**
	 *<b>Summary: </b>
	 * getNewMessForInsert(为新增数据,提供参考数据,选择 同一用户,同一类别)
	 * @param userId
	 * @param fileType
	 * @return
	 */
	public Map<String,String> getNewMessForInsert(String userId,String fileType,String deptId,String f_files_id);
}
