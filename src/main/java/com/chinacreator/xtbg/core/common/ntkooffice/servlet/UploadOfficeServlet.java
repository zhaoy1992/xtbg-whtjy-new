package com.chinacreator.xtbg.core.common.ntkooffice.servlet;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.ntkooffice.services.AbstractUploadOfficeService;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 *<p>Title:UploadOfficeServlet.java</p>
 *<p>Description:NTKO Offic 文件上传</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013年10月11日
 */
public class UploadOfficeServlet extends HttpServlet{

	private static final Log LOG = LogFactory.getLog(UploadOfficeServlet.class);
	
	private static final long serialVersionUID = 1L;
	
	private static final String tempFolder = "d:\\upload\\temp";//TODO 　路径配置 

	public UploadOfficeServlet() {
		super();
	}

	public void destroy() {
		super.destroy();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		AccessControl accesscontroler = AccessControl.getAccessControl();
		accesscontroler.checkAccess(request, response);
		String result = "";
		Map<String,Object> formFieldMap = new HashMap<String, Object>();
		try {
			DiskFileItemFactory factory = new DiskFileItemFactory();   
	        ServletFileUpload sevletFileUpload = new ServletFileUpload(factory);  
	        // 设置允许用户上传文件大小,单位:字节，这里设为20m  
	        sevletFileUpload.setSizeMax(20 * 1024 * 1024);  
	        //设置最多只允许在内存中存储的数据,单位:字节  
	        factory.setSizeThreshold(4096);  
	        // 设置一旦文件大小超过getSizeThreshold()的值时数据存放在硬盘的目录 
	        checkFolder(tempFolder);
	        factory.setRepository(new File(tempFolder));
	        // 开始读取上传信息   
	        @SuppressWarnings("unchecked")
			List<FileItem> fileItems = sevletFileUpload.parseRequest(request);  
	        for(FileItem item : fileItems){
	        	if(item.isFormField()){
	        		formFieldMap.put(item.getFieldName(), item.getString("UTF-8"));
	        	}else{
	        		formFieldMap.put(item.getFieldName(), item);
	        	}
	        }
	        String className = StringUtil.deNull(request.getParameter("className"));
	        if(!"".equals(className)){
	        	AbstractUploadOfficeService services = (AbstractUploadOfficeService) Class.forName(className).newInstance();//反射获取业务保存实现类实例
	 	        services.init(request, response,accesscontroler);
	 	       result = services.handleFromData(formFieldMap);
	        }else{
	        	throw new Exception("请指定office 数据处理服务！");
	        }
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}finally{
			formFieldMap.clear();
			formFieldMap = null;
		}
		response.getWriter().write(result);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
	/**
	 *<b>Summary: 判断文件夹是否存在，不存在则创建</b>
	 * checkFolder()
	 * @param path
	 */
	private void checkFolder(String path) {
		File tempfolder = new File(path);
		if (!tempfolder.exists()) {
			tempfolder.mkdirs();
		}
	}
	
}
