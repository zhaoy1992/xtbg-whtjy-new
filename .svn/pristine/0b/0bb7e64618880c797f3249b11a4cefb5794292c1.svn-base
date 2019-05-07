package com.chinacreator.xtbg.core.common.fancyuoload.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
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
 *<p>Title:FileUploadServlet.java</p>
 *<p>Description:文件上传servlet</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-10
 */
public class FileUploadServlet extends HttpServlet {
	
	private static final Logger LOG = Logger.getLogger(FileUploadServlet.class);
	
	private static final long serialVersionUID = 1L;

	public FileUploadServlet() {
		super();
	}

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String _Custom_Upload = request.getParameter("_Custom_Upload");
		if(_Custom_Upload!=null){
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
			return;
		}
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		FiletransferService ft = new FiletransferServiceImpl();
		//取得服务器路径  文件保存的路径
		String  mFilePath = request.getSession().getServletContext().getRealPath("")+FiletransferServiceImpl.upload_To_SeverPath ;  
		System.out.println(mFilePath);
		// 获得业务单号
		String buessid = request.getParameter("buessid");
		String creator = request.getParameter("creator");
		
		/**
		 * 将上传文件转换为tif格式
		 * @alter by 戴连春
		 * @alter date 2013-9-13
		 */
		//获得是否转换为tif的标记
		String convertToTif = request.getParameter("convertToTif");
		
		boolean toTifFlag = false;
		//传入了值，且传入的值为1，则认为是需要将上传文件转换为tif的
		if (!StringUtil.nullOrBlank(convertToTif)
				&& "1".equals(StringUtil.deNull(convertToTif))) {
			toTifFlag = true;
		}
		//是否将上传的文件转换为jpg
		boolean toJpgFlag = toTifFlag;

		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 存储文件列表
		List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
		
		List<?> items = null;
		boolean success = false;
		try {
			items = (List<?>) upload.parseRequest(request);
			Iterator<?> iter = items.iterator();
			
			FileUtils.mkDirectory(mFilePath);//创建文件夹
			
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (item.getContentType() != null) {
					// 取到客户端完整 路径+文件名 c:/abc.jpg
					String fullpath = item.getName();
					String realName = fullpath;
					//用uuid+系统时间重命名文件
					String uuid = FileUtils.randomUUID();
					//取到文件类型 
					String filetype = FileUtils.getFiletype(fullpath);
					
					/**
					 * 将上传文件转换为tif格式(由于现在基本上都是使用的一次上传一个文件，
					 *   故将文件读写操作放入循环中对性能并不会产生太大影响)
					 * @alter by 戴连春
					 * @alter date 2013-9-13
					 */
					//如果上传的本身就是tif格式的，则不转换
					if(".tif".equals(filetype)){
						toTifFlag = false;
					}
					
					if (!FilenameUtils.getName(fullpath).equals("")) {
						if (toTifFlag) {
							fullpath = fullpath.substring(0, fullpath
									.lastIndexOf("."))
									+ ".tif";
						}
						// 将文件上传到服务器
						String uploadFileName = mFilePath
								+ uuid
								+ FileUtils.getFiletype(FilenameUtils
										.getName(realName));
						//将文件写入服务器
						ft.uploadFileToServer(uploadFileName, item
								.getInputStream(), toTifFlag,toJpgFlag);
					}
										
					//文件名称
					String filename = FilenameUtils.getName(fullpath);
					
					
					String newFileName = uuid + "_" + FileUtils.getSysTime() + filetype;

					if (!filename.equals("")) {
						String reportAbsFilePath = mFilePath + newFileName; //新文件名文件保存路径
						// 保存数据库业务 到列表
						FileInfoBean filebean = new FileInfoBean();
						filebean.setExtend(filetype);
						filebean.setDjbh(buessid.trim());
						filebean.setDjsn(uuid);
						filebean.setFilename(filename);
						filebean.setAttachid(ft.getAttachId());
						filebean.setFilepos(reportAbsFilePath);
						filebean.setUpload_mode("1");
						filebean.setFileInput(item.getInputStream());
						//去掉大小的限制
						/*if(filebean.getAttachcontent().length > 1024*1024*20){
							response.getWriter().write("<script>alert('错误')</script>");
							return;
						}*/
						filebean.setCreator(creator);
						listFileInfoBean.add(filebean);
					}
				}
				item = null;//对象销毁
			}
			// 调用业务保存数据
			if (listFileInfoBean != null && listFileInfoBean.size() > 0) {
				success = ft.saveFile(listFileInfoBean);//保存文件到数据库中
				if(success){
					//FileUtils.mkDirectory(mFilePath);//创建文件夹
					/**
					 * 将上传文件转换为tif格式
					 * @alter by 戴连春
					 * @alter date 2013-9-13
					 */
					//ft.uploadFileToServer(mFilePath, listFileInfoBean);//将文件保存到磁盘文件中			
					
				}
			}
		} catch (Exception e) {
			success = false;
			LOG.error(e.getMessage(), e);
		} finally {
			// 返回是否成功信息给前端
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

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

	public void init() throws ServletException {
	}

}
