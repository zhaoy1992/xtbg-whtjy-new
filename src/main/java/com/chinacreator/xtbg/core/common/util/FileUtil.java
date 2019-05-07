package com.chinacreator.xtbg.core.common.util;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao;
import com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.servlet.AttachmentConfigBean;
import com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:FileUtil.java</p>
 *<p>Description:文件处理工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *Aug 7, 2013
 */
public class FileUtil {
	private static final Log LOG = LogFactory.getLog(FileUtil.class);
	/**
	 * 文件转化为字节数组
	 * 
	 * @param file
	 * @return
	 */
	public static byte[] getBytesFromFile(File file) {
		byte[] ret = null;
		try {
			if (file == null) {
				// log.error("helper:the file is null!");
				return null;
			}
			FileInputStream in = new FileInputStream(file);
			ByteArrayOutputStream out = new ByteArrayOutputStream(4096);
			byte[] b = new byte[4096];
			int n;
			while ((n = in.read(b)) != -1) {
				out.write(b, 0, n);
			}
			in.close();
			out.close();
			ret = out.toByteArray();
		} catch (IOException e) {
			// log.error("helper:get bytes from file process error!");
			e.printStackTrace();
		}
		return ret;
	}
	
	/**
	 * 把字节数组保存为一个文件
	 * 
	 * @param b
	 * @param outputFile
	 * @return
	 */
	public static File getFileFromBytes(byte[] b, String outputFile) {
		File ret = null;
		BufferedOutputStream stream = null;
		try {
			ret = new File(outputFile);
			String dir = ret.getParent();
			File directory = new File(dir);
			if(!directory.exists()){
				directory.mkdirs();
			}
			
			FileOutputStream fstream = new FileOutputStream(ret);
			stream = new BufferedOutputStream(fstream);
			stream.write(b);
		} catch (Exception e) {
			// log.error("helper:get file from byte process error!");
			e.printStackTrace();
		} finally {
			if (stream != null) {
				try {
					stream.close();
				} catch (IOException e) {
					// log.error("helper:get file from byte process error!");
					e.printStackTrace();
				}
			}
		}
		return ret;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* tableTodisk(请用一句话描述这个方法的作用)
	* @param mFilePath
	* @param fileName
	* @return
	 */
	public static boolean tableTodisk(String mFilePath,String fileName){
		FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
		FiletransferService ft = new FiletransferServiceImpl();
		FileInfoBean fib = null;
		List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
		try{
			String[] fileList = fileName.split(",");
			if(fileList!=null && fileList.length>0){
				FileUtils.mkDirectory(mFilePath);
				for(int i=0; i<fileName.split(",").length;i++){
					File file = new File(mFilePath+fileList[i]);
					if(!file.exists()){
						
						String djsnStr = "";
						int position = fileList[i].lastIndexOf(".");
						if (position != -1) {
							djsnStr = fileList[i].substring(0, position);
						}
						fib = fsd.getFileByDjsn(djsnStr);
						listFileInfoBean.add(fib);
					}
				}
				if(listFileInfoBean.size()>0){
					ft.uploadFileToServer(mFilePath, listFileInfoBean);
				}
			}
		} catch (Exception e) {
			LOG.error("数据库文件读取到磁盘时出错",e);
		} 
		
		return true;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* tableTodisk(将数据库文件读取到磁盘的指定路径)
	* @param mFilePath
	* @param fileName
	* @return
	* @throws Exception
	 */
	public static boolean tableTodisk(String mFilePath,String file_id,String saveType,String ins_id){
		List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
		try{
			System.out.println("附件ID：==="+file_id);
			System.out.println("mFilePath路径：==="+mFilePath);
			System.out.println("saveType：==="+mFilePath);	
			if(!StringUtil.isBlank(file_id) && !StringUtil.isBlank(mFilePath) ){
				FileUtils.mkDirectory(mFilePath);//创建文件夹
				if("attach".equals(saveType)){
					listFileInfoBean = getFileByDjbh(file_id);//从附件数据库表中查询数据
				}else if("docment".equals(saveType)){
					listFileInfoBean = getFileByRecordID(file_id,"text",ins_id);//从文档表数据库表中查询数据
				}
				if(listFileInfoBean.size()>0){
					uploadFileToServer(mFilePath, listFileInfoBean);//将文件保存到磁盘文件中
				}
			}
		} catch (Exception e) {
			LOG.error("数据库文件读取到磁盘时出错",e);
		} 
		return true;
	}
	
	//根据附件ID，查找到路径。存到指定位置
	public static boolean diskTodisk(String mFilePath,String file_id,String saveType)  {
		List<FileInfoBean> listFileInfoBean =  new ArrayList<FileInfoBean>();
		try {
			listFileInfoBean = getFileByDjbh(file_id);
		} catch (Exception e) {
			LOG.error("获取附件地址出错",e);
		}//从附件数据库表中查询数据
		for(FileInfoBean fib:listFileInfoBean){
			String filePath = fib.getFilepos();
			File realFile = AttachmentConfigBean.getRealFile(filePath);
			if(realFile!=null){
				copyFile(realFile.getPath(),mFilePath+File.separator+fib.getFilename().trim());
			}
		}
		return true;
	}
	
	/** 
     * 复制单个文件 
     * @param oldPath String 原文件路径 如：c:/fqf.txt 
     * @param newPath String 复制后路径 如：f:/fqf.txt 
     * @return boolean 
     */ 
   public static void copyFile(String oldPath, String newPath) { 
       try { 
           int bytesum = 0; 
           int byteread = 0; 
           File oldfile = new File(oldPath); 
           if (oldfile.exists()) { //文件存在时 
               InputStream inStream = new FileInputStream(oldPath); //读入原文件 
               FileOutputStream fs = new FileOutputStream(newPath); 
               byte[] buffer = new byte[1444]; 
               int length; 
               while ( (byteread = inStream.read(buffer)) != -1) { 
                   bytesum += byteread; //字节数 文件大小 
                   fs.write(buffer, 0, byteread); 
               } 
               inStream.close(); 
           } 
       } 
       catch (Exception e) { 
    	   LOG.error("复制单个文件操作出错",e);
       } 

   } 
   
	/**
	 * 
	*<b>Summary: </b>
	* getFileByDjbh(附件表中读取数据)
	* @param djbh
	* @return
	* @throws Exception
	 */
	public static List<FileInfoBean> getFileByDjbh(String djbh) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<FileInfoBean> fibList = new ArrayList<FileInfoBean>();
		sql.append("select extend,djbh,filename,attachid,djsn,attachcontent,filepos,length(attachcontent) as filesize  from oa_fc_attach where djbh=? ");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, djbh);
		pdb.executePrepared();
		for(int i=0;i<pdb.size(); i++) {
			FileInfoBean fib = new FileInfoBean();
			fib.setExtend(pdb.getString(i, "extend"));
			fib.setDjbh(pdb.getString(i, "djbh"));
			fib.setFilename(pdb.getString(i, "filename"));
			fib.setAttachid(pdb.getString(i, "attachid"));
			fib.setDjsn(pdb.getString(i, "djsn"));
			fib.setFilesize(pdb.getString(i, "filesize"));
			Blob blob = pdb.getBlob(i, "attachcontent");
			if (blob != null) {
				fib.setFileInput(pdb.getBlob(i, "attachcontent").getBinaryStream());
				fib.setAttachcontent(FileUtil.getBytesFromBlob(pdb.getBlob(i, "attachcontent")));
			}
			fib.setFilepos(pdb.getString(i, "filepos"));
			fibList.add(fib);
		}
		return fibList;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getFileByDjbh(附件表中读取数据)
	* @param djbh
	* @return
	* @throws Exception
	 */
	public static List<FileInfoBean> getFileByRecordID(String recordid,String text_type,String ins_id) throws Exception {
		String sql = "select filetype,filebody from oa_document_file where recordid=? and text_type is null";
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<FileInfoBean> fibList = new ArrayList<FileInfoBean>();
		pdb.preparedSelect(sql);
		pdb.setString(1, recordid);
		pdb.executePrepared();
		if(pdb.size()>0) {
			FileInfoBean fib = new FileInfoBean();
			fib.setFilename(ins_id+pdb.getString(0, "filetype"));
		
			Blob blob = pdb.getBlob(0, "filebody");
			if (blob != null) {
				fib.setFileInput(pdb.getBlob(0, "filebody").getBinaryStream());
			}
			fibList.add(fib);
		}
		return fibList;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* uploadFileToServer(写文件)
	* @param FilePath
	* @param listFileInfoBean
	* @return
	* @throws Exception
	 */
	public static String[] uploadFileToServer(String FilePath,List<FileInfoBean> listFileInfoBean) throws Exception {
		String[] paths = new String[listFileInfoBean.size()];
		FileOutputStream fopStream = null;
		InputStream iStream = null;
		try{
			String filePath = ""; 
			int index = 0;
			for(FileInfoBean fib:listFileInfoBean){
				filePath = FilePath+fib.getFilename();
				filePath =  filePath.trim();
				fopStream = new FileOutputStream(new File(filePath));
				paths[index] = filePath;
				index++;
				iStream = fib.getFileInput();
				byte[] b = new byte[1024];
				int i = 0;
				while ((i = iStream.read(b)) > 0){
					fopStream.write(b, 0, i);
				}
				fopStream.flush();
			}
		} finally {
			if(iStream != null) {
				try {
					iStream.close();
				} catch (IOException e) {
					LOG.error(e.getMessage(),e);
				}
				iStream = null;
			}
			if (fopStream != null) {
				try {
					fopStream.close();
				} catch (IOException e) {
					LOG.error(e.getMessage(),e);
				}
				fopStream = null;
			}
		}
		return paths;
	}
	
	/**
	*<b>Summary: </b>
	* deleteFile(删除文件)
	* @param filePath
	*/
	public static void deleteFile(String filePath){
		File tempFile = new File(filePath);
		if(tempFile.exists()){
			tempFile.delete();
		}
	}
	
	/*
     * 将java.sql.Blob对象转成byte数组
     * @param blobObj
     * @return
     * @throws Exception
     */
    private static byte[] getBytesFromBlob(Blob blobObj) throws Exception {
        byte[] bContent = null;
        if(blobObj == null){
            return new byte[0];
        }
        InputStream is = blobObj.getBinaryStream();
        int bLen = (int)blobObj.length();
        bContent = new byte[bLen];
        is.read(bContent);
        is.close();
        return bContent;
    }
		public static String getAppContextPath() {
		return FileUtil.class.getResource("/").getPath().replaceAll("/WEB-INF/classes/", "");
	}

}
