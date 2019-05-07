package com.chinacreator.xtbg.pub.oagwcs.dao;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;

import com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.FiletransferService;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.pub.oagwcs.service.util.GwConstant;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;


/**
 * 公文DB数据获取 --抽象类
 * @author tian.xia
 * 
 */
public abstract class GwDBDataGet {
	private static final Logger logger = Logger.getLogger(GwDBDataGet.class);
	private FiletransferService filetransferService = new FiletransferServiceImpl();
	private FiletransfersSysDao filetransfersSysDao = new FiletransfersSysDaoImpl();
	private List<FileInfoBean> documentContent = null;
	private List<FileInfoBean> attachList = null;

	/**
	 * 上传附件文件到服务器的路径中
	 * @param FilePath
	 * @param listFileInfoBean
	 * @return
	 */
	protected  String[] uploadFileToServer(String FilePath,List<FileInfoBean> listFileInfoBean){
		return filetransferService.uploadFileToServer(FilePath, listFileInfoBean);
	}
	
	/**
	 * 根据djbh将数据库中的文件复制到服务器路径中去
	 * @param FilePath
	 * @param djbh
	 * @return
	 */
	protected  String[] copyDBFileToServerByDjBh(String FilePath,String djbh){
		String[] paths = {};

		FileOutputStream fopStream = null;
		InputStream iStream = null;
		StringBuffer sql = new StringBuffer();
		sql.append("select * from fc_attach f where trim(f.djbh) = ?");
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		try
		{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, djbh);
			pdb.executePrepared();
			String filePath = "";
			paths = new String[pdb.size()];
			for(int i = 0 ; i < pdb.size() ; i++){
				filePath = (FilePath+pdb.getString(i, "filename")).trim();
				fopStream = new FileOutputStream(new File(filePath));
				paths[i] = filePath;
				iStream = pdb.getBlob(i, "attachcontent").getBinaryStream();
				byte[] b = new byte[1024];
				int j = 0;
				while ((j = iStream.read(b)) > 0) {
					fopStream.write(b, 0, j);
				}
				fopStream.flush();
				
			}

		}catch(Exception e){
			logger.error(e.getMessage(), e);
		} finally {
	
			if(iStream != null) {
				try {
					iStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				iStream = null;
			}
			if (fopStream != null) {
				try {
					fopStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				fopStream = null;
			}
		}
		return paths;
		
	}
	/**
	 * 根据fileid获取附件信息集合
	 * @param fileid
	 * @return
	 * @throws SQLException
	 */
	protected List<FileInfoBean> getFileInfoBeanlist(String fileid) throws SQLException{
		List<FileInfoBean> fileList = filetransfersSysDao.getFileInfoBeanlist(fileid);
		attachList = fileList;
		return fileList;
	}
	
	/**
	 * 根据recordId和docName 获取公文的正文内容，并封装成一个FileInfoBean的List
	 * @param recordId
	 * @param docName 不包括后缀名
	 * @return
	 */
	protected void getDocumentContent(String recordId,String docName)throws SQLException{
		List<FileInfoBean> fileList = new ArrayList<FileInfoBean>();
		PreparedDBUtil pdb =  new PreparedDBUtil();
		//教育考试院传过去的是无章的公文
		String count = DaoUtil.SqlToField("select count(*) from document_file where recordid = '"+ recordId + "'");
		if (Integer.valueOf(count) > 0) {
			
		} else {
			//教育考试院 查询不到无章的公文
			recordId = recordId.substring(0, recordId.indexOf("_ding"));
			docName = docName.substring(0, docName.indexOf("_ding"));
		}
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from document_file where recordid = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, recordId);
		pdb.executePrepared();
		for(int i = 0 ; i < pdb.size() ; i++){
			FileInfoBean fib = new FileInfoBean();
			fib.setAttachcontent(pdb.getByteArray(i, "filebody"));
			fib.setCreate_date(pdb.getString(i,"filedate"));
			fib.setCreator(pdb.getString(i,"username"));
			fib.setExtend(pdb.getString(i,"filetype"));
			fib.setFilename(docName);
			fib.setDjsn(docName);
			fib.setFileInput(pdb.getBlob(0, "filebody")
					.getBinaryStream());
			fib.setFilesize(pdb.getString(i,"filesize"));
			fileList.add(fib);
		}
		documentContent = fileList;

	}
	/**
	 * 构造公文发文的文件路径
	 */
	protected boolean buildGwSendPath(){
		File directory = new File(GwConstant.ARCHIVE_PATH);
		if(!directory.exists()){
			return directory.mkdirs();
		}
		return true;
	}
	
	/**
	 * 将发文的正文数据和相关的附件数据放置到临时文件空间，并返回所有路径的数组
	 * @param docSendFile
	 * @param djbh
	 * @return
	 */
	protected String[] getAttachAndDocSendFilePath(List<FileInfoBean> docSendFile,String djbh){
		String[] paths = StringUtils.
		concatenateStringArrays(
				uploadFileToServer(GwConstant.ARCHIVE_PATH+"/", docSendFile),
				copyDBFileToServerByDjBh(GwConstant.ARCHIVE_PATH+"/", djbh)
		);
		return paths;
	}

	protected List<FileInfoBean> getDocumentContent() {
		return documentContent;
	}

	protected void setDocumentContent(List<FileInfoBean> documentContent) {
		this.documentContent = documentContent;
	}

	protected List<FileInfoBean> getAttachList() {
		return attachList;
	}

	protected void setAttachList(List<FileInfoBean> attachList) {
		this.attachList = attachList;
	}
	
	
	
}
