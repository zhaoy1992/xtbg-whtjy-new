package com.chinacreator.xtbg.core.file.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils;
import com.chinacreator.xtbg.core.common.util.ZipUtil;

public class CustomUploadFromFile {
	
	private static final Log LOG = LogFactory.getLog(CustomUploadFromFile.class);
	
	private String basePath = "";

	public void upload(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		basePath = request.getSession().getServletContext().getRealPath("");
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List<?> items = null;
		try {
			items = (List<?>) upload.parseRequest(request);
			Iterator<?> iter = items.iterator();
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (item.getContentType() != null) {
					//1:保存为文件
					Map<String,String> fileMessMap = this.save(item.getInputStream(), item.getName());
					//2:解压到文件夹
					if(fileMessMap!=null){
						String fullName = fileMessMap.get("fullName");
						String tifFilesPath = fileMessMap.get("filePath")+FileUtils.randomUUID()+"ZIPcontent"+File.separator;
						//String tifFilesPath = "D:\\workspace\\xtbgbase\\creatorepp\\ccapp\\FcAttach1\\93b956e3-0f1d-4fa0-9768-e3d260609b7bZIPcontent";//解压发
						FileUtils.mkDirectory(tifFilesPath);
						new ZipUtil().unZipFile(fullName,tifFilesPath);
						//3:合并tif
						File lastFile = new File(fileMessMap.get("filePath")+File.separator+FileUtils.randomUUID()+".tif");
						//File lastFile = new File("D:\\workspace\\xtbgbase\\creatorepp\\ccapp\\FcAttach1\\2a4967e9-3b3a-4219-9402-7db5c0009bca.tif");
						boolean flag = TiffOP.mergeTiff(lastFile, new File(tifFilesPath));
						FileInputStream ins = null;
						if(flag&&lastFile.exists()){
							try{
								ins = new FileInputStream(lastFile);
								FiletransferService ft = new FiletransferServiceImpl();
								// 保存数据库业务 到列表
								FileInfoBean filebean = new FileInfoBean();
								filebean.setExtend(".tif");
								filebean.setDjbh(request.getParameter("buessid"));
								filebean.setDjsn(FileUtils.randomUUID());
								filebean.setFilename("合并.tif");
								filebean.setAttachid(ft.getAttachId());
								filebean.setFilepos("");
								filebean.setUpload_mode("1");
								filebean.setFileInput(ins);
								filebean.setCreator("zt");
								
								List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
								listFileInfoBean.add(filebean);
								flag = ft.saveFile(listFileInfoBean);//保存文件到数据库中
								if(flag){
									response.getWriter().write("<script>parent.afterSubmitFn(1);</script>");
								}else{
									response.getWriter().write("<script>parent.afterSubmitFn(2);</script>");
								}
							}finally{
								if(ins!=null){
									ins.close();
								}
							}
							
						}else{
							response.getWriter().write("<script>parent.afterSubmitFn(2);</script>");
						}
						
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public Map<String,String> save(InputStream inputStream,String fileFullName) throws Exception{
		FileOutputStream ros = null;
		Map<String,String> fileMessMap = null;
		try{
			String  mFilePath = basePath+FiletransferServiceImpl.upload_To_SeverPath;
			FileUtils.mkDirectory(mFilePath);
			String uploadFileName = mFilePath +FileUtils.randomUUID()+ FileUtils.getFiletype(FilenameUtils.getName(fileFullName));
			ros = new FileOutputStream(new File(uploadFileName));
			byte[] b = new byte[1024];
			int i = 0;
			while ((i = inputStream.read(b)) > 0){
				ros.write(b, 0, i);
			}
			ros.write(b);
			fileMessMap = new HashMap<String,String>();
			fileMessMap.put("fullName", uploadFileName);
			fileMessMap.put("filePath", mFilePath);
		}finally{
			try {
				if (null != ros) {
					ros.flush();// 清空缓存
					ros.close();// 关闭流
				}
			}catch(Exception ex){
				LOG.error(ex.getMessage(),ex);
			}
		}
		return fileMessMap;
	}
}
