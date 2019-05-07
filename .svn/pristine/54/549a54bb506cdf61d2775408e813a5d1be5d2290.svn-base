package com.chinacreator.xtbg.core.common.fancyuoload.servlet;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * FileUploadSecondServlet继承FileUploadServlet
 *<p>Title:FileUploadSecondServlet.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-4-11
 *依赖参数
 * 1:attachmentConfig:来自oa.properties
 * 2:_Custom_Upload:来自request(个性化处理上传的配置,自己指定处理上传请求)
 * 3:buessid 绑定业务ID
 */
public class FileUploadSecondServlet extends FileUploadServlet {
	
	private static final long serialVersionUID = 1L;

	private static final Logger LOG = Logger.getLogger(FileUploadSecondServlet.class);

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//如果没有配置,或者配置无效,则使用原来的上传类
		if("false".equals(configMap.get("canUpload"))){
			LOG.info("警告:oa.properties中附件配置找不到或不正确");
			super.doGet(request, response);
			return;
		}
		
		String _Custom_Upload = request.getParameter("_Custom_Upload");
		if(_Custom_Upload!=null){
			this.doCustomUpload(_Custom_Upload, request, response);
			return;
		}
		
		List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
		boolean success = false;
		String uploadMode = configMap.get("uploadMode").toString();
		try {
			//1:获得上传位置
			String baseUrl = AttachmentConfigBean.getBaseUrl();
			if(baseUrl==null){
				LOG.info("警告:程序找不到附件可存储的根目录");
				return;
			}
			String middleUrl = AttachmentConfigBean.getMiddelUrlStr(request);
			String filePath = baseUrl + middleUrl;
			if(!AttachmentConfigBean.checkAndCreateUrl(filePath)){
				LOG.info("警告:程序无法创建附件存储的目录:"+filePath);
				return;
			}
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			//
			String djbh = StringUtil.deNull(request.getParameter("buessid"));
			if(StringUtil.nullOrBlank(djbh)){
				return;
			}
			//about tif
			String convertToTif = StringUtil.deNull(request.getParameter("convertToTif"));
			if("1".equals(convertToTif)){
				success = specialHandleForConverToTiff(listFileInfoBean,djbh,filePath,convertToTif,request,response);
			}else{//common handle
				FiletransferService ft = new FiletransferServiceImpl();
				String creator = request.getParameter("creator");
				ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
				List<?> items = (List<?>) upload.parseRequest(request);
				Iterator<?> iter = items.iterator();
				
				while (iter.hasNext()) {
					FileItem item = (FileItem) iter.next();
					if (item.getContentType() != null) {
						//1:ready args
						String fullpath = item.getName();//// 取到客户端完整 路径+文件名 c:/abc.jpg
						String filename = FilenameUtils.getName(fullpath);//文件名称
						String filetype = FileUtils.getFiletype(filename);//文件类型
						String djsn = FileUtils.randomUUID();
						String reportAbsFilePath = middleUrl + File.separator + djsn + filetype;
						//2
						if(!StringUtil.nullOrBlank(filename)){
							FileInfoBean filebean = new FileInfoBean();
							filebean.setExtend(filetype);
							filebean.setDjbh(djbh);
							filebean.setDjsn(djsn);
							filebean.setFilename(filename);
							filebean.setAttachid(ft.getAttachId());
							if(AttachmentConfigBean.UPLOAD_MODE_COMPUTER.equals(uploadMode)
									||AttachmentConfigBean.UPLOAD_MODE_DB_AND_COMPUTER.equals(uploadMode)){
								filebean.setFilepos(reportAbsFilePath);
							}
							filebean.setUpload_mode(uploadMode);
							filebean.setFileInput(item.getInputStream());
							filebean.setCreator(creator);
							//去掉大小的限制
							/*if(filebean.getAttachcontent().length > 1024*1024*20){
								response.getWriter().write("<script>alert('错误')</script>");
								return;
							}*/
							if(AttachmentConfigBean.UPLOAD_MODE_DB.equals(uploadMode)
									||AttachmentConfigBean.UPLOAD_MODE_DB_AND_COMPUTER.equals(uploadMode)){
								listFileInfoBean.add(filebean);
							}else{
								listFileInfoBean.add(filebean);
								ft.uploadFileToServer(baseUrl, filebean);//磁盘
							}
						}
					}
				}
				if(listFileInfoBean.size()>0){
					success = ft.saveFile(listFileInfoBean);//存数据库
					if(AttachmentConfigBean.UPLOAD_MODE_DB_AND_COMPUTER.equals(uploadMode)){
						//将存储到数据库的文件 存到服务器
						ft.copyFileFromDBToServer(baseUrl, listFileInfoBean);
					}
				}
			}
		} catch (Exception e) {
			success = false;
			LOG.error(e.getMessage(), e);
		} finally {
			//返回是否成功信息给前端
			if (success) {//上传成功
				if(listFileInfoBean.size() == 1){ //单个文件上传 返回 文件 文件相关信息
					FileInfoBean filebean = listFileInfoBean.get(0);
					response.getWriter().write("{success:\"true\",filename:\""+filebean.getFilename()+"\",djsn:\""+filebean.getDjsn()+"\",filetype:\""+filebean.getExtend()+"\",extend:\""+filebean.getExtend()+"\"}");
				} else {
					response.getWriter().write("{success:\"true\"}");
				}
			} else {
				response.getWriter().write("{success:\"false\"}");
			}
		} 
	}

	/**
	 * 
	 *<b>Summary: </b>
	 * specialHandleForConverToTiff(专门处理TIF转换的,这种特殊处理建议都使用_Custom_Upload参数)
	 * @param listFileInfoBean
	 * @param djbh
	 * @param filePath
	 * @param convertToTif
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	private boolean specialHandleForConverToTiff(
			List<FileInfoBean> listFileInfoBean,
			String djbh,
			String filePath,
			String convertToTif, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		boolean success = false;
		FiletransferService ft = new FiletransferServiceImpl();
		String creator = request.getParameter("creator");
		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
		List<?> items = (List<?>) upload.parseRequest(request);
		Iterator<?> iter = items.iterator();
		while (iter.hasNext()) {
			boolean toTifFlag = true;
			boolean toJpgFlag = true;
			
			FileItem item = (FileItem) iter.next();
			if (item.getContentType() != null) {
				//1:ready args
				String fullpath = item.getName();//// 取到客户端完整 路径+文件名 c:/abc.jpg
				String filename = FilenameUtils.getName(fullpath);//文件名称
				String filetype = FileUtils.getFiletype(filename);//文件类型
				String djsn = FileUtils.randomUUID();

				if(".tif".equals(filetype)){
					toTifFlag = false;
				}else{
					filetype = ".tif";
				}
				String reportAbsFilePath = filePath + File.separator + djsn + filetype;
				//2
				if(!StringUtil.nullOrBlank(filename)){
					FileInfoBean filebean = new FileInfoBean();
					filebean.setExtend(filetype);
					filebean.setDjbh(djbh);
					filebean.setDjsn(djsn);
					filebean.setFilename(filename);
					filebean.setAttachid(ft.getAttachId());
					filebean.setFilepos(reportAbsFilePath);
					//filebean.setUpload_mode(StringUtil.deNull(configMap.get("uploadMode").toString()));
					filebean.setUpload_mode(AttachmentConfigBean.UPLOAD_MODE_DB_AND_COMPUTER);
					filebean.setFileInput(item.getInputStream());
					filebean.setCreator(creator);
					//去掉大小的限制
					/*if(filebean.getAttachcontent().length > 1024*1024*20){
						response.getWriter().write("<script>alert('错误')</script>");
						return;
					}*/
					listFileInfoBean.add(filebean);
				}
				//3
				ft.uploadFileToServer(reportAbsFilePath, item
						.getInputStream(), toTifFlag,toJpgFlag);
			}
		}
		if(listFileInfoBean.size()>0){
			success = ft.saveFile(listFileInfoBean);
		}
		return success;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * doCustomUpload(自定义上传)
	 * @param _Custom_Upload
	 * @param request
	 * @param response
	 */
	private void doCustomUpload(String _Custom_Upload,HttpServletRequest request, HttpServletResponse response){
		try {
			String[] config = _Custom_Upload.split("[|]");
			String className = config[0];
			String methodName = config[1];
			Class c = Class.forName(className);
			Object o = c.newInstance();
			Method m = c.getMethod(methodName, HttpServletRequest.class,HttpServletResponse.class);
			m.invoke(o, request,response);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
	
	public FileUploadSecondServlet() {
		super(); 
	}

	public void destroy() {
		super.destroy();
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		configMap = AttachmentConfigBean.getConfigMap();
	}
	private static Map<String,Object> configMap = null;
	
	public static void main(String[] args) {
		String aa = "D://ccapp//FcAttach1//";
		System.out.println(aa.replaceAll("//", "\\\\"));
	}
}
