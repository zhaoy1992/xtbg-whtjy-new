package com.chinacreator.xtbg.pub.jqueryupload.servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.pub.jqueryupload.utils.FileUtils;

/**
 * 
 *<p>
 * Title:FileUploadServlet.java
 * </p>
 *<p>
 * Description:文件上传servlet
 * </p>
 *<p>
 * Copyright:Copyright (c) 2010
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author steven.zhu
 *@version 1.0 2011-7-11
 */
public class FileUploadServlet extends HttpServlet {
	public FileUploadServlet() {
		super();
	}

	public void destroy() {
		super.destroy();
	}

	//FIXME lei.zhang
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		FiletransferServiceImpl ft=new FiletransferServiceImpl();
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		// 获得业务单号
		String buessid = request.getParameter("buessid");
		String creator = request.getParameter("creator");

		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
			items = (List) upload.parseRequest(request);
		} catch (FileUploadException e1) {
			e1.printStackTrace();
		}

		// String rootPath =
		// request.getSession().getServletContext().getRealPath("/");
		// String saveReportPath = rootPath + "Upload/";

		String saveReportPath = "d:/temp/";
		// 最新的文件路径和名字
		String reportAbsFilePath = "";

		// 存储文件列表
		List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
		boolean flag = false;
		Iterator iter = items.iterator();
		while (iter.hasNext()) {
			FileItem item = (FileItem) iter.next();

			if (item.getContentType() != null) {

				// 取到客户端完整 路径+文件名 c:/abc.jpg
				String fullpath = item.getName();

				// 取到 文件名 abc.jpg
				// String filename = new
				// String((FilenameUtils.getName(fullpath)).getBytes("GBK"),"UTF-8");

				String filename = FilenameUtils.getName(fullpath);
				// 取到文件类型 jpg
				String filetype = FileUtils.getFiletype(filename);
				// 得到uuid把文件重新命明
				String uuid = FileUtils.randomUUID();
				String newFileName = uuid + "_" + FileUtils.getSysTime()
				+ filetype;

				if (!filename.equals("")) {
					reportAbsFilePath = saveReportPath + newFileName; // 新文件名文件保存路径
					try {
						flag = true;
						// 保存数据库业务 到列表
						FileInfoBean filebean = new FileInfoBean();
						filebean.setExtend(filetype);
						filebean.setDjbh(buessid);
						filebean.setDjsn(uuid);
						filebean.setFilename(filename);
						filebean.setAttachid(ft.getAttachId());
						filebean.setFilepos(reportAbsFilePath);
						filebean.setUpload_mode("1");
						filebean.setAttachcontent(FileUtils
								.getFileBytes(item.getInputStream()));
						filebean.setFileInput(item.getInputStream());
						if(filebean.getAttachcontent().length > 1024*1024*50){
							response.getWriter().write("<script>alert('错误')</script>");
							return;
						}
						filebean.setCreator(creator);
						listFileInfoBean.add(filebean);

					} catch (Exception e) {
						flag = false;
						e.printStackTrace();
					} finally {
						item = null;
						// 返回是否成工信息给前端
						if (flag) {
							if(listFileInfoBean.size() == 1){
								FileInfoBean filebean = listFileInfoBean.get(0);
								response.getWriter().write("{success:\"true\",filename:\""+filebean.getFilename()+"\",djsn:\""+filebean.getDjsn()+"\",extend:\""+filebean.getExtend()+"\"}");
							} else {
								response.getWriter().write("{success:\"true\"}");
							}
							
						} else {
							response.getWriter().write("{success:\"false\"}");
						}
						flag = false;
					}

				}
			}
		}
		// 调用业务保存数据
		if (listFileInfoBean != null && listFileInfoBean.size() > 0) {

			ft.saveFile(listFileInfoBean);
			String  mFilePath = request.getSession().getServletContext().getRealPath("") ;  //取得服务器路径
			ft.uploadFileToServer(mFilePath+FiletransferServiceImpl.upload_To_SeverPath, listFileInfoBean);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

	public void init() throws ServletException {
	}

}
