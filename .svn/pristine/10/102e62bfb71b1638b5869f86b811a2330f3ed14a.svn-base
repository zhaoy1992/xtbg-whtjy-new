package com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl;

import java.util.Map;

import com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FileCopy;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.FiletransferService;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.pub.jqueryupload.utils.FileUtils;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class FileCopyToDocumentFile extends FileCopy {

	@Override
	public boolean copyOtherToFileBean(Map<String, String> params) {
		// TODO Auto-generated method stub
		boolean issucess = false;
		String djbh = params.get("djbh");//业务id
		String recordid = params.get("recordid");//文档记录id
		String filename = params.get("filename");//文件名称
		String mFilePath = params.get("mFilePath");//服务器路径
		FiletransferService ft=new FiletransferServiceImpl();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		String uuid = FileUtils.randomUUID();
		
		try {
			/*1.delete file*/
			sql.append("delete fc_attach where djbh=? and filename=?");//首先清空原先的文档附件
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, djbh);
			pdb.setString(2, filename);
			pdb.executePrepared();
			sql.setLength(0);
			/*2.copy file to fc_attach*/
			sql.append("insert into fc_attach(attachid,djsn,djbh,filename,extend,attachcontent,filepos,creator) ");
			sql.append("select '"+ft.getAttachId()+"','"+uuid+"','"+djbh+"','"+filename+"'||f.filetype,f.filetype,f.filebody,f.filepath,f.username from document_file f where f.recordid = ?");
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, recordid);
			pdb.executePrepared();
			sql.setLength(0);
			/*3.copy file to serverFilePath*/
			ft.copyDBFileToServerByDjBh(mFilePath+FiletransferServiceImpl.upload_To_SeverPath, djbh);
			
			issucess = true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		return issucess;
	}

}
