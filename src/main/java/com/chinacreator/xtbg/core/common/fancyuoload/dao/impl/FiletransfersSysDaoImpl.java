package com.chinacreator.xtbg.core.common.fancyuoload.dao.impl;

import java.io.File;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


import com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.servlet.AttachmentConfigBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:filetranserSystemDao.java</p>
 *<p>Description:附件上传操作</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author steven.zhu
 *@version 1.0
 *2011-07-06
 */
public class FiletransfersSysDaoImpl implements FiletransfersSysDao {
	
	private static final Log LOG = LogFactory.getLog(FiletransfersSysDaoImpl.class);

	/**
	  * <b>Summary: </b>
	  *     复写方法 saveFile
	  * @param conn
	  * @param listFileInfoBean
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.common.fancyuoload.dao.FiletransfersSysDao#saveFile(java.sql.Connection, java.util.List)
	 */
	public boolean saveFile(Connection conn, List<FileInfoBean> listFileInfoBean) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		for (int i = 0; i < listFileInfoBean.size(); i++) {
			String sql = "insert into oa_fc_attach(extend,djbh,filename,attachid,djsn,attachcontent,filepos,upload_mode,creator) values (?,?,?,?,?,?,?,?,?)";
			pdb.preparedInsert(sql);
			FileInfoBean file = (FileInfoBean) listFileInfoBean.get(i);

			pdb.setString(1, file.getExtend());
			pdb.setString(2, file.getDjbh());
			pdb.setString(3, file.getFilename());
			pdb.setString(4, file.getAttachid());
			pdb.setString(5, file.getDjsn());
			pdb.setBlob(6, file.getAttachcontent());

			pdb.setString(7, file.getFilepos());
			pdb.setString(8, "1");
			pdb.setString(9, file.getCreator());

			pdb.executePrepared(conn);

		}
		return true;
	}

	
	/**
	 * 
	 *<b>Summary: </b>
	 * delFileOnSeverById(通过ID删除File)
	 * @param fileId
	 * @return
	 * @throws Exception
	 */
	public boolean delFileOnSeverById(FileInfoBean bean) throws Exception {
		boolean success = false;
		if(!StringUtil.isBlank(bean.getFilepos())){
			File file = AttachmentConfigBean.getRealFile(bean.getFilepos());
			if (file!=null&&file.exists()) {
				success = file.delete();
			}else{
				success = true;
			}
		}
		return success;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 delFileByDjsn
	  * @param conn
	  * @param djsn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.common.fancyuoload.dao.FiletransfersSysDao#delFileByDjsn(java.sql.Connection, java.lang.String)
	 */
	public boolean delFileByDjsn(Connection conn,String djsn) throws SQLException {
		String sql = "delete from oa_fc_attach t where t.djsn = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql);
		pdb.setString(1, djsn.trim());
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 delFileByDjbh
	  * @param conn
	  * @param djbh
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.common.fancyuoload.dao.FiletransfersSysDao#delFileByDjbh(java.sql.Connection, java.lang.String)
	 */
	public boolean delFileByDjbh(Connection conn,String djbh) throws SQLException{
		String sql = "delete from oa_fc_attach t where t.djbh = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql);
		pdb.setString(1, djbh.trim());
		pdb.executePrepared(conn);
		return true;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 getFileByDjsn
	  * @param djsn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.common.fancyuoload.dao.FiletransfersSysDao#getFileByDjsn(java.lang.String)
	 */
	public FileInfoBean getFileByDjsn(String djsn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		FileInfoBean fib = new FileInfoBean();
		sql.append("select extend,djbh,filename,attachid,djsn,attachcontent,filepos,upload_mode from oa_fc_attach where djsn=? ");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, djsn);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			fib.setExtend(pdb.getString(0, "extend"));
			fib.setDjbh(pdb.getString(0, "djbh"));
			fib.setFilename(pdb.getString(0, "filename"));
			fib.setAttachid(pdb.getString(0, "attachid"));
			fib.setDjsn(pdb.getString(0, "djsn"));
			Blob blob = pdb.getBlob(0, "attachcontent");
			if (blob != null) {
				fib.setFileInput(pdb.getBlob(0, "attachcontent").getBinaryStream());
			}
			fib.setFilepos(pdb.getString(0, "filepos"));
			fib.setUpload_mode(pdb.getString(0, "upload_mode"));
		}
		return fib;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 getFileCountByDjbh
	  * @param djbh
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.common.fancyuoload.dao.FiletransfersSysDao#getFileCountByDjbh(java.lang.String)
	 */
	public String getFileCountByDjbh(String djbh) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) countNum from oa_fc_attach t where t.djbh = ? ");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, djbh.trim());
		pdb.executePrepared();
		String countNum = pdb.getString(0, "countNum");
		return countNum;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFileInfoBeanlist
	  * @param djbh
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.common.fancyuoload.dao.FiletransfersSysDao#getFileInfoBeanlist(java.lang.String)
	 */
	public List<FileInfoBean> getFileInfoBeanlist(String djbh)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<FileInfoBean> list = new ArrayList<FileInfoBean>();

		sql.append("select extend,djbh,filename,attachid,djsn,attachcontent,filepos from oa_fc_attach t where t.djbh = ? order by t.dj_sn");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, djbh);
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			FileInfoBean fib = new FileInfoBean();
			fib.setExtend(pdb.getString(i, "extend"));
			fib.setDjbh(pdb.getString(i, "djbh"));
			fib.setFilename(pdb.getString(i, "filename").trim());
			fib.setAttachid(pdb.getString(i, "attachid"));
			fib.setDjsn(pdb.getString(i, "djsn"));
			/*Blob blob = pdb.getBlob(i, "attachcontent");
			if (blob != null) {
				fib.setFileInput(pdb.getBlob(i, "attachcontent").getBinaryStream());
			}*/
			fib.setFilepos(pdb.getString(i, "filepos"));
			list.add(fib);
		}
		return list;
	}

	
	public boolean updateFile(String djbhNew,String dhbhOld)
			throws SQLException {
		try {

			    PreparedDBUtil pdb = new PreparedDBUtil();
				String sql = "update oa_fc_attach set djbh=? where trim(djbh)=?";
				pdb.preparedInsert(sql);
				pdb.setString(1, djbhNew);
				pdb.setString(2, dhbhOld);
				pdb.executePrepared();

			return true;
		} catch (Exception e) {

			return false;
		}
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 copyFileInfo
	  * @param newDjbh
	  * @param oldDjbh
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.common.fancyuoload.dao.FiletransfersSysDao#copyFileInfo(java.lang.String, java.lang.String)
	 */
	@Override
	public boolean copyFileInfo(String newDjbh , String oldDjbh )throws SQLException {
		//TODO 既然是文件复制,为什么要将原来的文件删除
		String sql1 = "delete oa_fc_attach where djbh = '"+newDjbh+"'";
		String sql2 ="insert into oa_fc_attach(extend,djbh,filename,attachid,djsn,attachcontent,filepos)  select extend, '"+newDjbh+"' as djbh,filename,attachid,substr(djsn,0,30)||sysdate,attachcontent,filepos from fc_attach t where t.djbh = '"+oldDjbh+"'";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql1);
		pdb.executePrepared();
		pdb.preparedInsert(sql2);
		pdb.executePrepared();
		return true;
	}

	/**
	 * 
	 *<b>Summary: </b>
	 * saveFile(保存文件基本信息到数据库中,copy saveFile方法)
	 * @param conn
	 * @param listFileInfoBean
	 * @param type type:"stream":附件内容放在inputstream中
	 * @return
	 * @throws SQLException
	 */
	@Override
	public boolean saveFile(Connection conn,
			List<FileInfoBean> listFileInfoBean, String type)
			throws SQLException {
		if("stream".equals(type)){
			PreparedDBUtil pdb = new PreparedDBUtil();
			String sql = "insert into oa_fc_attach(extend,djbh,filename,attachid,djsn,attachcontent,filepos,upload_mode,creator) values (?,?,?,?,?,?,?,?,?)";
			int size = 0;
			for (FileInfoBean file : listFileInfoBean) {
				pdb.preparedInsert(sql);
				pdb.setString(1, file.getExtend());
				pdb.setString(2, file.getDjbh());
				pdb.setString(3, file.getFilename());
				pdb.setString(4, file.getAttachid());
				pdb.setString(5, file.getDjsn());
				if(AttachmentConfigBean.UPLOAD_MODE_DB.equals(file.getUpload_mode())
						||AttachmentConfigBean.UPLOAD_MODE_DB_AND_COMPUTER.equals(file.getUpload_mode())){
					try{
						size = file.getFileInput().available();
					}catch(Exception e){
						LOG.error("文件大小错误:"+e.getMessage(),e);
						continue;
					}
					pdb.setBinaryStream(6, file.getFileInput(),size);
				}else{
					pdb.setString(6, null);
				}
				
				pdb.setString(7, file.getFilepos());
				pdb.setString(8, file.getUpload_mode());
				pdb.setString(9, file.getCreator());
				pdb.executePrepared(conn);
			}
			return true;
		}else{
			return this.saveFile(conn, listFileInfoBean);
		}
	}


	@Override
	public boolean del(String djbh, String djsn,Connection conn) throws SQLException {
		String sql = "delete from oa_fc_attach t where t.djbh = ? and t.djsn <> ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql);
		pdb.setString(1, djbh.trim());
		pdb.setString(2, djsn.trim());
		pdb.executePrepared(conn);
		return true;
	}


	@Override
	public List<FileInfoBean> getFileInfoBeanlist(String djbh, String djsn)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<FileInfoBean> list = new ArrayList<FileInfoBean>();

		sql.append("select extend,djbh,filename,attachid,djsn,attachcontent,filepos from oa_fc_attach t where t.djbh = ? and t.djsn <> ? order by t.dj_sn");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, djbh);
		pdb.setString(2, djsn);
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			FileInfoBean fib = new FileInfoBean();
			fib.setExtend(pdb.getString(i, "extend"));
			fib.setDjbh(pdb.getString(i, "djbh"));
			fib.setFilename(pdb.getString(i, "filename").trim());
			fib.setAttachid(pdb.getString(i, "attachid"));
			fib.setDjsn(pdb.getString(i, "djsn"));
			/*Blob blob = pdb.getBlob(i, "attachcontent");
			if (blob != null) {
				fib.setFileInput(pdb.getBlob(i, "attachcontent").getBinaryStream());
			}*/
			fib.setFilepos(pdb.getString(i, "filepos"));
			list.add(fib);
		}
		return list;
	}


	@Override
	public FileInfoBean getFileByDjsn2(String djsn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		FileInfoBean fib = new FileInfoBean();
		sql.append("select extend,djbh,filename,attachid,djsn,attachcontent,filepos,upload_mode from fc_attach where djsn=? ");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, djsn);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			fib.setExtend(pdb.getString(0, "extend"));
			fib.setDjbh(pdb.getString(0, "djbh"));
			fib.setFilename(pdb.getString(0, "filename"));
			fib.setAttachid(pdb.getString(0, "attachid"));
			fib.setDjsn(pdb.getString(0, "djsn"));
			Blob blob = pdb.getBlob(0, "attachcontent");
			if (blob != null) {
				fib.setFileInput(pdb.getBlob(0, "attachcontent").getBinaryStream());
			}
			fib.setFilepos(pdb.getString(0, "filepos"));
			fib.setUpload_mode(pdb.getString(0, "upload_mode"));
		}
		return fib;
	}


}
