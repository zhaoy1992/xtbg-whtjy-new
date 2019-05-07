package com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean;
 
 


	/**
	 *<p>Title:filetranserSystemDao.java</p>
	 *<p>Description:附件上传操作</p>
	 *<p>Copyright:Copyright (c) 2011</p>
	 *<p>Company:湖南科创</p>
	 *@author steven.zhu
	 *@version 1.0
	 *2011-07-06
	 */
	public interface FiletransfersSysDao {
		/**
		 * 保存文件基本信息
		 * @param conn 事物连接
		 * @param FileInfoBean  文件基本信息
		 * @return true/false
		 */
		public boolean saveFile(Connection conn,List<FileInfoBean>  listFileInfoBean) throws SQLException;
	
		 /**
			* del文件基本信息
			* @param fileid  文件编号
			* @return true/false
			*/
		public boolean  delFile(String fileid)  throws SQLException;
		
		/**
		 * 删除在服务器上的附件
		 * @param filepath
		 * @return
		 * @throws SQLException
		 */
		public boolean delFileOnSever(String filepath) throws SQLException;
		
		public boolean  delFileID(String fileid)  throws SQLException;
		/**
		 * 删除1g超大附件
		 * @param fileid
		 * @return
		 * @throws SQLException
		 */
		public boolean delBigFileID(String fileid) throws SQLException;
		
		public List<FileInfoBean> getFileInfoBeanlist(String fileid) throws SQLException;
		
		public PagingBean getFileInfoList(String fileid,String zjid) throws SQLException;
		
		public PagingBean getFileInfoList(String fileid,String zjid,String sortName,
				String sortOrder, long offset, int maxPagesize) throws SQLException;
		
		public String getFileCountByDjbh(String djbh) throws SQLException ;
		
		/**
		 * 获得文件基本信息
		 * @param djsn
		 * @return
		 * @throws SQLException
		 */
		public FileInfoBean getFileByDjsn(String djsn) throws Exception;
		
		/**
		 * 复制文件信息
		 * @param newDjsn
		 * @param oldDjsn
		 * @return
		 * @throws Exception
		 */
		public boolean copyFileInfo(String newDjsn ,String oldDjsn);
		
		


 
	 	}
	
	    