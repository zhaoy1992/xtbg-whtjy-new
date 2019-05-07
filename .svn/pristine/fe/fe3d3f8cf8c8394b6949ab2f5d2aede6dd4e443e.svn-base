package com.chinacreator.xtbg.core.common.fancyuoload.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.List;

import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao;
import com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.sun.media.jai.codec.FileSeekableStream;
import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageEncoder;
import com.sun.media.jai.codec.JPEGEncodeParam;
import com.sun.media.jai.codec.TIFFEncodeParam;

/**
 *<p>Title:FiletransferServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-10
 */
public class FiletransferServiceImpl extends FiletransferService {

	public final static String upload_To_SeverPath  = OASystemCache.getContextProperty("upload_To_SeverPath");//"\\ccapp\\FcAttach\\";//TODO 配置文件设置服务器路径//CacheCommonManage.getInstance().getSystemParam("upload_To_SeverPath"); 
	//add by shixing.he in 2014-04-09 财政厅历史公文正文附件从磁盘读取
	public final static String upload_To_SeverPath_czt  = OASystemCache.getContextProperty("upload_To_SeverPath_czt");//"\\ccapp\\FcAttach\\";//TODO 配置文件设置服务器路径//CacheCommonManage.getInstance().getSystemParam("upload_To_SeverPath");
	
