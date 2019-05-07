package com.chinacreator.xtbg.core.common.ntkooffice.services;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;

import com.chinacreator.security.AccessControl;

/**
 *<p>Title:AbstractUploadOfficeService.java</p>
 *<p>Description:ntko office 文件上传处理服务</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013年10月11日
 */
public abstract class AbstractUploadOfficeService {
	
	protected HttpServletRequest request;
	
	protected HttpServletResponse response;
	
	protected AccessControl accesscontroler;
	
	/**
	 *<b>Summary: 初始化服务</b>
	 * init()
	 * @param request
	 * @param response
	 * @param accesscontroler
	 */
	public void init(HttpServletRequest request, HttpServletResponse response,AccessControl accesscontroler){
		this.request=request;
		this.response=response;
		this.accesscontroler=accesscontroler;
	}
	
	/**
	 *<b>Summary: 保存提交表单中的数据</b>
	 * handleFromData()
	 * @param formFieldMap 表单数据，map中值：非文件是String，文件为 org.apache.commons.fileupload.FileItem
	 * @return
	 * @throws Exception
	 */
	public abstract String handleFromData(Map<String,Object> formFieldMap) throws Exception;
	
	/**
	 *<b>Summary: 文件保存到磁盘</b>
	 * saveFileToDisk()
	 * @param fileitem
	 * @param filePath
	 * @return
	 */
	protected void saveFileToDisk(FileItem fileitem,String filePath) throws Exception{
		File file =  new File(filePath);
		fileitem.write(file);
	}
	
	/**
	 *<b>Summary: 判断文件夹是否存在，不存在则创建</b>
	 * checkFolder()
	 * @param path
	 */
	protected void checkFolder(String path) {
		File tempfolder = new File(path);
		if (!tempfolder.exists()) {
			tempfolder.mkdirs();
		}
	}

}
