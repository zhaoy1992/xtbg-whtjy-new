package com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl;

import java.io.File;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean;
import com.chinacreator.xtbg.pub.jqueryupload.utils.FileUtils;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class FiletransfersSysDaoImpl implements FiletransfersSysDao {

	public boolean saveFile(Connection conn, List<FileInfoBean> listFileInfoBean)
			throws SQLException {
		try {

			PreparedDBUtil pdb = new PreparedDBUtil();
			for (int i = 0; i < listFileInfoBean.size(); i++) {

				String sql = "insert into fc_attach(extend,djbh,filename,attachid,djsn,attachcontent,filepos,upload_mode,creator) values (?,?,?,?,?,?,?,?,?)";

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
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean delFile(String fileid) throws SQLException {

		try {

			String sql = "delete from fc_attach t where t.djsn = '"
					+ fileid.trim() + "'";
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.preparedDelete(sql);
			pdb.executePrepared();
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	public boolean delFileOnSever(String filepath) throws SQLException {
		File file = new File(filepath);
		if(file.exists()){
			file.delete();return true;
		}return false;
	}
	
	public boolean delFileID(String fileid) throws SQLException {

		try {

			String sql = "delete from fc_attach t where t.djbh = '"
					+ fileid.trim() + "'";
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.preparedDelete(sql);
			pdb.executePrepared();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	public FileInfoBean getFileByDjsn(String djsn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		FileInfoBean fib = new FileInfoBean();
		sql.append("select extend,djbh,filename,attachid,djsn,attachcontent,filepos,upload_mode from fc_attach where djsn=? ");
/*		sql.append("select t.file_id,");
		sql.append("  t.file_name,");
		sql.append("  t.file_extra,");
		sql.append("  'd:/temp/' || t.serverfile_name || '.' || t.file_extra as filepos,");
		sql.append("  t.serverfile_name");
		sql.append(" from ta_oa_fileupload t");
		sql.append(" where t.serverfile_name = '"+djsn+"'");*/
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
				fib.setFileInput(pdb.getBlob(0, "attachcontent")
						.getBinaryStream());
			}
			fib.setFilepos(pdb.getString(0, "filepos"));
			fib.setUpload_mode(pdb.getString(0, "upload_mode"));
		}
		return fib;
	}

	public String getFileCountByDjbh(String djbh) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();

		sql.append("select count(*) countNum from fc_attach t where t.djbh = '")
				.append(djbh.trim()).append("'");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		String countNum = pdb.getString(0, "countNum");
		return countNum;
	}

	public List<FileInfoBean> getFileInfoBeanlist(String fileid)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<FileInfoBean> list = new ArrayList<FileInfoBean>();

		sql.append(
				"select extend,djbh,filename,attachid,djsn,attachcontent,filepos from fc_attach t where t.djbh = '")
				.append(fileid.trim()).append("'");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			FileInfoBean fib = new FileInfoBean();
			fib.setExtend(pdb.getString(i, "extend"));
			fib.setDjbh(pdb.getString(i, "djbh"));
			fib.setFilename(pdb.getString(i, "filename").trim());
			fib.setAttachid(pdb.getString(i, "attachid"));
			fib.setDjsn(pdb.getString(i, "djsn"));
//			Blob blob = pdb.getBlob(i, "attachcontent");
//			if (blob != null) {
//				fib.setFileInput(pdb.getBlob(i, "attachcontent")
//						.getBinaryStream());
//			}
			fib.setFilepos(pdb.getString(i, "filepos"));
			list.add(fib);
		}
		return list;
	}

	@Override
	public PagingBean getFileInfoList(String buessid,String zj_id) throws SQLException {
		String sql = "";

		sql = "select attachid,filename,extend,filepos,djsn from fc_attach where djbh='"
				+ buessid + "'";
		PagingBean pg = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<FileInfoBean> list = new ArrayList<FileInfoBean>();
		String filepos = "";
		String careate = "";
		String extedn = "";
		try {
			pdb.preparedSelect(sql);
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				FileInfoBean bean = new FileInfoBean();
				bean.setAttachid(pdb.getString(i, "attachid"));
				bean.setFilename(pdb.getString(i, "filename"));
				extedn = pdb.getString(i, "extend");
				bean.setExtend(extedn);
				filepos = pdb.getString(i, "filepos");
				bean.setFilepos(filepos);
				bean.setDjsn(pdb.getString(i, "djsn"));

				if (!filepos.equals("")) {
					careate = "";
					int j = 0, k = 0;
					j = filepos.lastIndexOf(".");
					k = filepos.lastIndexOf("_");
					if (j != -1 && k != -1) {
						careate = filepos.substring(k + 1, j);
						bean.setCreate_date(FileUtils.stringToString(careate));
					}
					bean.setNewName(careate + extedn);
				}
				list.add(bean);
			}
			pg.setList(list);
			pg.setRecords((long) list.size());

		} catch (SQLException e) {

		}

		return pg;

	}
	
	public PagingBean getFileInfoList(String buessid,String zj_id,String sortName,
			String sortOrder, long offset, int maxPagesize) throws SQLException{
		String sql = "";
		if(!StringUtil.nullOrBlank(zj_id)){
			sql = "select t.file_id,t.file_name,t.file_extra,t.serverfile_name||'.'||t.file_extra as filepos,t.serverfile_name," +
					"to_char(t.creatortime,'yyyy-mm-dd hh24:mi') as creatortime  from ta_oa_fileupload t where t.attach_id='"+zj_id+"'";
		}else{
			sql = "select t.file_id,t.file_name,t.file_extra,t.serverfile_name||'.'||t.file_extra as filepos," +
					"t.serverfile_name,to_char(t.creatortime,'yyyy-mm-dd hh24:mi') as creatortime  from ta_oa_fileupload t where t.attach_id is null";
		}
		PagingBean pg = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<FileInfoBean> list = new ArrayList<FileInfoBean>();
		String filepos = "";
		String careate = "";
		String extedn = "";
		try {
			pdb.preparedSelect(sql,offset, maxPagesize);
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				FileInfoBean bean = new FileInfoBean();
				bean.setAttachid(pdb.getString(i, "file_id"));
				bean.setFilename(pdb.getString(i, "file_name"));
				extedn = pdb.getString(i, "file_extra");
				bean.setExtend(extedn);
				filepos = pdb.getString(i, "filepos");
				bean.setFilepos(filepos);
				bean.setDjsn(pdb.getString(i, "file_id"));
				bean.setCreate_date(pdb.getString(i, "creatortime"));

//				if (!filepos.equals("")) {
//					careate = "";
//					int j = 0, k = 0;
//					j = filepos.lastIndexOf(".");
//					k = filepos.lastIndexOf("_");
//					if (j != -1 && k != -1) {
//						careate = filepos.substring(k + 1, j);
//						bean.setCreate_date(FileUtils.stringToString(careate));
//					}
//					bean.setNewName(careate + extedn);
//				}
				list.add(bean);
			}
			pg.setList(list);
			pg.setRecords((long)pdb.getTotalSize());

		} catch (SQLException e) {

		}

		return pg;

	}
	
	public boolean updateFile(String djbhNew,String dhbhOld)
			throws SQLException {
		try {

			    PreparedDBUtil pdb = new PreparedDBUtil();
				String sql = "update fc_attach set djbh=? where trim(djbh)=?";
				pdb.preparedInsert(sql);
				pdb.setString(1, djbhNew);
				pdb.setString(2, dhbhOld);
				pdb.executePrepared();

			return true;
		} catch (Exception e) {

			return false;
		}
	}

	@Override
	public boolean copyFileInfo(String newDjbh , String oldDjbh ) {
		String sql1 = "delete fc_attach where djbh = '"+newDjbh+"'";
		String sql2 ="insert into fc_attach(extend,djbh,filename,attachid,djsn,attachcontent,filepos)  select extend, '"+newDjbh+"' as djbh,filename,attachid,substr(djsn,0,30)||sysdate,attachcontent,filepos from fc_attach t where t.djbh = '"+oldDjbh+"'";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedDelete(sql1);
			pdb.executePrepared();
			pdb.preparedInsert(sql2);
			pdb.executePrepared();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}

	
	public boolean delBigFileID(String fileid) throws SQLException {
		try {

			String sql = "delete from ta_oa_fileupload t where t.file_id = '"
					+ fileid.trim() + "'";
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.preparedDelete(sql);
			pdb.executePrepared();
			return true;
		} catch (Exception e) {
			return false;
		}
	}


}