	private static final Log LOG = LogFactory.getLog(FiletransferServiceImpl.class);
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 saveFile
	  * @param listFileInfoBean
	  * @return 
	  * @see com.chinacreator.common.fancyuoload.service.FiletransferService#saveFile(java.util.List)
	 */
	public boolean saveFile(List<FileInfoBean> listFileInfoBean) {
		boolean sucess = false;
		Connection conn = null;
		try{
			conn = DbManager.getInstance().getTransactionConnection();
			FiletransfersSysDao sft=new FiletransfersSysDaoImpl();
			sucess =  sft.saveFile(conn, listFileInfoBean,"stream");
			conn.commit();
		}catch(Exception e){
			sucess = false;
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
		}finally{
			DbManager.closeConnection(conn);
		}
		return sucess;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 copyDBFileToServerByDjBh
	  * @param FilePath
	  * @param djbh
	  * @return 
	  * @see com.chinacreator.common.fancyuoload.service.FiletransferService#copyDBFileToServerByDjBh(java.lang.String, java.lang.String)
	 */
	public String[] copyDBFileToServerByDjBh(String FilePath,String djbh){
		String[] paths = {};

		FileOutputStream fopStream = null;
		InputStream iStream = null;
		StringBuffer sql = new StringBuffer();
		sql.append("select * from oa_fc_attach f where trim(f.djbh) = ?");
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		try{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, djbh);
			pdb.executePrepared();
			String filePath = "";
			for(int i = 0 ; i < pdb.size() ; i++){
				filePath = FilePath+pdb.getString(i, "djsn")+pdb.getString(i,"extend");
				fopStream = new FileOutputStream(new File(filePath));
				iStream = pdb.getBlob(i, "attachcontent").getBinaryStream();
				byte[] b = new byte[1024];
				int j = 0;
				while ((j = iStream.read(b)) > 0) {
					fopStream.write(b, 0, j);
				}
				fopStream.flush();
			}

			paths[paths.length] = filePath;
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
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
	  * <b>Summary: </b>
	  *     复写方法 uploadFileToServer
	  * @param FilePath
	  * @param listFileInfoBean
	  * @return 
	 * @throws Exception 
	  * @see com.chinacreator.common.fancyuoload.service.FiletransferService#uploadFileToServer(java.lang.String, java.util.List)
	 */
	public String[] uploadFileToServer(String FilePath,List<FileInfoBean> listFileInfoBean) throws Exception {
		String[] paths = new String[listFileInfoBean.size()];
		FileOutputStream fopStream = null;
		InputStream iStream = null;
		try{
			String filePath = ""; 
			int index = 0;
			for(FileInfoBean fib:listFileInfoBean){
				filePath = FilePath+fib.getDjsn()+fib.getExtend();
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
	 * 
	*<b>Summary: 上传文件到服务器</b>
	* uploadFileToServer()
	* @param descFile 写入的文件名
	* @param instream 文件流
	* @param convertToTif 是否将文件转换为tif格式  true：是, false: 否
	* @return 是否写入成功
	* @throws Exception
	 */
	public boolean uploadFileToServer(String descFile, InputStream instream,Boolean convertToTif,Boolean convertToJpg) throws Exception {
		OutputStream ros = null;
		OutputStream dos = null;
		OutputStream jos = null;
		File tmpFile = null;
		
		InputStream is = null;
		try {
			//首先建立临时文件
			String fileName = convertToTif? StringUtil.getUUID()+".tmp" : descFile;
			tmpFile = new File(fileName);
			ros = new FileOutputStream(tmpFile);
			byte[] b = new byte[1024];
			int i = 0;
			while ((i = instream.read(b)) > 0){
				ros.write(b, 0, i);
			}
			ros.write(b);			
			
			//将上传的文件转换为tif文件
			if (convertToTif){
				RenderedOp src = JAI.create("fileload", fileName);
				//更改扩展名
				descFile = descFile.substring(0,descFile.lastIndexOf("."))+".tif";
				dos = new FileOutputStream(descFile);
				TIFFEncodeParam param = new TIFFEncodeParam();
				ImageEncoder encoder = ImageCodec.createImageEncoder("TIFF",
						dos, param);
				encoder.encode(src);
			}
			
			if(convertToJpg){
				is = new FileSeekableStream(descFile);
				//RenderedOp src = JAI.create("fileload", descFile);
				//src绑定stream  代替src直接绑定file
				RenderedOp src = JAI.create("stream", is);
				String jspFile = descFile.substring(0,descFile.lastIndexOf("."))+".jpg";
				jos = new FileOutputStream(jspFile);
				JPEGEncodeParam param = new JPEGEncodeParam();
				ImageEncoder encoder = ImageCodec.createImageEncoder("JPEG",
						jos, param);
				encoder.encode(src);
				src.dispose();
			}
			return true;
		}finally{
			try {
				if (null != dos) {
					dos.flush();
					dos.close();
				}
				if (null != ros) {
					ros.flush();// 清空缓存
					ros.close();// 关闭流
				}
				if(null != jos){
					jos.flush();// 清空缓存
					jos.close();// 关闭流
				}
				if(null != is){
					is.close();
				}
			}catch(Exception ex){
				LOG.error(ex.getMessage(),ex);
			}
			if(null != tmpFile && convertToTif){
				//删除临时文件
				tmpFile.deleteOnExit();
			}
		}
	}
	
	public  String[] uploadFileToServerConvertToTif(String FilePath,List<FileInfoBean> listFileInfoBean) throws Exception{
		String[] paths = new String[listFileInfoBean.size()];
		FileOutputStream fopStream = null;
		InputStream iStream = null;
		try{
			String filePath = ""; 
			int index = 0;
			for(FileInfoBean fib:listFileInfoBean){
				filePath = FilePath+fib.getDjsn()+fib.getExtend();
				filePath =  filePath.trim();
				fopStream = new FileOutputStream(new File(filePath));				
				paths[index] = filePath;
				
				RenderedOp src = JAI.create("fileload", fopStream);
				
				
				OutputStream os = new FileOutputStream(FilePath);
				TIFFEncodeParam param = new TIFFEncodeParam();
				ImageEncoder encoder = ImageCodec.createImageEncoder("TIFF", os, param);
				encoder.encode(src);
				os.close();
				
				
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

	@Override
	public boolean uploadFileToServer(String baseURL, FileInfoBean bean)
			throws Exception {
		boolean flag = false;
		FileOutputStream fopStream = null;
		InputStream iStream = null;
		try{
			fopStream = new FileOutputStream(new File(baseURL+bean.getFilepos()));
			iStream = bean.getFileInput();
			if(iStream!=null){
				byte[] b = new byte[1024];
				int i = 0;
				while ((i = iStream.read(b)) > 0){
					fopStream.write(b, 0, i);
				}
				fopStream.flush();
				flag = true;
			}else{
				LOG.info("文件流找不到:"+bean.getDjsn());
			}
		} finally {
			if(iStream != null) {
				try {
					iStream.close();
				} catch (IOException e) {
					LOG.error(e.getMessage(),e);
				}
			}
			if (fopStream != null) {
				try {
					fopStream.close();
				} catch (IOException e) {
					LOG.error(e.getMessage(),e);
				}
			}
		}
		return flag;
	}

	
}
